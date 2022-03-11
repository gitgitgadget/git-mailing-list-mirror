Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85BB4C433F5
	for <git@archiver.kernel.org>; Fri, 11 Mar 2022 22:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiCKWyp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 17:54:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiCKWyc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 17:54:32 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4391B45A1
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 14:28:07 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id k29-20020a05600c1c9d00b003817fdc0f00so6132317wms.4
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 14:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+jHYzLlWfGJj3bXjxRpyUr6X/pm7zr0+zCujXJgOCoY=;
        b=JYavHcpWGC+Sv78K3CNAgZyqqoCjsYoMAU6Xp4DS9NpDefrn44fIHsjdJt53ZDTRjb
         rc7VYD7mglQgYe+uu8J3rpYhM7+RhtRodlruBnE9Ok4Wq31zrbI411G4EIuc1iwFqJ8h
         VTB+Cb7Te2MqlPwpW1MNFyDAytyz0TwuFQfk3NsIL6D+3T3aI3ZF/7f1iOJVH3FrvRph
         cOEP1DU1u+WmjL3T007wUUFJHpAWEApCtE1GKqvoR0cULKImIMFBVkpGwq5BL384bm8t
         /qnNj2Gx2v9mGY5MERPQ6CJkHVr6JDELp3SG/jpVo8w3q9RqKLKRA8lNkkzu+XKUjFq8
         azvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+jHYzLlWfGJj3bXjxRpyUr6X/pm7zr0+zCujXJgOCoY=;
        b=Dx9BFiz2fMcy7d7pJTo9enujL4D+EnsFCJzPfjkjsxsQfLNtMRVm6tREWQKfSGMAUA
         Wsf4pYBKxcku+jNkrYqLF8rgsydg5qIVeXhd4NwiZR+FH6U3PZiTWbt3SGzVewG54mPF
         FtmgykuFbClr6mr3yMo8EUDdx92wZEqh6rD72dKExzO/s1oH4xNQJPibAHIsDTKNXJP1
         xS8wbmx50eOBdZbwga3lNC/EH/ykGkUWBXOHZqcqX/Z7F9vG+plL5p4WsO2MPRcJeOG/
         dNRPXDUZv8K0Nm0iwRH7eWqsMCrbaPCM4cVXUboduIhdYyhQhXDZg0uSIQyRDwXV3fNy
         qmGQ==
X-Gm-Message-State: AOAM533GJKYJvGbRLOX0cZsmIRwWnyA9xeFTHnATE4PSlqRqW9OpxkLG
        ZMJJDX5tYz7xlv2xKjCQ4loN4n8ihwI=
X-Google-Smtp-Source: ABdhPJyMggJuBZbFlTTkkh67IoKfOIZ3OWiU57QKM94qHwx+MOvLL+CAYIpZi8CKE3JHAz412kvyHg==
X-Received: by 2002:a7b:c11a:0:b0:389:a2be:2a5a with SMTP id w26-20020a7bc11a000000b00389a2be2a5amr8712208wmi.25.1647033311578;
        Fri, 11 Mar 2022 13:15:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h13-20020adff18d000000b001f1de9f930esm11043092wro.81.2022.03.11.13.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 13:15:11 -0800 (PST)
Message-Id: <903643c449821f24d80c999b50031945c79a0a7e.1647033303.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1174.git.1647033303.gitgitgadget@gmail.com>
References: <pull.1174.git.1647033303.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Mar 2022 21:14:56 +0000
Subject: [PATCH 09/16] t7527: fix && chaining in matrix_try()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

fixup! t7527: test status with untracked-cache and fsmonitor--daemon

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/t7527-builtin-fsmonitor.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
index 026382a0d86..f60e211dbab 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -536,9 +536,9 @@ matrix_clean_up_repo () {
 }
 
 matrix_try () {
-	uc=$1
-	fsm=$2
-	fn=$3
+	uc=$1 &&
+	fsm=$2 &&
+	fn=$3 &&
 
 	test_expect_success "Matrix[uc:$uc][fsm:$fsm] $fn" '
 		matrix_clean_up_repo &&
-- 
gitgitgadget

