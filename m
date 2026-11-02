Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793655381;
	b=eFXDH9otuYyXA09uBdMRt2SMSx6vsU6uWxSuhMhqyzVA3UP3cd5ZIoEQakwgzLccSKYd
	 JSOt2eng7sMQp+8N1hW27UI2yGJua6v3+lND4XIPOoYYyiXswBofIyl8JUCTY36CfXXWV
	 /3/7PUc+ZdaYWcmmOq6Wm+RzNfGH3dQa6o7Zj2rItnh20pwdHGEVDl4wEtmCDg+QjlQ6V
	 hRJSCK0sbrZMxcccMqa9lhargWV2yBluSYy2FKA2Ec60qks3jgevBV7ay/HPR9dHhD75f
	 Pd1v4W8fQlj6Etva5LS/tQYpgQAo3XoEbqNPdZWJF/Ydqr2OmeU/ZUWoP6NGAASBycg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793655381;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=ajNYdMwHzcVR0q4KU+D29W1kSkgSg2E+sePdN9vSqLw=;
	b=mp2kyZmuRF8bFFoWuWrjdmOuhBZC8c2EZCwEx9tgquFWmtevoP6a+ApT+rFJiBdJDVQ1
	 t6lZ1+TGb77XdP8XfABCtbGVOK0hn1p/5Ox2FhEhV4pCzgz4+CXDz2FSt7iL3znG3pU24
	 Qg4Dp+gxURox7rh+iUkhJ0+uX49n6vx4WNdtK8S99gMjr9317H+B9iIQlL4u6VQ+N1QPu
	 TQygsnWcEVm5SGOYh4gkBtE7aI9I7bR6iPifQQol0jRp+M9QwwEAqIXt96NEexzrE7Igg
	 WtaArzIW37NK73UcSBrzeoq/FVezVXtd9Z0um7zF0laznNKhDDwBcRpjJu/4GXFO27w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Gyi6M6TS;
	arc=none smtp.remote-ip=209.85.210.45
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA19606A332
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 21:36:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CA19606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Gyi6M6TS
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-84d5e56f876so2562985a34.3
        for <git@vger.kernel.org>; Mon, 02 Nov 2026 13:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793655380; x=1794260180; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ajNYdMwHzcVR0q4KU+D29W1kSkgSg2E+sePdN9vSqLw=;
        b=Gyi6M6TSKo1csM+yfbvWsBHZlvUaMY3DLgswwLl1Z/UYW1a6xm/qwbFT6Enq6eGlut
         ou0bXxROP/F4FLmEZay1G942eF3WXgKOt91BDxO8aKBbfjgUrb+5h4yo7HcRedd7+cSv
         SXEiN1BfNymyAalLp0L5u6LE25fpJcHOflNI1++0CsfLD4qXpXKQNSEeU5fUnszMpc62
         +jRYHnify6St7X2D+55NJQPqv9k7Q9lNvSV/eJC7X0o+UXFUpXH/bLAI0puAh2/oSzZF
         CJpixmDEuRULqinRWYhQDq4XGB5EEpKAcUKyws2zEDA87IAznKuOX+T7SiDmdEIrQ/bf
         nVIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793655380; x=1794260180;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ajNYdMwHzcVR0q4KU+D29W1kSkgSg2E+sePdN9vSqLw=;
        b=mss74x+mhjIksLSsZ6xmLp8p55xCeoWFXXD5CxvcuwK/e7IDTK6mDmhwSjD82Yhurt
         Xm/Ahq/ejk2i83ClQtG7bz7CwQQd9xcIcCtX9PV8si2FazlWTEDJdNc7My7ZJaBMsW+p
         0kChiCjfB1aEv63krulkll9ArsF9wUzkye3yDOYZOjZsgqrS/X8ILJtYbXsFvq9V5Z2c
         yI85Ad25OrrKM45tYBQ9kToe4WtkzBFR7HWQ1UswwSe9Y19PyNAFgwhH7xMOfqpDflkS
         L4Zezx5oz2LMrT6QFEuKtLe8Y0nABjKCu+sx0jRNkCygBTgcvYaT8b3xE9OdwjOIu6XI
         rTIQ==
