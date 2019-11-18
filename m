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
	by dcvr.yhbt.net (Postfix) with ESMTP id 29B0D1F4B5
	for <e@80x24.org>; Mon, 18 Nov 2019 20:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbfKRUvk (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Nov 2019 15:51:40 -0500
Received: from mout.gmx.net ([212.227.17.20]:55263 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726237AbfKRUvj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Nov 2019 15:51:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574110290;
        bh=U6DcWVbS16qO1rVgnxAilUUj2otgJp3t1jjfjrpvXXs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=AGEwmbV9bXCxjpNtclfpTjUb87GzXXg187hGYTQIdXLbVGAjf8h6Hiu1H3/RBYKMt
         IG6gZ+BYwpRUSQrdBq9gl56mwCUxfbQuF0IaZl75QAHM49JeFxbmQnrJarjY5Ej5UV
         TDN93UBP+lC36K3aTKX1ZcCTcKbhRH9pzQcQoDVE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MRTNF-1iBiKt1Rav-00NRCT; Mon, 18
 Nov 2019 21:51:30 +0100
Date:   Mon, 18 Nov 2019 21:51:18 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     phillip.wood@dunelm.org.uk,
        Matt R via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Matt R <mattr94@gmail.com>
Subject: Re: [PATCH 1/1] rebase -r: let `label` generate safer labels
In-Reply-To: <xmqqo901tfn8.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1911182150330.46@tvgsbejvaqbjf.bet>
References: <pull.327.git.gitgitgadget@gmail.com> <4a02c38442dd8a4c0381adc8db0dce81c253da09.1567432900.git.gitgitgadget@gmail.com> <444f3ec4-abdf-1aa9-e8a8-8b5346b939e8@gmail.com> <nycvar.QRO.7.76.6.1909022124350.46@tvgsbejvaqbjf.bet>
 <xmqqo901tfn8.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:/mYNmSaoRUOdtJILh4byuZ8ZRRO4uSOKAapq/MxfLRxfohXxxtI
 YOHRZh4j5tn4B59NNpXjV3K0AjihWgHE4RIfBN9mbTBSxf4LMGM0sY8qFeOPlTdEUhpr+nR
 ToY2g5QAICkeksB2chzM6ZdbJqr5wgPjiXhQZYddP3fhK14l3iTCSLLwJZmOmgawpPm5g5I
 /6vLOGBavBLEVPq8djsEw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FnFNovaZN2w=:wiNjjvZUwxYXYcW13Wq7Mo
 nOR2jryqyiU129xxZMLuYkVZcgYihL3EYnt6Pp/5nUesmPlnDbxgsjsODgMBkpTP2Sz0s5CLa
 obL1UloEEP4LLL3X5lX8Er28jdOvIQFgJbWj5kz5iq1wDRSqdLsWW0t5bbv2e2mC6u1rIpVY/
 p+LfhB4Yx/zFGqtaiBED45ZJ9Ha4OU3laedDvF5yjwg8HTKZqZL8Q9/LAADQ5B53vdMBBmDps
 XAHIvcnvJsA8Og5uPUjPhkfV5JNKtRS5dZBfzsHsilqgwCz+nkMXRHbYk5utMGnID+i74k71U
 GdxTyRBGXlImi6wJcjO6SbGvU885rfkqm9DZ/jyBVXwd6hf6AY+6YWwe00HUNgce7oWsvrlA5
 w7zOhhUJegMjQ4PKIXqeExeNeFiF2uq7LlsQReHqFLnYYpL58FckbwVEW8Eg47b7zAqrYKUqz
 Dz34y/BosBG4ie/oQmFBelWkXkSCQvysdgyRQBJuVXCEJyLeyKTxq1DTVZ3rmYUhys2K5z9Gw
 lszGSPj/FKTEmloQ786pmfLG7xYVL6kiwNtsZI4NhT26qNmyh2CXbv3ssIceM+uVBwE7Nmha2
 yhPpdhedJGY27mJf/Ve0MyJiLT2KTheIM+CwU4LeoJPfIAY+tqYqbQhWKYGA7jbMY/kzfRZdx
 KJbYTxP2Fx/w3qqFNpNc/RjBbZVeZfOrwuhmJRwuQxi26nwlDBu+fJX1Z1oHom22w8GCDeVcx
 DpDg5pDrqC65aWFn6ocXcCZ1zeracvqJsQB3Xap+mIPMT1WAsFY4MY5nMfhm/ere35CkAPoqI
 /DzZlNmCtzv2QRYjc06/nW9c4oNcU2PAMRCb3I46Z143vUaveOuGYz97BBuJd/vrP47FbjEKv
 Bk2VTD0rH312kFuwOvnigZprFul6ZF3uUSaCsEbuoGyMHHLzwhXTo4HDai56+eTNGchLJEh2i
 Q2GJzXTepkU0vbhEoITBpTGq9/+Ac96Dc8u81K1kSfd1553zdeUNivfSf9TvDIdG18oz6julX
 INJo4ae0wYMyd/IZF7c5p9E8MpO0+JwU5vWJlk2auyrrjoCoIFSKiR2zL8jv8T0VJgizdSssT
 B4wdIP8HR6QAzbk/xaVvU10wEopFo+l/OXvkoL97r0piKHbbxVWqA87uaSs79M4PO84pf5wKJ
 nq0QbNX0FG9r4YdZdRnk9iQLkW6BXz24AzUdmhqLWU2UxBNqlNWU3c53yyf4ZzSKZFsMuiRCD
 jOk6rsXKfnQyVxCtIMNaVWqoZi4nq65LQ+qcPn4ATiFxrffAAHxcFbi7bu+I=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 3 Sep 2019, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> >> I'm sightly concerned that this opens the possibility for unexpected =
effects
> >> if two different labels get sanitized to the same string. I suspect i=
t's
> >> unlikely to happen in practice but doing something like percent encod=
ing
> >> non-alphanumeric characters would avoid the problem entirely.
> >
> > Oh, but we make sure that the labels are unique, via the `label_oid()`
> > function! Otherwise, we would not be able to label more than one merge
> > parent ;-)
>
> It somewhat feels suboptimal, from code followability's point of
> view, to have this "pre-sanitization" to replace isspace() to a
> dash, which is being extended to "all non-alnums", and the uniquefy
> of labels in label_oid(), in two separate places.  I wonder if the
> resulting code becomes easier to follow and harder to introduce new
> bugs, if this part is made to just yield label.buf it obtained form
> the log message as-is and leave the munging to label_oid()?

While the patch looks somewhat bulky without `-w` (due to the
indentation change), I agree that it is conceptually a good idea,
therefore I made it so.

Ciao,
Dscho
