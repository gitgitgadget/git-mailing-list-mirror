Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 247D01F462
	for <e@80x24.org>; Tue, 28 May 2019 19:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbfE1TIA (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 15:08:00 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:38198 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfE1TH7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 15:07:59 -0400
Received: by mail-qk1-f202.google.com with SMTP id n190so13516040qkd.5
        for <git@vger.kernel.org>; Tue, 28 May 2019 12:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=l1qJDK3EH/7uGlDYDf3Zqy5snbJwfuFpfp6o9QF7aSE=;
        b=g04A8nHDAwxS/zQ5Ye0waNAaLRfN9RkE+b+yuk18eBECVmJStrO80h7lKCZXGeWXLI
         M0WzFep4HTVCd2BRXI1X4Bnb02S8on3Gk9FGeeOHScn3l/q/lZTBbUCT5ECYREubVpGo
         dYcvNU/4CfysvpzwQoTgFTMcXbeRCqZMwJ30dv3AswNy+hGWk0i3EYhDv8DznZ+rv5PU
         szQFaHBQAuAsHQFGWqPvEtb0JCyz4QP/ohMRT2v6A7LLuD10Cj3NLZsaperZwT4CaptN
         QY8XFUQDySK8z42OSkN02sPTxf/O4slogK6T3SY81YUcpVZnZQ+DoXlL8MaRtmCdGqxr
         R+uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=l1qJDK3EH/7uGlDYDf3Zqy5snbJwfuFpfp6o9QF7aSE=;
        b=PPs4DBuy8cQ8aSLiFo/+yj0bm0NKpeUfxWakN53cgXnSVL2c77Ru7eLHolN89/Q9a2
         IiuM9RtLEcjVqEeBR0S2sm2rCFHLs+KeNf+Ir4lTCypmpaU/OA3cjcRie1YwbtOJjgQo
         d1x9nZjhjh9KMvxu5PnkxJrvJrkFy9grRWZqZ3zmXRY5f0gImiQEWVlCjOHb2qzi7/Tk
         VftnzlqAp5PBFXiQPXFm2aELQJJ2HM2uar/xWtyKF93jleuLxBhqNm3ykrVAyjdrGFBH
         2n6SOfp1dYuYaD/goH757pyVTT23ovd+pTMT5QdhzlmBzztU9gc1azCASEZUNiekTmKx
         TK5g==
X-Gm-Message-State: APjAAAX+cJXwO1f9HPBO0bWZe2Ci+C3ZnqlKkJQ27pkQZ0jerCpQVk9S
        LR8DN1I4ARj/jaAJjCXBwtLbGAILneB5wDpls9Li5aFRFG+Dqx92WliOCJzRlg72Bp5JP7kDpVY
        4cwGmryEWMHGVLeNtWBHda2tkguVZHJVmoz9zYZAWg4+CmWQS2IuWUh+siXvmZqiho3UR8TcSJQ
        ==
X-Google-Smtp-Source: APXvYqzkYiUfJV35dQKuTvwFr+Lxfnd/VkfwkoAxOL/UnNhbqz8yEWv0tHewtpe/omDK9NFbfkCnHO6pCo7nzF9kj2M=
X-Received: by 2002:aed:2665:: with SMTP id z92mr66436433qtc.368.1559070479079;
 Tue, 28 May 2019 12:07:59 -0700 (PDT)
Date:   Tue, 28 May 2019 12:07:29 -0700
In-Reply-To: <20190523005533.260611-1-emilyshaffer@google.com>
Message-Id: <20190528190729.78029-1-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20190523005533.260611-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
Subject: [PATCH v4] doc: hint about GIT_DEBUGGER in CodingGuidelines
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We check for a handy environment variable GIT_DEBUGGER when running via
bin-wrappers/, but this feature is undocumented. Add a hint to how to
use it into the CodingGuidelines (which is where other useful
environment settings like DEVELOPER are documented).

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/CodingGuidelines | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 32210a4386..1169ff6c8e 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -412,6 +412,12 @@ For C programs:
    must be declared with "extern" in header files. However, function
    declarations should not use "extern", as that is already the default.
 
+ - You can launch gdb around your program using the shorthand GIT_DEBUGGER.
+   Run `GIT_DEBUGGER=1 ./bin-wrappers/git foo` to simply use gdb as is, or
+   run `GIT_DEBUGGER="<debugger> <debugger-args>" ./bin-wrappers/git foo` to
+   use your own debugger and arguments. Example: `GIT_DEBUGGER="ddd --gdb"
+   ./bin-wrappers/git log` (See `wrap-for-bin.sh`.)
+
 For Perl programs:
 
  - Most of the C guidelines above apply.
-- 
2.22.0.rc1.257.g3120a18244-goog

