Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0BCE1F4C0
	for <e@80x24.org>; Fri, 25 Oct 2019 00:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732103AbfJYAMq (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 20:12:46 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36209 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729514AbfJYAMq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 20:12:46 -0400
Received: by mail-ot1-f67.google.com with SMTP id c7so627277otm.3
        for <git@vger.kernel.org>; Thu, 24 Oct 2019 17:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tkBjKl9r5HJrqyVPkq9pDQ9eyWec4KFKO6vpfKSbL14=;
        b=rLb/1GDJq1VYh2kHta3t0fbS/2IfiVX0Vc71Mn0z1qni4RxAAOuZhgfOAilUu6FbYS
         kgkmFcmwM+fCNpV5iAd8M7loNxK260CRgNveAKDTCKGeckWN2gTK/eK18AMENecCG8t9
         xKHGCM5tl+ohBKoCq2MNrEF+NVvVoYVk6jiLNP3AEXqpPEQGNQZCfdWxqHK3lMD9wr7X
         uoGnBU5hGGWUmm6Zpgpk+y2/DS1Y+rd3Mnm6o91s1xoVBYN+S6fR16MfddL1H+Xar1bk
         xunGV/QfJfD+JrRKAwJ3kWaUNPC39jQX+cDOp2ScmuCvXETBm3c9V6M3hNy+inVGl+e2
         AKSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tkBjKl9r5HJrqyVPkq9pDQ9eyWec4KFKO6vpfKSbL14=;
        b=EGEQ6U5WtjuAlPRyXMqQpxwgpwecxZ2bIBqf0VulL7TocHCmiBZbr4G4krYjWgpoZG
         TlT4nPu8e4u/VzaQ9Wc6uVHWu87Y29sG7b+ZIGxBIdkH8SHB7WzAla6uCGiZJooTEVMR
         wbj0nG3El3nKYsfU++Eg/9IgFexi0ERyHCfmD2cHU2ykH+1pVFaA7bNWTzjrHofzbgLw
         pWwr/FSIdNQ4uct4GmOY5HyOahPm6JuLRgv+6RaVuCxp0SXlMBUvDPxDsym/qlXllfK7
         P0k6yL6+pmplkuU1GhsxAUYKSgISHNVDpUynP159/q16w5RLk9KIIGNF+1ibf3k3s7ud
         /KpA==
X-Gm-Message-State: APjAAAVLYcQziSuQitvMPq56UJ/C7xh1pamDFntlM2giEuCHa1PIqBmC
        aQ++0Rdr535sgIcyT6syG8a3+gIkS0FKwra7gS8=
X-Google-Smtp-Source: APXvYqysK8YL5shuaBmp8wrwI6RF8WUp69eMAWDBt36AUhHc1ELMLNvqjsZqAtdseDEUbg5TXykrvmhgcfwR3Efk3IA=
X-Received: by 2002:a05:6830:457:: with SMTP id d23mr462363otc.267.1571962365214;
 Thu, 24 Oct 2019 17:12:45 -0700 (PDT)
MIME-Version: 1.0
References: <pull.390.git.gitgitgadget@gmail.com> <37aee862e14b1352eb08485f15ea06bab33679df.1570826543.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.1910122152210.3272@tvgsbejvaqbjf.bet> <CABPp-BFNCLJnt4NgFKVxURBGD1Z00gastc5q4ZPjcHmwS=kuFw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1910141211130.46@tvgsbejvaqbjf.bet> <CABPp-BFYWhyLqUktEnk6A7v6135k4TQHO20Wiy32mRQekt-3cg@mail.gmail.com>
 <nycvar.QRO.7.76.6.1910250020220.46@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1910250020220.46@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 24 Oct 2019 17:12:33 -0700
Message-ID: <CABPp-BHBUKq73Ru3D9HKp6ABo8eQNmkSkz6MjA+4J2a6xxtWjA@mail.gmail.com>
Subject: Re: [PATCH 2/2] merge-recursive: fix merging a subdirectory into the
 root directory
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 24, 2019 at 3:23 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Elijah,
>
> On Tue, 22 Oct 2019, Elijah Newren wrote:
>
> > [...]
> > Yes, t6043 is pretty long code-wise, and still has over five dozen
> > tests after ditching the separate "setup" tests -- but all of those
> > tests still run in 3.6s on my box. [...]
>
> $ time sh t6043-*.sh --quiet
> not ok 74 - 9g-check: Renamed directory that only contained immediate subdirs, immediate subdirs renamed # TODO known breakage
> not ok 87 - 10e-check: Does git complain about untracked file that is not really in the way? # TODO known breakage
> # still have 2 known breakage(s)
> # passed all remaining 117 test(s)
> 1..119
>
> real    7m22.393s
> user    0m52.115s
> sys     3m53.212s
>
> And this is not a slow box. So yes, those extra spawned processes? They
> accumulate. Spawning processes is what Linux was optimized for. You're
> optimizing for Linux.
>
> Ciao,
> Dscho

Wow, I knew it'd be slower on other platforms but I certainly didn't
expect a factor of 122; you've made me eat my words about performance
for this case.

Still, I rely pretty heavily on t6036, t6042, t6043, and t6046 for
sanity in the face of refactoring and rewriting -- and as mentioned
before they have caught refactoring bugs in those areas that appear at
first blush as "overzealous", and have done so multiple times.  So,
what's the alternative -- mark the tests as linux only?  Do that but
also add a second copy that is trimmed down so other platforms can run
that one?  Keep a local copy of all these tests?  Jump on the
our-testing-pyramid-is-inverted bandwagon when it materializes and
provides a way to write unit tests instead of just end-to-end tests
(I'm game for that one...)?  Start discussing crazy ideas like a
busybox-like shell, possibly with git extensions (a "git shell" if you
will, though I know the name is already taken), just for running the
git testsuite faster?  Those alternatives all sound either unappealing
or like very large projects that'll take a while to materialize (and
which I certainly won't be spearheading; I've got too many big
backburnered projects already).  This performance is clearly bad, but
gutting the tests isn't tenable either.
