Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B4A71F4B5
	for <e@80x24.org>; Mon, 18 Nov 2019 20:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfKRUwR (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Nov 2019 15:52:17 -0500
Received: from mout.gmx.net ([212.227.15.19]:33557 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726237AbfKRUwR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Nov 2019 15:52:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574110332;
        bh=1lFpGRFlo9zI8Ndqgcxb+U8lgOC8OWswWSbo64+fm2I=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=gKcHX9hDcreiUD77dqXBxhU+j5MqSyRA2TX2j3vyg7ghqNbCr/wVUyZ2Q/RZ6eq/n
         MVvQmN6IbFEw/n0mZEtdrPdjzXtAmZjpBFNPgtgusIIJqzijWm4NkKwhfUwwj/TQui
         leslAK0lnBDE4LbGJr8cLkP2spYmh5Xa/FR8uyZI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MCKFk-1if5jC290E-009ThD; Mon, 18
 Nov 2019 21:52:12 +0100
Date:   Mon, 18 Nov 2019 21:52:00 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Doan Tran Cong Danh <congdanhqx@gmail.com>, git@vger.kernel.org,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Subject: Re: [PATCH v2 0/2] Make git rebase -r's label generation more
 resilient
In-Reply-To: <xmqq8sod3l5a.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1911182151450.46@tvgsbejvaqbjf.bet>
References: <pull.327.git.gitgitgadget@gmail.com> <pull.327.v2.git.1574032570.gitgitgadget@gmail.com> <xmqq8sod3l5a.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ZJRaNfFEEp2/H0WmT5LqdlHyQogGx+AEUSnbRkjXyLzZ0ZnwvMP
 dof8B8H7KsrOdY276x++GIksiS6y7MbLZLNQjJB1cgbjhORs+6H7X1W5cARFD/i4C4foZOs
 SoBHpmp6bOJr7fxuVHKvPma6y1CZfIsZIg589kA/hoSfSxWehEyOPrvNguC7ykAN6iucMNW
 xwdXYCEvbu4avQ20PfHCA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pJZaLFVq5Og=:aQNr7b8kzD3Op3KfBJ/EKc
 wjGQZEVlDjZNxQZXO7lkDxq4IFibU78bZqq0j6G1kWjUWtB3lYhTuQCf1UqCFZ3rU1cxdLgQ8
 eMXXQ3uYgTGGSv8OsYyQ7yv6M83diVS0Tm1BQu0BEveZutlyUow4XcNH/AOhUfG8Tg69WTCAf
 MTdZ1Eav53YL+aWU/eMoT66trmXQca3xgr9j38IHJKpbJPfTG/J7ahLzukxgrq5l/JvvaXllx
 dXXJGTOeP7a/XtbzLGxuQKXwIjsqhT5ks0VMkItHjuF/t1eSSk0bsfqc+2h510GYJMGiDz+6s
 ezWiTxpSTdy3ZqhYJ+uJAjkBIlIHnYlmXuF5yywGS4qrx0KIrCWGC9ZCSPslzumMY1H4NVXOX
 Fcyz1qsX01MVE2Ukh4pRbdW/bxgwHk52v3wu8b2y2D2XYqpzHAiTECXkmilsXBFdFX1bEbEpk
 D2EnSwEZEaKqaQ0nhKnSc6Q0EdmutgmH4CJN9/UOstfATA52v8vMD3Rky29t0ZKBIgIQrWhTB
 yKr2tpMFOmp75p4h0CFEmJC7s+ne/8TDN5scWi/eR6f3thFpekPo4tw/CsA7fSqS70ZNCEwKR
 qBgbEYVzmMNLv416LYizpPtmv0fsEBtUCxM49OrJQ0mlJ5SoekIOvoPxZudbKTO7tIy5UtKQU
 DFh1uaIAhN3VCGAUQ5zvqJoG8yUbkmpucxrMpIxsmGL2H0lHji6HGQSFqq2OMLUM5TLBUbO44
 dNIkYZEccwZkKjLmS/XSb/zdLv2KylG90tSjii/cwnjq9FF23H/tFloiTAwX5MBtLiKwekeKq
 4OT/1MJ65Mv8qtdPPcej/VLixAO8/surbZtNL5fKzzlANa5lvuGu1uwHpKJmHIH3NPyTGEB2q
 kNcRxuJdI0We96WwDdaject6N7Wao0J3OE9Ighv3+mtHf6w1Vfb+6RfPbzYSdBuaG6PVXLe9R
 2cD+aFusasNHlJHcb2nvSNFPhLXrsVQoX/6RKIPonaVzzuFn6EBg8wNoh0g4skcv6rfN4hFVT
 L+7JuCSgHmkDknY1BPjCwAVvRAQ3kwkIuxtPg0wmNpQWE2qiY4mbJb3e6uPuErEtTEp5phPt+
 nF2WIYSub90WKtlkn+m2A8LlHT8nuIFdk2FY7clxv6aK7vJfDM4Tbpde/ZxYcRcovozp/LLfo
 u7/gHnMWwhjoK9s09+ozKyDpkW+NgMeFM0iIUI/RlEny4KPCkXSbn7DklCFJVvpYdwYCBJIZA
 1HfO62cEwX66jppd+Jm8uCy18KtaTYQGPKAWfku0Q7TsBeH5OV2U481HvwdE=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 18 Nov 2019, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > Those labels must be valid ref names, and therefore valid file names. =
The
> > initial patch came in via Git for Windows.
> >
> > Change since v1:
> >
> >  * moved the entire sanitizing logic to label_oid(), as a preparatory =
step.
> >
> > Johannes Schindelin (1):
> >   rebase-merges: move labels' whitespace mangling into `label_oid()`
> >
> > Matthew Rogers (1):
> >   rebase -r: let `label` generate safer labels
> >
> >  sequencer.c              | 72 +++++++++++++++++++++++++--------------=
-
> >  t/t3430-rebase-merges.sh |  6 ++++
> >  2 files changed, 51 insertions(+), 27 deletions(-)
>
> I think Dscho meant to Cc you as these two patches are meant to be a
> more complete solution to supersede your [*1*].

Whoops, totally forgot. Thanks!
Dscho

>
>
> [Reference]
>
> *1* <860dee65f49ea7eacf5a0c7c8ffe59095a51b1ce.1573205699.git.congdanhqx@=
gmail.com>
>
