Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E74C433E0
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 16:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C10ED22EBE
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 16:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbhAVQGi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jan 2021 11:06:38 -0500
Received: from mout.gmx.net ([212.227.15.18]:39777 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729357AbhAVQG3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jan 2021 11:06:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611331493;
        bh=o34h/zfvlHOLxIgxgahCVDI+AsA8SfDF0qHCM+75n8Q=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=BDAs2UkCiXEmJ83MkfXwoIJVhzQsMLOwjjTDkwUo8nOfE/2QRrobyFXBWvLZE5bYJ
         W8NSdgs6WJWplVpOAS+zkWMH/n2o+NM63RZ73P24NOzv2g3vyp1LdTNyu8dQG6Gw8U
         5wuLwkzsP/dGCQ20tjC0gRUJrpDdVZXBXFdbaK2g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.25.115.203] ([89.1.213.153]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MhU5R-1lg96U1e43-00ecyy; Fri, 22
 Jan 2021 17:04:53 +0100
Date:   Fri, 22 Jan 2021 17:04:55 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?B?6IOh5ZOy5a6B?= <adlternative@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 3/3] ls-files.c: add --deduplicate option
In-Reply-To: <CAOLTT8Qp2NMpbk56U6PVEmFVyZYWN6gM83HD4z_nmPWV4Z_ruw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2101221702420.52@tvgsbejvaqbjf.bet>
References: <pull.832.v4.git.1610856136.gitgitgadget@gmail.com> <pull.832.v5.git.1611037846.gitgitgadget@gmail.com> <e9c5318670658b032ba921129859f9fb3b2ca017.1611037846.git.gitgitgadget@gmail.com> <xmqq7do7fggn.fsf@gitster.c.googlers.com>
 <CAOLTT8R=fF00WCVBSTDKHG_3p5RcZaxM2AU-cUj1sNWvy=mhCQ@mail.gmail.com> <xmqq1reec943.fsf@gitster.c.googlers.com> <CAOLTT8Qp2NMpbk56U6PVEmFVyZYWN6gM83HD4z_nmPWV4Z_ruw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1775346365-1611331497=:52"
X-Provags-ID: V03:K1:5sZrAcj1cpOSdRn0q9L0oi/rW+3DMcHbSKttEJ9o4aEyBzRJbvx
 wfFA2tX9Pa+lnCmDeAM0m1skfFWlLP3yJVQYsNoVHoPpebonFhHd8HjY2X4r3XuoaHSfHtL
 a/SGlSf9xNrzXm8yLpyTq8wk6gHhyiSE3Knc7fG2ekVcKOuCczmQ+xFW3D74/6y/V0cCQk9
 XE2JxqYTkSfckUvgjH8Pw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zaklC9rlqGQ=:2Y2BiwViUc+3UnsxCxKIwY
 jjJVX/+Cy/uGfsARg7jjMT6vFJ9Mlku0viA4SdbGblY13XZzglnlXfnwGjLetgCtT5sYkMX0R
 +4pbXGAGy7fx3VQUsv0MNiRd+RZHsOX2SJpacDXESVJPsB/fN4fXCrATxSzwe1zL9asLdYwRw
 flEmM0rIxJtncl/YJKc5kTzqu34xnPEdRAXuvOT3XM712wTqE9eoFC1SGPnwxI5R2uVW521oE
 xnMF5DPkJjdJWsFDGRLLOph7aD3K6CFBHsuqZM1Cl04DC1VopdJG2h5RVptDDbp2bAXbTYH4N
 pOCx4Do5+67n7AwOCIb4+4/Y2wtyWHr31+T/Tpb2ye8PmpGUHHo/PAIv1F6pXHAIhOXwkA9Cr
 Ul2G7PykgXgAfGw5fMc9C3LPfhVB6HPpHr3XsUVSa1QZZ7L69PD5Gb3MjTMQXoR/Da+2yBiFV
 qD4VZGJ9ZT5oRAuXUxq82GA3uKc49oh1qwPX4vlv27Dam/0tboe+4YlDGd3WxOxMzP0YX8Nw9
 tpYnALEduimioQyfhTdeLBFmxyxywGMoWxn368FuMQa+Pnhlp0or9VwQd5fI84IhEXzpft3B5
 xzFMeVpWoKUscj5j2HwKg43xc/QkPqAo462ttYpttaCGRRErN7ZuVqn0qKdpm9bNC2TNsw3N0
 XFmJxwlg3/kzdCpczAQxr1b9qQwuE7D/8xd19Pboe6UjyyAaD1p2Rpfioxvap9nJvk+TZSlrZ
 JCSvH7cDUpIMk6UabxW6+gSmzblKExd0GKui6qqg8QKKriwajHzss/MnM0U5P+7ZyUanmju5T
 Ffn0BEwhMskZ0cdR7dHTmMLIYbp4mhusxP+XxJBAw5+D40OVs/kWM8T0wCuVdJp6JMyCp4Ko2
 tLx3RViRnPZy95p2T5dik/z/SDsp47c5MRV0rAJsk=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1775346365-1611331497=:52
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =E8=83=A1=E5=93=B2=E5=AE=81,

On Fri, 22 Jan 2021, =E8=83=A1=E5=93=B2=E5=AE=81 wrote:

> And should I still use gitgitgadget PR on my origin branch "dedup"or
> send patch on branch "zh/ls-files-deduplicate"?

The way GitGitGadget is designed asks for contributors to adjust their
patch(es) via interactive rebase, implementing the suggestions and
addressing the concerns while doing so, then force-pushing, optionally
amending the first PR comment (i.e. the description) with a list of
those changes, and then submitting a new iteration via `/submit`.

Ciao,
Johannes

--8323328-1775346365-1611331497=:52--
