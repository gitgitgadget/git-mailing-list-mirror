Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB4B11F454
	for <e@80x24.org>; Tue,  5 Nov 2019 15:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730833AbfKEPEE (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 10:04:04 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46180 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731014AbfKEPED (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 10:04:03 -0500
Received: by mail-wr1-f68.google.com with SMTP id b3so16009492wrs.13
        for <git@vger.kernel.org>; Tue, 05 Nov 2019 07:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wznfl6Lit/5QRTg67B9m39P2gqx5ssdwKOFbQsoM6j0=;
        b=YG9+U2wnhSkIQGWvCsgu9N0+BPT/c44ZumK+aPJ9ETMAbzwfp4vYVYVvKC3CK6qriT
         yU/WN88y7BalLZTDT7jbYug72vehAvWlocBolTc5cRX3izTIBuPu5wdsc/9eQZdY+Kp9
         wytfIldnxIgsxcwc0AB5K9y8tHvR27sdbk2hQn1KXC83vymeyPNXzK1myoT0gpiRK8sj
         ZBJ2WyP11iQlb79JxrkY5IaV/Tgn+5hfDAaJ5Fn8qKk+j0Ht/GCd5Uz/Q5j/JBWLVAU8
         pg1aHfz3mLSGaWqlHM1B1zKF7BqwMmWrkac6g8E8P5HrQS7QAFK2dcVoJ8Py76u/DFB/
         F8SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=wznfl6Lit/5QRTg67B9m39P2gqx5ssdwKOFbQsoM6j0=;
        b=HlccedjLnUnCnKzGuyY9JJiYX+mpEKEXNc7wmrfXbsBZriVTn+ilqCyx6iAFzyqV5B
         PPpnjYg17sFch2VeB49GGK4Wfj7cAFYeXgDMH9evvJwz5ufsD46XuhxHK/PupKHMH/M/
         ElS3Jha2IuvYxyjacbOmfgBAIInL3VN9IzeUHtBu3P6Ob2Tb7W7Hi214ScGDg8QbjnKS
         Uk2dPoosCKYANX3EE28e71tn++JlIdRiQwL0Vb89m22saJdGSbe0YD4xJwuoktZcwoV+
         sz0ZcDT6Yv50WNGSKx0UqDUhKmhwJjfpiQz2DlWY5GrikUQRRQaWR13zQek1lgvKtecn
         h1bQ==
X-Gm-Message-State: APjAAAWQHGMjbE7tg1JnraB9nRf7DWojf0GW9NAE5qz4bBAJYqeptDkh
        22q0jMPjrWZSHY426WrsCdZ0x98G
X-Google-Smtp-Source: APXvYqxIJp5PhTKLB/dn+9jbYYBwQkRON5DX12+A0ATWGIvPbogfFsHv5hiefcN4yMAtNZ1ciqQRxw==
X-Received: by 2002:adf:db0d:: with SMTP id s13mr27628921wri.319.1572966238417;
        Tue, 05 Nov 2019 07:03:58 -0800 (PST)
Received: from [192.168.2.240] (host-92-22-7-224.as13285.net. [92.22.7.224])
        by smtp.gmail.com with ESMTPSA id z14sm9511884wrl.60.2019.11.05.07.03.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2019 07:03:57 -0800 (PST)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 3/5] reset: support the --pathspec-from-file option
To:     Alexandr Miloslavskiy via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.445.git.1572895605.gitgitgadget@gmail.com>
 <8d9f1fbc18346144a0c866a59891b652dcfe9b7f.1572895605.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <b93592df-561f-36d4-09ce-e02d570c60da@gmail.com>
Date:   Tue, 5 Nov 2019 15:03:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <8d9f1fbc18346144a0c866a59891b652dcfe9b7f.1572895605.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alexandr

This also looks good, I've got some minor comments below. If I'm 
complaining about whitespace and style issues you know the patch is 
quite good!

On 04/11/2019 19:26, Alexandr Miloslavskiy via GitGitGadget wrote:
> From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
> 
> This option solves the problem of commandline length limit for UI's
> built on top of git. Plumbing commands are not always a good fit, for
> two major reasons:
> 1) Some UI's serve as assistants that help user run git commands. In
>     this case, replacing familiar commands with plumbing commands will
>     confuse most users.
> 2) Some UI's have started and grown with porcelain commands. Replacing
>     existing logic with plumbing commands could be cumbersome and prone
>     to various new problems.

