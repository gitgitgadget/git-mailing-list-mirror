Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9021A13E41D
	for <git@vger.kernel.org>; Thu, 18 Jul 2024 14:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721313103; cv=none; b=qTFPJEij6984wk2VwDETR+Sx9Ha6WmYOnGJ6OtK8UFxK6dU3XNuEN2C7tz8nUlU9cdr+F/l70RVSIDsJqLt/KifZTnpyywI7Xl98NkCKtZVwgcRSBP6lwfSoSV8obIIDfbPIyjM4U2GMY7y9GzQm8oiUCKwkOdQLjX2E5IwlBnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721313103; c=relaxed/simple;
	bh=/xHCjJS8BpOjSoPLrmmvXTKSazWTXSHFwJe0WnFSA0M=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Srb1TJGdbN1UrM+5k6LovPb9vPa2frAD+cNG9+MnNIsWCxF23+WyyazJ8TwguqU661c3Y+i3TKzzektR9Lii7EqBvtdrysIUc9o9r5XeuZ8Fpmk+IjUas50orXO7mU0ZeMbCghn3tBlgxoU8zRxDGO97SsYFF9GUrP+rRliPwcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PMZbW61L; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMZbW61L"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-25e3d8d9f70so415286fac.2
        for <git@vger.kernel.org>; Thu, 18 Jul 2024 07:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721313100; x=1721917900; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=kwwu5AbLwElyFjJCsiauSfCAFZ4Aa8N7KH1R9Fj1Ll8=;
        b=PMZbW61LY9+qI6lolEaDhzhgPPXxojvpnjnda2sOp6NCKhUqrJFGYGq7oY6o67+6uB
         704dEs5s9mQqwgBIF6aTO31SMF/9oxRiU7P9FEee5d5RLlfQ5K+w7yMhraGHFKGhED/8
         YZyskd8Ce0Wik5NG2FnsRV2TZ8rMQBc0CWs8NQdTZZQLdTsix7WElbYS0yNnpmUk6Qjs
         u6zixJ806xeSfOaZvHGLpg/UO7WylgYfnwvKiTxIeCOf1/ErCIzCRlnPPeTqoFWJqHs0
         K0s2m+zclEy7QFFALW46hdDb9EQcucnY7eEieHc95uD/2npCqV0nzvJBTvwIA/7r2n1c
         XrIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721313100; x=1721917900;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kwwu5AbLwElyFjJCsiauSfCAFZ4Aa8N7KH1R9Fj1Ll8=;
        b=Yibn35Vz6zV4+YFXXX5EvxYbWd0nsoweW4t2+D07SHTcaER4sCi2Kq7GQxPdKgh+Na
         beN7Ng6AoPXK4ujEHn0kyzsUbqkIGwHiD5CsZj6AyF1hj3HXrz4iA3QW3U44BW+g6321
         8GXQN8mW4dxNxTqoSjDTh7mGBUaansdvF+VE+JBhg4z8XqCNt8V76DRPlwde7f6TZkkK
         +4gS5x4nFkQh2rhZdXIXd8ySC9ZE50wnDKC4IHascia0mv4FnRE9g2a52WntQlSP1Azi
         QejJc/KIO/beEatRXJrCSCFB+8lygeqcQ3Rdw4U64kVMN524RUuDyA03Dx6sQPWo4Jcp
         B6ZA==
X-Forwarded-Encrypted: i=1; AJvYcCUAazJKUq5E9q8s5itAWh/AHQJJ/uoIap7f8HEd0Wp6ptXmVxy4pkrQc1heo+xXhc3fCiI6k3HCSERQQEorGlPkaaYY
X-Gm-Message-State: AOJu0Yxhdn+qLpU2ErMqVoAuMxechA+rrk06l3StESWJAH++37MSiQVc
	JaXOmM6f/UQU917wjjcdZ0hwvaZePR0ZJx68b6amWVeghV+VZfcIz8URhaeWG19aNNWsclitFWN
	LADFancT+kRNUKdmGuDrkIzVP2xkE7u3U
