Return-Path: <SRS0=FNL0=6A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F9F2C2BB55
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 12:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BDBC20767
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 12:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="gw6yH1Ps"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635096AbgDPMJE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Apr 2020 08:09:04 -0400
Received: from mout.gmx.net ([212.227.17.21]:56405 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2635078AbgDPMI6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Apr 2020 08:08:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1587038933;
        bh=RwSg18yiGwUzvbRDheuhR7UPI8ughFcmAa6Vn5kJLNU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=gw6yH1PsYdvIAKG+VFQwWYBYsqlkzxGdHZHZw/cTSXxcaJZE+H1/eq65YTRkzpmJN
         08qp1QDWh7IsvqtZ3bSXL6Z1bC6eHX7CS5DH3QzFTQpkVWF6mv+kVEF0EykrneRqzd
         gcuVAENThLKDn+wYhS10E0+rtd1o4PCu1AGjG71E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([89.1.212.99]) by mail.gmx.com
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MUXpQ-1jpPsb0Yee-00QX0V; Thu, 16 Apr 2020 14:08:53 +0200
Date:   Thu, 16 Apr 2020 14:08:52 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Danh Doan <congdanhqx@gmail.com>, git@vger.kernel.org,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v4 00/12] ci: replace our Azure Pipeline by GitHub
 Actions
In-Reply-To: <xmqqh7xk45l4.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2004161406480.46@tvgsbejvaqbjf.bet>
References: <pull.743.git.git.1585658913.gitgitgadget@gmail.com>        <cover.1586309211.git.congdanhqx@gmail.com>        <xmqqpncgmk5z.fsf@gitster.c.googlers.com>        <nycvar.QRO.7.76.6.2004101604210.46@tvgsbejvaqbjf.bet>        <xmqq1rovl54d.fsf@gitster.c.googlers.com>
        <20200410174141.GB27699@danh.dev> <xmqqh7xk45l4.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:rAMqjH2zAeCWyyLFogh8dLVZQ+364gsBmnJstb1EKDEscWJjetL
 ESVqMsBGm+UHLvEH897WmLrI1JT1b+BQE2rJas7cMJHjAHFf9hVuY+r23AoLtL7VhqFl40Q
 4fd56CpM9+Xp0SkzoiR3xuFmAYgsBueW+srdhimSL/kfOes1b+2ObzAIv4o/rM8qlqe54VV
 tV88Cky0lCSFqRqcaCoZQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TPOX0wpw64M=:tDzlTgSgi0m7YQQon7Ca3V
 py3njtS0xjD+jj7vlZvWnIPLB6rn60Y3Ily1cRr8QLWFUYs1xGUwuQoW1W0MFA3HG9SqlGky1
 0eYMap+oOeV8+Py6y6hePo0Gmkfn50RXPIhok2n1k2g6lhiNRCtrhq8w1s+JrllT/6TjGax9E
 g1FazXFfTGN7O+v7y8OCYBeeW4Wy3CXX+KQgx29RpFylOEz9TtLd5p3Qvf3SJuVCa6T+gZSkr
 UJ+Sa2e7RVDbJwo7j5+Ww0zdRYvobvbKLB1nPCSCYkaLMzlVMpWVBiWHwmCqmr3r2DXOZMaqY
 AIq6bCF8zQf+g92/I9M5yWw6YOeyXRuD1Gj9rn7QDB6ToSVt6IlxGF7itQYjUTEw9/wrNNyxl
 K8eBMZd/SQIMCIw+49FZ8mzhnc4JcbbGpNDTYJYKr8zqPcLaGf3+MnhsdzZ5rz8+3k37W541a
 PFnqR+nUQNq+/q5HvYpngr+c2WhMwfBSqGN7GXvKNtnikDGsTl8GoUUvwhl+hsvYTsOH5pF9J
 +HCBNq7trqKfTVzlLB0UXaCvu5h8/Khu4IvlZHBGw/iXZMm3AiBaPMKKp9/D3UYrk6hCM2f4n
 M953+LmBMIMg7uarqRzqefwkuZ/Vua7gjqhIU5qm9HECddBFxvFMU9+xLOqCBrOhZXxZAUYAJ
 q+nY5nGCk2lF4D4dpgVnMUr58PFuEOK/kTmqhIDoYuJG3W/NKFVggAeDPQjdiYZf7xbg3C9La
 ZpEKFK3SGwgYCP6XpNv9oLAZHuCEaLu53mVNtAXD/8Xi6/AOGc5HMURbaVe72zNP1ymtTa0R6
 TpUc3r7RbS8cAIhuiWgofWh22mucoZKSFQW+F4bi5z0yOp8xH8qQfPi8ADbVgEcNHFOeujqhv
 LFpW+pCGgEReww8DP3lB+S187TRVkhGC/5GCRDlK2cF68eHSZma2jJ0zPMQfbqcJzB2l/Q+dz
 Awrp3tf5n1wWbJe/b/YYnbIYHHNzQ5QTLi6Z+sLOeGrnokl1TC6tHQWxgslWVi4Nq04GpSA2T
 wYVvNzDbKIGmmSzCNUvfAHt57xaYtjA5T1TVTTyHpK/1qS/11jySPl2uD9fTvn1RF17Z1hAJT
 NGAQ4kzjue5sNZsDg166FaBA1rtgF8+d3qUSJz9COxZTqQ5rJXiIuVxsf01K+iYUbteTty9Mi
 ou8qKufPRldNI3r3uDSwr24uZmuGVFOKxKntXcDPThnk3g1xyjzdDRuabvLI1WIj18mgB76+H
 jY5o5OQfFGjYBPXZi
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 15 Apr 2020, Junio C Hamano wrote:

