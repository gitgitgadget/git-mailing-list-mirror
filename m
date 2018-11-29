Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8799A211B3
	for <e@80x24.org>; Thu, 29 Nov 2018 10:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbeK2WDn (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 17:03:43 -0500
Received: from mout.gmx.net ([212.227.15.18]:44509 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727020AbeK2WDm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 17:03:42 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MdKgV-1g9pPH0oEN-00IYRs; Thu, 29
 Nov 2018 11:58:40 +0100
Date:   Thu, 29 Nov 2018 11:58:41 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        git@vger.kernel.org, t.gummerer@gmail.com
Subject: Re: [PATCH v11 20/22] stash: convert `stash--helper.c` into
 `stash.c`
In-Reply-To: <87ftvmytqj.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1811291155570.41@tvgsbejvaqbjf.bet>
References: <cover.1542925164.git.ungureanupaulsebastian@gmail.com> <de2ebf96ee5f94a1cdadee67e436f5bd1b0fb6a5.1542925164.git.ungureanupaulsebastian@gmail.com> <xmqqefb8z9qh.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1811271438310.41@tvgsbejvaqbjf.bet>
 <87ftvmytqj.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1823495422-1543489057=:41"
Content-ID: <nycvar.QRO.7.76.6.1811291157510.41@tvgsbejvaqbjf.bet>
X-Provags-ID: V03:K1:o2AKUaJro5FzH/A8GRV01Ls2noaC44pPG7YGDrOrhejbpS/mXq5
 X+zvQtyQDGokJH26l17xBL50T1VeS8rhFzc8DrUQE036jXrWV3YoFM7ubGLKr1UW5N7DQgL
 nQzNnP1b6Zp3pNCCwUZLg4hAV7JltvQuqb+kFOAM+ufsVwvp5ejD1tvJPj7yWdXDvLmvOOk
 661asMWgLZDYc6zT1m7WQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:S5JlM7c/5as=:kpRJEGm+BTtSg7dy3GhQM/
 jkSNOF1ayy/SEz4Q1LutqIFBHb9e81dU6rxVs1RO4dctrCQ136ozNxT8SHX28dpi4MaVjfqqE
 AIqLDbL7FOk1InQkia5Xn8fIbMaRIb6xH221vyd+w0nWhgTWPjo7iGTVxv9WilQs8flQDGt8h
 FlLbyOfqB4tZMXcU4YvY2UZlDceGeLxhCWO29pWAp3sVj+OLutE+kmCrsxKM57D1Sf+XRUoK8
 JlKG8xzZOA49MHuWbtUzlB/xz+y6gFCPgHB9ixTk37s69u6kW0xBU9AjBCbeQe3tUDyybdcmz
 4BuSPON2i8Q7V1eLLiP2bpBuBNrXQUDZqfv1Y4QaWpIMxYKwHtywjsfC515Sps1K/hMJH+AI4
 +O6qgduBaxD9A/QMck/lL7Fwg347GHz08/a4axvNVsG08StW3KSTupZ80KhQA7V0rVffVcQxK
 XXsWB4jRuhtZKhehi+2sDuLbWW7aJ9IddzBJFjSoUq+pYy21ZiXgEHPjzQGXNDlnYb7ZKFlQO
 Aa8PLIelRGdjvWgNapHu3IT0wflkZIO22NDPwisGD9ktpUX/VFkIlq3JcRPdOitvCG766BIjv
 YxFX2G1aX5HVvehUGnPT0svHaFCVMTWTv8GZ/hA0eUISdPBB8fVPFaJpzruijVEMKQUiDoT6B
 Q7V7xQhOfEZsT4f6T5UVmi2DU0pteYYX2ZgzY6FZacnmO1uGXi+xvm4hEVJhvareancV95gNG
 2JRU25a51mbn3QMeEYcAxwsPV9M/JlTgUTC/M8gwgSFjDWUUQcUxbiAbi+HrcWZGttJmxM8J8
 zLQdBphti576oUXc22IanEouty5i2FzcyPJEJASLPsKaUR2H4B9O6aXXX7de6fPCBjo3/F7cX
 5abyP/MwOpIzcHekjSfQi55aZiG3eljtLYJmEr7ZLb0wxYuH9qj/CY8hGye4qaqZfkHokYz/a
 D/rXGi/uF0Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1823495422-1543489057=:41
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <nycvar.QRO.7.76.6.1811291157511.41@tvgsbejvaqbjf.bet>

Hi,

On Wed, 28 Nov 2018, Ævar Arnfjörð Bjarmason wrote:

> On Tue, Nov 27 2018, Johannes Schindelin wrote:
> 
> > On Mon, 26 Nov 2018, Junio C Hamano wrote:
> >
> >> Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com> writes:
> >>
> >> > The old shell script `git-stash.sh`  was removed and replaced
> >> > entirely by `builtin/stash.c`. In order to do that, `create` and
> >> > `push` were adapted to work without `stash.sh`. For example, before
> >> > this commit, `git stash create` called `git stash--helper create
> >> > --message "$*"`. If it called `git stash--helper create "$@"`, then
> >> > some of these changes wouldn't have been necessary.
> >> >
> >> > This commit also removes the word `helper` since now stash is
> >> > called directly and not by a shell script.
> >>
> >> Seeing the recent trouble in "rebase in C" and how keeping the
> >> scripted version as "git legacy-rebase" helped us postpone the
> >> rewritten version without ripping the whole thing out, I wonder if
> >> we can do the same here.
> >
> > Feel very free to cherry-pick
> > https://github.com/git-for-windows/git/commit/004da7e7faa36c872868ae938e06594ea1c2f01c
> > and
> > https://github.com/git-for-windows/git/commit/cedfcd39f5a4e4beb33e16fa67c4659fd4bdabf6
> > which is what we carry in Git for Windows.
> 
> ...and then something similar to 62c23938fa ("tests: add a special setup
> where rebase.useBuiltin is off", 2018-11-14) so those of us who're
> smoking next for bugs can test both and report if some of the test
> setups (odd OS's etc) show a difference in behavior.

I allowed myself to make those changes, and to reorder the last three
patches as asked by Junio. Paul, please find the result at
https://github.com/dscho/git as `git-stash`. If you agree with it, I would
be delighted if you resubmitted it directly after Git v2.20.0 is released
(Junio, it seemed that -rc1 slipped a couple of days, and now -rc2, too,
any word when you think the final v2.20.0 is due?).

Thanks,
Dscho
--8323328-1823495422-1543489057=:41--
