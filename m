Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A813D273DC
	for <git@vger.kernel.org>; Sun,  6 Oct 2024 15:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728227379; cv=none; b=XAHoNESRUjef3TYdGl5MId4A8M3IbMj/khoX65a1sHVQaM2fgP/pGpX3V92qtwm+9KGnJiq0+/KJ7ySWk9KyD02rmMbERQLl4mXyyQvZhkIHF3JtJCIUZmOnB4iHjSanHWwbRUcNC+7o1WIDLyghMRYSez/Y91yomdBvU/sNGX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728227379; c=relaxed/simple;
	bh=hmZW/ZfLKQYPqxavj7wU4RnoaFIVLY36jdG6G3yU7Yw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZJAYK9BDMNF/tO0MJMAW6lMHosnQfGNqOsNNm3N1I9s+hXVEAUnbtwHycpRfKYRp8DublW9GEro1ISBD8hu9ivo/l0c/6BcPUrgYIG3dwvQjGpUogjiwGuO1sUkO3w3rcneG/t/RSieEfg8b+X3o4df9rHNzpfvkDaMOjYvDBWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nq/S/EBC; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nq/S/EBC"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20b6458ee37so41563875ad.1
        for <git@vger.kernel.org>; Sun, 06 Oct 2024 08:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728227377; x=1728832177; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q54R9IQAbJbgm+Z7V0YWTRI7SY03EXNtbn/Kf/vpkHY=;
        b=nq/S/EBCc44penajJckv5aT+D1eYL9C6Pl91VccSyHRKWHzGEqDcGtp2CTLlgXxgrT
         dwYbW1GYSoFb+9y3cU0v9erCQspOTYFd58A2GTu9W2x4nD8/kxruaqVbg65U+QaEnNuL
         FBgC3rEdvZu5K0Ahcxs8qtdPEbg2v9PLIi44U57/Ydy+xjhB03WsOo9gbv6oSrfxzOhe
         sNLylxl2ns/lznjWmhMrAB0UMbySg/YXFWo10Nb5yLPAwAlkcmeacGQKq9HIGWISc10/
         FbuTRXHKzBHRnAyDr+AxhgLZ5Og3HiGftVZ8+B0wRPWgmdhVaMTsJShsaOnd/xtAhqZq
         53AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728227377; x=1728832177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q54R9IQAbJbgm+Z7V0YWTRI7SY03EXNtbn/Kf/vpkHY=;
        b=TK34d+Ynwcn+MbMaebXxFmDZR0n0IyohsPRbFcUI8XdxW6DrO+0jCZydMKUJdiYsI0
         F1rbkfLGOAJMU57JEr4FAivUW5soXLV6cPgNVsC20rAykqCRpC79smNu8tlssgQfxf89
         o38ULQXyMRtCru2+r7UrJ23Sx8UprzsIde9g+Xp3QsPDqjZnTO9KzxhS93nhKIupVEfU
         Qttqj7vPs1vcm03XZVYTKC7cp+L9GRenDBqz9rkkEbwPWw4KKyE4H+XpH4mAy9DQY78G
         L4kAdn+1GAYV2zZZGUp787i8rbk5AA0DmgtZ2qOVt3c58FHldk5elpucKj7C7EbonO7N
         Nu9Q==
X-Gm-Message-State: AOJu0Yw0VJmnZxxpUte9ntRNjlUIyGTvd7TQNLD9xEnV6CFKDPky7sqY
	CbYIC0GqGySq6Ik9ffeFcQjMS6dL0f4ylZBAHOcn1dCG9mBoRlmoqFGi8w==
X-Google-Smtp-Source: AGHT+IEWlRignHimn0UVzHKBhAnqm5dA7ln0IHJjXCaCBkuHMtM9WoN1fSIq4Vd37f1drop1cER5ww==
X-Received: by 2002:a17:902:e84d:b0:20b:b26e:c149 with SMTP id d9443c01a7336-20bfe01d3c9mr138198285ad.29.1728227376820;
        Sun, 06 Oct 2024 08:09:36 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f6833cdcsm3331662a12.49.2024.10.06.08.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 08:09:36 -0700 (PDT)
Date: Sun, 6 Oct 2024 23:09:42 +0800
From: shejialuo <shejialuo@gmail.com>
To: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 1/4] worktree: refactor infer_backlink() to use *strbuf
Message-ID: <ZwKoNg-HYGaohvCd@ArchLinux>
References: <20241006060017.171788-1-cdwhite3@pm.me>
 <20241006060017.171788-2-cdwhite3@pm.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241006060017.171788-2-cdwhite3@pm.me>

On Sun, Oct 06, 2024 at 06:00:57AM +0000, Caleb White wrote:
> This refactors the `infer_backlink` function to return an integer
> result and use a pre-allocated `strbuf` for the inferred backlink
> path, replacing the previous `char*` return type.
> 
> This lays the groundwork for the next patch, which needs the
> resultant backlink as a `strbuf`. There was no need to go from
> `strbuf -> char* -> strbuf` again. This change also aligns the
> function's signature with other `strbuf`-based functions.
> 

I think we should first say why we need to add the change in the commit
message which means we should express our motivation in the first. It's
wired to say "I have done something" and then talk about the motivation
why we do this.

