Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 132D91F4C1
	for <e@80x24.org>; Thu, 24 Oct 2019 22:16:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730356AbfJXWQ4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 18:16:56 -0400
Received: from mout.gmx.net ([212.227.15.19]:34493 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730134AbfJXWQz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 18:16:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571955405;
        bh=HquOmiTb+fWoZWzesNGVPDJkdJr+GUv5E3Q1t7kPuOc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=TuQdAkHB/d7E8t2JgarHUKiZNTtDibQVvZiudcPj2BGVZVjE9lyQdYn4SNSMBpFev
         nOr2NgD7WOEtOGSrogvy7TjU//ZcytZ0/fLi++LpaX8LjAHtKulrXdKU7QQIEcBkbM
         VUqAkc7oV/nUDWIIeekErZBIogaS96JicLV8eX0s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MY68d-1iVnsn3irF-00YOvl; Fri, 25
 Oct 2019 00:16:45 +0200
Date:   Fri, 25 Oct 2019 00:16:29 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Eric Wong <e@80x24.org>, git@vger.kernel.org,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [RFC/WIP] range-diff: show old/new blob OIDs in comments
In-Reply-To: <xmqq5zkghzid.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1910250014240.46@tvgsbejvaqbjf.bet>
References: <20191017121045.GA15364@dcvr> <nycvar.QRO.7.76.6.1910222111430.46@tvgsbejvaqbjf.bet> <20191023015629.GA15495@dcvr> <xmqq5zkghzid.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:19TOHGsyhwYgAxS1fEhHze8R+vYM+0Y7bq1YAAw3eKg4QxDd+5t
 q6d8qNvtYRBBaQ0dKdAjYB3WLIsVTPQC/TRZi5x83IJKj3qNHbburaBx/76/8sZrjpAKwaw
 6N0kzKQJUzcuTA6COH8pygsryL0t+6g5w0slaqT1nDI8x8SCUcNf10Fuvq56KLO3VrzYP6D
 jv+2vSaUejxL6/JucKiWw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Pr32jFWcWyE=:pbeHyTanG4tcuLN3GHfjKR
 j+ZbsCNXK+gTYxu5dzemyRZd55Tm3lNCwHrytxMNl8kkHXii1Onrsr2UgVr8nwXtVExrDPYT3
 gc9XYkCZ10h6izlhoLLL7CzeA5cEejkAaTbtQ3FxykiPrHYO5wbH/nM9neanwf3Kz1LZH13CC
 CgKwNkggS4rPJpb39AiQmLcjWtIGGCC2P8I6nTIRFLhb4eFh2qg5ATNJpC5hKzLDTF1NDtTy6
 jI6CRIsGhB2qxYXPX0Rbf4vFh2Xsh5EhbbX9qMMua0HbPQ1Hjd1kFiZjRiHlVJcUouoDSmnbd
 PbeKcjwpf3pm95kM9yoD5ruF8rN86d7vuGBbSGzdSnJ/UOkrtQtxga46z7zza55zjMl+f+yMC
 uR1CnI/XxSMIBewfBdB882FBhUC84CmCp0fpJhkAldO9TgMDgWNWDQygQ/iSbb+1s/T2MlOLQ
 NY6L+/wy8Zhfd+CeS75az1XnxWtxj6x8me0/bHCGx/7DJfB98dA5x6sCpKw5SPeu8fZ6bzsui
 SA7J+rOL9MguWWJWh0TMzZqu1fiILgjGpCPBqpqHocz39VHtbPOiPvurLjHHbbUmiwResNN7c
 TjVDmpecE16mewkWr3VCRgGLY3fQLVCPbe9D2H9pgrh8PExHMT2Y5jyvG7u6c/t7LDMXplUoG
 LJUb+8FfnPxELZiaX9nqnvyHFlUfXM5Kv5+httq0DNws1pAV8alBiI00nKXUpqoBUJ25FKubx
 3vUDiBGZykjGtB/A2RNnuMoDbMJkolUHqhIPBErvUnbvxOC1KRDGik52UO6R6K9KLUBJdJbn4
 uJV8gUmGmMvwH41YSWaRz4k8b3xHuZENhDKg+yPgMrfRAGD8jnwTfwmfxmAFi82Bg2cAZrU4a
 7dYckxQtk7WutJFQYw0qDTYBRPgdIeVQ08oEysmfp8tNynXzdM1HVuO7JKETWAVarkALJSCmv
 Sybu9ABQhxhfIPzIzEu0EmNExdYzLRnijTIq2u6lCF75YzZinNeAw4Fc9k0Ge+uPb4PfAnkee
 grBj+fVetzkQbO+ruCNZZrwL3yXIW6W4TNRwPReZL0HUheBeBza9k9/hrYGlbQeMSrlDJJf/m
 pU/Fk8SEaikCMm4KDzqB6gUDshOG8f094sCjxO2juVqk36MHzzEK9T/JrwbspnoXOFqdHP6dc
 TmDCtqJG0N0lfrMCzlaDWm1KwfKc0NDJjN/PNhOXsfwdRKIj3wfyODhRXEAyaqLLYs56iv75M
 J7rQSolCOFzoH4kN0dqB1jjHKoQbtb9d4HivfcjImz/zF9F/3fBhKy2z5cOA=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 23 Oct 2019, Junio C Hamano wrote:

> Eric Wong <e@80x24.org> writes:
>
> > What Konstantin said about git repos being transient.
> > It wasn't too much work to recreate those blobs from
> > scratch since git-apply has done it since 2005.
>
> ;-)
>
> > We could get around transient repos with automatic mirroring
> > bots which never deletes or overwrites anything published.
> > That includes preserving pre-force-push data in case of
> > force pushes.
> >
> >> Instead, we will have to rely on your centralized, non-distributed
> >> service...
> >
> > I'm curious how you came to believe that, since that's the
> > opposite of what public-inbox has always been intended to be.
>
> I think the (mis)perception comes from the fact that the website and
> the newsfeed you give are both too easy to use and directly attract
> end users, instead of enticing them to keep their own mirrors for
> offline use.
>
> Thanks for injecting dose of sanity.

Maybe your dose of sanity can inject a statement about the case when
public-inbox.org/git differs from a mirror, and not in a
fast-forwardable way? What is the authoritative source of truth, then?

Ciao,
Dscho
