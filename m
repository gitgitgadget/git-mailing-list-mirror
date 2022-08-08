Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62ED1C00140
	for <git@archiver.kernel.org>; Mon,  8 Aug 2022 13:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243359AbiHHN2G (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Aug 2022 09:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243339AbiHHN15 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Aug 2022 09:27:57 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84828A464
        for <git@vger.kernel.org>; Mon,  8 Aug 2022 06:27:56 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id j7so10927007wrh.3
        for <git@vger.kernel.org>; Mon, 08 Aug 2022 06:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=w1h9NraaToF+tuGu5gt0C56PoKkfBlb9sQmrKhyZZG8=;
        b=lrpHPmIXNgxZwBkAIdkcbYMFrQIEQXb2VjGcr1wGJZxqmL5uO7WFr53SFIuARBJVSO
         EX88z2lSgGINTfuE/7Cd21z6TDhbLuVEEm0pvLXkIbrYR6/ROgOQmmUb2K5VRRRFbZnn
         MaBG/BcMn+YdPGzaT5GNlhYaBSv5Iv/+YNaY/3CnrXsueCI5lbV/Z5iTePEFnrGJ14tL
         hi+ZH9OGRKPoZg+ZOWntIJfB1TCdwzndQIS+hIoBRPwi5CMjxOw0AlofEInZ3CZwE4Ay
         EnV2tHgXnnGgBpQ3Q+YFcfiJNohl76u5xFB6oQm/JVNq1gY4gMwOT9D+HOe0W3LBGsxU
         5j5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=w1h9NraaToF+tuGu5gt0C56PoKkfBlb9sQmrKhyZZG8=;
        b=kpIoheWg+HMHxi0yY6UJk3eVpamagE3lVgX2JDWOesxjHIuXCEctCc18McT4hs/sJf
         YBQPBSP2+aAUWdAeKTWV0WNFOkqjzRWSzqtHXli7u8Q0HwgWyY2AXIc9c2LzFhbVYFSZ
         GoW/ZibsBxoof6mGQGbkxeeIzk53OYEmnbTjnFpRr73C2WC+V/Zem9oxNfsqsmLrzZHy
         ih/JhHNNH1GCZ4Ssoffp+s6eb2M/jg42ajQ+HwXwemR3VMf7HZFWtlEsaIpnm+QsHOg8
         aQN7/aL5jMcZLcpM/eIijuaco8T/vHsLD5e2g3sFflLDqt30fc5kwzljPktEKZdO4FxT
         MUMA==
X-Gm-Message-State: ACgBeo2Fv8TFALZAPkEI4NOe6IAeEHc+0T5X5SnC3NxRl2QPuYPnyPvn
        jianhqc2gsabm86HIbZtKb3BC544Drk=
X-Google-Smtp-Source: AA6agR40OMitTlW8bhv8QqQJMiYd3SjDPD4D0MMmFkv8voKbAciSpm6LHtxJXCfXhht9eK3FstuJAw==
X-Received: by 2002:a05:6000:10c3:b0:21f:15aa:1b68 with SMTP id b3-20020a05600010c300b0021f15aa1b68mr11785003wrx.693.1659965274723;
        Mon, 08 Aug 2022 06:27:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z9-20020a5d4d09000000b0021dd08ad8d7sm11390233wrt.46.2022.08.08.06.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 06:27:54 -0700 (PDT)
Message-Id: <6349481810585d4dba2187266510d71fb2471cb7.1659965270.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1286.v2.git.1659965270.gitgitgadget@gmail.com>
References: <pull.1286.git.1657700238.gitgitgadget@gmail.com>
        <pull.1286.v2.git.1659965270.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 08 Aug 2022 13:27:48 +0000
Subject: [PATCH v2 3/5] mingw: provide details about unsafe directories'
 ownership
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

When Git refuses to use an existing repository because it is owned by
someone else than the current user, it can be a bit tricky on Windows to
figure out what is going on.

Let's help with that by providing more detailed information.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/compat/mingw.c b/compat/mingw.c
index f12b7df16d9..2c09c5bffee 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1,6 +1,7 @@
 #include "../git-compat-util.h"
 #include "win32.h"
 #include <aclapi.h>
+#include <sddl.h>
 #include <conio.h>
 #include <wchar.h>
 #include "../strbuf.h"
@@ -2720,6 +2721,29 @@ int is_path_owned_by_current_sid(const char *path, struct strbuf *report)
 		    IsValidSid(current_user_sid) &&
 		    EqualSid(sid, current_user_sid))
 			result = 1;
+		else if (report) {
+			LPSTR str1, str2, to_free1 = NULL, to_free2 = NULL;
+
+			if (ConvertSidToStringSidA(sid, &str1))
+				to_free1 = str1;
+			else
+				str1 = "(inconvertible)";
+
+			if (!current_user_sid)
+				str2 = "(none)";
+			else if (!IsValidSid(current_user_sid))
+				str2 = "(invalid)";
+			else if (ConvertSidToStringSidA(current_user_sid, &str2))
+				to_free2 = str2;
+			else
+				str2 = "(inconvertible)";
+			strbuf_addf(report,
+				    "'%s' is owned by:\n"
+				    "\t'%s'\nbut the current user is:\n"
+				    "\t'%s'\n", path, str1, str2);
+			LocalFree(to_free1);
+			LocalFree(to_free2);
+		}
 	}
 
 	/*
-- 
gitgitgadget

