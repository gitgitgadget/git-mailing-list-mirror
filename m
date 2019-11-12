Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36C7E1F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 10:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfKLKio (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 05:38:44 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35652 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbfKLKim (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 05:38:42 -0500
Received: by mail-wm1-f66.google.com with SMTP id 8so2396771wmo.0
        for <git@vger.kernel.org>; Tue, 12 Nov 2019 02:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8Yhc89CS3weW6GxUja4uz4NhZYQ6syhZPk1E02ipre8=;
        b=ENHjRoExe+SS4krR9euCLGWG81GAKhHuVNhcOfLy/JZf2+KyBKZf4ELwYUniwY/ATb
         zEml/aLcsBYUN9OE+1Y+yjUbjMRMa7ry7VyAYCCYrKfz9x6qfc0y54asyqZj3NgLarBZ
         EdjdbkTq3rO1IA4sK/oCKBzwamaW+LzI3yLV7ws/5UZzEmLWopzvYcpNF+hbnni3kFdq
         WMfz9elb/Rg/Zw/WpH/M8l6yiOrnBt/oI2PWbXuvsic1K13LFzQ5R+0UwSBv5Xf2GnO/
         w76aW8DtBX/0A8mPRgUfTNqLhXYrHdmKSgz/f12S3NCrbx4FInSl3ty4NNZ8Q6T/A2xn
         DYtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8Yhc89CS3weW6GxUja4uz4NhZYQ6syhZPk1E02ipre8=;
        b=PzIoeXwL15p1K9OOhsr/DgD19Lh9PGGE5g5+wUCb4SoOsETNCu4sQwJOlgATcOsMnL
         k4KXFgZ5Ukry+q/1C3e/O7dRRXBlkqto6u62qP2/n6CjpH9EDZTHXNAsQzxe0AahGT8q
         EIw/vXBZxUOamX+b5kswo+aXWbxCAJpl0Q3QmMwQYIXByQ2qF8uVLVd/EhN9Ct8mUNY6
         TOzzLE8QxVuQi0NXt0+MeuVazbo1htwV+KrCxh5gqUFwPO6O0vKEgHM9iaAD8bv/Ucdn
         0/AexfHi3CL49GPObmrM0SFaFmQ9DZUcuG1SGY6wDuogvD7SOGzNk2ge7Im+/xFYriAT
         J2gw==
X-Gm-Message-State: APjAAAXmI3j2fN3jBQMG6x2duPvCiuPIKXVGFpw+ApRr9/hD2O7ct/9O
        g/2s4F27oHS+nEc1yo5VtJNbfUss
X-Google-Smtp-Source: APXvYqzRqEe2pIkFkKeXfhhiTCMxsu9zisQPJ/FGK/cBbr79IkieJxI+SNxHnYtC+Q9xFvaSjXU87g==
X-Received: by 2002:a1c:30b:: with SMTP id 11mr2983028wmd.171.1573555119926;
        Tue, 12 Nov 2019 02:38:39 -0800 (PST)
Received: from localhost.localdomain (x4d0c65ae.dyn.telefonica.de. [77.12.101.174])
        by smtp.gmail.com with ESMTPSA id f24sm2313759wmb.37.2019.11.12.02.38.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Nov 2019 02:38:39 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 09/13] name-rev: restructure parsing commits and applying date cutoff
Date:   Tue, 12 Nov 2019 11:38:17 +0100
Message-Id: <20191112103821.30265-10-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.24.0.388.gde53c094ea
In-Reply-To: <20191112103821.30265-1-szeder.dev@gmail.com>
References: <20190919214712.7348-1-szeder.dev@gmail.com>
 <20191112103821.30265-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At the beginning of the recursive name_rev() function it parses the
commit it got as parameter, and returns early if the commit is older
than a cutoff limit.

Restructure this so the caller parses the commit and checks its date,
and doesn't invoke name_rev() if the commit to be passed as parameter
is older than the cutoff, i.e. both name_ref() before calling
name_rev() and name_rev() itself as it iterates over the parent
commits.

This makes eliminating the recursion a bit easier to follow, and the
condition moved to name_ref() will be moved back to name_rev() after
the recursion is eliminated.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 builtin/name-rev.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index e112a92b03..5041227790 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -111,11 +111,6 @@ static void name_rev(struct commit *commit,
 	struct commit_list *parents;
 	int parent_number = 1;
 
-	parse_commit(commit);
-
-	if (commit->date < cutoff)
-		return;
-
 	if (!create_or_update_name(commit, tip_name, taggerdate, generation,
 				   distance, from_tag))
 		return;
@@ -123,6 +118,12 @@ static void name_rev(struct commit *commit,
 	for (parents = commit->parents;
 			parents;
 			parents = parents->next, parent_number++) {
+		struct commit *parent = parents->item;
+
+		parse_commit(parent);
+		if (parent->date < cutoff)
+			continue;
+
 		if (parent_number > 1) {
 			size_t len;
 			char *new_name;
@@ -135,11 +136,11 @@ static void name_rev(struct commit *commit,
 				new_name = xstrfmt("%.*s^%d", (int)len, tip_name,
 						   parent_number);
 
-			name_rev(parents->item, new_name, taggerdate, 0,
+			name_rev(parent, new_name, taggerdate, 0,
 				 distance + MERGE_TRAVERSAL_WEIGHT,
 				 from_tag);
 		} else {
-			name_rev(parents->item, tip_name, taggerdate,
+			name_rev(parent, tip_name, taggerdate,
 				 generation + 1, distance + 1,
 				 from_tag);
 		}
@@ -273,16 +274,18 @@ static int name_ref(const char *path, const struct object_id *oid, int flags, vo
 	if (o && o->type == OBJ_COMMIT) {
 		struct commit *commit = (struct commit *)o;
 		int from_tag = starts_with(path, "refs/tags/");
-		const char *tip_name;
 
 		if (taggerdate == TIME_MAX)
 			taggerdate = commit->date;
 		path = name_ref_abbrev(path, can_abbreviate_output);
-		if (deref)
-			tip_name = xstrfmt("%s^0", path);
-		else
-			tip_name = xstrdup(path);
-		name_rev(commit, tip_name, taggerdate, 0, 0, from_tag);
+		if (commit->date >= cutoff) {
+			const char *tip_name;
+			if (deref)
+				tip_name = xstrfmt("%s^0", path);
+			else
+				tip_name = xstrdup(path);
+			name_rev(commit, tip_name, taggerdate, 0, 0, from_tag);
+		}
 	}
 	return 0;
 }
-- 
2.24.0.388.gde53c094ea

