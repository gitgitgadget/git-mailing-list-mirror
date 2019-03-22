Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EBFA20248
	for <e@80x24.org>; Fri, 22 Mar 2019 13:40:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbfCVNkb (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 09:40:31 -0400
Received: from mout.gmx.net ([212.227.15.15]:47347 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728005AbfCVNka (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 09:40:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1553261999;
        bh=40OzgV5lezsaVC4IVjcCHvqiQQrZKT3mLyXZwuyJVzw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=BpOQEHP1n020Lka6DnM7EybYlZoXH513Nelms+rDFgeFBAkabVemL/NhvVqe3zvV9
         8clmqd1dP6wmZkMlA1m2G2Cs9SZ7BGcwbLmQN1NOqZj20WFYXZ458duEzxUVMBoqGK
         9lDH21COranqL18X9GQU4Btmd1bvBCmzjrgmeFQE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MLfLH-1h89c42xH9-000prs; Fri, 22
 Mar 2019 14:39:59 +0100
Date:   Fri, 22 Mar 2019 14:39:43 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Mike Hommey <mh@glandium.org>, git@vger.kernel.org
Subject: Re: How to properly find git config in a libgit.a-using
 executable?
In-Reply-To: <20190322073311.GA839@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1903221436590.41@tvgsbejvaqbjf.bet>
References: <20190320101941.2xjsjx3zfnnp33a2@glandium.org> <20190322073311.GA839@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:nAcmwv7G9VgQI06W9N2GBji4Xs0Ztr0Vf/tJfY4SlFEO38TDF5h
 FmL4Xww2M2mmROMfashmbKa6Au/AxQ+TSr/x2zwpiyQlBPH9UynFcyz4X2cu4eUTd3iQ8nJ
 sMG5FwiDiKjdrlf1RJv/N4aD8qgKEzamoBRZ2JVRpqiEWyZbvpHMiFU/W30VhSUr3sxKz/u
 SgEzqA9el981XFjczLRqw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NwIg366BGOE=:P4UdZAclVTtEAzeQ4g8wOv
 VY1OkoJJvjpC3G8vG0lRJj+ZS3xu0QEYZTy0aQ/BwQjphrMlakn58gtfSrcxMXyMtmW6kTl7C
 SOieOLDtiNct9Tu6ae4IZe6IA+G/Vcm5kKvCATfJ/hpuQTgf6bOOW4tyl6cIoXFlgX8/qEZFU
 ocbg+9E7hmFeIpq65nNjkUhk/8Mm9mldlwcSfOzBV0CJQsLn198/fmTM8h16vK3dQB+29z7jH
 o+oP15+8xrNYl1RHPUY0ypR1gDSqUjiWEJClU45kA8vSsi82yV04RvK1ZGf7WwSRQW7GH2TLc
 x4AzzgLrcKiq/JK7CV54K8D6iO9Y4jMOXUHzwMqhj8nTBgVODI1HEpOjmepVglifAQ2HwkiyY
 9i0PuSuws9j1E1Gklr+OWqCZuTtb63xgFKOh3PZM1ec+1Q+pSQW+76tHGQsL//L1I3k4xCHAS
 Wo2/6ZlI3WJ0Ohkyt7ateg1OFsMbV84S9glUZWg0oy0WXbV+wji8vPax43QzLABACc8XD3zd8
 Mm4arFJETG7emLN6jK083Ih6EU922fpAlh5gKLdug+VsdqIOolNmQR+SPRSZTRElWRqZ5IYqL
 XqxvQGq+6UzWOtmBY0s8GKOaanKkUOdyY2EJF5a/nmw5B5ggHmKj+KKm6INdu9vaBjmZ10aCL
 L50z7MtqJVgdQJcRh+OIb3CSFNLTFbGJ4mhU/28/0m7A9HQc/w6G2AXKv2ruOWG3C2sci7Rz8
 XteJvgfL1AOHEUjiKyMyyz5A0xdggMQV6lFsqrRr/AbWFhSxXKjwQGygGTZF2HLax8kqw6Ofd
 84wRQhbZIAPsvnyOHlWmEsVAU5z5v2xIMR/lAD4S+iSuap/3stgOa9PxnXuWCU0NG0EKcO6ku
 GaDR4CAfxTGp/OQ4aCsS3AK1O0aswtGdap/cB5CK47ecsgMn7FfPy32/6nz0ce6ieUTTLovAC
 qsYJQwHGu9Q==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff & Mike,

On Fri, 22 Mar 2019, Jeff King wrote:

> On Wed, Mar 20, 2019 at 07:19:41PM +0900, Mike Hommey wrote:
>
> > I thought of a few options (it's worth noting the helper is invoked in=
 a
> > way that makes $GIT_EXEC_PATH set, which can help a little):
> > - spawn `$GIT_EXEC_PATH/git-config -l -z`, parse its output, and set t=
he
> >   internal config from that. That's the barbarian option.
> > - build the helper with RUNTIME_PREFIX, and modify the RUNTIME_PREFIX
> >   code to use $GIT_EXEC_PATH if it's set, rather than the path the
> >   executable is in. That actually sounds reasonable enough that I'd se=
nd
> >   a patch for git itself. But that doesn't quite address the nitpick c=
ase
> >   where ETC_GITCONFIG could be either `/etc/gitconfig` or
> >   `etc/gitconfig` depending how git was compiled, and there's no way t=
o
> >   know which is the right one.
>
> I'm not entirely sure I understand the problem, but it sounds like you
> want to know the baked-in ETC_GITCONFIG for a built version of git (that
> isn't necessarily the one that shares your build of libgit.a).
>
> There's no direct way to have Git print that out. It would be reasonable
> to add one to rev-parse, I think.
>
> Barring that, here's a hack:
>
>   git config --system --show-origin --list -z |
>   perl -lne '/^file:(.*?)\0/ and print $1 and exit 0'
>
> If the file is empty, it won't print anything, of course. But then,
> you'd know that it also has no config in it. :)

How about

	GIT_EDITOR=3Decho git config --system -e 2>/dev/null

It will error out if the directory does not exist, for some reason, e.g.
when you installed Git in your home directory via `make install` from a
fresh clone. So you'll have to cope with that contingency.

Ciao,
Dscho
