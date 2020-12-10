Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6876C19425
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 02:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C689423C40
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 02:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbgLJC03 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 21:26:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728659AbgLJC02 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 21:26:28 -0500
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8D8C0613CF
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 18:25:48 -0800 (PST)
Received: by mail-oo1-xc41.google.com with SMTP id x203so928972ooa.9
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 18:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nf92ToWB2Kk77Ym2fIcnojjqXJjiS6zxP/A1Xxsz2wQ=;
        b=dGQj108EYwug9P46Tmz4ptwoBrqga12X6c5F19s+QwcPROlTOCalzksBiQwFhMBJS+
         sih+9T3tish995mRTcOH2WACT1pEaU6P1Gju5jC+nuSudlfPnh3vEYk0QNfuS6eNOYXE
         raiN1EalapKGpab4QfSS/dirvN6KASMx0Gma6QTkkKqL6+FwIX7MRcT2UmPti9fCIEn9
         FfS2nHLK7EGk3n5M1cQTx7jq7t2/aCCDaYdBTxW/nCGb5WV2OMTPyVXWOSMcIbiiLJmF
         1iRJzVBpD1jfLqLGYBBYzU6saeuyyxiL2zxvYgUHh5GgVMkhgK1D/8i1C31jcQI7YhI2
         MUpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nf92ToWB2Kk77Ym2fIcnojjqXJjiS6zxP/A1Xxsz2wQ=;
        b=fyAukk9f6ni7GVd7845qn2OXVzpyjZkER3uMA5lQUs9lsYaFucyN7LABVRWBl6UVBv
         /w+wrTSvcipVppKR/12tP1Bga5fCl23RJAqK6obu7QjI9HUbFsn2q6m59LQZS74BSi7n
         x88khvz7c3pim4ndA3s64OYR3AhaUXD+HZi/IVhsYv50MDpc3tQ4fhiMzmrbCvYy2l7U
         cnsu6XM7Ulby088y01ShhdM2EKm2RutpAV6bx1KXG5mYfyBpLyEal7vpY1Lr988U/qVd
         2PNf5+vNc7DgBFpk/rcUSk86FJnWx/hhHa9Q+FLPiZc8aBIWkZCO2enXMb24z0aFTPWM
         b6Lg==
X-Gm-Message-State: AOAM532tA1FVQ1Omw+A4jl4ulMQtdBiB1aGEpyy0wfno7ygjW6MOidyo
        XyjjUmf6U53zjlRvnaTMg1XRQdSLoy/o47cqL2Q=
X-Google-Smtp-Source: ABdhPJztLpH3U9Eu9G8pnx2Mm5RZyaoZvy0Vea8nqaehOagyDPt0veXvoMfEdJs4r6zjU2vRQZvhpiDWnxMAwPt5dQo=
X-Received: by 2002:a4a:c60c:: with SMTP id l12mr4379666ooq.45.1607567148031;
 Wed, 09 Dec 2020 18:25:48 -0800 (PST)
MIME-Version: 1.0
References: <pull.929.git.git.1607223276.gitgitgadget@gmail.com>
 <30381addc5ca9f2b5299835020716291c7fe8d68.1607223276.git.gitgitgadget@gmail.com>
 <xmqqpn3ixuyj.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqpn3ixuyj.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 9 Dec 2020 18:25:36 -0800
Message-ID: <CABPp-BFypNXFKVav4hyG2+DvaU1U8UgcAwVqCMmWtZQWhzBnvw@mail.gmail.com>
Subject: Re: [PATCH 3/7] diffcore-rename: rename num_create to num_targets
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 9, 2020 at 6:20 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > Files added since the base commit serve as targets for rename detection.
> > While it is true that added files can be thought of as being "created"
> > when they are added IF they have no pairing file that they were renamed
> > from, and it is true we start out not knowing what the pairings are, it
> > seems a little odd to think in terms of "file creation" when we are
> > looking for "file renames".  Rename the variable to avoid this minor
> > point of confusion.
>
> This is probably subjective.
>
> I've always viewed the rename detection as first collecting a set of
> deleted paths and a set of created paths, and then trying to find a
> good mapping from the former into the latter, so I find num_create a
> lot more intuitive than num_targets.
>
> But the remaining elements in the latter set are counted in the
> counter "rename_dst_nr", so we clearly are OK to call the elements
> of the latter set "the destination" (of a rename), which contrasts
> very well with "the source" (of a rename), which is how the deleted
> paths are counted with rename_src_nr.
>
> When doing -C and -C -C, the "source" set has not just deleted but
> also the preimage of the modified paths, so "source" is a more
> appropriate name than "delete".  From that point of view,
> "destination" is a more appropriate name for "create" because it
> contrasts well with "source".
>
> You silently renamed num_create to num_targets in 1/7 without
> justification while adding num_sources.  Perhaps we should go back
> to that step and use num_destinations to match?  The result would be
> using words <dst, src> that pair with each other much better than
> introducing "target" to an existing mix of <create==dst, src> to
> make it <target==dst, src>.

Ooh, I like it.  num_destinations it is.
