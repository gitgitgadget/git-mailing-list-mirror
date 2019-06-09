Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27E641F462
	for <e@80x24.org>; Sun,  9 Jun 2019 19:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbfFITXV (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Jun 2019 15:23:21 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45888 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729115AbfFITXU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Jun 2019 15:23:20 -0400
Received: by mail-pf1-f195.google.com with SMTP id s11so3972996pfm.12
        for <git@vger.kernel.org>; Sun, 09 Jun 2019 12:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XUTLBNPSOBXVsO5dZQ461DI+juhfRqCFVj8GnB8r0r0=;
        b=tSyOtFZVAI+sZwhkJo2BdLATn4/nXTkNELOgeLy08Zmo/TEJM351IP23cFUsZUj8XX
         TXHGl718ODzms0/FDCU1/7335A+gpHHL4pmd4vbqhUt5DnZcqAXCC0efTg4ctvPAfjY8
         Vs6130qJa9FBZ8s+Z0e4KjPyumUo8e1kN4C4zQrK/A2/uvHiIM3a5g2QnJotiDSYNnFv
         IpzDDoXu6FkNC8U7SWJqgvxsFLCCpX8RwAGaTxBzQ4bddkhcw1JzuvVAQ1ru/hPMiib+
         Tq3aH8eqWyh/YEmfKGsgLLpeR4lMOpLNN3uYgpYKYV5FSd3bAc97iH9oeeRIZqDr2PGw
         AWEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XUTLBNPSOBXVsO5dZQ461DI+juhfRqCFVj8GnB8r0r0=;
        b=dS44DIsRVtaCxj5zSU4psJxovdtlkF8U8VWLxM6G65bidNpKqzWFRUxLclY+qWitwc
         xpY5j7hs5CzWo7qItsPtelyv6kia+7N1S8m6aUMBFt0bxtoKd48c3xalTfOpB1aXNZzJ
         fsAIht3PvrPE7cypnNc0fJGVvdeUR8+TK/W5Bktq/sxvy/nvXLdDaT1YyD79DOWEBf5P
         CnVZ8YnHNhXbwyVqJvUggnQeBEDjFltC2/3GMiZPSrfffobQWd69E7424aHRtJTY8c50
         COvJepB4uxQUN4FdWdGxjxPRHlggnWroJiuglUTy8H9JLge8SDNfAU4yEWbGMQT4tFqD
         Bevw==
X-Gm-Message-State: APjAAAWxLuHAqe8aOjZqrsqw+Q+/Am4bfhSCxCZkjDyu9/ksrdIcatpP
        zBQIDAUSDKk1MevDsott+YxqCra6ixyrpHRMyUw=
X-Google-Smtp-Source: APXvYqzuEKpM2ATLWPpCwzkNexER1vuz+n61QTgLNzocuN5oWf2+q2rG41fxmwFEN60d8Fe8k1dosO8nL1puOgG9vRc=
X-Received: by 2002:a63:a044:: with SMTP id u4mr11588540pgn.316.1560108200245;
 Sun, 09 Jun 2019 12:23:20 -0700 (PDT)
MIME-Version: 1.0
References: <pull.151.git.gitgitgadget@gmail.com> <1dd56d034efb6ff251bdac8d099052175f4777a0.1560005022.git.gitgitgadget@gmail.com>
In-Reply-To: <1dd56d034efb6ff251bdac8d099052175f4777a0.1560005022.git.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sun, 9 Jun 2019 21:23:08 +0200
Message-ID: <CAN0heSrQ-AVui0OzpL7WGBzmdU4ignUsFxYqeXDtgR+CsDXbJw@mail.gmail.com>
Subject: Re: [PATCH 1/1] t0001: fix on case-insensitive filesystems
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Sat, 8 Jun 2019 at 16:45, Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> On a case-insensitive filesystem, such as HFS+ or NTFS, it is possible
> that the idea Bash has of the current directory differs in case from
> what Git thinks it is. That's totally okay, though, and we should not
> expect otherwise.

> +downcase_on_case_insensitive_fs () {
> +       test false = "$(git config --get core.filemode)" || return 0

I think it would be worthwhile to add `--type=bool` to this git-config
call. See, e.g., the FILEMODE prereq in t/test-lib.sh. From my
understanding, this check would regress if someone did s/false/no/ in
builtin/init-db.c, so this check is perhaps not as robust as it could
be. (Now, as for *why* someone would do such a change...)

I do wonder if this is the right way to check for a case-insensitive
filesystem. According to git-config(1), this variable tells whether "the
executable bit of files in the working tree is to be honored". I can see
how this property could correlate with the filesystem being
case-insensitive, but from git-config(1), I would have expected
core.ignoreCase to be queried instead.

You're no doubt a lot more familiar with filesystem case-insensitivity and
how it interacts with Git than I am. Any light you could shed on this
would be much appreciated.

> +       for f
> +       do
> +               tr A-Z a-z <"$f" >"$f".downcased &&
> +               mv -f "$f".downcased "$f" || return 1

Makes sense. Good error-handling.

> +       done
> +}

Cheers
Martin
