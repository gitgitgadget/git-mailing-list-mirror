Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D9EECAAD5
	for <git@archiver.kernel.org>; Tue,  6 Sep 2022 15:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbiIFPoN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Sep 2022 11:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232483AbiIFPnb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2022 11:43:31 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3A320F58
        for <git@vger.kernel.org>; Tue,  6 Sep 2022 07:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662476028;
        bh=cGzOwU4ktNs01sJXestXO4sByQeEHZc7IXb1j2+d0Nc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=CoCr6M52Aukll5mEJw6op+bH/tlkN2Q/vI9OnVodQPHOIQSdy2tMF/FeXYjH1mch0
         IGerkwscPTxF3pts0cOilqLncHaVqsiD57PyTUynKRRXSjp3am5UzEp8qPhrAY9IYt
         7oojQFD4jtwxfxQR1OvN+n6XYSgxzrBh4wQE3Or8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.220.106] ([213.196.212.69]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MLR1f-1omGsE0d2h-00IXqA; Tue, 06
 Sep 2022 15:56:49 +0200
Date:   Tue, 6 Sep 2022 15:56:48 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Christoph Anton Mitterer <calestyo@scientia.org>
cc:     git@vger.kernel.org
Subject: Re: status on security of embedded repos?
In-Reply-To: <c209dc21f6826bbb60d75450e6f7f9ff2258d18c.camel@scientia.org>
Message-ID: <4697o162-0pop-4715-150r-2317p0n69581@tzk.qr>
References: <4e9ad5486e8a887f1e92cc4e401ca61be5f2bb9a.camel@scientia.org>  <6sq30r84-1s65-91n4-5qoq-23s9q433sno1@tzk.qr> <c209dc21f6826bbb60d75450e6f7f9ff2258d18c.camel@scientia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:JWS9AcPLCTivFdxeX9/9NkS35qcmc60+JlPS42LHt/9WrF0sE4d
 k1PeCc7VHwMpe0A0BWghFOKyKWejAc3IFImvY+VmWyD4qDCBbPbyEshhz6JFB9H7izEBkje
 3kzQeH3kbdQdEf6N3PO3/EgcL10ylFJX07v86wpe4+v8Xdl88plyUSgB+6vMC5lN5NaFCMa
 EJklEUwAqfxwFqY6j4YpQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3XBYPm6qaIE=:MrIYZVXanXXx6GPQaji+uH
 WDjbY19oics/rXY4f2vPyZurmDW66ie4cLgRp5Qh8cV5yDHhqHCiM07zR1+ku/FRseh0I8RZG
 uEPhEgebOkusJGcGVXmiwomRU1GMYhIHNQb0XPNsACu/U18rawsDwtBNNAgP99DLQoBvvUtp4
 HzNwNLx3tN1UWVusBX1WTZW+A/lGd/EJqWVcNPA1kb2h9A2QgBpef2EiitCGMKCUaTuuUxxmF
 CzRF3hHw42tNi3S2vpO4bQqIiWDJEoDETK/u5X+vA6XsIrQIZ4bHBr0cPHf90dkuWpLL+3vQ4
 EcA7Gq0rCcpSCjzu99IkKvJLHSgpaHBrZZCbnMC9orm4aBVl8EL5Sgm+J2qCSgHc6oOkN2t6U
 ynq4/MDkPvKBHx89Be4+/ptYXgclhWLdXEgYWEnXXSte7sl0RNYYLOnSuGFXlpSaH6vTacTPF
 uJTGdnOSnz3KcPftuuXB00p58jY7KBde4ox5PejpwDJK5whInnRcp+VQ+1XZbwOBZRUAmBjJL
 BGRVOJbDzz9VPkgsp0tvu2EnLyaNbv95pufhrtqt+1lqDfhypOvNgOHWG0V95mRoaRjJTLSDR
 +Ih2I5QJ87vl8CHrFwgA51YQQRiL7q0a7hy91W1cwHYAG727xSqo7xsPSOMdekr6X6/jzRgYx
 uu53J0P/UFe+3HmjPyOgbPEWZY4CBmX/JzsfUyzDQ7WdPrHUKYOXpSKc8vm2ob4ahrY0f6EAh
 D1W2VVBliiB/QIZdfSmYu35EEu0+ldRtiojGkvCjikPNh3T4KlUG+d0yDVuMM0DFMFdB7+SzK
 lE4bEMGT6e/k7wGv7cx/5E/Hv883WF8S4sZNeJH1bnoOzPkVOFt4F0l6CxQhhi75sZWh6L63h
 zf6CuSPQrGGjYuKjUeQvvIaA6+6Jv4NmfK1heZeVR6YttrsCDcmQD1boclMWRd4hNdFH8G6/G
 gINDJkpfHHUWpm9CG9sbk7l/kKAs64OnzbPwKQJLJ/gQ6f2YjpSJD6BIf9Lx8mHv1aacuWsBP
 ErAI2WkiOTFJLW/4e9B6Dq0cdlVO0lx4mkBIRoFbKORKn7oau7IGVPxxac8P0n6yg8QTkJ0QM
 W8T5bIs9ly0XoLKtwtvBQrJ62uh/HPcvqjjbEvt+cenDCy+EvWG6DugyPxpSYG+Lt5nPUvuNc
 XaaOdDiGNoJOn4aE/65I4WvAxW
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Chris,

answers inline.

On Mon, 5 Sep 2022, Christoph Anton Mitterer wrote:

> Is it known whether this will automatically prevent the issue also for
> any 3rd party modules for git?

As long as they use the core Git CLI at a new-enough version: yes.

But libgit2 and JGit, two separate Git implementations that are in wide
use, too, probably do not have support for this.

In other words, users of libgit2 & JGit will likely be unaffected by
setting `safe.bareRepository` and sill still need to take manual
precautions.

If you are using applications based on those projects, you might be
interested in porting support for `safe.bareRepository` to those projects
and contribute the enhancement.

> I mean is special action needed by them to consider the option? Or is
> it likely that there are some which manually discover the git config
> and could thereby still suffer from the vulnerability.
>
>
> I assume the same wouldn't be possible for non-bare embedded repos? I
> tried to try this, but when git add(ing) such repo, it already warns
> that the embedded (non-bare) repo would not be included in clones.

Yes, indeed, `.git` entries in Git's tree objects are forbidden.

Ciao,
Johannes

> On Mon, 2022-09-05 at 12:21 +0200, Johannes Schindelin wrote:
> > Note: The default will still be at `safe.bareRepository =3D all`.
>
> That seems like a not so secure default, given that probably only few
> people will ever encounter embedded bare repos.
>
> OTOH, the attack surface seems rather big, if one just needs to clone
> some arbitrary repo where one wants to look at some code, and is then
> in principle already fully vulnerable?!
>
>
> Thanks,
> Chris.
>
