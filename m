Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1794FC4321E
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 13:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350660AbiBHNOr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Feb 2022 08:14:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350221AbiBHMOw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 07:14:52 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36ABC03FEC0
        for <git@vger.kernel.org>; Tue,  8 Feb 2022 04:14:51 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id z13so898657pfa.3
        for <git@vger.kernel.org>; Tue, 08 Feb 2022 04:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Whv3pYMu8nPr6t8743zsp3QXUodPLiauUUIFsR6ts2Q=;
        b=KM4M245jwJ2NZv/YbROfRuWXU+kNggDrRGUNXNXfS/czgXYheMsr4Ec4FlaQBvlYv+
         tC3+uu3fjovA9ul6UuNLMFOQ6jtSZ+6A+KFnw51EiXQW8b9lLO2+S3PulX1Us9hzj7VJ
         D8zDMUCh1TcYsrBL1N4DuCUG8Jr30b/01kA8TFDAc10jvyWWLhhOKhLwExLETtncHUvG
         IH4y30u/XP5PUsVf5CK2fvMFq/IbVIC72yLqovT0iReN0FrPBACROFPNdoNaYd+csk43
         OSomPIbUh80CM3xyQNBNFCzFU735xmUeS2PqKuxpn6Wfvh0sOpHusLvrq1I444IiT0Ra
         HRzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Whv3pYMu8nPr6t8743zsp3QXUodPLiauUUIFsR6ts2Q=;
        b=i+5ZCDXf+broaivqA2PYNgTq0vZWrpU2kTptrsyeVZjC/H6lAAQmqa+8kfkmG+VT/B
         Q2cFboFn6EuhBHfrPMixsd8vAoJZI1/02zpri2GDxDKI9sZfHK75Np9vIymznbCDnkDi
         xuehtMkjbgZGZmq/k6mu8oFTLSbQFzgWiD+NaC1inWGg51yLtqMRjY+UuelAW9NM1U6I
         NUzvgNOZV9oOsYb84tAttgENfAtZjB1oa0X7fjItPgqZDxh2RG2pR+YkS88dqfl+fuy7
         BjrrtwakBF2Tk/GfuAjVAQu4bfNzZ5BJRljM77jNk3Yg9j00H3RH3pGvvQcoxh6bXh7i
         utYA==
X-Gm-Message-State: AOAM533rQIOYKsoieY2hkSu3aWWKDF0MGVXghDJv5vgr9x51j2c2blJY
        vk5u4e3hsZ6/2hgFAOemx21nOhSnQrkkyg==
X-Google-Smtp-Source: ABdhPJymthpbfUCvs9zjrH30VQ5INzWS7pP+yUZaa6j68SM7SJJgggbcyLILYrzRneSO2l7g7/Xksg==
X-Received: by 2002:a63:a102:: with SMTP id b2mr3260198pgf.459.1644322491109;
        Tue, 08 Feb 2022 04:14:51 -0800 (PST)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.44])
        by smtp.gmail.com with ESMTPSA id t3sm16973344pfg.28.2022.02.08.04.14.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Feb 2022 04:14:50 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: [PATCH v11 02/13] ls-tree: add missing braces to "else" arms
Date:   Tue,  8 Feb 2022 20:14:27 +0800
Message-Id: <6fd1dd938303192d5b0a4cdc2914b2ff72cf5a3d.1644319434.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.34.1.403.gb35f2687cf.dirty
In-Reply-To: <cover.1644319434.git.dyroneteng@gmail.com>
References: <cover.1644319434.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

Add missing {} to the "else" arms in show_tree() per the
CodingGuidelines.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/ls-tree.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 5f7c84950c..0a28f32ccb 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -92,14 +92,16 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
 				else
 					xsnprintf(size_text, sizeof(size_text),
 						  "%"PRIuMAX, (uintmax_t)size);
-			} else
+			} else {
 				xsnprintf(size_text, sizeof(size_text), "-");
+			}
 			printf("%06o %s %s %7s\t", mode, type,
 			       find_unique_abbrev(oid, abbrev),
 			       size_text);
-		} else
+		} else {
 			printf("%06o %s %s\t", mode, type,
 			       find_unique_abbrev(oid, abbrev));
+		}
 	}
 	baselen = base->len;
 	strbuf_addstr(base, pathname);
-- 
2.34.1.403.gb35f2687cf.dirty

