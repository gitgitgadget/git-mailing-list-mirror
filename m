Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C16A0C4332F
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 17:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbiLLReE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 12:34:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233023AbiLLRdj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 12:33:39 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E122BC4
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 09:33:30 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id ja17so3209352wmb.3
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 09:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Reyr8Pyqpy9YCMGpliM/nnpFRAyJ1iyyQG1u1NYZFCU=;
        b=CNSI8KvwX827ZTbBNi9ysh/ns9cmi4sUMPqjM3a9l8SQCGGl4E7xRBB1pCVcSAPUoY
         MydJowWfxjgps8j3SOViBKaEDiJspYttW8PJEjl1wrGRL1j5/Q0oeSTnBOFfSdDd2fBo
         AsgSsjxD1o9kwsTrNJiFAgxMWTm4YQNTzQhPmv7gBeOsQa/rGWae1kk2lQ12NHXUGAP4
         UGTYLOil2yib+u5A1HsaySnP3DQW5L0KwVojB+RMgGPRKpRBQyU5xmgD4+jMTcjaGjoG
         3456zRkcybJ+2mblZe9byUK2jWT6b7MvlwkBgja8EW9Bb2/XbJnIrjptZAhrXTdbJPMz
         D7XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Reyr8Pyqpy9YCMGpliM/nnpFRAyJ1iyyQG1u1NYZFCU=;
        b=PbWUG0VvSpX8FTTFMWEhWEDTMBRj2MdA4PCb+bObCT1EYXpiiHHUBUYA9n11qMr8/o
         T5e3rUP2lOasL3NFWSyymBV4rHI37aLwJoVKosreTChoOHu/QQF7WfMMTF30p4Jg66SH
         kWw9ymiIX/47osxyPl1QiIZlY47QqufWKCUbDTu25tfS1GLW5OCNZB+H27FESwj8CVty
         srtJMhWVlfL5lrIYaEvwtc3KDY37rGXFM363KFF5DNr73KokxJRRv/WzKvL8qrxf1i7n
         QPo02v3VSOWPIykNh3ir58b3kE4tWT+dGLnlHLsNLAeeFsIgiRbL8L1i1SJo7joEQ5aw
         Vx8A==
X-Gm-Message-State: ANoB5pmSaIyaOtTo/rpTBqjSZFpe0JIct1gWQABicGCtottVuBlXkBEm
        F03tDgYM0OLJFO4SimdEi9CcjFU5cCQ=
X-Google-Smtp-Source: AA0mqf6+pNayil6TjQRos5ygd6MdB3wZf7bRRy0P55S04CjWetiLeLGtXMYzzknUxPof0ZlJUMax7g==
X-Received: by 2002:a7b:cd89:0:b0:3d2:2651:64bd with SMTP id y9-20020a7bcd89000000b003d2265164bdmr3536196wmj.10.1670866409405;
        Mon, 12 Dec 2022 09:33:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j18-20020a5d5652000000b002427bfd17b6sm11282694wrw.63.2022.12.12.09.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 09:33:29 -0800 (PST)
Message-Id: <857d1abec4cf124e011c7f84276ce105cb5b3a96.1670866407.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1443.git.1670866407.gitgitgadget@gmail.com>
References: <pull.1443.git.1670866407.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Dec 2022 17:33:25 +0000
Subject: [PATCH 2/3] bundle-uri: advertise based on repo config
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, vdye@github.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The bundle_uri_advertise() method was not using its repository
parameter, but this is a mistake. Use repo_config_get_maybe_bool()
instead of git_config_maybe_bool().

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 bundle-uri.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index 8efb4e7acad..5f158cc52e1 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -610,7 +610,7 @@ int bundle_uri_advertise(struct repository *r, struct strbuf *value)
 		goto cached;
 
 	advertise_bundle_uri = 0;
-	git_config_get_maybe_bool("uploadpack.advertisebundleuris", &advertise_bundle_uri);
+	repo_config_get_maybe_bool(r, "uploadpack.advertisebundleuris", &advertise_bundle_uri);
 
 cached:
 	return advertise_bundle_uri;
-- 
gitgitgadget

