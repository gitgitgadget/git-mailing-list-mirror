Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F58F22F77E
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 19:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752003867; cv=none; b=n9KgnEVJrkKwbfp4nMwefQyaJSxwm8eFgPiACENLa6tBUiWgUIe94pRCHeqGzNiOa8fMXRF29tciI8aI4YjFZZSnWs7Um0JUmfkK402WNk4ZEbseV1h0GVLICG15sMvEauXro5GuIAazWxYkrLbmHis6v43I87AKYxCFXjKApBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752003867; c=relaxed/simple;
	bh=CsjEDmn2vg3TTx+LJfGbZEC4sfQ9orHZYzxnY6nZQuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UZh8UfhxIR58JhcYHfQvTeZAq42Yc5smJQTqffubn2c7lyirzfgZSP9RZ92TPwVb08rhhJLwFzFnnkGBS+UuwnlaCkeabuXyCOVX4A3ZkfiL2QnSfVkjgHFrfMl5d+iTyE2uvs4J568L+T4A8Kr/Sg6oZT3eTIaeiuwVYRKoLE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LKiNouRR; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKiNouRR"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-40abe6f8f08so3931080b6e.0
        for <git@vger.kernel.org>; Tue, 08 Jul 2025 12:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752003865; x=1752608665; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yHkPPo6W85BdOAzeNL1hPuC2sV2qcsN2ySTRxpI1Obw=;
        b=LKiNouRREajrOP/KviL3bfSbHjV7e4DhfRA2qBI6wDbnRpSdFgaGLGXe3RHhaCg7NZ
         AUxg2QUXYq+lDp1YbUaIFmNaHK0SJAru2Rg4QzN97SvjKIGs3/sikGXdRyoVAcSPX3b1
         qM0jTmwPxAThf54UEGw7xlPCSekCu7yhgwq/s3wnJB692lHj/ByvQCzSxPx3jvKXTySU
         eDS7ExWUdcpmOVM0d0/AC2dL6EAm3eDbJ4Lq3Px1BjmThXYIKkerK+2YKugKYam8tyJ7
         dz3bUHjnZjn8fkZKhoIEQRVuOqmeALJuZKR7Z44tOXggCGfQf6mbhjZ0MPJC0H00vKXC
         xkRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752003865; x=1752608665;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yHkPPo6W85BdOAzeNL1hPuC2sV2qcsN2ySTRxpI1Obw=;
        b=Z2IVnsNvz3a7/b4tsD3kilbuo5Gm6v8iUTsjsrBb3O5EDMRhU5y0Q8j8Tkkodv9A19
         C9RJV3evU8sFKB+hNfFT0EAPiSIf2h0eT2x3bwa2aZzkScEtp8YvDybNTJVLg353hh6S
         96xJ6ykJJLMlTpTCV7RPHfuaYoiSMDsWYcxDFXas8Lf8RfOXYQ7Gc3gbLdSh04yMxF6r
         /tVKOfLH3LbnO1m9SJpTPKcSZSDjfL3YXjd+WuCfGheK4gG+kLdlsMJTnHh0BFQ6lF5U
         NttQy0v3Uy0/oxWkhf/6Hia/unPAJz/ZqG6NF1RugQXNziuB9brMwTnfymvV43IRM97X
         3z0A==
X-Gm-Message-State: AOJu0YzAsMwXEH+KrspQe7P6dfFy0d4N9fR08Bj+JMnA+zxTC2AemgPq
	YFkRrWmVhb19mmdzHFfi9suXeljod9zHu4ji+gDzz8mgO5bYUBZbavdk
