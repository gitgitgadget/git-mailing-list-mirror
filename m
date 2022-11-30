Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C15F4C4332F
	for <git@archiver.kernel.org>; Wed, 30 Nov 2022 12:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234902AbiK3Mey (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Nov 2022 07:34:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234305AbiK3Mer (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2022 07:34:47 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331927B4C1
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 04:34:47 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 6so15894878pgm.6
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 04:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SkTCWdxV6s5mAUW3pTBiMGLbEaMT8nDCRQkJJ8vpNvY=;
        b=BLX3hlQIMRVpPlWo3D8c7B+8qgukiJ0WF0BG28tYRDOfHXEsYQG8nzKG+r4L4OxSnu
         8ZHFYoycpmpd7mow+jgJhRHggtA3zh3rmEoVNCvt9U8aitNfwAhPWjC5WK0X/m+hLxyb
         iCmc1CWu6eNmU2FuuSpycO16RaMCNlRqOq3ubvVLO43Hn+5dDZ8/RjLufpTaZzWAmKIv
         J7+2zmOqjCUjwcghyLsbb4UzGRafUC1zHX1rjPmVCaVG1zeVSHe1UUQslIfnVSZWa8dO
         U0vyM8cpu9RCNgg7JZXzJQhtcDpvvA1wBRSR0cjcox/Olw6OneQFKRXovEjPwDuGGpHx
         TGLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SkTCWdxV6s5mAUW3pTBiMGLbEaMT8nDCRQkJJ8vpNvY=;
        b=o5Y6ybvy/IS+qi8Zl8EvTQ3BlLbXWCNpnuWZK2/9etc2kzh2KdNWBUgYeO+EUazqWA
         2eEqJ4fkTGHABoOxEVGMeWgb+jkiJnkrAedwt7ThOzBkHi7WKSrVobgIYHalo0NPOkkq
         L5bq55DuC85H0vZOP4fr+4Vui7RYSoC4MfkKMDz+srWKektgGZlEdEygViZpUEBQyavk
         ml7KrcJWwlEkR2njIeGO+PZr1Zwm9ByZXh2hhIckCBCCS4WRIHmyWrqG6IfXPb1KYPmK
         GemM7t3wmTBatFvpMHRzU5S8/uChPR8eRpbjr4a4nLTaj2MHUdwHo2X0Eimw1JS+6BER
         YbuA==
X-Gm-Message-State: ANoB5pkPUlwJFxojoRuqcLaHXohWyBjdm1crqTxsj5D0pRZJrNlJpBYy
        ++IMAc2U1NUjU1OtufvphsE=
X-Google-Smtp-Source: AA0mqf6549rlUDu0hpgjsiLm0a4ZZx4KAceIMg01RfVJ7e1nB9MN5aGHUB63WnihG4nbNcMc79Z4iA==
X-Received: by 2002:a63:224c:0:b0:46b:8e9:747 with SMTP id t12-20020a63224c000000b0046b08e90747mr35486366pgm.365.1669811686525;
        Wed, 30 Nov 2022 04:34:46 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.57])
        by smtp.gmail.com with ESMTPSA id y6-20020a17090a390600b0021947bb6a9esm1431536pjb.36.2022.11.30.04.34.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Nov 2022 04:34:45 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     gitster@pobox.com
Cc:     dyroneteng@gmail.com, git-packagers@googlegroups.com,
        git@vger.kernel.org, lwn@lwn.net
Subject: Re: What's cooking in git.git (Nov 2022, #07; Tue, 29)
Date:   Wed, 30 Nov 2022 20:34:40 +0800
Message-Id: <20221130123440.96719-1-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.38.1.473.ga0789512c5a.dirty
In-Reply-To: <xmqqa64914jj.fsf@gitster.g>
References: <xmqqa64914jj.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> >> * tl/pack-bitmap-absolute-paths (2022-11-29) 4 commits
> >>  - pack-bitmap.c: trace bitmap ignore logs when midx-bitmap is found
> >>  - pack-bitmap.c: break out of the bitmap loop early if not tracing
> >>   (merged to 'next' on 2022-11-14 at 34eb0ea05a)
> >
> > Will the two commits which merged to 'next' on 2022-11-14 at 34eb0ea05a
> > be taken into 2.39.0-rc0 (or v2.39.0 is frozen already)?
>
> 2.39-rc0 was a preview of topics that were already done at that
> point about a week ago.  A topic that is not in -rc0 may hit the
> release, but it depends on how urgent the "fix" is, I would say.
> Unless there is a good reason not to, any topic should spend at
> least a week to cook in 'next' before graduating, and because there
> typically is about a week between -rc0 and -rc1, anything outside
> 'next' when -rc0 was tagged is not likely to have spent a week in
> 'next' when -rc1 is done.
>
> We could graduate the early bits separately, but is it so urgent a
> fix to get them in?
>
> I spent a few dozens of minutes to re-read these two patches, and
> while I do not think they are so complex and risky, I did not see
> anything in them to give them such an urgency (for that matter, I
> am not sure if they are even necessary, especially the one that
> loses information from the logs).

I confirmed that our understanding is consistent by your explanation.

Thanks.
