Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 024701F516
	for <e@80x24.org>; Tue, 26 Jun 2018 21:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932338AbeFZVhP (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 17:37:15 -0400
Received: from mout.gmx.net ([212.227.17.22]:59833 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932135AbeFZVhO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 17:37:14 -0400
Received: from [192.168.0.129] ([37.201.195.74]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LpPg1-1g3x9K1hWn-00fAnT; Tue, 26
 Jun 2018 23:37:07 +0200
Date:   Tue, 26 Jun 2018 23:37:06 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Alban Gruin <alban.gruin@gmail.com>
cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][PATCH v4 0/2] rebase -i: rewrite append_todo_help() in
 C
In-Reply-To: <20180626161643.31152-1-alban.gruin@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1806262336310.21419@tvgsbejvaqbjf.bet>
References: <20180607103012.22981-1-alban.gruin@gmail.com> <20180626161643.31152-1-alban.gruin@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:PO5I0roFbsw0e/m7gOXeQD2otzE/JAg9HiqqK8qHEWXAAi7YpLL
 uE8nk6aHRWDLPxdMGwvoFCJv854tmWQ/jjqtjdY34mZQaNCWxzpcEM7FssOyzCVjPVK7PvJ
 y5dfjKgdWOrFbEaoSGDUJda+JwkvMFuIQRqzRGCC5IVo5dpGAzqd+SqphqWhqnIPAI1pcGp
 JTpyjQYenAXBEqdFecDwg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QJQMDWzUctM=:nctqt5bKCJXMK5KLwbD58T
 wPQ7bi8mx8JxdhT9mklUQxoRiMuFkKsUnicao16nl/uw6yE79VVfMX0FnNxZGntgR4ceq0+/+
 vwEPzKLPcxx5TC2s/zj6yza2eP+3Gh5X1q7EnZBi9K/S50g9k4U5xHqpw5c4U+7tJwArAWSjH
 LFpwPwtsC8zRcOVEigbodcpBhW4GwUBbnjSsHuQwKLVzqFF3UzjeZmczlcDl5SUIsxCE6XyHI
 9vpOfyNsR65KazhWjO0ty17WFPALcTia8RTsx6z635qn3n5Zzt0E8wRIfYzrjnINKBdnlUNJD
 tXb4t0xzMPAzxK/HSOSPjXm+Cz19/PN6HGwZ/s3L2XkKX39pX0tZfLDpI9SANaLsvnBMZEzyC
 P4zKa8tAS8MXffJvUb/7JYeRLd8ipW0YsrlrZR3V5XHjKbhjq2EYgCKmrRbEhkvqPip7NPjk/
 59lOJMzbQK/l80LdakisjPaS/H5I6FMOjDs//y96liTrJ4oNsUjEA3wkPE8h3Im5wuKhplPzI
 hRMZ0ozq389PuNX8vpZbgdksoVOQ8Htet05AEZIFqm1zbBfOFujaIIgq3PB1KTXKDcoYDdqyb
 ZUlhz8iCFc8K1mgr1TTzTMPCxqF0t0w6xUSDdyylmtivlI4usTdgKLEMk2cDDWtdcYH2ZJTXp
 wnr9ye2hhBI76yaD1x0522IqktvKYeMZhSs4nNxKJnzsGCTAt2GBVFWpHmFXihST1N8UCXH/6
 UKKnbTMR9xH8Nqtj8HOyxsIXh2yL/OgY+KNVLdHKYcUy7xhtssdWAovpI7tBJPCouGcocgEKO
 SNktVCk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban,

On Tue, 26 Jun 2018, Alban Gruin wrote:

> This patch rewrites append_todo_help() from shell to C. The C version
> covers a bit more than the old shell version. To achieve that, some
> parameters were added to rebase--helper.
> 
> This also introduce a new source file, rebase-interactive.c.
> 
> This is part of the effort to rewrite interactive rebase in C.
> 
> This is based on next, as of 2018-06-26.

Out of curiosity: which commits that are not yet in `master` are required?

> Changes since v3:
> 
>  - Show an error message when append_todo_help() fails to edit the todo
>    list.
> 
>  - Introducing rebase-interactive.c to contain functions necessary for
>    interactive rebase.

Thank you very much!
Dscho
