Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4936218EB1
	for <git@vger.kernel.org>; Sun, 22 Feb 2026 16:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771779219; cv=pass; b=ud7UJOZwqQdW8K6RSEVZshROyIGbxeQsnPEJieJ3yY7kZ87imuc5GuJwvr5bPkVheK03K1nuuSv6NgfB2F+/LIizHLebRDP/Jpq3ErsxWqNBmfXzj4HFoH3wnX+uctgSqBNygnmy357EYBZ1N/EgXzh2PYv8G6yQqplwc+5S7dI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771779219; c=relaxed/simple;
	bh=uU2haT0nz1qz3Cw3y/SnmZJbjJIRMawgfMxp5OSRNWE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hbH193Xn7Nafmit7VeCDZY1OCVxlD0S1IL+XyAYZY+Bqr+vFk0xFaEz+Q4ACMyCKz/QZP40KSDQCouxudDIchfgMCAjf3CeQtqE40pU2KEHifx9yTJdkFWkL2h0Qq2lFXAIc/NI9Z7Z1PfJc0ZpWfZa1BBeAT6c9ym3ZUBXahxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aAOdx7OU; arc=pass smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aAOdx7OU"
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-5fe086fb0bcso788658137.0
        for <git@vger.kernel.org>; Sun, 22 Feb 2026 08:53:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771779217; cv=none;
        d=google.com; s=arc-20240605;
        b=U99W4mHFPTQET0cZ+tusyDzN3QhjLXb9vTO0VywQ7bZngMF2mUWLCLK/1Up61pIF/y
         R1nFMNKzjT944AfJL7KMHE9cK2NyiL1pZrudWkFmqAkzvu0zQISZres/nmzdFyN6GFbb
         vSKh6MyEXE+WrBwPwwFgxNLAvETOixfStnydk/gpA+ABq7xA5sDp170CFG0D125zj8HW
         I4EI81PPmTUY7opx2HVcKzL9sgRueVeVjxxf49rcffYX4DhfJmFZraRvgE8FuZQYaUg8
         hVyH3CR3wZRs6gxwONzIWZ/jJJw4b0gtE2z9+CZDc0Uo62c4BSceZ4XqrNJHcQsBTeqO
         vGWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=KrN4VyvxT/CLdo9JocJ+lks14LrP5gN/hmakNDlYvL0=;
        fh=XyaGUtcDhFWBZbdQIlSyBAhtbvUqmEub5GO2V47ylgo=;
        b=ABg39j0h0CFKgHnlqLWkgxutejlLzDdo1rQDHHd6okatwveGVvfc/mf4crl6cFspXg
         H/J7JplhJ+LWMbw2e3SEoDIOKYqpWHjHrrW93FAx8/XDLXZkgUxO4v7Ma5wSuTHS/m43
         bREb9p4jb7i3RhjQd6EHICo0eIDEXCMQ8d4r4RwauY/d1e5keqiw9YgZkb2iYk4vvyGH
         HBIf9l8E5LiZUcLJYxRc+3jRaK0Kv+7/Cc/2E5qXxJYDe3mimtfcNbLiMMHcN0E5Yq3Z
         5WElyVHs5c03WSgIBG8AZ44MzAuNIgScMXcM4Cujzm88JF4WShAVTWwnNsgqSRpH6ww1
         nSIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771779217; x=1772384017; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=KrN4VyvxT/CLdo9JocJ+lks14LrP5gN/hmakNDlYvL0=;
        b=aAOdx7OUJ2r2xG1UuNIFpdsDWjFUuJ7Xp1z6tiTEQ19U3b6ty55Epg5rj2ids4xIqA
         LlUtz//JDfIOSsfhE0B7HkwN+qBQ4MUI66eV9f8B2jCGDEOSkaI2g+bGqg5Wxk69TEJa
         +sTPvbAxGyCjzIJWv3ekj6MU+x/xlZkcTmYubQh0Dwm/NY5mh6etcSSockxLGKKgYZXP
         CpdyA4mpTHIGTI5UkB6Vv/ItXOMBa2170xzhQzU5VPChSIazrZiI/xoteiZ2o3rM21Nc
         wZq0nvmMtF3y+GAPLqc4amPEOqHLwsZhant7J19/I83O99azfCA50DX+vBd+HzyO4Q/C
         DpsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771779217; x=1772384017;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KrN4VyvxT/CLdo9JocJ+lks14LrP5gN/hmakNDlYvL0=;
        b=pVHz51kBNfCgvb+6f5zKp4QGqzkTwXqQJH4R40g+BvU/fRJJmSh5MzWKBVqEVlyqfP
         7TP3PyzZroB4/HTw1TGmDUWPj2Ii5MCEYblrnTRarKnd+t0HKWM3ixzaI2xdRtH7KuRK
         9Tk/iH6rb67i+FuLuf11Pi9OMIGp/29h+1R/RfCwekiRwyL0uPypn4lxSX9Nsg0D0gP3
         v9y4vJv/tGmYP25rOp4FSyDGxnObiW0Be+BfRRxYrFjMCyMdNT+X+J/WUcGlk7PY9721
         c7pkgQ2sLf2Dqb7V7tSJtkcPUYyINw8/7/excxKbw/3/9OENfrPRC9mQ5a35LvYQj4Qq
         GTjA==
