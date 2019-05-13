Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B32361F461
	for <e@80x24.org>; Mon, 13 May 2019 12:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbfEMM4p (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 08:56:45 -0400
Received: from mout.web.de ([212.227.17.11]:48579 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728015AbfEMM4p (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 08:56:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1557752197;
        bh=1oXi+fQEDlQ8JjTCDTS+R9hu/WILpFOpekckkx2zolA=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=oU1d/+OATHNlzJw23JJj5tMGy4pHaYMma8kzzKtywduk7QBOM/Vs5Dm9B2viSMdvD
         3xJ0A+9d9bIClb4ByP9DCgN9ecGOCrA1KAMBV/ftZaInv0o2DRxnWRAKmOGnnsV+/L
         SElMOpuMGiI05+nrwk1SvLyOj+SVqL1jlBMVnndA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LmuAa-1glcYz1IM8-00h7VI; Mon, 13
 May 2019 14:56:37 +0200
Date:   Mon, 13 May 2019 14:56:35 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 5/5] fast-export: do automatic reencoding of commit
 messages only if requested
Message-ID: <20190513125635.tntxhjbar2eold2i@tb-raspi4>
References: <20190430182523.3339-1-newren@gmail.com>
 <20190510205335.19968-1-newren@gmail.com>
 <20190510205335.19968-6-newren@gmail.com>
 <20190511210704.w2mxw3jv2ra2dr7w@tb-raspi4>
 <CABPp-BEzaSW_eY1yTpLr8tXHei0WV54PFGXmjCLAJNN03Zi3eQ@mail.gmail.com>
 <nycvar.QRO.7.76.6.1905131219490.44@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <nycvar.QRO.7.76.6.1905131219490.44@tvgsbejvaqbjf.bet>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:SOzUWR1jDu0/v83iLQfxVwxpk593W93gMW1wg5PzpZc2kMTCDWP
 q6M+AOnMYe3uyNoUoXp2FLFx9v502G0n3TtKvPwEC1lQQfL9HScFs3xvAaW1A2bp+/AGSQ3
 37XrJNwCbvuEWu/9PbUP+yh3kTYAlH/RSujDjE5y3MvJedRx7guADX57qsl/yreMwJvBwZ9
 3AGY8UtgaZWFebdHFAOsA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6aia1dWUVjI=:jI43lQ7ESrW7nq2c//tewM
 BO2pLPdGCgDYfz/9if6n22f8oyGGH/KQqxUcIn9yqjsIt5J/qYssenFJ+9Uzl3ZSVBEix9Mf3
 zyMxfxs0Wkht9jSLbbuMl7JSHg7lkKvU6eE7QKARBshhps3lj9MfVUmv41g0K98FYbnP6wSbS
 zI3nSlwYpugrI3iEvJtpQF2LjVvmvijHWEGykl1qWOzGhC/wbV/36KEXXIepPCR7zqBHbOvEi
 BV7gcf2FmerHszSzpKfCfxRQIUB3AhViBGToAOGNMByOKOPT9FrgC3CPFHDO2pnA+1YMwDH0P
 vcVPVQfQ+vDd3JXK19gGdrL+Dq1cqgGSdTJM3OM9HzGv2Ppl2sjw3K1DReY3q3DXkwSi9ebho
 jvaeM/Gw6OisMDsqw8OPFIkTCmpQTFuSzoX2L+C0NNQ6eVtY01OQ5Jp69a/1BB3VJZ9NY6SQq
 pzrfaYorSYbQUJKM+Jg7zoO63mPG3xfRPM0Anr7pQgdgDG08IkbXJQMf0iBk4BuyztjPjR3FV
 p2PTehLxIQcgbWCL6SRUK6XMjKoEy7QOmSa9uhDRYYz4FS7djOP8zLJFC2SANUJzBokeysY/c
 wF8Omra0DX6D5i9/Gm8lcsNH9uV5Xi2OFs8mixifwty9QAN+PeAMCRDnR/Iq0Tf/R+sJfxoi3
 hde48fvRmzto+th7INhoG1b5qMC8rR/LI9WfF32dsJSDsQqiFCekH4HnuQ5oTnUyamI+AmIQv
 72fadk12zRON+NzlC10LGhGtEGOXwRlSTNRCp6a8loSJSjYzT4FZvH5iaZOVcsYCPSeKnsFzI
 ho4rhYPBNj6LUYs6PdWGQ4HRkpk1d6jEdovCJaUJ/2L/Ni6pnISIEQxFwGdOUFwrzxTj0kiMM
 s1o4VjyqHOHKTrznivfmTbOcr8pYwcHbklDvJTiKwYeBmmI5LG8GAUKrYegVus
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 13, 2019 at 12:23:29PM +0200, Johannes Schindelin wrote:
> Hi Elijah,
>
> On Sat, 11 May 2019, Elijah Newren wrote:
>
> > [...] the craziness is based on how Windows behaves; it seems insane t=
o
> > me that Windows decides to munge user data (in the form of the command
> > line provided), so much so that it makes me wonder if I really
> > understood Hannes' and Dscho's explanations of what it is doing.
>
> It is not the user data that is munged by *Windows*, but by *Git for
> Windows*. The user data on Windows is encoded in UTF-16 (or some slight
> variant thereof). Git *cannot* handle UTF-16. Git's test suite *cannot*
> handle UTF-16. So we convert. That's all there is to it.
>
> Ciao,
> Dscho
>
> P.S.: Of course it is not *all* there is to it. There is also a current
> code page which depends on the current user's current locale. We can
> definitely not rely on that, as Git has no idea about this and would qui=
te
> positively produce incorrect output because of it. So we really just use
> the `*W()` functions of the Win32 API (i.e. the ones accepting wide
> Unicode characters and strings, i.e. UTF-16). I don't think we can do
> better than that.

We can actuall feed valid UTF-8 into a test case.
(Remember that shell scripts need this octal numbering, see
t/t0050)


See the "=E4" code point:
$ auml=3D$(printf '\303\244')
$ printf $auml
=E4


Now we can feed those 2 bytes (wich are valid UTF) into
Git and say "convert them from ISO-8859-1 into UTF-8,
resulting in 4 bytes.
Is my explanation clear enough ?
If not, plese tell me.