X-Gm-Message-State: AFq9FYJ/m1NQ7GrNGJRl6Zx6tdJvYawEk4jlkGxfNvXeuV4wtBt2Ye+D
	0GiMd3eKgNehk/bVWdfciBgLAy2MFG0P4dCv+0IyX0CyyEXTMSLxz+ok
X-Gm-Gg: AYBFou067VMMX4WFrjdgkqND4D3SMgTYDxWL3xtg1b3wWHdX1uhprJR4O1oTNcoXtK6
	d7hzqSC7QqQQpga/mUySL8J7S9vgkRNhv4IkNUBddSOkuC343cqBzWZUBKt/vJJ9M+HUwl7OLXK
	B63utK43QG3fnl4r2PjKNsuRXmwDI+G7epQC+j4Lh7hSvdz+s4rZwaPKK8vtFLuRsck23Z/VXmw
	x2uUKGB3DUJ9t//qzfBfbLJBVXFjcujeonYM98gF+GsuzmXeV1u12Cjmlq2xiPeqTva2HIOaZcl
	yM9btoDfixvioeiHS2BvptZQhdFcdsdQBPTaNotruvhNUzDFBM51HDU4DBicHr/37hqKUCGh5m/
	/oECUSl0Xde69xZI7NPsCNYIS3hxxY0KmnuS+D510/XTCArhRE5Jwq1XoyYdMW+Sxm1FcMm0jCl
	8raX3kMNa33CTTyUU1exz38T3eq7f2L462Auzqxw6B56hEju1dPJx6ycL7RnhFe7m4z+1pXIamI
	sIQWvPhnbAnouNM1cQfRJFs26RpfqYDEgjBY/J1b2LrJYKmUamsDOX8aSJi/A7FaGGItK0wLI+a
	ayb3vPU9hSOnFLt5Sxfclm9R441kmZCh+EJsfuNg8pAl7wK+YH3dS0Cb4GaT7E900CXxfWwfxQ=
	=
X-Received: by 2002:a05:6830:4acb:b0:81c:5aac:798a with SMTP id 46e09a7af769-85d363956eamr9833850a34.13.1793655380309;
        Mon, 02 Nov 2026 13:36:20 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85d354f2325sm10258139a34.20.2026.11.02.13.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 13:36:19 -0800 (PST)
Date: Mon, 2 Nov 2026 15:36:15 -0600
From: Justin Tobler <jltobler@gmail.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org, lucasseikioshiro@gmail.com, gitster@pobox.com
Subject: Re: [GSoC Patch v7 2/8] submodule: use repository to find
 superproject
Message-ID: <auj3hhrRvyX9lus6@denethor>
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
 <20260927114420.59724-1-jayatheerthkulkarni2005@gmail.com>
 <20260927114420.59724-3-jayatheerthkulkarni2005@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260927114420.59724-3-jayatheerthkulkarni2005@gmail.com>

On 26/09/27 05:14PM, K Jayatheerth wrote:
> `get_superproject_working_tree()` currently uses `xgetcwd()` to
> determine the repository whose superproject should be checked.
> 
> This is incorrect when `--git-dir` points to a repository different
> from the one associated with the current working directory. In that
> case, the current working directory may cause the function to return
> the wrong superproject or an empty result.

Ok, so we are not taking into account here that the git dir location
could be different than the current working directory.

> Pass the `repository` to `get_superproject_working_tree()` so that the
> superproject is determined from the repository being inspected rather
> than the current working directory.

Makes sense.

