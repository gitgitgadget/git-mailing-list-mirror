Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35BD75809
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 20:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729715467; cv=none; b=lW1cWOfpfFqpQBZJ9UzHMcLuL73TK+4icugp+s3lzIOHC/urCNMNoAXu21vVTT3N72frYVNipg1QBXeSrM/aoNf41D+jtE6mSYkB7FKU69FHLefUiNAQrfLS9Eev6vt+j+AossiG9s/drfDjJQaY+gS8kGm6761jYEU3pw68kB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729715467; c=relaxed/simple;
	bh=Pa877IHlUtYRtXljEmaj+hSdV6FrxaJULOMcM2rUH3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G87yTdLeTJdGWb1hI1MnTQinVG18etuSqAZbs2p7yei14n8oWVsvkdHit2DAgJSeTVZjcD+j/aOagW0/LwgpETyze9wpk1ITiJQ8N8lZVo9Dw5Goi8HBBq0T9EBSQdECeEIi1d5BO39pR3C2+5RMxG5CHxXSXxuANgSHmhi4dac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=LdaSlxDS; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="LdaSlxDS"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6e390d9ad1dso1408507b3.3
        for <git@vger.kernel.org>; Wed, 23 Oct 2024 13:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729715465; x=1730320265; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Eg7IB0c8T9R4zReK3U6gvfN+EUhjMSFZpLk4pY+T9GI=;
        b=LdaSlxDSp8qND/mdPSS0XYWgXUZO9NLQ/3n6+zI0txuS08rrHUnKDAFHfipUMVmoqb
         R8MQ57mVpZLpM67QKK0zV/FrGIkHx7V32EjOKFXDzaAiNtG4bWHP1OZ5oTP6KIeI4aA0
         tbRBjZ3rwEA1p8WEQFiOkM1DrYNFcLqUJIFALxZVdlvtq83zxhYP0b8cwJ4hasvsfl4/
         eEHJAzsp3sVq9LrRCnHLBpnMn3qYDuWSCdBG4iT06Nd1/ebQNJWtgQzNvy/cqyFRRwMr
         PbqtaMNsWCih+jfJ/yNX3skP0njQS5eHHhJqgKAGMLKydY0VRzIK1epQsnjHXjz1GIAt
         8NyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729715465; x=1730320265;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eg7IB0c8T9R4zReK3U6gvfN+EUhjMSFZpLk4pY+T9GI=;
        b=g8UfX096aiO18PaeC1Qq9qErEL9IItkGa/r9bDabTQ4TpCJa6QVi0oZ6eA8l8cv2dl
         2cuzn+WyD4NIjOnBfllzmAWHaC1hzMA/RF2NjESJesJlj+edEBLE1raRAvca5ZrKr18S
         Jx8odONDWR+umZWtygW43JGg+fPbGAUu1w8x3AVKA7aY+PUW/eLJhTgFZbtUNOeoh14h
         UjwbLSIwrFT/C0wHVr6rWvjpUfGoHr3iPjNIKwGz4Y0zKbHIqiUoLS9VQsxjN7Kk5HNb
         gj632RamStx3QeJrUfN3zjq62h4iSfN0Y1xpk47paukQ+DBq6pzVFBOlsfC+/BK9E0O3
         4GLw==
X-Gm-Message-State: AOJu0YwGqXeO2zuVopSXMwliTOQOwoVOEwT98VzkKAUfb+dJzFS/ZqzW
	EcDSJuv4/VXaFrhcGiD3URzfM4HESiSli41ivz2ze6jArv5BhlHzNGzF0uXiJew=
X-Google-Smtp-Source: AGHT+IGX+1r4su4D2Y4QbTpz4c6y0MTnE4215DkBc/2TI/mChipTZGh8JQOycKyanxVASoeby7ksXg==
X-Received: by 2002:a05:690c:d94:b0:6e3:3716:2d42 with SMTP id 00721157ae682-6e7f0daaa5amr38605507b3.6.1729715464849;
        Wed, 23 Oct 2024 13:31:04 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5ccb435sm16826537b3.91.2024.10.23.13.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 13:31:04 -0700 (PDT)
Date: Wed, 23 Oct 2024 16:31:03 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Usman Akinyemi <usmanakinyemi202@gmail.com>
Subject: Re: [PATCH v5 1/3] daemon: replace atoi() with strtoul_ui() and
 strtol_i()
Message-ID: <ZxldBxx2R+fqVQZK@nand.local>
References: <pull.1810.v4.git.git.1729634937.gitgitgadget@gmail.com>
 <pull.1810.v5.git.git.1729669220.gitgitgadget@gmail.com>
 <d9c997d7a9c8975ce845aa0cb4deaba22cbf3b94.1729669221.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d9c997d7a9c8975ce845aa0cb4deaba22cbf3b94.1729669221.git.gitgitgadget@gmail.com>

