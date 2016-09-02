Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47FC51FBB0
	for <e@80x24.org>; Fri,  2 Sep 2016 14:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932335AbcIBOWh (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Sep 2016 10:22:37 -0400
Received: from mout.gmx.net ([212.227.15.15]:63867 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932146AbcIBOWg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2016 10:22:36 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MRoRF-1bUeAe3oFN-00Stxg; Fri, 02 Sep 2016 16:22:22
 +0200
Date:   Fri, 2 Sep 2016 16:22:21 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Dennis Kaarsemaker <dennis@kaarsemaker.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 07/34] sequencer (rebase -i): add support for the 'fixup'
 and 'squash' commands
In-Reply-To: <1472818007.4680.53.camel@kaarsemaker.net>
Message-ID: <alpine.DEB.2.20.1609021557060.129229@virtualbox>
References: <cover.1472633606.git.johannes.schindelin@gmx.de>    <5488a031ffe14373b7434d497b7fd2f2e5fe55bd.1472633606.git.johannes.schindelin@gmx.de>   <1472718808.4680.19.camel@kaarsemaker.net>   <alpine.DEB.2.20.1609011658300.129229@virtualbox> 
 <1472746749.4680.33.camel@kaarsemaker.net>  <alpine.DEB.2.20.1609012009070.129229@virtualbox> <1472818007.4680.53.camel@kaarsemaker.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:YqrFsKolx0U5uWquMFuxgsZ3WvTUteG3Kz/wugjtPmtm5YP2sD5
 h54dmTG2wBQ+WyQWOeYUDS4Ls44SJsAP6xTnJQJGZc+uOgizqqgYag1bBd7bpZ/Vh/A9FBc
 VZqLQAxjnjWt53YLat6MzgIdQnjfFrt7tOiUsEuQMQyCiyDWTsK26/xD+7SUtEGS9FD2X97
 o0qwrbhJTQtklmKY8JR5Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xaY3lttEDio=:0jIOMBwrZP2jTwMslI0Vuc
 GDGnegajjil1j9mdd5W+ufw6b6PNKKz+pqC0TY2z56+6oDpEjaRUllxonHmYkVEWirrbcbSCY
 BJRXS1Ck0yAhb4RQx+aq42D2fm3j5r8nAPPzD5MAbC9uEWquJmAL3l+r+BBdBoTimVfyDROfy
 UBZcsbWScf8MaZOM772dYb3xp2EW9prtQpCqL4YH3GFK2rzcbCVhb90trw78kkhM5VzCSi87x
 /3NA28Sf7tXE7kOChPxSUSF/YLtyccOgNgScms03XCNr2vq9nDlTO78PjYRjSlC+xwV9fNulW
 +vDMTUAl5pZGWktlNenzHMl0+V+B00PaaCx3Zmh05IEENI9UGEs+noiJLkVQzEAOtvC+0nxWe
 mOqA2N9dFLMW57FkZjYvuLON8uLGt9tgq1OM/JZuZa0crrhHnpFHQTwwdCLAU7eLHvdOjVuhJ
 FF/1xN1MbA3HC/iEIgRx9L82rRI6rVjTD4cOIC4aFiv6pfv6p2FRFJOtkRQmhqGnJiSPHJc+T
 eEcOXwb4w2BX+RGrusB4OuMmSPsetbnm6IjoRxJzMPb6QGceGLoSvJSsYL/8OqbxP6F+1M6r+
 pvjO5HXOii3L2L2SJIAtQquhQRk6w5HwbpKOJz/p7EgFDGppTJVR60GiFRH7isoga0+sWrchn
 plZWitxfvYzBncTxq+OtKHIpg+NzgTYCVm6R2MU5d97oKVgHImUyMghI7xSSLtzfilst70h+C
 BZ3api7txp2XzU4rvtgwPibcO0OhDEpKITMzSHx839fRuTuiT6GnSPP4T2wDWOin3Cn60wWZv
 JK8dYVl
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dennis,

On Fri, 2 Sep 2016, Dennis Kaarsemaker wrote:

> On vr, 2016-09-02 at 09:13 +0200, Johannes Schindelin wrote:
> 
> > As Git for Windows does not ship with translations (for multiple
> > reasons), it would not be a regression.
> 
> I'm confused, how does "git for windows does not ship with
> translations" translate to "this is not a regression"? Is this patch
> series only meant to be for git for windows and not go into git.git
> itself?

Oh, I thought I had clarified my plan... The timeline is:

- I submit the remaining rebase--helper patch series for review (last week
  and this one),

- I publish a preview of Git for Windows v2.10.0 that already uses these
  patches (done: https://github.com/git-for-windows/git/releases/tag/v2.9.3.windows.3)

- once upstream Git v2.10.0 is released (possibly today, after my work
  hours), I perform a final "Git garden shears" run (read: rebase Git for
  Windows' patches, retaining the branch structure) on top of v2.10.0 and
  release Git for Windows v2.10.0, tagged as v2.10.0.windows.1 in
  https://github.com/git-for-windows/git (due to time zone differences
  relative to Junio, the most likely time for this release would be
  some time around noon tomorrow, given that the release engineering takes
  roughly 2-4 hours, running unsupervised for the most part).

- as far as Git for Windows is concerned, l10n is not really an issue yet:
  the installer is released without any localizations.

- After releasing Git for Windows v2.10.0, I will pay a lot of attention
  to feedback. Not only to hear a lot of praise, but also to catch any
  possible regressions. Not that I expect anything dramatic to happen
  because I really tested this as thoroughly as I can: not a single one of
  my interactive rebases since mid May has been performed without
  involving the rebase--helper. In the three cases where I *did* find a
  regression, I solved it immediately, of course.

- After releasing Git for Windows v2.10.0, I will have a nice beer. Or
  three.

- Then I will leisurely try to address the l10n issues.

- Then, I will send out the current iterations of the patch series that
  are in flight.

- I have the entire week to address concerns with Git for Windows as well
  as with the patch series (where the former takes precedence, of course).

- The second half of September, I will relax from this marathon that
  started in early February. Meaning: I will be mostly offline.

I hope this clarifies why I am not so concerned about some issues such as
translation, or commit messages, or grammar, and more so about others,
such as incorrect code.

Ciao,
Dscho
