Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93BDC43466
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 17:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A708206BE
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 17:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730027AbgIURAx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 13:00:53 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:35497 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729243AbgIUQjW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 12:39:22 -0400
Received: from mail.cetitecgmbh.com ([87.190.42.90]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mzy6q-1khoqf3Mlq-00x32t; Mon, 21 Sep 2020 18:39:03 +0200
Received: from pflvmailgateway.corp.cetitec.com (unknown [127.0.0.1])
        by mail.cetitecgmbh.com (Postfix) with ESMTP id 8D1391E01E7;
        Mon, 21 Sep 2020 16:39:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at cetitec.com
Received: from mail.cetitecgmbh.com ([127.0.0.1])
        by pflvmailgateway.corp.cetitec.com (pflvmailgateway.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ap15BqCM6pWN; Mon, 21 Sep 2020 18:39:02 +0200 (CEST)
Received: from pflmari.corp.cetitec.com (10-usr-pf-main.vpn.it.cetitec.com [10.8.5.10])
        by mail.cetitecgmbh.com (Postfix) with ESMTPSA id 4B0E81E01E6;
        Mon, 21 Sep 2020 18:39:02 +0200 (CEST)
Received: by pflmari.corp.cetitec.com (Postfix, from userid 1000)
        id DB71F8051A; Mon, 21 Sep 2020 18:39:01 +0200 (CEST)
Date:   Mon, 21 Sep 2020 18:39:01 +0200
From:   Alex Riesen <alexander.riesen@cetitec.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] config: option transfer.ipversion to set transport
 protocol version for network fetches
Message-ID: <20200921163901.GB4541@pflmari>
References: <20200915135428.GA28038@pflmari>
 <xmqqtuvxwkbz.fsf@gitster.c.googlers.com>
 <xmqqk0wtv204.fsf@gitster.c.googlers.com>
 <20200917140254.GA28281@pflmari>
 <xmqqbli4ox0h.fsf@gitster.c.googlers.com>
 <20200918071647.GA17896@pflmari>
 <xmqq363fnir9.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq363fnir9.fsf@gitster.c.googlers.com>
X-Provags-ID: V03:K1:OEwyA1suqygcjROnuSYJZ5/+NhnEfZ9ukbkUn+RIU/N30lGDpJK
 Y65XvGiF8cYQe7JfVMYc1EeSyh3X4QWkeuXYYcPQ+zEzYwE/69Y+SPauWX/MqUa8Yl2JaIZ
 JbMITL0beVxuKPss+HCID8VbgEua609aaxEwR9GutJEH924iVo8+uQRB9i6IemxMgCenK5s
 peS4AUe8Z6bVN4ZtgHz7g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NaVpjbF5JyU=:wlVurP8x8/ucoa/FU6W+qU
 OfxfL2Eomti2pnclHpvgIN7SfW+EKIL7gE2n4pPiCRUGQCySNLQRpWQ+90kvgYfMsPrX0Ed71
 YVBneRTCxipmyFaidrYohiaYlOwbMJLpYs7B2EQbC+9jstxmDIsgA8CPCx05AEsSiwM1o5KC6
 vYu1foXejYbhozyXuQmMnTd3tjmBy6jaiDsNSWgxKwJNPRJUMRejGqqhA4lru3tYNL/x8ccjP
 G2aI0WEAFhzp9Sl/AnDdJOItFGaTyTMprXzqbrV8XLlp5eZJFkMhOojika2syv00xjbbjHQFG
 hyOIlXYreSLDCBZaxr21eF+t3Xggv0YHA7vkl3ouuG1nimzRG9x+r6K8kK54oaLik2qlj2f52
 wAwxG/HOyJSYbU7xtAoLwbfJEnHCA4QHF+2bYiGQ5NIvt8Mx3kl6MyG1QMKu1Xw8l0TEBH0jp
 E5/0KF+inTef4MbYmIoDxV2mB1EGU4z7+jasj7ZvZ2Rzpq8a4kJvV2Vin6PydKyQYKyo6fZnn
 sYY0eUasT/EukXK9MvHI6Wqt4RRW1CDE9YckmHlg+G2mtM+m4/NzsY70z35rTjELJkVffyBZQ
 3AlfdKWmhaZfrNRX4By+ajbVKl9sMx2jbR9I5G86Tje10ojpNFBUJnWVeHH09wX4FEp7fMrlk
 cHpMtBK+A7YZqPs9sfcu40+hq46pXoYdzFLFgoQyTqp/tXqLGoKpOv/pT0J4J5lWuK1/0QMMs
 hUQYmGi1vPN4acJN2lOdprGYn0IKM2BWHAfiTCfToXXd0uGCLTPGEbfV56AL1z2OOKjOtO9t3
 ZxPrEm6dJ2DB2M7QJOe6+LAEB2L+gujxw2kibXzCsFS0teyq9lYq0JB53YOjruR+H6u76RgLe
 LjbXcEtnc5ccsuJqGroA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano, Fri, Sep 18, 2020 18:37:30 +0200:
> Alex Riesen <alexander.riesen@cetitec.com> writes:
> 
> >     git fetch --ipversions=ipv6,ipv8
> >
> > Given multiple times, the last option wins, as usual:
> 
> Just a clarification on "the last option wins".
> 
> You do not mean "I said v6 earlier but no, I want v8", with the
> above.  What you mean is that
> 
> >
> >     $ cat my-fetch
> >     #!/bin/sh
> >     git fetch --ipversions=ipv4 "$@"
> >
> >     $ ./my-fetch --ipversions=all
> 
> the argument given to 'my-fetch' overrides what is hardcoded in
> 'my-fetch', i.e. "I said v4, but I take it back; I want to accept
> any".

Absolutely correct.

> I find the above sensible.

... And is precisely my intention.

> > BTW, transport.c already converts transport->family to bit-flags in
> > connect_setup.
> 
> Yes, that is why I suggested the "list of acceptable choices"
> approach as a direction to go in the future, primarily to limit the
> scope of this current work.  I do not mind it if you want to bite
> the whole piece right now, though.

I shall try, I think.

> By the way, I have a mild preference to call the option after the
> phrase "protocol-family", without "IP", so that we won't be limited
> to Internet protocols.  IOW, --ipversions is a bad name for the new
> commnad line option in my mind.

I have nothing against protocol-family, with or without "transport-".
I just didn't want to ... over-generalize it prematurely: currently,
the transport family is very fixed on IP on many levels.

> As I said elsewhere, I also think TRANSPORT_FAMILY_ALL is a
> misnomer.  When it is specified, we don't use all the available ones
> at the same time.  What it says is that we accept use of any
> protocol families that are supported.  It is OK to use ALL in the
> CPP macro as it is merely an internal implementation detail, but if
> we are going to expose it to end users as one of the choices, I'd
> prefer to use 'any', and not 'all', as the value for the new command
> line option.

Noted.

Regards,
Alex

