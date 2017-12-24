Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6A4B1F42B
	for <e@80x24.org>; Sun, 24 Dec 2017 23:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751305AbdLXXIk (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Dec 2017 18:08:40 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:60976 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751201AbdLXXIk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Dec 2017 18:08:40 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 85AD41F424;
        Sun, 24 Dec 2017 23:08:39 +0000 (UTC)
Date:   Sun, 24 Dec 2017 23:08:39 +0000
From:   Eric Wong <e@80x24.org>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [RFC/PATCH] perl: bump the required Perl version to 5.10.0 from
 5.8.0
Message-ID: <20171224230839.f6r66u37wj4ai3sj@untitled>
References: <20171223174400.26668-1-avarab@gmail.com>
 <20171224143831.GD23648@sigill.intra.peff.net>
 <871sjkrtrm.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871sjkrtrm.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> On Sun, Dec 24 2017, Jeff King jotted:
> > As far as this actual perl change goes, I don't have a strong opinion. I
> > agree it would be nice to eventually move forward, and your reasoning
> > about what constitutes "old" seems sane. But we also don't write much
> > perl in this project these days, and I don't see a lack of modern perl
> > features causing a lot of headaches.

Agreed.

> Yes, unlike with the curl patches it's not a big PITA to maintain
> compatibility with 5.8, it would just be easier to write new code &
> maintain old code and not have to be on guard about not using features
> one takes for grantend, and maintain compatibility with 5.8 versions of
> core modules.

As one of the more frequent Perl users here (even outside of
git.git), I never considered using 5.10+ features at all until
now.  Maybe 5.8 compatibility is just too ingrained into me and
much of the stuff I work on is old and ancient(*).

That said, reading perl5100delta does reveal features such as
defined-or and given/when that I might find useful; but I'm also
not going to replace existing code to use new features unless
there is a clear improvement.

If there's new code people are developing using 5.10; I would
not object at all.  Otherwise, I don't see compatibility with
5.8 hurts more than it helps.

Maybe we change our docs to say we welcome 5.10 features for new
code, but I'm against changing things for the sake of change.


(*) Like this 32-bit laptop from 2005.  Only problem I have with
    it is the noisy fan.
