Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4972CC433E0
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 15:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2F7D23877
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 15:25:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbhAHPZJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 10:25:09 -0500
Received: from mout.gmx.net ([212.227.17.21]:54873 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725806AbhAHPZI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 10:25:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1610119413;
        bh=6jG+PRLm3esh1vct0KD3ZWZkvRqdJjW4PUMl1c3Oe5w=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=lB78+8OWSMzH79wDUeSulR3XBHhx/Qosiyw0DIWCd3SP7ZeWTNHbAqXUUN9Ev8pwO
         SxPiTD9/hFkKVPAfJkN2dV+U+wm1m0YNczkyB6OO1VUCBbophdmUFso4ZiPKJ5Yxrp
         en2zUpUZz9fPPXtg99v+PNPYCuRrLqsa57sG3Dk4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.251.4] ([213.196.212.28]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MC30P-1koEYq1VVt-00CPOE; Fri, 08
 Jan 2021 16:23:33 +0100
Date:   Fri, 8 Jan 2021 16:23:32 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] t7800-difftool: don't accidentally match tmp dirs
In-Reply-To: <20210108092036.GR8396@szeder.dev>
Message-ID: <nycvar.QRO.7.76.6.2101081622530.2213@tvgsbejvaqbjf.bet>
References: <20201224092431.13354-1-szeder.dev@gmail.com> <xmqq35zdnu1w.fsf@gitster.c.googlers.com> <20210108092036.GR8396@szeder.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-892468788-1610119414=:2213"
X-Provags-ID: V03:K1:cRjuFCQMwhm4LBwOjvPATII2iD1oOM1bXQ3ysBaLYY23Ga/lKNH
 I/uJ1S5hglGA7pvAJ5JhJqgiSVE6ryGAPv1H2DIpql+spPALQFWZJXf/na286V7vDYCUGxb
 6G13u/u3+Zzd2SPulj+6xbF6cIVrfp1KjWSSNoy7Re0ET4uJRm28UsC9hNqz6AwVe3TDMMc
 vD+W4I1E/UnYG5szdcKig==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uKAkfc36hhY=:djdobQU96o9H1DG3jdmxvo
 URv8X/OJPlgTd91DWXjCrFZCxy6BDW+6FwM8uTej6ENv2ZmyUY0anqxuMfDxE4LYhuU7N3g9Y
 YdOZqrXZQ4XyFYS/6DlV7uqrUM7sMSSFkzLY2VhkRfzGS7LALLYziFHmKiDPpy2bZ/DcKXq9c
 Rpqyqad7X89CWyuKNEmEX2GEjjfyNSr3TJrsNoBF8cD+UQI6G5PX27fqo0TwTcsfwkpiyaTev
 qg4B2+0Ug937aKalb6R1/CVXDG+zGOPAMw/Pybn7Ds/OO4wQAajrc7w3q+vnV70Pi9gVz4qV+
 j0xmjtZPUpJoQj1e5raL8MkbXp6qDXXjoaBH96WmrXKKw7+ErgsaJTxOxxgJ0LdqQdw0jLyLW
 6qCm6utfWuEjOzeDikK05Aq+xKICyHqzrS2qePgEFCGBYzBcYsEkrpkIZqfIqp4FARnrZsNwR
 GFK/0LvcJ0ikzwMUyfC4e6NwnBIRRgNouFOcRXBZpf7XFfb2Rk9b1jzN3saAiYpF/01zQPn/z
 AIKwZlczFXGmK4leFSr+HKVa1ibpUbYNcRF3ow+/TQmpzKmevyPGF3Vw3wujzS5pF5GvLa6oI
 O2Wb3FNRvwap7NrPGnAPnp/Kbu8vjoboqGR7P2SaJ/KJ185/HFMi41Q552Tk6KRUR60zJ6tnQ
 0W8blTKr92h7O9A0kNunUW3P4g6VjYRI25a6FMi4GRwHewiLk9f//1EKpLYsgjqxA+BTVHp/X
 GlmnQkorvqyXdiP00ceuTO0AcXfWUAe2iLlRevgJw+/XVDdKpKb39drEloq52KJ1fk3pAQRYi
 F1oCMgR5EWN4N/K/m1ajpH2LfoITxunalulRm6YaxpgdB88eKD/ss0I9ggVIw9wLWXhn613jP
 6tkSg2K8td+cc+kA/yDuQKigxLSUeh+90f0EnKS5E=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-892468788-1610119414=:2213
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi G=C3=A1bor,

On Fri, 8 Jan 2021, SZEDER G=C3=A1bor wrote:

> On Wed, Jan 06, 2021 at 10:24:27PM -0800, Junio C Hamano wrote:
> > SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:
> >
> > > diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
> > > index a578b35761..fe02fe1688 100755
> > > --- a/t/t7800-difftool.sh
> > > +++ b/t/t7800-difftool.sh
> > > @@ -439,73 +439,104 @@ run_dir_diff_test () {
> > >  }
> > >
> > >  run_dir_diff_test 'difftool -d' '
> > > +	cat >expect <<-\EOF &&
> > > +	file
> > > +	file2
> > > +
> > > +	file
> > > +	file2
> > > +	sub
> > > +	EOF
> > >  	git difftool -d $symlinks --extcmd ls branch >output &&
> > > -	grep sub output &&
> > > -	grep file output
> > > +	grep -v ^/ output >actual &&
> >
> > This unfortunately would not catch full paths on certain platforms.
> >
> > See https://github.com/git/git/runs/1660588243?check_suite_focus=3Dtru=
e#step:7:4186
> > for an example X-<.
>
> Hrm, one has to log in to view those CI logs?  Really?! :(
>
> Anyway, I (apparently falsely) assumed that the output these tests
> look at come from Git itself, and therefore we can rely on difftool's
> temporary directories being normalized UNIX-style absolute paths...
> But it seems they don't actually come from Git but from 'ls', because
> that's what those '--extcmd ls' options do, and I now going to assume
> that 'ls' prints those absolute paths with drive letter prefixes and
> whatnot on Windows.
>
> The initial version of this patch just tightened all potentially
> problematic 'grep' patterns, e.g. 'grep ^sub$ output && grep ^file$
> output'.  That should work on Windows as well, shouldn't it.  Will see
> whether I can dig it out from the reflogs.

The logs ends thusly:

=2D- snipsnap --
 ++++ diff -u expect actual
=2D-- expect	2021-01-07 05:12:54.687742100 +0000
+++ actual	2021-01-07 05:12:55.370745600 +0000
@@ -1,6 +1,8 @@
+C:\Users\RUNNER~1\AppData\Local\Temp/git-difftool.a01364/left/:
 file
 file2

+C:\Users\RUNNER~1\AppData\Local\Temp/git-difftool.a01364/right/:
 file
 file2
 sub
error: last command exited with $?=3D1
not ok 42 - difftool -d --no-symlinks

--8323328-892468788-1610119414=:2213--
