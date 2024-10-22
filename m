Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A753136345
	for <git@vger.kernel.org>; Tue, 22 Oct 2024 16:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729615011; cv=none; b=WwzRUcT2UcG56zkk0+dffugbD89hTufjtFtK9qYDmpTdSromrijrhCwsMXKAB8D4XutqsjRP/31av9aU7ktNZe3uU2AGr2axph9N2wl7/Oyd2nzaFkkMH1rnrKkZOgm9mX/q7UHocufgRccVkxLMU7weGaeZ9W3zFBUP/vKEOwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729615011; c=relaxed/simple;
	bh=fDA7ZVtBlzCSLIgGiVZwnoo7UCQT28VbLEcHxupsAkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vx0a+wdURFOQNvehOf1S/x9KWSydTzMP4KJGU9GJ0Y305q0kOJ5FWbUgOqt/wA12LL7t2bE/hfycWR/QHlAfNHDYqXqLT/wfaEka0r5pC41avFHUAjH+VKccUbAqDuXDj8Iu75BP+G7JboHRKdwiQLONiPTpNGYH977pq2U+16s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=K5zj5FHH; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="K5zj5FHH"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e28fa2807eeso5459217276.1
        for <git@vger.kernel.org>; Tue, 22 Oct 2024 09:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729615008; x=1730219808; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PJiJNo4cGgESpI+3ombar8HIqeZgJsVBeEYbEdZP168=;
        b=K5zj5FHHb/gy8bZC/2dBQRgdojdt4nqFuOudEU87ecKv5bKa7D+GVkYmvHiSsmcU39
         j+L43TFQ5z4f8uBdP+TWWIQwdW7rtkS0AdD/NQuf3mbduOUyn3DOi+NT7EPdIpA87RzQ
         U0txi7hvhOHxRnrvqAeOZRmEaAnsLxsEQQmRi13Dm5tWgv42cVk6t2JfeEV+7r7dP8KK
         9rKKQIWvfeTgGqN1z69Zjm/7sFmDdDVDyUHKr8tdXnqx+yo+/qNPlFC+xan/sg2TUeLU
         UWfNj8qLQ5Gk0PiDNBzEiBrOBYbMKvjHrYJVDxMNkRiP9Vx/TrFNyu30o00Zm2CG5nnO
         W8gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729615008; x=1730219808;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PJiJNo4cGgESpI+3ombar8HIqeZgJsVBeEYbEdZP168=;
        b=fqVTEUJlFUPaYhju4Q6cMN5H92RyBBSvjwNtg9eyEbhgG+pXH1xYPh/fkWKHFl2aM8
         F00MWM1D7eO/euqeoWsrIkxlXw6v9ywwZ8jvqrYPBwag+3ViSfHwi62JP2K7/u7etJVN
         rEzRnKkszGFjB36C0sErb1mu453uY3g9R8iFQ9ykU0zTdbwxwOe1FJ9ByAwAL0VPSSdJ
         JzYTQZghBElrekl7/TbyZd7XQTk6Ti6IYKCOLUX+udbSanWDBa/RV1A/LDEPLwjOC4Bf
         ALIBHzQj2/WUzcHIh+rF0GhN6Xq8SCbKHzITbFV4hLKqo8MVWCrCHLgMBmx6f0Ww3zvY
         gMeA==
X-Gm-Message-State: AOJu0YzbGXAooDD/cHP6nXdfjL94VT+poIt+mnfXsKV+oY0+7anDe1/M
	iWyqq0S8RobFrVd2sBmc2UGITlevqZJVOiBVmnIUC1xuNhPXEV9cPAgJCzhKJf9i57lGqgEh19x
	jp/njqw==
X-Google-Smtp-Source: AGHT+IHps+MBiQN2s4A2ESCGz6aChazdMivixvIWiduq0gbAq94GZKRUMLuJ0S4EvAsxvVbNm8CmMg==
X-Received: by 2002:a05:6902:1005:b0:e2b:cfb7:b0f0 with SMTP id 3f1490d57ef6-e2e271a21a3mr3399818276.29.1729615008324;
        Tue, 22 Oct 2024 09:36:48 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e2bdcb0356dsm1115395276.62.2024.10.22.09.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 09:36:47 -0700 (PDT)
Date: Tue, 22 Oct 2024 12:36:46 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Andrew Kreimer <algonell@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] t1016: clean up style
Message-ID: <ZxfUngQKdGZq2dWf@nand.local>
References: <20241022110730.7655-1-algonell@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241022110730.7655-1-algonell@gmail.com>

On Tue, Oct 22, 2024 at 02:07:30PM +0300, Andrew Kreimer wrote:
> Use `test_config`.
>
> Remove whitespace after redirect operator.
>
> Reported-by: Taylor Blau <me@ttaylorr.com>
> Signed-off-by: Andrew Kreimer <algonell@gmail.com>
> ---
> v1:
>   - https://lore.kernel.org/all/20241020121729.27032-1-algonell@gmail.com/
>
> v2:
>   - Base on "ak/typofix":
>     - https://lore.kernel.org/all/20241017112835.10100-1-algonell@gmail.com/
>   - Tested:
>     - ubuntu-latest, GitHub Actions.

Thanks. In the future, it's preferred to send subsequent rounds in a
reply to the initial round so that the discussion all happens in the
same thread.

Regardless, thank you for this patch, I've queued it. It looks good to
me, but perhaps others could chime in before we start merging this one
down.

>  t/t1016-compatObjectFormat.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t1016-compatObjectFormat.sh b/t/t1016-compatObjectFormat.sh
> index 92024fe51d..8341a2fe83 100755
> --- a/t/t1016-compatObjectFormat.sh
> +++ b/t/t1016-compatObjectFormat.sh
> @@ -116,8 +116,8 @@ do
>  		git config core.repositoryformatversion 1 &&
>  		git config extensions.objectformat $hash &&
>  		git config extensions.compatobjectformat $(compat_hash $hash) &&
> -		git config gpg.program $TEST_DIRECTORY/t1016/gpg &&
> -		echo "Hello World!" > hello &&
> +		test_config gpg.program $TEST_DIRECTORY/t1016/gpg &&
> +		echo "Hello World!" >hello &&
>  		eval hello_${hash}_oid=$(git hash-object hello) &&
>  		git update-index --add hello &&
>  		git commit -m "Initial commit" &&
> --
> 2.39.5
>
Thanks,
Taylor
