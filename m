Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 501BA1F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 15:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389501AbeGKPyK (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 11:54:10 -0400
Received: from thoth.sbs.de ([192.35.17.2]:46429 "EHLO thoth.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732935AbeGKPyK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 11:54:10 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id w6BFmmY8029867
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jul 2018 17:48:48 +0200
Received: from md1pvb1c.ad001.siemens.net (md1pvb1c.ad001.siemens.net [139.25.68.40])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id w6BFmlxG019933;
        Wed, 11 Jul 2018 17:48:47 +0200
Date:   Wed, 11 Jul 2018 17:48:46 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Jeff King <peff@peff.net>
Cc:     <git@vger.kernel.org>, Eric Sunshine <sunshine@sunshineco.com>,
        "Junio C Hamano" <gitster@pobox.com>,
        Martin =?UTF-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Ben Toews <mastahyeti@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 9/9] gpg-interface t: extend the existing GPG tests
 with GPGSM
Message-ID: <20180711174846.12618aea@md1pvb1c.ad001.siemens.net>
In-Reply-To: <20180711143554.GG23835@sigill.intra.peff.net>
References: <cover.1531208187.git.henning.schild@siemens.com>
        <f97d2d79f6a46ddffcd0065239f99b084708e813.1531208187.git.henning.schild@siemens.com>
        <20180710170901.GH23624@sigill.intra.peff.net>
        <20180711123824.7e0be91a@md1pvb1c.ad001.siemens.net>
        <20180711125109.GC23835@sigill.intra.peff.net>
        <20180711154019.202e75c5@md1pvb1c.ad001.siemens.net>
        <20180711143554.GG23835@sigill.intra.peff.net>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am Wed, 11 Jul 2018 10:35:54 -0400
schrieb Jeff King <peff@peff.net>:

> On Wed, Jul 11, 2018 at 03:40:19PM +0200, Henning Schild wrote:
> 
> > > So it may be simplest to just run most of the tests twice, once
> > > with gpg and once with gpgsm. I kind of wonder if all of t7510
> > > could just be bumped into a function. Or even into a sourced file
> > > and run from two different scripts. See the way that t8001 and
> > > t8002 use annotate-tests.sh for an example.  
> > 
> > I do not agree and would like to leave the tests as they are.
> > Instead of introducing a whole lot of very similar copies, i added
> > just a few.  
> 
> I'm not sure I understand why you added the ones you did, though. For
> instance, "--no-show-signature overrides --show-signature x509" seems
> like it has nothing to do with the gpg/gpgsm distinction.
> 
> So I'd have expected that to be _outside_ of the shared battery of
> tests.

True, it took my quite some time to figure out a way to configure gpgsm
non-interactively. Generate the key etc. without even a single popup of
the gpg-agent... After that i just added random tests to create
"coverage", without much focus. I would be happy to revisit that and
drop test cases, and add some that are missing.

Henning

> > The original ones are even very similar between each other.
> > We are again talking about two problems. 1. we need test cases for
> > gpgsm if we want to merge gpgsm 2. the testsuite is very repetitive
> > 
> > While addressing 1 make 2 obvious and worse, addressing 2 is a whole
> > different story and should probably be discussed outside of this
> > thread. And i would not like to inherit responsibility for 2. In
> > fact the whole discussion emphasizes that it was a good idea to make
> > GPGSM depend on GPG, because it allows to somewhat reuse existing
> > tests.  
> 
> IMHO there is a big difference between inheriting responsibility for
> something, and not making it worse. But I'm not all that interested in
> fighting about it.
>
> -Peff

