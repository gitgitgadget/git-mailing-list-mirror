Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A559DC5519F
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 23:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C297246D4
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 23:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="BDeLKFSv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgKRXNT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 18:13:19 -0500
Received: from mout.gmx.net ([212.227.17.20]:34477 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbgKRXNS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 18:13:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605741193;
        bh=hEPmouVPMg/FCwUZXStNHI7X7gerB2JPGwbY66Pbh0I=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=BDeLKFSv0cEim1qMG+rE2ER5gRzdDgcL3QLIO7sBXXAsMph60nLmiO5bZ5uEV7ZRC
         miqmVgFemaL+AtJbIUb8z5n1/L24b48ggHqPVX+rix+BTq2ax3IrxVsHS8qqO29fCd
         Ns3SN91/h/qUIr98gGR87iFR3Jv+I3f4kSpZilAg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.22.105] ([213.196.212.61]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mxm3K-1kL7PL3182-00zG9u; Thu, 19
 Nov 2020 00:13:13 +0100
Date:   Thu, 19 Nov 2020 00:13:13 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] t4015: let the test pass with any default branch name
In-Reply-To: <xmqqd00a1knr.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2011190011340.56@tvgsbejvaqbjf.bet>
References: <pull.794.git.1605727594021.gitgitgadget@gmail.com> <xmqqd00a1knr.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:pcES63s4QgDFxXIS6XGJIIvD4pN6s0OeeR71uJIdtc79ABni1Mh
 hobaeAwwzpn3SL1+LebVfyqAogRTnDMpsDF+Rk5+noDRJDlSIHH6y9tzIAf/TadgCd2IUp9
 JTuUDwfDOUmJm0z7gyC6YowsDDTR1BQc2DDkaTaleFBo1p/gKiApCIkf0KDXLGjnai91pr8
 KmVngPVcufoeKKM5L5ZdQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qS3c0wSWpHU=:FPK4gPlZ+vgk97mF1aio+S
 J/EyH88HuslAX2dmOjLCZbLyF6sENfkCuVnuJhVXi+3rWrQFM5LZ1nUN/G8ed/JNlQysc4EvM
 HOEchjHvA4k6iQiVUQCIXVBQj2+dwVumQAYNI5aGK4eCXefQCTLLBtRDl7y2mAJKHNbRR96PY
 IdJ4eaTrlK3ETnM/qFov+1H8YtYZUD2geil5DS2g//kbya5OlHghSGeNACkGK/QxX0yg8A4FZ
 gBgK+TSoQHsQaGPSLpc7Z5Dh0GdEXwkkD1/jQ6Bdz6NR3B9xF+1zbEpPDrtTlfI3+gGpTwtLr
 KGStFlrtAR6hKSA1wlVqUAQ4Qi/aNSEur50aOPKykPcKjlHpMWnRqD4xULRzmIhAUXesx1XHl
 7zkeUyzPSeYZudfv5nF3lxMQmI6vBnywOoSwTge2xLeRmudC2kBdsdBf5X8+PcneEvN5VS9Dy
 1ZIcghT7+4Fzvakr8TRlAM2K4A7Lk1S3/2JN0uI9gADN179l7VKszJdC0uRSgkmScfVv22bLo
 vrWfRwMwIUs81y4N0d3qR6edBaxzNjaspD+32yG5+uc9QoA4mPXxke9Z1sqY3cQJrfB1rWAwi
 dtGOaoRv+NZnBbgcr4Vk9qtoIO/fQ3vr3bpgRY60+p0M9clnZXnCY8nBaSzK2rNmm3Fy9RxCN
 Le/xF+tXVmRp4+tCIjmLuo0/8VA56xRaSc7v/lsAZ8YoRIvpsDi/cm1MKkb+AHDRDez11RohR
 cwIRJCAxKN6iPLr44fHWZbDNRq9I9mOenfxi8CRJXd8pu2PL3Ct//DmgG6EZyMuxuRWZ2sxmU
 9bdrsOW9t/ZZCc02v6uuPS7sfCjJHOfiMKfTC92+ZPktQb0h7X4C33Pp6Fl3X6RQPNEoEV34P
 7+sfff/QNrbLSvH7F4nTnMyf93wHkvYZ/5p8yIRN0=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 18 Nov 2020, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > We do not need to hard-code the actual branch name, as we have access =
to
> > the reflog and can be a lot more precise at what we want.
>
> I am not enthused to see us going beyond "@{1}" or "@{-1}".

Right. It also makes it a bit harder to understand the test case for the
occasional reader.

> It would make the test a bit too brittle as a future changes need to
> refrain from creating another commit and/or switching to a third branch
> to do some more set-up before coming here to attempt an merge.
>
> In this particular case, "git merge @{-1}" may be more robust from
> that point of view

It might be _slightly_ more robust, but not by a lot. I opted to use
`test_commit` instead and then refer to the revision via the tag that is
created by that function.

Ciao,
Dscho

> > diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
> > index 8bdaa0a693..c9dd62b70e 100755
> > --- a/t/t4015-diff-whitespace.sh
> > +++ b/t/t4015-diff-whitespace.sh
> > @@ -883,7 +883,8 @@ test_expect_success 'combined diff with autocrlf c=
onversion' '
> >  	echo >x goodbye &&
> >  	git commit -m "the other side" x &&
> >  	git config core.autocrlf true &&
> > -	test_must_fail git merge master &&
> > +	test_must_fail git merge @{2} >actual &&
> > +	test_i18ngrep "Automatic merge failed" actual &&
> >
> >  	git diff >actual.raw &&
> >  	sed -e "1,/^@@@/d" actual.raw >actual &&
> >
> > base-commit: e31aba42fb12bdeb0f850829e008e1e3f43af500
>
>
