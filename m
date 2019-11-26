Return-Path: <SRS0=BbQ7=ZS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7520AC432C0
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 22:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45DE12068E
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 22:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="UizQc3y+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbfKZWxC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Nov 2019 17:53:02 -0500
Received: from mout.gmx.net ([212.227.17.21]:56431 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726200AbfKZWxC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Nov 2019 17:53:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574808773;
        bh=ckYHyQNP+7KiT7TarlJo3GGkG37w1U8afCM/hoMcrxo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=UizQc3y+pWdbggl2+RcmhQuRGr4Mhm8V8g7uzTJLotw2nLw1x6AtiOPqchMBA+jwV
         9KBFrYdk+pyi84JC5v2Wwc11yCT6L1FKTmcR1EbQqeDG+ua4mH6JS9D8Jm1aAIO2XO
         0MmtNhOY/d51UIFV2vTdSIn0OZTtfdUP90JVDICA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M89Gt-1iVdEl3q5b-005JTw; Tue, 26
 Nov 2019 23:52:53 +0100
Date:   Tue, 26 Nov 2019 23:52:36 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Wong <e@80x24.org>
cc:     Jeff King <peff@peff.net>, Emily Shaffer <emilyshaffer@google.com>,
        git@vger.kernel.org
Subject: Re: GitGitGadget on git/git, was Re: Should we auto-close PRs on
 git/git?
In-Reply-To: <20191126224044.GA13328@dcvr>
Message-ID: <nycvar.QRO.7.76.6.1911262350240.31080@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.1911131234380.46@tvgsbejvaqbjf.bet> <20191114074117.GB17186@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1911142354290.46@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.1911181930290.46@tvgsbejvaqbjf.bet> <20191121105414.GA16238@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1911221430510.31080@tvgsbejvaqbjf.bet> <20191125143023.GF494@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1911262151590.31080@tvgsbejvaqbjf.bet> <20191126215648.GA18872@dcvr> <nycvar.QRO.7.76.6.1911262322130.31080@tvgsbejvaqbjf.bet>
 <20191126224044.GA13328@dcvr>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:KWbRjkvi3HpW3D3uUTcBfJ1YFULyGapWEffdCwnJXY5Uc3e4M/K
 SCu5eyuc99neqJHSot+JSKA3jH4XpZeLUoI1lgMd+UKFBWubli1Lkw4WLLMeD2yIrGSp2rU
 uksEYbxwGieEdTQVIxNyJtaP7huJBGlHsjWB5MYx8vcZSFzNySCbtaVIavuN/F7v9lGF9Nl
 94T5N9QbmI9yoeoOctfxg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yHaTTe0ES68=:YHRndjt6j7jY8gSH0Q8mgB
 XkdfZTA2apuanln3N3EI6ITT3PxUCrznpNyoLl1c0rwgqKOyjH992RmpQGuLgK4DlJ2I5fxFB
 up1ar+WCJ1B6RrUiqJyv7mW0OJ2RLiQj9qj9Wde0Stf6w/B+fp1Ezso9RrO/Aq6YMZumaBfbk
 4Sl/JBIG2nS30lmWCO7XXDhmXPq8uSqPz5hHS5jUb03QlcHp7xtDKzZhP1LcLjOqLIPcx4459
 7ZmR7UU0gV9MlydacSqwx5trQJHPAMkwCxHdih/xuT3loWqd8eolkLrSfwy6nWiITevQhiJm1
 UNqYWh14G2YraKwMOkMbmzcbhy4+WoSgrR5jAtGbSUEZpJ7724wsvyDqwbqyzZ7K8X358Wrfa
 Tl16/TWvXTuNk6UPxzKKC7u7BP2sQHSy7V50y6zuWPz2/gYRRmBkQFTBVd4f/tEtfq+AFYfUb
 8T2lQ8Q4aLqvunoFvYtyAiFDVRzAt7111FGs4WZuj+0iRkW6dJGZtXECmwyuXm6GPBkenjqAp
 DTb5cbyoflID3e/yx+XZh+MaaTo4uVWxIWk9s0yNQUuduFCHpiEPCMS5udCIEipK5Mc321uZL
 WOsubjvwwq5HNKWylkNMCzNjXf1LiIqDYRb3+heDRiHkr4LsrLSKJZhfFk7Dads9J9b3lBarX
 cd69L3cZOqraNgbPRMx+yRZosx83QPfyj+PmZ9Haohp/bPUSWhl5KsnV4njX4vLY5tLHb2ApO
 yo041Q/QopueXx6xKZw8yW3E0m/YcHVzm8XrpauDI9kFACkGZbjZDEL4Co8ul0MzfphO1/lS2
 jg7Q0GafQRNgZZKozgjjuwIbCBg62W5EAz6oFvUGIFz3byQaDRmiBy4zBdOnP+g3o6v0HgSU7
 UoT+gHer4c8D6RHiVxu0yQS5L+/i4It6cT8VkhKMxtWWZH2MVIa+TJc/Qq0Hpft4vC9lJbV8q
 pnsOObEfuFMbynyRgG/xK6mIAY+zbD7WISZwJxxE5AL+BC9hlNESZfyuml/XxTZjmyPM2FDnp
 11KHT8K/qdV0LSR4WM0c3FyKKMVkHeh+o1cFVrCYD4dIFVHZKV9adeLAC4a7A4KxTOV3+gxVU
 z/dZncZAg/CSQbh+WMw2Eruk1+neo/tueP+IyHMYfWADJRMiM1hC9F1yJf/2kFkGICUpscwMf
 XNYEf2ENgIGQWkBoChjwjOsOxgxGlciGjN1B98cqnnUdAo2gnMQhroXtyYgcXmET4h5kASMwx
 NC6DP44dlhZfHppwsWfnx9CrvKXRwVPZU9bFE+ZE0f+Jdi54kU/XWylyu2ng=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Tue, 26 Nov 2019, Eric Wong wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > On Tue, 26 Nov 2019, Eric Wong wrote:
> > > Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > > The biggest obstacle is that at least one of those Pipelines requi=
res
> > > > access to a clone of public-inbox.org/git, and cloning that is rat=
her
> > > > expensive. Even a shallow fetch would be super expensive, by virtu=
e of
> > > > _all_ the mails being blobs reachable from the tip commit's tree.
> > >
> > > Fwiw, lore.kernel.org/git/$EPOCH.git ought to be somewhat cheaper,
> > > but it's a different (more scalable) format which requires SQLite:
> > >
> > > 	https://public-inbox.org/public-inbox-v2-format.html
> >
> > Is this incremental? GitGitGadget needs this to be incremental ;-)
>
> Incremental as far as "git fetch" goes?  Of course :>
> The "m" file is overwritten with every commit, so the tree size
> stays at 1 (tree growth was a major scalability problem in v1).

Let me try again:

GitGitGadget "reads" the mail via the incremental clone, remembering the
hash of the latest processed commit. When the Azure Pipeline runs, it
first fetches, and if the commit is still the same, does nothing but exit
with success. If the commit is different, it looks at the mails that were
added, via `git log -p <previous-tip-commit>..<tip-commit>`.

Is that possible with the v2 format?

Ciao,
Dscho