X-Gm-Gg: ASbGncsGAjsxdFNzVwTkS83CUN1nV8XOYlvywHqyuu6KLPqtx+K244VaIr/1RdaCR+Q
	1TqdWBAXuy17d+60jg87lwzIuvAUf4XjsZcNhzI8oH4m3BuCeRoclu2s4opCCAJQUsRH5TFbwfX
	Xv6zhObt8IF41Ybx6kcXWiE85qfSp2OtNm9VfnFP6Axn88gduargY+9EPqg4AwKUfrwep6/VF2/
	PMsie5zBX6l3bpepxFN1KzK1xiYwqnNoL6iXyt7ddUy7n9seUMe5n9tsWLZKf1Ti1UPDHa3ivme
	SZYquK8hX0AJ6vGS+7cLYBIm2hQbITiBxuSncCq7+7007WMkNmseWnrvu5pFzNJM7g==
X-Google-Smtp-Source: AGHT+IHqEmOV6upYGY9LK83Ujrei0gF29BI1q96a+46cuLcmdgUCpoDe2G7Laadq16GeJFK4oS9E6A==
X-Received: by 2002:a05:6808:11cf:b0:40a:52f5:f2ad with SMTP id 5614622812f47-40d072772b0mr14095128b6e.8.1752003865119;
        Tue, 08 Jul 2025 12:44:25 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-40d02a31ce1sm1722931b6e.4.2025.07.08.12.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 12:44:24 -0700 (PDT)
Date: Tue, 8 Jul 2025 14:38:49 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>, 
	irecca.kun@gmail.com, Eli Schwartz <eschwartz@gentoo.org>
Subject: Re: [PATCH 1/8] meson: stop discovering native version of Python
Message-ID: <4ql5wzqvcoxrcbi6cznavtnfzwmh72tevixwgotvsx4kzkbljv@a55yhjqqqnym>
References: <20250703-b4-pks-meson-cleanups-v1-0-2804c2932abe@pks.im>
 <20250703-b4-pks-meson-cleanups-v1-1-2804c2932abe@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703-b4-pks-meson-cleanups-v1-1-2804c2932abe@pks.im>

On 25/07/03 11:28AM, Patrick Steinhardt wrote:
> When Python features are enabled we search both for a native and
> non-native version of Python. This is wrong though: we don't use Python
> in our build process, so there is no need to search for it in the first
> place.
> 
> There is one location where we use the native version of Python, namely
> when deciding whether or not we want to wire up git-p4(1). This check is
> invalid though, as we shouldn't check for the build host to have Python,
> but for the target host.

Ok, we are using the native python version, but we should really care
wether the target host has python.

> Fix this invalid check to use the non-native version of Python and stop
> searching for a native version of Python altogether.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  meson.build | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index 7fea4a34d68..21fdff0f496 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -866,9 +866,8 @@ if host_machine.system() == 'cygwin' or host_machine.system() == 'windows'
>  endif
>  build_options_config.set_quoted('X', executable_suffix)
>  
> -python = import('python').find_installation('python3', required: get_option('python'))
> -target_python = find_program('python3', native: false, required: python.found())
> -if python.found()
> +target_python = find_program('python3', native: false, required: get_option('python'))
> +if target_python.found()

Ok, so here we are not actually using python to build, but instead need
to know whether to include this build configuration which is dependent
on the target host having python. Makes sense.

It might be nice to leave a comment here to explain this. The changes in
this patch look good though.

>    build_options_config.set('NO_PYTHON', '')
>  else
>    libgit_c_args += '-DNO_PYTHON'
> @@ -1979,7 +1978,7 @@ if perl_features_enabled
>    subdir('perl')
>  endif
>  
> -if python.found()
> +if target_python.found()
>    scripts_python = [
>      'git-p4.py'
>    ]
> @@ -2202,7 +2201,7 @@ summary({
>    'iconv': iconv.found(),
>    'pcre2': pcre2.found(),
>    'perl': perl_features_enabled,
> -  'python': python.found(),
> +  'python': target_python.found(),
>  }, section: 'Auto-detected features')
>  
>  summary({
> 
> -- 
> 2.50.0.195.g74e6fc65d0.dirty
> 
> 