> Signed-off-by: Caleb White <cdwhite3@pm.me>
> ---
>  worktree.c | 26 ++++++++++++++------------
>  1 file changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/worktree.c b/worktree.c
> index 0f032cc..c6d2ede 100644
> --- a/worktree.c
> +++ b/worktree.c
> @@ -642,10 +642,9 @@ static int is_main_worktree_path(const char *path)
>   * be able to infer the gitdir by manually reading /path/to/worktree/.git,
>   * extracting the <id>, and checking if <repo>/worktrees/<id> exists.
>   */
> -static char *infer_backlink(const char *gitfile)
> +static int infer_backlink(st
> ruct strbuf *inferred, const char *gitfile)

This line is so strange. Why it generates a newline here?

>  {
>  	struct strbuf actual = STRBUF_INIT;
> -	struct strbuf inferred = STRBUF_INIT;
>  	const char *id;
>  
>  	if (strbuf_read_file(&actual, gitfile, 0) < 0)
> @@ -658,17 +657,16 @@ static char *infer_backlink(const char *gitfile)
>  	id++; /* advance past '/' to point at <id> */
>  	if (!*id)
>  		goto error;
> -	strbuf_git_common_path(&inferred, the_repository, "worktrees/%s", id);
> -	if (!is_directory(inferred.buf))
> +	strbuf_git_common_path(inferred, the_repository, "worktrees/%s", id);
> +	if (!is_directory(inferred->buf))
>  		goto error;
>  
>  	strbuf_release(&actual);
> -	return strbuf_detach(&inferred, NULL);
> +	return 0;
>  
>  error:
>  	strbuf_release(&actual);
> -	strbuf_release(&inferred);

Because we leave the life cycle of the "inferred" to be outside of this
function, we should not use "strbuf_release" to release the memory here.
Make sense.

> -	return NULL;
> +	return 1;
>  }
>  
>  /*
> @@ -680,9 +678,10 @@ void repair_worktree_at_path(const char *path,
>  {
>  	struct strbuf dotgit = STRBUF_INIT;
>  	struct strbuf realdotgit = STRBUF_INIT;
> +	struct strbuf backlink = STRBUF_INIT;

Here, we replace "char *backlink" to "struct strbuf backlink", we need
to align the changed "infer_backlink" function. That's OK.

>  	struct strbuf gitd
> ir = STRBUF_INIT;

Another strange newline here.

>  	struct strbuf olddotgit = STRBUF_INIT;
> -	char *backlink = NULL;
> +	char *git_contents = NULL;
>  	const char *repair = NULL;
>  	int err;
>  
> @@ -698,21 +697,23 @@ void repair_worktree_at_path(const char *path,
>  		goto done;
>  	}
>  
> -	backlink = xstrdup_or_null(read_gitfile_gently(realdotgit.buf, &err));
> +	git_contents = xstrdup_or_null(read_gitfile_gently(realdotgit.buf, &err));

So, we create a new variable "git_contents" here. I suspect this is a
poor design. In the original logic, we will do the following things for
"backlink".

  1. Call the "read_gitfile_gently" function. If it encounters error, it
     will return NULL and the "err" variable will be set to NON-zero.
  2. If the value of "err" is 0, we would simply execute the
     "strbuf_addstr(&gitdir, "%s/gitdir", backlink)".
  3. If not, and the "err" is "READ_GITFILE_ERR_NOT_A_REPO". We will
     call "infer_backlink" to set the "backlink".

Because now "backlink" is "struct strbuf", we cannot just assign it by
using "xstrdup_or_null(read_gitfile_gently(...))". So, we create a new
variable "git_contents" here.

And we will check whether "git_contents" is NULL to set the value for
the "backlink".

Why not simply do the following things here (I don't think
"git_contents" is a good name, however I am not familiar with the
worktree, I cannot give some advice here).

    const char *git_contents;
    git_contents = read_gitfile_gently(...);
    if (git_contents)
        strbuf_addstr(&backlink, git_contents);

Even more, we could enhance the logic here. If "git_contents" is not
NULL, there is no need for us to check the "err" variable.

>  	if (err == READ_GITFILE_ERR_NOT_A_FILE) {
>  		fn(1, realdotgit.buf, _("unable to locate repository; .git is not a file"), cb_data);
>  		goto done;
>  	} else if (err == READ_GITFILE_ERR_NOT_A_REPO) {
> -		if (!(backlink = infer_backlink(realdotgit.buf))) {
> +		if (infer_backlink(&backlink, realdotgit.buf)) {
>  			fn(1, realdotgit.buf, _("unable to locate repository; .git file does not reference a repository"), cb_data);
>  			goto done;
>  		}
>  	} else if (err) {
>  		fn(1, realdotgit.buf, _("unable to locate repository; .git file broken"), cb_data);
>  		goto done;
> +	} else if (git_conte
> nts) {

Another strange newline here. As I have talked about above, we should
not check "git_contents" here.

> +		strbuf_addstr(&backlink, git_contents);
>  	}
>  
> -	strbuf_addf(&gitdir, "%s/gitdir", backlink);
> +	strbuf_addf(&gitdir, "%s/gitdir", backlink.buf);
>  	if (strbuf_read_file(&olddotgit, gitdir.buf, 0) < 0)
>  		repair = _("gitdir unreadable");
>  	else {
> @@ -726,8 +727,9 @@ void repair_worktree_at_path(const char *path,
>  		write_file(gitdir.buf, "%s", realdotgit.buf);
>  	}
>  done:
> -	free(backlink);
> +	free(git_contents);
>  	strbuf_release(&olddotgit);
> +	strbuf_release(&backlink);
>  	strbuf_release(&gitdir);
>  	strbuf_release(&realdotgit);
>  	strbuf_release(&dotgit);
> -- 
> 2.46.2
> 

Thanks,
Jialuo
