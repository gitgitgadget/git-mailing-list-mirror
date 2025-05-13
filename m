Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E792BCF5F
	for <git@vger.kernel.org>; Tue, 13 May 2025 13:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747144356; cv=none; b=WyJm/4d9GUUi9qZ0vBBQTGxxfj1mUyNqr4tsVI4aHbuyUk/OGX0mU1B1xvikI9eIvo5cfMklv7mcff3ri7I3g5Wj3cgOF/I3uMKM4FaLkJfS0f8r9jtUVEaKnSWC6rVoOO+SZPAN+7NY7V1NJqlER8Bz04rnrvd1Wv10JzDxKFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747144356; c=relaxed/simple;
	bh=X6LHEn5bNdIDMheGNdsULrI108pBbxxIIYWnxJJ3oLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G4YLRqm7MKzquwtAWD+CK8vGyrtbPyOtNY9627Yky2k350Ss8ivXkUXGMWGfyblCCnZvwbqu6q48N3PD+Cm5EOXV2McfU0tR+FT+kUcw9rGp7YiSsW+EtFoL6NOsLx1+biWTstkXMRAsT6aCX1eN/Wc8nICvF8HebCOqLUtHc7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ej3ZA5hY; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ej3ZA5hY"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-442d146a1aaso52127635e9.1
        for <git@vger.kernel.org>; Tue, 13 May 2025 06:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747144353; x=1747749153; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7Qu5X851TyY3fSbE3tm/eyVpAOWvgKd6z5uD+WBEDm8=;
        b=Ej3ZA5hYi5vqbwoE6Z5aITc89Z4UHUqE6uNJ8zsjH74FWIBdaWOEwV2g1I9tqBGEQr
         lPNQsRM/NmDQt40Sy/hkjk19ekZm5Mzi9W0iinkoHLRr3xVV0yFM+U9I4LWYwioG1Imf
         r/sV0G6mDjIafzAyNFpSBaAib9EB9wPrPFf1CwofWjaLYF3N4oYBpzoGyTjmcqGuXcpc
         3aovW1yNrkJ5hVzciR/967Bl0obY2VYRBfXTT0dvGxttHr4UN1rDPhu+xvlIiFJVfRhg
         eKNvV8R8++pFWyL86clA0Xn3dHZds2jOQ/+CG6Puxt2toko2qz790RZ4aS5V1HseB1rT
         bT6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747144353; x=1747749153;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Qu5X851TyY3fSbE3tm/eyVpAOWvgKd6z5uD+WBEDm8=;
        b=O3l8QFBy1rLWwXXZPy0XTpKPF5cMUBgC7Z3Lqy7nn/e+g2TwREo02sxb6ROyC/Ddgy
         dFckzjAe7EYCjyA69hVVdjvUYuDTcTWB8yW2De1JVNNlCnFIgd27vMJ+rfmfAllAAkmu
         kF6kP9aGPG3spaSrgPg8ssL1N3WISkAxoY0oLI8QetwSkMLtyakhRtg8dD3T/HZaP8Py
         DJHbxoiJj0IhlgnSGwfrjByssFyPLrm+zv8YFJ+kGvNwJhOsT1BXLTwH6NetBg6K575K
         thPYdiqTU64Kk0FW00OmW1HIbmZ+otwwHrXtF6HNGaCCWgZyZhpdLYzDTRukO9P0kv2t
         pYfA==
X-Forwarded-Encrypted: i=1; AJvYcCU6hr/OKn9aW6DuSNT2Pyi9Sds6XDtCxrsNy7UmPJyWFPakG/a4dLi2B/2LGFxsJzavfeo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEx0Av7njaLSAZv2fOQygIPiszfc5yr7+QMV5DrKIHAnhEoOBg
	9PCFY/vWNUddy0odaFRkmzlzCluS1Lk910IdiIT3E8eqgkt/dUG1
