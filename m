Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6164BC433EF
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 18:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240275AbiCVSY4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 14:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240260AbiCVSYk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 14:24:40 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D1CBFA
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:23:11 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id m30so14799631wrb.1
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sCXgYeR36GUqmZmNkmliiej5zTY6qgDP8cvb8xuW+qw=;
        b=Kg8E0aAyULo0LgPZeaKvqpmuo1dJlqCpvv0gN3sRSmI2zbjHg8cMJ6BE2ow8KQBQiC
         LjxpJLoka7m2A1FpG7uDUgjLkl+Cyjc6u/DtWyes5ObmN7Y/BQ0WnNBsE+/scEYK2JGI
         OWuPhRi8TwpwtHlnM1ZntwCWCnaDrx3Fm6z8jPPRnQe1PEYhQj2i08hhCHbRKdmfrjm/
         nB0hJHRooPYQCljkCz3zezlfq+K1F+EyxDT5c5kXMH6DyVjZQb8YAcaJqfRVVr0F02cx
         CA3TLYT1IBOUa24S0d0akQdWTF7dURzqIg4F2VdOH9JTs0QBXFb71f+b7OUSaEe1ZKgs
         YY+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sCXgYeR36GUqmZmNkmliiej5zTY6qgDP8cvb8xuW+qw=;
        b=5753yPhu4/OGKPb/Sz1cmTq/5xGQxG55YrQn3kC33pSjZJBGQvjGWLC3eWyJ7Sg0g7
         C6GhclUlW0IAKN+Y4tj35gcKIyR/iToxVrUSh0BVK40NOMpu5W6pBE20xI3JwXGZUDO9
         xNWNOddKER72BqVpY1sxikao2LWH5Vad/lqnsM8lFidyleRBAIjpIvUnTYVk+775k4it
         npdhhBD8uosLv1kr/jzISXv3NCHt49gjNwIIUQ1dTjC7EbwctSIoOJs5Jn//8mSlO4gl
         BuHtElaoyrisHCUSPr10XNuvzk6ZBV+1VVC2PCw35nd+jTrPpIswUI3wqhmp4FSwlY23
         EkFg==
X-Gm-Message-State: AOAM5310m6HjlToeThJv5AkVi4/VbfIkr0Vez57X3+pcj4NgZt/79tEt
        iTiGJjB4tBBWoPmXHn3GYFtjYoVuq5E=
X-Google-Smtp-Source: ABdhPJxSVI0SRUMG2oDxmQBfe787q5GcNGjk+knqmYvdtHQq9E9ke+F0d9pUoRh9pBK6yAUdLZ/b1Q==
X-Received: by 2002:adf:8148:0:b0:203:f970:301c with SMTP id 66-20020adf8148000000b00203f970301cmr17517215wrm.508.1647973389872;
        Tue, 22 Mar 2022 11:23:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u12-20020a5d6dac000000b00204119d37d0sm5930342wrs.26.2022.03.22.11.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 11:23:07 -0700 (PDT)
Message-Id: <11d4a17b69239bdce17a7b4d76a3491c29976c13.1647973380.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v3.git.1647973380.gitgitgadget@gmail.com>
References: <pull.1143.v2.git.1646777727.gitgitgadget@gmail.com>
        <pull.1143.v3.git.1647973380.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Mar 2022 18:22:35 +0000
Subject: [PATCH v3 02/27] t7527: test FSMonitor on repos with Unicode root
 paths
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Torsten =?unknown-8bit?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        rsbecker@nexbridge.com, Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Create some test repos with UTF8 characters in the pathname of the
root directory and verify that the builtin FSMonitor can watch them.

This test is mainly for Windows where we need to avoid `*A()`
routines.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/t7527-builtin-fsmonitor.sh | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
index d28a74feeb9..429029fcadd 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -656,4 +656,27 @@ do
 	done
 done
 
+# Test Unicode UTF-8 characters in the pathname of the working
+# directory root.  Use of "*A()" routines rather than "*W()" routines
+# on Windows can sometimes lead to odd failures.
+#
+u1=$(printf "u_c3_a6__\xC3\xA6")
+u2=$(printf "u_e2_99_ab__\xE2\x99\xAB")
+u_values="$u1 $u2"
+for u in $u_values
+do
+	test_expect_success "Unicode in repo root path: $u" '
+		test_when_finished "stop_daemon_delete_repo $u" &&
+
+		git init "$u" &&
+		echo 1 >"$u"/file1 &&
+		git -C "$u" add file1 &&
+		git -C "$u" config core.fsmonitor true &&
+
+		start_daemon -C "$u" &&
+		git -C "$u" status >actual &&
+		grep "new file:   file1" actual
+	'
+done
+
 test_done
-- 
gitgitgadget

