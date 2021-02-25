Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B89D4C433E0
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 15:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 653EE64F10
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 15:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbhBYPN0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Feb 2021 10:13:26 -0500
Received: from mout.gmx.net ([212.227.15.15]:58121 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232596AbhBYPMh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Feb 2021 10:12:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1614265812;
        bh=YSPc5mNoxMjUGekdB71KOcPuQDQxRHEDjWE8SOPU3RE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=NtI4V83icmKxSptL5gJUxhSV7grTqobQ33pKtqhvfiMirBZ2vYLlJ9z6gw3K2VbwU
         6jIVvk/7KBl1/gBOijJlfb/PU19hAhdg3XAUmO9n2nvWET/oOnSGDYYUAIXTtCOTXp
         wBpLT1RtUJZriAbYBRSYspbTOu6m4YM+5Sn3JCbs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.162.2] ([89.1.215.66]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MowKi-1lbdsI0y3K-00qVH6; Thu, 25
 Feb 2021 16:10:12 +0100
Date:   Thu, 25 Feb 2021 12:08:36 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     ZheNing Hu <adlternative@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        David Aguilar <davvid@gmail.com>,
        John Keeping <john@keeping.me.uk>,
        Ryan Zoeller <rtzoeller@rtzoeller.com>
Subject: Re: [PATCH v5 0/2] difftool.c: learn a new way start at specified
 file
In-Reply-To: <xmqqo8gile02.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2102251206080.57@tvgsbejvaqbjf.bet>
References: <pull.870.v4.git.1613308167239.gitgitgadget@gmail.com> <pull.870.v5.git.1613480198.gitgitgadget@gmail.com> <xmqqblcjrgvc.fsf@gitster.c.googlers.com> <CAOLTT8T=R-M1eK9thSuzHNOJ8wkaTX3yYsLEgpqmHiEYWgM1XA@mail.gmail.com> <YCz6oDZCAODPS8sY@generichostname>
 <CAOLTT8Ri+XbSg_=KaLOCmNX4Nrii1ssN9_FFbnmm7ew4vYN5nA@mail.gmail.com> <xmqqo8gile02.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-857345123-1614251318=:57"
X-Provags-ID: V03:K1:wWVpTfndy255J22ruhl9FE2dXf0yNx8VTJ/E+3ROtxuuQo8lGXR
 NT2NNKEiLKywjT3HAUhfZNH5wv92ypgYqXmCPlrrf4Ad1OwxnD0sgvVNX3TumjcU9KR0X56
 67/3WWIFph+mAufDNHuGnAvJujzPt7wGpgyIM9oTXwI150PZbURoQQkQkMwMl8uVo1TlHvJ
 bqc+F2BlLg791h8N6Ao5Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fAeevz0thVc=:FRJcu1jHAQQ75IO3PdZWSJ
 VN47R0euXYK0Oh9HnyVpx6Z3ad2UVSP4rIsh4tBvwBeLTqRDJbtjvODVgDfjBRidXTPgNgA5Q
 h21YGvHgpY57zXVoNS1tZNTEvF4gnr2OXIBenP8ceOrHbrnORpqrRiGXjDxr99KGSMp5haZ6j
 TJEltCBYK1VMF/1A/OlO4zQmXy99Sudk+PSNgHQKpS8GixJtJMIqsZYtNso1nUoYd4cbz7UJT
 0H+eoAvqhXVjly940OKJuz/Byz+NItIzJqIKOBfH/kPAxBbB3/rxotEirYWPlUz7o0Ju27ics
 oikFQZpdnilmcjDAoiQfVfHNheYIyhDl2Kodyc4hoc3+yjtKf71Y6l7NS+74+gqAwmb6BGf80
 U3+Q2wkOAvMRsHh4dRbABO+cHhITAz/DQn1eQKKOtVyPtEoKjL5KA21Is9grnFvGh6H/9PNKn
 GsMyLYf6O7hYfLFIr7t9hPlSXoJaShP3/yQPKzTz7UBpIrfDB0Wrg/oA/FkcOVenugEiBNr7+
 DD4JFBkFhpmnJ9627rbnPMHPsgmCxsb3b7EMsrZzqRdZiy8zb6Z267hXAnFb4dY7ImmfS4iDy
 N5YwMQUafwRslgEndg4izGjH/McgZAQLdnzYmaD/LCObt0p4/9nLTkjoe2j0BfnW5QWRhi/Mu
 QIHAzWEqmoWzVMjqnQMWPphXkuRaBpeKt/qVgrWGuw7lGmlmFO0u94mOj91HXSO7ZUFXOnaq8
 WNyercSFIoaIHMlXgjSwyHvYTZG6vvuNOirbvNdCeg/Z2UjTDnMwmgMpLEU680XJT5SorIto2
 RPexJk+YLHg0+WPE4I52FbY1ry0FKH6qAPK2F99QNGDR/bxAil0ZhKQjpMxcnfW9QLZtJux9N
 IDejwh/2rfncynPkx+AKGVe9coPr3aBOcgBg9FaFM=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-857345123-1614251318=:57
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio, ZheNing & Denton,

On Wed, 17 Feb 2021, Junio C Hamano wrote:

> ZheNing Hu <adlternative@gmail.com> writes:
>
> > Denton Liu <liu.denton@gmail.com> =E4=BA=8E2021=E5=B9=B42=E6=9C=8817=
=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=887:14=E5=86=99=E9=81=93=EF=BC=
=9A
> >>
> >> On Wed, Feb 17, 2021 at 12:12:10PM +0800, ZheNing Hu wrote:
> >> > Oh, I am sorry.
> >> > Then I only need to squash the two commit, right?
> >>
> >> I've never used GGG before but I suspect that in your GitHub PR, you
> >> need to set the PR base to 'master' instead of 'jc/diffcore-rotate'.

Yes, that is my understanding of what needed to be done.

> > You mean I should cherry-pick Junio's patch to my topic branch, right?

That, too.

> ZheNing, the end result we want to see on the list is just a single
> patch, your 2/2 alone, that says "this patch depends on the
> diffcore-rotate topic" _under_ its "---" three-dash lines (where
> "meta" comments on the patch to explain how it fits the rest of the
> world, etc.).  As a single patch "topic", there won't be even 1/1
> marking, i.e. something like:
>
>     Subject: [PATCH v6] difftool.c: learn a new way start at specified f=
ile
>     From: ZheNing Hu <adlternative@gmail.com>
>
>     `git difftool` only allow us to ...
>     ...
>     Teach the command an option '--skip-to=3D<path>' to allow the
>     user to say that diffs for earlier paths are not interesting
>     (because they were already seen in an earlier session) and
>     start this session with the named path.
>
>     Signed-off-by: ZheNing Hu <adlternative@gmail.com>
>     ---
>
>      * An earlier round tried to implement the skipping all in the
>        GIT_EXTERNAL_DIFF, but this round takes advantage of the new
>        "diff --skip-to=3D<path>" feature implemented by gitster
>        (therefore, the patch depends on that topic).
>
>      Documentation/git-difftool.txt | 10 ++++++++++
>      t/t7800-difftool.sh            | 30 ++++++++++++++++++++++++++++++
>      2 files changed, 40 insertions(+)
>
>     ... patch here ...
>
>
> I do not know how to achieve that end result with GGG and I do not
> know if GGG allows its users to do so easily, though.

For single-patch contributions, the PR description is not turned into a
separate cover letter (per your request, Junio), but it is put between the
commit message and the diff as you illustrated.

So yes, the comment can go into the PR description (AKA the first comment
on the PR) and the next `/submit` will include it in the single mail.

Ciao,
Dscho

--8323328-857345123-1614251318=:57--
