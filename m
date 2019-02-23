Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A970020248
	for <e@80x24.org>; Sat, 23 Feb 2019 21:49:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbfBWVtB (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Feb 2019 16:49:01 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33678 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfBWVtB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Feb 2019 16:49:01 -0500
Received: by mail-wr1-f68.google.com with SMTP id i12so5990084wrw.0
        for <git@vger.kernel.org>; Sat, 23 Feb 2019 13:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=o4NBcJ1PeLmWdfuKdcS5MDkf9bSgVvTDTw4nzjd1q4k=;
        b=iwnRPnA+0bxm+fnDhH+v/t2qPz8jFgERPW5Dj8osbpVWdGZZ+TKMW9rlIWsY82KOF0
         gYKqX0gTiciPF7W216aWBPOO3Jm2pzlY0FoxYGJm4f4WS7VLZoPJwRAeXw5VnzMDqib1
         Hmsbb7P0UaijXLwGkAoFGocT91XkidudPYyi9z1ltfiqD69p2dUl6huZXsIyrANWZvxo
         Yjb5v185urnNFGFHlsis2LpxzbeyBSzsV1+aR2AcF3ZM5KPOrPxKaola6y0/N3uJBxuH
         cTLLlOjEvSiA8k2AXachSZ0oy7l0O3IlwYXsTw79UunHPb28fSLm8hHYnjaAhnLL5pm3
         +BRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=o4NBcJ1PeLmWdfuKdcS5MDkf9bSgVvTDTw4nzjd1q4k=;
        b=RAc6QkYg0jHTBX1fNpxN+TMaJhtexlB3yaVUtKINtaS8b57jaxXqiHv0kaW1QWcbRb
         tj0Vxth2wG7IfDy8d1NiaT+sOiWHvuM4Gqdp2MgcqDd9n9XWvpnbL0AVSSNLoaqORzqM
         RqJcakcsMV57zabjBlhUVTLar2PaVWo/f5cStWEG1ovrnbgLcBgKanB7TJ7PbUOXjhT1
         lBVMTSxXdvBwpdnCpjUOhSBSXW9MYvqgVsUlnum3IPcQkHLRgTJU1cWFrMFxjDlYP67w
         OrttL+72S542LTuCxpDAkSy8MegzM1BVF3fELvhKPSWtJIEnVRgqi5kn8OTJ87AV7yD9
         7C7Q==
X-Gm-Message-State: AHQUAubZaZGC9vsJdn2qbS/wF/CUay76JhBHpsGagDofJ2c5eMbRiief
        w5OrHPqKnLD2G2fUebL1sAgONQUp
X-Google-Smtp-Source: AHgI3IaiVW/afzo5wSC3YeJ2F/Z8i8VKeosyCEvJDWfw2I7dkrP9jixBHxhWnqA+o1qhTTibmle8cQ==
X-Received: by 2002:a5d:44c3:: with SMTP id z3mr7198621wrr.329.1550958538741;
        Sat, 23 Feb 2019 13:48:58 -0800 (PST)
Received: from localhost ([95.149.189.205])
        by smtp.gmail.com with ESMTPSA id u12sm4754578wmf.44.2019.02.23.13.48.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 23 Feb 2019 13:48:57 -0800 (PST)
Date:   Sat, 23 Feb 2019 21:48:56 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [GSoC][PATCH 3/3] clone: use dir-iterator to avoid explicit dir
 traversal
Message-ID: <20190223214856.GQ6085@hank.intra.tgummerer.com>
References: <20190223190309.6728-1-matheus.bernardino@usp.br>
 <20190223190309.6728-4-matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190223190309.6728-4-matheus.bernardino@usp.br>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/23, Matheus Tavares wrote:
> Replace usage of opendir/readdir/closedir API to traverse directories
> recursively, at copy_or_link_directory function, by the dir-iterator
> API. This simplifies the code and avoid recursive calls to
> copy_or_link_directory.
> 
> This process also brings some safe behaviour changes to
> copy_or_link_directory:
>  - It will no longer follows symbolic links. This is not a problem,
>    since the function is only used to copy .git/objects directory, and
>    symbolic links are not expected there.
>  - Hidden directories won't be skipped anymore. In fact, it is odd that
>    the function currently skip hidden directories but not hidden files.
>    The reason for that could be unintentional: probably the intention
>    was to skip '.' and '..' only, but it ended up accidentally skipping
>    all directories starting with '.'. Again, it must not be a problem
>    not to skip hidden dirs since hidden dirs/files are not expected at
>    .git/objects.
>  - Now, copy_or_link_directory will call die() in case of an error on
>    openddir, readdir or lstat, inside dir_iterator_advance. That means
>    it will abort in case of an error trying to fetch any iteration
>    entry.
> 
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> ---
> Changes in v2:
>  - Improved patch message
>  - Removed a now unused variable

s/variable/parameter/ I believe?

>  - Put warning on stat error back
>  - Added pedantic option to dir-iterator initialization
>  - Modified copy_or_link_directory not to skip hidden paths

Thanks, these descriptions are very useful for reviewers that had a
look at previous rounds.

>  builtin/clone.c | 47 ++++++++++++++++++++++++++++-------------------
>  1 file changed, 28 insertions(+), 19 deletions(-)
> 
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 862d2ea69c..515dc91d63 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -23,6 +23,8 @@
>  #include "transport.h"
>  #include "strbuf.h"
>  #include "dir.h"
> +#include "dir-iterator.h"
> +#include "iterator.h"
>  #include "sigchain.h"
>  #include "branch.h"
>  #include "remote.h"
> @@ -411,42 +413,45 @@ static void mkdir_if_missing(const char *pathname, mode_t mode)
>  }
>  
>  static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
> -				   const char *src_repo, int src_baselen)
> +				   const char *src_repo)
>  {
> -	struct dirent *de;
> -	struct stat buf;
>  	int src_len, dest_len;
> -	DIR *dir;
> -
> -	dir = opendir(src->buf);
> -	if (!dir)
> -		die_errno(_("failed to open '%s'"), src->buf);
> +	struct dir_iterator *iter;
> +	int iter_status;
> +	struct stat st;
>  
>  	mkdir_if_missing(dest->buf, 0777);
>  
> +	iter = dir_iterator_begin(src->buf, 1);
> +
>  	strbuf_addch(src, '/');
>  	src_len = src->len;
>  	strbuf_addch(dest, '/');
>  	dest_len = dest->len;
>  
> -	while ((de = readdir(dir)) != NULL) {
> +	while ((iter_status = dir_iterator_advance(iter)) == ITER_OK) {
>  		strbuf_setlen(src, src_len);
> -		strbuf_addstr(src, de->d_name);
> +		strbuf_addstr(src, iter->relative_path);
>  		strbuf_setlen(dest, dest_len);
> -		strbuf_addstr(dest, de->d_name);
> -		if (stat(src->buf, &buf)) {
> +		strbuf_addstr(dest, iter->relative_path);
> +
> +		/*
> +		 * dir_iterator_advance already calls lstat to populate iter->st
> +		 * but, unlike stat, lstat does not checks for permissions on
> +		 * the given path.
> +		 */

Hmm, lstat does check the permissions on the path, it just doesn't
follow symlinks.  I think I actually mislead you in my previous review
here, and was reading the code in dir-iterator.c all wrong.

I thought it said "if (errno == ENOENT) warning(...)", however the
condition is "errno != ENOENT", which is why I thought we were loosing
warnings when errno == EACCES for example.

As we decided that we would no longer follow symlinks now, I think we
can actually get rid of the stat call here.  Sorry about the confusion.

> +		if (stat(src->buf, &st)) {
>  			warning (_("failed to stat %s\n"), src->buf);
>  			continue;
>  		}
> -		if (S_ISDIR(buf.st_mode)) {
> -			if (de->d_name[0] != '.')
> -				copy_or_link_directory(src, dest,
> -						       src_repo, src_baselen);
> +
> +		if (S_ISDIR(iter->st.st_mode)) {
> +			mkdir_if_missing(dest->buf, 0777);
>  			continue;
>  		}
>  
>  		/* Files that cannot be copied bit-for-bit... */
> -		if (!strcmp(src->buf + src_baselen, "/info/alternates")) {
> +		if (!strcmp(iter->relative_path, "info/alternates")) {
>  			copy_alternates(src, dest, src_repo);
>  			continue;
>  		}
> @@ -463,7 +468,11 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
>  		if (copy_file_with_time(dest->buf, src->buf, 0666))
>  			die_errno(_("failed to copy file to '%s'"), dest->buf);
>  	}
> -	closedir(dir);
> +
> +	if (iter_status != ITER_DONE) {
> +		strbuf_setlen(src, src_len);
> +		die(_("failed to iterate over '%s'"), src->buf);
> +	}
>  }
>  
>  static void clone_local(const char *src_repo, const char *dest_repo)
> @@ -481,7 +490,7 @@ static void clone_local(const char *src_repo, const char *dest_repo)
>  		get_common_dir(&dest, dest_repo);
>  		strbuf_addstr(&src, "/objects");
>  		strbuf_addstr(&dest, "/objects");
> -		copy_or_link_directory(&src, &dest, src_repo, src.len);
> +		copy_or_link_directory(&src, &dest, src_repo);
>  		strbuf_release(&src);
>  		strbuf_release(&dest);
>  	}
> -- 
> 2.20.1
> 