> Danh Doan <congdanhqx@gmail.com> writes:
>
> > On 2020-04-10 08:42:10-0700, Junio C Hamano <gitster@pobox.com> wrote:
> >> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >>  ...
> >> > I would like to point out that there is only one single topic that =
is
> >> > cause for sorrow here, and it is the reftable one.
> >>
> >> I first thought so, too, but vsbuild failures like the one in
> >> https://github.com/git/git/runs/575116793 do not appear to be
> >> caused by that topic (6a8c1d17b8 excludes reftable), so there
> >> must be somebody else that is broken.
> >
> > Excerpt from build log:
> >
> >> fatal error C1083: Cannot open include file: 'config-list.h'
> >
> > It's from bugreport topic.
> > I've seen this failure in the past (when testing with pu),
> > then I saw it disappear.
> >
> > I thought it was fixed during my testing for v4.
>
> Is the issue something similar to 976aaedc (msvc: add a Makefile
> target to pre-generate the Visual Studio solution, 2019-07-29)?
>
> If that is the case, perhaps something like this would help?  I'll
> tentatively queue it on top of es/bugreport and merge the result to
> 'pu' to see what happens.

This patch is morally equivalent to (albeit a bit more complete than) the
patch I suggested in my mail to Emily that I sent on February 26th:
https://lore.kernel.org/git/nycvar.QRO.7.76.6.2002261649550.46@tvgsbejvaqb=
jf.bet/

So yes, I am very much in favor of that patch.

Thanks,
Dscho

>
> -- >8 --
> Subject: msvc: the bugreport topic depends on a generated config-list.h =
file
>
> For reasons explained in 976aaedc (msvc: add a Makefile target to
> pre-generate the Visual Studio solution, 2019-07-29), some build
> artifacts we consider non-source files cannot be generated in the
> Visual Studio environment, and we already have some Makefile tweaks
> to help Visual Studio to use generated command-list.h header file.
>
> As this topic starts to depend on another such generated header file,
> config-list.h, let's do the same to it.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  compat/vcbuild/README | 4 ++--
>  config.mak.uname      | 6 +++---
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/compat/vcbuild/README b/compat/vcbuild/README
> index 1b6dabf5a2..42292e7c09 100644
> --- a/compat/vcbuild/README
> +++ b/compat/vcbuild/README
> @@ -92,8 +92,8 @@ The Steps of Build Git with VS2008
>     the git operations.
>
>  3. Inside Git's directory run the command:
> -       make command-list.h
> -   to generate the command-list.h file needed to compile git.
> +       make command-list.h config-list.h
> +   to generate the header file needed to compile git.
>
>  4. Then either build Git with the GNU Make Makefile in the Git projects
>     root
> diff --git a/config.mak.uname b/config.mak.uname
> index 0ab8e00938..f880cc2792 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -721,9 +721,9 @@ vcxproj:
>  	 echo '</Project>') >git-remote-http/LinkOrCopyRemoteHttp.targets
>  	git add -f git/LinkOrCopyBuiltins.targets git-remote-http/LinkOrCopyRe=
moteHttp.targets
>
> -	# Add command-list.h
> -	$(MAKE) MSVC=3D1 SKIP_VCPKG=3D1 prefix=3D/mingw64 command-list.h
> -	git add -f command-list.h
> +	# Add command-list.h and config-list.h
> +	$(MAKE) MSVC=3D1 SKIP_VCPKG=3D1 prefix=3D/mingw64 config-list.h comman=
d-list.h
> +	git add -f config-list.h command-list.h
>
>  	# Add scripts
>  	rm -f perl/perl.mak
>
>
