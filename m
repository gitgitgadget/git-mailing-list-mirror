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
	by dcvr.yhbt.net (Postfix) with ESMTP id 486141F4BD
	for <e@80x24.org>; Tue,  8 Oct 2019 12:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730763AbfJHMFE (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Oct 2019 08:05:04 -0400
Received: from mout.gmx.net ([212.227.17.21]:43485 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730332AbfJHMFE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Oct 2019 08:05:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570536297;
        bh=Z3b8HjG26BPUoRTlajkMYxgFU4D85aS4Y2qfwkKXq5o=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Ie3UnB8psh8rsf6BYc1DpslpQIzrFyBHRpwbGG5950Ry2785LBRgxBpnxLbG1QGkF
         +t7fzX6fVVhc5pSUC4yoM/wJiavH5TFeh4QnSzlyBAAS+wm+PXX+wqHBBNPdhxJaru
         gISXpuUNvyC3ZnnuXC82TVjL9SWZm6lWpsmfyus0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MWRRT-1icIgl3rqd-00XwoI; Tue, 08
 Oct 2019 14:04:57 +0200
Date:   Tue, 8 Oct 2019 14:04:56 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Johannes Sixt <j6t@kdbg.org>
cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH v2 02/13] msvc: avoid using minus operator on unsigned
 types
In-Reply-To: <ff6896de-ba12-6669-d6e0-980ed0fcd1e4@kdbg.org>
Message-ID: <nycvar.QRO.7.76.6.1910081404310.46@tvgsbejvaqbjf.bet>
References: <pull.288.git.gitgitgadget@gmail.com> <pull.288.v2.git.gitgitgadget@gmail.com> <8800320590e4d7218a80f80abca23a7f44b8747d.1569837329.git.gitgitgadget@gmail.com> <xmqqy2y1a1qk.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1910041154120.46@tvgsbejvaqbjf.bet>
 <ae6a64f4-8f46-cbaf-5004-defc316c5157@kdbg.org> <nycvar.QRO.7.76.6.1910042319190.46@tvgsbejvaqbjf.bet> <xmqqr23q68rg.fsf@gitster-ct.c.googlers.com> <ff6896de-ba12-6669-d6e0-980ed0fcd1e4@kdbg.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:y230Bj0qDTv14j9k3Tv0/3CSv8fDsyHxfKjAGfe7Q1OOAL8Xnpf
 ctMx4MUJCjoam+iFM4wqY8MmrSVZfZIso43ULhikS6722n02XPiYKtGnV5LBPei7n89OHUb
 ADFJ2v7ONYSECZKWtyeZoLd9xJdzno72pskiJftQyywUVJF51n+XTqYqOQJ4O1VzgP9Qp66
 A6w/yUZUN7yz+EhLJEOxQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pOaAt4tfIr0=:Mw9/6i58UPWeK15qpRN5sa
 2UpgfMJFtb5F7KQ6JSGtTIFV4UKmbpTy0GtqniFWBke3+9dXcZueUmREwwMJo0T4gtEIo+PTX
 6MW2szO8uzR2DXfiI4kCdEUyomSWncJF6M6ptnDOORXmSeVNzs6+KEfZnkoxI8pPMVVMD2vsB
 FbXqKHZmzchtOmkKHrfVsMb24RSurkLz2+zOqWGMmZQwJi52gu6DVV15A0LwqMeXcV2P12VP+
 VYW0+6QuqqTi5khOlRHEr1uuNTRYOiYchE2yMM5FNvS3Fpdm6kZZwSMRg0l3iysHLPEKjFOFS
 VYB0gK85HpS2nYQcviUjWIp6YLBQKgXalToE6lfGf21845QZeRSittrmJXOPKE/1waaliOGDo
 ay6+fB6f1YlhVaQ0ComNACHP9IWwH4+8Qf5X+mRIrng9nrRjy8Fr7QwURd34H10QRSfJFcL1d
 5Sw4Pjbg2dpuatYlPKu0CD0JIepqouZotD9xFlReSBbYouBPaAr3R5uzzrv9t+A9/ft9JQ2Rs
 ag524gJmQlxVs3NOanWEKR2mwvvNZNM4yP43vbWZAxTJfm3AWoMroxgJpHaXixg405ZRacsap
 TPFZbSDeY1MdHYkXqmEFptEANXs7c0iniwrvTmGvAaT0USSHSS5d0jQyjk53qoZS4Rtr0r02V
 Eg7xviT+k7tewlmFV9RRlj2TkohcwKTagcn1Wai8i5hibeYAepFVnKxOz1ZHxC3S8HuVf82IN
 lSbjqfM826xMMRjpDU9bEnUyX4GulzDXaguQP6m7sVJhgoiR8Vco+8GO90f37LnLKzD6RQN3y
 0hZ/ZYawcm1GNLGG+5jrLZWG3wC2iMYbwa4NUcmgu7Em98Hpjv4EW0MJgm125aFI2G2B9MqbJ
 A8CRBeUONins5KpVm8x0u6x5Mi+DoyamUKbuYyssZeANq83MV9W62Tk9FBqhRYUIXvGXIXxUr
 poZDXyqPz1MMtC28x6PvCCrpDAQkPDTLNaZ36mu0E8qqk3dtldmQRIqMn0MV6tV5CZOh7xlj8
 wete2+cAijTChk9CRZ8OSECY3T4UuitnOcFMIt66hMVd87khWOiqwky85NwV7Qncf6FV42X80
 i1Y6fB/l4AGAk7X+hxGLlWuaW+wMeYsK18gia4bLFBEK0U4zDFXg+ZNkw5pi5Zw1xMg5prP0c
 aWJz2vlFPIlEeKbFKuga86wNMnTm4c0E42pttUB/ChMkfb+7tX1bwHfgmF6p+5t1SkEV6Ff3z
 2IKqzvvqSrsdL1thhPEbR7vi1twH/E49KfoGVXlpYcKym7jC65UEDI9hDk0c=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes,

On Sun, 6 Oct 2019, Johannes Sixt wrote:

> Am 06.10.19 um 02:02 schrieb Junio C Hamano:
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >
> >>> IMHO, if you don't accompany insert_pos_as_negative_offset() with a
> >>> corresponding extract_pos_and_found_condition() and use it everywher=
e,
> >>> it is more obfuscating than necessary.
> >>
> >> I do disagree here. No overflow checking needs to be performed for `-=
1 -
> >> <int-value>`. And that's what the opposite of this function really bo=
ils
> >> down to.
> >
> > I do not think j6t is referring to the over/underflow issues at all.
> >
> > The suggestion is that, because insert-pos-as-negative-offset
> > abstracts away [...] the fact that
> > "does not exist but here is the location it would be inserted" is
> > encoded in a certain way [...], the side that
> > consumes the encoded "pos" [...] should be abstracted away [...].
>
> Thank you, that summarizes my thoughts very well.
>
> > I think that is a reasonable thing to consider; it is not necessary
> > for correctness, but contributes to the conceptual clarity (iow, it
> > can be left as a separate clean-up step done after the series is
> > done).
>
> Thanks, but I disagree with the course of action: I think we should do
> both sides at the same time. (And if we aren't ready to do the decoding
> side now, then we should delay the encoding side).
>
> Consider someone is looking at the call site without knowing the
> detailed meaning of the return value ("What the heck is this -1
> business?"), it is a matter to look at the function being called to know
> what it is. With another function that does the encoding, it is one
> additional hop. That is my reason for saying "more obfuscating than
> necessary".
>
> That the helper function would reduce some small code duplication does
> not outweigh the obfuscation in my book. That's just MHO, of course.

So you got what you wished for:
https://public-inbox.org/git/pull.378.git.gitgitgadget@gmail.com

Care to review?

Thanks,
Dscho
