Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1EF71F462
	for <e@80x24.org>; Sun, 16 Jun 2019 08:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfFPIXk (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Jun 2019 04:23:40 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44445 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfFPIXk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jun 2019 04:23:40 -0400
Received: by mail-pg1-f196.google.com with SMTP id n2so4030990pgp.11
        for <git@vger.kernel.org>; Sun, 16 Jun 2019 01:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pazEKeDIH7AbdRnR/iaQGh0fYZ4URowy28AFbGXYC5I=;
        b=NhAS3gtEePt+VW7ZksKJARgsxoGLEmKlewkeiqcMDTFHG5Bd8sj7TRzi0DUcPSKYE0
         QzaB9UL2ugaPqTZc1flVZn3KHdhD/tgRU7VW9MJI70h3uxlGrmb+1sa5IAniJpaozWuz
         MyUZx2I+I7BtF8AJqg+tkQebqf9kEwTZu/m1XJr8LFLi3zD+QzRx8WEWD5edrChxJ5jo
         Ex/M9Mw7BVQOUB93JYBOFup4O48qW/S9MszUJJrWyFYqNX8f8wOi3lpNrTT3Lm+4cJ0N
         To64xwDbmyhmauQcfR3d+rREocAalaLVm0yvCmikmIYYgoUdAg6PpG/+0ob8s+2ysV8a
         mH/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pazEKeDIH7AbdRnR/iaQGh0fYZ4URowy28AFbGXYC5I=;
        b=B2lMy4SKnWUjyJQHgGzsfhiLfDXX84ZX9V5dsB/545TkDzZDDdf1CPuB6Q/RyW8XKr
         k50MpwQG4MIgWNm3m7p/8eEjuUkyQp53viBMNShk2vFLTvF73Dbfl+Ko8rEOVqxKkMKG
         H/CkF0nf3Jx9bj04nxzw+2Nr2cF8o64s8FZniD1IXLLHnNSQALp9qswlGRHTyF8xAyXg
         RmsnLOwgWx5mWAERhLx/PKUDENfu0Wd38HvotwsfRQ5M+OmQM4R8GxJ3fYH93Ru5v+Zr
         LlnU/xWeV7ZOHW+N/71b3PzdL/ELCqOGxxqirWHNrnP+yZzTNFl8/qXl9ybcJtYjG0IZ
         YAsw==
X-Gm-Message-State: APjAAAWtisdqdXRfS3b9d55lVmJymwePVZPQUARtsJAphAfKjakKXW3k
        r8ad5LvckyFUuotrnF0gLzs=
X-Google-Smtp-Source: APXvYqzpzft2B4o0uZ/KtstlMzyWiRKcyI3hNmVwj7RUE8OZbTQxFqvLAfYubatMZWyZXMmc+lm6hw==
X-Received: by 2002:a63:6105:: with SMTP id v5mr43684460pgb.312.1560673419659;
        Sun, 16 Jun 2019 01:23:39 -0700 (PDT)
Received: from ar135.iitr.local ([2401:4900:3105:6dd7:b496:8be7:332f:b415])
        by smtp.gmail.com with ESMTPSA id x128sm1471972pfd.17.2019.06.16.01.23.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 16 Jun 2019 01:23:39 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     git@vger.kernel.org, newren@gmail.com, t.gummerer@gmail.com,
        phillip.wood123@gmail.com, martin.agren@gmail.com,
        jrnieder@gmail.com, gitster@pobox.com
Subject: [GSoC][PATCH v4 2/4] sequencer: rename reset_for_rollback to reset_merge
Date:   Sun, 16 Jun 2019 13:50:38 +0530
Message-Id: <20190616082040.9440-3-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190616082040.9440-1-rohit.ashiwal265@gmail.com>
References: <20190608191958.4593-1-rohit.ashiwal265@gmail.com>
 <20190616082040.9440-1-rohit.ashiwal265@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We are on a path to teach cherry-pick/revert how to skip commits. To
achieve this, we could really make use of existing functions.
reset_for_rollback is one such function, but the name does not
intuitively suggest to use it to reset a merge, which it was born to
perform, see 539047c ("revert: introduce --abort to cancel a failed
cherry-pick", 2011-11-23). Change the name to reset_merge to make
it more intuitive.

Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
---
 sequencer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index d80e1c3fbb..408643f88a 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2731,7 +2731,7 @@ static int rollback_is_safe(void)
 	return oideq(&actual_head, &expected_head);
 }
 
-static int reset_for_rollback(const struct object_id *oid)
+static int reset_merge(const struct object_id *oid)
 {
 	const char *argv[4];	/* reset --merge <arg> + NULL */
 
@@ -2753,7 +2753,7 @@ static int rollback_single_pick(struct repository *r)
 		return error(_("cannot resolve HEAD"));
 	if (is_null_oid(&head_oid))
 		return error(_("cannot abort from a branch yet to be born"));
-	return reset_for_rollback(&head_oid);
+	return reset_merge(&head_oid);
 }
 
 int sequencer_rollback(struct repository *r, struct replay_opts *opts)
@@ -2796,7 +2796,7 @@ int sequencer_rollback(struct repository *r, struct replay_opts *opts)
 		warning(_("You seem to have moved HEAD. "
 			  "Not rewinding, check your HEAD!"));
 	} else
-	if (reset_for_rollback(&oid))
+	if (reset_merge(&oid))
 		goto fail;
 	strbuf_release(&buf);
 	return sequencer_remove_state(opts);
-- 
2.21.0

