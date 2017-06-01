Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9434D20D0A
	for <e@80x24.org>; Thu,  1 Jun 2017 18:56:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751148AbdFAS4u (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 14:56:50 -0400
Received: from mout.gmx.net ([212.227.15.19]:52946 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751097AbdFAS4t (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 14:56:49 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LqzEB-1dmHK70DQJ-00eeFs; Thu, 01
 Jun 2017 20:56:32 +0200
Date:   Thu, 1 Jun 2017 20:56:30 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, David Turner <dturner@twosigma.com>,
        Ben Peart <benpeart@microsoft.com>
Subject: preserve untracked cache, was Re: What's cooking in git.git (Jun
 2017, #01; Thu, 1)
In-Reply-To: <xmqqshjk5ezb.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1706012052480.3610@virtualbox>
References: <xmqqshjk5ezb.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Tdos/lexivTXCYDDNB4B5bHz6FAvngF/xFj3JSTAgo+ChHnV9hH
 RpIlzuReuDmTEGU1i3P/3PWxfqNQ/FNgsCQHENDssf7v5Ww9sA7n8QeFtGkRXnlu0/HVdzE
 tJq5Tltzhy+lsNmM4zWa56HmvwOwEXM9QnRXW5+/ipNxDTfjkAGp+jmY6si4fRQf636g73q
 LQ6Ea2iz3Pe+H59Tkt+6w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1Bi+GWSkwVA=:ZHA4noeDU6nwhJntFMT1ns
 BYkrJxZAWCaWp2CUVP0vo+C0nAQ+vt5H5y7dxofRK4aQFkmSJ/7cA+2xKqcg3fvREpiugumgj
 LqPnd6XKwdXpRx+b1Ka0NnlXWNfMuH9Ed8vr9qUlL73/uJe9Hk8u586IwRm2eKZG9E5+rbM8U
 sackGQ+9uDCr8EFWihaxiITkHS+K05pz30O4ysxLTiOt0qlDbAWw3W2MqRChgPIJxIap9w/qT
 EEURMSbyqZ6Zg0G+7F3/a1xZV133iyzIcjPHYmZNO/AK1/VKa8yRuR/8rhg3NB/Ap0vhvWRVN
 gmd/6Bpxv2cpPfALQtswrzvgSr1jTw29ZbYgksMTWY8pznocfTcMABi1EYluaCDMhErx0Ow1E
 UpzrHVLBmUBgdPSKEJWHe3unPcjxLbIN0s0LDEp7vK7rFX1Hh5RgGLNJZ7ZiiouHJ/3KU3UFM
 WnF68kxCmQLioMPxKMjIzRGZU24N7FS+8gW5ut8v4GrvIYrfwnxWVXUZScO0AcOD21F+hdmJ0
 a9c9Tv9LLqCfYsIf97X1UP2sC38Wx1VlGgSWbcSxyt2JaKpWgARDGDESlJlchzhL3cghzY9a+
 B12hms9OxlbXB6f8JOZIrBeTmbXksgwwBKU2+sGfN7/h5f2GzU8KbgkbI4DOz/kF7P4/V/pKs
 UPIORvaQjrcJ5uEGjFNda+ncMILKIKjzI6Yk76956+dZCST+LKfBBm39P5UM9XzvVBmb5sc6i
 Smvjolqa2TxTHE++Un/9DSEgU62I3tU+qB2oxVohHoZlATiJ7RjNXmCiJYiALxkHmhDQXBS9n
 5uKrvE8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 1 Jun 2017, Junio C Hamano wrote:

> * dt/unpack-save-untracked-cache-extension (2017-05-20) 1 commit
>   (merged to 'next' on 2017-05-23 at 3196d093d6)
>  + unpack-trees: preserve index extensions
> 
>  When "git checkout", "git merge", etc. manipulates the in-core
>  index, various pieces of information in the index extensions are
>  discarded from the original state, as it is usually not the case
>  that they are kept up-to-date and in-sync with the operation on the
>  main index.  The untracked cache extension is copied across these
>  operations now, which would speed up "git status" (as long as the
>  cache is properly invalidated).

It was my understanding that Ben's analysis conclusively proved that the
patch as well as the test are sound, and Dave agreed.

What is holding this topic up? Anything Ben or I can do to move this
closer to `next` or even `master`?

Ciao,
Dscho
