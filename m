Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8940FFA373F
	for <git@archiver.kernel.org>; Mon, 24 Oct 2022 16:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbiJXQaG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Oct 2022 12:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbiJXQ3m (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2022 12:29:42 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC2A21E33
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 08:16:01 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id z14so3243639wrn.7
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 08:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RY7k8+o8qeODmcHA1WccgZfqq3Axt7Lrx1jYvSnw5YU=;
        b=BI55K2rN30KbEyGUSrI/MIKtu/rrla06+nm6ty6ZvFoPQ65liuBspUeethO0UJqViK
         kPk0PDIi3ML9owaLKDMAb0rsGrwNXJ23uADYi4uC/mNVeoKeUvqHC/CZItQf5/aj1viP
         km8fNWxilhuoCX3ULsiZy6ZdshozAZcyWkxeVV/DT3K2DwR8oZQPj3ixIPWAvFxi6aOz
         9o2L5jEuuH5BPmF9886SvlpahCzkIkTnHNgvO5KVDSO1r0JD1Kt/GCPOQnP1RysX2MJa
         mnUZhGJsECtc/k42u9LPRgxwOJmAD3mOX2Tvxo8YynByLlpWtqsfLMjEh2SBiPa/ENE/
         Y+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RY7k8+o8qeODmcHA1WccgZfqq3Axt7Lrx1jYvSnw5YU=;
        b=yFirlcDYJMgwP8vpOmLnoPlpQMOqA5IpmiVIDhHtKtLnUTeKu2yXKNI7O0zXIGBcE+
         8d/It8hoL7PCDpK95d7YtVcqO5BmerGc1PI1DONyf3AAHKD3xjzt1Q2i1Kskr/uc0kp+
         JlNDbhOfWEm7MPtRnGH/C7Nh+MoPqAXOxu7Cx4bilz3L16UHGDN2s2EadUpxNgZnyD7G
         IMjYJ9uLjDN38H76sCEEZlYYerfs7XuZjPU2uRqoE4SqThRbuiBZ7crABp4I4W0PobSf
         x37Z/U8+sJ7DRV5gnpd3fgvBYF21x8LXApvgbseZ5D/Aj5DYRF8S60UiuMwR0KGjzOr7
         9sAQ==
X-Gm-Message-State: ACrzQf3ir5QHG3tWq1gUma+Q6twiA0e9bshSASSbxvRf/BcZKorSINWM
        vbIg1XjxLriUNxSV6uIOw8C4viYuLUg=
X-Google-Smtp-Source: AMsMyM5S/KJ5jIsHMy2UVIzr7iYnu8TcGHZSOZzSOSolJCi/psXlVxpBr3GzRmkmqECoovCmHb8Hlg==
X-Received: by 2002:a05:6000:170e:b0:22f:7c62:6251 with SMTP id n14-20020a056000170e00b0022f7c626251mr21524490wrc.679.1666623641149;
        Mon, 24 Oct 2022 08:00:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x3-20020a05600c2d0300b003a2f2bb72d5sm9824475wmf.45.2022.10.24.08.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 08:00:40 -0700 (PDT)
Message-Id: <f32ff5dc4eed5bffe8bb0759c408c3d0861ddb50.1666623639.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1369.git.git.1666623639.gitgitgadget@gmail.com>
References: <pull.1369.git.git.1666623639.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 24 Oct 2022 15:00:37 +0000
Subject: [PATCH 1/2] fsck: remove the unused BAD_TAG_OBJECT
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

The BAD_TAG_OBJECT msg-id is not being used anymore, so we can remove
it.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 fsck.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fsck.h b/fsck.h
index 6f801e53b1d..7d99f6ea337 100644
--- a/fsck.h
+++ b/fsck.h
@@ -24,7 +24,6 @@ enum fsck_msg_type {
 	FUNC(BAD_NAME, ERROR) \
 	FUNC(BAD_OBJECT_SHA1, ERROR) \
 	FUNC(BAD_PARENT_SHA1, ERROR) \
-	FUNC(BAD_TAG_OBJECT, ERROR) \
 	FUNC(BAD_TIMEZONE, ERROR) \
 	FUNC(BAD_TREE, ERROR) \
 	FUNC(BAD_TREE_SHA1, ERROR) \
-- 
gitgitgadget

