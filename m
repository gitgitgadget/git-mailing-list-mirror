Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A1FCC00140
	for <git@archiver.kernel.org>; Mon,  8 Aug 2022 13:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243399AbiHHN2M (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Aug 2022 09:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243352AbiHHN2A (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Aug 2022 09:28:00 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A4B9FE7
        for <git@vger.kernel.org>; Mon,  8 Aug 2022 06:27:58 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id z12so10883412wrs.9
        for <git@vger.kernel.org>; Mon, 08 Aug 2022 06:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=eLjEx9Bl9ywnepjxjVCPdZ6lH4L+q5Q+sk+026AsdWw=;
        b=CGlkPgwbvvJqs/7qBj/fRl9xSvrOXyT98bRe5nu1GBfN+MXErMe57E+HRZrZQziPov
         e2V+ecbqtireC5yF6LrDOkfAxX1/UBDeAJ/tbA1a7iArgw8P2xOognbIbu4VUMNJu1Qh
         qz8daoLLI3pRADSP5RN6FWeJ0NTzPBcku8cHPXG2E0Njkfw9AT1rIFO5CcJJOmMjaJwG
         teswRxVtumYO6sbzpmhNRONFIg6oiepQjoAmR8hvYNAIrtoD9u7hFcW1kmW95zraWJWC
         T/Nl8jzgaaT/czbZCCzSntl7accTvxbA7J4qQnV0UU2hl3VxxcDVmp/Iof47SXi925Q1
         N7gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=eLjEx9Bl9ywnepjxjVCPdZ6lH4L+q5Q+sk+026AsdWw=;
        b=apm8KmcNo1Aj77omadsc7d3IwvAjDanexBWpuj1ay4I0bWJB6xrH9BccXrp8vEAXX0
         BNykj1wdqQhdpKykUR3po/oyyDMnUMNR+38pk+no4U8QxYHV+PPG0zMKDKB1TUb9iCtc
         kKcMcw9MBmrireyUw5kS1PTXKqmAYRYqxK6aKkDNH0NpRDNyyAni/dDffa1QL4vrxRi/
         cNK9+SwGXQ6+Fx0yu7l9cvjBnmSH2grYYB49Wz2cWzOEPYBbOOzjPt1QQ3OA/vkCokRQ
         BwWMblRZdnWMajx2GwMR+QYEQwVvxDsuPT9m9m4gkvsNtDxnEnRPPztrB3rQ5IrjGoPa
         dI4Q==
X-Gm-Message-State: ACgBeo0nfrr6dmaBYhmGOj09u/CIiZ0kN3c1Wg9eNzphzimbe6XYO2mO
        Ubb0mUhDf0Ebuhk/UiMZevrvBN1Awjk=
X-Google-Smtp-Source: AA6agR4CQFw4PBv6jD6zCpM88M+uUX6ZSTfCD1zmVHnYOUY1laDrkfWpwoe0//IHqgKZQbdT2iKbNQ==
X-Received: by 2002:adf:efc3:0:b0:21f:15aa:1b40 with SMTP id i3-20020adfefc3000000b0021f15aa1b40mr11354920wrp.159.1659965276845;
        Mon, 08 Aug 2022 06:27:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w15-20020adfec4f000000b0021e6b62fde2sm11193001wrn.59.2022.08.08.06.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 06:27:56 -0700 (PDT)
Message-Id: <fbfaff2ec21d76229eb4d86f6bfe4eab4de20c96.1659965270.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1286.v2.git.1659965270.gitgitgadget@gmail.com>
References: <pull.1286.git.1657700238.gitgitgadget@gmail.com>
        <pull.1286.v2.git.1659965270.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 08 Aug 2022 13:27:50 +0000
Subject: [PATCH v2 5/5] mingw: handle a file owned by the Administrators group
 correctly
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

When an Administrator creates a file or directory, the created
file/directory is owned not by the Administrator SID, but by the
_Administrators Group_ SID. The reason is that users with administrator
privileges usually run in unprivileged ("non-elevated") mode, and their
user SID does not change when running in elevated mode.

This is is relevant e.g. when running a GitHub workflow on a build
agent, which runs in elevated mode: cloning a Git repository in a script
step will cause the worktree to be owned by the Administrators Group
SID, for example.

Let's handle this case as following: if the current user is an
administrator, Git should consider a worktree owned by the
Administrators Group as if it were owned by said user.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/compat/mingw.c b/compat/mingw.c
index 22f960c7e34..7aa9318db72 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -2728,6 +2728,7 @@ int is_path_owned_by_current_sid(const char *path, struct strbuf *report)
 	else if (sid && IsValidSid(sid)) {
 		/* Now, verify that the SID matches the current user's */
 		static PSID current_user_sid;
+		BOOL is_member;
 
 		if (!current_user_sid)
 			current_user_sid = get_current_user_sid();
@@ -2736,6 +2737,15 @@ int is_path_owned_by_current_sid(const char *path, struct strbuf *report)
 		    IsValidSid(current_user_sid) &&
 		    EqualSid(sid, current_user_sid))
 			result = 1;
+		else if (IsWellKnownSid(sid, WinBuiltinAdministratorsSid) &&
+			 CheckTokenMembership(NULL, sid, &is_member) &&
+			 is_member)
+			/*
+			 * If owned by the Administrators group, and the
+			 * current user is an administrator, we consider that
+			 * okay, too.
+			 */
+			result = 1;
 		else if (report &&
 			 IsWellKnownSid(sid, WinWorldSid) &&
 			 !acls_supported(path)) {
-- 
gitgitgadget
