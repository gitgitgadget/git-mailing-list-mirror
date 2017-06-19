Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05D511FA7B
	for <e@80x24.org>; Mon, 19 Jun 2017 16:37:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751758AbdFSQhE (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 12:37:04 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:32962 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750757AbdFSQhD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 12:37:03 -0400
Received: by mail-pf0-f175.google.com with SMTP id 83so56223503pfr.0
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 09:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=N0+U5mNnEgHrYTXfVuj1xq0RIBCz1rMaNylDrxMm9es=;
        b=WHcxt7G/6eFrdd9hrV1wq66cSyZJXLsS/dI4YdeqCKRK1ady724H4pQTGUqraUgxu5
         N2s1FK1ca/P39+VILZKq0uh4GJ3Tmij7thIvhgDA1BXlIbGxu7t+c/Urji1J3JFdbPHg
         si4o6iGgk6ujgajK+TH98FJK+JZEn912sc/rcdzWKK4RR9A+rOMXTmuFzWk15dLT//OY
         oKUUGY4OOw3wXrSOR5bkwRn6LsltnR28gLtdutcYDvJ5ZeneCnHe5IXxhKN60p/KUWG1
         qGFT1b/unLNQsPhchy9Wv6brqBYlUJZLqNbTwFaowsWWItAs136WLHygFkU5NUUovvn2
         YHzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=N0+U5mNnEgHrYTXfVuj1xq0RIBCz1rMaNylDrxMm9es=;
        b=asZKL2KiKw1Htal0AoA1k2PJRKo0j0elOA/Eqlt1ikfPmtLXoNwvuPmN8awJAJj1lV
         zgMf46m85jLknusuX5JZqn5jisI7Dm8XryMuxSfGnIfjlQ1vQCJE8sSGsmp/c5U00nH5
         z4GdVRDdRTcHnRAgeCV1MkAip74ZPRF9uGKB603NOQV5xnHE7yRbFqVC6lY5AUE+t8Ux
         1EIh1SbkyautH2UoqCzEKFGigNT/Fn6djjyYY3wbxVI1xvgyqK7J69slDWLZWC65okel
         uZyTcEs557j3t5dBB+emdGGj7W2JkVpLNdxdgRDEerIDh/nGPFPXHy0jCS9h5ERhoMzY
         Hyag==
X-Gm-Message-State: AKS2vOyIrwrMwMaKKGzS0opNqmgjTaN+mIHBsbe01KsCl+czzgMGlHDY
        RYKwcf+8vavweSsDfUWLp0SYidKP+pmE
X-Received: by 10.99.55.83 with SMTP id g19mr4310434pgn.243.1497890222218;
 Mon, 19 Jun 2017 09:37:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.218.134 with HTTP; Mon, 19 Jun 2017 09:37:01 -0700 (PDT)
In-Reply-To: <0092CDD27C5F9D418B0F3E9B5D05BE080102887B@SBS2011.opfingen.plc2.de>
References: <0092CDD27C5F9D418B0F3E9B5D05BE08010287DF@SBS2011.opfingen.plc2.de>
 <88AC6179-75D6-416B-9235-C628D6C59CA5@gmail.com> <0092CDD27C5F9D418B0F3E9B5D05BE080102887B@SBS2011.opfingen.plc2.de>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 19 Jun 2017 09:37:01 -0700
Message-ID: <CAGZ79kY0gwk7KRY2iAVTXPBjPzx+mkciVWRR2z2cDgiBjQ2uuw@mail.gmail.com>
Subject: Re: Restoring detached HEADs after Git operations
To:     Patrick Lehmann <Patrick.Lehmann@plc2.de>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Git Mailinglist <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 19, 2017 at 2:52 AM, Patrick Lehmann
<Patrick.Lehmann@plc2.de> wrote:
> Hello Lars,
>
> for your questions:
>> If there are multiple branches with the same hash then your script would pick the first one. Can you imagine a situation where this would be a problem?
>
> I can't think of a good solution to resolve it automatically. Maybe a script could print that there are multiple possibilities and it choose the first branch in the list.
>
>
>> Plus, you are looking only at local branches. Wouldn't it make sense to look at remote branches, too?
>
> This is also related to restoring tags. If we go this way, we should have this priority list:
> - local branches
> - remote branches

For remote branches you would create a local branch of the same name
(if such a branch would not exist, possibly setting it up to track that remote
branch)?

> - tags

as said in the other email and similar to remote branches, we'd not want to have
HEAD pointing to them directly but somehow have a local branch.

>> Submodule processing is already quite slow if you have many of them. I wonder how much this approach would affect the performance.
>
> Yes. It takes a few seconds to iterate all the submodules. It could be improved if the processing wouldn't be based on slow Bash scripts spawning lot's of sub-shells to execute multiple Git commands.

How many submodules are we talking about? (Are you on Windows to make
shell even more fun?)
