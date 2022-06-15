Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B96EAC433EF
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 23:36:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353626AbiFOXgI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 19:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350821AbiFOXgB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 19:36:01 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74081F2C1
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 16:35:59 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id a15so17279717wrh.2
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 16:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fsqie9DP/xVl7vON6ezt0AdhOBqtz8CpDNLwZoU5tWg=;
        b=FG6O1BO7dOalLT8YWlwNFEXlF2UVfEMzsMBakLlZOvQAubMwqOfBGMTfNnJE2b/+O6
         IsC6la057NX8DF+b37FbO7Oi6xrulBRcHBFOR2VZhtIU043/2Xyg2tgn/XhGkT7bVY6U
         k9FD5fKTHvHryvhD+QRo+ZROPwO+hCY9I24/uS8JbPJYahIlfNwNvKviStTEDNiW7s+7
         M0tyKpz7l+ZuuSgwu7+N78LLfmHv8MekqF5WYmRColKBj81Ye/yZ2ADIsDcGBdi+HBAF
         jB9xN9DKtzHfdmAxrRGqo1WY77mSE3hJbHw7cxaCHeNiqQQz0fvvTcP4N4uqX0TMPxR1
         ZlmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fsqie9DP/xVl7vON6ezt0AdhOBqtz8CpDNLwZoU5tWg=;
        b=NmMGnyOB3FZvKm2AatK5ucBQ0VlL4jomQt1KuQS6Ofow6X51ZAVdapgCsqUuqiKa8v
         dGmJDrMcYAdKKP60xhpybDN4pCV46xmNMeLgfpV+GKjPOtTs3/C+X8c32UC2W2OnllGl
         1pJrJ/70JXz6j7bkh63RUEWHW2Gzy9xw0oOJcYf7tXKXSn3aFJAhP+bhG7Yeh1s/vhTY
         0tJG9mBZxOBDAXgjLdbh7ShI4kgBdH0bm3spy2w9pRn2/FyCjTx0kFKqgIZZY+8Vfhla
         tNIHXnE0qIiDWzsTHZCe7usbvpp6E/nvouBUkgYcS7SnTr8txaAGtIRYOoMmIrQWzPd2
         uPHw==
X-Gm-Message-State: AJIora9M5iVEnFzjQxTAtFwhi+c6Kfm1JkofwGD6jrcLTxL5lKXgod5j
        YglkNX5HgvZDvXZxKj5BRtIglWYCa3Ta8w==
X-Google-Smtp-Source: AGRyM1s+mRb8KUeuuphRP4M9vRdCfTZqOYbY5zEATM80982zE+XBO84fuNRCWBmOVyOwEUlbI46Low==
X-Received: by 2002:a5d:5686:0:b0:217:7da8:8c5a with SMTP id f6-20020a5d5686000000b002177da88c5amr1905870wrv.3.1655336158080;
        Wed, 15 Jun 2022 16:35:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j19-20020a05600c1c1300b0039c5645c60fsm9223158wms.3.2022.06.15.16.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 16:35:56 -0700 (PDT)
Message-Id: <bc29a9710e3a22e6d660098c4f201f3bfecc54ea.1655336146.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1264.git.1655336146.gitgitgadget@gmail.com>
References: <pull.1264.git.1655336146.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 15 Jun 2022 23:35:40 +0000
Subject: [PATCH 06/11] pack-redundant: avoid using uninitialized memory
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In the `add_pack()` function, we forgot to initialize the field `next`,
which could potentially lead to readin uninitialized memory later.

Reported by Coverity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/pack-redundant.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index ed9b9013a5f..1f7da1f68b6 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -526,6 +526,7 @@ static struct pack_list * add_pack(struct packed_git *p)
 	}
 	l.all_objects_size = l.remaining_objects->size;
 	l.unique_objects = NULL;
+	l.next = NULL;
 	if (p->pack_local)
 		return pack_list_insert(&local_packs, &l);
 	else
-- 
gitgitgadget

