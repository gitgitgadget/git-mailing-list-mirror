Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B18C433DF
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 09:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 441FD2073E
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 09:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="KzB0Vcep"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbgGAJwT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 05:52:19 -0400
Received: from mout.gmx.net ([212.227.17.20]:37295 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729578AbgGAJwS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 05:52:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1593597134;
        bh=m2RDEKMSifQAsl4LxRNmdv9bMKDIeWfG9jfuedOXeWs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=KzB0VcepC3IRvf/4FRiEFStXqc88GykqSjs2z0jBaSnQtK9oWx+deYzmcDoOYYPGJ
         hLYGTdHoyJmYY+D+bFDHPmIbGGTPLzO2q5l0qAxcYyWs8+j9PvxTTn1hKNwZ0RbiGv
         2s7VE3S9o7VOm3tJltilDDevrnPITN4D6utfMI3Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.116.87] ([213.196.213.153]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mz9Z5-1iwFji3po3-00wBs8; Wed, 01
 Jul 2020 11:52:14 +0200
Date:   Wed, 1 Jul 2020 11:52:12 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
Subject: Re: [PATCH v4 1/2] diff-files --raw: show correct post-image of
 intent-to-add files
In-Reply-To: <xmqqeeq33t2q.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2007011149000.56@tvgsbejvaqbjf.bet>
References: <pull.654.v3.git.1593010066.gitgitgadget@gmail.com> <pull.654.v4.git.1593107621.gitgitgadget@gmail.com> <69256ab9107c3dba0dc007b69cc0ce98a9b91f9a.1593107621.git.gitgitgadget@gmail.com> <xmqqeeq33t2q.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:vE3Aw3XseAZ2p0DdLcfaBy1rhci1smyt9aS523yn4UOU6uQ223g
 4TQVAk7vCeHzwgcil73LFnY8/7aUZtArefpZiPRZ74r2F95xvkc3rdXQzTzOZWf8cy3LayR
 gn0Ix9wgE2wjpxIRVRDMOolG/vZMM4gEG/iplPg9NrNzNNoxX37L0V6tHJ3w/xgIIuKCx4v
 77L9l0uMRyokuWvdX5CXA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:S3NECT99zEc=:RXGmzhwUmecvRzA4g1Nd0L
 25bVGv7uTm0q/L3fMRxa6ATo/JqD7D5mtOoOPkvLCsSTuHKGtUS88sp0UvQzrYxpoMEy63M2w
 RHhgLQ1g+dh9fIqK4Q9rgRaO/YBGPMGm/XaDwdC7LOYQacP1+jKmde8t9ELymdmbMyF8DEzXR
 TXKjLu+mksGrsk9Jp1359Pnre2tTh4Jpx4Rxsl7uB7agddgovX2V8pdC25YSuml+dMIupORsJ
 0MEwHnseSrm84lqylgX5bvUnZoJr8sjSdWSNbt1hkD0u1Q9Q7DbbxDLp+PDiI+J2bC9vvwLS+
 vkA9kwyo8oqMAyQidJH5KPAIayG0XUuPn1kFe2uKUj2zADKXyYfL0tU3aIJMINqRnEtCOlFHw
 IAL12VIaL+K3Azjpj63nnHbrRwVX1L7PswdUXQ4mbEfSY6lRc5RVB8QaIg1/th13/p+5Wc4gK
 v3hRcjUlV9gACyOp3hSnOxrlQ7CBE4H1o7TaTSX+fE5aEqJYvCNywoTbeoLWMgyORHW8zGN4l
 /V8mfpt3oMde1/9YqOSc/U3x10ieO9t0z1wOdPH0PA3+ZIFpF6yX4j56N7XeOT/autr0id9zT
 Oa8iZ0YM7l/nuiu9I1xwCC7sm351gQDwmpPnCYEYLgtVa2zjP4dTxWuedxBQ9Lh6DbG858u6h
 YyxEovaoq3TsgDp1kuCd6RlH4r0QrVlCAGCX4yLl3/2jyIisZjx6I+Ux5cws8RDE4edgBXPND
 NltYUlRQOvunc0Ost39KgWJxQ7fMTSUosadv68yaPOS2ca6oaiWRw3VASh1QJafuSdVq9QFj2
 aJpAq05kbwMz8yxAEBrxtXtRAjpztp9QiodiEfN0jA4W/oeQIrZUYQIJW9IskeJs8VvWHaKtq
 PUt+5Iyu7bS/7lObWenuiELdyLSTKiTSdbKPa16XHpASXNV3lKNqIddnIglzI4dKcwYkvktTT
 ztAO4SR825SlhKAa2LL5NVHa5IPDZklAfaChpskCofxt22NIEl3pQidX/J0PosginR58rnk9x
 IqNqwtv8Vn8+YqyDC2+/GCeC8HHaW+RacgzdWZovEZHb/QTNkaR2C73ISElLDCLFp9zfA/iv3
 sSc53JMX87HvZlnf79kv1mr418WwhnyOmIXyv/gdvi7DG6CwfwdUz46c9DiHLM6oncmC7NQ9+
 kMf+Zc+4bIAbNjjXGeIy5PN4tW2CHhjdnvmRtcetTShP0QkItSGZFqjuMBDbb6US3wbmfoNIl
 dttvo2fMtnERyJZ+TLQgSZVvRCC1/uoFhOMRPEQ==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 25 Jun 2020, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > The documented behavior of `git diff-files --raw` is to display
> >
> > 	[...] 0{40} if creation, unmerged or "look at work tree".
>
> "on the right hand (i.e. postimage) side" is missing, which is
> crucial in this description.

True. Sorry for omitting that.

> > This happens for example when showing modified, unstaged files.
>
> Modified I would understand.  We notice that the contents on the
> work tree is different from what is in the index, and we tell the
> consumer "look at work tree".  I do not think you meant "unstaged",

Right. I probably should have written "[...] when showing files with
unstaged modifications".

> though.  If truly removed from the index, diff-files won't even know
> about the path.  You probably meant "removed from the working tree",
> but 0{40} in that case means totally different thing (i.e. it would
> be a (D)eletion record, so 0{40} on the postimage side is a filler,
> not even "look at work tree").  What would make more sense to
> describe might be
>
> 	This happens for paths that are modified, or unmodified but
> 	stat-dirty.

Yes, but that includes more than I wanted to describe because the
stat-dirty does not matter for intent-to-add files, and I wanted to point
out the analogy between unstaged modifications and intent-to-add-files.

I noticed that you merged this commit into `next` already, so I am
assuming that you do not want me to send a fifth iteration ;-)

Ciao,
Dscho

> Either case, we tell the consumer to check the "work tree".
>
> > For intent-to-add files, we used to show the empty blob's hash instead=
.
> > In c26022ea8f5 (diff: convert diff_addremove to struct object_id,
> > 2017-05-30), we made that worse by inadvertently changing that to the
> > hash of the empty tree.
> >
> > Let's make the behavior consistent with modified files by showing
> > all-zero values also for intent-to-add files.
>
> Well described.
>
> Thanks.
>
