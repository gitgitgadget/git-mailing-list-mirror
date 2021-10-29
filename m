Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38AE6C433FE
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 19:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 201ED60FE3
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 19:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbhJ2TzR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 15:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbhJ2TzP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 15:55:15 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D99C061714
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 12:52:46 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id s13so11031629wrb.3
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 12:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gzDmMQp2OIl5FNJPz7ERa5DTCVyvp/7DxWEw0bsfaNQ=;
        b=UQZGgtI5Dy6yC9E/uhNdJekBO4S4Ux7KAHTLX3M8xWqMG914dyav1D5Xnf09ujZaHG
         nU8mVxeuNM7sa9ioaSKnnD9O200pnm5zUjB3OnaChE2+pts4gxxzHiOCWki5IgyosuUT
         3lpaSpo1XuiTcUabHX36gjjpUerjvkolJY0/+1soyO/idarPi+VIXoLnXQtBQgbyC0Y8
         NlmOe3iBaq1C6/+Gbacmp/jz7hLMklm+8KjzIsb7m4vQmdK0WXdu/VtxDipFrJK+Zb9A
         DDzEyhcbQQuosv5rnocjIsdvQ0FMT2SpZ46aPeGiMMcO94Z5rVWexdkTb4mpQbK+eJE5
         K/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gzDmMQp2OIl5FNJPz7ERa5DTCVyvp/7DxWEw0bsfaNQ=;
        b=QD1zSxDhgaA1cZ+wBw/6S7YiXd0OzxZLx1LKaP4Uj/cIXYyD1ihbc7RgLY3ScoUgne
         d0y2vOhb4MMrbGl/wTsq38qU0zAqu4p+IPMTozAVVcfMTQOFOMGWWP0U7Fry3zf4mUMe
         g5hlAni/1+JLI2I5YxiEgPzpFTV4vR7xlAWYlaLHSxyY2p+5hhZFudXZ2cmAUU0c30Ee
         exLe5twk5BbyQpQVjXVyBvB1iJ1T0j8TfwNkQexRT5z/BCqsuVvJlmmx5Cea5r/08U7a
         obhPFukjHmURetGiWylWjPcXE4YnRQ+ReYg9jRGfYr9SW0kdg3sEXkYjtxscGa2QUixZ
         KyPw==
X-Gm-Message-State: AOAM531CGUXuI4CLoqfozzXD4AsaTtHYHxPkd9d0N+rmgSmfyLFSl5Jm
        m5AUHTUe8UH2OBXFUU4po5/sOIy7kRw=
X-Google-Smtp-Source: ABdhPJxcmQ/i8N0dfM0sqKv9Nw7hl+d0y2A272Oeo5cNXyJ6mVxPOcNVHvceM0sl+EG9AIlMLFoxsg==
X-Received: by 2002:a1c:4d13:: with SMTP id o19mr7938170wmh.164.1635537165169;
        Fri, 29 Oct 2021 12:52:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z12sm1811136wrv.78.2021.10.29.12.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 12:52:44 -0700 (PDT)
Message-Id: <f9481c77e2d42038196a587b4a637f4277f0dda7.1635537163.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1063.v3.git.1635537163.gitgitgadget@gmail.com>
References: <pull.1063.v2.git.1635530296.gitgitgadget@gmail.com>
        <pull.1063.v3.git.1635537163.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 Oct 2021 19:52:42 +0000
Subject: [PATCH v3 1/2] docs: fix places that break compilation in
 MyFirstObjectWalk
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

Two errors in the example code caused compilation failures due to
a missing semicolon as well as initialization with an empty struct.
This commit fixes that to make the MyFirstObjectWalk tutorial easier to
follow.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 Documentation/MyFirstObjectWalk.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/MyFirstObjectWalk.txt b/Documentation/MyFirstObjectWalk.txt
index 45eb84d8b48..bf0a7c1f766 100644
--- a/Documentation/MyFirstObjectWalk.txt
+++ b/Documentation/MyFirstObjectWalk.txt
@@ -65,7 +65,7 @@ int cmd_walken(int argc, const char **argv, const char *prefix)
 	const char * const walken_usage[] = {
 		N_("git walken"),
 		NULL,
-	}
+	};
 	struct option options[] = {
 		OPT_END()
 	};
@@ -697,7 +697,7 @@ First, we'll need to `#include "list-objects-filter-options.h"` and set up the
 ----
 static void walken_object_walk(struct rev_info *rev)
 {
-	struct list_objects_filter_options filter_options = {};
+	struct list_objects_filter_options filter_options = { 0 };
 
 	...
 ----
-- 
gitgitgadget

