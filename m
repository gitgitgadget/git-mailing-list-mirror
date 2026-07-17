Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFF33F8886
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 15:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784300427; cv=none; b=tdLvISSlvA3Sms3LALZUuBXhANO8S86ri6pClekCzQ6QlSINy4AisZBD5tSa18EdtbliqA4XDJkUlJG+rce0zjRbuh3rtzHLvPYRKdG4g1Yx+p+ZCK+WNkJGuDesPs9sczp0COOkLLEJM3ni63HFKB3eQCoKvXg/g3CMeTLrgYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784300427; c=relaxed/simple;
	bh=MgkUMF/EaGY/qT40emJCPtUBwBzsYiwUlrmVJINiD7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F1F4T1kzFdiI3rHOaYEUZpuzo0sGl4EHK41K2bYfCAse46EY6OngYZFSLqn0Pz/i40PYatFcHEjidVROisclUglo92juAmOI6OXVmeQehIM2svWq+XVUQ3Zis86A4lHteqxXLrM9n3tHN6T/KukT9PdpSFVrHGc0QiEBPTQt6J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gwhWsKX4; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwhWsKX4"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c15ba5b151dso615209766b.3
        for <git@vger.kernel.org>; Fri, 17 Jul 2026 08:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784300419; x=1784905219; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PXjqYKUt2ZWlWAyUP5HJGXGL7RYMr9kVu+GIu4b5FLY=;
        b=gwhWsKX4Mgszh+IGDKvH9xyOPL2wGxPfgRHBtcggU33R6aSqvQ5NcsvS46FujfzkK3
         X2im3aG5Ab3rnm8eVWrSDzVEANZ/NrxS+JF2karqPiyjVYAJ81LEx70u0bZoH7L0DIDv
         AogZHiLz1vWaxNzCrSrNFoP1fNoC+yPL4krp1p1fzbMf+GBkkgYAuGBDXRaOoVJ52eqA
         Sd44g2GIrcm3+UKXYKigY5GUoKcxeOFmZdkC43VMps/fYPpurunS175df+5OL2D2a9yp
         gXvEd8mGa2wdjhb9Xy1AOZR0V63woJX838Zb7dHrcVVSwxOdNwDZv3+yq8jRC9L0vhWa
         PK/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784300419; x=1784905219;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PXjqYKUt2ZWlWAyUP5HJGXGL7RYMr9kVu+GIu4b5FLY=;
        b=Z8zYX8uKPZX5n6z0nMigyXmMQanf31dGu5iiZn29k3dckzG2BhaRcTyC6nhIpnux90
         hAp5jelPdFWgOEZDoQFc2VkAWiuZRiVxjsEGz2dMGpsOgl5Oiu7tqLuhjl8TF0i743td
         vKKlVgYThELAjkEUm1LHjwqN0x29jPUk0atoM4gkdCzAo93Q8HawrsdsYMcu/M3uA4j7
         TK09WCcRj+IuiRjyHYuuoEDhs4dQ7MpGYt/QxITwRJObcuy7Apv/R75KExrK7B9kdQYg
         yLoTR6WwaCqF0OsgHvS8/Ab3IsjqsqynWCMvH8BRN+G4HPGa7eOkXejvvWDQV3ZjCrFe
         /oFw==
X-Forwarded-Encrypted: i=1; AHgh+RqCBqoFzH+MXZG+KkMZxjB+eBxTwKeiAh/Sq/Qwzq6b/bPnJxlrjh5U8z7U79UgiKaAUsA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2dWfKYlFxvp98yY/aYHKtiA4Uh4PWAQrlYhTFPajbl6iKwFnl
	DAw2KvSANzUK1YhGl5vNPx0pdpYpEeixnQXpNdIK75TfIC8HNwyC3N2XZCqmLw==
