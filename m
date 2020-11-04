Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 202A7C388F7
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 13:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEBF120780
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 13:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="bO/9XCMX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730001AbgKDNXF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 08:23:05 -0500
Received: from mout.gmx.net ([212.227.17.20]:56005 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729996AbgKDNXF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 08:23:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604496177;
        bh=y2Zi3gNaGlyiFac+23mRl5KshOtVYLwYGT/c53YtXYY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=bO/9XCMXYgoMc9jlW0U1NuEvXR54AzbYI484OdW4Rt1RwPaaCtx644+efyn4aY2HA
         7bcontMZGBamsTX7rmoPemxtNzlUvlRnmdsl2XHEO1OsqRwUDsKpLnD62av7n+fSSx
         LsQ1zK/5glVggLYpoXXAiy/boTy/MlRPlETlzt8Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([89.1.214.166]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MfHAB-1k7ISI2xqd-00gowu; Wed, 04
 Nov 2020 14:22:57 +0100
Date:   Wed, 4 Nov 2020 14:22:57 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Alban Gruin <alban.gruin@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: ag/merge-strategies-in-c, was Re: What's cooking in git.git (Oct
 2020, #04; Tue, 27)
In-Reply-To: <xmqqv9ensao7.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2011041422120.18437@tvgsbejvaqbjf.bet>
References: <xmqqmu079rbv.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2011020333440.18437@tvgsbejvaqbjf.bet> <xmqqv9ensao7.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:oA4Vg8QmnxwJszBXZl3EePjWFxL/TiaJeNKXGjWleMbqe9OX8Be
 wHBGKLVtm4qh0GbE2z9NXAwI3SxXHkhGUf7iB0ZsABXZ2U1avculoWpd3NEDjf2U3oxR2Qw
 pntWqLbfzRTP2myF37kvuhVHmEi/H2mu/chUmnxWqvLRn2RTr2SylBHl747CgFdBZWgEW/M
 4UEU1LNuqr+rFNv3O9Ncg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:M/cprMowMtU=:beBeWwAa0jdMNnmkWvB2yp
 pGldQ4XSn6pN/YWd8MGMncpr59rM8aLdB4N0j+BENZx3BjQ26IDu/dQwae0TjYdnM068/9SHa
 Mb5cX8Yw/ETEkD1ovnmLVTMkDOBsUxLfps3/g5Dd/LS1TscE9opjqoZcL4Vcl8MhgwUR52ufM
 0XBlvIug6HFEMlwbZQ0cTjSrpzgbFi4D34O5xBLPhJL0gD0lCtsr9GFxu8xVqvRswnX6WaH0k
 NlQ8mma7sN+GPtWUlMClgWE6uXNzxfqfd6ZO5Tr62zFh8O6drHXLWSgVNd5oMuRxjCGYwtDhc
 tsgB1qYLTJkgzd3A8DAK0/HKQdSwatlzngPDQlxcDV+dpVNHqM1Tiysl95yX24jWmmJZQNG5D
 7Hr3XTFtBR4x5brj50BeeU8cX3QQGMefnjnsVei+W+Hrc8m4owsr02XnTqxHsLQOzF6pI7yxx
 S4KjJJOhfuOLNE90sQ8WHv2+qGvbYhYW55hVmKsRjrDZ0b5rpr7PPr7tMD6f51ZYuwDQQ/lwY
 876RjbE/9i5ERmT4fnDUmfdkflcb8kbsNmmZ/oVg7rtor+Q2I6ElY++5jVfIpoJIMx5f7wSQC
 kUaA3ndNDuWdYKeGiB+Ie8wkkomnUexuJpL1i8iSpCylDxHdFegzaESTsEXD5rt8oOINcVi5+
 dDiJkIrn3cfkXxzgrj/6otUYsFRmoMTW7gZyjTOes9qL5R8zypg9T6uMAbN74MIQQciiefB1X
 gcjZH7xHLxbSMqkMGIc7NZ7RamWYaQmYHgUoWLzFSemJLh1ZFaS/zP6qyVkz93UOWa+UQNRjf
 xe4W2ZNVIHv3kMWBSxzB5xd2am9elP3eh8hLg3Ttsv01+l/f3cLC4DrONk6YcYM7dvixyHCqS
 C/RVypWsGfyoNC0hOgjt82tAF6X7qmPB06XjBVdZU=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 2 Nov 2020, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > On Tue, 27 Oct 2020, Junio C Hamano wrote:
> >
> >> * ag/merge-strategies-in-c (2020-10-06) 11 commits
> >>  - sequencer: use the "octopus" merge strategy without forking
> >>  - sequencer: use the "resolve" strategy without forking
> >>  - merge: use the "octopus" strategy without forking
> >>  - merge: use the "resolve" strategy without forking
> >>  - merge-octopus: rewrite in C
> >>  - merge-recursive: move better_branch_name() to merge.c
> >>  - merge-resolve: rewrite in C
> >>  - merge-index: don't fork if the requested program is `git-merge-one=
-file'
> >>  - merge-index: libify merge_one_path() and merge_all()
> >>  - merge-one-file: rewrite in C
> >>  - t6027: modernise tests
> >>
> >>  The resolve and octopus merge strategy backends have been rewritten
> >>  in C.
> >
> > From where I sit, this is ready for `next`.
>
> I just went back to the thread.
>
> https://lore.kernel.org/git/20201005122646.27994-1-alban.gruin@gmail.com=
/
>
> It seems that the topic saw quite a few comments and help by Phillip
> Wood in its earliest iteration, but I didn't see any review from
> those other than myself on the last iteration v3, and the review
> comments on the iteration haven't been acted upon yet.
>
> That was why I threw the topic in "needs review" bucket.  The later
> half of the series got no comments (I lost steam after reviewing the
> earlier half) and I suspect they would have be adjusted for fixes
> and improvements done to polish the earlier parts, so I am not sure
> where your "ready for 'next'" comes from.

Sorry, I had missed your latest suggestion had not been addressed yet.
Maybe I am a bit over-eager to get rid of those scripts...

Ciao,
Dscho
