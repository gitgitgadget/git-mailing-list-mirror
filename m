Return-Path: <SRS0=BZy3=CN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2173C2BB84
	for <git@archiver.kernel.org>; Fri,  4 Sep 2020 14:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3728207EA
	for <git@archiver.kernel.org>; Fri,  4 Sep 2020 14:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="glx7cBBy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730522AbgIDOIM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Sep 2020 10:08:12 -0400
Received: from mout.gmx.net ([212.227.17.20]:56967 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730527AbgIDOHn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Sep 2020 10:07:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599228412;
        bh=rYZfXCebo0A8qsenq/2wgLzyhgbdgBkM9uYuzPPCVVM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=glx7cBByPwn7Ac+5uQGqxAaUpAoQYkCzTUuq6c4FEZ7XsBfLGFOnAQzEsOTwnC/c7
         vIqZ7HvTGos0y4cUtf1PGgWLTp/aSKzS0ShtiFugTrYoH9Gdw7yoHNgZPbFbrgGeCx
         9CC0hV0ihqx6xTTmCmHCL18ILnaA8g0rR3xvIRHY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.169.176] ([89.1.212.11]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MmULx-1kwdmn0kSX-00iRCE; Fri, 04
 Sep 2020 16:06:52 +0200
Date:   Fri, 4 Sep 2020 07:42:29 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Victor Toni <victor.toni@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Aborting git rebase --edit-todo
In-Reply-To: <CAG0OSgcUi6sKJQmUEd4-Lu5qAiQqKk7X7aSRvRtcBWkcKj4f1g@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2009040734130.56@tvgsbejvaqbjf.bet>
References: <CAG0OSgeb0jcUmkjp+yzCPYkxQWCZFy3gYM9o7TfBGvtf4M08NQ@mail.gmail.com> <xmqqa6y6ah8h.fsf@gitster.c.googlers.com> <CAG0OSgcUi6sKJQmUEd4-Lu5qAiQqKk7X7aSRvRtcBWkcKj4f1g@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:68BEEs6dt6Uzy2qCRph8x2dEslezzMFdubTSqkRgcsGxMWVnZnE
 IQDnv3gmCTQAm17dbOjXSlCTbA5YSE/M6M1SJuiq5BA+HQX7EUnHdTzOusNCJKGSFZXPXRP
 nLkw2+eUSuBTKUVHURbpJlckiFo0LNb/i8fn6sJqw4JYXUKt0INya4vnGIeFNPvwuUBEumy
 HLnAkUkul4B+Gt/YncJAA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Wr/5Y5feQDY=:eXa2su6t9bASsnnD9pCgZk
 ir9Erx2YKGC1pj0xSFrtjUwr7blRVIYbasd+YqAJWzY+sw6N7oDYU3KZvbMJXRm1nkx3BNj1s
 0rjkrLSpCwMlNpEdo7G/Cbgspwk6rDLthHZq26L4P37n0IVIQROw9ziEqyz81pQxiSHYyWx+n
 vkFTR3S1xqUiSvJMAt1wptpJoqxCAuI9d/UFGHg8aTPUFlBoNPjgUamd5+urqn0VWs7XotJyo
 xBO3rS+VH0LkO8+x3B3JleEGjjomSgZbv5miC/LBsgqJvDkzEvjhqPun/HcqrPvB72tzA4T89
 X27SJxcyyARBDYmRqm31OlSaYu9q4vIQPxMVI9Kc869bF3aLbu3pPFLEeRAvOPLHKr1FQhc78
 zNvJ0tcEuzPp/Aeln+U5i9oLNpOX5g/VmnJOriqU9l6DGyGPVgHxNq7cyMNizTLleA/3hpDyC
 Mdl/94sNTi+ArokjsoTc4gYcunYdTYQLhi0FDzAQddy76uoYAy8EgyNQzNzs5PBgdEzA43JNC
 mDpd4fInny5KnWtDhe7B9Aig3G31djxsCTgCmInsu3L9l5+onP1L5MQtFjWXKuJukzdjCt/1+
 l3FXobaN0wMx+++qNHnl3Z4czw0fY1bwD46eudJs8r4cDf17ZoM4mM8zj/Gp57oUKwIFVSSdD
 9nRlS0ikrBB5jX3vP45iTeV1vtVuf3VGgmLEffNJ8Bz8s8UQNLLMLghM7LUSN9C9qgtys+zrD
 s+InEfJ/lBqcjjJpfZxQundayQlCa/mrX/DGeJ6AxHDWWGFkT+Lintms/b7g7QVYjwvIW/YJp
 j4i3uJRBBE5B9NmrZ2RTTqcElqDMzR6UuKI/1xjBtzDHzMWtlEZD8dj/iHmEvEVgSePYsSHwa
 DTPrnxW9qaYETMg61J/S8+FRZjSqoRT1QxFebgMJmRy6Ld0fNyQ2hN0bO4/cunU87+rMIes8S
 cuFd0YZF2i0+gCyMpcasmoLok62snz03F1i6H9hWWNdMCqCyEeuS+oAPyW3cnDMQaOgn7cqGd
 hR7IUnJxiqr4yy9chT0NJ7m5eNYgupKGU5AwdavEDZTIGn4tjY1YEqGAvj2pGM++Oxo5X+4qg
 zcFRypA8ZT9A1vn1yoELWM3P0meIh1sBpI7c5QjB4xB/jOU47xPBL/mKLxKDcXjx0v2LRQw4+
 8gSG2JYrDI4QWvprL7NTYFm12Gqyco52BgLhu4lmM3zpTmIxV31QPYTKYEEGCFUdjqiunPTeO
 DJTUGgTTpnzpuPk5PxqHGqBIVtnGly/GJOUZMUQ==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Victor,

On Thu, 3 Sep 2020, Victor Toni wrote:

> > It is rather unusual (or almost always wrong) to have a totally
> > empty commit log or initial todo list, so it is understandable for
> > Git in these situations to stop without doing anything further.
> >
> > There is no other sensible interpretations of what you are telling
> > Git to you by returning an empty buffer---it is extremely unlikely
> > you want to create a commit with no log message (without explicitly
> > allowing it with --allow-empty-message, the command is likely to
> > fail anyway), and it is extremely unlikely that you wanted to just
> > reset the tip of the branch to the --onto commit.
> >
> > Once an interactive rebase session has started and you are given the
> > remainder of the steps to edit and you give an empty buffer back,
> > however, there are two possible interpretations that are equally
> > sensible, I would think.
> >
> >  - One is that you are signaling that you are done with the rebase
> >    session and all the remaining commits are to be discarded.
> >
> >  - The other is that you botched editing the todo list, and you wish
> >    Git to give you another chance to edit it again.
> >
> > I think the implementor chose the first interpretation.  The "drop"
> > insn is a relatively recent invention, and back when it was missing
> > from the vocabulary, I do not think it was possible to say " discard
> > all the rest" without emptying the todo list, so that design is
> > understandable.
> >
> > Now we have the "drop" verb, the latter interpretation becomes
> > possible without making it impossible for the user to express the
> > former.  It might be a good idea to
> >
> >  (1) save away the original before allowing --edit-todo to edit,

We already do that:
https://github.com/git/git/blob/v2.28.0/rebase-interactive.c#L113-L115

> >
> >  (2) open the editor, and
> >
> >  (3) when getting an empty buffer back, go back to step (2) using
> >      the back-up made in step (1).

Yes, and we can claim that this is a bug fix to avoid having to respect a
deprecation phase.

> >
> > Either way, the todo list editor buffer can have additional comment
> > instructing what happens when the buffer is emptied.
> >
>
> Personally I would like to see your approach (1,2,3) implemented
> because it is not destructive. If the user wants to achieve something
> different he

or she, or they,

> can retry.
> Option / interpretation a)
>
> >  - One is that you are signaling that you are done with the rebase
> >    session and all the remaining commits are to be discarded.
>
> is more difficult to recover from. (I'm still thankful for `.git/logs/HE=
AD`)

Indeed, it is pretty tedious to recover from when you can originally made
edits to the todo list that you then accidentally discarded.

Ciao,
Dscho
