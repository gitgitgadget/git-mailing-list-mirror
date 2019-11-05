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
	by dcvr.yhbt.net (Postfix) with ESMTP id 999231F454
	for <e@80x24.org>; Tue,  5 Nov 2019 16:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389926AbfKEQOO (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 11:14:14 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35477 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389760AbfKEQON (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 11:14:13 -0500
Received: by mail-wr1-f67.google.com with SMTP id l10so22086495wrb.2
        for <git@vger.kernel.org>; Tue, 05 Nov 2019 08:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aNJ4ZzchkmsFEJCJAmfwO0uSlWqcaYgXhsb9CiskJ5I=;
        b=Du/z1bxKTLrl++nX/f2hi7GAIEoVtt0ORIunoOvq6KWySpuQPRiUrew+l/0b3NSAnu
         yvZupu0ynVv6C8T7FRjyI01Qq2tDaqXGuIWJjQo0g6jKgVHCVtVJRxM9Ma+2zX2WrjP7
         lfUck61fd9msfD7SIv2EXD1Ay9iYLHN20TPnxNsGtF06BMg0p3GbjAywGWEZ+4N1ouar
         MGxPJSk/Zuc+YaXkc/e4M4lK6pUxYpfscjsUqHD+DIaq7N8JwzwCaoCd/W9e04Hw9Hug
         mOOdTs8Ks1+1rNHERUb5nV22uf8WHM2mugoPvFY9uWKDqPmIVfmzt2eZ0UqscAij6UJR
         Xztg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=aNJ4ZzchkmsFEJCJAmfwO0uSlWqcaYgXhsb9CiskJ5I=;
        b=OgRw+HOCr2uA1xt5TAx+jDrCgnMdsa/NsIsHOCdeLWafxSpOeVxdHD32MjRj7CMWQK
         fydiNYX6AJcucAx67oZDVv7+uyIEh6GFZUEak9hE/TvH1Hfodqd7LoxINGWBg6xt4G8h
         7bM+sjnNRrjMV7TeU9XNn4NnIdytJKTJYYa0Vw5jK+1suoaSMyrE4b51PBn7lvz8MVIa
         JebOl5WI+plFTlBEPAG76F40r7Epm5c3NwAvyuHI9Dv+C17ELYHSraHeNR7xAFaNEmD5
         b/ZHUd3/LiT+C1kKMYsrXkjLIbzqLFpjMQai3vuuPTze1DWWVXKz0AxQfEFIFtx4znyB
         FAiw==
X-Gm-Message-State: APjAAAWRJcfHmlQvRBeOcZBbXo2v6xo0QT3r6MYjfzzBNIoT8ZsXHk4a
        8fgk40wEFo2qEGH32Kv80Vo=
X-Google-Smtp-Source: APXvYqwziveBIyb0MqxBbvA3E2bwBajczD1lCIeNZ5Wktjuhw0eA/T7+aPe/r3lYgzhkqiI0dNUe2Q==
X-Received: by 2002:a5d:49cf:: with SMTP id t15mr28522235wrs.63.1572970450948;
        Tue, 05 Nov 2019 08:14:10 -0800 (PST)
Received: from [192.168.2.240] (host-92-22-7-224.as13285.net. [92.22.7.224])
        by smtp.gmail.com with ESMTPSA id g11sm2109265wmh.27.2019.11.05.08.14.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2019 08:14:10 -0800 (PST)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 3/5] reset: support the --pathspec-from-file option
To:     Alexandr Miloslavskiy via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.445.git.1572895605.gitgitgadget@gmail.com>
 <8d9f1fbc18346144a0c866a59891b652dcfe9b7f.1572895605.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <3cee48dd-15bb-1bec-6d23-d05cce0f4eb1@gmail.com>
Date:   Tue, 5 Nov 2019 16:14:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <8d9f1fbc18346144a0c866a59891b652dcfe9b7f.1572895605.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alexandr

On 04/11/2019 19:26, Alexandr Miloslavskiy via GitGitGadget wrote:
> From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
> [...]
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

One thing I forgot to mention before is that if you're going to add 
these options to a number of commands then maybe it is worth defining a 
macro for each one in parse-options.h. There are a couple of examples of 
this at the end of that file.

Best Wishes

Phillip

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
> +
> +		if (pathspec.nr)
> +			die(_("--pathspec-from-file is incompatible with path arguments"));
> +
> +		parse_pathspec_file(&pathspec, 0,
> +				    PATHSPEC_PREFER_FULL,
> +				    prefix, pathspec_from_file, pathspec_file_null);
> +	} else if (pathspec_file_null)
> +		die(_("--pathspec-file-null requires --pathspec-from-file"));
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
> +
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
> +	restore_checkpoint &&
> +
> +	git rm fileA.t &&
> +	echo fileA.t >list &&
> +	test_must_fail git reset --soft --pathspec-from-file=list &&
> +	test_must_fail git reset --hard --pathspec-from-file=list
> +'
> +
> +test_expect_success 'only touches what was listed' '
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
