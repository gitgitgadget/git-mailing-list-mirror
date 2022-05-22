Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 984FCC433EF
	for <git@archiver.kernel.org>; Sun, 22 May 2022 18:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347415AbiEVSsy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 May 2022 14:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237466AbiEVSsx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 May 2022 14:48:53 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61F313F95
        for <git@vger.kernel.org>; Sun, 22 May 2022 11:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653245313;
        bh=5jma+mRL04m8fBT04t6c0JPBQvVGqTGG2kLv9ykDpvA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=WoiMBfClxfwgFZdZqHxbA2bljPtcTf+n+8uI3Gbp7RUhfAyTlRliQIL95ly6QCnVG
         ljJESgZFBhiGLPwlJ+IzAtTmOoSwHPY1nsqultE8bZ55cKA3FgfkRtqrA88TdD2Uao
         ZepjbHjv795sb708TXn4NuckF99lMQXokoYfphKw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.242.215] ([89.1.214.24]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Md6Qr-1nJEpO1lqt-00aFJU; Sun, 22
 May 2022 20:48:33 +0200
Date:   Sun, 22 May 2022 20:48:30 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Victoria Dye <vdye@github.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH v2 0/9] ci: make Git's GitHub workflow output much more
 helpful
In-Reply-To: <xmqq35h2cwrm.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2205222045130.352@tvgsbejvaqbjf.bet>
References: <pull.1117.git.1643050574.gitgitgadget@gmail.com>        <pull.1117.v2.git.1646130289.gitgitgadget@gmail.com>        <6b83bb83-32b9-20c9-fa02-c1c3170351c3@github.com>        <nycvar.QRO.7.76.6.2205212307090.352@tvgsbejvaqbjf.bet>
 <xmqq35h2cwrm.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:UqQxfNIO0xq8fA6Q6J4wafB56TKJXRrEwc5jk0C9i+F2eZSCl/5
 phOlz8XQiTTmugL1xnioKhxP7KgjGbsBUfDVuUlvuIponqK4i4rEKPgywBQPxVfAOBU0IiG
 z3u9ldNHgU0a39gOfHAuuSZTSj9Z5fRILh/kwjLMhhaZPGelYLOr797VNkXDe9oJlxVPRiq
 Z6ruFnTniFWtRrbvgEXMw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UFhZEhS3cQc=:ZBRy6/4Jvgem0q3nsqoPq7
 XpTBD6rqMn1FnRs+29CxS1wyMZwUQMXwaMGAlTG2tDz523yVobRyu507HYyaxmya8mxM6+Suh
 wBOrQ2uwEyb524dcAt8h5tVLOr2FITnRviGsLQaYF95z0fKOWKKV6E3MOKUG/uLlqCEeceDHN
 Mo5Mx/c+qVgM+adWhDi5F+Eaav0HTS3gcvaMOP/4Y8orJWUXmtW0cM/aPYxrcPiUfjRSMcbNU
 XyefcSIYgy9SKy6alHXugJ1dmAcP5Vz5kNbRwtcdAYJ3gCunKAUjzOlXin8zbowCssN/sukeu
 rddMdbwCZM9vCDUdTs+7lVP/RQwFgO1V/vHFUxb5H5pnZuLk48EJUWNuvnx70hkgHxL7yTL8M
 iXryBIcc4yWa0BOjXb18w6l906jiAxoVb7FXfeOhQPEz3zigGQMdJKZChfwrZDqmMpTzD/Pxp
 xoohTJyz3XSjPT+h2mvLEt0DKxbmLZjhg0EhoSX7TmOEQbWKnYvyzO5lKWiXmpyu8K/EbKjt5
 GohlqsU4uSlfOaFNBeNYn+idjpvNjA4xbLV9SO3+ko8bTtt6wcR4uFuyHZprHMG7Q+BRX8Hxv
 DvEORo2hx8phk3YJ+oe6HFIPd/tLWf5JJ/vSxah8TjS7dSSz5oWNrUvbDbNJtDtyjQg9ePCK4
 +jVR4Cbs+NPFDynPxbU421Z+4bJTPxSSy9O6AndsjKTiCOha2dhz68iNhJeLiu/EcjaIHiagi
 97lgsSeLwlSpYBNKXH988xHTe1c1O3y0Y6+zZ3I2kqASkYgTby+hNpxH5GTVXYJQOeL93iTmk
 kAt7VShvrsBeVamSRr4H0suCvN5/3Z/DENoCkvmRxjoXCel72u8OhjdGvumTiZLqm5uGtr4F9
 3yEnaJwa8kHYkpRUy+ZwYbiKadT2qzYugML4bSwWphBwmpjFUs91qe31dRXbqYyzTwAZfL0hR
 11XMKOSASrFh2IbWDuzd6svfh/5JM4EukHaV+NENhVu9w3jTrN+BkUSZ6WjYnm5JAqKu4g8UO
 C/2Wk0E5PkT4qk5oV09J6kFRpHcl7WM1KG7V273+dYcX6dP/qHsIHAw3ZK2dPqAj+q5p2yM9H
 9KPH++1X4ZPFK7PDVWpWMq1MtZ64ZpA5yOr3Zh2NpGr6KSDF/HIkyotGA==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sat, 21 May 2022, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> >> * print the verbose logs only for the failed test cases (to massively=
 cut
> >>   down on the size of the log, particularly when there's only a coupl=
e
> >>   failures in a test file with a lot of passing tests).
> >
> > That's an amazingly simple trick to improve the speed by a ton, indeed=
.
> > Thank you for this splendid idea!
> >
> >> * skip printing the full text of the test in 'finalize_test_case_outp=
ut'
> >>   when creating the group, i.e., use '$1' instead of '$*' (in both pa=
ssing
> >>   and failing tests, this information is already printed via some oth=
er
> >>   means).
> >>
> >> If you wanted to make sure a user could still access the full failure=
 logs
