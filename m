Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A37C47082
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 14:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B447A6105A
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 14:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbhFGOkV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 10:40:21 -0400
Received: from mout.web.de ([212.227.17.12]:59863 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230193AbhFGOkT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 10:40:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1623076697;
        bh=GWIjoIeVCh1QcL5GZpc7tc6NSL2Alzufxps9QBFTN24=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=WP4TkNFc6nafe8fpUepUR99FqL2IYWcpNok4dU6CWR0GPnrxz2BazpTeq0CCU1BuC
         ibv+WMm1tBOU/CES/Iz2YRGOBzn+zR+p0jII9EjRTLymC9/eR0miN4OZuJzNw2quz4
         6cvVUfHXdWbc0KCSZpVfqITaYUi/DPLn6Anvz5ck=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mq184-1l3R3D0n7y-00nDdH; Mon, 07
 Jun 2021 16:38:17 +0200
Date:   Mon, 7 Jun 2021 16:38:16 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org,
        Taylor Blau <ttaylorr@github.com>, Jeff King <peff@peff.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v3] t: use pre-defined utf-8 locale for testing svn
Message-ID: <20210607143815.77djyvxf4xec2qht@tb-raspi4>
References: <20210602114646.17463-1-congdanhqx@gmail.com>
 <20210607004838.15235-1-congdanhqx@gmail.com>
 <xmqqk0n6wkrr.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <xmqqk0n6wkrr.fsf@gitster.g>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:kpd4p666hLadLYnSmg4vdjqwa+Ix3+VPRMf6r3LfLditkRCetVv
 HGiXg6n4WnwgzV51Ix3yyV3Ou4x54xuCJidvxUdQ/ps2v9u/sQPewYPz7DtuAKk/KP9fnv4
 vDHdR7TQPIKTDk1sYgTLZqnWG6IqQ1zNFSZtrBRdLoGnQx+cK+y9/3cFoDTnmgKE/OG0WQE
 mk/PFYGc1YC8hOPmXHG4g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:v8949SajnhU=:gKuP7RkC345gFZHYCnQVD1
 zuY1h3HTxJ3MDLOMZgyCnLC3PGRCfJav+/khlR6Pp2IRiNuVDfOubW41APGOTYAca+szLJ8p8
 fEMjFy3YeHDLeThkhWNh/X9TLJG/XoupJ8O52p9E+JitfXbNSg+vQgXzKeh4B1XV0BS4D4DkO
 o7cVnHND6q6zXIcKwC7O5dNvWYoOWlTW67HAf6VbdAFRVESdpt7AxzcvyQI9Pk1PQG3PGLwXp
 2c9REWggsyWizIcZrzGxtYV/CU4SqodZhQwaYm6y4Iox43s4GUhkZr4FpKAKiZL4HeBQbx4o/
 I/o50psfmkX0UUDh/2+/oAO5SximuZEU7by5ESSFK74L1xYl2jACAA0e5AKAQqmlEOZ/yRgbs
 pMYWOpjmXOVVviGCaVDivrbagFEp+gPp9BeoLu/vK1UW3ExKQA5TfPRszojZ2l6U2tKNTV93J
 hKJWm5xueVfliV49Qf10l+TWoCNzaA81hBiPZPFQWVuN0jIv17VX/Q9ywrmO6ML9b+NfgrK/y
 /bKdadxeWOm0cu/scFwAsvdlamGEBLkEHYajAiikknyVQcNhAmnqovcgxVhOt5KBEvFJh41Sk
 CMmIlBtBTH/SChDabaTKUPbQGGRE7ERRlx0h91tJhI6s/TcZ1zpAOfVfazkP6SnFPgiil2SBg
 ohR5sshm4heJKdZIVOr/VXq4/5YsYmgkJCjUUjt6SdPE4K/SGXRJvYiOtlP9pJGTLobUx4Gjr
 autoBhHiLknkOgJLKBiBUnE3OAY43+VLRqFeRfzQKu2mxR1EXYLWdLGqex9Sk7PAc0SvQz8gM
 5rXHY45JM3l+jN38dNI42eKGIrbOFsFfPJjUlPopMbd8/6pi5EC3zH87VJzWS/IzI83dlYFPY
 NA+LgcHUIwuW1/2/98B8yWhfr5m+3vW8wuAwOULBLjpEttHHZ2h85+CSx9kMAWvzq9rfA/hV0
 Ckhceav8t/rfiYwyoyv1l57zb2BVK9OLH/3xpDwuK7M1s9Vr7mIxz1gE/eiOD+5PykALSZQ57
 aj0NJqqeB6dw/g70hAxL5UatKzAbGciSi5GRFhDKs74+PP1tPItR+8mxnIpfZRy+efFzdU+o4
 ZjWq1kDSKavPbwqddog2pHFtcKBX9SVMBdJ
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 07, 2021 at 10:01:12AM +0900, Junio C Hamano wrote:
> =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> write=
s:
>
> > Subject: Re: [PATCH v3] t: use pre-defined utf-8 locale for testing sv=
n
>
> That certainly is better than "user-specific", but a lot worse than
> "user-specified".  "pre-defined" leaves it open to question "who
> defines it?", and it is a reasonable interpretation that the locale
> may be hardcoded in the makefile, but that is not what this patch
> does.  Saying "user-specified" would not have such a problem.
>
> >> I kind of wonder if trying "C.UTF-8" would be a reasonable fallback s=
o
> >> that people don't even have to set this extra Makefile knob. But I'm =
not
> >> sure if we have a good way of testing if that locale works (if we can=
't
> >> find the "locale" binary).
> >
> > I also think we should fallback to "C.UTF-8" instead of not testing th=
ose
> > tests.  However, I don't know if there're any systems that not have "C=
.UTF-8"
> > locale.
>
> I do share the feeling, but have a hunch that systems lacking
> "locale -a" may be either superset of, or has at least large overlap
> with, those lacking "C.UTF-8", and the new mechanism introduced here
> will cover both of them, so I think it is OK to stop here, at least
> for now.
>
> Thanks.

I did a little bit of digging, the first (?) usage of locale was probably
introduced in the i18n patch to use gettext and msgfmt and stuff:

commit 5e9637c629702e3d41ad01d95956d1835d7338e0
Author: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Date:   Fri Nov 18 00:14:42 2011 +0100

    i18n: add infrastructure for translating Git with gettext

=2D-------------------------

I can't get rid of the feeling, that most systems have an UTF-8
locale enabled by default these days.

What does the following give us under Linux musl ?
set | grep UTF


MacOs (my box here) has this:

LANG=3Den_US.UTF-8
LC_ALL=3Den_US.UTF-8
LC_CTYPE=3DUTF-8
XTERM_LOCALE=3Den_US.UTF-8

If, and only if, Linux musl has a similar setup,
then we may be able to skip the Makefile knob for the moment.
Just skip locale -a, if locale is not available.
This is just a loose idea, I need to install the git-svn bindings and
test if the git-svn tests pass.