X-Gm-Gg: ASbGncs1uG2YhntSuUlEQekha9Ghkv1XXXMxy0gxtmHzo+r+bRcXpiBZMBVIXJ4q0XS
	QdjCNIwiSWRwnmLyYr1PX4fG5w0eST6NYwzecDtrOejT9A42bxQQqR3O/bZQZQdcFlvanTGJCN0
	I1j5+TSqQcWJ7vb+LJ+ek60Bfi30XZqTXtnUZHf6qTWwH5V5Ojp5TbPX6jx9xreRkRgpvCpm3jT
	eSDtpyBwnlbiWUVS5JyZBAfqV0aUh7tETLVDhSDSAVa1B4f2cELWqhkY0FxwDIM85L3qmO4I5hd
	bZ5JgVesWh5nHCtgHm2M7O175SngtpCoX0/8aN/FrwnQg+9DhQ5BQO+XE3U9xCfFdMx3nfUXCLZ
	gShz6b9y8qWA5Bt82tLiYBQM/GRo=
X-Google-Smtp-Source: AGHT+IHPaYLVLT3ocqQg5VxNJJQ6MduUL7kCwV72hH5z0IpHP66E4inxEzYbgBAuasTRK1KzGTX+EQ==
X-Received: by 2002:a05:600c:4e07:b0:440:68db:a013 with SMTP id 5b1f17b1804b1-442d6dd22ccmr117298845e9.25.1747144352717;
        Tue, 13 May 2025 06:52:32 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58f2fc4sm16537200f8f.56.2025.05.13.06.52.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 06:52:32 -0700 (PDT)
Message-ID: <431d6fec-3955-4703-8bb3-376eae7ff052@gmail.com>
Date: Tue, 13 May 2025 14:52:31 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 4/4] add-patch: add diff.context command line overrides
To: Leon Michalak via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Eric Sunshine <sunshine@sunshineco.com>,
 Christian Couder <christian.couder@gmail.com>,
 Leon Michalak <leonmichalak6@gmail.com>
References: <pull.1915.git.1746436719.gitgitgadget@gmail.com>
 <pull.1915.v2.git.1746884789.gitgitgadget@gmail.com>
 <973dfadd1b3c7e214b14c75494b3b3b786227362.1746884789.git.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <973dfadd1b3c7e214b14c75494b3b3b786227362.1746884789.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Leon

On 10/05/2025 14:46, Leon Michalak via GitGitGadget wrote:
> From: Leon Michalak <leonmichalak6@gmail.com>
> 
> This patch compliments the previous commit, where builtins that use
> add-patch infrastructure now respect diff.context and
> diff.interHunkContext file configurations.
> 
> In particular, this patch helps users who don't want to set persistent
> context configurations or just want a way to override them on a one-time
> basis, by allowing the relevant builtins to accept corresponding command
> line options that override the file configurations.
> 
> This mimics commands such as diff and log, which allow for both context
> file configuration and command line overrides.

The code changes here mostly look good, I've left a few comments
below. I think the tests could be improved, I've left some suggestions
on limiting the number of tests while improving the coverage. The new
tests I'm suggesting that check invalid option combinations are the
basis for most of my code comments.

There is still the issue of what to do with -U0. As I mentioned
previously "git apply" will fail when we try to apply the patch. We
can either pass the appropriate flag when the context is zero or
possibly use -U0 to mean the default number of context lines.

> diff --git a/Documentation/diff-context-options.adoc b/Documentation/diff-context-options.adoc
> new file mode 100644
> index 000000000000..e161260358ff
> --- /dev/null
> +++ b/Documentation/diff-context-options.adoc
> @@ -0,0 +1,10 @@
> +`-U<n>`::
> +`--unified=<n>`::
> +	Generate diffs with _<n>_ lines of context. Defaults to `diff.context`
> +	or 3 if the config option is unset.
> +
> +`--inter-hunk-context=<n>`::
> +	Show the context between diff hunks, up to the specified _<number>_
> +	of lines, thereby fusing hunks that are close to each other.
> +	Defaults to `diff.interHunkContext` or 0 if the config option
> +	is unset.

