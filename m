Return-Path: <SRS0=62NG=5C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02667C10F29
	for <git@archiver.kernel.org>; Tue, 17 Mar 2020 17:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA7AC20753
	for <git@archiver.kernel.org>; Tue, 17 Mar 2020 17:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOf6U4SY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgCQRAq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Mar 2020 13:00:46 -0400
Received: from mail-lj1-f174.google.com ([209.85.208.174]:35662 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbgCQRAp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Mar 2020 13:00:45 -0400
Received: by mail-lj1-f174.google.com with SMTP id u12so23770199ljo.2
        for <git@vger.kernel.org>; Tue, 17 Mar 2020 10:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=dyT2OUJBed7bEW9gtpiB7QaDHsIRdMFll5qbEod11JU=;
        b=SOf6U4SY1XHjGbhMA4R83bUjPdCoh6f2agnAR0pliTBURtMFP3BED9dyajOGI+JpJf
         6Lzr6L6Zj4gmAwrpsV6gfFBBsEl4g4VgoR0FcYytv31JNydIpjHni+rVpSxL7JZL5Ogm
         jfeB4BV7FrRwFM2HhZG4UnBQKrlJ/AApsphF61G3K8DBd/nZJJSyUoLYaoR67vClu3Sn
         t45D5qX28baRKMP1MkVi7hbxHc69ajwqk9a3w30u9xgDlVcfDIKUJR6nP/UD2o0cQgVX
         0Sc/TknsCP9mWGl48OAfNo43U3PzV+8GArN7JJc1c/fkmawZ4buLCHW2YuXMSuYLgcYU
         6/gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=dyT2OUJBed7bEW9gtpiB7QaDHsIRdMFll5qbEod11JU=;
        b=PsO9nVLy6CRIbl2Uh4FZR3hJ1Hai2ioKECasL6+DFoE7dWHWh83nHfLuonZefU+A2j
         nHAJqfUWnzooDmt6wBliDRxpnhGXg8tjoofdEKd+LIeslkkXhYJJEXCkeBqyWNhakD+k
         jGN2GQIDxyKXYj/5YJGhK/GnGE2M/RAYnMIQltVKt8nucvD/l02qbhPcfLcvTBFtck6L
         qtfQkQGQMyHWGJVsxIKP/WfwAz69PC2/s12qVf6z8Wlatavsx+K/Kuta1COhFwaTzFhg
         EHnQQHQA+OSpND5O8sBBpixLLmtc9z8QItbi0n9/eiM4TMb54Q8SEI9Ez743/NxTvqht
         /rfQ==
X-Gm-Message-State: ANhLgQ2IKD6rVsLn+PWr/bszl4dZhkmjYKlJ2kP8KR+gmrWR9RGyxG+7
        uU8ZyRm9eE8ju2jvt65Y+TZjlsrTVmR8G24IbrU=
X-Google-Smtp-Source: ADFU+vuUyJ/qEWIN8MPXISvZCHLUt85PTuPpxvXmdX21AiSan32mp8lOHiAyQvP3eOF4xXdBo4GzJdLAyfCaGmErfUw=
X-Received: by 2002:a05:651c:50a:: with SMTP id o10mr3256326ljp.163.1584464442119;
 Tue, 17 Mar 2020 10:00:42 -0700 (PDT)
MIME-Version: 1.0
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
Date:   Tue, 17 Mar 2020 22:30:00 +0530
Message-ID: <CAHk66ftx=XTSeVcPe09yA9KMDpHwiKFLKa62cCBFufjeenAbaQ@mail.gmail.com>
Subject: Re: [RFC] Possible idea for GSoC 2020
To:     stolee@gmail.com
Cc:     christian.couder@gmail.com, git@vger.kernel.org, jnareb@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Having such a complicated two-dimensional system would need to
> justify itself by being measurably faster than that one-dimensional
> system in these example commands.
>
> [...]
>
> My _prediction_ is that the two-dimensional system will be more
> complicated to write and use, and will not have any measurable
> difference. I'd be happy to be wrong, but I also would not send
> anyone down this direction only to find out I'm right and that
> effort was wasted.

Agreed. I have been through the papers of the involved variants and on graphs
comparable to some of the largest git repositories, the performance improves by
fifty nanoseconds for a random query.

Additionally:
1. They require significantly more space per commit.
2. They require significantly more preprocessing time.

> My recommendation is that a GSoC student update the
> generation number to "v2" based on the definition you made in [1].
> That proposal is also more likely to be effective in Git because
> it makes use of extra heuristic information (commit date) to
> assist the types of algorithms we care about.

> In that case, the "difficult" part is moving the "generation"
> member of struct commit into a slab before making it a 64-bit
> value. (This is likely necessary for your plan, anyway.) Updating
> the generation number to v2 is relatively straight-forward after
> that, as someone can follow all places that reference or compute
> generation numbers and apply a diff

Thanks for the recommendation. Reading about how this fits in more
with REU on the other thread, I too agree that updating generation
number to use corrected commit date would be more appropriate for a GSoC
project.

Regards
Abhishek
