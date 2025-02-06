Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E353E1624D4
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 15:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738854081; cv=none; b=XStUQyQGrp4QrOTVsniSY7VcreLXejPZJ0CxItP7gVTzpwSUPOzjM3Lfg5BxTz802iEP0cGLvi0Au24riI6TFpj95XYYraZyTRla8LLi3BMRrBZ8XspAVGDeB7RJ9QGkfRbUd5rpa/7ga7xOyRIIGYS3jzG7RuBEAkKTCc3ZZGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738854081; c=relaxed/simple;
	bh=b7cR/gd6HWgk35Ty4+RkXnK9hgKWn9EBxIGTlkCuttg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eOy4ucDInuzu8lH9nXAVMzkR0e9shN10O+2R9w9L38boiDLe5ocjE786NDx6IT3Ta/wKsUQbA56o7HC8oELvKw3HBG7EHL/kT+19I9ojB6xIPoKMWj1uLsaqwD4iC0YaxlEv1eT0wbHLXGHpS0aFSk5b5yEBD1ORmw8OlPl141M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dRPo4D8o; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRPo4D8o"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21f0c4275a1so16084485ad.2
        for <git@vger.kernel.org>; Thu, 06 Feb 2025 07:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738854079; x=1739458879; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kBI+ObF4TRzzQKLRAUZSASgMF/1RgDkYNJY8Cm9QgWc=;
        b=dRPo4D8oi6jlqemTbv5LtJxAD1KdiBFbi0VAXBpi7JXOR+21Aa8Y/8idhN5G706NNT
         RJo8Ltx/iUDrVzuDxUsshz8ie7XS9dNMDJNWOkGPqc+cMREPkshMCCGXvaLetPt4UYtv
         +zbgo8rFY4PBw0A/8ucVBEt6xl8qIKW9RsulkXMRKo/4ZSWA0jXe/QQzoEgWXXnfqxgv
         c7U5rUk53RaOR0nAwkDFxFXbRbnYQs7gA5DsNuHP/v8X+bcTVCq9vj6efam6TSBXiCAA
         x0GQC+SiWzHjC17Zh+6yu3Z+xqeWO/fNaT7HHbCAS7Dj7tPC+EkMfORNwWeMLIhSob2D
         y9Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738854079; x=1739458879;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kBI+ObF4TRzzQKLRAUZSASgMF/1RgDkYNJY8Cm9QgWc=;
        b=aw8uV16haVcVGjeAt766rZmh4V3lSzjg1OfEooJ6JT8aBEXJHDnT9QaXRyNSp/AcF9
         aMasUWqZKzNzSgwKlsIvGF1vlxoi4gpsp2AEilzmclV+QB2hzRmiiE+C9z4ihLqXUhIi
         2sxAGXUMEpG2xIxmeEnX70BWW/bMs/jk4U/O7xqn6f7bVzWueSwCXF76rKFR+QQTcEA0
         dge3ajDUOe/YwrsYXfSmMIBtKtPdb2K8RmjFS7xSf2rLzNeFvP+lnHGZEtQcqteX8sgx
         A675J+vyM/oq22dUPmHsn1v1sUdyuGz+1LHyNLCghUvjLee7qLQ5pks/CL+3yrBtbbgs
         Ngcw==
X-Gm-Message-State: AOJu0Yw2IDNu1CWHsV/kGo8is4DKjq7BdMHs8y6EtbmeJ206mU0i5tlV
	G9n5Qq4hTKtiO0Cv2M/GEGIAIcHWkY1DLdpqBw5/D8ATNAhv0kEa
X-Gm-Gg: ASbGncuNE/3Zr0pihRkvSg8z/VR1Qq03XhUmFHpKr6z/naLQoK2jtmxwL7EVGjVY7CQ
	ts+5v8M2UI2u7dUEXGkGMKdmSiHZeG2vWWvzRGECScqdyHWmlbwOZdOHOBpB2VT6i/ottywV2ou
	fBG40kJJ+Yc+dcKzuPmNrFptLkhIp30cbbT9G8wKPGuK07e1LgQUlOaqHRnHCqMiRhpnAstrOyZ
	vcxS+uP3GBMWYIslD2AvKWsBNnJPrbu8DJMhyCKxrNxM7E8B81BR5cltXjscX9L313mcg==
X-Google-Smtp-Source: AGHT+IE1WuNCbYd95IQfckM5rnXh7oYPA4Jt3gHn4t1U/cE4sQsi3EDeoivb4MQG2vcIpkbqs5QNWw==
X-Received: by 2002:a05:6a21:9184:b0:1e1:b1bb:87a0 with SMTP id adf61e73a8af0-1ede88af2cbmr16250752637.34.1738854078888;
        Thu, 06 Feb 2025 07:01:18 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-ad51aee3d3esm1389830a12.32.2025.02.06.07.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 07:01:18 -0800 (PST)
