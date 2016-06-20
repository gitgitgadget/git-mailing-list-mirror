Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A85E520179
	for <e@80x24.org>; Mon, 20 Jun 2016 10:12:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752047AbcFTKMp (ORCPT <rfc822;e@80x24.org>);
	Mon, 20 Jun 2016 06:12:45 -0400
Received: from mout.gmx.net ([212.227.15.18]:56874 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754417AbcFTKMj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2016 06:12:39 -0400
Received: from virtualbox ([37.24.143.194]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MaIsi-1azTjo2Nb6-00Jtny; Mon, 20 Jun 2016 12:12:28
 +0200
Date:	Mon, 20 Jun 2016 12:09:04 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Eric Sunshine <sunshine@sunshineco.com>
cc:	Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] format-patch: avoid freopen()
In-Reply-To: <CAPig+cQqworFpRvd-U9sgnyitQEzy6zAKc_091b9fzjuzsFnpA@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1606201208260.22630@virtualbox>
References: <cover.1466244194.git.johannes.schindelin@gmx.de> <de218a6cc529b3f5c33dc4b8282f16fd8a5329a8.1466244194.git.johannes.schindelin@gmx.de> <CAPig+cTiexRhzS3MwMEntGYxKms-XQvtoc7HOnUGJvDaBSK7JA@mail.gmail.com> <alpine.DEB.2.20.1606200814510.22630@virtualbox>
 <CAPig+cQqworFpRvd-U9sgnyitQEzy6zAKc_091b9fzjuzsFnpA@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:lF/cWnfZnj3+0LPzFa/bnpq0VkMiWgWNr3ugNVTm9aQj31fNOgR
 3FpPMzUf3ew667hPod91zZYSGCZCv/HJCmIeHZY97T798JL/H++IQeR6/+wuJDrLXmwmxyZ
 rF0yd9u2ZuGM0+fNJi8SGzv/xs5pJUY73L5UygEZifQXrvs3l8Y9afesjkAmDe7xWZx+t9p
 xNHNoP/DP8IMhHT95I9ww==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:kFTp6tcNXnE=:/qUw+w7AwevyeN9hGoS24M
 KcEHDnwqiq3oUiFg7CxokCu77vsjwXWY6jKFsW060Un5psmSelZ4zKUN2jdPZ1XeXMtUT2BgU
 0lf+QdBaUDxLPb6ZWHqF31thNCIoNyqRUxc1utjTpBDGcHeYvX4ieSVS8dE3GbCBZNURXlYIx
 QZQDUlEE0qKb0IMNmA+O+lJ10a10kkBZutt7eue6+CYVDN3i1PspFbBUxP08yCtyofJvEIoKG
 rEqmgKcuAzCrpwUNCk2ivLIfpl1IE7p8t+QG/v7SmPucwtca5NvGlxVv79u+f9PXaXuoO+n9J
 89lhdiWKvewkbQhOc3ltzgWUfn5JYppjTP68gxinjqORWOZZTBy92X1aIcHfqOerEHY4JElsp
 rFGglP9FFfBre24fcs8wCPTpRuqagW7uXrFDasYngB7y+06IxL8vbjosf/v6JTWfU4qASTbix
 7wzqtEXV3IVcq55RSyUB4kgqaOm/mtkxftukx01CM2f9XpUj+3jXv9UkvzvKzMhAF55DuMsG9
 o0Ll2F2I/pLkUdALnMf79+BfYgZu+5G6lMNyhcDxGa6rl2fWRqbDeUA8lZuuSb9Grdj/K3eBJ
 afX4HMDfO4bh0Sqne1UQP3MogEIEXSVw53Ml4UyRT0rYBmlsETsCotnBer4EGhMclDBIBlFVj
 legQX/Vns2snpDdRv/+o5001cDRBdX23+L0wJ7no7foIGMcxtghO4s109Ayv4av5meVzSN0FN
 v46vBVP6sRui+hM0y4/trc7N0O4r88uw3t1wNyFEh4XuRFtzda8WTPBXD/NfbmQaDlTAz44LK
 Wd2S7G+
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Eric,

On Mon, 20 Jun 2016, Eric Sunshine wrote:

> On Mon, Jun 20, 2016 at 2:26 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > On Sun, 19 Jun 2016, Eric Sunshine wrote:
> >> On Sat, Jun 18, 2016 at 6:04 AM, Johannes Schindelin
> >> <johannes.schindelin@gmx.de> wrote:
> >> >         if (output_directory) {
> >> > +               rev.diffopt.use_color = 0;
> >>
> >> What is this change about? It doesn't seem to be related to anything
> >> else in the patch.
> >
> > Good point, I completely forgot to mention this is the commit message.
> >
> > When format-patch calls the diff machinery, want_color() is used to
> > determine whether to use ANSI color sequences or not. If use_color is not
> > set explicitly, isatty(1) is used to determine whether or not the user
> > wants color. When stdout was freopen()ed, this isatty(1) call naturally
> > looked at the file descriptor that was reopened, and determined correctly
> > that no color was desired.
> >
> > With the freopen() call gone, stdout may very well be the terminal. But we
> > still do not want color because the output is intended to go to a file (at
> > least if output_directory is set).
> 
> Would it make sense to do this as a separate preparatory patch, or is
> it just too minor?

That's a good point. It *is* a change in its own right. Will reroll.

Thanks,
Dscho
