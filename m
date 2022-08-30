Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766CCECAAD4
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 09:35:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbiH3Jfx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 05:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbiH3JfF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 05:35:05 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69500E68D9
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:33:13 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 92-20020a9d0be5000000b0063946111607so7658442oth.10
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=44HHDgpUjqwYn97esXWH6mQcjyhG45ZoEdWVWlQwTc0=;
        b=M/NApWUpEtt5BV7qobLEFJgcZ71PTP/n+8A+Pkcv6A1ivtz/AM1UfxMnUGfMScCoSx
         Uh2XuvXBxC2ZfKRKU5rI2XfT6mmYrYUkxd99sIAafI+MtmngBx8QpOKvECI8b3uZm+B4
         lHL9vftCc0SWnirfg48mjAPSC2Kj3Fozz2Cxsss9IKdoUFE7DUG3eu9+aehXACPpT7bD
         BVNCfuL66C0mF8fChR56a4HBDuAdXklDg8yvHukJgj2jmUeXVB7kbpfBjloohPp7fUFq
         cUq7iG6xfo+yPPw87isRuG4AU8tbmiKSZnQ36CstYT184HeVFakDIS3fg9hIJQcPTGwX
         hd9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=44HHDgpUjqwYn97esXWH6mQcjyhG45ZoEdWVWlQwTc0=;
        b=DlWlJR0t6umG7e0zGzEUxq7CvNEJzwhg2jdJltIXpEsdEF80K9lC50XwXobcMk9LFT
         kLpJGHLyCSD352fOZJ5nr6eMOaiGzUDheyzb3NokwW/OvjHhUZUj/j8Wnbcw5Vh1I44k
         wVnVZJacu5WyYIcRp67ozv8ywiLZX9dpL5Y1Qer0pQIz5xBASBE6cTmY6rPV8LuP3phU
         HKsvz/nui9jMvA8IivzagIm4jLCmwjV6ohReMzc/yc5B/hqjkA9xzI7IniNNq5i9L15c
         llM8Z6Qvn6ZGPUuT3F3h9TK+svhwk1pBmtgxv1ecOQs4x8kquQ2w6MkweSuUJA8FwWri
         A9nw==
X-Gm-Message-State: ACgBeo3W0dYooxMtrSwBH5LRql9vKVYKQiEjfC4Ke3DF3WCMHoIG+1pk
        811q1GXMtBEcZfwLjQ3glu3QLF1jmvw=
X-Google-Smtp-Source: AA6agR5pd9OVDULK9sbXFYZda0QDFlGeViUkjMSdNiOV4PyDvXyeaowckB01gjb7rcMGix8UAGIomA==
X-Received: by 2002:a9d:66cf:0:b0:637:1d30:d72b with SMTP id t15-20020a9d66cf000000b006371d30d72bmr7919709otm.35.1661851987351;
        Tue, 30 Aug 2022 02:33:07 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:eec:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id g17-20020a544f91000000b0033a11fcb23bsm5981649oiy.27.2022.08.30.02.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 02:33:06 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     git-fc@googlegroups.com,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 51/51] completion: bash: trivial grammar fix
Date:   Tue, 30 Aug 2022 04:31:38 -0500
Message-Id: <20220830093138.1581538-52-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.37.2.351.g9bf691b78c.dirty
In-Reply-To: <20220830093138.1581538-1-felipe.contreras@gmail.com>
References: <20220830093138.1581538-1-felipe.contreras@gmail.com>
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
index 77a475e272..dffb34266f 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3152,7 +3152,7 @@ _git_worktree ()
 		# Here we are not completing an --option, it's either the
 		# path or a ref.
 		case "$prev" in
-		-b|-B)	# Complete refs for branch to be created/reseted.
+		-b|-B)	# Complete refs for branch to be created/reset.
 			__git_complete_refs
 			;;
 		-*)	# The previous word is an -o|--option without an
-- 
2.37.2.351.g9bf691b78c.dirty

