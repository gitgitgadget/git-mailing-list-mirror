Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1DC605BA
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 22:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723761027; cv=none; b=MhXj+eBzR95jcW108ybt14kqNyfJW2hvwVVowD5Yf3EEZsdFLr9hcXReAPPqy5Fpjy1ouDIqu61G8w2r5HGcYjjoM4ai1V9pl96JWW9P7lzeArmgaBAVOEoXEHpe0/GgICyoe7lpBjHJ3r10MqmffnBXUPYuXZV05WfbpZZd650=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723761027; c=relaxed/simple;
	bh=RdhpC6q0+7yi9bpQW/CfSzM3XsSPOyhSR0QEVoQGK6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cyyXuPl8nq8zpjvixxOxZF+1Qjm4L5F//r50efzDPE1uCcJJcEg4270e/ZfzqX0+FTB6AqLcmTc/seQibjXoI+NgTyOHLW/CdomYDM/GoDAUgMHq6/lxjmLPnWCFbmtz/SXpfgL7UDNH6+Psm04tv4O12kgNz3XVA0ybxmQuljk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JBDSvoba; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBDSvoba"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5d8060662a1so873795eaf.2
        for <git@vger.kernel.org>; Thu, 15 Aug 2024 15:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723761025; x=1724365825; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ElN6G46CiIToR5lzlf82/PODOVjbxuqZKRKusN6WBD0=;
        b=JBDSvobaTFATB68hLbsHwSNi5/v4y5EZC08C+o+KJFNJrFSoOBMpT9EmwwiZv5Zyud
         wqg6BQjNS0ZP4vpLeviGiZh9FoqiFiqdyTefIKd4eQVbj8Kf8Q6DiWi4k+gZgbLXpWCz
         h4ymjGEKIlS3DP32XfVkKbC1vyonrPtcai8rd3ULvI5reqnuwCEm3uA8Wb9jvTwnTr8n
         +2lFGbDFg6eYGDV0/GjUOOWCZ2qNJs7rll5eT3nr+rHiAQoz0OBZb3hF+Iwq36JH++zB
         XBwnJnq1mmCpXUFASRhnTWWjlGahR5dbVq03YA3q2V+TnnoVYB0qCijcaA68mBrVhonj
         fPRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723761025; x=1724365825;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ElN6G46CiIToR5lzlf82/PODOVjbxuqZKRKusN6WBD0=;
        b=OFfPZru8DLBn3DgE9lApe83jGRSnpaV1d/74OubcirIKnexVQ+U0zq9c0AibPNHR2a
         8hkTZ0qqrBuGOuxzzuSkzwvd+6jQ2yH1MEudiPreItZLRsYFEiWWiypTFn83+OhFj3kb
         JscEA7OHTyiELXrQY99A8ELzV8PL32hWZoiV/htmTcRNqNJVwRbvK9oLE0v567izFNWs
         n0JewDyq8S30tL/KVbc3wnovWJnF0K7m2YpXay/s49zmsnzJmkGIpNemzfY6lwChlOiI
         OBm7MuBO/bSBMXVxwO1wX5x/gpqpGBpRLUwZFwZQpvTvFICwsF/SGYbAFw23d27+aWW6
         jAmg==
X-Gm-Message-State: AOJu0YyqRs3W35vhynvpNU4L1i+TDU5/YV50jZd5PjfJjkcvK+Tifxb8
	nUk804g5IpX2JZipVWmfIU4vPQ81OVaY7WmAeyWgex09cP9uYNSL
X-Google-Smtp-Source: AGHT+IH256QDhZsKa9YxFhFJdhIZpjGjYFxQc3/ERhzPq8+Eaqemx3gBKwJQVo75RDOAW9O4QjFeig==
X-Received: by 2002:a05:6820:2295:b0:5c4:144b:1ff9 with SMTP id 006d021491bc7-5da9800d2f2mr1640539eaf.5.1723761025070;
        Thu, 15 Aug 2024 15:30:25 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5da8cfc4eeesm455463eaf.39.2024.08.15.15.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 15:30:24 -0700 (PDT)
Date: Thu, 15 Aug 2024 17:29:36 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH 5/5] setup: make ref storage format configurable via
 config
Message-ID: <c7ssb2tvukrbtftm2ifvz4aobp7hlunfkh3x25x4wysisvih62@utweuhfbcvjd>
References: <cover.1723708417.git.ps@pks.im>
 <a0417b7d1a8e96f71399117f3f7333c5a2920dce.1723708417.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0417b7d1a8e96f71399117f3f7333c5a2920dce.1723708417.git.ps@pks.im>

On 24/08/15 10:00AM, Patrick Steinhardt wrote:
> Similar as the preceding commit, introduce a new "init.defaultRefFormat"

s/as/to/

> config that allows the user to globally set the ref storage format used
> by newly created repositories.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  Documentation/config/init.txt |  5 ++++
>  setup.c                       | 14 +++++++++++
>  t/t0001-init.sh               | 44 +++++++++++++++++++++++++++++++++++
>  3 files changed, 63 insertions(+)
> 
> diff --git a/Documentation/config/init.txt b/Documentation/config/init.txt
> index d6f8b6e61b..9be97bcac8 100644
> --- a/Documentation/config/init.txt
> +++ b/Documentation/config/init.txt
> @@ -13,3 +13,8 @@ endif::[]
>  	`--object-format=` in linkgit:git-init[1]. Both the command line option
>  	and the `GIT_DEFAULT_HASH` environment variable take precedence over
>  	this config.
> +`init.defaultRefFormat`::
> +	Allows overriding the default object format for new repositories. See

I think you meant to say "default reference format" here. :)

> +	`--ref-format=` in linkgit:git-init[1]. Both the command line option
> +	and the `GIT_DEFAULT_REF_FORMAT` environment variable take precedence
> +	over this config.
[snip]

The remainder of this patch extends from the previous patch to add
support for a configurable default reference format set in a Git config.
Nicely done and looks good to me.

-Justin