X-Google-Smtp-Source: AGHT+IFMJg/V3DrdqoVZG4OjpW8Ta5nNHok9xajrZ2JBNu+07pssrDzaO0/PG75wwmzb9l11bCG0rwC75l1QceSZpa0=
X-Received: by 2002:a05:6870:220f:b0:24c:59f7:e840 with SMTP id
 586e51a60fabf-260d902b6ecmr3823428fac.17.1721313100461; Thu, 18 Jul 2024
 07:31:40 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 18 Jul 2024 07:31:38 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <ZpPFbYOqDVWKz0ic@ArchLinux>
References: <ZpPEdmUN1Z5tqbK3@ArchLinux> <ZpPFbYOqDVWKz0ic@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 18 Jul 2024 07:31:38 -0700
Message-ID: <CAOLa=ZRYoYfY-P-dzpYbz0Yq44_TYGyJamf1hufJ0fxGZb3Z0Q@mail.gmail.com>
Subject: Re: [GSoC][PATCH v11 10/10] fsck: add ref content check for files backend
To: shejialuo <shejialuo@gmail.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, 
	Eric Sunshine <sunshine@sunshineco.com>, Justin Tobler <jltobler@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000e69389061d866f2d"

--000000000000e69389061d866f2d
Content-Type: text/plain; charset="UTF-8"

shejialuo <shejialuo@gmail.com> writes:

