Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63DBB20133
	for <e@80x24.org>; Fri,  3 Mar 2017 21:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752507AbdCCVro (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 16:47:44 -0500
Received: from mail-io0-f173.google.com ([209.85.223.173]:35477 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752508AbdCCVrP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 16:47:15 -0500
Received: by mail-io0-f173.google.com with SMTP id z13so39225545iof.2
        for <git@vger.kernel.org>; Fri, 03 Mar 2017 13:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+qgfRk+F4fueDxWkWQtX7CnWz+SHl9CVwzyxhMAAKxE=;
        b=isiTanQn7gtC3peGBvF9L3G3cqSfD4w9JXVrrUA4Qc8/h0DIkBmPuP/4GXvfs8uWvc
         CJ0cgKAU2IMYPy2R0Lfz50Hq19xaur1fO4o1ar9DfcszpHc3SBkD/QDJBf3oj7r0tb8b
         nzGN6uYBGi4MtfwAxLsiN0w711/r1GPG1nzWdS5ImcQ8sltB6py139VdsuVfkeRaUYKs
         3snMD2BajzPuc1jDyDR7TQy+dIAk1PKj2nm7t9hPkgTYGP2OOCgfPg75Vlz7sCH2WEUJ
         ImDmpj8Nw4jl/SckYpenQf1Hh/BzDAOrWJ1LhlY7DqlDat9v57PlGYjgmRDDXKmyGR8Q
         OPtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+qgfRk+F4fueDxWkWQtX7CnWz+SHl9CVwzyxhMAAKxE=;
        b=EiVmtqKcbJKn5M2Aq8nJuBrrKCuR7HemR4uJCBulcdZnr2RpE/vgpvTv+Bn+mfHnU7
         7o1BsVRuQ+euu9hnnuPow1SX2hqaMvEj4aEc6ERrTc1YZw2AvjCFssX2jGE68q72CiaB
         LVS4QSHiZ6iPg6XEQ/J116Uj0ES03FBOCqYFKQAKBdEnpK/G3EE56bGFS871ICgz+IVv
         ZPv8l/yx/rZIhW68wg7BhZaZW0Kiv5EEJwbFkjOUT7BskaD2mLnMGRoqHWm9a3WypftC
         Zs5UxyfsxpUOPhLJrv67k2lJUVyfx6XyfjTwP6sRYZ1UwrtAWLJOja4BeZt41qbj61yk
         N+CA==
X-Gm-Message-State: AMke39nEGv3o2A5P2fsAlQp1MpjBIESW7NxXBPdsNe+N93FPaRUx3XiYSjg+JNcP2Nm287Ybsz3yKCtpV8eOCUtn
X-Received: by 10.107.37.148 with SMTP id l142mr4555004iol.159.1488577626634;
 Fri, 03 Mar 2017 13:47:06 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.13.1 with HTTP; Fri, 3 Mar 2017 13:47:06 -0800 (PST)
In-Reply-To: <CA+55aFwXaSAMF41Dz3u3nS+2S24umdUFv0+k+s18UyPoj+v31g@mail.gmail.com>
References: <20170223164306.spg2avxzukkggrpb@kitenet.net> <22704.19873.860148.22472@chiark.greenend.org.uk>
 <xmqq60jz5wbm.fsf@gitster.mtv.corp.google.com> <20170224233929.p2yckbc6ksyox5nu@sigill.intra.peff.net>
 <CA+55aFw6BLjPK-F0RGd9LT7X5xosKOXOxuhmKX65ZHn09r1xow@mail.gmail.com> <CA+55aFwXaSAMF41Dz3u3nS+2S24umdUFv0+k+s18UyPoj+v31g@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 3 Mar 2017 13:47:06 -0800
Message-ID: <CAGZ79kY+TwN5xp8R7-UHecuErkEmdpR-vnK8gU4zpaekCa1grQ@mail.gmail.com>
Subject: Re: SHA1 collisions found
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Ian Jackson <ijackson@chiark.greenend.org.uk>,
        Joey Hess <id@joeyh.name>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 2, 2017 at 11:55 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So: What do you think about the concept?
>
>                Linus

One of the things I like about working on Git is its pretty
high standard of testing. So we would need to come up with
good methods of testing this, e.g. when
GIT_TEST_WITH_DEGENERATE_HASH is set, we'd use
an intentionally weak hashing function and have tests for
the collisions. These tests would need cover most of the
workflows that are currently performed with Git
(local creation, fetching, pushing). Writing all these
additional tests (which consists of creating colliding
objects/commits and then performing all these tests),
sounds about as much work as actually converting to
a new hash function. (First locally and then at a later
point in time all the networking related things).

I would not want to go that way.

Stefan
