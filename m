Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA7EC07E95
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 15:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EDCE613FD
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 15:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235029AbhGPPu3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 11:50:29 -0400
Received: from mout.gmx.net ([212.227.15.15]:54099 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233204AbhGPPu2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 11:50:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626450448;
        bh=gsXLY5KqU6U6+J/Duk4xBVCj9YEGM4qts3+nFpPfseY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=iHNiaOl24P+c0D4On9anIT39QSQvHWkO0O8bqWUnHT4BHJzVYVkzu8TF27toyoYgx
         5FA8RgtpCrYdAng4Axs9l0s5amm9fR5tr8RpEcY8j4i7/8MbhBBpGtRTT5JsHUNij6
         TmdWZQxjEd1uZ945j5xgeOn7j5zHWzYBklCTOVlo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.111.2] ([89.1.214.95]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFsZ3-1lulxP06TX-00HNtu; Fri, 16
 Jul 2021 17:47:28 +0200
Date:   Fri, 16 Jul 2021 17:47:26 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3 11/34] fsmonitor-fs-listen-win32: stub in backend for
 Windows
In-Reply-To: <87v95tbqgh.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2107161747010.59@tvgsbejvaqbjf.bet>
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com> <pull.923.v3.git.1625150864.gitgitgadget@gmail.com> <5a9bda7220356ebf0689bb6aaa9068520dc6e33b.1625150864.git.gitgitgadget@gmail.com> <87v95tbqgh.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-461751124-1626450448=:59"
X-Provags-ID: V03:K1:YbDY9TBuByyhVieM3PnEiROZxw6CP3xwPvTClsT+TMuXW+dVzXV
 CnggcJtGyKPtTsX9hGXHzEVJqwscur/w++4OnO9IzbbkeJElaN7cTiAkRfuyEYcT7ADkeOb
 Zqd/eVYDB+u/RZW7o9ZWdbemdXlKP4+vAEwWkU+94rbW0NeZ+5fqNqSIZD+hTH3r6cykebg
 22vA+uuuXT6KXLLrMwbjw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:e8OFVFSgo/c=:QoSX6DmjlzVN2qfykWM+0Y
 qZ3YLY6xwNrhJaMVLi0DD/IJ49U5PtU/BkDefFS4Wt6csFvA70UtEj6tlsGkvtW2aN26M22Bk
 0h9cLocC4Wzun8lxogo7ZDnL3o2uQtlR83UvbRZ1Mrl8Su+rpWJzF/SeJZo8fARv4rUk7+Hd1
 CSROXvtK0k4tqqiD0y8m5HHaNxZGb/cjg3q4aqroIw9aQ4td58YhxQqFvHFIxk7HFX80BN3L5
 T+N2pQX2gdGbDTq17cPc7OJlKbFTp/730arwOWGah1gkwYGsgiX50cc586Nn3KRYaqNnZlf0X
 nsB3I4/XNz7FnPxDZmB7IyoeD1LfoDdUxQjiaviuwlW7H+JWZAIrJt6l5ynlYt8hRQZOr18u8
 eVZ+mH+4NYK8XXvrHmtaOIzRDYdB1XTrL8qPuniaKtwvDpiuk1VJYLMo3w0AEZ/GaAmeWXbdF
 DsVprEPU8eWhLT7U1W3AIoRp3twXgyYjMmv2Q2Hb9fkUOWxvfC6JV7YOosLhQ673er3KVN5Jz
 cDspix6seE3zXCfT3jmmnKtu490vg3qlgmbfP96Q9xg05BPx2q+7Vn+6OdIKcWRoiJFA7bakp
 rkGb2YE0MTPRBYeWhzVT1HpBSFHpWQ2g5TRbGN50xf/JUDX0Cl/Eof6xk6u/iMRYXnESsk2TS
 xBMLxU7CPzTgW0Xu8M6VnDeBrZ51ZUknt75sV6N4+v26DgSkyE0t2RgCwzmt6WKzYxIKd68tw
 5hJf9zlepc9KQbp9krndN1G2n8FeAE+WYOhrM1mRgwLUEVbS17aQdxkKPXXtv/bkh+5civJ87
 7pEkTpT7+JLIneuY00WbgVVt0t4Ir8EdVelSUxkcmg8ObZ3sFv/PxKnEYlQmT4nv1z+pgVMIx
 2VihHe51PvYV+UhpQqz/ilU3SiBoTc1Pw8SQxBwOYeEgg7MEVknTNuWxXLiDp/6bJlvwywEdd
 beySIP0Atz0VxxB9hb7kp7rEsWfTantzp2KZyr7s1h736I1ZwtOySxi//sOI/62csAg9uwCsq
 9jgpXywQf9fMPTbuXxB2XcQ8rK8x5YofVC2XsfuOjk2L/XrLk9snvNVBCfvLr6fPbIUiFGlFM
 1f/onUfg6xhlztjmKSlj2eLEXti2WquZTiVGaVpfRrnZx/+F/1cK1qyEQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-461751124-1626450448=:59
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Fri, 2 Jul 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