> >> (i.e., including the "ok" test results), you could print a link to th=
e
> >> artifacts page as well - that way, all of the information we currentl=
y
> >> provide to users can still be found somewhere.
> >
> > That's a good point, I added that hint to the output (the link is
> > unfortunately not available at the time we print that advice).
>
> https://github.com/git/git/runs/6539786128 shows that all in-flight
> topics merged to 'seen', except for the ds/bundle-uri-more, passes
> the linux-leaks job.  The ds/bundle-uri-more topic introduces some
> leaks to commands that happen to be used in tests that are marked as
> leak-checker clean, making the job fail.
>
> Which makes a great guinea pig for the CI output improvement topic.
>
> So, I created two variants of 'seen' with this linux-leaks breakage.
> One is with the js/ci-github-workflow-markup topic on this thread.
> The other one is with the ab/ci-github-workflow-markup topic (which
> uses a preliminary clean-up ab/ci-setup-simplify topic as its base).
> They should show the identical test results and failures.
>
> And here are their output:
>
>  - https://github.com/git/git/runs/6539835065

I see that this is still with the previous iteration, and therefore
exposes the same speed (or slowness) as was investigated so wonderfully by
Victoria.

So I really do not understand why you pointed to that run, given that it
still contains all the successful test cases' logs, which contributes in a
major way to said slowness.

Maybe you meant to refer to https://github.com/git/git/runs/6540394142
instead, which at least for me loads much faster _and_ makes the output as
helpful as my intention was?

Ciao,
Dscho

>  - https://github.com/git/git/runs/6539900608
>
> If I recall correctly, the selling point of the ab/* variant over
> js/* variant was that it would give quicker UI response compared to
> the former, but other than that, both variants' UI are supposed to
> be as newbie friendly as the other.
>
> When I tried the former, it reacted too poorly to my attempt to
> scroll (with mouse scroll wheel, if it makes a difference) that
> sometimes I was staring a blank dark-gray space for a few seconds
> waiting for it to be filled by something, which was a bit jarring
> experience.  When I tried the latter, it didn't show anything to
> help diagnosing the details of the breakage in "run make test" step
> and the user needed to know "print test failures" needs to be looked
> at, which I am not sure is an inherent limitation of the approach.
> After the single extra click, navigating the test output to find the
> failed steps among many others that succeeded was not a very pleasant
> experience.
>
> Those who are interested in UX experiment may want to visit these
> two output to see how usable each of these is for themselves.
>
> Thanks.
>
>
>
>
>