X-Gm-Gg: AfdE7cmLe4e8C4XLNOPavXMJrgRn3QQgngvYPmhnMYS5yoQcqp5fyGy31VgbcK0HsBE
	NzUDUTFZj64+RMcpG5DMobyA9oXZ+M3XryiVpWARVPadGPOHj5fx5CKv2FX92XOk3wEyPZChUsE
	lY7PGW9jO6V1BSXKz2pjb+od6bmQ4SspB3e6+A/PWc/8I754O4Fes7LNJHH/p2f/Znk9uhXaTx3
	Nx3a2+quJ4f84iCp3nW8IATUzYMKfrSYS+4s0Lta6pJgj9lkDDDED+PnNhjsLXJWBmKOFa9hvJj
	yyjNXBVjMcwTOj9Uiw1Kj9HAVg5U3EnQgVLSTHyz91wqYZvd+6LJhJs6qmPPVFodFQ99QXJD2zv
	W8oQUzgP5KSNshQeYeapZ8X3OMnNw0LFvKKJ2GouQUe6fcliQRhDTZOTe0zij6zsjtA8A69jXHb
	VMXgOBH/kRs/6BU3NUVo8k87JCQWzCftT4qiDkNqPfkfeAUqZVlbcsG9sQ
X-Received: by 2002:a17:907:9727:b0:c16:67d8:7a0f with SMTP id a640c23a62f3a-c16b46ef15emr124183566b.28.1784300418304;
        Fri, 17 Jul 2026 08:00:18 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d? ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1712a5fa2fsm88212066b.31.2026.07.17.08.00.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2026 08:00:17 -0700 (PDT)
Message-ID: <b0df688a-3b26-48f6-8b1c-98530483885e@gmail.com>
Date: Fri, 17 Jul 2026 16:00:15 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] copy: drop dependency on `the_repository`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20260716-pks-copy-wo-the-repository-v1-1-8f1e078bb82f@pks.im>
 <20260716-pks-copy-wo-the-repository-v2-1-8f5e32942929@pks.im>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20260716-pks-copy-wo-the-repository-v2-1-8f5e32942929@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

This version looks good to me

Thanks

Phillip

