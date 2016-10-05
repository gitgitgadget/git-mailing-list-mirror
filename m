Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D4AB207EC
	for <e@80x24.org>; Wed,  5 Oct 2016 11:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754598AbcJELZU (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 07:25:20 -0400
Received: from mout.gmx.net ([212.227.17.20]:57179 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753725AbcJELZR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 07:25:17 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MfiFU-1bUbIh2Q44-00N6FK; Wed, 05 Oct 2016 13:25:03
 +0200
Date:   Wed, 5 Oct 2016 13:25:02 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 3/6] Make the require_clean_work_tree() function
 reusable
In-Reply-To: <xmqqy424t097.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1610051324270.35196@virtualbox>
References: <cover.1473580914.git.johannes.schindelin@gmx.de> <cover.1475586229.git.johannes.schindelin@gmx.de> <3b4f46b761589d84b7713c869d00d3231ab346fd.1475586229.git.johannes.schindelin@gmx.de> <xmqqy424t097.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:RhpKANwIYASgSAeahjWlFWEosDAAlj7MhDxDQwwlEuQPO9DQaey
 V7znuRMsN8tO7yYLzIzHvk0XL/ndO/U38qDXj+inSaogtmVGn8eJRIRjw4smbRE6k2tefzn
 zRiMx30XBfiknXlh60+dCL6Na7hHptfEudxE8CvJIjhto+NPo8zZvBrPERDVieh7vX5cdmM
 Wu2kUnA+se1pHj5WTTdQg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GF0RLsFOXf8=:kuWaVGm4JlW4NkKt1voydK
 o2mlHYoo7IQWe7yVEIkmO2yI6stoQLhlfMEJnKfWaEl/sT28aHpji/M1fUEI/qe4X0fnwa5Lu
 rW9UDr9LwL4n6xO4HTXY1CMsIVmrMbxugM8oUJUxIHPYaEq31pveKYKBMmlkBbj+bJdcXekK/
 LasRs+m2+cru4q8J4nGl2q/T8l1HN/fAUtICRBjpytcXSJ2XkPCU6XqmfYHYvOQkquQRoilLo
 z+h1+2oCkN9283Y7lgF3JAPRytZWGRbSXar7TKUN8BxAwic1dY60zc7HUyXcc3HUHvXkova88
 PQQqjXKRNlD+jzVwCVk9/pA5oMUvDtWqBB0X5DNyRxD855Xpz7ESYbpe1Y/bXBKw/S32zRfgS
 Ah3FidtkEU1r+EhhPd06YOFHPUniL1XeK4POOCYrjgHsuSJBp81Pr0us93C60HhsOQNAzqBEQ
 kx9UXHHDcCopBqBstMlSIrVABXr1sT4+NObJNeRAhthu9o7cpVSlaDmdN3CpX17W7zqXqWqlC
 XiaHOEBSn2GkQrmn2/PmVnKEQoFAhSNUbPgDMaYUf0YnJvawjTtn94WttxLvYq9Wev6s3kZ+9
 ifeu0Y6iwOc2CVS6APTt9Yj5EQoEs9x9mrScVGRZMCoDd6jIv+7zHLMD6GMFQ6dEym33nQ0Yt
 WBFSou+o1mtmk/QXZtVOThMFAJ+j2/15BFQ4c+FXoZfv1efZEomrwrr1BMHZJ/CX+AOk54opY
 A0QEVVQRs32dyQRHfwiB0P+vB24rZ183WG9FZ0iznTr+u55Uo1/PH4lrXddtDXMcfhDrrYrBh
 2egRTkc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 4 Oct 2016, Junio C Hamano wrote:

> I'd tweak the message while queuing, though.
> 
>     wt-status: make the require_clean_work_tree() function reusable
>     
>     The function "git pull" uses to stop the user when the working
>     tree has changes is useful in other places.

I stumbled over this sentence. How about

	The function used by "git pull" to stop [...]

instead?

Thanks,
Dscho
