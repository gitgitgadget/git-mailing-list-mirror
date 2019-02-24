Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECB4D20248
	for <e@80x24.org>; Sun, 24 Feb 2019 10:11:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbfBXKLX (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Feb 2019 05:11:23 -0500
Received: from mail-ed1-f54.google.com ([209.85.208.54]:45415 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728120AbfBXKLV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Feb 2019 05:11:21 -0500
Received: by mail-ed1-f54.google.com with SMTP id d9so5178032edh.12
        for <git@vger.kernel.org>; Sun, 24 Feb 2019 02:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=UQ4CCD8hkcBwpkfRYkUR8c1ujID7gYubmdZdKWZ/jiU=;
        b=Phja/wg3QgjrA3yeJHv1fTjo0qQRsj0yNMLfGtO9MezMvjUw0uYxb1g9B5XObtsybV
         HRZaTwHFWJdRGdtmPzZoNZG5Cy8idk4xGofzdSKw29psIqrW2r10MVnHGMLlhj4Hnr6h
         q9nGr12HlWcah1vtYQ5XDEM4Us/Kbwyf+zwFcL4g5s1O23NEzB06dN+s9tr0hrncFOO7
         qt/LzHmMx86Z8TDxnql3KIYgRtINF15gpYP25Jgf9lnksWNuCwHwy0LGrgT1rfVJjahV
         lN5Cf0aQRoc0PzXa0zLFuCuHmVE1A+lMvHKa1uK5VBfG0pzsBMqNXAGmSZrw3ad9+gCe
         dHLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=UQ4CCD8hkcBwpkfRYkUR8c1ujID7gYubmdZdKWZ/jiU=;
        b=nIFYgRlbh2etZ7DnHlXc/qYGCWrKC/B3kGGJPYBGMLHuPdSrMjllxH+Hr8gCbe4Ky8
         I08XZLx9dAPtJLcUNLSSd8G1iClhx7+7cNfKagHVp4r8Rx4Xhj02khKBtAVGzYcGiv5Z
         VpFs5hn0zWJZvd8rk6Y8p+FqGPnURAe6yrc/1VAvvd/4uC0Hv6dr1nGoeUwfF+MY46ii
         d7kwWhR4L3Df5JUGwpeuTVeOqLx3h5H8nP2Zi8Uu8VdDJy1CVc2r4goIVZhkoxiRSlKp
         Yq678NWSDyK0T5couSYZEB0pZee4JbYcTkb86u+CiXwGVnWUZEuphTNXrSNnTzidbr3s
         UfcA==
X-Gm-Message-State: AHQUAubrNchhwOQit6DjZQaV1lG6kUXZwvW3J/KDUhm31LOsUkvLwTWN
        voD6CeQuwuFmLovXOi08ybD4W6fX
X-Google-Smtp-Source: AHgI3IY67SzmMKayjb/G063qZPdP6FPNnrNmYG9DxqML9JWb2/xnPW1Mb50SaCZp9zqE+Lw6ZMFmYw==
X-Received: by 2002:a50:b613:: with SMTP id b19mr10183991ede.214.1551003079699;
        Sun, 24 Feb 2019 02:11:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n25sm1823443edd.83.2019.02.24.02.11.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Feb 2019 02:11:19 -0800 (PST)
Date:   Sun, 24 Feb 2019 02:11:19 -0800 (PST)
X-Google-Original-Date: Sun, 24 Feb 2019 10:10:53 GMT
Message-Id: <45c00ddf64982448361c461964e4ad77a328be74.1551003074.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.117.git.gitgitgadget@gmail.com>
References: <pull.117.git.gitgitgadget@gmail.com>
From:   "Pranit Bauva via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 05/26] bisect.c: libify `bisect_checkout` and its dependants
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Pranit Bauva <pranit.bauva@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pranit Bauva <pranit.bauva@gmail.com>

Since we want to get rid of git-bisect.sh it would be necessary to
convert those exit() calls to return statements so that errors can be
reported.

Emulate try catch in C by converting `exit(<positive-value>)` to
`return <negetive-value>`. Follow POSIX conventions to return
<negative-value> to indicate error.

Turn `exit()` to `return` calls in `bisect_checkout()`.

Handle this return in dependant methods - `check_merge_bases()`.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
---
 bisect.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/bisect.c b/bisect.c
index bb926f09d0..1f2f3201a3 100644
--- a/bisect.c
+++ b/bisect.c
@@ -710,7 +710,7 @@ static int is_expected_rev(const struct object_id *oid)
 static int bisect_checkout(const struct object_id *bisect_rev, int no_checkout)
 {
 	char bisect_rev_hex[GIT_MAX_HEXSZ + 1];
-
+	int res = 0;
 	memcpy(bisect_rev_hex, oid_to_hex(bisect_rev), GIT_SHA1_HEXSZ + 1);
 	update_ref(NULL, "BISECT_EXPECTED_REV", bisect_rev, NULL, 0, UPDATE_REFS_DIE_ON_ERR);
 
@@ -719,14 +719,14 @@ static int bisect_checkout(const struct object_id *bisect_rev, int no_checkout)
 		update_ref(NULL, "BISECT_HEAD", bisect_rev, NULL, 0,
 			   UPDATE_REFS_DIE_ON_ERR);
 	} else {
-		int res;
 		res = run_command_v_opt(argv_checkout, RUN_GIT_CMD);
 		if (res)
-			exit(res);
+			return res > 0 ? -res : res;
 	}
 
 	argv_show_branch[1] = bisect_rev_hex;
-	return run_command_v_opt(argv_show_branch, RUN_GIT_CMD);
+	res = run_command_v_opt(argv_show_branch, RUN_GIT_CMD);
+	return res > 0 ? -res : res;
 }
 
 static struct commit *get_commit_reference(const struct object_id *oid)
@@ -822,7 +822,7 @@ static void check_merge_bases(int rev_nr, struct commit **rev, int no_checkout)
 			handle_skipped_merge_base(mb);
 		} else {
 			printf(_("Bisecting: a merge base must be tested\n"));
-			exit(bisect_checkout(mb, no_checkout));
+			exit(-bisect_checkout(mb, no_checkout));
 		}
 	}
 
-- 
gitgitgadget

