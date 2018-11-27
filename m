Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 859961F97E
	for <e@80x24.org>; Tue, 27 Nov 2018 13:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbeK1ApK (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Nov 2018 19:45:10 -0500
Received: from mout.gmx.net ([212.227.15.19]:46637 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbeK1ApJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Nov 2018 19:45:09 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MBWTO-1gIKJb1mtS-00AVtu; Tue, 27
 Nov 2018 14:47:05 +0100
Date:   Tue, 27 Nov 2018 14:46:49 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        git@vger.kernel.org, t.gummerer@gmail.com
Subject: Re: [PATCH v11 20/22] stash: convert `stash--helper.c` into
 `stash.c`
In-Reply-To: <xmqqefb8z9qh.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1811271438310.41@tvgsbejvaqbjf.bet>
References: <cover.1542925164.git.ungureanupaulsebastian@gmail.com>        <de2ebf96ee5f94a1cdadee67e436f5bd1b0fb6a5.1542925164.git.ungureanupaulsebastian@gmail.com> <xmqqefb8z9qh.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:tzwYzixz+YuUUCZkSQrVQGdLBycO87RA/hoXpw5yf4/8R15xNEj
 2kuJ7WxylIpv6KtJhXqTWjcqAHKsw4fe/2XdbNffL+CdhCNELg3tVs7hu5pc8cDaETJhYP1
 dNoHuBfCTgojBmVB3ZkiFMWUprJhYhcHYxdY9BkJtszfy59AOKtaCM7Z7Nh3jqnnihfA9Jv
 XfW65UIXQz71oqPG05hlQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ObwrYfMOdUU=:+N1Tu1l+1+UL6R8pxjPCYC
 sMdgM2xdznOobwHw0FQNProDza03ZY+FPb9sfHfhyaGcpzbQ0c836YpfXjiBg9LpJDusB2reT
 9OLmYlUB1j1kHOxLu+Jc1NCdDNQrY9yUWMGgaVBg5OBOVl/MnLRebGdD98tdSb4i28QsXCIy3
 GdJLtXmxK0J5ZvkazgzvZLiqx8NZf0uOhUgMEU3snebehuaW+gHKP4MRobP0t0sA++qTKywRk
 3ktFm5ThAGgGirT/uwItj3Uqd12cQbn5vepMlxevcQ8bKkfzebrOqJDBxRG6FXTqi8aCmlXNS
 PIAHMccHTscMK6Y9WnMrLNCX42R7nB+rD7eZxS2GjHXvPgWky9FainioSFUNX8kjE3ctudYTN
 uIVKSzcPFO4HnNvoBCxMRoGJmymB0/iHCkWDFa6Nys+Sn15tt/WynK5TtKF/Fi5J8w+vlYM58
 yf2A6gXV4udQZ6FtzseSc702xoWyBDAghVWFyYXo1MHms5vg+rEOCBGSCyrmToBK33AZqHiUH
 Ulus2QimTah1S/7lH4JA/BMS/fU/y5FsC8TrrzPEyvLsW4Bepsb0CaLjN9pyHXRVb9WIxVQgz
 o2yGXBanT0As106i4ZYz5ZFgAn1zvlHnmaQ87FBG+bTj0RIzsxDklFHmTGx6/ZXUUaOd6+k/J
 X1DZaAd7iWzVAOuk3nmquTXQCWojyCtaPVFxA1sAphimpnKE2plG+nABNnJKTbrM8UpY0o7WQ
 287iYhYGxLB+GSQTmFYHdiWWj5HUbpe9E+0VVkEJK/IemISVMH/DPRx3B+VLeTG5mI8VcObpe
 VHR4uTZ6RjuPGfR46IyL25s8m/IlvCusNsbKNhZBaeWKLc0EnCaSQc699ByxaLD0i8Z6mfriH
 /hU6wMyj3r5qOlfXinmtz5+uhJbAdITrcGR1E3z2g2ldVehQ2gvfSvLaPMLnS3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio & Paul,

On Mon, 26 Nov 2018, Junio C Hamano wrote:

> Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com> writes:
> 
> > The old shell script `git-stash.sh`  was removed and replaced
> > entirely by `builtin/stash.c`. In order to do that, `create` and
> > `push` were adapted to work without `stash.sh`. For example, before
> > this commit, `git stash create` called `git stash--helper create
> > --message "$*"`. If it called `git stash--helper create "$@"`, then
> > some of these changes wouldn't have been necessary.
> >
> > This commit also removes the word `helper` since now stash is
> > called directly and not by a shell script.
> >
> > Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
> > ---
> >  .gitignore                           |   1 -
> >  Makefile                             |   3 +-
> >  builtin.h                            |   2 +-
> >  builtin/{stash--helper.c => stash.c} | 157 +++++++++++++++------------
> >  git-stash.sh                         | 153 --------------------------
> >  git.c                                |   2 +-
> >  6 files changed, 92 insertions(+), 226 deletions(-)
> >  rename builtin/{stash--helper.c => stash.c} (91%)
> >  delete mode 100755 git-stash.sh
> 
> Seeing the recent trouble in "rebase in C" and how keeping the
> scripted version as "git legacy-rebase" helped us postpone the
> rewritten version without ripping the whole thing out, I wonder if
> we can do the same here.

Feel very free to cherry-pick
https://github.com/git-for-windows/git/commit/004da7e7faa36c872868ae938e06594ea1c2f01c
and
https://github.com/git-for-windows/git/commit/cedfcd39f5a4e4beb33e16fa67c4659fd4bdabf6
which is what we carry in Git for Windows.

Ciao,
Dscho

> Also, the remaining two patches should be done _before_ this step, I
> would think.  I can understand it if the reason you have those two
> after this step is because you found the opportunity for these
> improvements after you wrote this step, but in the larger picture
> seen by the end users of the "stash in C" and those developers who
> follow the evolution of the code, the logical place for this "now we
> have everything in C, we retire the scripted version" step to happen
> is at the very end.
> 
> Thanks.
> 