Nice - we reuse the same text for all the "-p" commands.

> diff --git a/add-interactive.c b/add-interactive.c
> [...]
> @@ -98,6 +99,17 @@ void init_add_i_state(struct add_i_state *s, struct repository *r)
>   	repo_config_get_bool(r, "interactive.singlekey", &s->use_single_key);
>   	if (s->use_single_key)
>   		setbuf(stdin, NULL);
> +
> +	if (add_p_opt->context != -1) {
> +		if (add_p_opt->context < 0)
> +			die(_("%s cannot be negative"), "--unified");
> +		s->context = add_p_opt->context;
> +	}
> +	if (add_p_opt->interhunkcontext != -1) {
> +		if (add_p_opt->interhunkcontext < 0)
> +			die(_("%s cannot be negative"), "--inter-hunk-context");
> +		s->interhunkcontext = add_p_opt->interhunkcontext;
> +	}

Centralizing these checks like this is a good idea.

> @@ -1031,10 +1047,13 @@ static int run_diff(struct add_i_state *s, const struct pathspec *ps,
>   	if (count > 0) {
>   		struct child_process cmd = CHILD_PROCESS_INIT;
>   
> -		strvec_pushl(&cmd.args, "git", "diff", "-p", "--cached",
> -			     oid_to_hex(!is_initial ? &oid :
> -					s->r->hash_algo->empty_tree),
> -			     "--", NULL);
> +		strvec_pushl(&cmd.args, "git", "diff", "-p", "--cached", NULL);
> +		if (s->context != -1)
> +			strvec_pushf(&cmd.args, "--unified=%i", s->context);
> +		if (s->interhunkcontext != -1)
> +			strvec_pushf(&cmd.args, "--inter-hunk-context=%i", s->interhunkcontext);
> +		strvec_pushl(&cmd.args, oid_to_hex(!is_initial ? &oid :
> +			     s->r->hash_algo->empty_tree), "--", NULL);

This is good - we propagate the values we were given on the
command-line.

> diff --git a/builtin/checkout.c b/builtin/checkout.c
> [...]
> @@ -564,8 +575,13 @@ static int checkout_paths(const struct checkout_opts *opts,
>   		else
>   			BUG("either flag must have been set, worktree=%d, index=%d",
>   			    opts->checkout_worktree, opts->checkout_index);
> -		return !!run_add_p(the_repository, patch_mode, rev,
> -				   &opts->pathspec);
> +		return !!run_add_p(the_repository, patch_mode, &add_p_opt,
> +				   rev, &opts->pathspec);
> +	} else {
> +		if (opts->patch_context != -1)
> +			die(_("the option '%s' requires '%s'"), "--unified", "--patch");
> +		if (opts->patch_interhunk_context != -1)
> +			die(_("the option '%s' requires '%s'"), "--inter-hunk-context", "--patch");
>   	}

This does not catch "git checkout -U 7" because this code is only run
if we're checking out paths. I think you need to check this is
checkout_main() instead.

> diff --git a/builtin/stash.c b/builtin/stash.c
> [...]
> @@ -1826,8 +1831,15 @@ static int push_stash(int argc, const char **argv, const char *prefix,
>   		die(_("the option '%s' requires '%s'"), "--pathspec-file-nul", "--pathspec-from-file");
>   	}
>   
> +	if (!patch_mode) {
> +		if (add_p_opt.context != -1)
> +			die(_("the option '%s' requires '%s'"), "--unified", "--patch");
> +		if (add_p_opt.interhunkcontext != -1)
> +			die(_("the option '%s' requires '%s'"), "--inter-hunk-context", "--patch");
> +	}
> +

This needs to die on invalid context values as "git stash" seems to
ignore the exit code of the subprocess that checks for negative values.

> @@ -1877,8 +1892,17 @@ static int save_stash(int argc, const char **argv, const char *prefix,
>   		stash_msg = strbuf_join_argv(&stash_msg_buf, argc, argv, ' ');
>   
>   	memset(&ps, 0, sizeof(ps));
> +
> +	if (!patch_mode) {
> +		if (add_p_opt.context != -1)
> +			die(_("the option '%s' requires '%s'"), "--unified", "--patch");
> +		if (add_p_opt.interhunkcontext != -1)
> +			die(_("the option '%s' requires '%s'"), "--inter-hunk-context", "--patch");

This needs to die on invalid context values as "git stash" seems to
ignore the exit code of the subprocess that checks for negative values.

> diff --git a/commit.h b/commit.h
> [...]
>   #include "object.h"
> +#include "add-interactive.h"
>   struct signature_check;
>   struct strbuf;

Lets not add this. Instead lets just add a declaration for "struct
add_p_opt" like the ones in the context line so that we don't end up
including everything from add-interactive.h when we only need a single
struct declaration.

> diff --git a/parse-options.h b/parse-options.h
> [...]
> +#define OPT_DIFF_UNIFIED(v) OPT_INTEGER_F('U', "unified", v,
>   N_("generate diffs with <n> lines context"), PARSE_OPT_NONEG)

This looks good

> +#define OPT_DIFF_INTERHUNK_CONTEXT(v) OPT_INTEGER_F(0, "inter-hunk-context", v, N_("show context between diff hunks up to the specified number of lines"), PARSE_OPT_NONEG)

This is a bit verbose but it  matches what is in diff.c.

> diff --git a/t/t4032-diff-inter-hunk-context.sh b/t/t4032-diff-inter-hunk-context.sh
> index bada0cbd32f7..d5aad6e143a7 100755
> --- a/t/t4032-diff-inter-hunk-context.sh
> +++ b/t/t4032-diff-inter-hunk-context.sh
> @@ -47,6 +47,31 @@ t() {
>   	"
>   }
>   
> +t_patch() {
> +	use_config=
> +	git config --unset diff.interHunkContext
> +
> +	case $# in
> +	4) hunks=$4; cmd="add -p -U$3";;
> +	5) hunks=$5; cmd="add -p -U$3 --inter-hunk-context=$4";;
> +	6) hunks=$5; cmd="add -p -U$3"; git config diff.interHunkContext $4; use_config="(diff.interHunkContext=$4) ";;
> +	esac
> +	label="$use_config$cmd, $1 common $2"
> +	file=f$1
> +
> +	if ! test -f $file
> +	then
> +		f A $1 B >$file
> +		git add $file
> +		git commit -q -m. $file
> +		f X $1 Y >$file
> +	fi
> +
> +	test_expect_success "$label: count hunks ($hunks)" "
> +		test $(test_write_lines q | git $cmd $file | sed -n 's/^([0-9]*\/\([0-9]*\)) Stage this hunk.*/\1/p') = $hunks
> +	"
> +}
> +
>   cat <<EOF >expected.f1.0.1 || exit 1
>   diff --git a/f1 b/f1
>   --- a/f1
> @@ -107,6 +132,42 @@ t 3 lines	1	2	1	config
>   t 9 lines	3	2	2	config
>   t 9 lines	3	3	1	config
>   
> +# common lines	ctx	intrctx	hunks
> +t_patch 1 line	0		2
> +t_patch 1 line	0	0	2
> +t_patch 1 line	0	1	1
> +t_patch 1 line	0	2	1
> +t_patch 1 line	1		1
> +
> +t_patch 2 lines	0		2
> +t_patch 2 lines	0	0	2
> +t_patch 2 lines	0	1	2
> +t_patch 2 lines	0	2	1
> +t_patch 2 lines	1		1
> +
> +t_patch 3 lines	1		2
> +t_patch 3 lines	1	0	2
> +t_patch 3 lines	1	1	1
> +t_patch 3 lines	1	2	1
> +
> +t_patch 9 lines	3		2
> +t_patch 9 lines	3	2	2
> +t_patch 9 lines	3	3	1
> +
> +#					use diff.interHunkContext?
> +t_patch 1 line	0	0	2	config
> +t_patch 1 line	0	1	1	config
> +t_patch 1 line	0	2	1	config
> +t_patch 9 lines	3	3	1	config
> +t_patch 2 lines	0	0	2	config
> +t_patch 2 lines	0	1	2	config
> +t_patch 2 lines	0	2	1	config
> +t_patch 3 lines	1	0	2	config
> +t_patch 3 lines	1	1	1	config
> +t_patch 3 lines	1	2	1	config
> +t_patch 9 lines	3	2	2	config
> +t_patch 9 lines	3	3	1	config
> +

