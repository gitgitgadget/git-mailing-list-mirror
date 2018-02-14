Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE94E1F404
	for <e@80x24.org>; Wed, 14 Feb 2018 19:01:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162522AbeBNTBN (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 14:01:13 -0500
Received: from mail-oi0-f74.google.com ([209.85.218.74]:54008 "EHLO
        mail-oi0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162516AbeBNTBK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 14:01:10 -0500
Received: by mail-oi0-f74.google.com with SMTP id 24so11369409oir.20
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 11:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=FajR2nxp8FE79hibvzctvVq2xRKEQ86x/idjCIOHvbI=;
        b=hdNlSEv0S0kSWoTUCuK7q3cyvWXDyxaGGqoleACcZPQXDK83j2cTW72SsV9jKlCwSM
         ORyuREia1r87eAoLy2JqCAWhsxr6kFY7iDjPj9QL8iW3FeG4er8KnPIMAxvGAocWc3MH
         mFbZMLRMG40e+9e+fUnN+3uqnD9a9sHWTT9b3PbHNJzWKFKJW9R2gA2YqLRMwa/pUi48
         dLgay03tbYK51No7gONMzmQSAS9eSYpv1VvLk/VVlu2sy/TTMqYs/JVSpStM+dA5MvFR
         Aq5NsMfJYbRBZMBqdCtMbpuXtC4QrszH08Irk1yN2/6Y3ESeuHVKgG+P421f+d2DzjsB
         6M5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=FajR2nxp8FE79hibvzctvVq2xRKEQ86x/idjCIOHvbI=;
        b=byJp3+BxIVC8AL9v9FlxHPRoBC/2ATMa0EXGBkHSt7TYrWfv7o9b5bWdpQ1nbcyYQO
         1IX+Z9iPlDTYZvS4MjWwmeSmNTXjm+x9fhUkka+0JD3Oc7Z+OaW8Xzb2/uFVCA2AxiiX
         iFOxErplpOQQfAaCGERi4/qla+gLv88zBHLUJah7499vldFiOclRh9D/0tM0cOGfzhZZ
         hSgTtmcshIjW7Ta7AjjJPigZQLv6uvTUBcPE7iYL3WDX9s5k9D12WN/hFYwaryxcMvth
         TShwqOnAuPNKTUdNz1Jayl3ss0kG8O3s17F/nC1U0iqQb+j0DT1cwTMZsgO+c/QcZDaF
         H5Qg==
X-Gm-Message-State: APf1xPD6pLwl165lf2GW/ygvpoXkvCM3bwXq0Uxig8hFVROV+glVMyj9
        cXMJ9+5LHVJXj8w7oPRbVl+COBZ4KH3VEmmqV9QvNZC5rYgC7fwv3ZZau9sNu0ZFBRk7iJaIugg
        yA1vM260Le+AM8B6/OBLC676ciBZcC9w7Fak8Nq0M8jVs+O+6vwO3BTQ7Xw==
X-Google-Smtp-Source: AH8x224eJKac478+cy+Z6ECEzWlQxpJ5puTRz1qzftv5MLc2qshX/WTXcn0F4rHzD0bnT+SRXfUvVeEeIH0=
MIME-Version: 1.0
X-Received: by 10.157.51.148 with SMTP id u20mr12132otc.77.1518634869320; Wed,
 14 Feb 2018 11:01:09 -0800 (PST)
Date:   Wed, 14 Feb 2018 10:59:32 -0800
In-Reply-To: <20180214185959.221906-1-bmwill@google.com>
Message-Id: <20180214185959.221906-11-bmwill@google.com>
References: <20180129223728.30569-1-bmwill@google.com> <20180214185959.221906-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.1.109.g93438bbb9.dirty
Subject: [PATCH v2 10/37] help: rename 'new' variables
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     j6t@kdbg.org, sbeller@google.com, avarab@gmail.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename C++ keyword in order to bring the codebase closer to being able
to be compiled with a C++ compiler.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/help.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/help.c b/builtin/help.c
index d3c8fc408..598867cfe 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -194,11 +194,11 @@ static void do_add_man_viewer_info(const char *name,
 				   size_t len,
 				   const char *value)
 {
-	struct man_viewer_info_list *new;
-	FLEX_ALLOC_MEM(new, name, name, len);
-	new->info = xstrdup(value);
-	new->next = man_viewer_info_list;
-	man_viewer_info_list = new;
+	struct man_viewer_info_list *new_man_viewer;
+	FLEX_ALLOC_MEM(new_man_viewer, name, name, len);
+	new_man_viewer->info = xstrdup(value);
+	new_man_viewer->next = man_viewer_info_list;
+	man_viewer_info_list = new_man_viewer;
 }
 
 static int add_man_viewer_path(const char *name,
-- 
2.16.1.291.g4437f3f132-goog

