Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D809C433EF
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 12:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EED9160F9B
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 12:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236913AbhIMMMY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 08:12:24 -0400
Received: from mout.gmx.net ([212.227.15.15]:53169 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236301AbhIMMMX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 08:12:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631535063;
        bh=7+oxmG6mZq27XgMrJVhdNFqOTK+9hktU+RTK6hYfrIY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=gjsDrivI/ohtDzJN4NJw30kKQnXNLqoW9yoff4Lr8JmunEdW+oHl1OW9G6msGJSm/
         I8TdQB9Z9udk45J/2diyxHwDofe7CTjJgPDhqSkQ5bDKqU4YGchMcQOZUF3nN5bhp7
         ufm2DygK6Azn8u6nvw+itH/uxFwcLI0Cbx/00538=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.116.95] ([89.1.214.165]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MtwZ4-1nDRXf1fDA-00uGAA; Mon, 13
 Sep 2021 14:11:03 +0200
Date:   Mon, 13 Sep 2021 14:11:01 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: js/retire-preserve-merges, was Re: What's cooking in git.git (Sep
 2021, #03; Fri, 10)
In-Reply-To: <CABPp-BGR3dfJE7TZ+jkjDdWyeXYowmJhtoFaQ8_Abn=ZROhB5Q@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2109131409530.55@tvgsbejvaqbjf.bet>
References: <xmqqsfycqdxi.fsf@gitster.g> <CABPp-BGR3dfJE7TZ+jkjDdWyeXYowmJhtoFaQ8_Abn=ZROhB5Q@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:kxRq6L/1EJvIUJZFvOQYozymwnwjGvz/orbCALzUOv+F1Q2QZ6c
 H3GgSaudnNSYPCyrG1j6/A9tZ3OHC1wCdHLc+xu5HFaihYrGhAPRF3jUsf5ismB3g2FU9vR
 f3JqWZckyKVyVNxcE4GwoQCBJgut9Dp88zGwVE5jk+M0LweqfekdPYYrA7tqtn7v8hoB+//
 /RCF0vHK++jYv2/FlrmJQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ey8Ahm8eTB8=:167PZknc3jGN+q7CAlj8b/
 ubyib/FP2M8IxyyNwOYhKUDGkG28dYdHQLewApa+coUIPX4eGH4sBRbhWgIEG501ZyIkOd0Wg
 JRW7/2vFvDypM7QfWafXRg1743P/C0pvm20jWmv2fo6BkB79Ru2NYNYFnaAoDBfSvVL4r0iG+
 0mcqJ27GRj8IRkX3EBNvFYwzkc6qdm3z8/XsrUVeJHTqxBtX6X1dRb/WESGSVyYPuoxnYEOI9
 RKuGui63ukC6mKuYtpFxuZCmx7/oj2rPch+SEx0KZn//7RbIivMvl7yK0Bj8girazOlnupyOX
 xWHGd2SeTbH7Q0xfV5/HCr8FXnBQoniOpoPDPVykCkE5mWtkSu1qI660xSfLEyyjoAb4WbemE
 O1cBZjTiB6Uv/BVOhyfBZk4gmmHDxse5fKudtEyCmMOR3Y0A66TCIXOspK+QLSSGWAm73opyN
 CBUfnQ5Mf1Zt14nguT3SC5RzqcXos20q3RBwczj42tdwZO/ace49rYRO5iRsCg4eB7iydQp2v
 aUhWFdLixAdLu3dvcfKpYZXNXFCM5inNmhK7pSeQpAXaeeI75NOt8zhlLqdVlpAKIRO96MKWH
 IBJO1ibGdaACJZOAQXbLpUnmO23E5NFsgJreuycnAfwbbZf/bI3rZ1PItAjjeuzQIAQ6pk3NJ
 C4nNXW6u2Km1nxambGqbP0Ir/Z2dv+EyuL5q8uSEoAzY02hgof8ICIkfZhyuzwO7t0Wc5epnB
 8YMkcE0FxR3bSp898ijo9cJjFQjuJT7hOYz5VCjxAJjFwfkdnJ8egETKaNnoJRvnRrUlTE3cQ
 +fV0dP0i9d9LmtKK/RikFsfGttq+n7EDqyiSq3OntHguHd/dGDxMQcvMi1CmvzUwKWOYLVMIt
 KlNCQYuvtWhD4eWUiHyYB4TUGQ2UQu+j5u3Wjp1UBRlajj5m3kdBn8R38ECzQrWTsyqiEG1rI
 X9PQUzLHEi06ADAFOxna9xpwR+ZZiB0fpFhGJmQ0J81RiZQjoT9mLmZmp03m2nZzcV8moJOuK
 MBUW3Ocnc63DkiRzqQkcBdR251RbbsBYpPiZ04QkzwnNaou/x+2o8yWwi01ni71IEk3d7nbsi
 VSIs0AD3Y2W1pQ=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah & Junio,

On Sat, 11 Sep 2021, Elijah Newren wrote:

> On Fri, Sep 10, 2021 at 3:12 PM Junio C Hamano <gitster@pobox.com> wrote=
:
> >
> > --------------------------------------------------
> > [New Topics]
> >
> > * js/retire-preserve-merges (2021-09-07) 11 commits
> >   (merged to 'next' on 2021-09-10 at f645ffd7a3)
> >  + sequencer: restrict scope of a formerly public function
> >  + rebase: remove a no-longer-used function
> >  + rebase: stop mentioning the -p option in comments
> >  + rebase: remove obsolete code comment
> >  + rebase: drop the internal `rebase--interactive` command
> >  + git-svn: drop support for `--preserve-merges`
> >  + rebase: drop support for `--preserve-merges`
> >  + pull: remove support for `--rebase=3Dpreserve`
> >  + tests: stop testing `git rebase --preserve-merges`
> >  + remote: warn about unhandled branch.<name>.rebase values
> >  + t5520: do not use `pull.rebase=3Dpreserve`
> >
> >  The "--preserve-merges" option of "git rebase" has been removed.
> >
> >  Will merge to 'master'.
>
> I'm not objecting, but I'm kind of surprised to see this after your
> and Dscho's previous discussion at
> https://lore.kernel.org/git/xmqqv939uis8.fsf@gitster.g/; I thought
> it'd stay in next for a while.  Was this a mistake?

Oh, good catch! I would be very much in favor of cooking this until it is
tender and ready for consumption.

Ciao,
Dscho
