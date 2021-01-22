Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16150C433E0
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 16:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFAFD233FA
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 16:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729545AbhAVQXi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jan 2021 11:23:38 -0500
Received: from mout.gmx.net ([212.227.15.15]:54337 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729568AbhAVQXT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jan 2021 11:23:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611332495;
        bh=ta1/y0YbQL1oJjT9MYCda/tu9sOfQHka1XT0zDewQps=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=DwZxjDOpcUrT/5oTJXS8rKHSrtIg7Zy2bP8LN8+hVXrWyRnJNKDH04qK+1qFQZEWU
         FaMD0xvW0TXbXiwyNf4yA5lK0kvXRHwgoCU7WUws2B0TNKhj4Fkp+8Kyv4UDR679aG
         ec2f35+BKr4xMfNiZRdc26nBvetB90hKJtQ1POSA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.25.115.203] ([89.1.213.153]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MsHs0-1lqocP1qX4-00tgie; Fri, 22
 Jan 2021 17:21:35 +0100
Date:   Fri, 22 Jan 2021 17:21:37 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 3/3] range-diff(docs): explain how to specify commit
 ranges
In-Reply-To: <xmqqwnw5am64.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2101221720200.52@tvgsbejvaqbjf.bet>
References: <pull.841.git.1611267638.gitgitgadget@gmail.com> <041456b6e73b3a88097d0cc06056eb43d35d42c6.1611267638.git.gitgitgadget@gmail.com> <xmqqwnw5am64.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:4BoWkHovQlflm82a6pk6vuL1lb9K0Q/QKGqm+yCY+X1HkSy4Ni6
 FLwzZ7R1NVmgTu6ef9aPIafTTry8sV2x99T0yIfuEZ988LFEestrOTZDFyhiduuU7+M+2w9
 8+mqd5zx7Ws6aa34mG+JVZZAfQ3JJqABdVoKEzp0JwI8V5J67RAbL+eD8AP/gXExhpxcMW3
 +VnOsstQ0gDtsc/vGUSPw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QrclgMGgnZU=:chxEyZYtwTTmHxFcEojpM9
 Lxrbw6Bw9AJvvOx9D9fdZNK14Q8UaAUfMEd+SoFF4yOmSjNxJ9n0OPLgKqBo2YwW9PNBg+84O
 jgOnXBVrYEyifF2F0/1I5s82RdbJqVt5BDhA/aYGYFfp7MdQrzAmR9bap20wL3D+ZQbCvGinH
 wH+da9vngwmp7+buNmTNwgx/CieeJZ6yzGWhwADrB+7cuH4aVRm1aBWIDddib8L95baqwdKVD
 XllqX6rBg0tNGncl2BjvjbzgKuvsTrORwQ8Zjvyv+NTJs9aej3lQPm7U0kEVUFlFuPJt9g0rk
 UeAaP6m/3beuWOKnE3gl7ctkRRrQNj8ym8K9cwhypHeKZRDnqIWWUdqk7059u7YTAKaxk3MKw
 edTm8BUWJ7I+cCUFRLNjRZm6kA4QW6VZChh70zx3wrccmxdLX7U7Iq/xRaTp8rjCA4wqrChAD
 EoIKTeD+yHIppCkSqz05D749iKa2OfKk13T7xBSQlmFZ+m6yGJG1Za+YsTTDWPrtVpxZoDX/K
 SZ5ieUjaxXP8XdVwTObootgTtP1xNYlr2EFKVBdR/kOUoTca9RNLHUcuyWMWAcWtC0IS6+fcB
 LNOGeZJ/yK3wmPVKW2j/CROIniyiGSlco3su1Hn2LqWPSZizAHSpVq++jYdlPNX/CGQmVYHdg
 t8gLUzzGiqUzmGtEgr5edLj4zo4pA3Mmlii29njfo69mKAecv1+Aq7+tLB7O4rg4P/QwormGL
 q6ce3Fx5Ro79hfbOBY/WYpMrMBp0pNWwOt297I3oIKVRSCilNRw9f4+hg7SGUyz4KJv4NzgLz
 eJNDcWuoGZ+JmTPPdv1T1EiH9EaPR4qsTcIqCnE41Qy9avOLTK2TnWRuQmBHPwHg5eQbxJFr/
 TF9HYcJEvTsOGBJLR9vhA/loQPD6rvWjw5+nEnFJg=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 21 Jan 2021, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > There are three forms, depending whether the user specifies one, two o=
r
> > three non-option arguments. We've never actually explained how this
> > works in the manual, so let's explain it.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  Documentation/git-range-diff.txt | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/Documentation/git-range-diff.txt b/Documentation/git-rang=
e-diff.txt
> > index 9701c1e5fdd..76359baf26d 100644
> > --- a/Documentation/git-range-diff.txt
> > +++ b/Documentation/git-range-diff.txt
> > @@ -28,6 +28,19 @@ Finally, the list of matching commits is shown in t=
he order of the
> >  second commit range, with unmatched commits being inserted just after
> >  all of their ancestors have been shown.
> >
> > +There are three ways to specify the commit ranges:
> > +
> > +- `<range1> <range2>`: Either commit range can be of the form
> > +  `<base>..<rev>`, `<rev>^!` or `<rev>^-<n>`. See `SPECIFYING RANGES`
> > +  in linkgit:gitrevisions[7] for more details.
>
> Good.
>
> > +- `<rev1>...<rev2>`. This resembles the symmetric ranges mentioned in
> > +  the `SPECIFYING RANGES` section of linkgit:gitrevisions[7], and is
> > +  equivalent to `<base>..<rev1> <base>..<rev2>` where `<base>` is the
> > +  merge base as obtained via `git merge-base <rev1> <rev2>`.
>
> Does this merely resemble?  Isn't it exactly what a symmetric range is?

No, it is not exactly what a symmetric range is because `range-diff`
treats both arms of the symmetric range independently, as two distinct
non-symmetric ranges.

> > +- `<base> <rev1> <rev2>`: This is equivalent to `<base>..<rev1>
> > +  <base>..<rev2>`.
>
> Nice to see this documented.

Yes. I was rather surprised that I had overlooked that in my original
submission of the `range-diff` command.

Ciao,
Dscho