On Wed, Oct 23, 2024 at 07:40:18AM +0000, Usman Akinyemi via GitGitGadget wrote:
> From: Usman Akinyemi <usmanakinyemi202@gmail.com>
>
> Replace atoi() with strtoul_ui() for --timeout and --init-timeout
> (non-negative integers) and with strtol_i() for --max-connections
> (signed integers). This improves error handling and input validation
> by detecting invalid values and providing clear error messages.
> Update tests to ensure these arguments are properly validated.
>
> Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
> ---
>  daemon.c              | 12 ++++++++----
>  t/t5570-git-daemon.sh | 26 ++++++++++++++++++++++++++
>  2 files changed, 34 insertions(+), 4 deletions(-)
>
> diff --git a/daemon.c b/daemon.c
> index cb946e3c95f..a40e435c637 100644
> --- a/daemon.c
> +++ b/daemon.c
> @@ -4,6 +4,7 @@
>  #include "abspath.h"
>  #include "config.h"
>  #include "environment.h"
> +#include "gettext.h"
>  #include "path.h"
>  #include "pkt-line.h"
>  #include "protocol.h"
> @@ -1308,17 +1309,20 @@ int cmd_main(int argc, const char **argv)
>  			continue;
>  		}
>  		if (skip_prefix(arg, "--timeout=", &v)) {
> -			timeout = atoi(v);
> +			if (strtoul_ui(v, 10, &timeout))
> +				die(_("invalid timeout '%s', expecting a non-negative integer"), v);
>  			continue;
>  		}
>  		if (skip_prefix(arg, "--init-timeout=", &v)) {
> -			init_timeout = atoi(v);
> +			if (strtoul_ui(v, 10, &init_timeout))
> +				die(_("invalid init-timeout '%s', expecting a non-negative integer"), v);
>  			continue;
>  		}
>  		if (skip_prefix(arg, "--max-connections=", &v)) {
> -			max_connections = atoi(v);
> +			if (strtol_i(v, 10, &max_connections))
> +				die(_("invalid max-connections '%s', expecting an integer"), v);
>  			if (max_connections < 0)
> -				max_connections = 0;	        /* unlimited */
> +				max_connections = 0;  /* unlimited */
>  			continue;
>  		}
>  		if (!strcmp(arg, "--strict-paths")) {
> diff --git a/t/t5570-git-daemon.sh b/t/t5570-git-daemon.sh
> index c5f08b67996..722ddb8b7fa 100755
> --- a/t/t5570-git-daemon.sh
> +++ b/t/t5570-git-daemon.sh
> @@ -8,6 +8,32 @@ TEST_PASSES_SANITIZE_LEAK=true
>  . ./test-lib.sh
>
>  . "$TEST_DIRECTORY"/lib-git-daemon.sh
> +
> +test_expect_success 'daemon rejects invalid --init-timeout values' '
> +	for arg in "3a" "-3"
> +	do
> +		test_must_fail git daemon --init-timeout="$arg" 2>actual_error &&
> +		test_write_lines "fatal: invalid init-timeout ${SQ}$arg${SQ}, expecting a non-negative integer" >expected &&

Hmmph. test_write_lines is typically called like

    test_write_lines 1 2 3

to write a file which contains three lines where each of the arguments
appears on its own line.

But here you pass a single argument, which causes us to write out a
single line. Is there a reason for this? If not, I would expect us to
write:

    echo "fatal: invalid init-timeout ${SQ}$arg${SQ}, expecting a non-negative integer" >expect

Or, perhaps even cleaner would be to do:

    test_must_fail git daemon --init-timeout="$arg" 2>err &&
    test_grep "invalid init-timeout ${SQ}$arg${SQ}" err

since I don't think asserting on the actual error contents matching
verbatim what we expect is adding all that much.

(Also throughout you write 2>actual_err, but redirecting 2>err is more
concise and in convention with the rest of the test suite's style).

> +		test_cmp actual_error expected || return 1
> +	done
> +'
> +
> +test_expect_success 'daemon rejects invalid --timeout values' '
> +	for arg in "3a" "-3"
> +	do
> +		test_must_fail git daemon --timeout="$arg" 2>actual_error &&
> +		test_write_lines "fatal: invalid timeout ${SQ}$arg${SQ}, expecting a non-negative integer" >expected &&
> +		test_cmp actual_error expected || return 1
> +	done
> +'
> +
> +test_expect_success 'daemon rejects invalid --max-connections values' '
> +	arg='3a' &&
> +	test_must_fail git daemon --max-connections=3a 2>actual_error &&
> +	test_write_lines "fatal: invalid max-connections ${SQ}$arg${SQ}, expecting an integer" >expected &&
> +	test_cmp actual_error expected
> +'
> +

Same notes from above in these two as well.

Thanks,
Taylor