X-Forwarded-Encrypted: i=1; AJvYcCXOy3L3sHlPvkE10giSIwwnE3xpdzv97AEbij/Aeoyp56wKSOu+2ZxUrymo/HTP1WLMPsI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6hMZh+aSnBXn0jzOk1yhXwTVwqQP0jxzVjsL3IvLoacqzSvmG
	OIbKqjW8tHSKd04lTEjLHYnj1lgC3wmKT8H3Ndsak/93XLBLXwWkbivmZ2twPCAxQQtY0LSo34L
	d7WAA1epdqQKOBQbc56mZx8Mhr19Zf5Y=
X-Gm-Gg: AZuq6aIU3huMGNXzCO6hRjfwMVOssZUP3xoAjmBu7U9dXWWORSyeqf3tlNrtENlwRkW
	WB66eAfRPvkbkfcpgFjUJfERsfqj0Wr1Tpa3EPDFOWzxpZ9XfW1mp9o2MH33u7HbMfQi/3kjXW+
	0n0hASQchk5fZSxcCpO39N2PtP8JTqhtRZerE0GY0xPu+2BI3nwsDq8A4RayuOW4a5fbluYbVNv
	IYDh1bRs92Cwsmm+pHHVOlPdIusvfdFXsd36GmmpGrFg12XxclnDCHPnE0LzEj2wtivvbQkvWNm
	ZDkH8yl7h+QYGwuYSl6b7X25QoMR+AkEvjXeEv0=
X-Received: by 2002:a05:6102:e11:b0:5fd:ef66:2466 with SMTP id
 ada2fe7eead31-5feb307185bmr1995159137.22.1771779216679; Sun, 22 Feb 2026
 08:53:36 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 22 Feb 2026 11:53:35 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 22 Feb 2026 11:53:35 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260222102928.377519-1-a3205153416@gmail.com>
References: <20260221083001.220061-1-a3205153416@gmail.com> <20260222102928.377519-1-a3205153416@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 22 Feb 2026 11:53:35 -0500
X-Gm-Features: AaiRm51nIa2dAA3xGmyRNCg6tNzSh8v3yQYMSeEppka6wEYbVHA0x2_JENTM7GM
Message-ID: <CAOLa=ZTePRR05M5VBxxk0OA=_RyNd0pLe=Bq6xwnE3MyZBjBAw@mail.gmail.com>
Subject: Re: [PATCH v10] setup: improve error diagnosis for invalid .git files
To: Tian Yuchen <a3205153416@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com
Content-Type: multipart/mixed; boundary="000000000000d4d8f9064b6c7e33"

--000000000000d4d8f9064b6c7e33
Content-Type: text/plain; charset="UTF-8"

Tian Yuchen <a3205153416@gmail.com> writes:

> 'read_gitfile_gently()' treats any non-regular file as
> 'READ_GITFILE_ERR_NOT_A_FILE' and fails to discern between 'ENOENT'
> and other stat failures. This flawed error reporting is noted by two
> 'NEEDSWORK' comments.

Okay.

> Address these comments by introducing two new error codes:
> 'READ_GITFILE_ERR_STAT_ENOENT' and 'READ_GITFILE_ERR_IS_A_DIR'.
>

Nit: This is much better, we seem to talk about the issues and the new
errors introduced. I wonder if we can tie the errors to the issues.

Perhaps

    The 'read_gitfile_gently()' is used to obtain the location of a git
    directory by parsing a '.git' file.

    When parsing the file with 'stat(2)', it fails to differentiate
    between a 'ENOENT' and other errors. Introduce
    'READ_GITFILE_ERR_STAT_ENOENT' to make this differentiation.

    The function also marks directories as
    'READ_GITFILE_ERR_NOT_A_FILE', introduce 'READ_GITFILE_ERR_IS_A_DIR'
    to specifically make this distinction.


