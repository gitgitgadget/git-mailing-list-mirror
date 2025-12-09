Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069C017D2
	for <git@vger.kernel.org>; Tue,  9 Dec 2025 02:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765247672; cv=none; b=SXURZNMNCIW/1HmiT4qeq66ah5WVa3wZ2Midh3fAdox6fzykmSu+UEmxA9kF7+8l9Kar1ybXVwVt7lAepieU1fUxTJ+v8UB6MTfxxXZOQFHZqBVv+aL49zwGLr4BGZYdMmUE4Dv8jVy51StzByU5KIDHE8mrPVisG4ry6PSF7as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765247672; c=relaxed/simple;
	bh=ME2eiRS9GDUvao/BRfgPeXkVwmDIGyD0gRm0W/rwN5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jY6X/4zvSRteiE/lbbDIfiaRKjDNH1r60Tv0XBuO0LHYcWzJ0YwWZR3N+qAgFzu3czSGCRZOYUk7Flqp+o+Op0UXTHdbnGqYL0uXtUZLMkRw6pdaQSMeqNLJX/m9AwU8dVqS+VgKRrGRO/Qsg6Gohdm9ASua6lPTbSjfCCXDCYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NNnyq0RF; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NNnyq0RF"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-3ed151e8fc3so3099213fac.2
        for <git@vger.kernel.org>; Mon, 08 Dec 2025 18:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765247670; x=1765852470; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l48rAHhnd2rtaAyN499Mdebq7AgWNA0tf8QAQX77BNc=;
        b=NNnyq0RFwqsl5ZR9fG2NpUKJGRRMQPxUwX8EhkgGBnvGLKEg0rlKflhqnFc91eT/0y
         wOea4yEYht8ApDqV47YZht4Yk4eZULdqyaqJtTA4cjIIfQG4zDOluVgblLlXsHBQ+LLD
         4AbNv7gedfaoPzc0rsDkdkcdY4y4+Df95tlcDR8BGPIEAlEY5nUMzdHzei35RZvuUaly
         dJA7XVmSDFlGneHURY6jFjHhNCKOrOPcBCj1F30CuzWXDP5nDU8gkpSl71uTmC/o8Jaa
         DT0YErEfF5yTC62YQVePteY7DzRfVOhhKBZE3w7dn+Y0pnJnbagxpwiFBb32eUF8WsW/
         B80A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765247670; x=1765852470;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l48rAHhnd2rtaAyN499Mdebq7AgWNA0tf8QAQX77BNc=;
        b=AXdiew5+wyTItvDV/w07z3t9u77HhKMQl2NBSAF+crkOm+O20a0XDU/DOGl2AuXRRZ
         8g0z4djAtILFr9+aqKJ8fK+oSiju1tbjV8rIQs9eWDsXCrTYwsy9yehqc8mX/XSzZx8N
         9rAigLvvUem6z3pH8PSJroP4Usa4T8aFH8qD89B1DGWufTsGs3AnfCVtm8k+1oxvO99y
         CfSxAw8nlQmGcHohDIv6z0keWfpJmvvF69jqz+5ud/z0Q5wvcLvu+put3U5bpHPs48tS
         He9LRWCbWga/6F7+YdsC+RkFHXvldyuC5shDM593CH3I4kD1t1YywKKKk1Qh3mYQKd21
         AUCw==
X-Gm-Message-State: AOJu0YzC7WwehQKYzrwu7blVph+Gi9nV9mdqLz2wlWQjtcyDe7ri8VDp
	CHDlrB+eflgGx2ZpaJXnWG7lsipp08EKYAFqlhfgbFiPURgvb4EIfpzO58jlxQ==
X-Gm-Gg: ASbGncuhdaICdF0vKYLBDh99l8Hacc4J9kZ4sp8pCNAgGptiz+TvrtiJL0N5n5S9DFU
	Houp5KsCiGhIkc6jyRifdiADq5GhntHDesFvFTwkJ9LmUl4ma6kVwaEIOjRJDNHXTdIEIO7BGvH
	X2ZW//GVoI9ukz6NntlEnMuWq4Wy/jwTtPvYAhJskNS1lgRgKBFeJSxSv8gU3ViEYo8EXuYFnF1
	aFNcT4vVKIK8xmyfdMs1GS70tvJU1wOpa59vaBKX4SX4VSIqcBgge+LLt+uBNOUKT20YmzgC9Q6
	Xf/yp6UzHrE47KyGm0uhrG924BQxm38QX3R2gaAgffr/MEvzBP98ufW6TAZbjn+LveaQsjRG1MZ
	hnw4+FkmzlYDoUHSlmHWSjOWbiDDRrnACIi+lUKGGBiXEuJHx4BwuFy4bUNVBf3keUB8/DuLUDb
	utdSgW
