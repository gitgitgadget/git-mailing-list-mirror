Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8599C432BE
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 10:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5A4660BD3
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 10:26:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233424AbhHRK0d (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Aug 2021 06:26:33 -0400
Received: from mout.gmx.net ([212.227.17.21]:56633 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230435AbhHRK0a (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Aug 2021 06:26:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629282338;
        bh=0EQ4IU0yIF2FeTI/oox5uJFnTl5bQ32xVkV6vVK5hNI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=bZpQKbVwJhwgkTkboenoGM5QhLLLTBJtnD20fOavJNJ1DX142uUD3L1ptOG1n+d5r
         aMAvfGOxiV0Iy3VBTiTS5iCyYApeJgaqoA24z2aBG/MkxcJqxJHIH5mq6J3/fddX8R
         mlf1xh+aMB0Qat4jUikO8NfmadM7auOdEETxs7X0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.215] ([213.196.213.229]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MZktj-1mbwmL2yZT-00Wjzp; Wed, 18
 Aug 2021 12:25:38 +0200
Date:   Wed, 18 Aug 2021 12:25:35 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        ak@linux.intel.com, Jeff Hostetler <git@jeffhostetler.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH] make: add install-strip target
In-Reply-To: <CAPig+cT5nPJ7NKFKXRQJwTzL13oEwzMBBpAa+P+XoZxO9SEKKQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2108181222120.55@tvgsbejvaqbjf.bet>
References: <20210817110728.55842-1-bagasdotme@gmail.com> <nycvar.QRO.7.76.6.2108172327290.55@tvgsbejvaqbjf.bet> <CAPig+cT5nPJ7NKFKXRQJwTzL13oEwzMBBpAa+P+XoZxO9SEKKQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:wZ11e8DIY6Ia/PQOAdHhYjFyBwnAM7tmnaKl0Vr3y4GjehMXwK0
 NU15DuFWudAMeCDNAnhOjr+5a2jTd8qBDRA79YdlatFnFC8em71qLrnas57AhO8fKLmZ7a/
 B1v0QN8Hs4mw/P2TyxunlQ/JX1Ws1gGkG+a7aSffjoJUDce0kqvPBqWNlExrOgB8rCIh5kI
 0AuX4Brl+vy/8vCmG8BmA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NKdahLtrNts=:CP9oAa5Eozabtv7nonYFJ8
 PRWHscQ2LwEqSgj6axhmOLhLL97T+aehS7qB3N4ShavvzAjB0qrHQMAtu6ufPkfJgjPHPTv5b
 wKqRTy+jOy7vqN9d5HOsECTBE9ziIotOYfzZamrQR+K+o9iHmxbZ8DsbUaVPeZyjtEf+hRuAy
 rZYK/7GgMCeLV0urJN8gaeQzUU8yyH6/hx3nz2ksXTxzIkucgEGCcewV1OGnlNEBhYmyNEQR7
 wczXaLDUxyuIxp0+etCfSWCt5o2CgxbfY3AAJVGrIfhnVWtQao24uB9aYGP6GizEriDkq27TF
 +oLY/iuets2ws8PBIXHU0nUPqn1aIVk6tJzCzOvvOfHkMf8rMvWZtDKHEC4WyUBovjiLDflUn
 B2MWCrWOerPhHv8cI22dKUh2Fo3+V9zYUrme9Hi1FLuDOU3hSu0VrfS/nfFH4KnCPeXvrdgWT
 1Jx6QQBmUpMZH0kNj0qmgK72a1tXpHw/Mu1apgfc7GMwFS7HiwBSADNUJJhCa4CJSGRKc04cx
 9rNMKkU4peSM26KgMtC64P9lMQobYJJHbIpCgQq1VWmv/0sUnSiSSQ0wJcwFcJfvkBVsSaSv+
 bibVOc554Y7wS6KkeX+tjRU4QZckmeXbDU75/QuUpVwpvGdIc9VmlVJXxBDqVlKTVbGOZyZL2
 Q15L3jvzkxLNjkRQWcTLISzWTGvlxAa01EIjMjeWzAaq8nUmNPNDMI4GPDrC+9lN5NRTuyqfx
 E0YWV+JFuUwhfsbzzF6xUM4cLiP8s8t0PAPEj15FyJW1qCvaJ51TrrBlkGx3APPivUx8qsril
 yshUEa63gB/R216Q6LEQxWi/xIgNqtB4lgg/2UCPaTo7sJfY2+sEYJAWdfzcmJMriSiYcsJ9S
 8ItPW5rK65dcmh/CEYzxbcmcENdj4qCW9mXxdKkOGZbynpYdN/kcPCDIk1MoIE6B4wW1v4MtN
 nAeVITjn+HjlbL7gzB2rQzz6TJkmBnIocSVflOGBW4V/nvuNiexDV5gWSuZyCugfA3AP78ijk
 Z83dS4SJjmR/Q+g0D8b/Nv/Oxu1MZe/tyjx+sFWblOJm292YqSX/CJd4WIhHioZh0fofIlmX8
 T48gdH9iWWV+E8/VK2OqWdq+wmw38hnz//OG0ojOGWd7P1jRwHO4Ac6Qg==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Tue, 17 Aug 2021, Eric Sunshine wrote:

> On Tue, Aug 17, 2021 at 5:29 PM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > On Tue, 17 Aug 2021, Bagas Sanjaya wrote:
> > > diff --git a/Makefile b/Makefile
> > > @@ -3093,6 +3093,9 @@ endif
> > > +install-strip: all strip
> >
> > Would those `all` and `strip` targets interfere with one another if `m=
ake
> > -j2` was called? If not, wouldn't it be sufficient to let `install-str=
ip`
> > depend on `strip` alone?
>
> A more pertinent question, perhaps, is why would we need
> `install-strip` at all? What benefit does it provide over simply
> typing `make strip install`?

That would require an order-only prerequisite (see
https://www.gnu.org/software/make/manual/html_node/Prerequisite-Types.html=
)
for `make -j2 strip install` to work correctly, i.e. something like this:

=2D- snip --
diff --git a/Makefile b/Makefile
index 2d5c822f7a8..9987f3b2c13 100644
=2D-- a/Makefile
+++ b/Makefile
@@ -2990,7 +2990,7 @@ profile-install: profile
 profile-fast-install: profile-fast
 	$(MAKE) install

-install: all
+install: all | strip
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(bindir_SQ)'
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
 	$(INSTALL) $(ALL_PROGRAMS) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
=2D- snap --

I am not quite certain that this is compatible with other `make`
implementations we still might support (if there are any, I remember that
we often have to rely on `gmake` because the native `make` does not
understand our `Makefile`?), so that might need to be conditional on GNU
Make.

Ciao,
Dscho
