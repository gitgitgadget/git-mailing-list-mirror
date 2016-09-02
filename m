Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32FFC1F859
	for <e@80x24.org>; Fri,  2 Sep 2016 07:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751644AbcIBHP6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Sep 2016 03:15:58 -0400
Received: from mout.gmx.net ([212.227.17.21]:51965 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751040AbcIBHP4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2016 03:15:56 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0M8qOm-1bnOCV0Kaa-00CEZk; Fri, 02 Sep 2016 09:15:47
 +0200
Date:   Fri, 2 Sep 2016 09:15:46 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Dennis Kaarsemaker <dennis@kaarsemaker.net>, git@vger.kernel.org
Subject: Re: [PATCH 07/34] sequencer (rebase -i): add support for the 'fixup'
 and 'squash' commands
In-Reply-To: <xmqqr393wkof.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1609020914320.129229@virtualbox>
References: <cover.1472633606.git.johannes.schindelin@gmx.de> <5488a031ffe14373b7434d497b7fd2f2e5fe55bd.1472633606.git.johannes.schindelin@gmx.de> <1472718808.4680.19.camel@kaarsemaker.net> <xmqqr393wkof.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:3WTB78mRmNEHyTwbyOyeDOuV5OHFGkWHH9Z5QpDIpISxtf7e+l+
 GP2iJ0GFQVkzirnFQ091iuhEDt36z2S2oW37d2H3yzI34of6eIhwSc+lfi1masoxG1qVEq7
 1Mfa9momCug9P0j8W3SEozNL7bVX200YnIZdDWCNH5YYQfTGcu2yS4fd4hYM7h8L8o9DyWo
 I8wJ5+5fOWv2XHbFk6eUw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fXxKdKzqNnI=:ndmhpejvHmkQLIJtoUuQAw
 Sf/7jZXuyS1R4KnzIJEj7BQZidNmVf/KNqXrI6oG//EejnGGNhD/ZKn75p3P/zCmepGm5SjXp
 NDqlLjlojlL66uLOjVD1rHAdI1cfNTLxdtBhIWJQqwQHo5w9elaMp3d5LwGQcV3KhDmeu7L/b
 Sp2ASNWyv1eHO66SvD+TIXMp/yMUpfpVmvmBSZzk2v2Eq7DkQrkH6Hsvswdhz2QZcudMt3N13
 4DFVJkJx7RlOed6CWF4I1hRDZNuBbIh89DNsPZxjsQohnJKwrpdT/MuRWcvh670jrRj6hlryF
 LdR7fLdQHUmQBNIsBC3mr42jxDGmpmcIi7ip83wp1wyrFlSExplKOJf7gL7zRhbaoiTZT2hOn
 u7D1XxUozQJ9jLWAjAgo6imMgOKoMy8Z2ess5ryDmd3ix24egAeIyaBRAQVa/HjetVQQIJvSR
 nicVAqDuEnZNmDLY4MemNoGcAb/Ld+t+UXPRNNfL97tMqWi9TXMq+iBTfiSP8KtIDcrkDc3Pt
 F3wc/JWoC98iBYGPd5WYbOlzyV+XOeDGpjd2w93nMsUp2mKGhow82d2Ch3v7mp06i96FYlEXL
 iv+Hpy6ezWRtSd0In0C00fadJsx/nTIvBv+ld/HSYwh8NN4ljGEEnjCFLOSgKVSaGiGAueGXi
 2F77p1ULwGFgYUw9qAJXroJLxOj1fmhBRjHA0wvdRMA4lP+ZU8IN8p2ducz2q8M2LZXJWfvKQ
 glf6sYPWnzU9qZnsMtSUbwir6zCujk9OyTMIg0b3foff7LM+X9U4rPjDGEvyOAc4YSkDH0Eic
 xD4piON
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 1 Sep 2016, Junio C Hamano wrote:

> For those who were not paying attention on the 'master' front during
> this pre-release period [*1*], I have to point out that the scripted
> Porcelain has been updated to lose the Anglo-centric st/nd/rd/th and
> this series would want to get updated to match.
> 
> 
> [Footnote]
> 
> *1* Why weren't you?  Repent! ;-)

I tried to. But, you know, I was kinda busy with a couple of patch series.

In any case, I changed the code this morning. Can't say that I like those
forced last-minute changes.

Ciao,
Johannes
