Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429CA39E6C6
	for <git@vger.kernel.org>; Tue, 28 Jul 2026 17:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785258747; cv=none; b=HJpRLGloQ2oeXKKbJ2h77to+mm7U/rHZKJV/p0tysCN44wIAQvI1QhsX/wdH+n1+RzVWSFf7eCHUsLtO4wyzLrTipClNWgjwAzICx4UNS7v8qp/XbcUocRoMUde2DtXLc6HjRAtF3HSq2cVqGyDcwdD3LU8aodcqJHhynob52oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785258747; c=relaxed/simple;
	bh=mRMARNvGl6lBpVgE8iiWImGNbluiazgpoI+zC5zT67Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YN3amXyhs+HVdayv3vFn22Xo0UFa1bN3V9ZjGNu6GR9jrQbTeOKxH42FT4CyDVzCs8JakYkJZDJrmB1zC3XHeA3btIP3DuEGf9xOw+ujszrkjgbA7wf49WWZJ4MT3rBwOKaC/iyRPhqd2+70aGPaLdNus1xR8+pGHbbWVdWcS/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r+756qne; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r+756qne"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-81062fdeaf5so17672847b3.0
        for <git@vger.kernel.org>; Tue, 28 Jul 2026 10:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785258745; x=1785863545; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3c5ACRLkUIJFDEwvVjo2bavDitRk3ycZ1Z6L47/CVMs=;
        b=r+756qneB3t2wgYuC4nBfFLAnxq/1HLp//ltvFDGL21TKx1Svp7KaEPiqrYDwecfaz
         vQ4y34BIZoUUZvEfYT/rhhCYpLIC4W2VOiOjUJ3X4ma67kH2aNQGS0Uw8q2dS5ndQz2D
         KNQXJwKURycXiX04m6Uq3aOGXrlWhH564x0B1fu51GJarQrw4YUoGFzNirxMLsq5/u/n
         WiirT94cjMHCYH4gziqcMP/H0zaxNT5VUCCJ2fVh93alUfMsCRQ5KB8IcduHWORhciFi
         AmfQFprDTOFvGBkLUgi9j+baAL4AkfxQaTCmEc3TaI8UoOoCdn1d8KJLIERAQDGdTqrp
         k/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785258745; x=1785863545;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3c5ACRLkUIJFDEwvVjo2bavDitRk3ycZ1Z6L47/CVMs=;
        b=XqvT6Uxojk9OkHD9wb7SWVzxv6qzuJ9WwVMuPm1KXFKsyAKV8SEJaSbEI2JhAV9utl
         PWz0o4uk6DbBxQ7dCJxHorme33/vs7DJrZXJWVhG9QI3+torxtKgZw/UKt0VccrVtWzt
         kbGPkzgy3dRMPh/vVA84Z5X3ui8yTrAI8Mwri06M5q3s+D8sVKSHu049TQrMmUSycYcV
         ypoeFtROavhGOksqRZ0k6CFAKMrQxpO9awIo4HNTeLKKFXD+qg7NUgNF3Kyw1Jyhhq9u
         sWE6TfMY8Ngaf4lmBBS2LuMp3CjF9/g3A5gLaRBsqEbeFUf6N4M7WUwfux8Hlugb5TL0
         Q3Mg==
X-Gm-Message-State: AOJu0Yx0HYypujv0I8Kl9QhFrhPHxzdsCq8Qz8jHT80uDL4OFPmTlxzY
	KuArl4msB8NtwmRLoRysg2ocxPuVeAO5EalfQoLYpiEc8OLucRf6IhjGXVauGA==
X-Gm-Gg: AR+sD117MjAfVz+N02dZxuDw1fYkpDynpFVSrbCfvJLpOv9Ji9OSg5EFAb84mO3IVaT
	Gq7P6w5M+5dtjjzPZgrkraizv8tQ7pg8n/cvoXOb4g3ZP9HeFTHuTk3qHpCxTjYF7te3ZYNz3cq
	09Botc+Mdwj/2rAcsXt/IvOhfJ1hnyO+mReRzZaNXplBjXkTCOksPrNPTGLiKfwI9/OIrZartIp
	YdWOpCITeRy6QuaQ4ybPWotZk0lwGL/40tDPb9EJ2LH9h5kOvb7ZnmgTHOYUJLbOSD4aLqqNW9V
	/Sa/IG8K9iwSS6eguaX1c1V/m8hO9bo+YKDjRSEKz7PDzV6c6xm2oWhP4i/d5ML/QzjEpFo6/oE
	3yC327wW9dHePOQBMUhHqfkrfgNj3d0HHEWQyIRms6QVZqzG+erri4dncLKC2u2dK6q8DkDo=
X-Received: by 2002:a05:690c:4c09:b0:81e:4acb:c0a with SMTP id 00721157ae682-81f991fe6f1mr14794757b3.2.1785258744999;
        Tue, 28 Jul 2026 10:12:24 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fa292a2b7sm2542127b3.28.2026.07.28.10.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 10:12:24 -0700 (PDT)
Date: Tue, 28 Jul 2026 12:12:18 -0500
From: Justin Tobler <jltobler@gmail.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, lucasseikioshiro@gmail.com, 
	ps@pks.im
Subject: Re: [PATCH v3 3/7] repo: add path.objects with absolute and relative
 suffix formatting
Message-ID: <amjeDPUeoOSN_oYk@denethor>
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
 <20260726104343.16933-1-jayatheerthkulkarni2005@gmail.com>
 <20260726104343.16933-4-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260726104343.16933-4-jayatheerthkulkarni2005@gmail.com>

On 26/07/26 04:13PM, K Jayatheerth wrote:
> Tools and deployment hooks frequently query the location of the object
> database directory. Currently, this relies on legacy parsing methods or
> manually inspecting `git rev-parse --git-path objects`.

"Tools and deployment hooks" seems a bit overly specific. Maybe instead
we could just say "Scripts operating on a repository may need to query
the location of the object database directory"?

Also, I'm not entirely sure what is meant by "legacy parsing methods"
here.

> Introduce `path.objects.absolute` and `path.objects.relative` keys to
> `git repo info`. This allows tools to discover the object database
> location safely while natively adhering to active `GIT_OBJECT_DIRECTORY`
> environment variable overrides.

In the context of pluggable ODBs, this proposed key is a little more
interesting because a non-"files" ODB source in the future may not even
have a filesystem path to an objects directory. When this becomes more
relevant, we could just adapt these keys to return an empty string in
such cases, but it does also make me question whether it is information
that we should further expose in the first place if it does eventually
becomes an internal detail of a specific ODB source.

It probably doesn't matter too much, but I've CC'd Patrick for his
thoughts too.

[snip]
> diff --git a/builtin/repo.c b/builtin/repo.c
> index 82359473e9..d6bdd5bcfa 100644
> --- a/builtin/repo.c
> +++ b/builtin/repo.c
> @@ -122,6 +122,28 @@ static int get_path_gitdir_relative(struct repository *repo, struct strbuf *buf)
>  	return 0;
>  }
>  
> +static int get_path_objects_absolute(struct repository *repo, struct strbuf *buf)
> +{
> +	const char *obj_dir = repo_get_object_directory(repo);
> +
> +	if (!obj_dir)
> +		return error(_("unable to get object directory"));
> +
> +	format_path(buf, obj_dir, startup_info->prefix, PATH_FORMAT_CANONICAL);

For the absolute path, do we actually need to provide the prefix? It
might make it more clear that its the aboslute path if we just pass ""
instead?

-Justin
