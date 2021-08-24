Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC6CC4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 09:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C0DE613D0
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 09:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235750AbhHXJ3H (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 05:29:07 -0400
Received: from mout.gmx.net ([212.227.17.21]:57773 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235720AbhHXJ3G (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 05:29:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629797268;
        bh=kxV2DGD0CrI07h7StTdzFqcqotlSfv/AgTNiYUOrLm4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Minl33iVksGsvfZYav0iNvmOKZjv0pGIJRYQXFFFTc3KM6Lx6ZiiR9B0c1TFOANcD
         DLE8rSFUjY83xrtl6hIy7gtpx4qgSHzZhO0B+CNBmyvVNFu1XN5Ssox2ffH9iHjMEr
         NXYbrzRKI2LUGczu1TYXrnZE2RneOmXXm9CEG5Dk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.215] ([89.1.214.7]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MWzfl-1mY8zt1H0z-00XOtl; Tue, 24
 Aug 2021 11:27:48 +0200
Date:   Tue, 24 Aug 2021 11:27:44 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jiang Xin <worldhello.net@gmail.com>,
        Git List <git@vger.kernel.org>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        =?UTF-8?Q?Matthias_R=C3=BCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        =?UTF-8?Q?Christopher_D=C3=ADaz?= <christopher.diaz.riv@gmail.com>,
        =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>, Arusekk <arek_koz@o2.pl>,
        Daniel Santos <hello@brighterdan.com>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?UTF-8?Q?Tr=E1=BA=A7n_Ng=E1=BB=8Dc_Qu=C3=A2n?= 
        <vnwildman@gmail.com>, Fangyi Zhou <me@fangyi.io>,
        Yi-Jyun Pan <pan93412@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH 1/1] ci: new github-action for git-l10n code review
In-Reply-To: <xmqqsfyzq1wq.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2108241126190.55@tvgsbejvaqbjf.bet>
References: <20210822161325.22038-1-worldhello.net@gmail.com> <20210822161325.22038-2-worldhello.net@gmail.com> <nycvar.QRO.7.76.6.2108232232460.55@tvgsbejvaqbjf.bet> <xmqqsfyzq1wq.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:GQZ4Jt6kphGj3S7lbS4E49ZiFRxwOY5SJILiK5vyNP5U/EyQlUS
 d+Sox3iG3XuD6G35vR10GiS1Gd1LUleHR7ZsMg/e0JSFb3WBTGh1z/dDQzM0gBY4ZCuHU9c
 61e06Yqq+yZ50WMrKIMKnSJoLRmLKtLnFrRpGweQe4VvDN3lEgQ1F9i+rXfBQs4dNJduVH2
 b7l+0Jsn3mZvwmIE60pfw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rz7E862MDYI=:lZkDYl90WTvGK2fvAGqZxH
 3ZNCHBz42aW7nH1qOLteD6RGoqN/+0WZ9WxRw1inNXM+HSo6PebXL38GK6+WeoHLSZ7unLWqK
 98t4Q97b0ySrToN0xPqeyAJP9RxSc7pPjrpSkEQI924F1/NXd23kigtBMNrkMCE1yVlnplPL2
 NUDGIxP3QWh4qRQ0p56F/BsmZ/Kr3L6XEy+bz2ojIKvY++SwKyrZHPApfIuKK/b2tLLfKiKz8
 6M38ihkjADctLMpBtQLe3Op9GJCoYloILpFiNQK9HfPZgZEReZtMG7xSLpCu2RSHuqZeS7xNF
 fEDymQ/5/0Boerh11ZZrP5iWlEU9VfzhW1Ejr6Gqhv2yqZ1OY/TTqSYPemcn9k5x+sEV7hvhl
 zHLJl79uvomrqRHEJqN1QMNMRmDDnWcoSJ3aKVQcX+OR3/HasEjxsCG5pqxA3i1O8EQUUPP9j
 XmLnxloSctj5aNsYgI1iNgUla+ialGnzvzZ2iiD7L2ycYAyy/BrO5/n4t2IYUa0icLeJS1u91
 vryvsCOtNWa5IyPMeu0UBFPpsRdWCYZn9QBQg92ieJ0LiA7kNXJMo6TekRx9QUGQYg9AHmtBj
 mG9ZAnOI1OX0NtrNpjwcvHeFnM6Pd8GKBgOeErM+KZlw/HJMCyXqbGRQhT/QH1oyNLDir4TNF
 7iWFUogxarDkPz9X49v1fdFdWSZbwP+QQ0jMdWL6OvWl7Q8qPuPT+dqKfnjA/4WIInZYZlWz+
 AbZuqLlu34+HnXFetszfisygLjLWCMmeWmbEn6OoKT2bjKXExL03vS0LrkwepSgBuYI8uTUjD
 ffz7nVav3dF6rLX5QhNxPOKc7s0gRtrqSSEok395EXyw69/1Er4vEJ7ABolsNl3TcJi/rC3dU
 3fMclL/O6oUHRUWiFgMoEVsFbFyzOPLDZPJKchNjJZT7jC+f4pOw0INw4NWTN3lXc+Lzx/nuV
 18WGwlH/cwpyanEnTxLMaIfqJHu7FeqZLec2jmttKC5KZbw8fao0nJI6rssIXmDmqzD1K905E
 lTghXqvaDaC6x8n6NJNRrOZKsS7F19VEr5aHpCKmFxx4k2vvhZgaFAL1RG00s4uABqsYqjgXw
 9qK5m67Gt8yfL0jk/7woq/0eid4q8ft7cK8V/zTmRkd41BXFty+CbBS2w==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 23 Aug 2021, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> >> For a push event, it will scan commits one by one. If a commit does n=
ot
> >> look like a l10n commit (no file in "po/" has been changed), it will
> >> immediately fail without checking for further commits. While for a
> >> pull_request event, all new introduced commits will be scanned.
> >>
> >> "git-po-helper" will generate two kinds of suggestions, errors and
> >> warnings. A l10n contributor should try to fix all the errors, and
> >> should pay attention to the warnings. All the errors and warnings wil=
l
> >> be reported in the last step of the l10n workflow as two message grou=
ps.
> >> For a pull_request event, will create additional comments in pull
> >> request to report the result.
> >
> > It is a good idea to automate this.
> >
> > I am a bit concerned that the `ci-config` approach, even if we use it =
in
> > the Git project itself, is quite cumbersome to use, though. So I hope =
that
> > we can find an alternative solution.
> >
> > One such solution could be to make the `git-po-helper` job contingent =
on
> > part of the repository name. For example:
> >
> >   git-po-helper:
> >     if: endsWith(github.repository, '/git-po')
> >     [...]
> >
> > would skip the job unless the target repository's name is `git-po`.
>
> Nice.
>
> Can this be made into a matter purely local to git-l10n/git-po
> repository and not git/git repository? I am wondering if we can ee if
> the current repository is git-l10n/git-po or its fork and run it only if
> that is true.

The biggest problem is that there are forks of `git-l10n/git-po` that
accept PRs in their own right. That is what I tried to address by using
just the repository name, without the org/user prefix.

Ciao,
Dscho
