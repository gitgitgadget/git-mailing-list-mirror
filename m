Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B4F9C6FD1D
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 08:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjDAIqm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 04:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjDAIqf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 04:46:35 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D77EC6B
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 01:46:34 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id ca2-20020a056830610200b006a11ab58c3fso12466849otb.4
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 01:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680338793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rr0wkzEqfI6Hg6o91HnD2M/16KjNG1MP5jbC34nQk8o=;
        b=Z817JxJWnNVurssXL535JsDChuTzMOSMFji6XfFwR0+d9PREKG0ilY9IM4/rNOu+hX
         g83S5IrthFktReIMPzaijhu2AueKX58HT47dh+Q2Xd9sC7zlI8Ru3AHPEH72rHNycoTt
         25PaxcoSJcAqlIvSK6qlbdPuAjqTsYqPzOkGeo80Kj8n1aJ0QjIsNiPPBIzC9l4504Ya
         ioU2qAdn8mAFOUQrTZ+hnEZv0/KNZgkqeBOQlpx6jqka5Sp0jnCHbHXuhKgPhYQTy7OR
         EEkmiMslO6AG3kunmR2Wp8yZDUtMoJQj1Ulu8zI0N+ct4iRyqRHpE9OsZmy2T0bYgb89
         7RBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680338793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rr0wkzEqfI6Hg6o91HnD2M/16KjNG1MP5jbC34nQk8o=;
        b=3pkne3pQ2yEjHXRc9VTEeIRYqYK+4Nw2Mw9Qo84pTz/VjVfxozuuPbs2iNj5ARfKyR
         ODyXsHoKkaaRNYzyyukU2MgX6X33XI38x8Pmumnmpgtcl3++Eht0n/X/By2U2R1IySDn
         yqtsupecDj7L3cOwy9cHgqRiJOJFC2Jj0GXj3vBp6Z4O0Crh8ydxXtc3n49K7IRwhWLh
         thxlbAjFB/SF2LNPOsw56TLanMU45/yxVlbWOzDiRmohKy7zMKzv3tPWDh4cS0/JSGVq
         W8LdUeCOli2K2QQ5H1EG0H/wmwsBMGbs4RfE32m5MAXRtYkjxFdeuS3qBvvHZIwvo8or
         VxwQ==
X-Gm-Message-State: AO0yUKW4HgTwINOzR4Ka/3yO+wpLSntcUN1nhWuP+hWIlH+c4RUA1FsX
        a9ZZBP9qxQqqn1ybcwcGzgdmXIgasd4=
X-Google-Smtp-Source: AK7set/e4kfduXrp7WGlUIvud3HcALQlaLvdI3MrQXimx7sn8j+L8EJ5Seex/dbN/KHJH9rBLANiEw==
X-Received: by 2002:a05:6830:1bc7:b0:69f:9779:a216 with SMTP id v7-20020a0568301bc700b0069f9779a216mr13601441ota.30.1680338793594;
        Sat, 01 Apr 2023 01:46:33 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id d27-20020a05683018fb00b006a2f4a754e8sm1152114otf.60.2023.04.01.01.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 01:46:33 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 04/49] completion: bash: trivial grammar fix
Date:   Sat,  1 Apr 2023 02:45:41 -0600
Message-Id: <20230401084626.304356-5-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230401084626.304356-1-felipe.contreras@gmail.com>
References: <20230401084626.304356-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 45eaea57d5..cf6ff0595f 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3330,7 +3330,7 @@ _git_worktree ()
 		# Here we are not completing an --option, it's either the
 		# path or a ref.
 		case "$prev" in
-		-b|-B)	# Complete refs for branch to be created/reseted.
+		-b|-B)	# Complete refs for branch to be created/reset.
 			__git_complete_refs
 			;;
 		-*)	# The previous word is an -o|--option without an
-- 
2.33.0

