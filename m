Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFFEE1F461
	for <e@80x24.org>; Wed, 28 Aug 2019 12:25:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbfH1MZi (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Aug 2019 08:25:38 -0400
Received: from mout.gmx.net ([212.227.17.21]:41179 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbfH1MZi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Aug 2019 08:25:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1566995129;
        bh=7D7N65rdyV2igqJbIE79tKG7OUiik4la2LStcfkBP5g=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=KFFecAMGNmCkvVBQMzxycyOoAtF+o0Swt2MIvyQ9804z/CMN2i9bF/7ljh4yQ9uG3
         WHPnuQLfxlamOKqBYBdaXs4n9rnuK9UTyKWT2cc8U5WJ0SOaWqnPGKSByKuPEaqWC9
         8mBjIqMBCkke/+7G80sQUE08Dgoh6piTmkGwby3g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MfBsk-1hrK2k3xla-00OrPq; Wed, 28
 Aug 2019 14:25:29 +0200
Date:   Wed, 28 Aug 2019 14:25:28 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Git Gadget <gitgitgadget@gmail.com>, git@vger.kernel.org,
        "Philip.McGraw" <Philip.McGraw@bentley.com>
Subject: Re: [PATCH 1/1] git-p4: auto-delete named temporary file
In-Reply-To: <xmqqo90bj2ye.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1908281424240.46@tvgsbejvaqbjf.bet>
References: <pull.303.git.gitgitgadget@gmail.com> <CANg4QoGSVQWG3QXzoiA8oDsjXaXGoZ+WMNLSPpu75eJWdrWxLQ@mail.gmail.com> <xmqqo90bj2ye.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:HWjFg6YVQyveM4koOLHMFK+TkKotyAUUqi3sbmcuUACHbcGWUdB
 p3fSsVKqGlStBs1pSf10f2UDTGR5eTZsYJ5y2kwh+y4BIsEXx+X9Df+wtmfSjr5WgrcAM9W
 O5gUlIpVSOBRAZihr3B6WF9hGsrtm2yg7xqSBFov95cnOC5oT8jbjXB9+yUkNhnitBh1bdL
 EphNoIzYH5qlozwQG4I9Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7elr/HD6R7E=:86yBPnpVvJyARccY0iZAfM
 ZamedIR4hzyr26rNnLqEbyrlxfjcMtKMrYgpuLJROgXsZe5fNhB6G4tddJIOtqjJk6RThUg3h
 fWc2VwrROZoWY2iT9p7D3yK9Oeu8nn4ELVA0/JBuyU4ZFQNLTIuFVKheZWCYjMntsxxCYP2re
 Yxz9dAQO3c+1NlsIGneoC4laojbe9XCqBrTmGkf2CQ0W9bevEKyX9p9UvTjlr4A4hlz+gCaFp
 I4b06jDVLsfaEqfETcqutgr4pM9j2r+vye8OOEtEkIPeJTJl6fThASqFRAbC3ChtphJWH7n3k
 35znEvTQy27NrkYxpFiUNMYL2cWaW+gPJkb2ag1PcaESBHl6U59VIxvgUTVuhkYJcw2KbjqZb
 CfZmI9CHUI+TwpzqaQJUYZLlS4A5Nr7vH7sYixy+Lpauq5YothJeKAOacfdKqoMxVvtJfTSzf
 E3hmCB48vS3LEKxkQ+/eAOo8NfKlyRAwY8gzbME+SKOmBfSbsn180z6WtmjKQcOmxsYW4H1g8
 r6zS+dXPAIvXg/fNzc4vecAl2s5CnX1ipEKrrToTLKKB5WDMDgwCABsNkyN87VJBO9sVIU0RU
 5xHLAA/fj/3cMkvjRaS3q4KCyrD9PR3IF1DO4Xs088GFB1uDKXCxZKYjHF4DwCKMYJrARiW+B
 yMMsnmkb+4qJ5pIBM7b2b0yQelxNWSTqvFDAmT0aT89tWMeHzIUKFw3ycaW5LucGmMdEPEg90
 icc5ulzGA6M08213pmRUHmpM0gZALJo0wAe8p9M7G/5GOYvHXU//8lyyfL3/ckRvIcp6yI35K
 xuIox1CGnJoI34lDs9GBof9ctyEOcC6nkcc9kXvZPKpndX4KUb/NDiJ7J3z1sjvliclb8zkwe
 bfNBs+eUMIwr5/AD/D4og0HQNoMt1l1tfc+St/AXGVCW6YRDu7xGMPq4x2ibL2Q5BpayYkLiT
 SAUHhW9CZdqkBpiwWBLKBntRQd+8R4N52lWNGfyljzef1qnJoP+G08+iGxkBGuemS2XCLqyR8
 MEGKRoGBrdCUDea2ZvnYJ1flB+HU92r7+rnU0trR8/hUEY3mVRpjjLekEn5t2Yl4sej7y/T0K
 H99iUo3l3AyaaY9e3rXcz0MyL0OKgERkhn4eY85S38TbCUbKHx9kZzUjSAiM4t7/HoEfumvZ2
 dJBHI=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 26 Aug 2019, Junio C Hamano wrote:

> Funny that the patch is line-wrapped, which I do not recall ever
> seeing in GGG-generated e-mails.  Dscho, do you know if anything
> funny is going on?

Yes, this was me trying to re-send the patch via GMail's web UI because
the first time GitGitGadget sent it, it did not get through (only the
cover letter did).

So I tried to fix the screw-up by sending manually, and screwed it up
even more.

Sorry about that.
Dscho

>
> Git Gadget <gitgitgadget@gmail.com> writes:
>
> > From: "Philip.McGraw" <Philip.McGraw@bentley.com>
> > ...
> > diff --git a/git-p4.py b/git-p4.py
> > index c71a6832e2..33bdb14fd1 100755
> > --- a/git-p4.py
> > +++ b/git-p4.py
> > @@ -1160,13 +1160,11 @@ def exceedsLargeFileThreshold(self, relPath, c=
ontents):
> >              if contentsSize <=3D
> > gitConfigInt('git-p4.largeFileCompressedThreshold'):
> >                  return False
> >              contentTempFile =3D self.generateTempFile(contents)
> > -            compressedContentFile =3D
> > tempfile.NamedTemporaryFile(prefix=3D'git-p4-large-file', delete=3DFal=
se)
> > -            zf =3D zipfile.ZipFile(compressedContentFile.name, mode=
=3D'w')
> > -            zf.write(contentTempFile, compress_type=3Dzipfile.ZIP_DEF=
LATED)
> > ...
>
