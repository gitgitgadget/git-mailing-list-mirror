Return-Path: <SRS0=PlGQ=4G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F062C34026
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 16:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59C6F207FD
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 16:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="GUEEdd85"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgBRQBF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Feb 2020 11:01:05 -0500
Received: from mout.gmx.net ([212.227.15.15]:46427 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726360AbgBRQBF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Feb 2020 11:01:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582041658;
        bh=PNLjYwoOp/pYIAAeHlFpcsD28jACv8FR8irGvuN0jk8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=GUEEdd85kPzA5RG0Az60L8qNczkJpyDG8BhIdoEtDQUVKahNdyjWAHoOHKcjtF64W
         SsrOMgSV4ADpQsPshpYB1RaRDAxHIFJSE9d8plcKDfw2Zr1dlvljO2d9AOg1KHyDZ9
         WtWY85B+wHwnp5ogupET5+R0vfs83lAS/yoHu3jg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB ([89.204.153.251]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MKKZ3-1ik4gA47t1-00Llny; Tue, 18
 Feb 2020 17:00:58 +0100
Date:   Tue, 18 Feb 2020 17:00:55 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: en/rebase-backend, was Re: What's cooking in git.git (Feb 2020, #04;
 Mon, 17)
In-Reply-To: <CABPp-BEFQs4LL0uwkZSpXb_wxo7Wk-gEQSsv-=4B5ja5H1xXTg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2002181659540.46@tvgsbejvaqbjf.bet>
References: <xmqq36b8lvdl.fsf@gitster-ct.c.googlers.com> <CABPp-BEFQs4LL0uwkZSpXb_wxo7Wk-gEQSsv-=4B5ja5H1xXTg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:mr7ZNooSDyQem4YwISNIeKh3WkEohA9u6njqpeEOCQswy7BAquB
 4PeooDDh2ov/blMRY3xIft6qZX1yW5bVz8GUnc6aSt1r1mLUOiVi0Nw1Em4fEsLfjCQDXH9
 NVRQeIe+prvKpl5nTW3/AD1pMIwD2At9OgASAKPtgVhROskXurcIwpsOOYkOCxrnosnfvK+
 uXILQeTpkViVBqM8ZeZxg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tnwolMZzDaM=:GzBWXz7bFZ8EHm4Hfsxwnd
 zA4PyGyPk6O8ydtWew+B+tzuKymdoUX1LZygWE5obyXWzyoJZ2ZKyO2BbWyMJ0KzAmOrOitGQ
 MOTNbBbbIaoLIaGMcBskN5nibeXYDmn8sLciJFjYukFCZ8R66K1neHWiA687rx+cBUwyDj08x
 iWAbbvqTmx11h1BxS1oF9p++eFqP6096pvjDOSHXlfQDywjnda8kESLggxWxPxF0tMexxQWBM
 CD1MyPJE7baIEuSOar/vhvOvbxl0e3joDJcLMkO3JgdgG/K9YZISS7j+SdTRldW2oxtC3emfP
 VKuqUpfl6T5byr7wgSoUGso9gj9rJ3AeUP/L+wcNwtPMa4wcY67JnmA30GpCZh6VD/EQecCNQ
 o50xzIBPnmkMVKvV6cqKl9rD6vY4wb5X0u8rwQCkuvg+2CzKGm20hwasmPfivcdxE/bE44j1K
 f6pMm80AOWq+yQ34xktKLHFRuJ6QvP2GW4tobfUQVx8+TGqA4Uvk+A/9o/5OFmMb/we2ZUUVx
 nPaNOtSZVBDnqrrQ5r/aE/E+OMobQ8QYb18Fb7X6iJZblrQys8ZAIoFYI4kpBY2MIv27e+iPi
 paw0UkPrIsPuYxinMIvRRJd+FyH//Z7EgIu++hRxfUvUvzIeatNOf3alIqwuLo3plU0i0lu3w
 FFy4pEnN9YeWOFMP3i56J32reem/8yGmdiH3r6Q5uKMR5soaAChPXP1cGRsvcgK8vbq1yxpKR
 T1Bf1AH3M63gI/QLEehG9QZBM6XfzZtq7MfSv77tHaHhY4oIS4T/0SiHdGzNQ7vOPesZDVVt7
 7aCdWhZnqN+7FAADi3Fq9uz/5ffgH+ItcKrfarWzaKVLJy8x1eGvsBT4ywJ30ThW0c/rzsOIf
 m+53YXLgEdCXHl0K/uRFK5M6FPjb9t1QfiMbDK/Dv972I28ZZjXCyFrfF0cyaNNSbyi4nXuVH
 7/hj5slL10bdPK/RBEtKOygKoS69sqWe1YPW7fWjnetJtCZ/48fbMulQprayizj9E9XV7hbl4
 XTgqQLYBgplmwmx7EFj2s5Kn+Z1ALy3dkJ8Qm7rA8ZpfcP+sRCpOqjwR77o3YpWlL6SLPqIir
 qtjh2Qww8vfnZirvYWiHIv2MNOfqYrOMWzQhTRTgUyHqwjSI2tNZwPPNQ13OluHrk52Zwxal9
 3WR2nEh0kg4mTJqyaCJ6W1XjpyrpcuOeaRnfJweXnr97LXTOTTykt8ljhpD+PWzdnEH8704PV
 E1Po5Y2VqPOXwj/sr
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Mon, 17 Feb 2020, Elijah Newren wrote:

> On Mon, Feb 17, 2020 at 2:09 PM Junio C Hamano <gitster@pobox.com> wrote=
:
>
> > * en/rebase-backend (2020-02-16) 20 commits
> >  - rebase: rename the two primary rebase backends
> >  - rebase: change the default backend from "am" to "merge"
> >  - rebase: make the backend configurable via config setting
> >  - rebase tests: repeat some tests using the merge backend instead of =
am
> >  - rebase tests: mark tests specific to the am-backend with --am
> >  - rebase: drop '-i' from the reflog for interactive-based rebases
> >  - git-prompt: change the prompt for interactive-based rebases
> >  - rebase: add an --am option
> >  - rebase: move incompatibility checks between backend options a bit e=
arlier
> >  - git-rebase.txt: add more details about behavioral differences of ba=
ckends
> >  - rebase: allow more types of rebases to fast-forward
> >  - t3432: make these tests work with either am or merge backends
> >  - rebase: fix handling of restrict_revision
> >  - rebase: make sure to pass along the quiet flag to the sequencer
> >  - rebase, sequencer: remove the broken GIT_QUIET handling
> >  - t3406: simplify an already simple test
> >  - rebase (interactive-backend): fix handling of commits that become e=
mpty
> >  - rebase (interactive-backend): make --keep-empty the default
> >  - t3404: directly test the behavior of interest
> >  - git-rebase.txt: update description of --allow-empty-message
> >
> >  "git rebase" has learned to use the sequencer backend by default,
> >  while allowing "--am" option to go back to the traditional "am"
> >  backend.
> >
> >  The last step may be rushing things a bit and may want to be
> >  taken separately.
> >  cf. <pull.679.v5.git.git.1581802602.gitgitgadget@gmail.com>
>
> Thanks.  I'm curious, though, what you mean by this last bit -- was it
> just a reflection of my request for folks to comment on whether the
> last patch was wanted?
>
> In my view, taking the last patch separately does not make sense; it
> should either be dropped entirely or taken close to the same time as
> the series.  My reasoning for this is as follows: The only place the
> current backend names exist is in the documentation.  The cost of
> changing the names is thus low.  Once this series lands, the backend
> names will be exposed in the user interface.  If we cut a release with
> those names, then changing the names will require a bunch of
> transition work.  So, if we're going to change the backend names, it'd
> be better to do it sooner (while the cost is negligible) rather than
> later.
>
> So far, Phillip has voiced an opinion on this (cf.
> <e2863381-174c-a55c-bb22-0c7aec9cabf4@gmail.com>) -- "I think it is a
> good idea - merge and apply make much more sense that interactive and
> am"; haven't heard from anyone else yet.

FWIW I am also in favor of renaming the backends. Unfortunately, I won't
have time to review this patch series for the foreseeable time.

Ciao,
Dscho
