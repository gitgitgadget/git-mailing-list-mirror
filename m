Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E570C433F5
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 13:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2C5C60041
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 13:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240858AbhIINs4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 09:48:56 -0400
Received: from mout.gmx.net ([212.227.15.18]:58369 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355027AbhIINqx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 09:46:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631195135;
        bh=4yOY/DDW/JlNevw1aLatSx3op/Tt5JYjb0dagFrx2EY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=TBmA4IiZdnN2B/r4K8kRLrLrDZeNDwv5W4GgRlUECXxhvZBaURPGggVnqsWhBIXV4
         ozZ/HX6jrblHFr/Q8mhr2ARtYZlDF0q40B/+64Taz6MJs6MGeE8nEOER7xuydTJyeY
         c3UhK8YujXUlMaqRfNcNvqcBFHb18q/XPldt4CbQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.174] ([213.196.213.44]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbAh0-1mvSC71GHo-00bdJe; Thu, 09
 Sep 2021 15:45:35 +0200
Date:   Thu, 9 Sep 2021 15:45:33 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] gc: remove unused launchctl_get_uid() call
In-Reply-To: <87bl52dkv1.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2109091541370.59@tvgsbejvaqbjf.bet>
References: <b0d6bb0b07f29e68f5bcdf4c69d3d726d77882c0.1629819840.git.gitgitgadget@gmail.com> <patch-1.1-93adb856b0c-20210909T012244Z-avarab@gmail.com> <nycvar.QRO.7.76.6.2109091222260.59@tvgsbejvaqbjf.bet> <87bl52dkv1.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-77811055-1631195135=:59"
X-Provags-ID: V03:K1:i4nmUva0qnlIhMbQZmh+lim17NwQNwQN+rMGKP3u2lZXvX8P0NQ
 fiSTXiweXi9Sok3PWpn8aMCEKShXLSd2pwjZ21zp3l1Zediq/d1FC1xuexZ50maxSSWYEOU
 N95xcfB+ew0DlrKdVOaQp8ChK3HtmLfGAEwopnE6tVYL5Z1l9ovhHP+F0JLVRJ/gZO79eyB
 kclZrU2xH1si4Z+1dr/WQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uJYei02Q2QY=:a+hbiexlxs5ME7f57ukGrT
 61Rl0695AtrlQDQ/R+GDkWq2lZsCJGNx5hzEODYpiCrLWUhRkKJgFDPifcBazsMXJ8zYxMoPG
 GEA3x/LwqJ2wb1jdHXYpdRrgyuRpK/6/awI71yl7TTPY4oajMOAcrDg3Lg+eJbXWLOVfXgEX+
 Lt6UQdApUNpx7r1h02H6sosMe3bz5KtK2eeY2Ij6COA3utJORzVFKg3FJD0ptXyudByhJ9Vin
 ddrrHiWzm23ijPJxv6WhHU9Trl88I8BxtYuWQCbsdY5/ysQpnPT4hf6xIWCmjU/lDeoap6ZpY
 7W6Swof6QVGNdhFKxnftu0kfB0Vfp9jMxECxC2vCXbHUQ/2bYihdlwGlaPpIxE80CaWfKYEd/
 Qi3Rr0cDzKYCF9HSs4hrmzKwQno3j8LkfKLpunpW8AKdaTBUGc5Ev3XWZ+BpEpOjGnzmgBjgx
 ixx8Q7msCPx2mz5O0S6gWefBlYkfC2DBTRF6WXZCMeYor8RcV1z7pUrUPCRewhDtU82iix/cd
 lbt45bV/Xize24B8GInbE4kxU1knpEWMDi3IOBW3Qaz5UHcmH9QWqg0kJz28LwR8NZ0byVMZW
 GmsGn2Jh0qQAYNzQVY6ci3HwRyWKHIAAi/+fiKoO+I0pxnoO0Qi9J1kKcJyARv0wCnqoVzInQ
 f+SSrlCdDB+6rQ/ucQGbLffld0agev8o7fHQstc1qyfysOGKAfquvMVw0UiIT6Lq1UmOEa0aA
 QN9toNxjNBkFZ/m35cAlge/dOkcax7aSm8XAWGjeD5qZvPbCqDWJ0S4o0PRX9Rnloo9LWjC1P
 d3WGgfD+KcT9FMKtZCVm6t0vr9w0oSG/sq1j8CRNijdKVb+d70iU4o584Af1qTAumJEVMExFM
 /M8yrcNDJtQ8hi/9CWcCbjukgXEyu6V21NWQLYAeJuWnfLdjojtnE6fsj5s3CYWG6khwW+Bii
 e+62rNVm74YCFTwI/Tl/R0SrHy+TYmaFTTT1/uVh6EZnlm1MaK9OssNVj5XkuTBzwotuniLio
 HqOvMLZ1oOwQlIMKdgCok4kwNczM19370ysZbnIsFeyFlS8LwltJm1BLJkUcZJ6LTUwSHcrj+
 ljr3j4d1stjcjI=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-77811055-1631195135=:59
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Thu, 9 Sep 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

>
> On Thu, Sep 09 2021, Johannes Schindelin wrote:
>
> > Hi =C3=86var,
> >
> > On Thu, 9 Sep 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> >
> >> When the launchctl_boot_plist() function was added in
> >> a16eb6b1ff3 (maintenance: skip bootout/bootstrap when plist is
> >> registered, 2021-08-24), an unused call to launchctl_get_uid() was
> >> added along with it. That call appears to have been copy/pasted from
> >> launchctl_boot_plist().
> >>
> >> Since we can remove that, we can also get rid of the "result"
> >> variable, whose only purpose was allow for the free() between its
> >> assignment and the return. That pattern also appears to have been
> >> copy/pasted from launchctl_boot_plist().
> >
> > I don't find the most crucial information in that commit message: what=
 is
> > the fall-out of the removal of this call?
> >
> > Such an analysis (_with_ a summary of it in the commit message) is
> > definitely required. And it should not be left as an exercise for the
> > reader.
>
> Do you mean an assurance to the reader that the removed code doesn't
> have any side-effects? E.g. an addition of
>
>     As the patch shows the returned value wasn't used at all in this
>     function, the launchctl_get_uid() function itself just calls
>     xstrfmt() and getuid(), neither of which have any subtle global
>     side-effects, so this removal is safe.
>
> ?

Yes. You want to refrain from forcing every reader to have to go look at
the definition of that function at that revision. The accumulated time
spent tallies up rather in disfavor of doing the work diligently on the
contributor's side and save every reader some time. I mean, you forced me
to spend the time, and then to spend more time to point out the missing
analysis, and then you provided the paragraph as a question, forcing me to
spend even more time on answering. All this time could have been saved in
the first place. In this instance, it is too late to do anything about it.
But I'm sure you plan on contributing other patches. Hopefully it will be
more efficient next time.

Ciao,
Johannes

--8323328-77811055-1631195135=:59--
