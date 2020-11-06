Return-Path: <SRS0=eTRQ=EM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8797DC2D0A3
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 11:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08B0420728
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 11:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="cQ0pokNR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgKFL5d (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Nov 2020 06:57:33 -0500
Received: from mout.gmx.net ([212.227.17.22]:43241 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbgKFL5c (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Nov 2020 06:57:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604663846;
        bh=LJuSTNjYI61Ajd4Ij2y4CiD7loT16xYQ8ZKDsJXq09o=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=cQ0pokNREBcujPAIZZO5KzQVDxyt1o2A6BQiiw2cuuW5gFu8lIp8bQDRb6zg6ybVs
         DGtZfwad9292lGqxoOTllSeo+sOHbxeD1KL/kG3JwTKQynXdurvUlbml+uP+2uE3rS
         OhmFuylT06wGZo4BjKtmtLjU20UTlpPuNGLCSU6s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([89.1.214.166]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MhlGq-1k6KO604hM-00dl0W; Fri, 06
 Nov 2020 12:57:26 +0100
Date:   Fri, 6 Nov 2020 12:57:28 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 02/11] docs: new trace2.advertiseSID option
In-Reply-To: <xmqqeel7ijk0.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2011061255080.18437@tvgsbejvaqbjf.bet>
References: <cover.1604006121.git.steadmon@google.com>        <cover.1604355792.git.steadmon@google.com>        <5d5097b67109554e0763724633810ea616b5e2b2.1604355792.git.steadmon@google.com>        <xmqq1rhaqfqg.fsf@gitster.c.googlers.com>       
 <20201105192847.GD36751@google.com> <xmqqeel7ijk0.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:9Jdchj3rLAMFblsefVFhzCR6nJYPVDjfQAYuN1oZ+lguKYPJoOh
 j6X6UgYemUiR5Qv67zuEw4QWpkP2HVYO3nm0YQstPWF2EioVjSiLsChdAetN3tvm4lYSjQl
 WJiOmLD8S/v24KIFDgFJdAmb/hCHYLWFV0YwFbQJjtceUALIkmGb53pDep/XQdL5xDmSkL6
 UEKGqBQLPDE+99BXZXsvQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:k/IuRfOSYM0=:Dyr+rcST2uFd7RCip+Lxj+
 Z7MwQRCCrQlJpprzmzqeDD905uo+np3pJoiOOfAsvW6cxgQmPLlM5x8K6dT4RzMH8bdIKClVe
 Clt/RQrX1qWPjq20nEE1eiDCrn3eE+KKDXEu/D2PEWVKnFoDUU5Z9NatyoP8qHXEG0daLY/Ao
 OTVEHkYIDiZUtMhHVFMLOa0zPeaNM9m/S9q9Gwwp7KtS+6XMNzn7bbU8D4zetc35ziVAjp5Ew
 ng7P6lSZ1UlChqCRbBmv1SSp7Xu03e5lCZYiulAr+HB2K6W1SjZhIgQF0zXxrN13KZ9GgcmCO
 9M/jOTBAdUoGU4k1tMkbWA9uRgqrZil5/1uohvEU1p+6hpLwVi4irNu6pGTYCfiqwZRMhae6G
 79gS/wwilyrjHETJHBkqQVgJx23Xl4soWUqoKa7f94eYmY2dIM0iFnZ4mzJtwAlLjPa/kMvru
 cNxRdAyUKzJAtxflhQakkyW8bRQxK5otNhF/6R0mw2/Ov/AfSpLzSCTXtjlk/R8/BVWqhzhuL
 wPKiW0F1eFQa9El40ekvqzayleghlGbLxMdMYlBnRttXRQX0hT7OUccJLVtjVzsS0pR5ytl0K
 plLY2PhNkIJnHYwdkTUQM9Ep0fLIMv6AeJvfuqCE0DCKGHwDCs2bS1RcYkwYjTJCB39gqAmlg
 of09bWg/ZkSFPkNrfNY8EP1sl98h1LeAlzR+pY/df0x2KUrdMO2jLoONoIFRZG/yPkrDATos7
 kDisos5eSuCBglQb99oFhyTkCWkJYdyNBgwq4trg8WLDPI9uO5w4RCWw2SCJRa/GAf+We1lTa
 9JrBpZKM7Gz5T2jrP7VJPRyNBK9wQugwRKdoDAYPfrxbIS6NXsppw2c6tPRDvEhbcYdED90oF
 SIek340aHrX50geUntmPtdmY9BDD/VS6/DzEIY6LU=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 5 Nov 2020, Junio C Hamano wrote:

> Josh Steadmon <steadmon@google.com> writes:
>
> > Yes this makes sense. Do you think it's worthwhile to move all the
> > session ID implementation out of trace2? Right now there are some
> > user-facing bits (environment variables for parent/child SID hierarchy=
)
> > that specifically mention trace2, and I believe that the repo tool is
> > using it to tie together logs produced by a single repo invocation.
>
> If somebody other than trace2 starts using session ID, or if we
> introduce a mechanism that allows a session ID assigned without
> enabling the rest of the trace2 machinery, such a separation may
> make sense at the implementation level, but until then, I do not
> think it is worth doing.

Yep, the closest we came to having another user of the session ID was
Matthew DeVore's `git xl` effort, but that effort seems to have gone cold
(https://lore.kernel.org/git/20200207013918.GA459@comcast.net/#r is the
latest message in that thread that I could find).

Ciao,
Dscho