There are 29 tests here and yet more below. I think we can
get the test coverage we need much more efficiently with the following
added to t3701

for cmd in add checkout restore 'commit -m file'
do
	test_expect_success "${cmd%% *} accepts -U and --inter-hunk-context" "
		test_write_lines a b c d e f g h i j k l m n o p q r s t u v >file &&
		git add file &&
		test_write_lines a b c d e F g h i j k l m n o p Q r s t u v >file &&
		echo y | git -c diff.context=5 -c diff.interhunkcontext=1 \
			$cmd -p -U 4 --inter-hunk-context 2 >actual &&
		test_grep \"@@ -2,20 +2,20 @@\" actual
	"
done
	
test_expect_success 'reset accepts -U and --inter-hunk-context' '
	test_write_lines a b c d e f g h i j k l m n o p q r s t u v >file &&
	git commit -m file file &&
	test_write_lines a b c d e F g h i j k l m n o p Q r s t u v >file &&
	git add file &&
	echo y | git -c diff.context=5 -c diff.interhunkcontext=1 \
		reset -p -U 4 --inter-hunk-context 2 >actual &&
	test_grep "@@ -2,20 +2,20 @@" actual
'

test_expect_success 'stash accepts -U and --inter-hunk-context' '
	test_write_lines a b c d e F g h i j k l m n o p Q r s t u v >file &&
	git commit -m file file &&
	test_write_lines a b c d e f g h i j k l m n o p q r s t u v >file &&
	echo y | git -c diff.context=5 -c diff.interhunkcontext=1 \
		stash -p -U 4 --inter-hunk-context 2 >actual &&
	test_grep "@@ -2,20 +2,20 @@" actual
'

Those tests will fail if any of the commands that accept "-p" do not
accept "-U" or "--inter-hunk-context" or if command-line arguments do
not override the config settings. We should also add tests in t3701 to
check that invalid option combinations and values are rejected like so

for cmd in add checkout commit reset restore 'stash save' 'stash push'
do
	test_expect_success "$cmd rejects invalid context options" "
		test_must_fail git $cmd -p -U -3 2>actual &&
		test_grep -e \"--unified cannot be negative\" actual &&

		test_must_fail git $cmd -p --inter-hunk-context -3 2>actual &&
		test_grep -e \"--inter-hunk-context cannot be negative\" actual &&

		test_must_fail git $cmd -U 7 2>actual &&
		test_grep -E \".--unified. requires .(--interactive/)?--patch.\" actual &&

		test_must_fail git $cmd --inter-hunk-context 2 2>actual &&
		test_grep -E \".--inter-hunk-context. requires 
.(--interactive/)?--patch.\" actual
	"
done

The "checkout", "stash save" and "stash push" tests above currently
fail because the implementation does not implement those checks
properly.

With a few tweaks this series will be looking very good

Best Wishes

Phillip
