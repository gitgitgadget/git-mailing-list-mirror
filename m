Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1EF2CD8CAB
	for <git@archiver.kernel.org>; Tue, 10 Oct 2023 16:21:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233484AbjJJQVs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Oct 2023 12:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbjJJQVr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2023 12:21:47 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199639D
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 09:21:44 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59f2c7a4f24so93238807b3.0
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 09:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696954903; x=1697559703; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jA6YQXxnreTrepahUWhFpruVFXNdD5zeXaMk1zfNKNc=;
        b=USy0axN3x8omv4Z2Uck9mVVFd9THc5cHxFV/+5m2/Z2i+IZ+bbuWN/tINQvSL/v0+1
         fATyDb+JAJXIR2SyRAkmGtp/+Qls1H+xvunp1ikCFd1/CXhq+ZsEaKMdwWI2RyO6vjaE
         w2r8JCV3X6tmdOjBZcwdP7xPosKXMTpvFWl0cuMtZkknMNw9bO4vtkgaCbTmk4KXdPzY
         i9YK7olAsqanUvP3AE3qPjuwqLq1QowpHXqnI1FbggU32u1/emJSOdPkctG8otb0d5qd
         Bih0CmkQBNh69ou0bw8VL7+d9C4KLhnt/nguCS19rrqAU/Iotr2KZW3UFa9vpOAJTXjy
         J+qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696954903; x=1697559703;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jA6YQXxnreTrepahUWhFpruVFXNdD5zeXaMk1zfNKNc=;
        b=JqAMcQlZ53F110tCcU9Obytd3D/kTa06QiRS/JX/eL4e3vObmg7LTc+TKwXJCoWIeO
         1Wf9XgWm3qlwQK2kFtxqaNxHxsB2zIg9h4bhxa5dYKh+dKRrggVnwu10S2hPTJxm0ySa
         xraOGq8F5Ne1eqqpGc86FBQu4TltMR/+GFUF8jctO8TCQpGzh3kQD/eWPXOXhmumpjFA
         yLi/4cbouFv/lO0t4AXhsfMMgv9/EbODtwaBa2tA6zX4XW9FfQrpe6hO12mQC7h0k9rj
         ulDZ+hmDt4GihdZSPfV+lI9ddKFB/e8Snsm+6cNoAXJro+874hM/XpzsQCbumyCtpuWT
         Zk0Q==
X-Gm-Message-State: AOJu0Yw2r2Siw/DC9J5BvZ5sU1oRzxxxIK00tx1Xw3osr6T6M9CUZyG8
        XfZ/E79CpHGN4G8udmxZwknZeB2AG4O1QaYzb262
X-Google-Smtp-Source: AGHT+IFU1bj0U7UqZoj6C2o391rLKyAxTBLLy7pQuZbpZ7aY/iCb0QrMo31a5EBFaA/iSfsU0+FIs+CHI8hlpeOECYQW
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:1002:fbcf:d571:5625])
 (user=jonathantanmy job=sendgmr) by 2002:a81:b623:0:b0:5a7:b575:49c3 with
 SMTP id u35-20020a81b623000000b005a7b57549c3mr62276ywh.4.1696954903344; Tue,
 10 Oct 2023 09:21:43 -0700 (PDT)
Date:   Tue, 10 Oct 2023 09:21:41 -0700
In-Reply-To: <4670774d-a899-492c-9b36-98ee243c8d4d@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Message-ID: <20231010162141.2133714-1-jonathantanmy@google.com>
Subject: Re: [PATCH v4 0/4] Preliminary patches before git-std-lib
From:   Jonathan Tan <jonathantanmy@google.com>
To:     phillip.wood123@gmail.com
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Calvin Wan <calvinwan@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

phillip.wood123@gmail.com writes:
> Hi Jonathan
> 
> On 29/09/2023 22:20, Jonathan Tan wrote:
> > Calvin will be away for a few weeks and I'll be handling the git-std-lib
> > effort in the meantime. My goals will be:
> > 
> > - Get the preliminary patches in Calvin's patch set (patches 1-4) merged
> > first.
> > 
> > - Updating patches 5-6 based on reviewer feedback (including my
> > feedback). I have several aims including reducing or eliminating the
> > need for the GIT_STD_LIB preprocessor variable, and making stubs a test-
> > only concern (I think Phillip has some similar ideas [1] but I haven't
> > looked at their repo on GitHub yet).
> 
> It sounds like we're thinking along similar lines, do feel free get in 
> touch on or off the list if you want to ask anything about those patches 
> I pushed to github.

Thanks. I'm updating patches 5-6 now and basing on your work, in fact.

> > [1] https://lore.kernel.org/git/98f3edcf-7f37-45ff-abd2-c0038d4e0589@gmail.com/
> > 
> > This patch set is in service of the first goal. Because the libification
> > patches are no longer included in this patch set, I have rewritten the
> > commit messages to justify the patches in terms of code organization.
> > There are no changes in the code itself. Also, I have retained Calvin's
> > name as the author.
> 
> I agree it makes sense to get the preliminary patches merged on their 
> own. I think the argument that they reduce the scope of includes is a 
> reasonable justification on its own. I've left a couple of comments but 
> they're looking pretty good.
> 
> Best Wishes
> 
> Phillip

Thanks.
