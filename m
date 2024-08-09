Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D529D18030
	for <git@vger.kernel.org>; Fri,  9 Aug 2024 17:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723223942; cv=none; b=m1glyDBxCFEZykq11+gbtLPGOgyFoxSabqtaY2GjUhZhGvO70XgZy3YVSU+hobll69VwTuQGJeYPu9au+m7oKh/Np/FJfD7wTcHZDOp8wm/gf0BY0wF7Z7Czu2xn98DWh4hro0O/YdMtAgsx6byNCOUc+n28ZeiTOAm6Yf1DuO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723223942; c=relaxed/simple;
	bh=LtcPDUbUzfPBir4whEXa/N3o6lTXj3joryvZ+tLfAq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T9saq3tmOFgJcsxKaUvwFHXITIm+EOeRfDp4Ng51nPsC6bQ0yvmslZYWmYO6998w6NMX1SsHzwb+UhP3sbcqOPaBOC3PT7eMD8xsgKP5NnHDscJW5+6FW4cBl42POLNU9hQqPs3Fk8TvSZHFOR5hsqtQVYdxn8szZDdLJyYK5gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AzTOZ88z; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AzTOZ88z"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3db16a98d16so1490597b6e.0
        for <git@vger.kernel.org>; Fri, 09 Aug 2024 10:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723223940; x=1723828740; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6F43JwPrEza+l3kzQDEsb6avbzekXziwINARz8zRiTI=;
        b=AzTOZ88zLT3Ms1TWbtaUY97k/MQ9AlugNzHs6ASIXbSSXfgBreJ2e/DuSgqPYFPkf3
         jRDXtlygALbi11BFQ1tGevjD9L1w87vo3M6Ie2emPNkdjuA/5rSM1RvvG2/RinJteQH6
         V8LRohqPwThi1O5VO5NOA+oGFJdzoXYzGHV8PGif5kzXFh4P5ZrWhFF8+bBvss8xlPs7
         1dM0ZuXnKk7Bu/WLjIOc+uM5fTRLdZNKlphvzeT+ftWQ/bjMtCQfoJoop02aamEFsJPA
         2h7lxJ2Ai8Jgerm0dXwB29Cjj1w1p2f4guzz/1FeEvWdcEoG2c0c+98I2WwGKMJtqUol
         VXZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723223940; x=1723828740;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6F43JwPrEza+l3kzQDEsb6avbzekXziwINARz8zRiTI=;
        b=YLGsOENuHfnyAg5i9wGiDhS9xULchPW5zGCfyT7Fr0ZO/HSaNpR4Kw836nWOWizkUi
         ad6s1GsY7iIq2xtndRwv8xqsFwrmYr/QL9FWMgn7QzrvowCnaSWA9D/vvfpTUyqjj37A
         QJ+83cIcyAFdNWTnpl89kAgrP+3jUR05s9LICJdXVqrsuuBHdR36Lo96PZtiLgFT6leZ
         E7YeiJxtibs6e+RBXOlVcSsHVfPeoURpRTNBSXE3iUlsPAtDl2Tkrd3Xcywx2a3knIOt
         Y3guXt5Z+yDHYSfe4eW7x2PwsOMAjRLKqi9UyGRVCUP4J2YTPiaIjG6GGFDcjAzBa02k
         OsZg==
X-Gm-Message-State: AOJu0YyZJU0vpz2IwGk5DJoPS6EUFOlFDSTfKhf+VotVxtjH5hIDTV2U
	axEgkytSeUlBWIbKWc5RRZdXFN4+v4WfPjbthrvqWq/AIs4FsA96OUuhUA==
X-Google-Smtp-Source: AGHT+IF0ddU6z9/2JV4dnE4aHdlBmBWqTy6H3MqDNuG+7320IOfhnoc8BodM8JPm1+sS6GCI8eXWzQ==
X-Received: by 2002:a05:6808:164c:b0:3dc:1793:3644 with SMTP id 5614622812f47-3dc416f08b4mr2145685b6e.49.1723223939899;
        Fri, 09 Aug 2024 10:18:59 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3db563c50ddsm5698680b6e.49.2024.08.09.10.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 10:18:59 -0700 (PDT)
Date: Fri, 9 Aug 2024 12:18:12 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 02/20] path: expose `do_git_common_path()` as
 `strbuf_git_common_pathv()`
Message-ID: <ytv7y3jlbaru5o3ehotanqoqvjnwaomzsyj746k3hbb3htymts@m4qct6cvebiz>
References: <cover.1723013714.git.ps@pks.im>
 <e7a143c30dd95d8192eacc35c876e7926cb7c6a4.1723013714.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7a143c30dd95d8192eacc35c876e7926cb7c6a4.1723013714.git.ps@pks.im>

On 24/08/07 08:56AM, Patrick Steinhardt wrote:
> With the same reasoning as the preceding commit, expose the function
> `do_git_common_path()` as `strbuf_git_common_pathv()`.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  path.c | 22 +++++++++++-----------
>  path.h |  5 ++++-
>  2 files changed, 15 insertions(+), 12 deletions(-)
> 
> diff --git a/path.c b/path.c
> index 71f1cb4dfb..bff98b255e 100644
> --- a/path.c
> +++ b/path.c
> @@ -617,16 +617,16 @@ int strbuf_git_path_submodule(struct strbuf *buf, const char *path,
>  	return err;
>  }
>  
> -static void do_git_common_path(const struct repository *repo,
> -			       struct strbuf *buf,
> -			       const char *fmt,
> -			       va_list args)
> +void strbuf_git_common_pathv(struct strbuf *sb,
> +			     const struct repository *repo,
> +			     const char *fmt,
> +			     va_list args)

Here we reorder the arguments to make `strbuf` first. I assume we are do
this to align with the preexisting `strbuf_git_common_path()` and use
the "strbuf_" prefix in the function name.

In the previous commit we used the "repo_" prefix for
`repo_git_pathv()`. Would it make sense to be consistent here? All these
functions are operating on the provided buffer, but for a given
repository. Not sure what would be most appropriate here.

>  {
> -	strbuf_addstr(buf, repo->commondir);
> -	if (buf->len && !is_dir_sep(buf->buf[buf->len - 1]))
> -		strbuf_addch(buf, '/');
> -	strbuf_vaddf(buf, fmt, args);
> -	strbuf_cleanup_path(buf);
> +	strbuf_addstr(sb, repo->commondir);
> +	if (sb->len && !is_dir_sep(sb->buf[sb->len - 1]))
> +		strbuf_addch(sb, '/');
> +	strbuf_vaddf(sb, fmt, args);
> +	strbuf_cleanup_path(sb);
>  }
