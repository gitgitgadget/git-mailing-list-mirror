Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BBC61F859
	for <e@80x24.org>; Fri, 19 Aug 2016 13:14:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755145AbcHSNOV (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 09:14:21 -0400
Received: from mout.gmx.net ([212.227.15.18]:50393 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752305AbcHSNNg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 09:13:36 -0400
Received: from virtualbox ([37.24.141.212]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LZzKf-1atjje4B2b-00loWz; Fri, 19 Aug 2016 15:11:36
 +0200
Date:   Fri, 19 Aug 2016 15:11:34 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 4/4] cat-file: support --textconv/--filters in batch
 mode
In-Reply-To: <xmqqoa4p4rua.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1608191510060.4924@virtualbox>
References: <cover.1471524357.git.johannes.schindelin@gmx.de> <2315ae5ab6918a7c1567f11a64093a860983bc20.1471524357.git.johannes.schindelin@gmx.de> <20160818220530.2dcsag4qeitia4ao@sigill.intra.peff.net> <xmqqoa4p4rua.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:HMSondlvrYfn+Ltto8zrxpJIobS7FRz1jbL0uXxZvT2+aPNuDIG
 KerexfHoCGTEIaGq8c8rJiF/dUGauWbcxBIVyhJcRa8WWuQHkPkJ2faTBgLBjqC1nzfjkFu
 qTKlqbbklNLpGkSOfbXEsbrY3yk7NPNOaOCK2W1DUBC1lPeyGjLMLS1WffhpYXlo0GG0Cyf
 tzx9j6UllyCO7LZtFDrVw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:I7nwg5njdFk=:cuB/9plG5HUtPN84uOf8Ry
 O+tRaydLaB+evIes40P5gBx8jjsJInN5XmLaJOofvHXUZOtgEcP9xjdosig1+h6PccI0mpitk
 ap8FdAgAV9hwWwJl5SYgoIzLgdpzAEM/CX7JMD3f1LpoL4rrhFvprew6tJf1nzkLACT9qT0gq
 mnM6RZ+F4BBuqO6S7jBp21/uz+Sv/OB+FjQnFLp0j+hHL3YVF6IVU5OnAlOWHA2foOT3hoCRO
 uEJ6XS1Y9B4MelakV7K12Uvcwrxf40eKj4AKooxeDqjU8Vx5A/Pk0rtn5oAr5ly6mX1i0hgHV
 G2q/z7v8SDpGO208CrE3YW24Pnl7A1OU2X0vq4d8qQYOJxEGvBj98m93huCMb0O2/M3av8OSA
 4D2kjHk3LFVoO/M8+wTjVmJG28NFcNjB6zVZizA/axbztbQFM3J681nX4GUfohlO6FSBjjuKe
 ACbHYBclEId5Vu6Q1tfOvVKdNuwUiFf3Dl32CtJTkHuc7GciP6yYTU7N4kH0d5RRyI55mo7ff
 o5DWoUYAOjar5i/IlbbfKN/2sudrnKHNVLPAPRjBetYMEf3Xnrr+EnlT1rYuJElGnIdXP4X38
 Su9W/IT8efvKpENCu2vGmJYtkZf55sFrPWfK6bZzyfuRZkVjDmsPrdYzx9NhFO4BsH73fP0Rg
 jDsXzmcRqqZORqmuetwQ+IyssWVs9YnNQKkvm4GKgP6pDCS6c9pz3f9fne+y49i5OMrELIMIE
 l4tZbSRoBu2nsmcgl+q1DBvJPunELbIPQysXtxIL5FR7SeI+pDsSn4ae52iT1WZIhPWR2XhjX
 I1ginzR
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 18 Aug 2016, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Thu, Aug 18, 2016 at 02:46:28PM +0200, Johannes Schindelin wrote:
> >
> >> With this patch, --batch can be combined with --textconv or --filters.
> >> For this to work, the input needs to have the form
> >> 
> >> 	<object name><single white space><path>
> >> 
> >> so that the filters can be chosen appropriately.
> >
> > The object name can have spaces in it, too. E.g.:
> >
> >   HEAD:path with spaces
> >
> > or even:
> >
> >   :/grep for this
> 
> When I wrote my review, I didn't consider this use case.
> 
> There is no -z format in --batch, which is unfortunate.  If we had
> one, it would trivially make it possible to do so, and we can even
> have paths with LF in them ;-).  On the other hand, producing a NUL
> separated input is a chore.

I think it would make for a fine little project to add support for --batch
-z.

Just not in this here patch series.

Ciao,
Dscho