On 16/07/2026 16:28, Patrick Steinhardt wrote:
> When copying a file we need to potentially adapt permissions of the new
> file based on whether or not "core.shared" is enabled. Parsing this
> configuration makes us implicitly depend on `the_repository`.
> 
> Refactor the code to instead require the caller to pass in a repository
> so that we can remove `USE_THE_REPOSITORY_VARIABLE`.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> Hi,
> 
> I guess the title says it all: this small patch removes the dependency
> on `the_repository` in "copy.c". Thanks!
> 
> Changes in v2:
>    - Adapt a couple more sites to use a repository from the context.
>    - Link to v1: https://patch.msgid.link/20260716-pks-copy-wo-the-repository-v1-1-8f1e078bb82f@pks.im
> 
> Patrick
> ---
>   builtin/clone.c      |  2 +-
>   builtin/difftool.c   |  4 ++--
>   builtin/worktree.c   |  4 ++--
>   bundle-uri.c         |  2 +-
>   copy.c               | 12 ++++++------
>   copy.h               |  8 ++++++--
>   refs/files-backend.c |  2 +-
>   rerere.c             |  2 +-
>   sequencer.c          |  6 +++---
>   setup.c              |  2 +-
>   10 files changed, 24 insertions(+), 20 deletions(-)
> 
> diff --git a/builtin/clone.c b/builtin/clone.c
> index d60d1b60bc..18603dd4ce 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -335,7 +335,7 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
>   				die_errno(_("failed to create link '%s'"), dest->buf);
>   			option_no_hardlinks = 1;
>   		}
> -		if (copy_file_with_time(dest->buf, src->buf, 0666))
> +		if (copy_file_with_time(the_repository, dest->buf, src->buf, 0666))
>   			die_errno(_("failed to copy file to '%s'"), dest->buf);
>   	}
>   
> diff --git a/builtin/difftool.c b/builtin/difftool.c
> index 26778f8515..5e7777fbe4 100644
> --- a/builtin/difftool.c
> +++ b/builtin/difftool.c
> @@ -552,7 +552,7 @@ static int run_dir_diff(struct repository *repo,
>   					struct stat st;
>   					if (stat(wtdir.buf, &st))
>   						st.st_mode = 0644;
> -					if (copy_file(rdir.buf, wtdir.buf,
> +					if (copy_file(repo, rdir.buf, wtdir.buf,
>   						      st.st_mode)) {
>   						ret = error("could not copy '%s' to '%s'", wtdir.buf, rdir.buf);
>   						goto finish;
> @@ -658,7 +658,7 @@ static int run_dir_diff(struct repository *repo,
>   				warning("%s", "");
>   				err = 1;
>   			} else if (unlink(wtdir.buf) ||
> -				   copy_file(wtdir.buf, rdir.buf, st.st_mode))
> +				   copy_file(repo, wtdir.buf, rdir.buf, st.st_mode))
>   				warning_errno(_("could not copy '%s' to '%s'"),
>   					      rdir.buf, wtdir.buf);
>   		}
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index d21c43fde3..84b01960fb 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -349,7 +349,7 @@ static void copy_sparse_checkout(const char *worktree_git_dir)
>   
>   	if (file_exists(from_file)) {
>   		if (safe_create_leading_directories(the_repository, to_file) ||
> -			copy_file(to_file, from_file, 0666))
> +			copy_file(the_repository, to_file, from_file, 0666))
>   			error(_("failed to copy '%s' to '%s'; sparse-checkout may not work correctly"),
>   				from_file, to_file);
>   	}
> @@ -368,7 +368,7 @@ static void copy_filtered_worktree_config(const char *worktree_git_dir)
>   		int bare;
>   
>   		if (safe_create_leading_directories(the_repository, to_file) ||
> -			copy_file(to_file, from_file, 0666)) {
> +			copy_file(the_repository, to_file, from_file, 0666)) {
>   			error(_("failed to copy worktree config from '%s' to '%s'"),
>   				from_file, to_file);
>   			goto worktree_copy_cleanup;
> diff --git a/bundle-uri.c b/bundle-uri.c
> index 3b2e347288..ef37aebf30 100644
> --- a/bundle-uri.c
> +++ b/bundle-uri.c
> @@ -396,7 +396,7 @@ static int copy_uri_to_file(const char *filename, const char *uri)
>   		uri = out;
>   
>   	/* Copy as a file */
> -	return copy_file(filename, uri, 0);
> +	return copy_file(the_repository, filename, uri, 0);
>   }
>   
>   static int unbundle_from_file(struct repository *r, const char *file)
> diff --git a/copy.c b/copy.c
> index b668209b6c..6074132050 100644
> --- a/copy.c
> +++ b/copy.c
> @@ -1,5 +1,3 @@
> -#define USE_THE_REPOSITORY_VARIABLE
> -
>   #include "git-compat-util.h"
>   #include "copy.h"
>   #include "path.h"
> @@ -35,7 +33,8 @@ static int copy_times(const char *dst, const char *src)
>   	return 0;
>   }
>   
> -int copy_file(const char *dst, const char *src, int mode)
> +int copy_file(struct repository *repo,
> +	      const char *dst, const char *src, int mode)
>   {
>   	int fdi, fdo, status;
>   
> @@ -59,15 +58,16 @@ int copy_file(const char *dst, const char *src, int mode)
>   	if (close(fdo) != 0)
>   		return error_errno("%s: close error", dst);
>   
> -	if (!status && adjust_shared_perm(the_repository, dst))
> +	if (!status && adjust_shared_perm(repo, dst))
>   		return -1;
>   
>   	return status;
>   }
>   
> -int copy_file_with_time(const char *dst, const char *src, int mode)
> +int copy_file_with_time(struct repository *repo,
> +			const char *dst, const char *src, int mode)
>   {
> -	int status = copy_file(dst, src, mode);
> +	int status = copy_file(repo, dst, src, mode);
>   	if (!status)
>   		return copy_times(dst, src);
>   	return status;
> diff --git a/copy.h b/copy.h
> index 2af77cba86..1059b118d6 100644
> --- a/copy.h
> +++ b/copy.h
> @@ -1,10 +1,14 @@
>   #ifndef COPY_H
>   #define COPY_H
>   
> +struct repository;
> +
>   #define COPY_READ_ERROR (-2)
>   #define COPY_WRITE_ERROR (-3)
>   int copy_fd(int ifd, int ofd);
> -int copy_file(const char *dst, const char *src, int mode);
> -int copy_file_with_time(const char *dst, const char *src, int mode);
> +int copy_file(struct repository *repo,
> +	      const char *dst, const char *src, int mode);
> +int copy_file_with_time(struct repository *repo,
> +			const char *dst, const char *src, int mode);
>   
>   #endif /* COPY_H */
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 3df56c25c8..442c98414e 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -1736,7 +1736,7 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
>   		goto out;
>   	}
>   
> -	if (copy && log && copy_file(tmp_renamed_log.buf, sb_oldref.buf, 0644)) {
> +	if (copy && log && copy_file(refs->base.repo, tmp_renamed_log.buf, sb_oldref.buf, 0644)) {
>   		ret = error("unable to copy logfile logs/%s to logs/"TMP_RENAMED_LOG": %s",
>   			    oldrefname, strerror(errno));
>   		goto out;
> diff --git a/rerere.c b/rerere.c
> index 8232542585..bf5cfc6e51 100644
> --- a/rerere.c
> +++ b/rerere.c
> @@ -756,7 +756,7 @@ static void do_rerere_one_path(struct index_state *istate,
>   	/* Has the user resolved it already? */
>   	if (variant >= 0) {
>   		if (!handle_file(istate, path, NULL, NULL)) {
> -			copy_file(rerere_path(&buf, id, "postimage"), path, 0666);
> +			copy_file(the_repository, rerere_path(&buf, id, "postimage"), path, 0666);
>   			id->collection->status[variant] |= RR_HAS_POSTIMAGE;
>   			fprintf_ln(stderr, _("Recorded resolution for '%s'."), path);
>   			free_rerere_id(rr_item);
> diff --git a/sequencer.c b/sequencer.c
> index 1355a99a09..63bc1ef215 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2419,7 +2419,7 @@ static int do_pick_commit(struct repository *r,
>   		} else {
>   			const char *dest = git_path_squash_msg(r);
>   			unlink(dest);
> -			if (copy_file(dest, rebase_path_squash_msg(), 0666)) {
> +			if (copy_file(r, dest, rebase_path_squash_msg(), 0666)) {
>   				res = error(_("could not copy '%s' to '%s'"),
>   					    rebase_path_squash_msg(), dest);
>   				goto leave;
> @@ -3864,11 +3864,11 @@ static int error_failed_squash(struct repository *r,
>   			       int subject_len,
>   			       const char *subject)
>   {
> -	if (copy_file(rebase_path_message(), rebase_path_squash_msg(), 0666))
> +	if (copy_file(r, rebase_path_message(), rebase_path_squash_msg(), 0666))
>   		return error(_("could not copy '%s' to '%s'"),
>   			rebase_path_squash_msg(), rebase_path_message());
>   	unlink(git_path_merge_msg(r));
> -	if (copy_file(git_path_merge_msg(r), rebase_path_message(), 0666))
> +	if (copy_file(r, git_path_merge_msg(r), rebase_path_message(), 0666))
>   		return error(_("could not copy '%s' to '%s'"),
>   			     rebase_path_message(),
>   			     git_path_merge_msg(r));
> diff --git a/setup.c b/setup.c
> index 0de56a074f..91d61a5939 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -2331,7 +2331,7 @@ static void copy_templates_1(struct repository *repo,
>   			strbuf_release(&lnk);
>   		}
>   		else if (S_ISREG(st_template.st_mode)) {
> -			if (copy_file(path->buf, template_path->buf, st_template.st_mode))
> +			if (copy_file(repo, path->buf, template_path->buf, st_template.st_mode))
>   				die_errno(_("cannot copy '%s' to '%s'"),
>   					  template_path->buf, path->buf);
>   		}
> 
> ---
> base-commit: d35c5399e3e54ac277bb391fc2f6be3e816d312b
> change-id: 20260716-pks-copy-wo-the-repository-aa01ccdbed76
> 
> 