> Enhance the git-fsck(1) command by adding a check for reference content
> in the files backend. The new functionality ensures that symrefs, real
> symbolic link and regular refs are validated correctly.
>
> In order to check the trailing content of the regular refs, add a new
> parameter `trailing` to `parse_loose_ref_contents`.
>
> For symrefs, `parse_loose_ref_contents` will set the "referent".
> However, symbolic link could be either absolute or relative. Use
> "strbuf_add_real_path" to read the symbolic link and convert the
> relative path to absolute path. Then use "skip_prefix" to make it align
> with symref "referent".
>
> Thus, the symrefs and symbolic links could share the same interface. Add
> a new function "files_fsck_symref_target" which aims at checking the
> following things:
>
> 1. whether the pointee is under the `refs/` directory.
> 2. whether the pointee name is correct.
> 3. whether the pointee path is a wrong type in filesystem.
>
> Last, add the following FSCK MESSAGEs:
>
> 1. "badRefContent(ERROR)": A ref has a bad content
> 2. "badSymrefPointee(ERROR)": The pointee of a symref is bad.
> 3. "trailingRefContent(WARN)": A ref content has trailing contents.
>
> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> Signed-off-by: shejialuo <shejialuo@gmail.com>
> ---
>  Documentation/fsck-msgids.txt |   9 +++
>  fsck.h                        |   3 +
>  refs.c                        |   2 +-
>  refs/files-backend.c          | 145 +++++++++++++++++++++++++++++++++-
>  refs/refs-internal.h          |   5 +-
>  t/t0602-reffiles-fsck.sh      | 110 ++++++++++++++++++++++++++
>  6 files changed, 269 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/fsck-msgids.txt b/Documentation/fsck-msgids.txt
> index dab4012246..b1630a478b 100644
> --- a/Documentation/fsck-msgids.txt
> +++ b/Documentation/fsck-msgids.txt
> @@ -19,9 +19,15 @@
>  `badParentSha1`::
>  	(ERROR) A commit object has a bad parent sha1.
>
> +`badRefContent`::
> +	(ERROR) A ref has a bad content.
> +
>  `badRefName`::
>  	(ERROR) A ref has a bad name.
>
> +`badSymrefPointee`::
> +	(ERROR) The pointee of a symref is bad.
> +
>  `badTagName`::
>  	(INFO) A tag has an invalid format.
>
> @@ -167,6 +173,9 @@
>  `nullSha1`::
>  	(WARN) Tree contains entries pointing to a null sha1.
>
> +`trailingRefContent`::
> +	(WARN) A ref content has trailing contents.
> +
>  `treeNotSorted`::
>  	(ERROR) A tree is not properly sorted.
>
> diff --git a/fsck.h b/fsck.h
> index 2a2441e147..e92a5844ae 100644
> --- a/fsck.h
> +++ b/fsck.h
> @@ -32,6 +32,8 @@ enum fsck_msg_type {
>  	FUNC(BAD_OBJECT_SHA1, ERROR) \
>  	FUNC(BAD_PARENT_SHA1, ERROR) \
>  	FUNC(BAD_REF_NAME, ERROR) \
> +	FUNC(BAD_REF_CONTENT, ERROR) \
> +	FUNC(BAD_SYMREF_POINTEE, ERROR) \
>  	FUNC(BAD_TIMEZONE, ERROR) \
>  	FUNC(BAD_TREE, ERROR) \
>  	FUNC(BAD_TREE_SHA1, ERROR) \
> @@ -72,6 +74,7 @@ enum fsck_msg_type {
>  	FUNC(HAS_DOTDOT, WARN) \
>  	FUNC(HAS_DOTGIT, WARN) \
>  	FUNC(NULL_SHA1, WARN) \
> +	FUNC(TRAILING_REF_CONTENT, WARN) \
>  	FUNC(ZERO_PADDED_FILEMODE, WARN) \
>  	FUNC(NUL_IN_COMMIT, WARN) \
>  	FUNC(LARGE_PATHNAME, WARN) \
> diff --git a/refs.c b/refs.c
> index 410919246b..eb82fb7d4e 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1760,7 +1760,7 @@ static int refs_read_special_head(struct ref_store *ref_store,
>  	}
>
>  	result = parse_loose_ref_contents(content.buf, oid, referent, type,
> -					  failure_errno);
> +					  failure_errno, NULL);
>
>  done:
>  	strbuf_release(&full_path);
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index d20e149214..42d2f676b9 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -1,6 +1,7 @@
>  #define USE_THE_REPOSITORY_VARIABLE
>
>  #include "../git-compat-util.h"
> +#include "../abspath.h"
>  #include "../copy.h"
>  #include "../environment.h"
>  #include "../gettext.h"
> @@ -553,7 +554,7 @@ static int read_ref_internal(struct ref_store *ref_store, const char *refname,
>  	strbuf_rtrim(&sb_contents);
>  	buf = sb_contents.buf;
>
> -	ret = parse_loose_ref_contents(buf, oid, referent, type, &myerr);
> +	ret = parse_loose_ref_contents(buf, oid, referent, type, &myerr, NULL);
>
>  out:
>  	if (ret && !myerr)
> @@ -589,7 +590,7 @@ static int files_read_symbolic_ref(struct ref_store *ref_store, const char *refn
>
>  int parse_loose_ref_contents(const char *buf, struct object_id *oid,
>  			     struct strbuf *referent, unsigned int *type,
> -			     int *failure_errno)
> +			     int *failure_errno, const char **trailing)
>  {
>  	const char *p;
>  	if (skip_prefix(buf, "ref:", &buf)) {
> @@ -611,6 +612,10 @@ int parse_loose_ref_contents(const char *buf, struct object_id *oid,
>  		*failure_errno = EINVAL;
>  		return -1;
>  	}
> +
> +	if (trailing)
> +		*trailing = p;
> +
>  	return 0;
>  }
>
> @@ -3438,6 +3443,141 @@ static int files_fsck_refs_name(struct fsck_options *o,
>  	return ret;
>  }
>
> +/*
> + * Check the symref "pointee_name" and "pointee_path". The caller should
> + * make sure that "pointee_path" is absolute. For symbolic ref, "pointee_name"
> + * would be the content after "refs:". For symblic link, "pointee_name" would
> + * be the relative path agaignst "gitdir".
> + */
> +static int files_fsck_symref_target(struct fsck_options *o,
> +				    const char *refname,
> +				    const char *pointee_name,
> +				    const char *pointee_path)
> +{
> +	const char *p = NULL;
> +	struct stat st;
> +	int ret = 0;
> +
> +	if (!skip_prefix(pointee_name, "refs/", &p)) {
> +
> +		ret = fsck_refs_report(o, NULL, refname, NULL,
> +				       FSCK_MSG_BAD_SYMREF_POINTEE,
> +				       "point to target out of refs hierarchy");
> +		goto out;
> +	}
> +
> +	if (check_refname_format(pointee_name, 0)) {
> +		ret = fsck_refs_report(o, NULL, refname, NULL,
> +				       FSCK_MSG_BAD_SYMREF_POINTEE,
> +				       "point to invalid refname");
> +	}
> +
> +	if (lstat(pointee_path, &st) < 0)
> +		goto out;
> +
> +	if (!S_ISREG(st.st_mode) && !S_ISLNK(st.st_mode)) {
> +		ret = fsck_refs_report(o, NULL, refname, NULL,
> +				       FSCK_MSG_BAD_SYMREF_POINTEE,
> +				       "point to invalid target");
> +		goto out;
> +	}
> +out:
> +	return ret;
> +}
> +
> +static int files_fsck_refs_content(struct fsck_options *o,
> +				   const char *gitdir,
> +				   const char *refs_check_dir,
> +				   struct dir_iterator *iter)
> +{
> +	struct strbuf pointee_path = STRBUF_INIT,
> +		      ref_content = STRBUF_INIT,
> +		      abs_gitdir = STRBUF_INIT,
> +		      referent = STRBUF_INIT,
> +		      refname = STRBUF_INIT;
> +	const char *trailing = NULL;
> +	int failure_errno = 0;
> +	unsigned int type = 0;
> +	struct object_id oid;
> +	int ret = 0;
> +
> +	strbuf_addf(&refname, "%s/%s", refs_check_dir, iter->relative_path);
> +
> +	/*
> +	 * If the file is a symlink, we need to only check the connectivity
> +	 * of the destination object.
> +	 */
> +	if (S_ISLNK(iter->st.st_mode)) {
> +		const char *pointee_name = NULL;
> +
> +		strbuf_add_real_path(&pointee_path, iter->path.buf);
> +
> +		strbuf_add_absolute_path(&abs_gitdir, gitdir);
> +		strbuf_normalize_path(&abs_gitdir);
> +		if (!is_dir_sep(abs_gitdir.buf[abs_gitdir.len - 1]))
> +			strbuf_addch(&abs_gitdir, '/');
> +
> +		if (!skip_prefix(pointee_path.buf,
> +				 abs_gitdir.buf, &pointee_name)) {
> +			ret = fsck_refs_report(o, NULL, refname.buf, NULL,
> +					       FSCK_MSG_BAD_SYMREF_POINTEE,
> +					       "point to target outside gitdir");
> +			goto clean;
> +		}
> +
> +		ret = files_fsck_symref_target(o, refname.buf, pointee_name,
> +					       pointee_path.buf);
> +		goto clean;
> +	}
> +
> +	if (strbuf_read_file(&ref_content, iter->path.buf, 0) < 0) {
> +		ret = error_errno(_("%s/%s: unable to read the ref"),
> +				  refs_check_dir, iter->relative_path);
> +		goto clean;
> +	}
> +
> +	if (parse_loose_ref_contents(ref_content.buf, &oid,
> +				     &referent, &type,
> +				     &failure_errno, &trailing)) {
> +		ret = fsck_refs_report(o, NULL, refname.buf, NULL,
> +				       FSCK_MSG_BAD_REF_CONTENT,
> +				       "invalid ref content");
> +		goto clean;
> +	}
> +
> +	/*
> +	 * If the ref is a symref, we need to check the destination name and
> +	 * connectivity.
> +	 */
> +	if (referent.len && (type & REF_ISSYMREF)) {
> +		strbuf_addf(&pointee_path, "%s/%s", gitdir, referent.buf);
> +		strbuf_rtrim(&referent);
> +
> +		ret = files_fsck_symref_target(o, refname.buf, referent.buf,
> +					       pointee_path.buf);
> +		goto clean;
> +	} else {
> +		/*
> +		 * Only regular refs could have a trailing garbage. Should
> +		 * be reported as a warning.
> +		 */

What happens if a symbolic reference has trailing garbage ?

> +		if (trailing && (*trailing != '\0' && *trailing != '\n')) {
> +			ret = fsck_refs_report(o, NULL, refname.buf, NULL,
> +					       FSCK_MSG_TRAILING_REF_CONTENT,
> +					       "trailing garbage in ref");
> +			goto clean;
> +		}
> +	}
> +
> +clean:
> +	strbuf_release(&abs_gitdir);
> +	strbuf_release(&pointee_path);
> +	strbuf_release(&refname);
> +	strbuf_release(&ref_content);
> +	strbuf_release(&referent);
> +	return ret;
> +}
> +
>  static int files_fsck_refs_dir(struct ref_store *ref_store,
>  			       struct fsck_options *o,
>  			       const char *refs_check_dir,
> @@ -3490,6 +3630,7 @@ static int files_fsck_refs(struct ref_store *ref_store,
>  	int ret;
>  	files_fsck_refs_fn fsck_refs_fns[]= {
>  		files_fsck_refs_name,
> +		files_fsck_refs_content,
>  		NULL
>  	};
>
> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
> index a905e187cd..2fabf41d14 100644
> --- a/refs/refs-internal.h
> +++ b/refs/refs-internal.h
> @@ -709,11 +709,12 @@ struct ref_store {
>
>  /*
>   * Parse contents of a loose ref file. *failure_errno maybe be set to EINVAL for
> - * invalid contents.
> + * invalid contents. Also *trailing is set to the first character after the
> + * refname or NULL if the referent is not empty.
>   */
>  int parse_loose_ref_contents(const char *buf, struct object_id *oid,
>  			     struct strbuf *referent, unsigned int *type,
> -			     int *failure_errno);
> +			     int *failure_errno, const char **trailing);
>
>  /*
>   * Fill in the generic part of refs and add it to our collection of
> diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
> index b2db58d2c6..35bf40ee64 100755
> --- a/t/t0602-reffiles-fsck.sh
> +++ b/t/t0602-reffiles-fsck.sh
> @@ -98,4 +98,114 @@ test_expect_success 'ref name check should be adapted into fsck messages' '
>  	)
>  '
>
> +test_expect_success 'regular ref content should be checked' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	branch_dir_prefix=.git/refs/heads &&
> +	tag_dir_prefix=.git/refs/tags &&
> +	(
> +		cd repo &&
> +		git commit --allow-empty -m initial &&
> +		git checkout -b branch-1 &&
> +		git tag tag-1 &&
> +		git commit --allow-empty -m second &&
> +		git checkout -b branch-2 &&
> +		git tag tag-2 &&
> +		git checkout -b a/b/tag-2
> +	) &&
> +	(
> +		cd repo &&
> +		printf "%s garbage" "$(git rev-parse branch-1)" > $branch_dir_prefix/branch-1-garbage &&
> +		git fsck 2>err &&
> +		cat >expect <<-EOF &&
> +		warning: refs/heads/branch-1-garbage: trailingRefContent: trailing garbage in ref
> +		EOF
> +		rm $branch_dir_prefix/branch-1-garbage &&
> +		test_cmp expect err
> +	) &&
> +	(
> +		cd repo &&
> +		printf "%s garbage" "$(git rev-parse tag-1)" > $tag_dir_prefix/tag-1-garbage &&
> +		test_must_fail git -c fsck.trailingRefContent=error fsck 2>err &&
> +		cat >expect <<-EOF &&
> +		error: refs/tags/tag-1-garbage: trailingRefContent: trailing garbage in ref
> +		EOF
> +		rm $tag_dir_prefix/tag-1-garbage &&
> +		test_cmp expect err
> +	) &&
> +	(
> +		cd repo &&
> +		printf "%s    " "$(git rev-parse tag-2)" > $tag_dir_prefix/tag-2-garbage &&
> +		git fsck 2>err &&
> +		cat >expect <<-EOF &&
> +		warning: refs/tags/tag-2-garbage: trailingRefContent: trailing garbage in ref
> +		EOF
> +		rm $tag_dir_prefix/tag-2-garbage &&
> +		test_cmp expect err
> +	) &&
> +	(
> +		cd repo &&
> +		printf "xfsazqfxcadas" > $tag_dir_prefix/tag-2-bad &&
> +		test_must_fail git refs verify 2>err &&
> +		cat >expect <<-EOF &&
> +		error: refs/tags/tag-2-bad: badRefContent: invalid ref content
> +		EOF
> +		rm $tag_dir_prefix/tag-2-bad &&
> +		test_cmp expect err
> +	) &&
> +	(
> +		cd repo &&
> +		printf "xfsazqfxcadas" > $branch_dir_prefix/a/b/branch-2-bad &&
> +		test_must_fail git refs verify 2>err &&
> +		cat >expect <<-EOF &&
> +		error: refs/heads/a/b/branch-2-bad: badRefContent: invalid ref content
> +		EOF
> +		rm $branch_dir_prefix/a/b/branch-2-bad &&
> +		test_cmp expect err
> +	)
> +'
> +
> +test_expect_success 'symbolic ref content should be checked' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	branch_dir_prefix=.git/refs/heads &&
> +	tag_dir_prefix=.git/refs/tags &&
> +	(
> +		cd repo &&
> +		git commit --allow-empty -m initial &&
> +		git checkout -b branch-1 &&
> +		git tag tag-1
> +	) &&
> +	(
> +		cd repo &&
> +		printf "ref: refs/heads/.branch" > $branch_dir_prefix/branch-2-bad &&
> +		test_must_fail git refs verify 2>err &&
> +		cat >expect <<-EOF &&
> +		error: refs/heads/branch-2-bad: badSymrefPointee: point to invalid refname
> +		EOF
> +		rm $branch_dir_prefix/branch-2-bad &&
> +		test_cmp expect err
> +	) &&
> +	(
> +		cd repo &&
> +		printf "ref: refs/heads" > $branch_dir_prefix/branch-2-bad &&
> +		test_must_fail git refs verify 2>err &&
> +		cat >expect <<-EOF &&
> +		error: refs/heads/branch-2-bad: badSymrefPointee: point to invalid target
> +		EOF
> +		rm $branch_dir_prefix/branch-2-bad &&
> +		test_cmp expect err
> +	) &&
> +	(
> +		cd repo &&
> +		printf "ref: logs/maint-v2.45" > $branch_dir_prefix/branch-2-bad &&
> +		test_must_fail git refs verify 2>err &&
> +		cat >expect <<-EOF &&
> +		error: refs/heads/branch-2-bad: badSymrefPointee: point to target out of refs hierarchy
> +		EOF
> +		rm $branch_dir_prefix/branch-2-bad &&
> +		test_cmp expect err
> +	)
> +'
> +
>  test_done
> --
> 2.45.2

--000000000000e69389061d866f2d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 3d73381e5d7d5cf7_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hWkowZ1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK2t5Qy85alZUN2JyTVZwMnZvU0NjdGQ2YWhWQkdVaQpLalNtLzNoMS8x
cDVjR29NbU9aOVFRWTFVeGZ3aXVraEcyWm8yQnkvOUxhcGd6ZTYyUmx5akQ5MWhkNWkzVW4vCnJi
NTdTa3J1L2xDV0JpZ1N1NjJWTFRLWEliV2RNUlBmbVEyZDhxc2Fia3huaWR3dXJZdjEwMy9lUDlt
ellwUTkKaU9TdklkODZ5bkMrQ0hDb21vd3Rod201a2tCR1FPc3pKQ0R6bXF3UUxPQzQ1dC8vRDJC
S3BjcWJlWHBteW9STQpYb0pxdThQZnlxWnRrQWJNVytoV0hGeUZhV1ZWem1yZXp4UzhYSXVFL1Bw
NmszbWVGWDhzdUJxd1ZRa0N2TmdQCnZKOWFvTnc4eXF4ZlY1dDlFOTRWaGZneWpXc3VwSUxrNGpl
OGZxbEc4c3daalArWUNEczBqNzRiUWRqWERhZm8KRmJpZmxiSkwxMjJsT2JFSCtFUXZQbnZjY0xL
WndZNEFHNW1RK0ZUUlBZdzAvQURhV3lHY1VDTzI2R3hUdlBUcgpDQVZ0Q1p4eThLeFdSb0VuYXA2
bXNTOXMrbVdxTWxNRTZVdFQvbjRSK0w3TXk5QnNmUE5HNVZUTHN1Zzl2ekFkCmtKelk2elRRTXo5
ek1TWGl5bW1XalhCWHBpRVBGWnpwSWJOVW9Odz0KPVlYbDEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000e69389061d866f2d--
