Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E40471F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 08:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754455AbeGIITV (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 04:19:21 -0400
Received: from gecko.sbs.de ([194.138.37.40]:42704 "EHLO gecko.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754326AbeGIITU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 04:19:20 -0400
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
        by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id w698It2r010058
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 Jul 2018 10:18:55 +0200
Received: from md1pvb1c.ad001.siemens.net (md1pvb1c.ad001.siemens.net [139.25.68.40])
        by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id w698IsY9017675;
        Mon, 9 Jul 2018 10:18:54 +0200
Date:   Mon, 9 Jul 2018 10:18:54 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     <git@vger.kernel.org>, Ben Toews <mastahyeti@gmail.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/8] builtin/receive-pack: use check_signature from
 gpg-interface
Message-ID: <20180709101854.2777aae2@md1pvb1c.ad001.siemens.net>
In-Reply-To: <xmqqk1q8hwta.fsf@gitster-ct.c.googlers.com>
References: <cover.1530616446.git.henning.schild@siemens.com>
        <cover.1530616446.git.henning.schild@siemens.com>
        <f9e371c8dd2a17ddb5fd5989a7fdad1c0d1bb6e7.1530616446.git.henning.schild@siemens.com>
        <xmqqsh4wjg7b.fsf@gitster-ct.c.googlers.com>
        <xmqqk1q8hwta.fsf@gitster-ct.c.googlers.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am Fri, 6 Jul 2018 14:35:29 -0700
schrieb Junio C Hamano <gitster@pobox.com>:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Henning Schild <henning.schild@siemens.com> writes:
> >  
> >> The combination of verify_signed_buffer followed by
> >> parse_gpg_output is available as check_signature. Use that instead
> >> of implementing it again.
> >>
> >> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> >> ---  
> >
> > Makes sense.  
> >
> > When d05b9618 ("receive-pack: GPG-validate push certificates",
> > 2014-08-14) implemented the check, there wasn't check_signature()
> > available.  The commit probably should have done what a4cc18f2
> > ("verify-tag: share code with verify-commit", 2015-06-21) later did
> > to introduce the check_signature() function by factoring it out of
> > commit.c::check_commit_signature() as a preparatory step.
> >
> > Will queue.  Thanks.  
> 
> Well, I guess I won't queue this version that would waste others'
> time, as you'd be rerolling to update variable names and such, so
> I'd wait for that (and you in turn would wait for the names and
> other discussions to settle).
> 
> Thanks anyway.

I think 1 and 2 can be seen as somewhat unrelated to the gpgsm feature,
they are more general refactoring. So i think picking them is a good
idea. It will make the series shorter and ease review in the next round.

Henning
