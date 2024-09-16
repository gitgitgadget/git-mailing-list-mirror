Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD342837A
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 16:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726503934; cv=none; b=feoZ0J6hoqkE0fCuo8FLZNa5uZTeZ15Myam65ABWlM3D70tqm1nLnAGCy9+K+nrGuQt4Qe0FiagilGWhWEkpmhhiFY3z3blao81KJ5K/MGhHJs7G8AUjViT2Y0bTk3m32bjVGsXjJXfR7BNC+OnAXwOPNei1w/Wn8TLYe2cxCcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726503934; c=relaxed/simple;
	bh=8hI7kFhGCddk+QM57vib8vtaKukMh4ObfjwWH67irNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ct1Qtgmpo1l0N/dkK22EU39TLoz1kICzsJw7O6juGnxVQDa39bQX8MQa+SLh1DAwuKfi5V+I8ptXncv7cyls2Q+jvtIAgkiwEjLg3YkX0gg+v/ahRWAeylFVGht1WhZk/wfFnKqVf8CRwdhKvrf+xJnAiHK6kO1XpeOhJmf5fjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SLLpzxxo; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLLpzxxo"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2780827dbafso1821661fac.1
        for <git@vger.kernel.org>; Mon, 16 Sep 2024 09:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726503930; x=1727108730; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DhqttTPwBZvAIOWRrNCXOiSpXqSJL8mvbdl2ypoopFk=;
        b=SLLpzxxofeKC8TNcv50m3e8iXjFhxnkM+fq/Yff1Dv8/jdMnbysJqTVFqKjALCftMM
         +Kk64QJjsKy+FPNxQkW4zsWsD0hyJj+nywnyYNBfzbikF6LLOM0y2+6Sk4oyLNgB+D+/
         0Zd37boEw9dtMUlG1iv4Rx9xnyUor9qfjQRk2ZCCTcewPryFLP68q1SyZeBoYG9ieL5W
         PECsnINX3wgAQDN/yC8ndUdv9cjlz6L94vl0RXPcn3dO47R0llf+2IsDCgwFo933QqVD
         qlcFciW1FCA501y1tfK5K7S5El1ZfjFVG5ZEOGJvFPZiprX0vq02vubTcEKslv4E2IX/
         /PVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726503930; x=1727108730;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DhqttTPwBZvAIOWRrNCXOiSpXqSJL8mvbdl2ypoopFk=;
        b=ettozFLRDYiel6DlhVAIwIpbeedZQxHAoW+lV/lyg9DtY2MC4ErFngBmvxgUsZkZqX
         h1RqRH4qnUKmC2IFqbXEYYAqMPDF/a3uXPzoTwsI3vAY6WaH3C3uUjaO7QatWtf0+9tG
         0c2eITrGdhd5pYzSICVlV114ZucFbYxFDx/T4BAvvwbI8teRQFM0JrfSc1XRatruyq2O
         X5kvn2gGEI9JdRHoqjAUwTzAf66jMJ/ZFgtmEJEdhUk0ySw40mNNc981pPg+GDsEzq1m
         VMN8EDOj1K169MJvzR/U95E4OC3QxlTmzi8C+XV/tgMtRrr9qMpO1QUm3tZRQ9dkmFUY
         m/1w==
X-Gm-Message-State: AOJu0YzbFmgKG1k8ENlfKSKXIdlDNTKI3neWy2WJsLTLQNIPsMU7NQXe
	iaA/7Akn9PqVR3XhPvhKm+o74jL3+AuUfDNetbCPnZifHadDLffxuQ+9Nw==
X-Google-Smtp-Source: AGHT+IFPo58k+Ufd70iCUB39gksB9/QWcOFDpzJwDtGWNJrqkumgPN3QMS/6V5oh9aRvN9acCYtLVA==
X-Received: by 2002:a05:6871:e2c1:b0:260:e4ac:72e5 with SMTP id 586e51a60fabf-27c68a091b7mr6917054fac.25.1726503930408;
        Mon, 16 Sep 2024 09:25:30 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-27c956f3b33sm1607827fac.33.2024.09.16.09.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 09:25:29 -0700 (PDT)
Date: Mon, 16 Sep 2024 11:24:15 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 01/23] builtin/help: fix dangling reference to `html_path`
Message-ID: <guzjej2ghio2bxxt6epofcnl57nqaoagm65byox4iwhvkim2oy@qcuyzzsw5que>
References: <cover.1726484308.git.ps@pks.im>
 <e3bed973afacaec801cff1e77aeea6050cb34f57.1726484308.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3bed973afacaec801cff1e77aeea6050cb34f57.1726484308.git.ps@pks.im>

On 24/09/16 01:45PM, Patrick Steinhardt wrote:
> In `get_html_page_path()` we may end up assigning the return value of
> `system_path()` to the global `html_path` variable. But as we also
> assign the returned value to `to_free`, we will deallocate its memory
> upon returning from the function. Consequently, `html_path` will now
> point to deallocated memory.
> 
> Fix this issue by instead assigning the value to a separate local
> variable.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/help.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/builtin/help.c b/builtin/help.c
> index dc1fbe2b986..282ea5721fa 100644
> --- a/builtin/help.c
> +++ b/builtin/help.c
> @@ -513,23 +513,24 @@ static void show_info_page(const char *page)
>  static void get_html_page_path(struct strbuf *page_path, const char *page)
>  {
>  	struct stat st;
> +	const char *path = html_path;
>  	char *to_free = NULL;
>  
> -	if (!html_path)
> -		html_path = to_free = system_path(GIT_HTML_PATH);
> +	if (!path)
> +		path = to_free = system_path(GIT_HTML_PATH);

Previously, `html_path` was being assigned the return value of
`system_path()` and consequently escaping this scope even though the
value was being freed. There is no reason to modify the global value to
begin with so we instead assign the value to a local variable. Makes
sense.

>  
>  	/*
>  	 * Check that the page we're looking for exists.
>  	 */
> -	if (!strstr(html_path, "://")) {
> -		if (stat(mkpath("%s/%s.html", html_path, page), &st)
> +	if (!strstr(path, "://")) {
> +		if (stat(mkpath("%s/%s.html", path, page), &st)
>  		    || !S_ISREG(st.st_mode))
>  			die("'%s/%s.html': documentation file not found.",
> -				html_path, page);
> +				path, page);
>  	}
>  
>  	strbuf_init(page_path, 0);
> -	strbuf_addf(page_path, "%s/%s.html", html_path, page);
> +	strbuf_addf(page_path, "%s/%s.html", path, page);
>  	free(to_free);
>  }
>  
> -- 
> 2.46.0.551.gc5ee8f2d1c.dirty
> 
> 
