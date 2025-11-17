Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E342701DA
	for <git@vger.kernel.org>; Mon, 17 Nov 2025 16:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763396891; cv=none; b=ejSpwGQhkey8h8r8T8lW6JdKKMV2qFw6yX4ZRPx9Ju2QsRVMGneRAHxMYWwkFgun7HOeYvY+FqQNaR8giwyhozI/DriOmeWr4Ihp7Xb5jUxZRLOJmp2tnAG3sBwg/dOm4sQ/O5skVChrtUORDKvgNWY85vwqT5P9qJsecS92gAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763396891; c=relaxed/simple;
	bh=X0J/+upMg5gPtDljVd7A7u6tH5QcJ07AXUwIO4ZboGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ktc7b+XbAHZSIRGWIUeV7HEMetRMzi5hh5wIQn+0BeUBFseoK4d1Dgdlnmba9E2y87yqTVWFXAGJXtqktlQ8I7Lv4Ve72JLRm7GbuYWtH4+HF+kP64FKhzGwJMyAKpSuHEXmvbSsoIzuDY88kn269JVTB7RdYeOxCSKz9aykwcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VH5IEcP8; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VH5IEcP8"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47755a7652eso31243935e9.0
        for <git@vger.kernel.org>; Mon, 17 Nov 2025 08:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763396888; x=1764001688; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6ssVFZ7hMzzpw8QFyUFU+LBPy8xQWJSQvK4SvhE+cC4=;
        b=VH5IEcP8+gUb/MxA9J0m6AhfrIJSZsVIBEsWaZ1jdYIqdotX6VpAD9LaIO+kkvC9D6
         +BdG9a6dNw/p2UrgeFUedGghNgkGmCgT9Vy4jc2+4RjvXvsrEfQ7DcYAiJjR/Zk0mWjz
         9VrXLdfsiOhqBqcDeqWsxQBhUvToHIZ03ZZCCKDhxHix09b7KzaKh0eCptUcoNNgKlX+
         MjqemU4McSZJrDxJwvOOQqZnhJy1bPxVF/HR06pf0fqiWAPH/vgrcYf6UaOCFJFqHU9v
         09R09hWgedwQhJbxwQ4pibs1EfKLo4SkO6Tt/O6e38N6iYctpDoo3t1RU0GsiIxxjpmR
         YYZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763396888; x=1764001688;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ssVFZ7hMzzpw8QFyUFU+LBPy8xQWJSQvK4SvhE+cC4=;
        b=i5bCRo03x9AkfnXdec1Bgb4Y3R1ax4UKKB27aEum+f8D6EzfzWU59vIKzBtFJaZi5l
         A+zAewT/0NA4VB20b/gkgAoXcPDI7Fw2fGe29Lkj+iJwuaOGkLRMoIh2Imfq1zPKkcU3
         w2UKNaFwwCU6ETjvqH/8Y+aiepiDo3DIotrR+wzzkzXyxqwVdVF6cPq2gGp0mMk6u6Fj
         dRWZQldSHt4ujT1+KQht4eap8IBsFS2RFJv4N7hKRwQNG/UQz7zPaNE9FCHZ5VpBvdxu
         wDXW9b5ulqn16VgxrQqOpT6G3cGUzEYEBWNMZYHR3/09NabqYg5Uld4xpJpkaM2gvqWY
         48Dw==
X-Forwarded-Encrypted: i=1; AJvYcCVepiH9QkUPb/JvhO+CqNGFJp20pkLO5TqM/BmJwqh1QPsD7Li2vVdzg0vT8Ed5a5gn6EY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2u/rn0AITxi/gvpzMtyxOj9oh0b9ZcwZt1B28l8obZse7B3Dw
	ZgdmHf8OIbvhoGuq+gCrHt+ot6Js16P5rxuP8nn4HMme+rE6SctCnsQr
X-Gm-Gg: ASbGncs11yTpGlbohbaWuv2NNKxu+8ZUhfF5s0q8PbBXc17rjjH78X+KlnUMvvFDOMU
	BmXycpEIthO8WZPPCcubGRdwBZDLMus+y39nwHrR1fE+0/pwkIDVYXc+b6bioJ2kF5A6EMN/hMY
	t4Rzm2MRp2Bh7Tz5OdbW71e+FJEMs2sxQtkTu9zyIVtkkm1DlUohCS9ri9eNk31KQdlvlx9II+m
	jNONzxjB/iihFdd0Q6n+l4zkExz3Pw1/OIdgQQG63agmt9G2xZc7yCVUo25MOgWPQOeIjSi86VD
	c1/1+LVQAA4kjXdA/7b66M8uSewwYD2CoSB7jUJfMqK+a0mT8anWDiKjBx+TL6nxaGLlQzkHR0R
	CtXDlBhVx37hV5drupoIRs6ms7y8NPzZvzHSWpK+zdHS+D3pHW0kgT0mK5IqjxTWLdoX0QhXurS
	lgXHRQDx1ylypfhtxA94Tin2I8EcTQmyX1g6E1xbKHE04FtWfNT3jGMNE3Yrqzai18D2rX+5ZhT
	w==
