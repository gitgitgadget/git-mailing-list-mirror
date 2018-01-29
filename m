Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B56B1F404
	for <e@80x24.org>; Mon, 29 Jan 2018 22:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752276AbeA2Wiu (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 17:38:50 -0500
Received: from mail-yw0-f202.google.com ([209.85.161.202]:44386 "EHLO
        mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752255AbeA2Wij (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 17:38:39 -0500
Received: by mail-yw0-f202.google.com with SMTP id t63so6407781ywa.11
        for <git@vger.kernel.org>; Mon, 29 Jan 2018 14:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=iUZoQVq6xY6GNkgouBk/fNZVQO01HcukVfSG/OFyPKc=;
        b=BsIGu5XMzk3pBlukILMCyV4dCqYJ8+uIqlPhxRgWXXzhrqvt3rRc28a1xzPaZFwawI
         jgijfjfy/G704VhatDqLAuf2sMeMRfdF86mGqAg+CoUH394xtYo9kL5lp8jR4rwtzfIk
         ConPhUbBZRdoi9ZuWKLSPjzDiSZPH79JZV+aLfcsc/GuSxV/wSWvVmo6fio9f3LyF331
         kVoRRKuMxlkPplGp6lJP5QUuWACKyxq3dYihznmwwNjH6/6drbBg5sAj52qfqgip7BEB
         ZDCLgilz6VQRFJjVTOj9argyY0V8agd1sLltIBYX9zLNIR3Lil/7En6pRBqfTRlJtBK/
         aDhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=iUZoQVq6xY6GNkgouBk/fNZVQO01HcukVfSG/OFyPKc=;
        b=qcs3BXSFazRM/XUrtfpsAPvQUg3LB/4WrRvLDadHvaxOwS+IvPbq4dBDolD2935Rif
         ajzLJnSNFQO7+jKtgcqkJw/Eh0alsChArCMCN6e+xquzUPm8JPJGw/hpkecV691jgnGH
         dffyrKR2rEwXBCR6EVRVMQbX6LXE6AzbeEs93vWlEdjMT1iPqIPwFZUiMdxI3lqUbQXX
         wkzgWix4UJdpeCPxkPzYCHp6h/vO8TMyqgx7kbf+xQ8Pi3h33+pSgdGMCWwWvRyD5DOB
         SYoKnSz2/nng9QmnOKMOPizkLF9yGw12jAugo/Djf5xs5sHp/iqCvVxxopqy25so1oWo
         4qTA==
X-Gm-Message-State: AKwxyteWBUnzUSWH7On8uxnRO80/IeqQuiuDOqQl0GxC6o2EVQ8ev7ah
        NE1KioHY6Sp7YMdSeW/+NIWIP33yfDMhH4/Zn23x7XRXtKInI3HTOXfUA7ET81cGhaMS1D3LDDa
        56tcNSROSGLMyffl63pjA1D3otEm8/n+2riIAJAotzbpoXA/g3SWNUNVoBw==
X-Google-Smtp-Source: AH8x226GMBZAXPggRFvbQ4q0g0BPNU4vTjbDKkvrQ9Cvkx80X6bJFxWrP/+ViRtliEmgSXGoL0G+R3MtcN0=
MIME-Version: 1.0
X-Received: by 10.37.172.103 with SMTP id r39mr3139705ybd.74.1517265519246;
 Mon, 29 Jan 2018 14:38:39 -0800 (PST)
Date:   Mon, 29 Jan 2018 14:37:16 -0800
In-Reply-To: <20180129223728.30569-1-bmwill@google.com>
Message-Id: <20180129223728.30569-26-bmwill@google.com>
References: <20180129223728.30569-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH 25/37] remote: rename 'new' variables
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     j6t@kdbg.org, avarab@gmail.com,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename C++ keyword in order to bring the codebase closer to being able
to be compiled with a C++ compiler.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 remote.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/remote.c b/remote.c
index 4e93753e1..6f79881f6 100644
--- a/remote.c
+++ b/remote.c
@@ -1970,12 +1970,12 @@ static void unmark_and_free(struct commit_list *list, unsigned int mark)
 int ref_newer(const struct object_id *new_oid, const struct object_id *old_oid)
 {
 	struct object *o;
-	struct commit *old, *new;
+	struct commit *old, *new_commit;
 	struct commit_list *list, *used;
 	int found = 0;
 
 	/*
-	 * Both new and old must be commit-ish and new is descendant of
+	 * Both new_commit and old must be commit-ish and new_commit is descendant of
 	 * old.  Otherwise we require --force.
 	 */
 	o = deref_tag(parse_object(old_oid), NULL, 0);
@@ -1986,17 +1986,17 @@ int ref_newer(const struct object_id *new_oid, const struct object_id *old_oid)
 	o = deref_tag(parse_object(new_oid), NULL, 0);
 	if (!o || o->type != OBJ_COMMIT)
 		return 0;
-	new = (struct commit *) o;
+	new_commit = (struct commit *) o;
 
-	if (parse_commit(new) < 0)
+	if (parse_commit(new_commit) < 0)
 		return 0;
 
 	used = list = NULL;
-	commit_list_insert(new, &list);
+	commit_list_insert(new_commit, &list);
 	while (list) {
-		new = pop_most_recent_commit(&list, TMP_MARK);
-		commit_list_insert(new, &used);
-		if (new == old) {
+		new_commit = pop_most_recent_commit(&list, TMP_MARK);
+		commit_list_insert(new_commit, &used);
+		if (new_commit == old) {
 			found = 1;
 			break;
 		}
-- 
2.16.0.rc1.238.g530d649a79-goog

