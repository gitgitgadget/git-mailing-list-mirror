Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFE511F403
	for <e@80x24.org>; Fri, 15 Jun 2018 14:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756196AbeFOOez (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Jun 2018 10:34:55 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:52825 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756165AbeFOOey (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jun 2018 10:34:54 -0400
Received: from [192.168.100.119] ([80.150.130.51]) by mrelayeu.kundenserver.de
 (mreue101 [212.227.15.183]) with ESMTPSA (Nemesis) id
 0LjrTN-1g4oOA0SL3-00bpZs; Fri, 15 Jun 2018 16:34:51 +0200
Subject: Re: [BUG] git-rebase: reword squashes commits in case of
 merge-conflicts
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
References: <8e28202a-8646-53e8-8c22-389d61791c70@onlinehome.de>
 <20180612100810.GA27231@sigill.intra.peff.net>
From:   ch <cr@onlinehome.de>
Message-ID: <118a8026-7050-dbd2-9f46-31e8db2bac05@onlinehome.de>
Date:   Fri, 15 Jun 2018 16:35:43 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180612100810.GA27231@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:p4lVd6BGoPE2GNVkW0Cg2ql29ku9WANU+h5wc/r9kG0ok1HtUPo
 Fyd8tiyWAfjHTl3ygKk0eFkIK2vC0ki2PmEUbTOv5aWOU1Bq8t5cNU6ZuT61cX9FmS0hK4g
 a8MQrJ4TxeCuzLzPvCHvdlbiZYVv2/dZfRVWWkWv1t9rFEkkBP9KBecVCBUbQQLPMp+ZAuS
 J2QnZWDHmphKdOwatQlyg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RxmmdJLEC2s=:GtEkOqhAXIVfTNMhgznEgw
 ZXiJ9+ozkF0RqfqYXgxDOjgvgVu4T//YY8sK/T4BEEaQ2ohDiUjJxewD6ZlzTx/vyhCzCh+vX
 Uh7PzGmRVtY3L8LgCKGaKdulMlLUJ67fZjBQINcdqqm8xZw8aBvmmTlXcxWpE0y6jBOh5mqsw
 +6wHTr3vJaOZjmLvMkwIwHF5QxYbyHDVoarsR2t6rg1UcbNEYMxlyuAVWNNWWt4JNSYBASUoe
 fA8miL+IUnOv80BP5KBUm7O1NIMIWBx6Lt0dJewes4xOpih3F7L9XX0lxkIjooV9zYAXcCeZ+
 yifeVH4hvz4vBWMujvTvpMkDJGGd0ADhIIwHeps5lcqgG8B0LzcbfZNPuK+WtCbS2b5sQvrD1
 v6NHfBPFvgW5Z6P00lMAGKBoGaEl1VfE99qLCd+3QvgHe338XtUPKikn4YW05IUrw38OlepNI
 E7rJfvDHeIkRJ4sXbgvUeqiXjOosoZEZVje0wi3cgEOcEcMzjteR4gRC/WHFVjEv7XHsP2tL0
 /GiS6GAn+lrs7Ze5qnsTpBP6Zern4jhy4pMetply+uRj+/MO3RD9yHCLrOZa02GJ7uHv29cIG
 lKrTSlmQywjA+IsKQ0fbWtAkN9ujSEuYp2RpRfiLXSuRu5GWK3iUcKwqdV9/V71gSBxTTf1Qn
 sCenIW4Nhal8OOJuX5+5DjluqoKTgacQR8eGRcr05moiVnew4EwO8m/B9PUNpBc0w3xcG6zZt
 aWwHWNz8MAJ/sxE3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12.06.2018 12:08, Jeff King wrote:

 > Thanks for a thorough report. I couldn't reproduce it on v2.17.1 on
 > Linux, which makes me wonder if the issue is related to git-for-windows
 > somehow. To the best of my knowledge (and a quick scan of "git diff"
 > results) the code should be the same, though.

I gave native Git version 2.17.1 on Ubuntu 18.04 (no WSL this time) a try
and was able to reproduce the issue outlined in my first email.

In case there is a misunderstanding, when I wrote

On 11.06.2018 18:06, ch wrote:

 > After the rebase the 'stuff' branch only has a single commit even though I'd
 > expect there to be two according to the instructions that were passed to
 > git-rebase.

I actually meant that there's only a single commit exclusively reachable
from 'stuff' after the rebase, i.e.

   $ git log stuff ^master

only lists a single commit while there actually should be two unless I'm
missing something.

Sorry for being a bit sloppy in my initial report.

- ch
