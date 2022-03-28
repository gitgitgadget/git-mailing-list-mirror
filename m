Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098DDC433EF
	for <git@archiver.kernel.org>; Mon, 28 Mar 2022 20:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345462AbiC1Ut6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 16:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346467AbiC1Usu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 16:48:50 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31EACAE6A
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 13:47:09 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id u3so22081512wrg.3
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 13:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8n6dxquGPa1gC3AfN6y5QY8KGFeb9meuhwrmwG18LLY=;
        b=PXMogHIKjMLQr4UZWAlJPmB8inIdBkIx3WvU8DfnY+xfPuQx2EKSKu9pftkcxjyuw3
         oYUQ641btVnmK9UF4UezeTD/QY8HIfujkwjZuzXBrtjRJ8YQ4iOlbzqzoaTpYd7ca98s
         FEODD9Acg09QPxuXuY2shEvinLp2wIwQYXV3U+xiOCUOtLHZDw8jAfHfPX+/FPOPut4K
         JVNu4Uujkw8RjZAugeEUZx/n7lfTDE/oZQZ5x1A8dWac8gRhN8lKPMfktFO5SN0OJY9t
         BtE9Nvb4PETVppT5PYH8m7FR6Sb9efPAMkAW4+zlVNumQVRsvLONSNf3dNeugl4m16Qf
         K75A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8n6dxquGPa1gC3AfN6y5QY8KGFeb9meuhwrmwG18LLY=;
        b=6S5jpHMp27zaoAzb9b5iS6EutzuNx7ot70zQCS4YtU5H9ym22a22VqxPqYN7/vx8Pl
         1x9v8KRVP08r2ed5bqm2GcuvfgqSpNs9LZ3jrdSQv1vAOAfmrzSu72pBXEAFv0AefBCr
         J7/Rt2mPzUN7LVn+oMwnfhnlTps7ZPLSpB9KKXoIK47Odu7O+OtYbaacf1CmyrsbakSf
         gElV9+DKT1rGBVhr7MNPcs7fNY2GJV9uLYY50LZ3nfY+PHavLHEe6Ucw7QhprSUQ0fLs
         HiLUElwHUsEnHXFpYRd39rDkJY5+kte78PONy5dnIqGkkI6k0J+5i+ckfjWwYAmBEG5+
         CcIA==
X-Gm-Message-State: AOAM530qjd3w7GpijK0oGlfpGnKsTH2GnSZXcQbMlHuP6/ODYkrQ4yK9
        nmPjkx46o4U5Mi/19UZDTF+Fkft8JmY=
X-Google-Smtp-Source: ABdhPJylO6M1DwIh3wlV1Qn4SNAVnDnKXAP1Roj8fvNw4LEE2mnJRRKDQN7yLvw0hy9cMzitPnGHDg==
X-Received: by 2002:adf:e197:0:b0:205:7b24:678f with SMTP id az23-20020adfe197000000b002057b24678fmr26204361wrb.670.1648500427668;
        Mon, 28 Mar 2022 13:47:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o8-20020a5d6488000000b002051f1028f6sm15566930wri.111.2022.03.28.13.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 13:47:07 -0700 (PDT)
Message-Id: <pull.1188.v2.git.1648500426.gitgitgadget@gmail.com>
In-Reply-To: <pull.1188.git.1648231504463.gitgitgadget@gmail.com>
References: <pull.1188.git.1648231504463.gitgitgadget@gmail.com>
From:   "Des Preston via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 28 Mar 2022 20:47:04 +0000
Subject: [PATCH v2 0/2] worktree: include repair cmd in usage
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Des Preston <despreston@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm working on an extension for the github CLI (github.com/cli/cli) to make
it easier to create and manage worktrees using Github info
(github.comm/despreston/gh-worktree). I noticed there was a worktree command
that wasn't showing up in the usage menu git worktree -h.

Signed-off-by: Des Preston despreston@gmail.com

Des Preston (2):
  worktree: include repair cmd in usage
  worktree: accept multiple paths

 builtin/worktree.c | 1 +
 1 file changed, 1 insertion(+)


base-commit: 4c53a8c20f8984adb226293a3ffd7b88c3f4ac1a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1188%2Fdespreston%2Fworktree-usage-repair-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1188/despreston/worktree-usage-repair-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1188

Range-diff vs v1:

 1:  e0bfbfd5320 = 1:  e0bfbfd5320 worktree: include repair cmd in usage
 -:  ----------- > 2:  1df005a4ef1 worktree: accept multiple paths

-- 
gitgitgadget
