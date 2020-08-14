Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 073D3C433E1
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 14:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4CCE20866
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 14:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="jBl0USkZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbgHNO2o (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 10:28:44 -0400
Received: from mout.gmx.net ([212.227.17.21]:40561 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728540AbgHNO2n (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 10:28:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1597415318;
        bh=89y+jRZMBUmvbOsMAUjpn+/BmkzazoFDIHgT3DsbyFI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=jBl0USkZvcapT9CuV6wKIGN1oxIxFlVw3Oq7DYMEPdPj9kIqte1fpZ/mgqG8OX/3c
         AfjxCgF5tk8LdrUfh31EKmnx/iY1JuzjIHCYTu5b6b1F6k+sEjnWC8Y1xydIFc4kbE
         /uZfYBMr12x022o+cQbFzkqc4OjyB/mnSW36iZxQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.231.116] ([89.1.215.129]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MnakX-1kW3UZ03N7-00jdRK; Fri, 14
 Aug 2020 16:28:38 +0200
Date:   Fri, 14 Aug 2020 16:28:37 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH 3/5] make git-bugreport a builtin
In-Reply-To: <xmqqr1sa2znw.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2008141625450.54@tvgsbejvaqbjf.bet>
References: <20200813145515.GA891139@coredump.intra.peff.net>        <20200813145936.GC891370@coredump.intra.peff.net> <xmqqr1sa2znw.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:W7CmoPXHVM5gS4niizbtQmb6/bI3JfaU96//kuQ93rY6Qsy/Ay2
 WUbvIwswFriuWY9WRhXqv7G2/SF4fQhGWgI8SXGbkjcd8w+2Z+1Mib2B0PmBxz6GHthGz61
 M1X7I2pkMV7bvoLWKVQoyU6M6iIskx2S7g5fFKewqJaq78bZgRKaf5rSS5s8S+/nQMbcTBc
 jQ/94mLxt238DIR1vIaGA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:d4x/uwKixMo=:vgJ7CQ1lOnrub9qOu6nNpX
 Qf/VnyW2bEj2BgYX8f3R9V/aH7XyIQ5uLnl96SCwUB9ItZ2CzUPFqDXeee3Ahn1ptUd5r7Fuh
 gy1+eSQ0UzvJWRlnrU2WsGmHlaZMPqJrVhp0ChDs/C2kBAMX73fU7uu2flDlwyR5vqfToS037
 RQQBSe0rdYQrL6fQpvIek3dYKp+0GLtD1HPfVCPfgDSgLFkTk5a1r152QYAliWhseHj/k1Czd
 TmpHkmnDVMA7MKyjfKlgekEAmOZ3FsSyjvD//a7w4WCenBhrU/+K6PyaDz3x/f0Fo89mTGsiN
 oV0TKDfyQStWeodhasGHSZCEePpeDo1dqSt1ZBlIfPcRsm6xiiJ6tMa7NrRYRO3B9DBVUO9Ag
 TNPNm13HsqYNlyVMdsnooUR4IjPfaiXzJxVlNAaiKYW+7Tt5p1Gmrieni/3UkSaAUMBDWq7zY
 +takLhB+ypWTPGobthkwv3hSktNAWD7nkHZIMvjnrTWR/cXsfHG6oade43tfo0USacv0BvUEs
 8taNTMLVKAUk+3YJ+Gt0770oaS+8B3JWMKN414oBACFr4Qcu7laPYYnf23wPPBLWwdvI2mEsy
 AguDt2ByNRedtq68JeO1aTy34rKJhml9N5NoCP/jF2YVltiT39APOQDIc37vR74lAhgeWiErV
 HCVIDWeJ3YvENeRXzhxnsbzH6nPMHMCCsm/KPECihKguhmvekZc8jOdrscmyilxy/O8T62wZs
 y/BoItW4Gu6xnA7ZulSDfaOEdW0FQ6SFT92PO1GlRGM+Hw47u1PrDg7uEmyFGHK3anDIkzo9n
 vTw0sWNz7R+jsUmTiAv25muJ8m3tYzCVOO4CjtGUTnJ8VykgnxWjbK2VEYAqHMOCsu7FXUyY4
 n8CRRNRs8+zs1DN1l0dyLMy5dfE/Ea9T5ie9MjtVNCnp7aVnpBwMqdfSEx8Z0vDuyqNKvWSed
 OtblcbtFLpyN5MM8nYjoCUlvH/z7nVIjB99g888lKXhP8fVU/1+o+E8u2+eKa97ynbXBajnN6
 0LAHrXGgHcXJa5aPR0u6OvmbbdVUQa5qNcH0mmEUrlImaQGg3yknE7f3BcImbNqbl0dtpYw65
 Je7B06r2V99onr+GMJ7UOF9dtexRxDsWx+j5tlEdTwF8h0kL++GpBeAr66J9WO8Hv+H4ROoai
 YBkjQOBvZ07kt9LGgJqRuIJlk+ZqzuxyvzkDbxTVSCwtius3qQ0lPdOtMwm9OBZ6IfsraYdUm
 ij4+yIfI5h/TFCgIy4mdmOMhoiH3JQGoRzXRNYw==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 13 Aug 2020, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
>
> > There's no reason that bugreport has to be a separate binary. And sinc=
e
> > it links against libgit.a, it has a rather large disk footprint. Let's
> > make it a builtin, which reduces the size of a stripped installation
> > from 24MB to 22MB.
> >
> > This also simplifies our Makefile a bit. And we can take advantage of
> > builtin niceties like RUN_SETUP_GENTLY.
> >
> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> >  Makefile                            |  6 +-----
> >  builtin.h                           |  1 +
> >  bugreport.c =3D> builtin/bugreport.c  | 10 +++-------
> >  contrib/buildsystems/CMakeLists.txt |  5 +----
> >  git.c                               |  1 +
> >  5 files changed, 7 insertions(+), 16 deletions(-)
> >  rename bugreport.c =3D> builtin/bugreport.c (96%)
>
> I am on the fence, as bugreport does not seem to be fully completed
> part of the system.  The original thinking was that it may soon want
> to grow by linking with platform specific libraries for lower-level
> system characteristic identification, at which time we'd not want to
> have it in builtins and "we can take advantage of builtin niceties"
> will cause us regrets.  The only reason that hasn't happened as far
> as I can see is because its development speed is rather slow.

No, I think the reason is much more benign: my suggestion to query
information from the respective executables that _already_ link to said
shared libraries seems to have born fruit. It has the additional advantage
that we need not worry about cases where `git-bugreport` would look at a
different dependency than, say, `git-remote--curl`.

So yes, I am rather delighted that `bugreport` finally takes this
direction. It makes me much less worried about the reliability of the
information provided in bug reports.

Ciao,
Dscho
