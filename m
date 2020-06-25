Return-Path: <SRS0=4a08=AG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E835C433DF
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 13:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B4AB206FA
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 13:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="cj1R2nIb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404709AbgFYNGI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Jun 2020 09:06:08 -0400
Received: from mout.gmx.net ([212.227.17.20]:59937 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404285AbgFYNGF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jun 2020 09:06:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1593090352;
        bh=Y93NVeGdRXq4njeqsdY8n+tMu78YtRnHRl3bMRHGBBs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=cj1R2nIb5UCeP5s17uMKLVF49wWpIPhqcws1MXGGlsOCAl+/JsDWpNOhob0NNLqGl
         J7dPzsh5M8kr5nSK6jGSUIcxVBocy2nNsmQC0Lb7ebS/3A3ynuATdckUjeDJUlELhY
         tpmaK+YD/f4ZCqIxZWlPh+1Zw5+4mQifX4bqXWIU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.227.237] ([213.196.213.24]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mf078-1jDUGL49RC-00gZhx; Thu, 25
 Jun 2020 15:05:52 +0200
Date:   Thu, 25 Jun 2020 15:05:53 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        peff@peff.net, sandals@crustytoothpaste.net,
        Matt Rogers <mattr94@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH v3 2/8] send-pack/transport-helper: avoid mentioning a
 particular branch
In-Reply-To: <xmqqlfkc8o57.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2006251504120.54@tvgsbejvaqbjf.bet>
References: <pull.656.v2.git.1592225416.gitgitgadget@gmail.com> <pull.656.v3.git.1592951611.gitgitgadget@gmail.com> <a29943d7bbc11a524089348a4abbd33c7514eee9.1592951611.git.gitgitgadget@gmail.com> <xmqqr1u59u5f.fsf@gitster.c.googlers.com>
 <nycvar.QRO.7.76.6.2006241443200.54@tvgsbejvaqbjf.bet> <xmqqlfkc8o57.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:pW0zBXGhIXyWBr3WKAAUMP5F3mWcQghmuR4y4/pm6VXwsCSHDM7
 eRhoyKZivtzcGKUmC3Z/QnceBrQwl/HNjLFLifEPxS5cqSAMsxvsI0f/VrAOJV8boqb3sPF
 80kZGN7G2D5t7DATHTUiq8pqTs/qp/iSiVDO2ym3A5hO1fEfAaHQEmhDeMcFmXr1jq2BTY4
 HQdn3MJOQWV6BMzBzuviw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:y3ejjr46tBo=:aCSryf96Qi0Cmvlx+NCSxe
 DTeSyzkDYL00lva5Gc86QpqTHagV3//YUg/2WKRFZ2lrczRYbgOT1XEsW1iW1iQmu7mSo1L2B
 iQjtj5CmsfEcJOP1/F5jMtEnZdeuRanxCNX7eIO4yRmaDlg+xE25c9dwDHDhIr2UmRujO0PVZ
 mO9+YS7qE3pM4k80ycgqpQKYegy2zfuGYty6ePhWi+9ddQjSgityB0fPcgmhilVDWP3wwCR9M
 HArz8VMvrgz+pNOFOMYG0x9bjLqUG3ox+pEjZ4zd8boDIRtGOSgMTHZquOboNeoKJOsa/GGi/
 qZNBo39fpw0qcGiHWFJvnkcMGTvNTc+sd1ElhiKRzz497FfD4TJSsYfEy5g2Jf5AIzwDYTBnf
 D+IV/Ul5k8wVRDEyq+Ww4WvP4tw7280KSqZblGtTZJ6gNkQTqtX29th79XOms2XUBqgLME7xd
 zjuAF/YY5FeY3UtdEO5Bl/W/sI6K5YRRFd1sRQdAg/c/HMGaNO3Zc1bdxAvZfQdHpB7TNjC+/
 zk4qsXvJKuVhlVZ46qu91oJuX+Yr3zB9dLOg3Rjh+fZyYyUqaU773y2MvLwwOqviId1HmnmKY
 aEDOzgaxLRmpnUNyCHH/sZOntUGP3LN6CnaPeMBn4TpiOI1No+IByOXmCb2MPtTOLvGQaD8WI
 G8q7z3o59EpYimdnSJ3Hxjp6TA9rot7cDC07JIr0f/1fHYVTDczfyI4hdY9Uve0IsYUVgiuSW
 fh3GwJ3LLp5ocYxzTG94qkM9+nm/pkkMxOdYkTFV2cuVAmBLwZVdk5aMhC7IrsYGAGNu9YZHG
 I0CyK52FL5qZtJeQqv2jvHG9uoLtKd4sgOpFVshmBsIPQrielF2R4hHXDqEgP7CAr31osOtdm
 MQGW31sHEPKZmrgo/gnshqX6Ep/JhI6o2klJJpuME59cePWqkVR5OftAQtcwi+YT0OtNXVZEX
 qGQvJ4yySuzyj47UyQrVxolIPvM7iWG/LdatAID3ndrs3n1vg7SSQA5e7Eiyu/um1vVuukexw
 MjfE6pyZqF2dUikTjbmXZYW3rj08EDEVTDwW1Y+qJIOb39+ZFKdZcuzUvbj54an1Vz8X5T2BX
 DfLzUpMLvA+VP6O5WOOWvuHQ3MjL85GdqXHRRbgMfp3GeiEquiBxdvTvDirHawuddyTUFym6R
 ZypzlwnvKRO2jjvnnNpkzyE5KNHcyCa2/wSReoq/bBFZhsEnRQltSFwVst/AZntJ0Q57V5C23
 dRlhMaGfjaYA9/DeIPj4osR2PRXaVtSxOkeOrvA==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 24 Jun 2020, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > On Tue, 23 Jun 2020, Junio C Hamano wrote:
> >
> >> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> >> writes:
> >>
> >> > @@ -1046,7 +1046,7 @@ static int push_refs(struct transport *transp=
ort,
> >> >  	if (!remote_refs) {
> >> >  		fprintf(stderr,
> >> >  			_("No refs in common and none specified; doing nothing.\n"
> >> > -			  "Perhaps you should specify a branch such as 'master'.\n"));
> >> > +			  "Perhaps you should specify a specific branch.\n"));
> >>
> >> Hmph, not just "specify a branch."?  Maybe it is just me, but
> >> "specify a specific branch" did not roll well on my tongue.
> >
> > Oh well. "Perhaps you should specify a branch" sounded too judgmental =
to
> > me, but I'm not a native speaker, so I simply removed the word "specif=
ic".
>
> I'm not either.

We should start a society or something ;-)

> Note that when I say "maybe it is just me", I usually am not asking to
> change anything.

Of course! In this instance, your suggestion made me think and prefer the
non-repetitive version (because let's face it, taking out that word did
not make it any more or less judgemental).

Ciao,
Dscho
