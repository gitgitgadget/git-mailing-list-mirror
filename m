Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C2551F442
	for <e@80x24.org>; Wed,  8 Nov 2017 09:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751587AbdKHJCF convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 8 Nov 2017 04:02:05 -0500
Received: from relay-ff112.magwien.gv.at ([217.149.228.140]:42722 "EHLO
        relay-ff112.magwien.gv.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751306AbdKHJCD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Nov 2017 04:02:03 -0500
X-Greylist: delayed 568 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Nov 2017 04:02:02 EST
Received: from localhost (localhost [127.0.0.1])
        by relay-ff112.magwien.gv.at (Postfix) with ESMTP id 4813C2063B;
        Wed,  8 Nov 2017 09:55:30 +0100 (CET)
X-Virus-Scanned: by amavisd-new using Sophie and ClamAV at magwien.gv.at
Received: from relay11.host.magwien.gv.at (relay11.host.magwien.gv.at [--])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by relay-ff112.magwien.gv.at (Postfix) with ESMTPS id 2187420570;
        Wed,  8 Nov 2017 09:55:30 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by relay11.host.magwien.gv.at (Postfix) with ESMTP id 6DDF7166A30;
        Wed,  8 Nov 2017 09:52:32 +0100 (CET)
Received: from mail.fsw.at (sfsww2k12ex02.intern.fsw.at [--])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by relay11.host.magwien.gv.at (Postfix) with ESMTP id 2D5DA166A20;
        Wed,  8 Nov 2017 09:52:31 +0100 (CET)
Received: from SFSWW2K12EX02.intern.fsw.at (--) by
 SFSWW2K12EX02.intern.fsw.at (--) with Microsoft SMTP Server (TLS)
 id 15.0.1293.2; Wed, 8 Nov 2017 09:52:31 +0100
Received: from SFSWW2K12EX02.intern.fsw.at ([fe80::a1d5:6bb5:fb11:2572]) by
 SFSWW2K12EX02.intern.fsw.at ([fe80::a1d5:6bb5:fb11:2572%15]) with mapi id
 15.00.1293.002; Wed, 8 Nov 2017 09:52:31 +0100
From:   Ekelhart Jakob <jakob.ekelhart@fsw.at>
To:     "Junio C Hamano  *EXTERN*" <gitster@pobox.com>,
        Michael J Gruber <git@grubix.eu>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Matthias Lischka <matthias.lischka@fsw.at>
Subject: RE: [PATCH 2/3] merge-base: return fork-point outside reflog
Thread-Topic: [PATCH 2/3] merge-base: return fork-point outside reflog
Thread-Index: AQHTPA2qwa68IIz8OE+EjGcZawC3PaMKZVEg
Date:   Wed, 8 Nov 2017 08:52:31 +0000
Message-ID: <b9c2c978a6d3407c8c26509fc82b3920@SFSWW2K12EX02.intern.fsw.at>
References: <68633b20-9e2b-ae23-2ede-8728283250f0@grubix.eu>
        <cover.1505394278.git.git@grubix.eu>
        <5513a1415d11517c28158d9b4212d383a233182f.1505394278.git.git@grubix.eu>
        <xmqq60ckzng7.fsf@gitster.mtv.corp.google.com>
        <cd97bb1b-13f3-0856-a250-8f4921b9f6d8@grubix.eu>
        <xmqqshfnx1kl.fsf@gitster.mtv.corp.google.com>
        <xmqqshfgk1mr.fsf@gitster.mtv.corp.google.com>
        <5a2fca1d-4edf-965f-4840-58c924c91051@grubix.eu>
        <xmqqzi9nlcyw.fsf@gitster.mtv.corp.google.com>
        <4a14c35c-88b0-7bc3-0a6e-c69ed9ec7ee7@grubix.eu>
        <xmqqa81njds0.fsf@gitster.mtv.corp.google.com>
 <xmqq7ewckbpk.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqq7ewckbpk.fsf@gitster.mtv.corp.google.com>
Accept-Language: en-US, de-AT
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for all the effort to fix this issue. Unfortunately, we are still suffering from this and our workaround just stopped being sufficient.

We were wondering if there is any way to tell when this fix will be released?

BR Jakob

-----Original Message-----
From: Junio C Hamano *EXTERN* [mailto:gitster@pobox.com] 
Sent: Dienstag, 3. Oktober 2017 08:06
To: Michael J Gruber <git@grubix.eu>
Cc: git@vger.kernel.org; Ekelhart Jakob <jakob.ekelhart@fsw.at>; Jeff King <peff@peff.net>; Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/3] merge-base: return fork-point outside reflog

Junio C Hamano <gitster@pobox.com> writes:

> Michael J Gruber <git@grubix.eu> writes:
>
>> I'm still trying to understand what the original intent was: If we 
>> abstract from the implementation (as we should, as you rightly
>> emphasize) and talk about historical tips then we have to ask ourselves:
>> - What is "historical"?
>> - What is tip?
>> - Tip of what, i.e. what is a "branch"?
>
> The feature was meant to be a solution for "upstream rebased the 
> branch I based my work on."
> ...

So, what is the status of this thing?

While I think 1/3 and 3/3 of these three definitely make sense, I do not think "fork-point outside reflog" does as-is If it is not even part of the commits that were known to be at the tip some time in the past (including "right now"---which is the fix you made with 3/3 is about), then the patch may make the command return something in more situations, and these extra things that it returns might even be improvements, but they are definitely not "fork-points".

To be quite honest, I am not convinced that the extra output you would get out of the command by removing the latter half of "which are the ancestors that were known to be at the tip?" would always give better commit to use as the beginning of the topic to be rebased, as I do not see any reasoning behind why, unlike the filtered case where there _is_ a strong reasoning (with explained
limitation) behind it.

As long as the code misidentifies and picks a commits deeper than necessary, which will force the user to say "rebase --skip", I think we are OK.  What we want to absolutely avoid is the opposite; somehow the code misidentifies a commit that is part of the work you want to rebase as a recommended fork-point, which would cause the rebase to silently lose changes.  I do not think I saw why it won't happen explained in the log message of 2/3 at all.