I think reset is a good example of the second reason - it's not straight 
forward to implement it in plumbing commands

> The new option is designed to behave very close to pathspecs passed in
> commandline args, so that switching from one to another is simple.
> 
> The new option allows to read either a specified file or `stdin`.
> Reading from file is a good way to avoid competing for stdin, and
> also gives some extra flexibility.

I think this flexibility is a good idea

> Decisions taken for simplicity:
> 1) The new option is declared incompatible with other options that
>     could use `stdin`.

I'm confused reset does not use stdin does it?

> 2) It is not allowed to pass some refspecs in args and others in file.

s/refspecs/pathspecs/ ?

> 3) New options do not have shorthands to avoid shorthand conflicts.

> Also add new '--pathspec-file-null' switch that mirrors '-z' used in
> various places. Some porcelain commands, such as `git commit`, already
> use '-z', therefore it needed a new unambiguous name.

As the 'lines' in the file are nul terminated perhaps it would be better 
to call this --pathspec-file-nul or --nul-termination. I think the use 
of --null to mean nul termination for config was a mistake (for grep it 
matches what GUN grep does but it's still unfortunate).

> 
> Co-authored-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
> ---
>   Documentation/git-reset.txt    |  18 ++++-
>   builtin/reset.c                |  22 +++++-
>   t/t7107-reset-pathspec-file.sh | 126 +++++++++++++++++++++++++++++++++
>   3 files changed, 161 insertions(+), 5 deletions(-)
>   create mode 100755 t/t7107-reset-pathspec-file.sh
> 
> diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
> index b0ea6e0ce5..d484cd2827 100644
> --- a/Documentation/git-reset.txt
> +++ b/Documentation/git-reset.txt
> @@ -9,18 +9,20 @@ SYNOPSIS
>   --------
>   [verse]
>   'git reset' [-q] [<tree-ish>] [--] <pathspec>...
> +'git reset' [-q] [--pathspec-from-file=<file> [--pathspec-file-null]] [<tree-ish>]

--pathspec-file would be shorter and still conveys the intent of the 
option. Is this line missing a leading space?

>   'git reset' (--patch | -p) [<tree-ish>] [--] [<pathspec>...]
>   'git reset' [--soft | --mixed [-N] | --hard | --merge | --keep] [-q] [<commit>]
>   
>   DESCRIPTION
>   -----------
> -In the first and second form, copy entries from `<tree-ish>` to the index.
> -In the third form, set the current branch head (`HEAD`) to `<commit>`,
> +In the first three forms, copy entries from `<tree-ish>` to the index.
> +In the last form, set the current branch head (`HEAD`) to `<commit>`,
>   optionally modifying index and working tree to match.
>   The `<tree-ish>`/`<commit>` defaults to `HEAD` in all forms.
>   
>   'git reset' [-q] [<tree-ish>] [--] <pathspec>...::
> -	This form resets the index entries for all `<pathspec>` to their
> +'git reset' [-q] [--pathspec-from-file=<file> [--pathspec-file-null]] [<tree-ish>]::

Alignment again

> +	These forms reset the index entries for all `<pathspec>` to their

The new form does not mention <pathspec> so this could be confusing

>   	state at `<tree-ish>`.  (It does not affect the working tree or
>   	the current branch.)
>   +
> @@ -107,6 +109,16 @@ OPTIONS
>   	`reset.quiet` config option. `--quiet` and `--no-quiet` will
>   	override the default behavior.
>   
> +--pathspec-from-file=<file>::
> +	Read `<pathspec>` from `<file>` instead. 

As we have a separate synopsis line for --pathspec-from-file which does 
not mention <pathspec> it might be better just to say "read pathspecs 
from `<file>` instead of the command line".

> If `<file>` is exactly `-`
> +	then read from standard input. Pathspecs are separated by LF or
> +	CR/LF. Pathspecs can be quoted as explained for the configuration
> +	variable `core.quotePath` (see linkgit:git-config[1]). See also
> +	`--pathspec-file-null` and global `--literal-pathspecs`.
> +
> +--pathspec-file-null::
> +	Only meaningful with `--pathspec-from-file`. Pathspecs are
> +	separated with NUL character and are not expected to be quoted.
>   
>   EXAMPLES
>   --------
> diff --git a/builtin/reset.c b/builtin/reset.c
> index fdd572168b..0eaa6b0bca 100644
> --- a/builtin/reset.c
> +++ b/builtin/reset.c
> @@ -31,6 +31,7 @@
>   static const char * const git_reset_usage[] = {
>   	N_("git reset [--mixed | --soft | --hard | --merge | --keep] [-q] [<commit>]"),
>   	N_("git reset [-q] [<tree-ish>] [--] <paths>..."),
> +	N_("git reset [-q] [--pathspec-from-file [--pathspec-file-null]] [<tree-ish>]"),
>   	N_("git reset --patch [<tree-ish>] [--] [<paths>...]"),
>   	NULL
>   };
> @@ -284,8 +285,8 @@ static int git_reset_config(const char *var, const char *value, void *cb)
>   int cmd_reset(int argc, const char **argv, const char *prefix)
>   {
>   	int reset_type = NONE, update_ref_status = 0, quiet = 0;
> -	int patch_mode = 0, unborn;
> -	const char *rev;
> +	int patch_mode = 0, pathspec_file_null = 0, unborn;
> +	const char *rev, *pathspec_from_file = NULL;
>   	struct object_id oid;
>   	struct pathspec pathspec;
>   	int intent_to_add = 0;
> @@ -306,6 +307,10 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
>   		OPT_BOOL('p', "patch", &patch_mode, N_("select hunks interactively")),
>   		OPT_BOOL('N', "intent-to-add", &intent_to_add,
>   				N_("record only the fact that removed paths will be added later")),
> +		OPT_FILENAME(0, "pathspec-from-file", &pathspec_from_file,
> +				N_("read pathspecs from file")),
> +		OPT_BOOL(0, "pathspec-file-null", &pathspec_file_null,
> +				N_("with --pathspec-from-file, pathspecs are separated with NUL character")),
>   		OPT_END()
>   	};
>   
> @@ -316,6 +321,19 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
>   						PARSE_OPT_KEEP_DASHDASH);
>   	parse_args(&pathspec, argv, prefix, patch_mode, &rev);
>   
> +	if (pathspec_from_file) {
> +		if (patch_mode)
> +			die(_("--pathspec-from-file is incompatible with --patch"));

This is sensible as -p is interactive so we wouldn't expect command line 
length to be an issue

> +
> +		if (pathspec.nr)
> +			die(_("--pathspec-from-file is incompatible with path arguments"));
> +
> +		parse_pathspec_file(&pathspec, 0,
> +				    PATHSPEC_PREFER_FULL,
> +				    prefix, pathspec_from_file, pathspec_file_null);
> +	} else if (pathspec_file_null)
> +		die(_("--pathspec-file-null requires --pathspec-from-file"));

