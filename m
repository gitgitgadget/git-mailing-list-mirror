Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E7A11F859
	for <e@80x24.org>; Tue, 30 Aug 2016 07:49:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754077AbcH3Htj (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 03:49:39 -0400
Received: from mout.gmx.net ([212.227.15.19]:58105 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750697AbcH3Hti (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2016 03:49:38 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MCcvy-1bnxCk1r9e-009OzJ; Tue, 30 Aug 2016 09:49:28
 +0200
Date:   Tue, 30 Aug 2016 09:49:26 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 03/14] sequencer: lib'ify write_message()
In-Reply-To: <xmqqfupn9v76.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1608300947540.129229@virtualbox>
References: <cover.1471968378.git.johannes.schindelin@gmx.de> <cover.1472219214.git.johannes.schindelin@gmx.de> <6cc2e834ae9e595625fbbc6922613994098fd7dc.1472219214.git.johannes.schindelin@gmx.de> <xmqqfupn9v76.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ofzp1NhHi2QbzF8eT/PR76VphqcsUAB+8RES7ctavdQmKCIgYjs
 cVKG7oSh7dHpbj0P2DbnV04fOOl9zibnWwutZQAKoKrSvWKh8CnpimTwBk75PeiY1NxsA/I
 O3gsBMU+19mL+B51DgapIyZmNGl84FculzddouJ5VVHS7hPZpG7BD+N3gWtnHtYT1tWb+7V
 CPbshBn++ytqHgZBUmfeg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:r1vmQ0AW2q4=:aaL2Ph2d4ay/dcSxhFlNhl
 7Luui3J6Z9T2WZbciljKgJst4Q6xiEHW1sc7YnvvJHCB0/zxe74YhT/28GhndQAk3RkWWpMo1
 9ct4oqjH5V7X2rh/K+HjdPADn77bLqmSUXjlDIRE9v1Tsi2+89FSHOUjFW6M1HaSpQlHNWNEd
 N9xmdpxxhztKPoMaGcUc202ftgWeyRLAcoevbUajzJNLPe7i0jWH2nrIgjH5kkJ770t7FvYe4
 1ODrOVf2PQ3rnI+NhLgosw2nVqdSDG+t8lDXtDufA2u1w3N7q7rqZcUgpJlTPqNnK794Jj0jD
 vXkOoY9BQDIpETC03JCFrC2hWi5z4Gtah9W0kONwVLgLchOmCOAcJDGHyCwoTYq2I4tPN//rz
 5sWQeX9k2upJ36Q/ZgCG/bZ7QjVEgyFqh1XXKS2BeleBX+ZuhJ8XgvdNm9d3+1Qz2Wpl0RdkQ
 wlayj6IJdZoLfuCVsKUJk4hc92LjqY3xfrcMiCGaxrE/UMmH4TN1QebhBK0sj0CW+zUJAUdHc
 h9TH8UkCkghlSK9RJhcum0z3zAGLH+Ls3Ppiu0ep4LpsIQfG9MAw4dXyk+b5IezDy7V3mAyv3
 vEFzc7mbqzGFVWAP8K2kPCj5zM2sJH/dXghtEU6wOCtMPXOvcHL1/z3iwYuBYMs16qfTDtFFd
 iFJzXWYFkNiQNUaml8EobHjZGAjWAwOPtWoNmHiKoLB+K9zMr5IXLVTl+P37XRSCuHHkJ06mU
 AnvOg86oeJIpREFnkfEQGy0niSs8E/8iOaNH4fHBTDhlrTwt7rwWyGF+nceAPlWy7mqvjdFzu
 0sqEp+l
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 29 Aug 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > Instead of dying there, let the caller high up in the callchain
> > notice the error and handle it (by dying, still).
> >
> > The only caller of write_message(), do_pick_commit() already checks
> > the return value and passes it on to its callers, so its caller must
> > be already prepared to handle error returns, and with this step, we
> > make it notice an error return from this function.
> > ...
> > @@ -223,7 +226,7 @@ static int fast_forward_to(const unsigned char *to, const unsigned char *from,
> >  
> >  	read_cache();
> >  	if (checkout_fast_forward(from, to, 1))
> > -		exit(128); /* the callee should have complained already */
> > +		return -1; /* the callee should have complained already */
> 
> This hunk does not seem to have anything to do with write_message()
> conversion, other than that its only caller, do_pick_commit(), also
> calls write_message().

Darn. Sorry that this slipped through. I split it out into its own commit,
and fixed checkout_fast_forward_to() in yet another commit.

Ciao,
Dscho
