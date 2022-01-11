Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A06DCC433F5
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 12:36:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239188AbiAKMgo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jan 2022 07:36:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238836AbiAKMgn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jan 2022 07:36:43 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC15C06173F
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 04:36:43 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id lr15-20020a17090b4b8f00b001b19671cbebso5625404pjb.1
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 04:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yXVoGlyESpfEQiBUMrHFwh7Y10zfzfcgrc3RIv6IyG4=;
        b=QWGZOyEL2NFUKGpxSSjcdiWY4nuNlY6Bx6qZ7Oq6RVL4WrLpw9IifQ4xVouJhbOXvr
         bhBIxvRgTmwqmTTwl+IhhbH0kfJsQNlO9S7yCNNF7jBgiQsyLYublAXZ+dPqG0dMcWot
         uZS1VOli0Xjr8xwVsTfzSi1ToN+ZZwwUD8XjaJG8mfMRLS1pfHxHU9NGy39HjnsgYD47
         ofiyNr8Bnx+BIpMYr0TXL0Bzlo7T+xujn5hJNdTCFtHNo8GD3HC7lbrVX4v3AvbXum5c
         bKtzzvxf9eNgL3ksfqaIsqJT2ShGFkSsZG2PvnjwR62Kvq6g8MVSWqJcp0fibB+z+pyM
         PE4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yXVoGlyESpfEQiBUMrHFwh7Y10zfzfcgrc3RIv6IyG4=;
        b=akFonw4LGwIEhWBBABXZsCXtU9xY42l72z+d0RYTC5KZUqnQ1xIhYjCqVwYPRBjpJj
         HLX4Yz5RKFrMj6bNhXEB1QWlodiNGMPC4Jy21/++/gYJVzlEANsPlQybx3vXVBkwk+gO
         BPIHv+UgJx0OT1F0mE1SY8NwiBNEJahUZrkvJj/xMi0mWoVkMpDbLmzfITZLQt+0BM85
         fRae1kOGpMdhbefNE3pMuw5wGsjQDCbOo6407ew1LQlswLwvkWuPI0y2UUIlwG5nwvvD
         CfdbciwQH7VOINIMEsvdxXz3nV4+JUg5PkwyozWaaMsCiCotWfnKf6vbAV5ig4g7LLJ5
         +PQg==
X-Gm-Message-State: AOAM5335uuKc8yC0Hsy9Aa8Ao6wtAb2nAdsdXqdAE0BTGSPmyiCG52uK
        4fNO+Tkjhu5qgRlmrCPTeKne0DUcFdM=
X-Google-Smtp-Source: ABdhPJxMgDABTPlWniIO7foAjoDdCTuGq8PHaKJrFaJnZa3Mc7yaPHo50lp3RypEjbSTZuSD0EoNQQ==
X-Received: by 2002:a17:902:8689:b0:149:f6f1:ab64 with SMTP id g9-20020a170902868900b00149f6f1ab64mr4107580plo.6.1641904603001;
        Tue, 11 Jan 2022 04:36:43 -0800 (PST)
Received: from ubuntu.mate (subs32-116-206-28-58.three.co.id. [116.206.28.58])
        by smtp.gmail.com with ESMTPSA id x25sm10149486pfu.113.2022.01.11.04.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 04:36:42 -0800 (PST)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     Anders Kaseorg <andersk@MIT.EDU>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH] branch: missing space fix at line 313
Date:   Tue, 11 Jan 2022 19:36:27 +0700
Message-Id: <20220111123627.58625-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The message introduced by commit 593a2a5d06 (branch: protect branches
checked out in all worktrees, 2021-12-01) is missing a space in the
first line, add it.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 branch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/branch.c b/branch.c
index 829130bb11..5d20a2e848 100644
--- a/branch.c
+++ b/branch.c
@@ -310,7 +310,7 @@ int validate_new_branchname(const char *name, struct strbuf *ref, int force)
 	worktrees = get_worktrees();
 	wt = find_shared_symref(worktrees, "HEAD", ref->buf);
 	if (wt && !wt->is_bare)
-		die(_("cannot force update the branch '%s'"
+		die(_("cannot force update the branch '%s' "
 		      "checked out at '%s'"),
 		    ref->buf + strlen("refs/heads/"), wt->path);
 	free_worktrees(worktrees);

base-commit: 90d242d36e248acfae0033274b524bfa55a947fd
-- 
An old man doll... just what I always wanted! - Clara