>
> On Thu, Jul 01 2021, Jeff Hostetler via GitGitGadget wrote:
>
> > From: Jeff Hostetler <jeffhost@microsoft.com>
> >
> > Stub in empty backend for fsmonitor--daemon on Windows.
> >
> > Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> > ---
> >  Makefile                                     | 13 ++++++
> >  compat/fsmonitor/fsmonitor-fs-listen-win32.c | 21 +++++++++
> >  compat/fsmonitor/fsmonitor-fs-listen.h       | 49 +++++++++++++++++++=
+
> >  config.mak.uname                             |  2 +
> >  contrib/buildsystems/CMakeLists.txt          |  5 ++
> >  5 files changed, 90 insertions(+)
> >  create mode 100644 compat/fsmonitor/fsmonitor-fs-listen-win32.c
> >  create mode 100644 compat/fsmonitor/fsmonitor-fs-listen.h
> >
> > diff --git a/Makefile b/Makefile
> > index c45caacf2c3..a2a6e1f20f6 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -467,6 +467,11 @@ all::
> >  # directory, and the JSON compilation database 'compile_commands.json=
' will be
> >  # created at the root of the repository.
> >  #
> > +# If your platform supports a built-in fsmonitor backend, set
> > +# FSMONITOR_DAEMON_BACKEND to the "<name>" of the corresponding
> > +# `compat/fsmonitor/fsmonitor-fs-listen-<name>.c` that implements the
> > +# `fsmonitor_fs_listen__*()` routines.
> > +#
> >  # Define DEVELOPER to enable more compiler warnings. Compiler version
> >  # and family are auto detected, but could be overridden by defining
> >  # COMPILER_FEATURES (see config.mak.dev). You can still set
> > @@ -1929,6 +1934,11 @@ ifdef NEED_ACCESS_ROOT_HANDLER
> >  	COMPAT_OBJS +=3D compat/access.o
> >  endif
> >
> > +ifdef FSMONITOR_DAEMON_BACKEND
> > +	COMPAT_CFLAGS +=3D -DHAVE_FSMONITOR_DAEMON_BACKEND
> > +	COMPAT_OBJS +=3D compat/fsmonitor/fsmonitor-fs-listen-$(FSMONITOR_DA=
EMON_BACKEND).o
> > +endif
> > +
> >  ifeq ($(TCLTK_PATH),)
> >  NO_TCLTK =3D NoThanks
> >  endif
> > @@ -2793,6 +2803,9 @@ GIT-BUILD-OPTIONS: FORCE
> >  	@echo PAGER_ENV=3D\''$(subst ','\'',$(subst ','\'',$(PAGER_ENV)))'\'=
 >>$@+
> >  	@echo DC_SHA1=3D\''$(subst ','\'',$(subst ','\'',$(DC_SHA1)))'\' >>$=
@+
> >  	@echo X=3D\'$(X)\' >>$@+
> > +ifdef FSMONITOR_DAEMON_BACKEND
> > +	@echo FSMONITOR_DAEMON_BACKEND=3D\''$(subst ','\'',$(subst ','\'',$(=
FSMONITOR_DAEMON_BACKEND)))'\' >>$@+
> > +endif
>
> Why put this in an ifdef?

Why not? What benefit does this question bring to improving this patch
series?

Ciao,
Dscho

--8323328-461751124-1626450448=:59--
