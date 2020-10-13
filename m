Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3151C433E7
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 19:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE37220BED
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 19:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732322AbgJMTBR convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 13 Oct 2020 15:01:17 -0400
Received: from mx.pao1.isc.org ([149.20.64.53]:63556 "EHLO mx.pao1.isc.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727733AbgJMTBR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Oct 2020 15:01:17 -0400
Received: from zmx1.isc.org (zmx1.isc.org [149.20.0.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.pao1.isc.org (Postfix) with ESMTPS id 0F1C93AB1AA;
        Tue, 13 Oct 2020 19:01:17 +0000 (UTC)
Received: from zmx1.isc.org (localhost [127.0.0.1])
        by zmx1.isc.org (Postfix) with ESMTPS id C813C16008D;
        Tue, 13 Oct 2020 19:01:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by zmx1.isc.org (Postfix) with ESMTP id B66F2160090;
        Tue, 13 Oct 2020 19:01:16 +0000 (UTC)
Received: from zmx1.isc.org ([127.0.0.1])
        by localhost (zmx1.isc.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id EcJhHPNrvsxd; Tue, 13 Oct 2020 19:01:16 +0000 (UTC)
Received: from larwa.hq.kempniu.pl (unknown [212.180.223.213])
        by zmx1.isc.org (Postfix) with ESMTPSA id F024016008D;
        Tue, 13 Oct 2020 19:01:15 +0000 (UTC)
Date:   Tue, 13 Oct 2020 21:01:13 +0200
From:   =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <michal@isc.org>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 3/3] t: add -I<regex> tests
Message-ID: <20201013190113.GB9341@larwa.hq.kempniu.pl>
References: <20201001120606.25773-1-michal@isc.org>
 <20201012091751.19594-1-michal@isc.org>
 <20201012091751.19594-4-michal@isc.org>
 <nycvar.QRO.7.76.6.2010121320190.50@tvgsbejvaqbjf.bet>
 <20201013063846.GF3278@larwa.hq.kempniu.pl>
 <nycvar.QRO.7.76.6.2010131337320.50@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2010131337320.50@tvgsbejvaqbjf.bet>
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

> > First, let me say that the goal of minimizing the run time of a test
> > suite is close to my heart (it is an issue at my day job).  Yet, I
> > assumed that this new test would not be detrimental to test suite run
> > times as it takes about half a second to run t4069-diff-ignore-regex.sh
> > on my machine - and (I hope) its contents are in line with the "tests
> > are the best documentation" proverb.
> 
> Sadly, the test is not quite as fast on Windows. I just ran this (on a not
> quite idle machine, admittedly) and it ended in this:
> 
> 	# passed all 11 test(s)
> 	1..11
> 
> 	real    0m51.470s
> 	user    0m0.046s
> 	sys     0m0.015s
> 
> Yes, that's almost a minute.

Out of curiosity: is that under Cygwin?  I have seen shell-based tests
finishing in 15 *seconds* on Unix-like systems and in 15 *minutes* under
Cygwin, which would be in line with your measurements provided above.

> > Right, neat, though this does not (yet) test:
> >
> >   - the interaction between -I and --ignore-blank-lines (this is visible
> >     in code coverage),
> 
> Right. Any chance you can finagle that in, e.g. by yet another `-e`
> argument to the `sed` call?

I will try in v3 (while also looking at what I can do for other missing
-I<regex> tests I pointed out).

-- 
Best regards,
Michał Kępień
