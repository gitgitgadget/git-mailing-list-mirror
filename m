Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2190208EB
	for <e@80x24.org>; Tue,  7 Aug 2018 19:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390234AbeHGVoi (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Aug 2018 17:44:38 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33561 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729922AbeHGVoh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Aug 2018 17:44:37 -0400
Received: by mail-ed1-f66.google.com with SMTP id x5-v6so137964edr.0
        for <git@vger.kernel.org>; Tue, 07 Aug 2018 12:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=KoFVcWNePFqjheo3XlXSt3Lo/GFR51lJwdIj6ovJ1LQ=;
        b=oQ1eZfuLlTpdfIItpT5E5bavxn7qaRr3Z04XbaGvsazBt0AOtVLz5O+dt35ldO2wLR
         MvYJiGQZm4X2Mhf7qPxVI231cTV1lsZ0IRn3IURVjTFCXXn+71OnBySvydBlZ1keq02T
         1svVSvw7FA8III1A12DvLwbgIUu5i31jS67T0cC/S4vQDVDtKli1aO6WBiX1+VFggGaw
         RZAPeiQvRCAhRM9XTrcG8t1L7Gj50izURO33oqluxdhXnwkkIBJv6/bGj28loP/pfJCX
         IH+cIpKx2daTcs+VomFotv11Eo5cu7CjiX9ToxWR4MApGpuMxZeDjCXceFsCjq930o8s
         Ljpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=KoFVcWNePFqjheo3XlXSt3Lo/GFR51lJwdIj6ovJ1LQ=;
        b=lZQTBvOLYdp6kERGXzGIgoRQfgwE57r6kUQUxhQQuR7Ais7/a8HIDOjs1Yuhi5j91r
         21l2g7zxe7LMvcaaD5Gqhwou3JvISX/Uq1k91+tSMTIXEv6e17Wgup5esR25eGARkiEG
         n8OwjNtKt17NWVL9VbBkPgOspe06kkj3iEvW6EA6pnhixOiuUQlAPShYAfSrhx5LnSxj
         Ybmoo1PDcJKjy2UblnChdWcoOYwRtDzMt3X0CjbOm+wFnce/7bXNs4jC4HkYfG3+u9Jt
         6KsX7dzkBLfmDw9JzTzZ2iUFEEz829uuQjOAApoHA0w/5U61RBALZyZ69IizU4BIVfuS
         XWmw==
X-Gm-Message-State: AOUpUlHjygkRYxEmCTGFTpeiKufL9QCryylJWrGx+//Gj86dJUDgJe6X
        /okKVnyzOpApNPNYmxpLiNA=
X-Google-Smtp-Source: AAOMgpdtDlLDhw93QTYkb4ZRtdLSXPRAuOfxAJv06TV2VwwUnULYUd9TTTI1N2mcx2os1P32zHDfew==
X-Received: by 2002:a50:afa3:: with SMTP id h32-v6mr24119227edd.129.1533670123925;
        Tue, 07 Aug 2018 12:28:43 -0700 (PDT)
Received: from evledraar (h98111.upc-h.chello.nl. [62.194.98.111])
        by smtp.gmail.com with ESMTPSA id l22-v6sm1451253eda.41.2018.08.07.12.28.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 12:28:42 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] pull --rebase=<type>: allow single-letter abbreviations for the type
References: <pull.14.git.gitgitgadget@gmail.com> <d2ba1e6bef9d6d4eabc8eaa60435dcae1105fd07.1533410586.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <d2ba1e6bef9d6d4eabc8eaa60435dcae1105fd07.1533410586.git.gitgitgadget@gmail.com>
Date:   Tue, 07 Aug 2018 21:28:42 +0200
Message-ID: <87sh3qrn6d.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Aug 04 2018, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Git for Windows' original 4aa8b8c8283 (Teach 'git pull' to handle
> --rebase=interactive, 2011-10-21) had support for the very convenient
> abbreviation
>
> 	git pull --rebase=i
>
> which was later lost when it was ported to the builtin `git pull`, and
> it was not introduced before the patch eventually made it into Git as
> f5eb87b98dd (pull: allow interactive rebase with --rebase=interactive,
> 2016-01-13).
>
> However, it is *really* a useful short hand for the occasional rebasing
> pull on branches that do not usually want to be rebased.
>
> So let's reintroduce this convenience, at long last.

I agree with the shorthand, but I really think this should be
documented. The amount of people who'll discover this by reading the
code is much smaller than those who might discover it via the docs.

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/pull.c  |  6 +++---
>  t/t5520-pull.sh | 12 ++++++++++++
>  2 files changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/pull.c b/builtin/pull.c
> index 4e7893539..53bc5facf 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -48,11 +48,11 @@ static enum rebase_type parse_config_rebase(const char *key, const char *value,
>  		return REBASE_FALSE;
>  	else if (v > 0)
>  		return REBASE_TRUE;
> -	else if (!strcmp(value, "preserve"))
> +	else if (!strcmp(value, "preserve") || !strcmp(value, "p"))
>  		return REBASE_PRESERVE;
> -	else if (!strcmp(value, "merges"))
> +	else if (!strcmp(value, "merges") || !strcmp(value, "m"))
>  		return REBASE_MERGES;
> -	else if (!strcmp(value, "interactive"))
> +	else if (!strcmp(value, "interactive") || !strcmp(value, "i"))
>  		return REBASE_INTERACTIVE;

Here 3 special cases are added...

>  	if (fatal)
> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> index 68aa5f034..5e501c8b0 100755
> --- a/t/t5520-pull.sh
> +++ b/t/t5520-pull.sh
> @@ -475,10 +475,22 @@ test_expect_success 'pull.rebase=interactive' '
>  	false
>  	EOF
>  	test_set_editor "$TRASH_DIRECTORY/fake-editor" &&
> +	test_when_finished "test_might_fail git rebase --abort" &&
>  	test_must_fail git pull --rebase=interactive . copy &&
>  	test "I was here" = "$(cat fake.out)"
>  '
>
> +test_expect_success 'pull --rebase=i' '
> +	write_script "$TRASH_DIRECTORY/fake-editor" <<-\EOF &&
> +	echo I was here, too >fake.out &&
> +	false
> +	EOF
> +	test_set_editor "$TRASH_DIRECTORY/fake-editor" &&
> +	test_when_finished "test_might_fail git rebase --abort" &&
> +	test_must_fail git pull --rebase=i . copy &&
> +	test "I was here, too" = "$(cat fake.out)"
> +'
> +
>  test_expect_success 'pull.rebase=invalid fails' '
>  	git reset --hard before-preserve-rebase &&
>  	test_config pull.rebase invalid &&

...but this test is only for 1/3. I haven't run this, but it looks like
the tests will still pass if we remove --rebase=p and --rebase=m.