> Mentored-by: Justin Tobler <jltobler@gmail.com>
> Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
> Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
> ---
>  builtin/rev-parse.c        |  2 +-
>  submodule.c                | 43 +++++++++++++++++++-------------------
>  submodule.h                |  2 +-
>  t/t7400-submodule-basic.sh | 19 +++++++++++++++++
>  4 files changed, 43 insertions(+), 23 deletions(-)
> 
> diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
> index 43693454d5..e1a6da0076 100644
> --- a/builtin/rev-parse.c
> +++ b/builtin/rev-parse.c
> @@ -997,7 +997,7 @@ int cmd_rev_parse(int argc,
>  			}
>  			if (!strcmp(arg, "--show-superproject-working-tree")) {
>  				struct strbuf superproject = STRBUF_INIT;
> -				if (get_superproject_working_tree(&superproject))
> +				if (get_superproject_working_tree(the_repository, &superproject))
>  					print_path(superproject.buf, prefix, format, DEFAULT_UNMODIFIED);
>  				strbuf_release(&superproject);
>  				continue;
> diff --git a/submodule.c b/submodule.c
> index 6fcb606f7e..4db90ef9b0 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -2610,34 +2610,35 @@ void absorb_git_dir_into_superproject(const char *path,
>  	absorb_git_dir_into_superproject_recurse(path, super_prefix);
>  }
>  
> -int get_superproject_working_tree(struct strbuf *buf)
> +int get_superproject_working_tree(struct repository *r, struct strbuf *buf)
>  {
>  	struct child_process cp = CHILD_PROCESS_INIT;
>  	struct strbuf sb = STRBUF_INIT;
>  	struct strbuf one_up = STRBUF_INIT;
> -	char *cwd = xgetcwd();
> +	struct strbuf target_wt = STRBUF_INIT;
> +	const char *worktree;
>  	int ret = 0;
>  	const char *subpath;
>  	int code;
>  	ssize_t len;
>  
> -	if (!is_inside_work_tree(the_repository))
> -		/*
> -		 * FIXME:
> -		 * We might have a superproject, but it is harder
> -		 * to determine.
> -		 */
> +	worktree = repo_get_work_tree(r);

We now use the passed repository to get the working tree instead of
relying getting the current working directory and checking if we are
inside a worktree. Looks good.

> +	if (!worktree)
> +		goto out;
> +
> +	if (!strbuf_realpath(&target_wt, worktree, 0))
>  		goto out;
>  
> -	if (!strbuf_realpath(&one_up, "../", 0))
> +	strbuf_addf(&one_up, "%s/..", target_wt.buf);
> +	if (!strbuf_realpath(&one_up, one_up.buf, 0))

I was confused at first why we bother invoking `strbuf_realpath()` here
since it's just an intermediate step, but I assume that is so we can use
it in the error statement later on.

>  		goto out;
>  
> -	subpath = relative_path(cwd, one_up.buf, &sb);
> +	subpath = relative_path(target_wt.buf, one_up.buf, &sb);
>  
>  	prepare_submodule_repo_env(&cp.env);
>  	strvec_pop(&cp.env);
>  
> -	strvec_pushl(&cp.args, "--literal-pathspecs", "-C", "..",
> +	strvec_pushl(&cp.args, "--literal-pathspecs", "-C", one_up.buf,
>  		     "ls-files", "-z", "--stage", "--full-name", "--",
>  		     subpath, NULL);
>  	strbuf_reset(&sb);
> @@ -2648,14 +2649,14 @@ int get_superproject_working_tree(struct strbuf *buf)
>  	cp.git_cmd = 1;
>  
>  	if (start_command(&cp))
> -		die(_("could not start ls-files in .."));
> +		die(_("could not start ls-files in %s"), one_up.buf);
>  
>  	len = strbuf_read(&sb, cp.out, PATH_MAX);
>  	close(cp.out);
>  
>  	if (starts_with(sb.buf, "160000")) {
>  		int super_sub_len;
> -		int cwd_len = strlen(cwd);
> +		int wt_len = target_wt.len;
>  		char *super_sub, *super_wt;
>  
>  		/*
[snip]
> +test_expect_success 'path.superproject-root works with --git-dir' '
> +	test_when_finished "rm -rf sub super" &&
> +	git init sub &&
> +	test_commit -C sub initial &&
> +	git init super &&
> +	(
> +		cd super &&
> +		git -c protocol.file.allow=always submodule add "../sub" sub &&
> +		git commit -m "add submodule" &&
> +
> +		SUPER_ROOT="$(test-tool path-utils real_path .)" &&
> +		MODULE_DIR="$SUPER_ROOT/.git/modules/sub" &&
> +
> +		echo "path.superproject-root.absolute=$SUPER_ROOT" >expect &&
> +		git --git-dir="$MODULE_DIR" repo info path.superproject-root.absolute >actual &&

`path.superproject-root` isn't introduced until the next patch, so this
test fails at this commit. Maybe the test should exercise the existing
`git --git-dir=... rev-parse --show-superproject-working-tree` caller in
t1500 instead?

-Justin
