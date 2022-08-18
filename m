Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 558DFC28B2B
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 07:15:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243804AbiHRHPd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 03:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235917AbiHRHPc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 03:15:32 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C878385A95
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 00:15:30 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ba1so673954wrb.5
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 00:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=+oHudiKLZdQMNgloDfH40ARogh/Mjvsts1oMojxyM3w=;
        b=SuoUpyCZR3+zlDdwfM4E2kxkk9pcoGwqT8S/hTbrfkzrfCw9+E5I0dEaiZ2qGzNnjh
         7w37ZWtypruQg27BnohmV2rGhiMT+tDyjuyZMbt6+Y1fPZ1SYL4JwW2MJfp45wpxZUa/
         uURqKBeK3wQFLcl4yqvGHqoGVrsL4fWRpQv0hsafxHb2M7SxCn6iiu2/76U1DB83zvK0
         oEuEyi+07pOmkfnGIxazcJWdYYGEbbRfhLh0PR0sTuyDwrY2S2kXPKw9OoVbCrJtuKaX
         2tTVWl/Ish47vXd9B2jDR9QOkjFMYQFm+pq8SlNyue5Foud39tiB4Wm7VoeoDVAxpo/I
         Y7RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=+oHudiKLZdQMNgloDfH40ARogh/Mjvsts1oMojxyM3w=;
        b=UwRnmmVn3W1Z5oen/a8tnuRNfPUcknN/39MQJjUb6ryoOIcPPlvQFnLvpvBPEkk++l
         arKvlNgkL7T5IDuPZZq7lvX2wh6xU4eOOpsI0DbLtvh5JgyN9C/K54ZdXrhinlYid6o9
         2zK5FUcWi+mDK3Kng70kWxAA6DwO4EWKfnDJDjDu2QxMNSHplCzAH6nTDOqO6TDCGLb1
         Y+C9kXQkSB5JRfGpWriejbp3HzaBNkz41b+RxEdUexPWYm2pm4MFAj/QbX3aao61XOiO
         C4QBKr8mDj+Rn7YK5QTQchsqPn8jxUE9SH/XhlHphQtS+5DGjvMB3FP0Pz4AXXPKhJQk
         YFQw==
X-Gm-Message-State: ACgBeo3i6jxYfsIhzwiwC35mVH1gREh84K6tP/8xN82gnCdB4iW46JWW
        O+nTkeIymislLCzUPXpS42acN7rMSQk=
X-Google-Smtp-Source: AA6agR6EPq0NJ4Ka9UfMbQIKMXPsLNm/X5hqxBQr0FCVV3GVZj/a26PM3jP+ME050pO13nQl8dKrbQ==
X-Received: by 2002:a05:6000:168e:b0:220:87da:c3e4 with SMTP id y14-20020a056000168e00b0022087dac3e4mr751018wrd.559.1660806928926;
        Thu, 18 Aug 2022 00:15:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v5-20020a5d6105000000b002251c75c09csm659234wrt.90.2022.08.18.00.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 00:15:28 -0700 (PDT)
Message-Id: <pull.1325.v3.git.1660806927.gitgitgadget@gmail.com>
In-Reply-To: <pull.1325.v2.git.1660718028.gitgitgadget@gmail.com>
References: <pull.1325.v2.git.1660718028.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 18 Aug 2022 07:15:24 +0000
Subject: [PATCH v3 0/3] Fixups for cw/submodule-merge-messages
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series fixes a few issues I noted in cw/submodule-merge-messages (which
merged to next a few days ago). Sorry for not responding before that topic
merged to next; I caught Covid near the end of my vacation and it took me
out for a while. So here are a few patches on top instead.

Changes since v1:

 * rebased directly on top of Calvin's patch, allowing Junio's patch in
   cw/submodule-merge-messages to be dropped.

Changes since v2:

 * changed the second patch to instead initialize sub_flag to
   CONFLICT_SUBMODULE_FAILED_TO_MERGE, as suggested by Junio. (thanks!)

Elijah Newren (3):
  merge-ort: remove translator lego in new "submodule conflict
    suggestion"
  merge-ort: avoid surprise with new sub_flag variable
  merge-ort: provide helpful submodule update message when possible

 merge-ort.c | 104 +++++++++++++++++-----------------------------------
 1 file changed, 34 insertions(+), 70 deletions(-)


base-commit: 4057523a4061092e9181220d54dca9eadcb75bdc
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1325%2Fnewren%2Fsubmodule-merge-messages-fixups-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1325/newren/submodule-merge-messages-fixups-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1325

Range-diff vs v2:

 1:  374278c6a1d = 1:  374278c6a1d merge-ort: remove translator lego in new "submodule conflict suggestion"
 2:  340c0f46f74 < -:  ----------- merge-ort: add comment to avoid surprise with new sub_flag variable
 -:  ----------- > 2:  48200773a1b merge-ort: avoid surprise with new sub_flag variable
 3:  80207d18334 = 3:  4c4a8f028d4 merge-ort: provide helpful submodule update message when possible

-- 
gitgitgadget
