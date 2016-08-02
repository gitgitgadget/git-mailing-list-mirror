Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 390ED1F858
	for <e@80x24.org>; Tue,  2 Aug 2016 08:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755820AbcHBIbl (ORCPT <rfc822;e@80x24.org>);
	Tue, 2 Aug 2016 04:31:41 -0400
Received: from mout.gmx.net ([212.227.17.21]:61045 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752417AbcHBIbO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2016 04:31:14 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LeiJ8-1auuP33Bdu-00qTEc; Tue, 02 Aug 2016 10:12:31
 +0200
Date:	Tue, 2 Aug 2016 10:12:29 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v6 06/16] merge_recursive: abort properly upon errors
In-Reply-To: <xmqqlh0gjpr6.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1608021004080.79248@virtualbox>
References: <cover.1469547160.git.johannes.schindelin@gmx.de> <cover.1470051326.git.johannes.schindelin@gmx.de> <8ff71aba37be979f05abf88f467ec932aa522bdd.1470051326.git.johannes.schindelin@gmx.de> <xmqqlh0gjpr6.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:/M0wKMdhcphe9kp7Gs7yJiF/4wI2Oi1ofnN+v05SDjBcPfHsy5U
 XrwekPl233w8uHJcZBCdNArCRbxoZwESYsM32lnsAyX0Bi56zUb3vZtG3s2ju1t7tyTxQcX
 N9VQiIJ+SCXZ2lnenIWGHeo6bxJo25WocOrYoAUmIw9BRmwrb4NWgoapWEBaTOCFwEK7iOp
 CkuU+SbbuvyBck0lMqBfw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:aTyKbLJ4UzU=:xB3MD+sA42Cw4a7r4qwjbX
 ijVNv70e4Dkl1wvwsfTxO6QGJcZLEBvSsywjrVS64Os2miRstCtJ2DUWj5+Vaf6HAJMJ5pg4+
 wXGGRUhZsugkofBb1q0NbvUduuGRstrNLzmbZ3EylyfXsQQiO809za6A/7g0IdZuDyA9kpWeW
 12unte3PlHPxg4hlBVq7lhngbuzKWhPRAlpL9RQDZO/7xaP1WWyJtN61Y2St83AmWSbDj8k7L
 8xcIE+6q5u+gxdDtBDCbpx+e1CgnTlBvwwg9WM/j0BZ1XlqllFDMxWqcfoaCM4h7eG2fmsndX
 ZTIAlc/+Ye1kZZ3Nbm/HVW/f3rV2Kd06fL8FW9y013heMP5Eg1igP/mmLKLOIQQ/4GCKJJFM1
 NwQmGvvyZmxkO/1W6vCq+vbaLarmY0vlOHAhB/woLUNM4fDvNFBmXTcZNSiCnJjljpeHt26Wb
 oqKZDFvtHJMvFYvT2CBs2ytJH72kWk8JoeLLhPAmLykeQhQbZfqdqUzcjqOmTBAuzZRNctQlb
 IGj0iXPbV3ko4L56IJtum3W603TmCdtlirsMueIaUt0J4k8U79Xx7uNIfxnS9wlZi21BQGK6D
 nlF8iOh4HEg00Z3qyw4/mP5/wfWwlXJzyQyF1ShSs1p5v2STK0aVYxfsdj+XcgJzJO4OmFrd9
 ZqISgblfRNsxrXZUj1sQ7EUUV09KipQN45f9zNkEHnt6lR+axc2uDYqPPo6B2NZm6olAcJsu2
 KrR2zMXR/nvHHDjmprRiLqkOuadpqRRAWK8I3VmA7W3JGAHrHXPiUTwOxZfuT/36lusaEg+u5
 491RW4H
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Mon, 1 Aug 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > Subject: Re: [PATCH v6 06/16] merge_recursive: abort properly upon errors
> 
> s/merge_/merge-/; for this one alone.

I see that de8946de1694a8cf311daab7b2c416d76cb04d23 still shows it with an
underscore instead of a dash, while you fixed my other tyops in this patch
series.

I tend to think that the underscore is correct: this change is not so much
about the builtin (which is written with a dash) but about the function
(written with an underscore, used by more than just merge-recursive, e.g.
cherry-pick).

> > There are a couple of places where return values never indicated errors
> > before, as wie simply died instead of returning.
> 
> s/wie/we/;

Right. What can I say, I am surrounded by too many Germans.

I fixed this locally, in case another re-roll should be required. What you
have in `pu` looks correct to me, though. Let me know if you want me to
re-submit nevertheless.

BTW I should have said this earlier: I run all my rebases, all my merges,
all my cherry-picks using a Git version with these patches for months (of
course, the patches have changed, but not in the most critical parts I was
concerned about, the parts where die() calls were replaced). If I would
have found any regression, I would have notified you immediately, of
course.

Ciao,
Dscho
