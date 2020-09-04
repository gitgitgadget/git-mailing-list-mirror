Return-Path: <SRS0=BZy3=CN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506D3C433E2
	for <git@archiver.kernel.org>; Fri,  4 Sep 2020 13:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A5842073B
	for <git@archiver.kernel.org>; Fri,  4 Sep 2020 13:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="PVTmhJgv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730727AbgIDN4z (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Sep 2020 09:56:55 -0400
Received: from mout.gmx.net ([212.227.15.15]:50975 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730551AbgIDN4r (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Sep 2020 09:56:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599227794;
        bh=YJnVBkj1fOLO8HcOFCqwfdjhsoVxJT2K9QC818qj7Lc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=PVTmhJgvNj/+EBYh1PT6LLVv/w0wUauoRyFnHh9qmrI7OtlCKupwhg9+f94J9bY5L
         Poge39gz3+v3tfTTkk5JQ023drzVMLHnMJrepj9utEUPu13P6Ecycgcd7u//m5xf6a
         ZifQSzvpXAg6M7wDaSEOU/bSohAP1Pkru24/A5mE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.169.176] ([89.1.212.11]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MtwZ4-1kZAR33Z1Q-00uFnp; Fri, 04
 Sep 2020 15:56:33 +0200
Date:   Fri, 4 Sep 2020 07:32:11 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Victor Toni <victor.toni@gmail.com>, git@vger.kernel.org
Subject: Re: Aborting git rebase --edit-todo
In-Reply-To: <xmqqa6y6ah8h.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2009040729010.56@tvgsbejvaqbjf.bet>
References: <CAG0OSgeb0jcUmkjp+yzCPYkxQWCZFy3gYM9o7TfBGvtf4M08NQ@mail.gmail.com> <xmqqa6y6ah8h.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:IFOfEEUcVZtOtTZA095VGlpRNht/sakqjjtPGHLYW9SGrkVquWB
 MHApz12+NCFiSFqK24wVqFfB1FvWe/iI9kuErecbewEv25+fQ2jK823ODujk7zkNSpX7cGD
 1jUOwwzCjjwAwQlbB00wDk8k66dCAYeZl6ezxjA9qcvVYu+0R03PZM2rBu0Jtj2C+s85AmO
 89TDVBGJGH2j/6TOvZ5pg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:keqhWLM/Nv8=:FdWCdjtWT8TkB5l3Qw6zUG
 hVBXXXfVIhhBGsXK1uXpdGfCBJl8WLr0uJ8Rrr9JmFPyQKcGKgGFN61DbgtpmZF+GFu4PdPxO
 RUP6WCg8D1lvpOLpxxNeut6iPmFj6NVmbcSCJ6xEQYunmnh1cyT/JiH4kFAKMDFK4KhFzu+Rr
 eqTPq3fSGcGbO2FYydUuyZ1IhNV6HJ3tu9df1ncjgywb4nL/fe7K5ZBMJoK6ZuDW9WgzAebFD
 sGJuNu7nsbNmkrHsGfpsdqHixqfmzrhlHskrHliFrBzu3s1ozsq7FmbFF0zJJkr3rKLXepO9J
 RHOmeIwCMwdf8e7GIq03DpEI3+FIlRi2d3gHrPRYX0I5cuGxcmrVLuoGrMxreFPX9zHkKdfdU
 kBBkP9DxO2jRUj7zkTTENJBO49XMdEyzPq8CU69ORpH719Jr8+8aycDNWTWrzUJwdT4k8AjOz
 6S8Lwaz0iXrNcq0LlG6g0xUAuiJIB1MQJaXhsb+4CY9htsibGcDGOYJuLbvwxKXach9BkXpx3
 wg6qcf1Qe0uIjmEZdb9an+2cegkDS5xWRl0Fclbcpf1WYvNPu0Xjg5NPT+kUBE+MWLnRc0ypl
 LSWlYi2nU19AwnvrAI1gkPuNsFB3MyuKYDla2l++XdTDgbmVZd2J9LJBpBDjeFk2r1+tILspY
 l3LOItxLtv6N7cPZJUW0vmxlYU/+oy/AuMvL9D3sL1+27qQkvEMFW/yxHAWwQNTWANa9R/bUi
 LWEzUz77Q4f0QcGXMdHcpKGE9Fogv6NeabZK/0FD5YnbCwwWUXO/z5CMyKFudeWl9vX0pWdLp
 tzP5sNc5hLQlca7XgZrAqe0T68UeqWOiELcjFjB8D9/QyDhWPPf2uz2YjgBDchJt6PUoyRZ2r
 YbeWhSIwufrDGZm1QEtlF11PehevpNiQr/E3Q+Z0gNXtINvFqYVe5fsre1W9wvN0dY3uOKaBv
 CdlwvcJlj8ErEzxYWJHuwsChYWm+6ZHv8b44pK+BUlexyIMj7xu36yZWmQSRK82DrY65U3a93
 gX8IN5NTiqIgmdi/oTX6ZFMUxRO8ruB/4ImDEZMcZ28bIX3C3kb0+aE2vPW6nToUjhS+oAKGC
 lFU6dGqpXEXfEJMDd0ODI/PmYFbqnMBSq03/1/AQyx+68SJJBZAUn1/vyi+B87HKY3mCUilIt
 zgI/5DfE1spYmob5quvo1c0xO7tKMBU+OO2gl0wS33Y5HGq0pUa3v7X0xJhlWOcLhKu0Hi65E
 /mntPMN1eDklRrrnTudLszpal21isKaM+SEqbWQ==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio & Victor,

On Thu, 3 Sep 2020, Junio C Hamano wrote:

> Victor Toni <victor.toni@gmail.com> writes:
>
> > When doing a commit or choosing what to do for an interactive rebase
> > one can just wipe the whole content of the editor, save and close to
> > abort the action.
> > While doing a `git rebase --edit-todo` I came to the conclusion that I
> > would like to abort the edit and did the same. The final `git rebase
> > --continue` got me rid of the rest of the commits...
> > (Fortunately the "missing" commits could be rescued by looking into
> > `.git/logs/HEAD` so thumbs up for that. )
> > Unfortunately the behaviour of `--edit-todo` was a bit surprising and
> > somehow doesn't feel consistent with the other actions involving an
> > editor.
> >
> > Can this be considered a bug?
>
> It is rather unusual (or almost always wrong) to have a totally
> empty commit log or initial todo list, so it is understandable for
> Git in these situations to stop without doing anything further.
>
> There is no other sensible interpretations of what you are telling
> Git to you by returning an empty buffer---it is extremely unlikely
> you want to create a commit with no log message (without explicitly
> allowing it with --allow-empty-message, the command is likely to
> fail anyway), and it is extremely unlikely that you wanted to just
> reset the tip of the branch to the --onto commit.
>
> Once an interactive rebase session has started and you are given the
> remainder of the steps to edit and you give an empty buffer back,
> however, there are two possible interpretations that are equally
> sensible, I would think.
>
>  - One is that you are signaling that you are done with the rebase
>    session and all the remaining commits are to be discarded.
>
>  - The other is that you botched editing the todo list, and you wish
>    Git to give you another chance to edit it again.
>
> I think the implementor chose the first interpretation.  The "drop"
> insn is a relatively recent invention, and back when it was missing
> from the vocabulary, I do not think it was possible to say " discard
> all the rest" without emptying the todo list, so that design is
> understandable.
>
> Now we have the "drop" verb, the latter interpretation becomes
> possible without making it impossible for the user to express the
> former.  It might be a good idea to
>
>  (1) save away the original before allowing --edit-todo to edit,
>
>  (2) open the editor, and
>
>  (3) when getting an empty buffer back, go back to step (2) using
>      the back-up made in step (1).
>
> Either way, the todo list editor buffer can have additional comment
> instructing what happens when the buffer is emptied.
>
> I have no strong opinion on this one myself.  Deferring to Dscho,
> who may have a lot more to say on the design issue around this
> feature than I do.

First of all, some historical background: the idea that deleting
everything in the todo list aborts the rebase *predates* `git rebase
=2D-edit-todo` by quite a bit, in fact, that idea was implemented in eithe=
r
the very first version of `git rebase -i` or at least very, very short
thereafter.

This idea came from the fact that deleting the commit message would abort
a `git commit`.

In the meantime, `--edit-todo` is a thing (where this behavior makes a lot
less sense), and `drop` is also a thing.

I agree that it may be a good time to deprecate that behavior, after
introducing a new verb `abort` or something like that.

Ciao,
Dscho
