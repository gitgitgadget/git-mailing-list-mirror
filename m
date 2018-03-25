Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1C7B1F404
	for <e@80x24.org>; Sun, 25 Mar 2018 04:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751011AbeCYE2c (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 00:28:32 -0400
Received: from mail-qt0-f170.google.com ([209.85.216.170]:41278 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750989AbeCYE2b (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 00:28:31 -0400
Received: by mail-qt0-f170.google.com with SMTP id d18so4086124qtl.8
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 21:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=jntrpwUTnqyuWyKgx+/GlGZySkApiVmCDgWMI5LSUzc=;
        b=ueB+HKtUqghyND5B80it+25hPC+alYKuoceefEed5Jy672IBclLgX8q4sEao5oiaSy
         jTQl35U+KhilXpv6xRbQTxPFg4cstrEeYzQmGCT88MHU4/NR25hbSR11cYRUnhB2dwGV
         KgGgBWA0GhPffz3mDNGbkeY2S1ck1ZIn8VlJV1YEtF5Xt+4fCmkI8CnjnOQRGbHjH1ik
         AXHc6s8pEivStzI64SBn/KaqZSYD5BFxd7Z8XdvOBycuCJ7yUycb8adL8LLvY9D43sQD
         Tx7cDHAq4I6ZnHtlm5ZrO8+YbjrxtH4eCqxzBntXOXLgpWb13A5MT0sDqioSXR+VPwmY
         oVZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=jntrpwUTnqyuWyKgx+/GlGZySkApiVmCDgWMI5LSUzc=;
        b=A6FgZ3VPE/ZrrWBeIBHy1c2j9M3sOwfLsf2JRQTbv5VAAIKqQWFampYNNt/sqOqQlk
         zXI9nAbdKUlCHBG0PkvCeK+9Xv9UzURoN+ynqvM4o+ySAioKQswtDiQfY0qPe2uKlSLz
         29cMOyWehAZAoWFy7qW39LSOJsVLlsnoXXaU4VfCufujMKJ2iAqGwZhtk19kSU7g3OEC
         go3kYjpHJ9B1OnNeCEU6ftBvfjPqqJyBbTgHVs08h4dicSX/1av+nfeoMp8y9nqXpWyk
         LFID4qxOsfidkQ0U9ZUMgkRjTIrlNpi7Ff4t2WzghuWWDHCZc3td59IL+tk+0yBKpc6A
         tOhA==
X-Gm-Message-State: AElRT7Fl4TpNdJIYwmEwAMd4wN5UT+DGF2W+sBUE9qalvmFkPgpgPe+x
        FT7190e9QRcczB06JgawAYr+/YhL4cr2s4NCMMk=
X-Google-Smtp-Source: AG47ELsPLomYFjvTrm33m0N45P8yLBRFCL27L36eGMCiT9wrsljT4z3whuXPPKniMrMDKwL1To0B9Ddf7hBwl//oxcY=
X-Received: by 10.200.50.174 with SMTP id z43mr47913371qta.250.1521952111174;
 Sat, 24 Mar 2018 21:28:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Sat, 24 Mar 2018 21:28:30 -0700 (PDT)
In-Reply-To: <20180325041056.GA22321@sigill.intra.peff.net>
References: <20180324183844.4565-1-kaartic.sivaraam@gmail.com>
 <CAPig+cQ8xw23SGhpx5qtDEyzJGR1v4L2Lm9tEWe56Rh3c8Q3cg@mail.gmail.com>
 <87ea8cac-c745-b7e6-7804-5116cd94ed48@gmail.com> <20180325041056.GA22321@sigill.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 25 Mar 2018 00:28:30 -0400
X-Google-Sender-Auth: 06E2mN9-exdSr389rB9GhOR8JDQ
Message-ID: <CAPig+cRe9AmFv=GCxPOo5vcLGFuT1qdM60M4KV5P6UN+Ai-QoQ@mail.gmail.com>
Subject: Re: [PATCH] branch -l: print useful info whilst rebasing a non-local branch
To:     Jeff King <peff@peff.net>
Cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 25, 2018 at 12:10 AM, Jeff King <peff@peff.net> wrote:
> Alternatively, we could at least detect the situation that confused you:
>
> diff --git a/builtin/branch.c b/builtin/branch.c
> @@ -676,6 +676,9 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
> +       if (list && reflog)
> +               die(_("--reflog in list mode does not make sense"));
> +
>
> That doesn't help somebody mistakenly doing "git branch -l foo", but
> more likely they'd do "git branch -l jk/*" if they were trying to list
> branches (and then "branch" would barf with "that's not a valid branch
> name", though that may still leave them quite confused).

Assuming that existing clients of "-l" (if there are any) only invoke
"git branch -l <name>" to create a new branch, then it would be
possible to interpret "-l" as --list when <name> is an existing
branch. That is, the "-l" in "git branch -l" and "git branch -l
<existing-branch>..." is recognized as --list, and (for backward
compatibility only) the "-l" in "git branch -l <new-branch>" is still
recognized as --create-reflog.

This idea falls flat, however, if there are clients out there which
actually depend upon "git branch -l <existing-branch>" failing.
