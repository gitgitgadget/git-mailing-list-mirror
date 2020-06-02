Return-Path: <SRS0=E3tc=7P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC701C433E0
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 20:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B175D206A2
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 20:32:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="KSJoIgKs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgFBUcx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Jun 2020 16:32:53 -0400
Received: from mout.gmx.net ([212.227.15.19]:45473 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbgFBUcx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jun 2020 16:32:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1591129969;
        bh=UepxadeyOQGIF+diPB84+5jprci3kHkLHACQ8P2z7uc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=KSJoIgKsa7RZlXeXtl7IygdxpwDXfGFPWqgGkrtTw2I5A+EWIL1l3gf7siuxWnKPK
         vmwXl/iCsxvoYTgRiiKNrW3k11mOy0yMA7zt/7DHZeGuvGkKQoYWFNB09a3ErD+aqv
         HS6GV/gSFeeSaJvjEPP2SOVrgzsXof4GJ6cH09oo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.16.94] ([89.1.213.117]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MA7GS-1jqdi63tE2-00BfDw; Tue, 02
 Jun 2020 22:32:49 +0200
Date:   Tue, 2 Jun 2020 22:32:48 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Subject: Re: symbolic links in Git for Windows v2.27.0, was Re: [ANNOUNCE]
 Git for Windows 2.27.0-rc2
In-Reply-To: <xmqqv9kats3k.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2006022232340.56@tvgsbejvaqbjf.bet>
References: <20200526204539.6181-1-johannes.schindelin@gmx.de> <nycvar.QRO.7.76.6.2005282322580.56@tvgsbejvaqbjf.bet> <xmqqv9kats3k.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:weeopKtn/PqEAcvfSGvlYhkZLxWx7VN9J0pehnaoCgXO2gSKzY3
 RmgUdLbRYbmmZZ+bsTkmq3qI4Enz3sHPwC1PYgPLlHm53i2BlOu2laJoNJPK2IdlCQOMrfo
 8kG7TUlACbKKDm2G/+5c9GPe/4tOBbB7vrm6Zvx7UzktCYNrktZitNUehK9C3O1Lbf16ch7
 w+28pMXT5OfR6QWzGUqEg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:p7lXaFVjk00=:8+kVeo0F7ZOlmg+2F635Ut
 iZLchk6rty44QPSKOUfthAEdZe7gr9CxrL55lJFyuKwtGyD0nNTJck/3MRNIrBZ4TUlqesEvx
 Vl4ienB9GH4Ex+jgHCzk7KTRWvUdl8lk1LNT4AKWYedZpJj5dh5vj9Ik/0x+mOD7mFPwwBi8F
 9lhwC0tdYtdFRrxBEf4WGPhhOg11LcOLLnpNWvMbZFvxpUu+7PNb99RBbHjhuvyWZPusbhACQ
 p0ZOtQbG9bRXZYjcCGa1qUtnRdP3l5GOze7lU2IsjLWfm7qbh5yzf6HgFJC6piDhUMi4ZltO+
 TDHQKIcWjs58Q+gkHc4GRAg4DvffkxmcqVuGiEjhQBxbCM50PC7MLjn7nMKiAxZuS6+YE+1d2
 f7RGLwjhGzpXw6W5QqRyWGXGbC3wmbYZO7u5pDEGNnCtR/CD8k3ySmn7aAzxYbg8X9Frd4H6J
 0gZsdZI8ucCwuiPrb6wrtpiSTmtCE++X5dNgIyf4Yy986nfGYvmbBERmGQ/qBsE5mI0EOsAtn
 PJ2yzV1GLhEKTaJCp/DJskX2RPkWj8Bw6V64AOcCXBVcsTGaX+kq+Sxly1hYektQGi773kYdg
 9kXQ8e1/ldOX1MxzstddjqzoT4QiWoGFDtpdocLVcspLJ2jzeYPODnEUJ+h7w9mRJ8+j53vsh
 wSEq6tMaDE2nf1A45IMi4mnUbaLcJeLvU140SsTuwoM3A/C99kEkrtjB5oAfTjUQuTyiv6eLV
 RVrd+TUMaZzjf2NA7DM880DzpBhM0Wu2QnmtuYJSwq0hjhCyovq/jfiUGszpSqhdqeDRKEgMn
 zn0cWgDTHeLRVhr3uat7kRBdZz5t07BP647bFfuzPKRTk8v64M1t2EljBM8zLmfjtupQbDM8P
 1oZ4wXgR4/lsEwLeCWx/AZySU2mdWxTUbXVC/dIXjiZbf8n3n5ZbOCOhAnNkWtkUMDMEpGb+4
 OEnnKYHBUrtvw6AxgIrQx7k2XcVBpAKZsOfBJorOEfbevG5BRP2+PbDj5bSpF8DYj0aFQ0TLb
 x3lizHNq56iIOZpvipMx3P5U29VvPJmUBAnkE+I0bLGDQiHBVz/4pnKg0ijvITgKqW8oQItGk
 c9Gvxvq3tUSvZfzW2/cSflqonfWXm6MioB8Xk9InzWzUJj3vHkBq6xkqFKY4rJb3/ETuGbHVb
 QBBN2y/rclswG6GGJshOK1obKvs6vuECNou7XNMH4trlvsTWCOSMGay43Xu5XdEQzJBxeP+Sh
 XdepoYBMrcy4Tvpmn
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 1 Jun 2020, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > Git for Windows v2.27.0 will be out on Tuesday (or even on Monday if G=
it
> > v2.27.0 is released early enough).
>
> Thanks for a reminder that Europe is ahead of me by about a bit less
> than half a day ;-)

You're welcome ;-)
Dscho
