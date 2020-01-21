Return-Path: <SRS0=4+BP=3K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA441C2D0DB
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 11:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A864524653
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 11:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Ui933EM7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729367AbgAULqZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jan 2020 06:46:25 -0500
Received: from mout.gmx.net ([212.227.17.21]:55341 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726052AbgAULqY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jan 2020 06:46:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579607183;
        bh=25kHSuzWS5RztvzXgs10QgmSgCUwUoM8lbRklNBXcsM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Ui933EM7PKNOdfKRIT8b1dmCPUtEPlhEHnv1dbDnI2VO7l1HeH/n7wCy2MiVHulhx
         2IQjDjyRlmv4A+gKDlYcFua7olMNT74K0csYzc86Dm68lPS8DB08FWKMS6JWIh6UOf
         9hfxbPbjH7fQStnXmkXuODZ79SiZCiDHLZmrR5Q8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MAfYm-1inFDi3cyW-00B4mh; Tue, 21
 Jan 2020 12:46:22 +0100
Date:   Tue, 21 Jan 2020 12:46:07 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
cc:     git@vger.kernel.org
Subject: Re: Y2038 vs struct cache_time/time_t
In-Reply-To: <20200120194515.GE4113@kitsune.suse.cz>
Message-ID: <nycvar.QRO.7.76.6.2001211245380.46@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.2001201555220.46@tvgsbejvaqbjf.bet> <20200120194515.GE4113@kitsune.suse.cz>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-189066351-1579607183=:46"
X-Provags-ID: V03:K1:pgpN0Hz/QBIK/B2UjuphsXZBnHSKoaYlNZvz9sGpuc1TROKnmo3
 SSaBbnA+2myXmIa8H5hWHZdqw44/UEpy7B115DWcWhHpdqxOwclVsjbuQbxvR/V9Ys3VvEv
 +vYFRhYVXOo9RJQaBsnCF37bdTQ8F6r5roX3vtIrUWd919v1ymbzzrTK1U8INfbTkKs2NEv
 lyLP0oqwDdz9zmBR+jDvQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wEsaHbXSinU=:Jhg4D991dkNQp96aMdx3XN
 ao0w+ozvHbSMmUUMX7rhIvrt19K3jvgOdoYZSCM4JIcxAW0ynf9s79+i3HZxDGYGYU6rsmDuV
 7QyQiPllydaE3um/zfdi1bUROMKAITYejsm6SBPG6m2fgilwwgEsSDuumZ+PmXchd2zhiho6R
 KXpvCJvoxOfmm88X48N3Blwqykhe8RqvGNBf/Eniyw4cReRFM7HAYThWpUeztV3eX6mAAKd7s
 SYOw4gUZ+OeYQ1LBaQokOO2mOZBGe4TLKcHLf8P/VOp1ACmH/jgG0BI5036XDp2tHqvBy8uXl
 D02AZm22JgPpRuvuLMLNNFI7GWtD4RQO4DrMP57VshsLLPegs6yOZAgzKgCyfYkNrh7QIUyzt
 TydsPfCwYnXvpo5FXkYiAnDjlBZHKeDnzr2Sqr1MxsCqEhGuKGuUUgOZtzFBgM8L5JMSM1REG
 gOUW6TSD9Z9DQqzwV3g7/lRpzk5QFfmwXiNxamuXR/MLE6+Dma67wtLmQkCd5ITrTP5Wkky6S
 RHo6dj0BjPyNy43v+ZfQ2cPxyUT6oR/ZDMEW73oCNz8Y7OQ9j6eTvdE3aJHlua2sDxcmCA0g+
 7FqqsOpKBhwaF9A1AE3ICbsjKsfklG0o6XPY0hfbTCkyjdz0EG/3uCTDgFx3mZcZ42jd/0pNy
 tkLMjc0s4Gx9CFCOWji6R5fYly+bKfpVqFCYt+gDpLrM7TFfS/bL+foffv+gBQoKM2d9eMBkR
 45IkBDjpz/J6fJFz6gPXSf3PUZLhwv3xJdAigUo3Wv95B842JZASInl30h1HypPmNPoCNO1CS
 SRuAdahpe/K3WUxqpUkYzRxacC7rb5/JIKCAyIsy3FwjOoFJY8B6d1bZIYV9aJcs8OkTpypFa
 9JGTVJVsWYmXEyFylMSGCIJkLXynNB26f6B0qxVqQeks7hJnsPXCja2C0xomo316TRvu/iRPb
 +6D1EwC8WuitjnV/GGm2Bl3POy0RuezT92dGqFXsnxJ+HntlkbKZHANGcm4w0rqOrA4jc73U7
 Q9bF09obOBr3r5YdZqIQBCAOdeVY+NieSOg1cOxnyTEGQlxHkN3DBnMcBrdlqCjNr+AnjwDs+
 mf7TkSyMzSMp2hemeGLmh43bI2sarTp7xFXCrlzi3ojybJyGnsddV6W2mavzM50YdUN8aXyBv
 QRMGSwih1uWvVvOwha6i4CwPFgMyZH28rf92MJ8vDFaA831jhh1uD4kfjT+3WFO5wzFasH1st
 O3PTDIIsURDr2d7q77W7qvJYAOVLxZ8sOhyPl41esJwGVechvtg+qz01kEDo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-189066351-1579607183=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Michal,

On Mon, 20 Jan 2020, Michal Such=C3=A1nek wrote:

> On Mon, Jan 20, 2020 at 08:38:51PM +0100, Johannes Schindelin wrote:
> > Team,
> >
> > today, in quite an entertaining thread on Twitter
> > (https://twitter.com/jxxf/status/1219009308438024200) I read about yet
> > another account how the Year 2038 problem already bites people. And co=
sts
> > real amounts of money.
> >
> > And after I stopped shaking my head in disbelief, I had a quick look, =
and
> > it seems that we're safe at least until February 7th, 2106. That's not
> > great, but I plan on not being around at that date anymore, so there. =
That
> > date is when the unsigned 32-bit Unix epoch will roll over and play
> > dead^W^Wwreak havoc (iff the human species manages to actually turn ar=
ound
> > and reverse the climate catastrophe it caused, and that's a big iff):
> > https://en.wikipedia.org/wiki/Time_formatting_and_storage_bugs#Year_21=
06
> >
> > Concretely, it looks as if we store our own timestamps on disk (in the
> > index file) as uint32_t:
> >
> > 	/*
> > 	 * The "cache_time" is just the low 32 bits of the
> > 	 * time. It doesn't matter if it overflows - we only
> > 	 * check it for equality in the 32 bits we save.
> > 	 */
> > 	struct cache_time {
> > 		uint32_t sec;
> > 		uint32_t nsec;
> > 	};
> >
> > The comment seems to indicate that we are still safe even if 2106 come=
s
> > around, but I am not _quite_ that sure, as I expect us to have "greate=
r
> > than" checks, not only equality checks.
> >
> > But wait, we're still not quite safe. If I remember correctly, 32-bit
> > Linux still uses _signed_ 32-bit integers as `time_t`, so when we rend=
er
> > dates, for example, and use system-provided functions, on 32-bit Linux=
 we
> > will at least show the wrong dates starting 2038.
> >
> > This got me thinking, and I put on my QA hat. Kids, try this at home:
> >
> > 	$ git log --until=3D1.january.1960
> >
> > 	$ git log --since=3D1.january.2200
> >
> > Git does not really do what you expected, eh?
> >
> > Maybe we want to do something about that, and while at it also fix the
> > overflow problems, probably requiring a new index format?
>
> Which means we can split off the timestamps to a separate file, too ;-)

Sure. We could also jump from a cliff at the same time. Just because you
can do something does not mean that it is a good idea to actually do it.

Ciao,
Johannes

--8323328-189066351-1579607183=:46--
