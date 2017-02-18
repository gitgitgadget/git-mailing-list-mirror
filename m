Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C480F201B0
	for <e@80x24.org>; Sat, 18 Feb 2017 18:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753468AbdBRSgq (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Feb 2017 13:36:46 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:37138 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753277AbdBRSgp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Feb 2017 13:36:45 -0500
Received: by mail-wm0-f53.google.com with SMTP id v77so28844514wmv.0
        for <git@vger.kernel.org>; Sat, 18 Feb 2017 10:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gal-ro.20150623.gappssmtp.com; s=20150623;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Fj/d/x0B8RD0jYbAY3fQljFnDr5DQq/Aq9tjA/+A2R4=;
        b=wh5pnOYcKFyZMXZx7PSfLI/NkmioQ6FzFLEXm/KT0E3GH8V9kalJEnfxbbFiHiuHe3
         HL8jWjGiSqTe5EA0DVS8MpsnwvGPvZ5sdMl5lVKPKmfU2aETzqOOfboRjNVJTT3FAdyO
         LuCmdMcdTkn+V6ceRkTBYMcWhjLFtlqVx24hSIhK9I2Gud3VRP3mqwbkxn6Iw7IH1KGj
         cVMJc2uYdrGv4UK3o7f9MQ+4vkHIslm6lf0lenWCiyGx2ouX1BXuEv3dSjf/1c0McWLI
         20v0vskTYgy0W4dANErRiprX4UBcXrJYzzw++lg4NhxdaHHKR7/IM7cK2nImnxAaaghm
         rmug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Fj/d/x0B8RD0jYbAY3fQljFnDr5DQq/Aq9tjA/+A2R4=;
        b=Hlafmtr42sIWzwX9A0JnhOk6DYlkjg7oPhyBp9iwzLZG4Eh/kTzVNeD7zrx80KiEBu
         30JtpoN9pUzqcQV+/+XE16P9sRVg/ir0qctwom2M4p4ufitv8u/7xd6ZQxGswJvFO07W
         p3L9+ltVorcf128xdp1Uk/2jPEbz4QYzydHMeazsxGVr93ZNh172/LgmhIBeILctJW8u
         ACnY1iSKgQxsDr7E/1C6XYjqqRYdu8jvHgtxHU/ceDUwYi8mI/M/GwIQBvPIlPf/XjA2
         w5nsZnTwUBNyZs1XZ/SSvpdV3pmN5fHYrlKQM0biAQY78REjZgr81csK48Tv73HdvM01
         b35A==
X-Gm-Message-State: AMke39nG7m9KbiFhsNwV6NQ1FLZUFsaF8SMACFLEPfDSBn7hs/Ky2ue8dK/G/YqNX2UhOH8O2CMtyReU/XBi0g==
X-Received: by 10.28.216.130 with SMTP id p124mr5611954wmg.58.1487443003494;
 Sat, 18 Feb 2017 10:36:43 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.226.6 with HTTP; Sat, 18 Feb 2017 10:36:43 -0800 (PST)
X-Originating-IP: [77.178.91.90]
In-Reply-To: <477d3533-d453-9499-e06e-72f45488d421@kdbg.org>
References: <CAMX8fZWe2HO78ySonHX0adtPUxVPbj5_vo-NUGrjwpb7gPdGrQ@mail.gmail.com>
 <d4991e4b-cbc4-da14-381a-88704e457a19@gmx.net> <3ff5ce3c-285f-cb9a-d1d4-46323524dab7@kdbg.org>
 <CAMX8fZVkBU6M8fkUcRr69V97_NTSOGGmPB1U-ObhmVv3i6wQhg@mail.gmail.com> <477d3533-d453-9499-e06e-72f45488d421@kdbg.org>
From:   Alex Hoffman <spec@gal.ro>
Date:   Sat, 18 Feb 2017 19:36:43 +0100
X-Google-Sender-Auth: zo91R-Fsyro3p7_8J8XPqe3r_h8
Message-ID: <CAMX8fZW2y+iPRfSbXVcHufbM+CsqgekS_0WnCEJ++=njy_TvKg@mail.gmail.com>
Subject: Re: Git bisect does not find commit introducing the bug
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Stephan Beyer <s-beyer@gmx.net>, git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> But this is not how Git works. Git computes graph differences, i.e., it
> subtracts from the commits reachable from v.bad those that are reachable
> from v.good. This leaves more than just those on some path from v.good to
> v.bad. And it should work this way. Consider this history:
>
> --o--o--o--G--X
>    \           \
>     x--x--x--x--X--B--
>
> When you find B bad and G good, than any one of the x or X may have
> introduced the breakage, not just one of the X.
>

Thank you for clarifying how git bisect works. How did you find that
out? Did you check the source code? If that is not documented in the
man page may be it worth documenting it in order to avoid future
confusion for other users.

Let's consider your example with distinct names for nodes:

--o1--o2--o3--G--X1
    \                \
     x1--x2--x3--x4--X1--B--

It makes sense that git bisect is expecting a single transition, as
this is a precondition for a binary search to work. My definition of
"the transition" is a commit with at least one of its parents as a
good version, but the commit itself a bad version. I hope we agree
that git bisect's mission is to search for this transition (as I
suppose that most of people need such a functionality from git, if not
exactly from git bisect). How could be x1 or x3 be the transition, if
chances are that o1 is not a good version? Of course it would make
sense to me if bisect would check o1 whether good and only then to
check also x1-x3, but this is not what git makes (at least not in my
initial example).

If you consider that git bisect's mission is different from finding
the transition, could you please explain what exact commit git bisect
is supposed to return (ideally with terms from the graph theory) and
when it makes sense to return that? Because I do not see any sense in
looking in the path x1-x3 without knowing that those commits may be a
transition.


> Oh, IMO git bisect was well thought through. If it considered just paths
> from good to bad, it would not given the correct answer. See the example
> history above. Bisect authors would not have deemed that sufficiently good

You definitely convinced me that git MUST search more than only in the
paths between good and bad commits, as the good commit G does not have
to be the first good commit (thank you for that). My problem/confusion
is that it returns something that does not make sense to me, because
it does not make sure it returns a transition.

VG

PS: thank you for continuing this discussion.