Date: Thu, 6 Feb 2025 23:03:00 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 05/16] path: refactor `repo_submodule_path()` family of
 functions
Message-ID: <Z6TPJIy1yRnNI2PP@ArchLinux>
References: <20250206-b4-pks-path-drop-the-repository-v1-0-4e77f0313206@pks.im>
 <20250206-b4-pks-path-drop-the-repository-v1-5-4e77f0313206@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206-b4-pks-path-drop-the-repository-v1-5-4e77f0313206@pks.im>

On Thu, Feb 06, 2025 at 08:58:01AM +0100, Patrick Steinhardt wrote:
> As explained in an earlier commit, we're refactoring path-related
> functions to provide a consistent interface for computing paths into the
> commondir, gitdir and worktree. Refactor the "submodule" family of
> functions accordingly.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/submodule--helper.c |  2 +-
>  path.c                      | 37 +++++++++++++++++++++++++++++--------
>  path.h                      | 30 ++++++++++++++++++------------
>  t/helper/test-ref-store.c   |  7 +++----
>  worktree.c                  |  3 ++-
>  5 files changed, 53 insertions(+), 26 deletions(-)
> 
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 3a64f7e605..c1a8029714 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -1826,7 +1826,7 @@ static int clone_submodule(const struct module_clone_data *clone_data,
>  
>  	connect_work_tree_and_git_dir(clone_data_path, sm_gitdir, 0);
>  
> -	p = git_pathdup_submodule(clone_data_path, "config");
> +	p = repo_submodule_path(the_repository, clone_data_path, "config");
>  	if (!p)
>  		die(_("could not get submodule directory for '%s'"), clone_data_path);
>  
> diff --git a/path.c b/path.c
> index d918d0409e..d721507be8 100644
> --- a/path.c
> +++ b/path.c
> @@ -560,14 +560,15 @@ const char *repo_worktree_path_replace(const struct repository *repo,
>  }
>  
>  /* Returns 0 on success, negative on failure. */
> -static int do_submodule_path(struct strbuf *buf, const char *path,
> +static int do_submodule_path(struct repository *repo,
> +			     struct strbuf *buf, const char *path,
>  			     const char *fmt, va_list args)
>  {
>  	struct strbuf git_submodule_common_dir = STRBUF_INIT;
>  	struct strbuf git_submodule_dir = STRBUF_INIT;
>  	int ret;
>  
> -	ret = submodule_to_gitdir(the_repository, &git_submodule_dir, path);
> +	ret = submodule_to_gitdir(repo, &git_submodule_dir, path);
>  	if (ret)
>  		goto cleanup;
>  
> @@ -586,13 +587,14 @@ static int do_submodule_path(struct strbuf *buf, const char *path,
>  	return ret;
>  }
>  
> -char *git_pathdup_submodule(const char *path, const char *fmt, ...)
> +char *repo_submodule_path(struct repository *repo,
> +			  const char *path, const char *fmt, ...)
>  {
>  	int err;
>  	va_list args;
>  	struct strbuf buf = STRBUF_INIT;
>  	va_start(args, fmt);
> -	err = do_submodule_path(&buf, path, fmt, args);
> +	err = do_submodule_path(repo, &buf, path, fmt, args);
>  	va_end(args);
>  	if (err) {
>  		strbuf_release(&buf);
> @@ -601,16 +603,35 @@ char *git_pathdup_submodule(const char *path, const char *fmt, ...)
>  	return strbuf_detach(&buf, NULL);
>  }
>  
> -int strbuf_git_path_submodule(struct strbuf *buf, const char *path,
> -			      const char *fmt, ...)
> +const char *repo_submodule_path_append(struct repository *repo,
> +				       struct strbuf *buf,
> +				       const char *path,
> +				       const char *fmt, ...)
>  {
>  	int err;
>  	va_list args;
>  	va_start(args, fmt);
> -	err = do_submodule_path(buf, path, fmt, args);
> +	err = do_submodule_path(repo, buf, path, fmt, args);
>  	va_end(args);
> +	if (err)
> +		return NULL;
> +	return buf->buf;
> +}
>  
> -	return err;
> +const char *repo_submodule_path_replace(struct repository *repo,
> +					struct strbuf *buf,
> +					const char *path,
> +					const char *fmt, ...)
> +{
> +	int err;
> +	va_list args;
> +	strbuf_reset(buf);
> +	va_start(args, fmt);
> +	err = do_submodule_path(repo, buf, path, fmt, args);
> +	va_end(args);
> +	if (err)
> +		return NULL;
> +	return buf->buf;
>  }

By reading through the patches from 1 to this. I gradually understand
your design now. For every refactor, we will provide three kinds of
functions. All of these functions will return `const char *` and we
could elegantly use `NULL` to indicate the error.

Thanks,
Jialuo
