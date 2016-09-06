Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F95C1F6BF
	for <e@80x24.org>; Tue,  6 Sep 2016 15:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755486AbcIFPlJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Sep 2016 11:41:09 -0400
Received: from mout.web.de ([212.227.15.14]:59327 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755397AbcIFPlI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2016 11:41:08 -0400
Received: from [192.168.178.36] ([79.197.217.192]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0Lc8aj-1bFuAU27dd-00jXme; Tue, 06 Sep 2016 17:40:55
 +0200
Subject: Re: [PATCH] compat: move strdup(3) replacement to its own file
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <89725a44-8afa-1eb1-732a-23b1e264616c@web.de>
 <alpine.DEB.2.20.1609040941210.129229@virtualbox>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <6926b39c-4448-c463-33f7-d9eae841c635@web.de>
Date:   Tue, 6 Sep 2016 17:40:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1609040941210.129229@virtualbox>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:eEczhkUTon6W9JbJ8rrYvtwGOHqAjyq1AHPdnL5070NrmgN7ayt
 sZD4DX+/wUILk5xex4IhYPMq+kixz8NwDcQ6HEIWYU/ZScy9PQQtZa64ubh7r+WPKq1zabi
 o44dZxQZLwj64JJhb3vNKzdEzZ2cEDpvDxVzNNgX9FYFfxQN5DAxn+92269E/4MdMVLlQs/
 XIoTllqW3UkZtujPZEJJQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Oiv0Wk7SExU=:ox6S9sx+aU5s24CyHcPyOn
 m+V9e6YhjsoiyUCBTnl2CcP6AHV64gHGuBAzmVhUcd+AR0rrl60Kmpoc5JlTTXPcZZjMoLNyC
 hC5LCHKvWkpgbPM2egrpPXamdnDMYqv9XBslNK9D14Ao1nAvEIqe4ryCUxW+/qMdSPke2rmtt
 AHdVcr3Xet7NWl2DbQP5SaQ4k3cEFpcPkyUMadgpKg7eGon1RMZ4pnhdAh929tFswV0DygNql
 NfUjcLTMM1IsyaIBhAu2MCcXSHsxrjUQm6tt6mo5g9vOZngIWQ/sbARLBGRuWtCGzEkAY+n2/
 I1Z371lmZCCqbDGROB3uBwWc4u2L+gVhf4LJ8Z8e0Yo5TU9UIT1SuAGT9tx9MOO2jbkWviZaY
 XSArvGssYIBe7Zm+imjxyD4opWySaTXL6hOx63I92k4xdnmIk+j2tD7X3pmML0t1nizvH5JxS
 lwIgvhW2n/YlQFRkYFNf7rwlru5qUQVaU3mhnxUG+byTYpreLU4NMTCr9cgbqCc6cPoyZKQBN
 +YJN5S1GpLbrrwpd/SG8xQwe9UNC1pv5HC+HF4VoaM9Y7+SbRxxyxFVvv5JMs4iSdfbbUwZ+F
 YkQDKwpBCdMTbb0ecXvadM8TjdXcp7igMqMe8QoBkLiST5KgtsxneQnhq1P/AWxYp+q1Ey38y
 BPSCMMZN5aBVItzQIFUO7WFZ0/3pqffPYHLx/JJOOC9tuPJKgVCvwF/NQ53t/c/ur8JmJ3hLd
 VC112EdKUHQeDzgCJ7CaLeo9ZgVgyp7a92WjaPQyL03j70tW0qH853js47fihSlVudf7iWty6
 pmhuBzH
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 04.09.2016 um 09:46 schrieb Johannes Schindelin:
> Hi René,
>
> I imagine you Cc:ed me because the nedmalloc stuff came in via the Windows
> port, contributed by Marius (who is no longer active on the Git project
> because it works well enough for him)?

Kind of; it's also a follow-up to the recent discussion you started 
about compiler warnings in that code.

> On Sat, 3 Sep 2016, René Scharfe wrote:
>
>> Move our implementation of strdup(3) out of compat/nedmalloc/ and allow
>> it to be used independently from USE_NED_ALLOCATOR.  This reduces the
>> difference of our copy of nedmalloc from the original, making it easier
>> to update, and allows for easier testing and reusing of our version of
>> strdup().
>
> I would like to suggest an additional paragraph to explain why we do not
> need to #include "git-compat-util.h" in nedmalloc from now on:
>
> 	Please note that nedmalloc never actually uses strdup() itself,
> 	therefore we need not enforce gitstrdup() usage in nedmalloc.c.

Well, OK.  I think the missing point is that the original nedmalloc 
doesn't come with strdup() and doesn't need it.  Only _users_ of 
nedmalloc need it.  Marius added it in nedmalloc.c, but strdup.c is a 
better place for it.

René
