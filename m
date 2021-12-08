Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C240C433EF
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 11:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232444AbhLHLac (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 06:30:32 -0500
Received: from mout.gmx.net ([212.227.17.20]:53125 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229716AbhLHLab (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 06:30:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1638962807;
        bh=Toa5qCEyKUVEGBX54qJIMd3nlANrcc1+zlMM4pw8H2o=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=URp2ojIHx8zd8+SlOd194gnKPIZ11LaMpZieilAhY/Eu3Z8y957tP36RatzpvczL+
         EL4UgSd73ST0thnDNJnA/v2yY7oZHGTuFFn/d19gnb5sxRhDfNidWv43nkogOaimbC
         UI7CclrcTAT5oh3CCZX84ErLlfJ2sDiej8PLTzjs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.17.164.160] ([89.1.212.223]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1Obb-1mXWHd2y0B-012oe7; Wed, 08
 Dec 2021 12:26:46 +0100
Date:   Wed, 8 Dec 2021 12:26:43 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Matt Rogers <mattr94@gmail.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Subject: Re: [PATCH v9 00/17] Upstreaming the Scalar command
In-Reply-To: <xmqq35navofg.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2112081217450.90@tvgsbejvaqbjf.bet>
References: <pull.1005.v8.git.1637363024.gitgitgadget@gmail.com> <pull.1005.v9.git.1638273289.gitgitgadget@gmail.com> <211130.86mtlleqhm.gmgdl@evledraar.gmail.com> <nycvar.QRO.7.76.6.2111301450030.63@tvgsbejvaqbjf.bet> <xmqqtufs1a39.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2112021549330.63@tvgsbejvaqbjf.bet> <xmqq1r2vvszo.fsf@gitster.g> <CABPp-BGaHHUuQqvvDLBSaRG7C=SzS-ykOLi4HCdDDXQHgHjmJA@mail.gmail.com> <xmqq35navofg.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:LCHqAIGtQqpFm/e/VhUvs7dFcVcqb8zblCCE03fOBwmfD4GfcW0
 gTyGep23flF92KE6GjaasxboCRL1csQFQhz8TnYNMFEqBpyEadCy1BGKZUVwkZklmJSsxj/
 3IIU+xrzq1t5Vl2b7nYxPq6/kZjcglWY6Jbxx2FOUCfRIWyueevAq+OlIqfW5FU98LOngvj
 TtdYb5UlTRNIK/gT/9pdg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gfPcqiIiZjQ=:Iq70rSeH7jGgYINLyUfq4A
 EijirLnJes1WtROT/js0Zn7EnbUMYYODKXuB9DJx8qeKfyl37BEjTJKGQa4TRAUKj9knfBrfm
 7Na58My3N8OeRQ014PwLOwC8N4FeK9k7nTlNPaZ6o5dw6ygR07+5G/P4f+trBaMRViBAJ0F0j
 k4kfbfM6z//EfZK3pVibgO8seUdmqByl7KYm0fCtrbTfr5HOhlSEHf95x0zn7VIvJSvPJx7sI
 vEoOZV/AwuNMS3t5ifx5VPTcD3rj9S6YR7pB+CCQdCi9qfMWA13JouiNolZg1D3Em0ICb4shz
 zdv3D9siyeri/XXiQtWd33Nh33dCNYBoULtGGwYEYqvExluoBnbG1BsZxWJZ7nnW4zKz/7tSE
 O9PxIVWUTkY7+E/R7YJPA8K3upU2LzLndWtkH5FZ5fl0LWRswWYj246qOga1CtdliN7hSZcRV
 GTXnqoXBwwPYkA7UT1aO/zmVYA6HGCFQMBZepkfvzbSBItE9DWWGfc0+7h+gBJMDHCIYe8sNu
 dS5sreE8jxK5du8WlCoa6I8bIQwFNeCf4ypsAHuHdzImi9cCK4FaNPzeEzRLqqItOkNgYi57F
 4X2iMGdIuoB4sQ77DmULPxyG5NIb1WWamhYG5At/7rgBQ/0YGwpH6T2CTqvSBurIsKFcY6jQ/
 5LR8BGpFkJrSD8Pw4MjWEjj1LJ51KZzPRbvrA58SdWIlk7lROabPR8S/e1tOOhsqdgwog3bZj
 xD71IewUD3plF8knpUqGbd94qQlaOnm0gqGQpbkENtlkopQs6v2M7K3ZnSGG8xCdhuPW+5z0Z
 s6SEpdHhh1CjNn0fQILNicH87UQiX1xPpP5FI6KaML0sJUgq/rk20jw3dwGmzo7AiKX0KnNWl
 IbMUlhmkfn8JUN+Pfp0TQYWVxV7mUI7pruD72RVLAaVqEx5QhxT4qYx3/nYEP2zdhg4F8oOro
 lXw8CUAmHnfM4s2vZmmYSuMJ7HpH3gQY0waaY2FdIvK60c8HAqRbBL+HZ09JtSYCgc7Oag+L/
 7uqKmUwq6htlwBedYoA3sN9rcbyTxb0BNZKvLGbPHDzp0DI9OZ0SnGeuP7/qDRfUeLCYoHnk1
 FUYoP2GNG0LfGY=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 2 Dec 2021, Junio C Hamano wrote:

> Elijah Newren <newren@gmail.com> writes:
>
> > while I think CI testing would be nice once we have a functionally
> > useful scalar, the CI tests of this early version aren't really
> > netting us anything.  And they're blocking future scalar series
> > unnecessarily.  Johannes already said he had planned CI testing for a
> > future series, so I'd rather just take this version of js/scalar minus
> > the CI integration for next.)
>
> Yeah, with less stomping on each others' toes, things may flow
> smoother.

I also would find it nice if that was the case.

If I remember correctly, you mentioned quite a couple of times that you
expect, particularly oldtimers on this list, to be mindful when
contributing patch series, and to delay patches that would interfere with
other patch series that are already in flight.

I saw with sorrow that this rule was ignored a couple of times recently,
even with new contributors, and I sincerely hope that we can unignore that
rule again.

> As long as people are happy with the core part, that sounds like the
> best approach forward.

Thank you. I have to admit that it was quite frustrating to see so many
obstacles being put in my way, only to end up at pretty much the same
place as I had been over a month ago. So it is extra gratifying to hear
that you move forward with the Scalar patch series. I truly believe that
our users will be better off for it.

Thanks,
Dscho
