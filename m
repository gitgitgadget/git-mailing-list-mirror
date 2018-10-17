Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 564C61F453
	for <e@80x24.org>; Wed, 17 Oct 2018 20:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbeJREvL (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 00:51:11 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:37020 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbeJREvL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 00:51:11 -0400
Received: by mail-qt1-f201.google.com with SMTP id z26-v6so30336040qtz.4
        for <git@vger.kernel.org>; Wed, 17 Oct 2018 13:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MYArFxNxgbDam3KuspghH+QPw6EVCnFAHlBV+qU4vyQ=;
        b=TZV75qPOce8/PctwmoR7cghigpHYQ+FWfRvr1TS9xLfgd9qIV3ktPVfYd8zazC9coP
         3mFWpuBlGjbKpOpOapvx48UjwQUsH3l/s7CcQ5ZVxIlhN1jVBj4+RGwqPxEyyAoqzMxe
         z9A1GL54GCuycCEO9B+vkaswzCYuBSwr+FQGowte384jLJNNE++X1Gq8NTiT2kPmi+BH
         jPNsM/dyePpqQYk/llJWKW/YM9IfKhbXJL8Nccykm9KsNtVcoy5ZHUCOFWHu4ptqQnxk
         Wn+zhhqDZnDE31FLs6k+/7CYZ5owMsSfS/6Yqy9144yit+Jo/rMrlNtbP/jE6VSfdpCs
         uPPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MYArFxNxgbDam3KuspghH+QPw6EVCnFAHlBV+qU4vyQ=;
        b=P0kC9uQA2i21QQ5+fClkJsO3LrLBrlvn5Teo6HGKWWwwJpuBNaRRIcQqfkLlDP6Fg5
         Mi6XLuL/DVO/eSkGq+oYWXvs/C53YxeDUBKa/Mp0H7Iwf3/4DEsUs4wl+dSrFm8sI5VI
         5EAbuCg4LJUEzCnSWczLcwc7ASy/pm/hKoJy9A/pmEuu7y+i5RcopRZFasSMYFZKuAkx
         /PAUdjiBddXvphr64mDeojmsXQH4YofYfHGj60565b/JetjVicwR/FuTFUHle2ctaHDJ
         EmqFxw4TKJXF8wkkx5tmsisDt8PBjx8X6ybR2rJvdza6q5hfmZan6pwK85RI10BexKpV
         He7w==
X-Gm-Message-State: ABuFfojFyYK8Cdm6Km3xZ2TXoJ4k7JESolhJW8p/1MWW+B0Utj16M3is
        LnuKiVu4GpWrJK39tP298oONlD3q66nX5/gbZct9
X-Google-Smtp-Source: ACcGV634GaXXChjF+Gj0OV8A4XD8FgIsJXyUc+StT0muXdmL5/2iIg4FjdexEKsbh1sZt8PpKFRihIdaizXIS4hmBH8N
X-Received: by 2002:a0c:c13b:: with SMTP id f56mr23402876qvh.11.1539809623563;
 Wed, 17 Oct 2018 13:53:43 -0700 (PDT)
Date:   Wed, 17 Oct 2018 13:53:40 -0700
In-Reply-To: <CAGY-PBgsG-T3JY=awszwGMpFx+jDx-a1FcV0s6vR067bSqgZaA@mail.gmail.com>
Message-Id: <20181017205340.190036-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <CAGY-PBgsG-T3JY=awszwGMpFx+jDx-a1FcV0s6vR067bSqgZaA@mail.gmail.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: Git wire protocol v2 fails fetching shallow changes with `pack
 has XXX unresolved deltas` on large repos with lots of tags Inbox x
From:   Jonathan Tan <jonathantanmy@google.com>
To:     arturas@uber.com
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> No changes are needed in mirrored repository. Crash happens both with
> 2.18.0 and 2.19.1 git versions. Having repository locally is not
> required but reduces test runtime, you can quite reliably reproduce
> issue when fetching over net directly from chromium.orgbypassing
> mirroring step.

Do you have the reproduction steps for this? If I run

  git -c protocol.version=2 fetch --tags \
    https://chromium.googlesource.com/chromium/src \
    +refs/heads/*:refs/remotes/origin/* --depth=1

repeatedly in the same repository, it succeeds. (And I've checked with
GIT_TRACE_PACKET that it uses protocol v2.)
