Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA32EC433EF
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 17:31:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376361AbhLBRef (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Dec 2021 12:34:35 -0500
Received: from mout.gmx.net ([212.227.15.18]:38201 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1376352AbhLBRec (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Dec 2021 12:34:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1638466260;
        bh=p8oNTpcNz2Eh4o0FaHzeph4VZzsoHipRtLuW1XnAPpg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Jy8uBqfEup9n8zF2rtmgvfo23MAagA7wRTsEmup/QgTFe98ny7sSLzIA1QqTmU6/P
         sKrEEuvtt7PBkw/CmQICA9/fG0ooA6fZwlJicSy5xXBEgsw60rBndb6+etVM9ZpQjy
         ls/L1KtP7wZW+WHxXbk403A5cEEvAHeM6+fUD+dA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.219.221] ([89.1.212.223]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N7i8O-1mXduY0Nu6-014i2r; Thu, 02
 Dec 2021 18:31:00 +0100
Date:   Thu, 2 Dec 2021 18:30:58 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?Q?Slavica_=C4=90uki=C4=87?= <slawica92@hotmail.com>,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH 2/2] add -i: default to the built-in implementation
In-Reply-To: <xmqqee6wymx2.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2112021635330.63@tvgsbejvaqbjf.bet>
References: <pull.1087.git.1638281655.gitgitgadget@gmail.com> <84824918ae4564a9194a1a55124ee8694f210437.1638281655.git.gitgitgadget@gmail.com> <xmqqee6wymx2.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ulFeXZFmNURq+l2RdwUxxhecTrRVvssQgN4aeTlbGzoFX5yErHe
 lToFDzWGWBilfZRQ8LeGTtbTjG/gr+WxekBZskW67SBjJpaEzGrnU/f+J1zZ/0vb7b9cFQo
 hqw0wkUDsFz3gojwLDLmCwK6HdGP/I6LElIV0xEXuhEjeArhC7hykm3Rprc7C+5eMAWKnID
 sd2X/fa6VCcxx/IU4OP2A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fXeRybVxBAY=:EpK0gUBu5Gsbl2mEv96Z/I
 Kt9H0knXd17RqECX8z7sglMMbe2UNja/Ozv/9kqeyaR9X6M5HfAC5rsQ19BQDP19sew1uNwTj
 AWd8uxv3W/ZvaBHyJERhooB+WgqHX8lf9V6Oz2aIAOq/ldVXUesL7mZ3xB31y/GKWjyL81UQf
 QilGc1rHJHwWsqP+E9pITAMFNbwlJ6CaBhq9SuA6cZo3vaZYTzbNnU2dt+2F2GZUAznaiSndK
 xc1L0h/RIddfOE8uykz8GHZRIlAUQrR2eX1f/fEyr8o9LDiC5V981Y2CSvncgIdNMXWVdnLPQ
 JoDJvYnMrwOdqtFMEbBGRTjIIE5Rfo0Ko+n/e0sZ0CMot0paS+Y6vdbJjziyVmhgcs81M1R7h
 +YLBO53cIPsEMFPocbu9dimpOlTJmqY8CNoep/PF4+diG2EHs09Mb2jUcloG6xufvKtIdqKAb
 z+bujJZlcS9kNjuzh9gGWPB0AeGSlzVvuvduMyM1U733qviT1rncDp2jqT16KCx+bfH3AVVSL
 bCU+ZiLoHTgompPyOpgeJbgc2zDXGmxs2SPWNnib85ExaFpZ1uldUaffDharptHTQKqED+Vhy
 7i2pAPSpoZ14wp1wKqIyDaQ6pB6eGZkSQ/s1Be/HN7ZgT5JgjDsw7asmNLfDw55r8TfJaRoSz
 I4dvyl9ZZQ+Sja9dx6Mjbp5moQoqVnYlfgGru7Fo0+5/L/Edu1Si9DYdEMi5ghMEx5ITlTdqt
 7MWlKUm985dqBSqIs+v+m52L9em65SV1GVbmRq7cg9OY+dUKVlNPws5fkdBJiSCJ59PUAjW4s
 kHuCLUXv/l9h7u8CJy5oWTnsAbz4eIcCTW4R7yAczQEGwFrUuo=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 1 Dec 2021, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> [...]
> > diff --git a/builtin/add.c b/builtin/add.c
> > index ef6b619c45e..8ef230a345b 100644
> > --- a/builtin/add.c
> > +++ b/builtin/add.c
> > @@ -237,17 +237,12 @@ int run_add_interactive(const char *revision, co=
nst char *patch_mode,
> >  	int use_builtin_add_i =3D
> >  		git_env_bool("GIT_TEST_ADD_I_USE_BUILTIN", -1);
> >
> > -	if (use_builtin_add_i < 0) {
> > -		int experimental;
> > -		if (!git_config_get_bool("add.interactive.usebuiltin",
> > -					 &use_builtin_add_i))
> > -			; /* ok */
> > -		else if (!git_config_get_bool("feature.experimental", &experimental=
) &&
> > -			 experimental)
> > -			use_builtin_add_i =3D 1;
> > -	}
> > +	if (use_builtin_add_i < 0 &&
> > +	    git_config_get_bool("add.interactive.usebuiltin",
> > +				&use_builtin_add_i))
> > +		use_builtin_add_i =3D 1;
> >
> > -	if (use_builtin_add_i =3D=3D 1) {
> > +	if (use_builtin_add_i !=3D 0) {
>
> Nit.
>
> 	if (use_builtin_add_i) {
>
> I wondered if these random calls to git_config_get_X() should be
> consolidated into the existing add_config() callback, but this
> conditional will go away hopefully in a few releases, so it probably
> is not worth it.  Inheriting the way the original code grabbed the
> configuration variables is good enough for our purpose here.

As I said in my reply to Phillip, I found it misleading to skip the `!=3D =
0`
because we are catching both the `=3D=3D 1` as well as the `=3D=3D -1` her=
e.

Ciao,
Dscho
