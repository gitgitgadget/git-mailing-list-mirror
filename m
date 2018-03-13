Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EDE11F404
	for <e@80x24.org>; Tue, 13 Mar 2018 18:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932255AbeCMSYJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 14:24:09 -0400
Received: from mail-wr0-f170.google.com ([209.85.128.170]:38089 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751556AbeCMSYF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 14:24:05 -0400
Received: by mail-wr0-f170.google.com with SMTP id l8so1624542wrg.5
        for <git@vger.kernel.org>; Tue, 13 Mar 2018 11:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=7G0LvwOGtyRF/ewK9+Ni7IOrMBUEwKS+KgJMdWYZJaY=;
        b=ar9x+Z+WZOSsR8+VCEvGy2YboTQZl0VmNEh44xP0H47RJsgJPsbf6q6GDkc4OLYKDW
         C6r8iULhY+8YrzQ1FfOTP2bDBzQlCLrtU3zSGtBNEhPUZm//8k++qmIeUH56YWYyU9JO
         fZdu4lsRgUqSRfBXsrs29j5Ye633/M6j2z2U7OICuVQ3PZFsjHk7gLQYrUqjylPrSD5H
         5BBGYMCrUSUlW9BlBiyJlFac88MXJKTO43cck398CIV+d0WsqEa/RzaHJbmmxxK5+L1l
         jUAkGKYURring4A40u7vDuBHDT1o709t0qbJbqDaouMhJJctNuCtohd5rSeyPoAgQUJq
         SU8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=7G0LvwOGtyRF/ewK9+Ni7IOrMBUEwKS+KgJMdWYZJaY=;
        b=SX9EO7Ou6va/aB26fBCut+yb8lbaaanegpS7ckKbHS+W7TVuvGL3E/dPK8CRJ9KY3B
         XNH4cxWhy+OCPqE/LbmqpsIkxvInds+GHlXFonNbb/3ChHeWwNb80NNY3oxgoiK95vS4
         9F7RG6Mrhz37O2XTuFg+mGfG/kSa/9q2fIev/MP+fPwrSQ9aLBEUyeRDqVIBeE2eMRTn
         lI0NMOCiXa1ThsXqKUOMGZWmn+ZyU/bL4d8R4/vbt7rXM0staEJJd+YYZf4zh/x9l5Yy
         I6fYFidVyIK69dqDbP/ptNeDdK0VXRZOLAZPaxkv5z4NQs4KqZizv0UVLXJhtyuOFZ0J
         Ox4w==
X-Gm-Message-State: AElRT7H/MCcQTTtdHR2axxV1tmJ5HPhavxLURJq9EFu5ImFeTPE1XTvZ
        2v5dOOiyD6MvyuitbHzErxU=
X-Google-Smtp-Source: AG47ELv3dTqp2MaTTdBOvv5QqCa6U/TmJyzY3rd0HsFWDGE6X6C64C9Y0AVMyUEpU4r1t5QAeWTBUg==
X-Received: by 10.28.237.19 with SMTP id l19mr1523769wmh.157.1520965443735;
        Tue, 13 Mar 2018 11:24:03 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id n7sm1126150wrg.20.2018.03.13.11.24.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Mar 2018 11:24:03 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Phillip Wood <phillip.wood@talktalk.net>,
        Sergey Organov <sorganov@gmail.com>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        phillip.wood@dunelm.org.uk, Git mailing list <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution (Road Clear)
References: <87y3jtqdyg.fsf@javad.com>
        <bbe64321-4d3a-d3fe-8bb9-58b600fabf35@gmail.com>
        <nycvar.QRO.7.76.6.1802270051470.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <CA+P7+xq8UUcLWomUi=PS_hTKfJd3dMAxMmhioDS1bixwcmKAqw@mail.gmail.com>
        <nycvar.QRO.7.76.6.1802271718090.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <4d7f3406-b206-cc22-87df-85700d6a03d9@gmail.com>
        <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com>
        <940d959d-151d-68dd-0f13-320ebad0d75b@gmail.com>
        <87606hoflx.fsf@javad.com>
        <0ac3a3fd-4053-e32e-75ed-8829f22c2e1f@gmail.com>
        <87a7vss6ax.fsf@javad.com>
        <6c8749ca-ec5d-b4b7-f1a0-50d9ad2949a5@talktalk.net>
        <872944c4-ca97-9f55-a424-86d1e3299a22@gmail.com>
        <87h8pvm7zz.fsf@javad.com>
        <ebc73962-8dff-520c-e19d-8fcc1ef63ab0@talktalk.net>
        <xmqqwoyp5eig.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1803080804420.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <xmqqbmfzx9n0.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1803111248200.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Date:   Tue, 13 Mar 2018 11:24:02 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1803111248200.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        (Johannes Schindelin's message of "Sun, 11 Mar 2018 12:56:04 +0100
        (STD)")
Message-ID: <xmqqk1uf3kcd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> So essentially, what your cherry-pick'able commits are is a way to store
> what rerere would have stored (i.e. the set of merge conflicts together
> with their resolution)?

If rerere would have stored, I wouldn't have separate band-aid
system on top.  These fix-up commits are usually on parts that do
not get involved in textual conflicts; "rerere" which relies on
having textual conflicts (the "shape" of the text in the conflicted
region is what lets "rerere" index into its database to find the
recorded resolution) wouldn't have stored them and that is
fundamental.

> If so, what tooling do you have to identify quickly what to cherry-pick,
> given merge conflicts?

It exactly is the issue I've been trying to find ideal solution for
quite a while and not successfully.  Here is a sample thread

  https://public-inbox.org/git/xmqqeft3u0u5.fsf@gitster.mtv.corp.google.com/#t

and every message I mention "merge-fix" is relevant.

The current band-aid system punts and indexes the merge-fix changes
by merely a branch name.  When refs/merge-fix/X exists, what it
means is "When branch X is merged to an integration branch, it is
likely that the integration branch _already_ has merged an unnamed
topic that causes semantic conflicts and requires this fix-up".
This needs occasional manual adjustment---e.g. when the topic X
turns out to be a lot more stable than the other topic Y that was
causing us trouble with semantic conflicts, I may at some point
reorder the topics and have topic X advance to 'next' before topic Y
does.  And when that happens, when I merge X to 'next', because Y is
not yet in 'next', I shouldn't apply refs/merge-fix/X (often, an
attempt to cherry-pick it on top of a merge of X into 'next' would
fail, which would be a bit of safety, but not always).  What I
should do instead is to rename refs/merge-fix/X to refs/merge-fix/Y
immediately before merging X to 'next', so that the cherry-pick is
not applied.  When rebuilding 'master'->'jch'->'pu' chain, X (now in
'next') will be merged before Y (not in 'next') gets merged, and
when it is Y's turn to be merged, the merge-fix I used to apply when
merging topic X will be applied.

In the ideal world (I think I'm repeating the ideas raised in the
thread quoted), the merge-fix database should be indexed with a pair
of commit object names (e.g. a step in branch X that adds a new
callsite for function frotz() and a step in branch Y that changes
the function signature of frotz()), and teach the system to
cherry-pick refs/merge-fix/A-B to resolve semantic conflicts, when
both commits A and B appears in the integration branch for the first
time.  And make sure these are kept up-to-date across rebasing of
commits A and B.  After rebasing the topics X and Y that contained
the commits A and B, if they became C and D, the system somehow
needs to be able to locate the previous merge-fix that was valid for
A-B pair when C-D pair gets merged.