X-Google-Smtp-Source: AGHT+IHITkmVsTlCyiocEWFfOrErFbk+6134mCKGtVUdY28Ww4n25fiNoOwIQ1BCRMeJRE4wF9Y8eg==
X-Received: by 2002:a05:6870:b493:b0:3e8:9d25:b40 with SMTP id 586e51a60fabf-3f543e025fcmr3971237fac.20.1765247669800;
        Mon, 08 Dec 2025 18:34:29 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3f50aa34d4fsm9919681fac.5.2025.12.08.18.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 18:34:28 -0800 (PST)
Date: Mon, 8 Dec 2025 20:34:25 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/8] odb: move computation of normalized objdir into
 `alt_odb_usable()`
Message-ID: <cqrno3lfvbfrb6ieestagbs5avshs7znoumky2plvtc4tjye2a@onwb5vmtstbx>
References: <20251208-b4-pks-odb-alternates-via-source-v1-0-e7ebb8b18c03@pks.im>
 <20251208-b4-pks-odb-alternates-via-source-v1-3-e7ebb8b18c03@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208-b4-pks-odb-alternates-via-source-v1-3-e7ebb8b18c03@pks.im>

On 25/12/08 09:04AM, Patrick Steinhardt wrote:
> The function `alt_odb_usable()` receives as input the object database,
> the path it's supposed to determine usability for as well as the
> normalized path of the main object directory of the repository. The last
> part is derived by the function's caller from the object database. As we
> already pass the object database to `alt_odb_usable()` it is redundant
> information.
> 
> Drop the extra parameter and compute the normalized object directory in
> the function itself.
> 
> While at it, rename the function to `odb_is_source_usable()` to align it
> with modern terminology.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  odb.c | 27 +++++++++++++++------------
>  1 file changed, 15 insertions(+), 12 deletions(-)
> 
> diff --git a/odb.c b/odb.c
> index 3ffeece567..2513457a31 100644
> --- a/odb.c
> +++ b/odb.c
> @@ -89,17 +89,20 @@ int odb_mkstemp(struct object_database *odb,
>  /*
>   * Return non-zero iff the path is usable as an alternate object database.

While we are here we could fix this typo: s/iff/if/

>   */
> -static int alt_odb_usable(struct object_database *o, const char *path,
> -			  const char *normalized_objdir)
> +static bool odb_is_source_usable(struct object_database *o, const char *path)
>  {
>  	int r;
> +	struct strbuf normalized_objdir = STRBUF_INIT;
> +	bool usable = false;
> +
> +	strbuf_realpath(&normalized_objdir, o->sources->path, 1);
>  
>  	/* Detect cases where alternate disappeared */
>  	if (!is_directory(path)) {
>  		error(_("object directory %s does not exist; "
>  			"check .git/objects/info/alternates"),
>  		      path);
> -		return 0;
> +		goto out;
>  	}
>  
>  	/*
> @@ -116,13 +119,17 @@ static int alt_odb_usable(struct object_database *o, const char *path,
>  		kh_value(o->source_by_path, p) = o->sources;
>  	}
>  
> -	if (fspatheq(path, normalized_objdir))
> -		return 0;
> +	if (fspatheq(path, normalized_objdir.buf))
> +		goto out;
>  
>  	if (kh_get_odb_path_map(o->source_by_path, path) < kh_end(o->source_by_path))
> -		return 0;
> +		goto out;
> +
> +	usable = true;
>  
> -	return 1;
> +out:
> +	strbuf_release(&normalized_objdir);
> +	return usable;
>  }
>  
>  /*
> @@ -164,13 +171,10 @@ static struct odb_source *odb_add_source(struct object_database *odb,
>  					 int depth)
>  {
>  	struct odb_source *alternate = NULL;
> -	struct strbuf tmp = STRBUF_INIT;
>  	khiter_t pos;
>  	int ret;
>  
> -	strbuf_realpath(&tmp, odb->sources->path, 1);
> -
> -	if (!alt_odb_usable(odb, source, tmp.buf))
> +	if (!odb_is_source_usable(odb, source))

The normalized ODB path is only being used in alt_odb_usable() so
relocating it inside that function make sense. Looks good.

-Justin