> To preserve the original intent of the setup process:
> 1. Update 'read_gitfile_error_die()' to treat 'IS_A_DIR' as a no-op
>    (like 'ENOENT'), while still calling 'die()' on true 'NOT_A_FILE'
>    errors.

Nice, shouldn't we also mention READ_GITFILE_ERR_STAT_ENOENT is now
treated as a no-op, while its counterpart is not.

> 2. Unconditionally pass '&error_code' to 'read_gitfile_gently()'. This
>    eliminates an uninitialized variable hazard that occurred when
>    'die_on_error' was true and 'NULL' was passed.

Where is the 'uninitialized variable hazard'? The function says:

  If return_error_code is NULL the function will die instead

> 3. Only invoke 'is_git_directory()' when we explicitly receive
>    'READ_GITFILE_ERR_IS_A_DIR', avoiding redundant filesystem checks.

Nice.

> 4. Correctly return 'GIT_DIR_INVALID_GITFILE' on unrecognized errors
>    when 'die_on_error' is false.
>
> Additionally, audit external callers of 'read_gitfile_gently()' in
> 'submodule.c' and 'worktree.c' to accommodate the refined error codes.
>
> Signed-off-by: Tian Yuchen <a3205153416@gmail.com>
> ---
>  setup.c                       | 42 ++++++++++++++------
>  setup.h                       |  2 +
>  submodule.c                   |  2 +-
>  t/meson.build                 |  1 +
>  t/t0009-git-dir-validation.sh | 72 +++++++++++++++++++++++++++++++++++
>  worktree.c                    |  6 ++-
>  6 files changed, 110 insertions(+), 15 deletions(-)
>  create mode 100755 t/t0009-git-dir-validation.sh
>

I couldn't find a discussion, why did we merge the commits?

