Return-Path: <SRS0=aR3Y=3R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0B0C2D0DB
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 22:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52F7B21739
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 22:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="a6o9qZ1u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgA1WrC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jan 2020 17:47:02 -0500
Received: from mout.gmx.net ([212.227.15.19]:34205 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbgA1WrC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jan 2020 17:47:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580251614;
        bh=m6ZQb2SGJrZGZf0YKF0Qby7G9ihX9OomEhKhSNznOtg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=a6o9qZ1u0gNvsKeu5bPPAhfTLo0qjVcbmIN5rao5GJ7TVU+aT1/EUAQHdqc9tsDM7
         Qw0kCHS5hX5Utza6Ok8DCsIodQAVfUB+JIt1PD4PYmaz5yNbGu6/ePb+w+AnHLzMnc
         MV0wC35X/y46G4ezqpALojQRlMRgCypEEXrfF0P0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.86]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N2mBa-1jhlL80b9g-0138uF; Tue, 28
 Jan 2020 23:46:54 +0100
Date:   Tue, 28 Jan 2020 23:46:51 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Alban Gruin <alban.gruin@gmail.com>
cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 0/2] rebase -i: extend rebase.missingCommitsCheck
In-Reply-To: <5f9b02f2-6b77-91da-2af1-d36cb6b137a3@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2001282346180.46@tvgsbejvaqbjf.bet>
References: <20200111173917.15690-1-alban.gruin@gmail.com> <20200125175436.29786-1-alban.gruin@gmail.com> <nycvar.QRO.7.76.6.2001261043540.46@tvgsbejvaqbjf.bet> <5f9b02f2-6b77-91da-2af1-d36cb6b137a3@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-196653532-1580251614=:46"
X-Provags-ID: V03:K1:naAMAQD2ZLO8xVUpD9/pOjEdHsMDg1iFdIj6NURQtCLwYFQc0k8
 o7bE7nDPc8UVkv447jbUNBNZ7kPbJBrvSc0JcPOGYhNRaxlkH9WUTPPwj6sD4Z169sd0uji
 RVgSlR554qDQ12UolT//0Tot9hDFw6YZTE+Js/2srPFP0KpE/viekEsgPjlnx3LUm3rhwvG
 GlFuDouigwuWfpvBk6HCQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9slFYaqUtZ0=:Yak++J/Hm+gTRsrP0JJuCj
 kOjecEWP1KSarhdXHJbMk9YqFs4OEsH6zgMwqSLAnDdYgcrT2SmytaWYKTG+K/xvSTom2nZ+a
 Wagl1qB+gwPlmaopDXbkkq1bVCVaOZl4Z+/BXRQml5oSlTikIP4I60b6dzg0bd6Ya6+og8mZZ
 DqRlXCreLX44XVcYl3Ygd/mdjV5UMyTJZsefng/CzdDOXrJYtQWQ1wDu5YyuByekOTRhN6the
 wUat5g1pBi+7h5uWYdQsYk8eGetWpstmXELQWP0xxDasGpmTWtxs9+ZrO5HRiCU0YPKnbeavM
 uqR7C3H9e8yjXKyqSrMuOpAkTzFZXbmCIWspzxae338bNNR8bCkuTAANU/SwK2BPyACrNljma
 ywAeKTH3Y+5aV/oBbIr1/Y43/r/+uMR1H7HilvsKYFt7bYk06uxzEz0Elfhd+tJqYRAsz2VLj
 uX2guGQztaGSThTn3om4RlQGx1r2UcIppY3TSTvcJmG4Vr14DenqnGv5bqL9F9TFbVBzjp7/D
 uUI7aY7wUraZ3kFBjsSA/MC4vlYjjlU0Wi5dxLzyM3TsmZ4lWbxPIZTi+iZlPDbR8qGQph0m9
 sJdx8uEejxBNngbSfAETD60VHkXbkdDTKw0EGER1ZEYrA1+YWp8JmaJPTHFD9vab6RATrmSnm
 5J1zfpuuQggVKYxqalKVhuoTZbk0ot2ZBLfNSq6TfuIV8lgQYwzY8Nm4nHs4uH+CsYTBWhpFv
 MAAbPUSdNwDiCHsYWwyO1pbATLZlMg1VGEBbs8wfRYYnZlhjZMzeifwPD61VPEy8cYkv9ck6R
 EDzgemOgmYjblgCmy70Lflmc2IUniqmWEyY9R77FbR8mYgSkzcbFa28Mt56K+7bp3YfRFcTD3
 w9Cw9q+tfbEWeMv6uQfxSaNXh62eAuEsGAAu1uiT5/Tjm6Yb9+IOTBvJNHmZVtV6Sx3k9Xv13
 tF8ReJkePbVYO+UlWD5Xm8nZ3szseVRkx177aiYqiEldBLiDlftEapBvyDmp6UlduniPp4nz8
 TudRLt5TgsJ7/ZdQnrnXvnevswL0bFugQB9CAu6AYZ8bdUPUzmR4k2ivs4+9bUNiCwtY2EO0U
 lpO+2yBR7NDpDxa+C7mO5DIcCjCI/g3H3WRSyuzfLxEbYHYTD4UFExKfMSazWott+LTpjH758
 Gl+whI7XKyddAlFGwTuBjo5BFoQ+vRNpVAuqpYPaSokbAFPOd63ln+7KQuZZuNAHZNAC1xSXJ
 dnHcEIxoSY0INwbUd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-196653532-1580251614=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Alban,

On Mon, 27 Jan 2020, Alban Gruin wrote:

> Le 26/01/2020 =C3=A0 11:04, Johannes Schindelin a =C3=A9crit=C2=A0:
>
> > The way I read your patches, they will conflict with
> > `js/rebase-i-with-colliding-hash`, so maybe it would be a good idea to
> > base your patches on that branch?
> >
>
> Let's do this.  This will also solve the conflict this series already
> has with master.

Thank you!
Dscho

--8323328-196653532-1580251614=:46--