Style nit: the coding guidelines state that if any branch of an if 
statement requires braces then all the branches should be braced. This 
is widely ignored though.

> +
>   	unborn = !strcmp(rev, "HEAD") && get_oid("HEAD", &oid);
>   	if (unborn) {
>   		/* reset on unborn branch: treat as reset to empty tree */
> diff --git a/t/t7107-reset-pathspec-file.sh b/t/t7107-reset-pathspec-file.sh
> new file mode 100755
> index 0000000000..cf7f085ad5
> --- /dev/null
> +++ b/t/t7107-reset-pathspec-file.sh
> @@ -0,0 +1,126 @@
> +#!/bin/sh
> +
> +test_description='reset --pathspec-from-file'
> +
> +. ./test-lib.sh
> +
> +cat > expect.a <<EOF
> + D fileA.t
> +EOF
> +
> +cat > expect.ab <<EOF
> + D fileA.t
> + D fileB.t
> +EOF
> +
> +cat > expect.a_bc_d <<EOF
> +D  fileA.t
> + D fileB.t
> + D fileC.t
> +D  fileD.t
> +EOF

These days we tend to set up the expected files within the relevant test 
case using <<-\EOF to allow indentation and disallow substitution 
(unless it's needed of course)

> +test_expect_success setup '
> +	echo A >fileA.t &&
> +	echo B >fileB.t &&
> +	echo C >fileC.t &&
> +	echo D >fileD.t &&
> +	git add . &&
> +	git commit --include . -m "Commit" &&
> +	checkpoint=$(git rev-parse --verify HEAD)
> +'
> +
> +restore_checkpoint () {
> +	git reset --hard "$checkpoint"
> +}
> +
> +verify_state () {
> +	git status --porcelain -- fileA.t fileB.t fileC.t fileD.t >actual &&
> +	test_cmp "$1" actual
> +}
> +
> +test_expect_success '--pathspec-from-file from stdin' '
> +	restore_checkpoint &&
> +
> +	git rm fileA.t &&
> +	echo fileA.t | git reset --pathspec-from-file=- &&
> +
> +	verify_state expect.a
> +'
> +
> +test_expect_success '--pathspec-from-file from file' '
> +	restore_checkpoint &&
> +
> +	git rm fileA.t &&
> +	echo fileA.t >list &&
> +	git reset --pathspec-from-file=list &&
> +
> +	verify_state expect.a
> +'
> +
> +test_expect_success 'NUL delimiters' '
> +	restore_checkpoint &&
> +
> +	git rm fileA.t fileB.t &&
> +	printf fileA.tQfileB.t | q_to_nul | git reset --pathspec-from-file=- --pathspec-file-null &&
> +
> +	verify_state expect.ab
> +'
> +
> +test_expect_success 'LF delimiters' '
> +	restore_checkpoint &&
> +
> +	git rm fileA.t fileB.t &&
> +	printf "fileA.t\nfileB.t" | git reset --pathspec-from-file=- &&
> +
> +	verify_state expect.ab
> +'
> +
> +test_expect_success 'CRLF delimiters' '
> +	restore_checkpoint &&
> +
> +	git rm fileA.t fileB.t &&
> +	printf "fileA.t\r\nfileB.t" | git reset --pathspec-from-file=- &&
> +
> +	verify_state expect.ab
> +'
> +
> +test_expect_success 'quotes' '
> +	restore_checkpoint &&
> +
> +	git rm fileA.t &&
> +	printf "\"file\\101.t\"" | git reset --pathspec-from-file=- &&
> +
> +	verify_state expect.a

If I've understood correctly this doesn't test if a path is correctly 
unquoted, only that it is accepted.

> +'
> +
> +test_expect_success 'quotes not compatible with --pathspec-file-null' '
> +	restore_checkpoint &&
> +
> +	git rm fileA.t &&
> +	printf "\"file\\101.t\"" >list &&
> +	# Note: "git reset" has not yet learned to fail on wrong pathspecs
> +	git reset --pathspec-from-file=list --pathspec-file-null &&
> +	
> +	test_must_fail verify_state expect.a
> +'
> +
> +test_expect_success '--pathspec-from-file is not compatible with --soft --hard' '

s/--soft --hard/--soft or --hard/

> +	restore_checkpoint &&
> +
> +	git rm fileA.t &&
> +	echo fileA.t >list &&
> +	test_must_fail git reset --soft --pathspec-from-file=list &&
> +	test_must_fail git reset --hard --pathspec-from-file=list
> +'
> +
> +test_expect_success 'only touches what was listed' '

s/^/--pathspec-from-file / ?

Best Wishes

Phillip

> +	restore_checkpoint &&
> +
> +	git rm fileA.t fileB.t fileC.t fileD.t &&
> +	printf "fileB.t\nfileC.t" | git reset --pathspec-from-file=- &&
> +
> +	verify_state expect.a_bc_d
> +'
> +
> +test_done
> 
