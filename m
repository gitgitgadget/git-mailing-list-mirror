Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D35F61FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 13:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757985AbcLSNFo (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 08:05:44 -0500
Received: from mout.gmx.net ([212.227.15.19]:55572 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757376AbcLSNFn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 08:05:43 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MOfx8-1cCtcR1DC2-0063QU; Mon, 19
 Dec 2016 14:05:33 +0100
Date:   Mon, 19 Dec 2016 14:05:30 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v2 00/34] Teach the sequencer to act as rebase -i's
 backend
In-Reply-To: <xmqqa8bz39aw.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1612191352310.54750@virtualbox>
References: <cover.1472633606.git.johannes.schindelin@gmx.de> <cover.1481642927.git.johannes.schindelin@gmx.de> <xmqqa8bz39aw.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:XWqtXy/jjNU2wHu6LTdh6oHD6kzXiE66vEIcCdkIUPvxG/o5hKj
 0uvw7pBjwBcjoCtrkGiFMErIaqhBTpSKRWR/6gA8+3zVLqKD2R+QtQAlWoFxSHmp8jY04o7
 F03a7TG3tSmYZaHlPFSZ7AnqefJ3s5WtdMKxi7sba49OHMhWGwbmU2b1MJngWy+xjtQPfle
 OIkrAxsZFM6q6ny/ueU/Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LPiAvAco2yo=:RTxRlyiGIGXsdb0k8mWcEZ
 zHKxcYpSk4j9fUoPvez7bjEGjGXteaPPVW4xZ2M5sxFw0B/M2+ol0y+6/5In2/Amk8Q89Ias2
 aaRUyGV6QRedawe7OKJOShTRY5vDllx/t1i1ryDTqV0yliPxRFAI7cIO7mXU5Okp5D6Q1S5//
 WIruhWrdMRSPmE/u4X/NDv1wdwv0IJQoa8MBHI9+og9JhXOxKPO3/yj5j14bKTcm4YS+bWr5D
 gYiHvLxgvDZOB33O6VSQ3jsrNytCEV6gzaUZgEc9iq2R4hqu+55xtxwEid/m0ztA+kfvFsIxG
 eCSl4SqI/lvYYuTPztsBiBxNryp3ia6GLuUUbqUc98k8wcGTT27cp3dbicvcInDV+z3gpbPnj
 Yq426KA2ZUE77nyVyCxbWEA+Gc9be3wo+FPUb3gMSNgQemDQugqTWPeyeSYVSxgK20I+Gl+jq
 Gm8imZQy6HHlQrpp2Jpa0On/9v3E/uYMyxy3QT0PbzuJQV8U0yCVH/OnLEuh9hqLU7gh8uXFx
 NQUKzCK3ACvTXbMDTBw7+Wk1IJdeQUk83TsTWD/vGfAjoIqauc8vGo1tmcEMYpdad7Kr4TuC/
 Wxt3PpNfeG1rir47BoBLTRTR3gEyUMWQnrBreoq4VIrT9acxYirWEh+vfoQKWzyUkW+7L6DeH
 C4PJjhVuUkcp7cxQI7EHdUzblnY2zfqGnQp0mAzTYahCsxhV5hL3uxTRIQ5UM37aCJHj/FcXr
 3TpRogR1hbX0rQMM1eMyeW8iv6dcqZi1q3FNW8s+EfwOJh8y/NsIjpe62svtxI42in/KGphfA
 gLfbQAz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 13 Dec 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > Apart from mostly cosmetic patches (and the occasional odd bug that I
> > fixed promptly), I used these patches since mid May to perform all of my
> > interactive rebases. In mid June, I had the idea to teach rebase -i to
> > run *both* scripted rebase and rebase--helper and to cross-validate the
> > results. This slowed down all my interactive rebases since, but helped
> > me catch three rather obscure bugs (e.g. that git commit --fixup unfolds
> > long onelines and rebase -i still finds the correct original commit).
> > ...
> > Please note that the interdiff vs v1 is only of limited use: too many
> > things changed in the meantime, in particular the prepare-sequencer
> > branch that went through a couple of iterations before it found its way
> > into git.git's master branch. So please take the interdiff with a
> > mountain range of salt.
> > ...
> > Changes since v1:
> > ...
> > - removed the beautiful ordinal logic (to print out "1st", "2nd", "3rd"
> >   etc) and made things consistent with the current `rebase -i`.
> 
> It was removed because it was too Anglo-centric and unusable in i18n
> context, no?

Yes, but I remember putting in a lot of time to try to come up with the
most elegant way to convert a number into an English ordinal in a shell
function. That's where all that wistfulness came from.

> Judging from the list above, interdiff are pretty much all cosmetic
> and that is why you say it is only of limited use, I guess.

No, I said that it is only of limited use because I had to fudge things to
come up with an interdiff. I had to fudge things because there is no
interdiff: it would require the previous iteration of the patch series to
apply cleanly to the current `master`, which it does not. So I rebased the
patches and left as much intact as possible, which means that the rebased
changes do not even compile because they were based on a previous
iteration of the prepare-sequencer patch series that did not make it into
`master` without substantial changes.

>     ... goes and reads the remainder and finds that these were
>     ... all minor changes, mostly cosmetic, with a helper function
>     ... refactored out or two and things of that nature.
> 
> It is actually a good thing.  We do not want to see it deviate too
> drastically from what you have been testing for some months.

Well, that ship has sailed. Neither of the patch series
"require-clean-work-tree", "libify-sequencer" and "prepare-sequencer" made
it into `master` without substantial deviations from the code I had been
testing and improving for half a year. I did not expect the code to be
accepted unchanged, anyways.

Ciao,
Dscho
