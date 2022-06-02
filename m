Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E665FC43334
	for <git@archiver.kernel.org>; Thu,  2 Jun 2022 13:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235594AbiFBNww (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jun 2022 09:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235564AbiFBNwu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jun 2022 09:52:50 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06661AA173
        for <git@vger.kernel.org>; Thu,  2 Jun 2022 06:52:49 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id f23-20020a7bcc17000000b003972dda143eso4818933wmh.3
        for <git@vger.kernel.org>; Thu, 02 Jun 2022 06:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=1JmwUBAx9UiPfFnkQ3tYmCbC17zqW9epZElSmzunTxU=;
        b=HicQPGigfiQpOBEqW2v2CSiPCQFIOUA+T5DL5QMGLEZTpCWGduU0XxMBckDSKYTk7I
         yj+7COrGCzG3CD77WvCk1B7nwUGNKgm921WLBBtomzTBl7MTNC8UKeEbHFoy0/TttT4w
         r0TgLTiBT2kW5MuuIL9/gQmunWztna+NX/wQ46j2XqYwBQ0uBkYpQSEUcRB//12qLepQ
         aPBRMIeSnEQWB74oSG0UpCX5SPfoAgolTUwEcDLurz3EH85POu4ywI8q1qvIQ5Gz1x2Z
         YUxkZxTyYgLx5V0Y4UydvoLh5vZkXAdGXTUCY6xHsvXEC9CrZWn/Jn3ZN9YQ9p0XGmnF
         faFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1JmwUBAx9UiPfFnkQ3tYmCbC17zqW9epZElSmzunTxU=;
        b=ihigE7gNeG5skfV3Pw9WeFCfYjj4GbJfWTEKIyS5IBxVrqI2kPMw8EwysNzz7lNiEb
         2IrejnylIJBKDh6rzVFX2RlTL4Rbxj+dKlIhhPfn63IUx+6/fbz6YGIk4pcJWqOoUaDt
         8ov3XKrj3g7vRfMLbgtTxEZUPRdmroYsH5YzoFSe2JeawLx2/Y2ZiPmDltRJkjRpClRO
         EL6m+wni1VWm3z6u78IbsQiW84YPPlajIChcVdR6Wroa3y+uuZ0/2ljREEpvOAyCvm+P
         PR+PbWCY8JkOaMWdxePzQXBr18FFP/Tyd6OBcKBX4oLBin0cqzpIqgXtnOeQ4cfVoori
         6RGg==
X-Gm-Message-State: AOAM5300LI+e8tk/y7uKddAdOYkEDxv9ZmaBYfeEClRKmDH1LIu3o5ka
        GmVPBWjji8FOpzjCGsu2YBmCWdRDlJ8qS6g/
X-Google-Smtp-Source: ABdhPJzZZMko2FI26iazvTwfekzxtsiLOovAu22wqwEBkEZE6BO8SDfris2j6rY2l4PVSPb2Dr3iHw==
X-Received: by 2002:a7b:cbda:0:b0:397:48d6:6c9f with SMTP id n26-20020a7bcbda000000b0039748d66c9fmr4250736wmi.10.1654177968046;
        Thu, 02 Jun 2022 06:52:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i12-20020a7bc94c000000b0039736892653sm5456144wml.27.2022.06.02.06.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 06:52:47 -0700 (PDT)
Message-Id: <pull.1246.git.1654177966.gitgitgadget@gmail.com>
From:   "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 02 Jun 2022 13:52:44 +0000
Subject: [PATCH 0/2] bitmap-format.txt: fix some formatting issues and include checksum info
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are some issues in the bitmap-format html page. For example, some
nested lists are shown as top-level lists (e.g. [1]- Here
BITMAP_OPT_FULL_DAG (0x1) and BITMAP_OPT_HASH_CACHE (0x4) are shown as
top-level list).

The first commit fix those.

The second commit is about including the info of trailing checksum in the
bitmap-format documentation.

[1] https://git-scm.com/docs/bitmap-format#_on_disk_format

Abhradeep Chakraborty (2):
  bitmap-format.txt: fix some formatting issues
  bitmap-format.txt: add information for trailing checksum

 Documentation/technical/bitmap-format.txt | 100 +++++++++++-----------
 1 file changed, 49 insertions(+), 51 deletions(-)


base-commit: 2668e3608e47494f2f10ef2b6e69f08a84816bcb
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1246%2FAbhra303%2Ffix-doc-formatting-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1246/Abhra303/fix-doc-formatting-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1246
-- 
gitgitgadget
