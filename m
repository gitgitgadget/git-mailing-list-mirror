Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B885A1F744
	for <e@80x24.org>; Thu,  7 Jul 2016 11:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752046AbcGGLSJ (ORCPT <rfc822;e@80x24.org>);
	Thu, 7 Jul 2016 07:18:09 -0400
Received: from mout.gmx.net ([212.227.15.15]:64392 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752013AbcGGLSI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2016 07:18:08 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MKqOW-1bL7JW1dpI-0001Ka; Thu, 07 Jul 2016 13:17:50
 +0200
Date:	Thu, 7 Jul 2016 13:17:49 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	git@vger.kernel.org
Subject: Re: [PATCH 2/9] merge-recursive: clarify code in was_tracked()
In-Reply-To: <xmqqr3b6u6mb.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1607071316390.6426@virtualbox>
References: <cover.1467199553.git.johannes.schindelin@gmx.de> <dd3e2cf842fd5e11e31914aa55b8b995e8d3d75c.1467199553.git.johannes.schindelin@gmx.de> <xmqq4m8b4zdd.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1607011057180.12947@virtualbox>
 <xmqq7fd51ijr.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1607020906560.12947@virtualbox> <xmqqr3b6u6mb.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:QAmNm2x5smJMjQPRL3oEqOUdigMwCBTzfUv0U+RXlNMoar4LbOA
 tNtAOBxgr8ECYZDyaKQBdvxtWJE5QfJ381nr6ZB7ovYQSFICUalaiInIaNBloG0eHK3BDgF
 KZFv9i03ix3bbbx3aY4eqFCdjGtEJawUi1Lji92jxRlLES87gIw60tVNNAbQw0S/342yESn
 aj+QyU6DtUM7oHq8zu1sg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:KBfKDSteUV4=:/Ik/aGFviNT8rfej+fGkQO
 2edigcSsMN0CT9kz02nE7w2QzLfB3DTnRihCHBHRhTsxuZHNuvx5x0sxOCG85vC5DTqR28V13
 8czHynB/8qmJ7HkqqmfsGw4ZoXDDH/DQ/W1JX51cFaRnpRvikmBylKmjrmLKWYRaQGvoQ8p8v
 WcszDWPl1Z4xr3Lx+SZ9x1DVBx0b8pxc7Dw47sMt/dJQ4eoC/PZ6UQTpy5LVDKiJsW4mikiAx
 yyi/RUm8nlRVdYV5xeS3zfXBANHW/bhVPGMMXoOGVAsuSZWj8tzCO7wCiDSG1vnKnqi2cFxkZ
 cDMeJuH4hWn0Pe13Zj8JotZgOz/W27BqPtWSvIrjIuq4NZ+z5AEOwYOLB7i2rFtEeHcGOJWGR
 4Da1+2f6hrQKlH11aESlLmXQ5XsdkvGg36EMij4gpGfKwcx/yKLu/EpUZtGvy41g2gEzgQMRd
 Wcq424Y8RfDicHcnlbtGhOEgXYajTMmU6onyjV37vEwvHgnBA4w2B8ogqEfpyuNfbqBgyO7kG
 Z0G5HcFJjGSPi7WsoUiiSbMOvYsEdPYeum01fGj7W6xY6cm501HeT5YYnE30ZKI9G0sfSjEMC
 hwMIxeu9ZuYPgXFFj25vtZdpNSEzMZtXr/K+lD2t73oLwEwojluXZro4sKV+ZAcGxk3/MVxOb
 oIQ7KIjgL5+Fx+N+n8TEoEBaKI4240DKAqGSWZMLu5aiYytNWpiRzeVVPNyR9xGQ07Uu8f3ma
 D0egQncl/TplTbxcTb/LxzyNBNNZtizM7tAHx7CH64hHFFaq9b8eroYg1pQ0Zsok21ON0TjTq
 p3Zwizh
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Wed, 6 Jul 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > To understand why we're not done yet, the crucial point is *not* that the
> > return value encodes the insert position. The crucial point is that
> > despite asking for an index entry matching a specific name, we might not
> > find one, *even if there is one*.
> 
> I've been wondering why you keep saying "even though we didn't ask,
> we look for stage#0", and now I see why.  The cache_pos() interface
> *is* about finding the stage#0 entry for the given path.

Good that this is clarified now.

> [...]
> As you pointed out, we can return early without falling into the
> generic "we are still looking at the same path" codepath when we
> find thestage#0 entry, so I wouldn't mind doing something like the
> following.
> [...]

As this is essentially what I wrote with some minor touch-ups, I just
replaced my version with yours.

Will resend,
Dscho
