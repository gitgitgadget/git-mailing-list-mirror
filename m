Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF64C43331
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 15:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E01DD20732
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 15:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728932AbgC3PVC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Mar 2020 11:21:02 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:46865 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgC3PVC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Mar 2020 11:21:02 -0400
Received: from [192.168.100.176] ([80.150.130.51]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MNc1T-1jgwBO0I4R-00P9iy; Mon, 30 Mar 2020 17:20:49 +0200
Subject: Re: [PATCH] gitk: to run in a bare repository (was: gitk can't be run
 from non-worktree folders)
To:     Git List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Martin von Zweigbergk <martinvonz@gmail.com>
References: <4e2e5829-b9a7-b9b4-5605-ac28e8dbc45a@onlinehome.de>
 <20200123163151.GC6837@szeder.dev>
 <CAPig+cTixT9JYDPn-umKdQLtTm5byA1wwmvVY1ryuh+hv2=6MQ@mail.gmail.com>
 <xmqqpnfa3sj1.fsf@gitster-ct.c.googlers.com>
 <xmqqk15i3rp7.fsf_-_@gitster-ct.c.googlers.com>
 <20200123192707.GA110440@coredump.intra.peff.net>
From:   ch <cr@onlinehome.de>
Message-ID: <8be28321-3108-4846-ac6a-d5c7977774dc@onlinehome.de>
Date:   Mon, 30 Mar 2020 17:20:47 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200123192707.GA110440@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:w3QLoKoKHC2MUeAs/tMOfX0rjKGAL27vybmRwc50S0hVsy5B9DM
 3VnP3efTEzsFqvZRJxRSoAtqMxl4UGf6ctHBHZK7H/1XCrccMJ8xrk1I8PlkaDAUxcuKouL
 xsMJUpLZWFquAO9aUcmebbyRY9WOrqxCkC+7/VXQuoujc1k8B/9i2T2PYdwnBkLsgIwjk7w
 ZzI7jO2+CBo7QP2TrY3GA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:x4nwgb6BK5I=:rVNXF1+lHECGUunXCyco3S
 7n1v/PPB67hpcvUIAWqmqtnP3SKW2NtF/nnK/P8+0otdim6+QgYhRhymA8hXWrCR6jfTrnMWH
 q+Ut1S4aw8fONecHTt9LifdTi53cbn26Sc+EpXq6J5fB+kIq5S70uSG/2FVDL9iOB3jdmAWYW
 zBzXuoBR69bl9hvZCCmCh2Ntg8ZVbC/uLJ+rKY9FG2O8D1I6mvVTHe8d2rTQA35LTcE9iiRXB
 W56UjKkQAKu6hsCfihnn6vkZ6xlA8J38rKLNdZuSpiTJyM6nzh1liP1n+O57FQMoQRH4VDrSZ
 8SmrfqJMT6NsBYfIf1zYT33C6WFHTwilws7SXTsbw3HgAA8bZ/Xcq+Rd51Z6h1kqn13J7Bm29
 hMq4Wg9BwJDoj+aDjWMfWmreKGJWJDbgEQPMvI6sxBggGOjUZ5jI/fRNaf+r2MSNrlqEJHLZC
 b4QL2znI5xQIOHaysA9A6/SbVAN+fN3Rgcy/hhfCLuCZbLO6poojXAhYZEMrg2mdrkVbosXiN
 aIR5E5urlBQ0SPvH2gagp8+zAmsVF2Tg00WGG6W6FCfOxzdwCoxq1uKGqR37ybukTjOf6ktLx
 /jcPHCM0ZhYjlvi2Pma1bpD4cgBsWwpLml2B2KeATyClYd0jFo29h1Wo/Hw5Y7tt54Z57bJKT
 3QLCwb0+ZF4Fthrr584wz/9W8CKRweaQQ8TjmSoSM0LYYEt/u9Yi2hrgRZfkBwWjevNQefoll
 pjNC9yOltaIgVtJ2oQxgk1hDrNYv12Q1CP63bmrz36qtAyK2BnoKv+SKSu5/8pb89NifC53vh
 f9S/45J/V0A+n8ljgDOr4E/A7C0Ckl4c39RUtMAyhnEtYZkhFtYsFrys0YhDCvnZPomwfcb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry for bumping this thread but what's the integration status of the patch?
The issue still seems to be present in v2.26.0.windows.1.

On Thu, Jan 23, 2020 at 11:20:36AM -0800, Junio C Hamano wrote:

 > -- >8 --
 > Subject: [PATCH] gitk: be prepared to be run in a bare repository
