Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43C5B1FAD6
	for <e@80x24.org>; Mon, 11 Sep 2017 18:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751076AbdIKSLL (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Sep 2017 14:11:11 -0400
Received: from mail-wr0-f171.google.com ([209.85.128.171]:33185 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750853AbdIKSLK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2017 14:11:10 -0400
Received: by mail-wr0-f171.google.com with SMTP id a43so16320866wrc.0
        for <git@vger.kernel.org>; Mon, 11 Sep 2017 11:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=env3skuFGwRuOnygCppvZBvD8Z7E3dvPezqg/5L92mQ=;
        b=P8ID21Lct5icN573s+sB0H06a922ac+LpSqrWVxnAAGYmC5E8u9XRhTc7bnrgxJXYZ
         MJRmI3buadW4iiUv2Ozs3DbaLD+Ya/99VK6JnySd4f+6BWDTwDNzlwSkEpTCE/gSHK1g
         5/2NQBw4pwX8yNB9DMa7dJidcpRlnowBR25po3QgNo8ZTELI1PINJoPuigZBFcAcwnqA
         N0O6oZ1neLu+WeMKR+WZ7lWaB9dy41SN1CTwvVc5wvhUJS+iffSBxUmwkki6LmkwAno0
         FgJAFcoF6Dfo5fin+Cqq+1uLuvlB721M/9KDeTBCY6GYAHEfl5Jwp+dVJkiJLmxsJfRh
         QrWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=env3skuFGwRuOnygCppvZBvD8Z7E3dvPezqg/5L92mQ=;
        b=dPFwmaiiRJE/FQlzuckugOML3aa5ZnlmrrL/ldZmR7JTUnCmeTR0VAxx5IXNqGE29A
         vMCMs4era7wTpGwTqsE1WoLx6uPwGiELAhP9M1misPls9tb4tMM5rRg3WFFEoKoTnBPB
         bEQw2l7Q9wlEthOy2ylGdWVYlesOgLpwC1xrx0m5prgrDt6BEC2EozqOnS9VNPbpRcIU
         TOaZnRZ77auuX/16kNuVjfqKDwQmXLGRUYszRnTwm3yEjBxJXFVYMmpEi4dvYr+x9TFG
         FZDEa10gb1qD8kRYA8HKhixp8u6XOlb9rU6VlxxEUkbkTpXKQfa09iTkUX00focNP+o1
         6S2g==
X-Gm-Message-State: AHPjjUhXyGHZYM26LIEmJ5zSfX88gG4Jw/A9HKRGx5FDqV3SVnypUWeS
        Dg0Ekgq1VMm5wzLbbnEeOTdTz4raHKrMRHJxFw==
X-Google-Smtp-Source: ADKCNb7LryWYluMKleJE0u+klY8VFl6zIcKOiBDbDtgYI8eVWTb9HYSL1tuPDzla3nCh0OvfvYBtb1JCRkI2k0JQyYk=
X-Received: by 10.223.150.27 with SMTP id b27mr9265688wra.100.1505153469064;
 Mon, 11 Sep 2017 11:11:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.170.68 with HTTP; Mon, 11 Sep 2017 11:11:08 -0700 (PDT)
In-Reply-To: <CAOZF3=Ouvk8ccME+fXr_T=GL1j4Gx3Hgj3ao_-GQng-noeOubg@mail.gmail.com>
References: <CAOZF3=Ouvk8ccME+fXr_T=GL1j4Gx3Hgj3ao_-GQng-noeOubg@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 11 Sep 2017 11:11:08 -0700
Message-ID: <CAGZ79kacL7TodpBFmrPJtasjXYVKTVDb-FmM5QJyAPS-+NYf7w@mail.gmail.com>
Subject: Re: [idea] File history tracking hints
To:     Pavel Kretov <firegurafiku@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 11, 2017 at 12:11 AM, Pavel Kretov <firegurafiku@gmail.com> wrote:
> Hi all,
>
> Excuse me if the topic I'm going to raise here has been already discussed
> on the mailing list, forums, or IRC, but I couldn't find anything related.
>
>
> The problem:
>
> Git, being "a stupid content tracker", doesn't try to keep an eye on
> operations which happens to individual files; things like file renames
> aren't recorded during commit, but heuristically detected later.
>
> Unfortunately, the heuristic can only deal with simple file renames with
> no substantial content changes; it's helpless when you:
>
>  - rename file and change it's content significantly;
>  - split single file into several files;
>  - merge several files into another;
>  - copy entire file from another commit, and do other things like these.
>
> However, if we're able to preserve this information, it's possible
> not only to do more accurate 'git blame', but also merge revisions with
> fewer conflicts.
>
>
> The proposal:
>
> The idea is to let user give hints about what was changed during
> the commit. For example, if user did a rename which wasn't automatically
> detected, he would append something like the following to his commit
> message:
>
>     Tracking-hints: rename dev-vcs/git/git-1.0.ebuild ->
> dev-vcs/git/git-2.0.ebuild
>
> or (if full paths of affected files can be unambiguously omitted):
>
>     Tracking-hints: rename git-1.0.ebuild -> git-2.0.ebuild
>
> There may be other hint types:
>
>     Tracking-hint: recreate LICENSE.txt
>     Tracking-hint: split main.c -> main.c cmdline.c
>     Tracking-hint: merge linalg.py <- vector.py matrix.py
>
> or even something like this:
>
>     Tracking-hint: copy json.py <-
> libs/json.py@4db88291251151d8c5c8e4f20430fa4def2cb2ed
>
> If file transformation cannot be described by a single tracking hint, it shall
> be possible to specify a sequence of hints at once:
>
>     Tracking-hint:
>         split Utils.java -> AppHelpers.java StringHelpers.java
>         recreate Utils.java
>
> Note that in the above example the order of operations really matters, so
> both lines have to reside in one 'Tracking-hint' block.
>
> * * *
>
> How do you think, is this idea worth implementing?
> Any other thoughts on this?
>
> -- Pavel Kretov.

This was discussed a couple of times on the mailing list
(though not recently).

I searched for "rename tracking files site:public-inbox.org/git"
and came up with
https://public-inbox.org/git/Pine.LNX.4.58.0504141102430.7211@ppc970.osdl.org/
(the nearby emails seem to also be relevant to this discussion)

tl:dr: When encoding these hints, you do it at commit time,
but the heuristic can be improved upon later.
So you can assume the heuristic is better for the
common case, as someone will fix the heuristic for the
common case. Also Gits model is to track objects.