> diff --git a/setup.c b/setup.c
> index c8336eb20e..9d49b9ae53 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -897,10 +897,14 @@ int verify_repository_format(const struct repository_format *format,
>  void read_gitfile_error_die(int error_code, const char *path, const char *dir)
>  {
>  	switch (error_code) {
> -	case READ_GITFILE_ERR_STAT_FAILED:
> -	case READ_GITFILE_ERR_NOT_A_FILE:
> +	case READ_GITFILE_ERR_STAT_ENOENT:
> +	case READ_GITFILE_ERR_IS_A_DIR:
>  		/* non-fatal; follow return path */
>  		break;
> +	case READ_GITFILE_ERR_STAT_FAILED:
> +		die(_("error reading %s"), path);
> +	case READ_GITFILE_ERR_NOT_A_FILE:
> +		die(_("not a regular file: %s"), path);

Not your fault, but some of the errors quote the path and some don't, it
would be nice to be uniform here.

>  	case READ_GITFILE_ERR_OPEN_FAILED:
>  		die_errno(_("error opening '%s'"), path);
>  	case READ_GITFILE_ERR_TOO_LARGE:
> @@ -941,8 +945,14 @@ const char *read_gitfile_gently(const char *path, int *return_error_code)
>  	static struct strbuf realpath = STRBUF_INIT;
>
>  	if (stat(path, &st)) {
> -		/* NEEDSWORK: discern between ENOENT vs other errors */
> -		error_code = READ_GITFILE_ERR_STAT_FAILED;
> +		if (errno == ENOENT)
> +			error_code = READ_GITFILE_ERR_STAT_ENOENT;
> +		else
> +			error_code = READ_GITFILE_ERR_STAT_FAILED;
> +		goto cleanup_return;
> +	}
> +	if (S_ISDIR(st.st_mode)) {
> +		error_code = READ_GITFILE_ERR_IS_A_DIR;
>  		goto cleanup_return;
>  	}

This block makes sense.

>  	if (!S_ISREG(st.st_mode)) {
> @@ -1578,20 +1588,28 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
>  		if (offset > min_offset)
>  			strbuf_addch(dir, '/');
>  		strbuf_addstr(dir, DEFAULT_GIT_DIR_ENVIRONMENT);
> -		gitdirenv = read_gitfile_gently(dir->buf, die_on_error ?
> -						NULL : &error_code);
> +		gitdirenv = read_gitfile_gently(dir->buf, &error_code);

So we now ask the error code to be provided, even if `die_on_error` is
set. I assume, we will manually handle `die_on_error`.

>  		if (!gitdirenv) {
> -			if (die_on_error ||
> -			    error_code == READ_GITFILE_ERR_NOT_A_FILE) {
> -				/* NEEDSWORK: fail if .git is not file nor dir */
> +			switch (error_code) {
> +			case READ_GITFILE_ERR_STAT_ENOENT:
> +				/* no .git in this directory, move on */
> +				break;
> +			case READ_GITFILE_ERR_IS_A_DIR:
>  				if (is_git_directory(dir->buf)) {
>  					gitdirenv = DEFAULT_GIT_DIR_ENVIRONMENT;
>  					gitdir_path = xstrdup(dir->buf);
>  				}
> -			} else if (error_code != READ_GITFILE_ERR_STAT_FAILED)
> -				return GIT_DIR_INVALID_GITFILE;
> -		} else
> +				/* NEEDSWORK: should we catch a directory .git that is not a git directory here? */

Nit: we should probably wrap this.

> +				break;
> +			default:
> +				if (die_on_error || error_code == READ_GITFILE_ERR_NOT_A_FILE)
> +					read_gitfile_error_die(error_code, dir->buf, NULL);
> +				else
> +					return GIT_DIR_INVALID_GITFILE;
> +			}
> +		} else {
>  			gitfile = xstrdup(dir->buf);
> +		}

The changes themselves make sense to me.

>  		/*
>  		 * Earlier, we tentatively added DEFAULT_GIT_DIR_ENVIRONMENT
>  		 * to check that directory for a repository.
> diff --git a/setup.h b/setup.h
> index 0738dec244..ed4b13f061 100644
> --- a/setup.h
> +++ b/setup.h
> @@ -36,6 +36,8 @@ int is_nonbare_repository_dir(struct strbuf *path);
>  #define READ_GITFILE_ERR_NO_PATH 6
>  #define READ_GITFILE_ERR_NOT_A_REPO 7
>  #define READ_GITFILE_ERR_TOO_LARGE 8
> +#define READ_GITFILE_ERR_STAT_ENOENT 9
> +#define READ_GITFILE_ERR_IS_A_DIR 10
>  void read_gitfile_error_die(int error_code, const char *path, const char *dir);
>  const char *read_gitfile_gently(const char *path, int *return_error_code);
>  #define read_gitfile(path) read_gitfile_gently((path), NULL)
> diff --git a/submodule.c b/submodule.c
> index 508938e4da..b179f952fb 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -2559,7 +2559,7 @@ void absorb_git_dir_into_superproject(const char *path,
>  		const struct submodule *sub;
>  		struct strbuf sub_gitdir = STRBUF_INIT;
>
> -		if (err_code == READ_GITFILE_ERR_STAT_FAILED) {
> +		if (err_code == READ_GITFILE_ERR_STAT_ENOENT) {
>  			/* unpopulated as expected */
>  			strbuf_release(&gitdir);
>  			return;
> diff --git a/t/meson.build b/t/meson.build
> index f80e366cff..c4afaacee5 100644
> --- a/t/meson.build
> +++ b/t/meson.build
> @@ -80,6 +80,7 @@ integration_tests = [
>    't0006-date.sh',
>    't0007-git-var.sh',
>    't0008-ignores.sh',
> +  't0009-git-dir-validation.sh',
>    't0010-racy-git.sh',
>    't0012-help.sh',
>    't0013-sha1dc.sh',
> diff --git a/t/t0009-git-dir-validation.sh b/t/t0009-git-dir-validation.sh
> new file mode 100755
> index 0000000000..9b3925c85f
> --- /dev/null
> +++ b/t/t0009-git-dir-validation.sh
> @@ -0,0 +1,72 @@
> +#!/bin/sh
> +
> +test_description='setup: validation of .git file/directory types
> +
> +Verify that setup_git_directory() correctly handles:
> +1. Valid .git directories (including symlinks to them).
> +2. Invalid .git files (FIFOs, sockets) by erroring out.
> +3. Invalid .git files (garbage) by erroring out.
> +'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup: create parent git repository' '
> +	git init parent &&
> +	test_commit -C parent "root-commit"
> +'
> +
> +test_expect_success SYMLINKS 'setup: .git as a symlink to a directory is valid' '

Nit: should we also cleanup? with a 'test_when_finished "rm -rf
parent/link-to-dir"'.
Should apply for all the tests.

> +	mkdir -p parent/link-to-dir &&
> +	(
> +		cd parent/link-to-dir &&
> +		git init real-repo &&
> +		ln -s real-repo/.git .git &&
> +		git rev-parse --git-dir >actual &&
> +		echo .git >expect &&
> +		test_cmp expect actual
> +	)
> +'
> +
> +test_expect_success PIPE 'setup: .git as a FIFO (named pipe) is rejected' '
> +	mkdir -p parent/fifo-trap &&
> +	(
> +		cd parent/fifo-trap &&
> +		mkfifo .git &&
> +		test_must_fail git rev-parse --git-dir 2>stderr &&
> +		grep "not a regular file" stderr
> +	)
> +'
> +
> +test_expect_success SYMLINKS,PIPE 'setup: .git as a symlink to a FIFO is rejected' '
> +	mkdir -p parent/symlink-fifo-trap &&
> +	(
> +		cd parent/symlink-fifo-trap &&
> +		mkfifo target-fifo &&
> +		ln -s target-fifo .git &&
> +		test_must_fail git rev-parse --git-dir 2>stderr &&
> +		grep "not a regular file" stderr
> +	)
> +'
> +
> +test_expect_success 'setup: .git with garbage content is rejected' '
> +	mkdir -p parent/garbage-trap &&
> +	(
> +		cd parent/garbage-trap &&
> +		echo "garbage" >.git &&
> +		test_must_fail git rev-parse --git-dir 2>stderr &&
> +		grep "invalid gitfile format" stderr
> +	)
> +'
> +
> +test_expect_success 'setup: .git as an empty directory is ignored' '
> +	mkdir -p parent/empty-dir &&
> +	(
> +		cd parent/empty-dir &&
> +		mkdir .git &&
> +		git rev-parse --git-dir >actual &&
> +		echo "$TRASH_DIRECTORY/parent/.git" >expect &&
> +		test_cmp expect actual
> +	)
> +'
> +
> +test_done
> diff --git a/worktree.c b/worktree.c
> index 9308389cb6..d1165e1d1c 100644
> --- a/worktree.c
> +++ b/worktree.c
> @@ -653,7 +653,8 @@ static void repair_gitfile(struct worktree *wt,
>  		}
>  	}
>
> -	if (err == READ_GITFILE_ERR_NOT_A_FILE)
> +	if (err == READ_GITFILE_ERR_NOT_A_FILE ||
> +		err == READ_GITFILE_ERR_IS_A_DIR)
>  		fn(1, wt->path, _(".git is not a file"), cb_data);
>  	else if (err)
>  		repair = _(".git file broken");
> @@ -833,7 +834,8 @@ void repair_worktree_at_path(const char *path,
>  			strbuf_addstr(&backlink, dotgit_contents);
>  			strbuf_realpath_forgiving(&backlink, backlink.buf, 0);
>  		}
> -	} else if (err == READ_GITFILE_ERR_NOT_A_FILE) {
> +	} else if (err == READ_GITFILE_ERR_NOT_A_FILE ||
> +			err == READ_GITFILE_ERR_IS_A_DIR) {
>  		fn(1, dotgit.buf, _("unable to locate repository; .git is not a file"), cb_data);
>  		goto done;
>  	} else if (err == READ_GITFILE_ERR_NOT_A_REPO) {
> --
> 2.43.0

The rest looks good. Thanks!

--000000000000d4d8f9064b6c7e33
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 965f68038008cceb_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tYk5Jc1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mM1VVQy85aTdhbHhBYUdwQS9PcWN2dXFjQlBVa3BVagplNFEzVDRhZGEx
RDUwZ2orZkVuVllvSytJZFBNc1kwWHlRREw5bC9OZU9wRGdNMEpDcENqaHEybFBSNU4yNTNEClpT
eGRIMWVsdWxQMm5telNWc21uUmo2c2U4bjlLeHgyNlJYakJsaGhJUUxsTmpzL095QUt6UDU4b0Fm
NDUzaHUKN3QwekNUWEUwL0YxZnJrZTIveURQQjRiZ0NXY2dQRHJidkJtY0JXSUVrRXNFOFE3Y1d4
akxFeVVMTGVPa1l0RQpGbzRBbFBJL1JaSWJuc2ZGMTFhSDlBTVR5OUZJcU5HQ1d5UzJuR0xBN1Zm
anc1aFFkTWRVOTRiYXJjMWVyaTFuCjhTQ01Qa1QrRGxpQzEzdE82SUlPeWtwb3VubFpjaGVkbytL
d0xPSEl0QkM3NnFUS2ZCdlUwZ3RzcGVjWmd0K2oKTlpMWWpTWVZkYmh6WTZKVVE1RXh0aFNzV0dl
bXgxK0h0OXJ6OERwUkhoV0w2aHdEeHQ0Nkw2bTJ4eXBKbWoycAovU2pHNzRuS2ZXZW1tcFI4NEtu
azRGZWd2bmdZMExiemo2UXpDVVRvSTVOZ2JKajVjcHlmT3NBVEJxYkRlWUVBCmpCQS9LcnYrZWp4
S0s3djFWQUgyMFFhVkRXeW5MTEpmbFhpZ0E5bz0KPWlMbGkKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000d4d8f9064b6c7e33--