X-Google-Smtp-Source: AGHT+IH5Vf7ySEhHshbC8ww4YB84qseyQhrs9cU6BuVRyJTLdqacHpBBbWj42jZbv6qVDb7r+E9v+w==
X-Received: by 2002:a05:600c:6052:b0:477:9986:5e6b with SMTP id 5b1f17b1804b1-47799866420mr51650415e9.28.1763396887699;
        Mon, 17 Nov 2025 08:28:07 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:658:8901:ced:8495:73eb:ebd6? ([2a0a:ef40:658:8901:ced:8495:73eb:ebd6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787e442c2sm324777455e9.7.2025.11.17.08.28.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Nov 2025 08:28:07 -0800 (PST)
Message-ID: <cca1e594-6685-4f9e-a57d-8419ccc6fa68@gmail.com>
Date: Mon, 17 Nov 2025 16:28:06 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v6 04/11] builtin: add new "history" command
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, Junio C Hamano
 <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>,
 =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>,
 Martin von Zweigbergk <martinvonz@gmail.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Elijah Newren <newren@gmail.com>, Karthik Nayak <karthik.188@gmail.com>
References: <20251027-b4-pks-history-builtin-v6-0-407dd3f57ad3@pks.im>
 <20251027-b4-pks-history-builtin-v6-4-407dd3f57ad3@pks.im>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20251027-b4-pks-history-builtin-v6-4-407dd3f57ad3@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 27/10/2025 11:33, Patrick Steinhardt wrote:
> When rewriting history via git-rebase(1) there are a couple of very

There's more than a couple of items in this list, s/couple of/few/?

> common use cases:
> 
>    - The ordering of two commits should be reversed.
> 
>    - A commit should be split up into two commits.
> 
>    - A commit should be dropped from the history completely.
> 
>    - Multiple commits should be squashed into one.

I'd add editing an existing commit to this list, even if we don't 
implement it initially

> diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
> new file mode 100644
> index 00000000000..6bdfeb50e8b
> --- /dev/null
> +++ b/Documentation/git-history.adoc
> @@ -0,0 +1,44 @@
> +git-history(1)
> +==============
> +
> +NAME
> +----
> +git-history - EXPERIMENTAL: Rewrite history of the current branch
> +
> +SYNOPSIS
> +--------
> +[synopsis]
> +git history [<options>]
> +
> +DESCRIPTION
> +-----------
> +
> +Rewrite history by rearranging or modifying specific commits in the
> +history.
> +
> +THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.

Excellent - keeping our options open is a very good idea

> +This command is similar to linkgit:git-rebase[1] and uses the same
> +underlying machinery.

This isn't strictly true now that we're baisg "git history" on the 
replay machinery.

> You should use rebases if you want to reapply a range of
> +commits onto a different base, or interactive rebases if you want to edit a
> +range of commits.
> +
> +Note that this command does not (yet) work with histories that contain
> +merges. You should use linkgit:git-rebase[1] with the `--rebase-merges`
> +flag instead.
> +
> +COMMANDS
> +--------
> +
> +Several commands are available to rewrite history in different ways:
> +
> +CONFIGURATION
> +-------------
> +
> +include::includes/cmd-config-section-all.adoc[]
> +
> +include::config/sequencer.adoc[]

This probably isn't relevant now we're not using the sequencer.

Thanks

Phillip

> +
> +GIT
> +---
> +Part of the linkgit:git[1] suite
> diff --git a/Documentation/meson.build b/Documentation/meson.build
> index 9d24f2da544..d1f6bde7c16 100644
> --- a/Documentation/meson.build
> +++ b/Documentation/meson.build
> @@ -64,6 +64,7 @@ manpages = {
>     'git-gui.adoc' : 1,
>     'git-hash-object.adoc' : 1,
>     'git-help.adoc' : 1,
> +  'git-history.adoc' : 1,
>     'git-hook.adoc' : 1,
>     'git-http-backend.adoc' : 1,
>     'git-http-fetch.adoc' : 1,
> diff --git a/Makefile b/Makefile
> index 01c171b4f03..1380ee1e196 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1395,6 +1395,7 @@ BUILTIN_OBJS += builtin/get-tar-commit-id.o
>   BUILTIN_OBJS += builtin/grep.o
>   BUILTIN_OBJS += builtin/hash-object.o
>   BUILTIN_OBJS += builtin/help.o
> +BUILTIN_OBJS += builtin/history.o
>   BUILTIN_OBJS += builtin/hook.o
>   BUILTIN_OBJS += builtin/index-pack.o
>   BUILTIN_OBJS += builtin/init-db.o
> diff --git a/builtin.h b/builtin.h
> index 1b35565fbd9..93c91d07d4b 100644
> --- a/builtin.h
> +++ b/builtin.h
> @@ -172,6 +172,7 @@ int cmd_get_tar_commit_id(int argc, const char **argv, const char *prefix, struc
>   int cmd_grep(int argc, const char **argv, const char *prefix, struct repository *repo);
>   int cmd_hash_object(int argc, const char **argv, const char *prefix, struct repository *repo);
>   int cmd_help(int argc, const char **argv, const char *prefix, struct repository *repo);
> +int cmd_history(int argc, const char **argv, const char *prefix, struct repository *repo);
>   int cmd_hook(int argc, const char **argv, const char *prefix, struct repository *repo);
>   int cmd_index_pack(int argc, const char **argv, const char *prefix, struct repository *repo);
>   int cmd_init_db(int argc, const char **argv, const char *prefix, struct repository *repo);
> diff --git a/builtin/history.c b/builtin/history.c
> new file mode 100644
> index 00000000000..f6fe32610b0
> --- /dev/null
> +++ b/builtin/history.c
> @@ -0,0 +1,22 @@
> +#include "builtin.h"
> +#include "gettext.h"
> +#include "parse-options.h"
> +
> +int cmd_history(int argc,
> +		const char **argv,
> +		const char *prefix,
> +		struct repository *repo UNUSED)
> +{
> +	const char * const usage[] = {
> +		N_("git history [<options>]"),
> +		NULL,
> +	};
> +	struct option options[] = {
> +		OPT_END(),
> +	};
> +
> +	argc = parse_options(argc, argv, prefix, options, usage, 0);
> +	if (argc)
> +		usagef("unrecognized argument: %s", argv[0]);
> +	return 0;
> +}
> diff --git a/command-list.txt b/command-list.txt
> index accd3d0c4b5..f9005cf4597 100644
> --- a/command-list.txt
> +++ b/command-list.txt
> @@ -115,6 +115,7 @@ git-grep                                mainporcelain           info
>   git-gui                                 mainporcelain
>   git-hash-object                         plumbingmanipulators
>   git-help                                ancillaryinterrogators          complete
> +git-history                             mainporcelain           history
>   git-hook                                purehelpers
>   git-http-backend                        synchingrepositories
>   git-http-fetch                          synchelpers
> diff --git a/git.c b/git.c
> index c5fad56813f..744cb6527e0 100644
> --- a/git.c
> +++ b/git.c
> @@ -586,6 +586,7 @@ static struct cmd_struct commands[] = {
>   	{ "grep", cmd_grep, RUN_SETUP_GENTLY },
>   	{ "hash-object", cmd_hash_object },
>   	{ "help", cmd_help },
> +	{ "history", cmd_history, RUN_SETUP },
>   	{ "hook", cmd_hook, RUN_SETUP },
>   	{ "index-pack", cmd_index_pack, RUN_SETUP_GENTLY | NO_PARSEOPT },
>   	{ "init", cmd_init_db },
> diff --git a/meson.build b/meson.build
> index ae8d4fef059..2d789612a01 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -604,6 +604,7 @@ builtin_sources = [
>     'builtin/grep.c',
>     'builtin/hash-object.c',
>     'builtin/help.c',
> +  'builtin/history.c',
>     'builtin/hook.c',
>     'builtin/index-pack.c',
>     'builtin/init-db.c',
> diff --git a/t/meson.build b/t/meson.build
> index 401b24e50e0..019435918fa 100644
> --- a/t/meson.build
> +++ b/t/meson.build
> @@ -384,6 +384,7 @@ integration_tests = [
>     't3436-rebase-more-options.sh',
>     't3437-rebase-fixup-options.sh',
>     't3438-rebase-broken-files.sh',
> +  't3450-history.sh',
>     't3500-cherry.sh',
>     't3501-revert-cherry-pick.sh',
>     't3502-cherry-pick-merge.sh',
> diff --git a/t/t3450-history.sh b/t/t3450-history.sh
> new file mode 100755
> index 00000000000..417c343d43b
> --- /dev/null
> +++ b/t/t3450-history.sh
> @@ -0,0 +1,17 @@
> +#!/bin/sh
> +
> +test_description='tests for git-history command'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'does nothing without any arguments' '
> +	git history >out 2>&1 &&
> +	test_must_be_empty out
> +'
> +
> +test_expect_success 'raises an error with unknown argument' '
> +	test_must_fail git history garbage 2>err &&
> +	test_grep "unrecognized argument: garbage" err
> +'
> +
> +test_done
> 

