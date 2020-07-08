Return-Path: <SRS0=LMRs=AT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0021EC433E0
	for <git@archiver.kernel.org>; Wed,  8 Jul 2020 14:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1ED82078D
	for <git@archiver.kernel.org>; Wed,  8 Jul 2020 14:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="jxM44do6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729746AbgGHOb3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jul 2020 10:31:29 -0400
Received: from mout.gmx.net ([212.227.17.21]:42359 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729486AbgGHOb3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jul 2020 10:31:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1594218677;
        bh=bm1gyA0ccskpSh28P4M8Knrz+EsVPT4AgYGZtZ7sbX4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=jxM44do6vC56VO/Cid0b9uUbELUOj9KVskamKOQjVkFG4AKWpX2r/yPXRsTmJmUBL
         ZB4MoTVJK3ig3NCflH7tIjdupfXaRLH76n0Hm96m8R/aUCdJEUkGYhbstU4qUm3E9e
         q3CEmQpNz2HLJ+zeiOlKgT99Khnyfzq5f6c29vjc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.26.78] ([89.1.213.9]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M2f9b-1juYHa2QqV-00481J; Wed, 08
 Jul 2020 16:31:17 +0200
Date:   Wed, 8 Jul 2020 16:31:16 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: mr/bisect-in-c-2, was Re: What's cooking in git.git (Jul 2020, #01;
 Mon, 6)
In-Reply-To: <xmqqh7uj7tqn.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2007081630180.50@tvgsbejvaqbjf.bet>
References: <xmqqh7uj7tqn.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ya4hnfODLuCAMz3dAoG7wjGILsWP1HhLSTapcGR8P361dHq8grv
 6wOYVcT2EW63Pd6Hnl8T6dAO7WYc0MTmfWcAsiGBfoYBOAVYu3XgY5T5RM0nQKduQYgSk4n
 mAJmZS+PJBMdJj1ZbW8jX8EGIYB7X7VJZeDXthHQb2sZC/y07bKz0OOPHXGcrsVayPZgS1f
 tzMgC1GJ4/gwrcFp9SnWg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:e3jF4qO0g4M=:ypKYQ1wFQHGX/TUARg+B6u
 xEQ/eTabwQ+ke4AqHgs3J1l1zi9kQw2hVZlaR+kYn13Dwe8BhQNnFss5ebkb+0EF1RhW2aKd3
 Ju6mToTDVa70I5VB6E3DM5KSROL3bFFYQlOlSxRYNyjvO7a5N4i7vJh42+gh1ROytPD+3zSSX
 /3+j4jvwMAFPUDUglMehLcZ99hcRHZhFdAGsZZMAr1R2gB5CR0d+fNE0N56++Q8cZh+qpMQsk
 pZDKP3vNp8VZ//wBgbGIxKL3f2IoSsCppxqm4whtA7/HN8Fenyjp/ErQMvaqPDbzldy+nYgeF
 WAemFN4INPDaOFHxcyN2GTt1GF023uAzp23D+DKv+VbcYAzKErKUADCKu2AgsM0BY66FWeVjR
 3YJRvhm9U9UoqKZx4HomLmZ0Y4vTylkyddNU6tial9nvFX7yjR5/+pKElYFfZ6HSpDpZVDIrq
 +L+c6fhQhSeOeWuq7DjGFv3T9ycyp1ZBv1x6APgu7qW+buFLisxAnIBxGD5uaXxzln5vatGb9
 cMEM2yIDmwFA4p8YR5ziuMKdQ/zFHCoG/ZcX2XCrVQcNRIeWtpO8esWb3doiuIFiOWt0aGrU8
 3Vh0JA8JxFDYqCvDTja3rrlR39F3OFU4gjnXqzOMqBH6TmGL6182/TDPV7ypl1Md2WITYExWl
 N6S6IhhF04EBxvmT+slOv0p83ccvTOot5lmNABfkIT7HAUuPXhwKGeJDoWKNY4dPJjDSVCD/p
 CmbCMCxRTIeW7O1nZJPTJeN1PVc/uPEWADPenHO/cD60Rs+d/IdMRn1GT9YehzHjS1nEomeW5
 /OH5nTxXjyUradjHkokxEzaWyeGcsimalNk4aflaRhVDbV5us+Nk7TKcwr6hi26U52HbZuuXO
 EZxTNwQYjQEcpfgqc6BZbZTu7kZjP9rTUKMKgVzTFLflQe51D0o2mYQvpI4KUm7lcr7Ym4g6q
 a/jiO5FYWryZ1Oi/muxbSjmzML2NH6QUv0jk9nOjZlgzbP2/l691jvtmVEUwWFWhTjOZG0Fy8
 SpP6ZYAkhBbGUqKmzoKmN3/gexCTPg7vQT1COgUhMJ/HVSqTTilnsmWycGs3CahVU5m50mYq7
 I815gCh/ZstCKJGi7Tb/ViDvsyUntdfzDTKw3Ql6Gofe9sDph7bBc7H1Oa6/CaRCvHdG7t5bT
 U4pHWYx7sItcJMRbBQmi/cmbu2fpTzNpiU7QCfkZMqy8EANAuwthykO+kvSSwopXFGyHxCj44
 AvMBBa8EAaExeB1QtpnQbiryJoPgl0sTIARSitg==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 6 Jul 2020, Junio C Hamano wrote:

> * mr/bisect-in-c-2 (2020-04-23) 12 commits
>  - bisect--helper: retire `--bisect-autostart` subcommand
>  - bisect--helper: retire `--write-terms` subcommand
>  - bisect--helper: retire `--check-expected-revs` subcommand
>  - bisect--helper: reimplement `bisect_state` & `bisect_head` shell func=
tions in C
>  - bisect--helper: retire `--next-all` subcommand
>  - bisect--helper: retire `--bisect-clean-state` subcommand
>  - bisect--helper: finish porting `bisect_start()` to C
>  - bisect--helper: reimplement `bisect_next` and `bisect_auto_next` shel=
l functions in C
>  - bisect--helper: reimplement `bisect_autostart` shell function in C
>  - bisect--helper: introduce new `write_in_file()` function
>  - bisect--helper: use '-res' in 'cmd_bisect__helper' return
>  - bisect--helper: fix `cmd_*()` function switch default return
>
>  Rewrite of the remainder of "git bisect" script in C continues.
>
>  Expecting a response to reviews.
>  cf. <nycvar.QRO.7.76.6.2005230007260.56@tvgsbejvaqbjf.bet>

Maybe you could change this to

   Needs more reviews.
   cf. <20200701133504.18360-1-mirucam@gmail.com>

?

Thanks,
Dscho
