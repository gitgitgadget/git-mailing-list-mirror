Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D233B2082F
	for <e@80x24.org>; Sat, 15 Jul 2017 12:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751202AbdGOM5A (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Jul 2017 08:57:00 -0400
Received: from mout.gmx.net ([212.227.17.21]:62913 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751187AbdGOM47 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Jul 2017 08:56:59 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Metpl-1dHIcJ0rQv-00OVfM; Sat, 15
 Jul 2017 14:56:46 +0200
Date:   Sat, 15 Jul 2017 14:56:44 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Stefan Beller <sbeller@google.com>
cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Liam Beguin <liambeguin@gmail.com>
Subject: Re: [PATCH v6 02/10] rebase -i: generate the script via
 rebase--helper
In-Reply-To: <CAGZ79kYFgR_Lo-hWq6_UanvidG6a9H54qop=sg_33FCsA9Z0pQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1.1707151454230.4193@virtualbox>
References: <cover.1500043436.git.johannes.schindelin@gmx.de> <814284075336e715dd52859e69aeb41226624af7.1500043437.git.johannes.schindelin@gmx.de> <CAGZ79kYFgR_Lo-hWq6_UanvidG6a9H54qop=sg_33FCsA9Z0pQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:v1WpO+BQl0xnLQO0uLZBA5LI5mk+HuoVBUiEJfwwsNbXJgUvwKD
 jxm14I+qfrxrqc2+GuUaeMEi56aKS5v0SkQcwcfl3CH+LRr01OMMU9E08iGJF8dk9zVYOjN
 TAw0hSYq0RxWxT+IFV6gIxNKnj/e84uK6/ae8fQFxbXo7Y0y82A4XSqt9NvAoj4Kzuc8eqV
 SaP2a2wof/i4eYdf8WVHg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GrDkypxWn80=:Q3Ij0SKJ50N3iO+SmvSQzM
 pxAkVXyhKvFlYUjA/FbhEHMiudv+TqEWMW6YOxdfHOg7YtB9ux48WlGr01NGVbD2WKvaB52ke
 7MuXCelnHohXQQ7/Vr5OkUIy1dbBDacNAdpx13rkCe8R0dlHdneQLP02oVniNU1f4YQM+CtsT
 h8S/m9jZOPNB3K4/gnDRbbGHbmtNTj6x7UGPx/B3MrEUYGQ4XUTT50JHqxmBEoihT7B4QFQLu
 PuNgX1fZaemtEK/RBx4b/sXe5IwuqRejlqc75O41JNxP+hgwAGnS7YIMqB1gLOGUL1Mp7QtzS
 dByXRv8m8x/pWen0MjlMOouLneK6e3IKGnf50mK5T1RnDUrar+JF/aGEWAjFYx8HHHWnEXzk1
 ESDJqS4ISMR7nl9VlFuzAY0q/55rtbm5M26DtvAYm+qag6RPKGrXFTi95KL1UqNf1ZEi/h+Ga
 ScJRny/zfvCu6/jiGwf41lyIBakMT4YNCTZCdkrhwScdGDGfRApPzvZUcq2SgOXwcQBl12+7l
 zHILKRT6KwwERK0BUSERG4Uicjlzm9CajSj+YadpJoq/j1D18PTzCAgieN1C6dfJKL0nqgHGv
 HqtqEsZo2mEnfcJaBNBb0RtN/Hk6raEqPtqUkEEccxs1VlOXATc7JoXexnVYyZ6acikGloKmJ
 05AHyejBAI4Ie+wJFJqZfV6NAW6YHKD4LG+xw4JeIxHHVS/Q22keYZ4FE2WUJlsE6KBLXQ4/a
 XHv6VYTujMUWgg9MI8FFNN8aGCC7DSz/40Z9HhrlzwdytGcEqH0WYhmmLxvInyywfHhw1gWIY
 yXrRFsFI00MpGW/w8YvAp7M8OFO8Ax6OfGV66in+z54y9u7QgM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Fri, 14 Jul 2017, Stefan Beller wrote:

> There are two conflicting messages I get:
> * only a few fields seem to be polluted (verbose_header,
>   max_parents), much fewer than I thought
> * we do use these undocumented ways already,
>   but not at the scale that DScho is trying to here.

We use mostly undocumented ways, because there is simply no API. It was
decided early on that libgit was never intended to be a public API. So
that's that.

TBH a much better way to handle this would have been to say: this is
fragile, as the pretty-printing is not properly abstracted, and hence we
may need to break the contract at some stage (which would not cause
compile errors, though), maybe you, Dscho, can fix that after this patch
series was applied by abstracting it properly?

Ciao,
Dscho
