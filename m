Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D608C433F5
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 18:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbiBUSql (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 13:46:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbiBUSqh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 13:46:37 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1910195
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 10:46:12 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id k127-20020a1ca185000000b0037bc4be8713so3782wme.3
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 10:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=t3pu1ljUtOiq0weLRk+F++jc7TEifpPhWv/yQsIL2IA=;
        b=cWn8wBxRUq6fJ/488C+YkVpQd1z0X8iGWJA7UGuzhTSARDAYYMbtbH4Ok8DxjgQRZX
         SN4tV3FxYPHTqQMlsnJRBOq2IwE1MSGkhYXYp468BnWzVAu6WyuVLxTOK4X64YxZK/Ki
         qqh0JliarjGeD63Jk19yLKhwYMVZexsV29Z2j47yTk2ozjDZzfzo7Goxf4JRlbsDvHAm
         ERzDN7V666DxULiYw949OQDdVifIPuPDB0xzklJcYFG06XTl/Hl8TE25TgIug2lsBI4h
         CDlIfT98MEt4dj29LHqzCRyKyRlXNQJWqr9pcmLAvs4shYi3laQYhS+a/54GRkxf1RYf
         yz0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=t3pu1ljUtOiq0weLRk+F++jc7TEifpPhWv/yQsIL2IA=;
        b=N2ZZmBn6KS2bYcUKrYaCWu3l/Qxv5FmI7Nz5lV6myLUMh4rK52D1iYzQnlu0mc3C2T
         5rfyRE532UapStj4xQ7G006x//V7rWfyRs7kA/exHru2985CsRo1aJNAzgONUgBF153U
         +o2JWlyKfO6RE6vOUXQG4CnDrwtng9SyrUN3MHq5P0o2KCQf1RSU3cDhkuDdCzMGLpZT
         n2qhRt+YyQfgEuEfEv6G8jHq4lCwWxPv7t3m8ta59OQmJ+t7dmwFstOl5drc/Fd/jZ0q
         DS8N1kptNV+DCP/zJg7lDzJ4lmajvJUaUJG2bjnqpt9wVnJkEqltKVkrzr9pmxwcX5iV
         OkOQ==
X-Gm-Message-State: AOAM533JVZ4xRO/eEo5JEY2UliHe0LAeuac8jfzrzVhfu7CbYMdDJBEY
        iDxw//qAkM7nygUfOB6Id7L2H+eWRbM=
X-Google-Smtp-Source: ABdhPJyDG6OfrDko9IobitEUeMJR9b2o3FuPzx4wwVuDgbL2dbsehL7cfXd2wRZmAqkT6SoZi61Rdw==
X-Received: by 2002:a7b:c5d1:0:b0:37f:a8a3:9e17 with SMTP id n17-20020a7bc5d1000000b0037fa8a39e17mr269447wmk.109.1645469171057;
        Mon, 21 Feb 2022 10:46:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l38-20020a05600c1d2600b0037e9090fb1esm174021wms.24.2022.02.21.10.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 10:46:10 -0800 (PST)
Message-Id: <pull.1185.v3.git.git.1645469170.gitgitgadget@gmail.com>
In-Reply-To: <pull.1185.v2.git.git.1645106124.gitgitgadget@gmail.com>
References: <pull.1185.v2.git.git.1645106124.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Feb 2022 18:46:03 +0000
Subject: [PATCH v3 0/7] reftable: avoid reading and writing empty keys
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

this series makes sure that the object record does not have to consider
empty keys (and therefore, a NULL memcpy destination)

while we're at it add some more tests, and fix a naming mistake.

Han-Wen Nienhuys (7):
  Documentation: object_id_len goes up to 31
  reftable: reject 0 object_id_len
  reftable: add a test that verifies that writing empty keys fails
  reftable: avoid writing empty keys at the block layer
  reftable: ensure that obj_id_len is >= 2 on writing
  reftable: add test for length of disambiguating prefix
  reftable: rename writer_stats to reftable_writer_stats

 Documentation/technical/reftable.txt |   2 +-
 reftable/block.c                     |  27 ++++---
 reftable/block_test.c                |   5 ++
 reftable/reader.c                    |   5 ++
 reftable/readwrite_test.c            | 105 ++++++++++++++++++++++++++-
 reftable/reftable-writer.h           |   2 +-
 reftable/writer.c                    |   9 ++-
 7 files changed, 136 insertions(+), 19 deletions(-)


base-commit: 45fe28c951c3e70666ee4ef8379772851a8e4d32
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1185%2Fhanwen%2Fobj-id-len-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1185/hanwen/obj-id-len-v3
Pull-Request: https://github.com/git/git/pull/1185

Range-diff vs v2:

 1:  80d29e8f269 = 1:  80d29e8f269 Documentation: object_id_len goes up to 31
 2:  4c1a19fc4ae ! 2:  68e7bc32ff8 reftable: reject 0 object_id_len
     @@ Commit message
          reftable: reject 0 object_id_len
      
          The spec says 2 <= object_id_len <= 31. We are lenient and allow 1,
     -    but we forbid 0, so we can we can be sure that we never read a
     -    0-length key.
     +    but we forbid 0, so we can be sure that we never read a 0-length key.
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
      
 3:  600b115f8b1 = 3:  8b5aebdb07a reftable: add a test that verifies that writing empty keys fails
 4:  ba036ee8543 ! 4:  a9372cacd1b reftable: avoid writing empty keys at the block layer
     @@ reftable/block.c: int block_reader_first_key(struct block_reader *br, struct str
       	if (n < 0)
       		return n;
      +	if (!key->len)
     -+		return -1;
     ++		return REFTABLE_FORMAT_ERROR;
       
       	return 0;
       }
 5:  2bd3d44ba57 = 5:  0b8a42399dd reftable: ensure that obj_id_len is >= 2 on writing
 6:  82d36ee0e0d = 6:  bdccd969475 reftable: add test for length of disambiguating prefix
 7:  c6ffdb3471c = 7:  72499a14e38 reftable: rename writer_stats to reftable_writer_stats

-- 
gitgitgadget
