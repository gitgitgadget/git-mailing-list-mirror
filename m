Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D3611F597
	for <e@80x24.org>; Mon, 23 Jul 2018 13:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388230AbeGWOyX (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 10:54:23 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:38360 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388091AbeGWOyW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 10:54:22 -0400
Received: by mail-pl0-f68.google.com with SMTP id b1-v6so264451pls.5
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 06:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZdGlRTIF/tEl6bFcfsOFLA7EHnv1sdO4j4SRHze+fts=;
        b=YfIyGBhIeFgZpZPo9annSqWGGMCE/lN08k4ai7z5fCLy/MCcScDm0taefRnBZKxAiw
         AovuIWePBJeESxA2uWdeevIhHstzk33y0jcOLoMJqTV+hPLGL8dVgZ+4Tv1AIlEqYtcW
         pBwlW4gop/z2qa5+gMqTZdNzPC4Tiqibcz4CmdZYyOs5r0nZA7hlE2mb713HuTuQZGzM
         26UX4Uu82xwhwolWIRXSQwO0AWsTV/LWyW/NDqJryVZKKkyQ1KpAJW78IXOlFLneeGeV
         NKqI6E43tII45tCQz8xfa3vSXRevVHW17ITX+O/CQ5imz3PpdqAwJ+XaT8FYGA7gz9vx
         4+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZdGlRTIF/tEl6bFcfsOFLA7EHnv1sdO4j4SRHze+fts=;
        b=ZkZvj4VKj6jfYtD8BgiuGlPSxjYzX7V9ctGm43KiUKbvucHD/vl52NsE6YNwQHT2l+
         oELw29CXPFc11DzKWpOUdQsD4OcXrMK178JOmifhSGTlGEiagscIJ7w4SkOM15697000
         QDyjkqFLTB9/RbUtDmMA76KzCyWBiR2e3eY3ZiparAN4CeRgGJ1OBcVSRpdem+LxzriK
         a7W3bDH/peAtiLafY88o3U/BDxzpUqZvevv6aYjDEt7w8KqtcyAaQu3wbtn8q8BTpxX3
         +m0u03arrdq/hV6/G2EmC8UQILOyv8honIZq+G1wpAbe6I9TNuuQ9ZHNKrRDciAV6eAc
         tSxA==
X-Gm-Message-State: AOUpUlG/nUthzUuqOdjBh3m4JWoH306FMv0pL6V6rFekdI1lq4tGkBf/
        1rZIfKX4vkL15ZMXWhULpQWy+Oal
X-Google-Smtp-Source: AAOMgpdNrkDR/XCInp7xA8U3NIn64CzaZ6blxmEAFQPJqgAhRr6o2PMgZscEmKsCqgR+H2IQ118BQQ==
X-Received: by 2002:a17:902:342:: with SMTP id 60-v6mr13029136pld.311.1532353980848;
        Mon, 23 Jul 2018 06:53:00 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id i3-v6sm8273415pgq.35.2018.07.23.06.52.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 06:53:00 -0700 (PDT)
Date:   Mon, 23 Jul 2018 06:53:00 -0700 (PDT)
X-Google-Original-Date: Mon, 23 Jul 2018 13:52:45 GMT
Message-Id: <4c2aa015a444e87db7242a436b99f02bf3d331f4.1532353966.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2.git.gitgitgadget@gmail.com>
References: <pull.2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 9/9] vscode: let cSpell work on commit messages, too
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

By default, the cSpell extension ignores all files under .git/. That
includes, unfortunately, COMMIT_EDITMSG, i.e. commit messages. However,
spell checking is *quite* useful when writing commit messages... And
since the user hardly ever opens any file inside .git (apart from commit
messages, the config, and sometimes interactive rebase's todo lists),
there is really not much harm in *not* ignoring .git/.

The default also ignores `node_modules/`, but that does not apply to
Git, so let's skip ignoring that, too.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/vscode/init.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/contrib/vscode/init.sh b/contrib/vscode/init.sh
index a134cb4c5..27de94994 100755
--- a/contrib/vscode/init.sh
+++ b/contrib/vscode/init.sh
@@ -33,6 +33,8 @@ cat >.vscode/settings.json.new <<\EOF ||
         "*.h": "c",
         "*.c": "c"
     },
+    "cSpell.ignorePaths": [
+    ],
     "cSpell.words": [
         "DATAW",
         "DBCACHED",
-- 
gitgitgadget
