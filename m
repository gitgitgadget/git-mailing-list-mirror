Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE736C433EF
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 18:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbiBUSqr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 13:46:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232053AbiBUSqh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 13:46:37 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D50CDF
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 10:46:13 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id n8so10025580wms.3
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 10:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=W5Yj2jthDENAX/pjHPe/3jF4bTw09ifuA6lPu72S2Y4=;
        b=e/dJuRPdx+mLDqGWMd0jXuYljLyXFjbUj+35emoXH9MlA60cXkgL3+upQBn8NjJJQe
         fQSwn6ETFvGPNP0vq1UK57D9+vYKddNavVIRJNwVLLiQ2yXNV568aN11AXU+wX0aTLdC
         kBh8mgn97FwvgTvoa7OlCzFY1pnUP735jcEqobBBtTS+75biMywXQVMQlL3Xno7OTYS8
         cPPcX2+LnnlNNYcOGRMJlHZvpx7X+ZUMvfVZj32Ci55MRttkGoMIm3DyCUrmkO6RXc45
         SZgMxD5887v4kIQX4uK3jk4/D2Wfx7ol/90hr/+fhrXkhOBBGR0qSgcuNtEeWpJXtA9+
         TysQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=W5Yj2jthDENAX/pjHPe/3jF4bTw09ifuA6lPu72S2Y4=;
        b=41xNJuRBn8DCTf+By2TKzreikf0EjcLIAGdy8Dv44C07gR81I7WWROJihOnA65p0lu
         AOkzSXcHPssduFgwM7wGV/K0oYMTgFgVzFo18IRu1sV+hRPf76D5GdQhN5M/vaNZD2ri
         MCkV0LsaadQr1WYmLQuPRG74g9OwgpVmYllOsyAThVyu7X1gyWn44yqMPWl/VC4s9IYM
         T9Vu4UKPE/NQxk5kiTdmpqYdhqV5tLU6Ls/Z5tKr5ORlx2lmM81jHCxUYVNmup2TZbui
         /LYokNqgiQ8lj1Q4yEzVoZKkftL+bUo40VkuuudB+39JT0zYXLGszq5o4FdVFogravgA
         oX0A==
X-Gm-Message-State: AOAM530NSYi9fcuIgISIBn1f0cemdxJ3CRTyTM7CmdeUQ2cByBB+0Opu
        4rLi+7fu4OtkePE/39o4ZUOKAOXP2s0=
X-Google-Smtp-Source: ABdhPJx4zp3X3OZAzSiRD65VFWLyt9wjP4vx1T3ujmeOUL/yIj/VLatCDvra/v/7QplSElW31IenfA==
X-Received: by 2002:a7b:c055:0:b0:37b:dc5f:7f48 with SMTP id u21-20020a7bc055000000b0037bdc5f7f48mr289788wmc.110.1645469171852;
        Mon, 21 Feb 2022 10:46:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o12sm1060999wrq.117.2022.02.21.10.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 10:46:11 -0800 (PST)
Message-Id: <80d29e8f269bf0888d5b1db5f941d1a9bf89c86a.1645469170.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1185.v3.git.git.1645469170.gitgitgadget@gmail.com>
References: <pull.1185.v2.git.git.1645106124.gitgitgadget@gmail.com>
        <pull.1185.v3.git.git.1645469170.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Feb 2022 18:46:04 +0000
Subject: [PATCH v3 1/7] Documentation: object_id_len goes up to 31
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

The value is stored in a 5-bit field, so we can't support more without
a format version upgrade.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 Documentation/technical/reftable.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/technical/reftable.txt b/Documentation/technical/reftable.txt
index d7c3b645cfb..6a67cc4174f 100644
--- a/Documentation/technical/reftable.txt
+++ b/Documentation/technical/reftable.txt
@@ -443,7 +443,7 @@ Obj block format
 Object blocks are optional. Writers may choose to omit object blocks,
 especially if readers will not use the object name to ref mapping.
 
-Object blocks use unique, abbreviated 2-32 object name keys, mapping to
+Object blocks use unique, abbreviated 2-31 byte object name keys, mapping to
 ref blocks containing references pointing to that object directly, or as
 the peeled value of an annotated tag. Like ref blocks, object blocks use
 the file's standard block size. The abbreviation length is available in
-- 
gitgitgadget

