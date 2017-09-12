Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C330209BA
	for <e@80x24.org>; Tue, 12 Sep 2017 08:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751266AbdILIe7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Sep 2017 04:34:59 -0400
Received: from 7.mo64.mail-out.ovh.net ([46.105.63.1]:46664 "EHLO
        7.mo64.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751178AbdILIe5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2017 04:34:57 -0400
Received: from ex2.mail.ovh.net (gw1.ex2.mail.ovh.net [164.132.80.186])
        by mo64.mail-out.ovh.net (Postfix) with ESMTPS id E376A923D6;
        Tue, 12 Sep 2017 10:24:54 +0200 (CEST)
Received: from [10.0.2.127] (86.200.198.152) by EX7.indiv2.local (172.16.2.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Tue, 12
 Sep 2017 10:24:53 +0200
Subject: Re: [PATCH 4/4] imap-send: use curl by default
To:     Junio C Hamano <gitster@pobox.com>
CC:     Jeff King <peff@peff.net>, <git@vger.kernel.org>
References: <c74c8c386f2c2d8b6cebd4addf925d0121986067.1502114584.git.nicolas@morey-chaisemartin.com>
 <71479602-fabc-1861-124b-90b26b952344@morey-chaisemartin.com>
 <20170807200126.fnbz57qd44vj43c6@sigill.intra.peff.net>
 <xmqqy3pk1kjn.fsf@gitster.mtv.corp.google.com>
 <xmqqk2141jst.fsf@gitster.mtv.corp.google.com>
From:   Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Openpgp: preference=signencrypt
Message-ID: <52583345-ada8-3f57-0bc1-04c92c8d0903@morey-chaisemartin.com>
Date:   Tue, 12 Sep 2017 10:24:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:56.0) Gecko/20100101
 Thunderbird/56.0
MIME-Version: 1.0
In-Reply-To: <xmqqk2141jst.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: fr-xx-classique+reforme1990
X-Originating-IP: [86.200.198.152]
X-ClientProxiedBy: CAS4.indiv2.local (172.16.1.4) To EX7.indiv2.local
 (172.16.2.7)
X-Ovh-Tracer-Id: 11085329008436766685
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeelledrgedugdeltdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemuceftddtnecu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Le 12/09/2017 à 09:02, Junio C Hamano a écrit :
> Junio C Hamano <gitster@pobox.com> writes:
>
>> I was sweeping my mailbox to collect loose ends that haven't been
>> tied down, and noticed that this topic does not seem to have reached
>> a conclusion.  Do we want to reboot the effort?  Or should we just
>> throw it in the #leftoverbits bin for now?
> Ahh, I failed to find newer incarnations of this topic (there was v3 that
> starts at <087f5907-6558-ce32-2f5c-2e418522c030@morey-chaisemartin.com>)
> when I wrote it.  Sorry about pinging a wrong/old article.
>
> I just gave a cursory re-read of the review thread over the v3
> series; it appears that we were very close to the finishing line
> already?
>
> Or am I yet missing/forgetting some later developments that made
> this topic obsolete?
>
> Thanks.
>
v3 needs just a few bits fixed:
- Fix the bads return code in patch #1.
- Reword patch #4 was you found confusing. I sent a proposal fix that you probably missed:

Is something like this clearer ?
Author: Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Date:   Sun Aug 6 21:30:15 2017 +0200

    imap-send: use curl by default when possible
   
    Set curl as the runtime default when it is available.
    When linked against older curl versions (< 7_34_0) or without curl,
    use the legacy imap implementation.
   
    The goal is to validate feature parity between the legacy and
    the curl implementation, deprecate the legacy implementation
    later on and in the long term, hopefully drop it altogether.
   
    Signed-off-by: Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>


If you're happy with this log message, I've v4 ready to post.

Nicolas

