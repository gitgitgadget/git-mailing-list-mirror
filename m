Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16114208B8
	for <e@80x24.org>; Wed,  9 Aug 2017 19:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752064AbdHITCp (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 15:02:45 -0400
Received: from benson.default.arb33.uk0.bigv.io ([46.43.0.16]:52021 "EHLO
        benson.default.arb33.uk0.bigv.io" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751536AbdHITCn (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 9 Aug 2017 15:02:43 -0400
Received: from cpc91198-cmbg18-2-0-cust103.5-4.cable.virginm.net ([81.98.98.104] helo=dagon.hellion.org.uk)
        by benson.default.arb33.uk0.bigv.io with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <ijc@hellion.org.uk>)
        id 1dfWFV-00081s-SL; Wed, 09 Aug 2017 20:02:38 +0100
Message-ID: <1502305353.2735.33.camel@hellion.org.uk>
Subject: Re: [PATCH 2/2] filter-branch: Handle rewritting (very) old style
 tags which lack tagger
From:   Ian Campbell <ijc@hellion.org.uk>
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Date:   Wed, 09 Aug 2017 20:02:33 +0100
In-Reply-To: <xmqqlgms7nbl.fsf@gitster.mtv.corp.google.com>
References: <1502179560.2735.22.camel@hellion.org.uk>
         <20170808080620.9536-2-ijc@hellion.org.uk>
         <20170809102040.l5sb6ukqh2225zqm@sigill.intra.peff.net>
         <xmqqlgms7nbl.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 2017-08-09 at 08:50 -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > On Tue, Aug 08, 2017 at 09:06:20AM +0100, Ian Campbell wrote:
> >
> >> Such as v2.6.12-rc2..v2.6.13-rc3 in the Linux kernel source tree.
> >> 
> >> Insert a fake tag header, since newer `git mktag` wont accept the
> input
> >> otherwise:
> >
> > Hmm. Now your resulting tag will have this crufty "unknown@example.
> com"
> > header baked into it, won't it?
> >
> > Should we instead make git-mktag more lenient (possibly with a
> > command-line option to reduce accidental omissions)?
> 
> That sounds sensible. Thanks for injecting a dose of sanity.

Indeed. I'll add a --allow-missing-tagger option (suggestions for a
snappier name accepted!) and pass it unconditionally from the filter-
branch script.

Ian.

