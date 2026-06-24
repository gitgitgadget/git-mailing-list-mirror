Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0831F277C9E
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 21:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782338104; cv=none; b=Q726lcVwsC3tXFSog9GPIbK91G5G1gRu8SAPIH5O+8jHfyTD5g7cOMdPYfVHMp2/PnIsolSI46oBoWbPc14MuhY6wfEBdHQs7D1AKHTLjPcdL7nddeRCfwl1P33Gw4Sn4pCp6RSRBDPwu56k7IEW8Fm3B4RUfBa79l+QrY7iVLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782338104; c=relaxed/simple;
	bh=+pcQKsX2Od7PYmXpWgrGvYJyM8pJQOynDjbSAQBJKHU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=I9+RexdqBfUBOlHx4NMWkazAw3mDWBHHoPeW0T8xMsc5NKoyT4+ruhpnKS5pBmIb9jijIA9Jm7N08JQgnQX9e/1D92VNq3iyRqo0an7z3ozrMM/wlPrWKgW25d0dZG33zJEC5Z0pTPntKvEUidoHRDJkSNdCjdMrEOS1kYFAPDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fiISO2pc; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fiISO2pc"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-91587626ae1so175758885a.3
        for <git@vger.kernel.org>; Wed, 24 Jun 2026 14:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782338102; x=1782942902; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fTrrKEcGxONzLUj//fMDW172QJl5AWztQkpBEFRtkhs=;
        b=fiISO2pcIrQam1ZtX/tQvvgTXLGi2qEgEIju45y5un/nc9pe+MGB5Lg5DWXp+qrzjC
         7aDoJ/dxhxc/zMcNwPZuC/I/mXOGcYeStH2oJ9ijEB8bV86zRDHsng9IjVOC2pp10cnD
         PiAzWqUTrmTJPonPwk8T7sJXzrKTZqwJIU/raTjKRUYQADrehmuvAkdbpcLgw5amjCzu
         zEGwm9GEX79gHhKYHB+CNO/cDdmKMFyn8dyV0lEPcWh3ifnzM5tg6COTPkh0NSqbxnsR
         rFrPxBEDOfzbYVl95sPIk0w+luoXBdmOq0ywbeEV46SZIrp9haVnVb1/lcDB67HxBDfj
         W3Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782338102; x=1782942902;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fTrrKEcGxONzLUj//fMDW172QJl5AWztQkpBEFRtkhs=;
        b=DRtjmcKMkUTY3ZT4j/LWCi4/D3N8E/UsN9Bx1MSFWhzElUI+9iAtNPhogW+mZhyw6M
         sPDDPreFeuOcHbinmJOs+6rWMmeCQ8N09peD3LktgZAm8RabpRWMM01IbdFnK/WkS1n+
         i6NxveC1UvJM+x26Jfh6n5oADp0wtmIoRpCW2yyJaWIMv8NHP9N46x0c41Ot0QEewDxo
         rwDkHmqGnD50IJIuQ4vFhSVGutk6A/0suPTXhJzBrEcEM9x8qYd3w8TZExHtI12ByTOb
         01xdqb2NnOwEwWPQ8T/zeIn1cEOd4/E8lqZkgzfWf+ty+3CiZmXlXekXLb69vImjTuT5
         Xneg==
X-Gm-Message-State: AOJu0YwWRD/fPjg4hZojTFkJvYEA+Xsmyni5+H65Et86SB3/R/Y97y+x
	jn+nefrUw71dc2lhKwdeVRINRWvFv0eHL4Rh5+2hYqoNqytHKzmhf+/38JtZU1bO
X-Gm-Gg: AfdE7cmbDYdFH7vZD7kR2aeWn86DeAfczhQq40szMDrfNzLmzR3oZVE2jOy8YWI451w
	j3M/ODlU2ZYouj0fHMUjQ1LkSPjfq5lk8QuGZgoJbpNlQr1psfY1d/UEawibK+dhLBxBwuFNQ0A
	iXXvVTNHHlz/G76BVEgVQKvPdJAa64Jc0531FOjJkfx5QEHjXnKQ2dOJp/f1Xkzs5MGA9+UUdV1
	BBO7sZHVZ0Ik1NQi1WqPCjVUlnRV8PRr4+ks7IkfMpaX1pKnjAsOaXJuyI2RGusJD4VE73x/YT5
	T2WrR61d0gGhkY5kbhgAtBQjb628jTfVZecGdQ6M69CL6xPHb9QZA8Q+/+myEzmotVximlGQUU4
	aSOkw2F8+1ekU2LuBAo6Ghter1JSjFEvgKzczCJH4UWkPurvirzAPWvfL4UAtBfLxg0DwQHhykb
	wEdY7kvjDRagv1bzKs
X-Received: by 2002:a05:620a:414f:b0:921:8c21:b929 with SMTP id af79cd13be357-92781c06b92mr856354185a.12.1782338101787;
        Wed, 24 Jun 2026 14:55:01 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.91.164])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-925fd391075sm650076485a.4.2026.06.24.14.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 14:55:00 -0700 (PDT)
Message-Id: <8139490c369eb858085118893975cf05efeae142.1782338098.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2281.v15.git.git.1782338098.gitgitgadget@gmail.com>
References: <pull.2281.v14.git.git.1781786652.gitgitgadget@gmail.com>
	<pull.2281.v15.git.git.1782338098.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 24 Jun 2026 21:54:57 +0000
Subject: [PATCH v15 1/2] branch: expose helpers for finding the remote owning
 a tracking ref
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Marc Branchaud <marcnarc@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

The remote-lookup that setup_tracking() does is useful outside
branch.c too; for example, deciding which remote to "git fetch"
from given a remote-tracking ref.

Move 'struct tracking' to branch.h and add two helpers backed by the
existing for_each_remote walk: find_tracking_remote_for_ref() and
advise_ambiguous_fetch_refspec(). setup_tracking() uses both. No
behavior change.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 branch.c | 96 ++++++++++++++++++++++++++++++--------------------------
 branch.h | 16 ++++++++++
 2 files changed, 68 insertions(+), 44 deletions(-)

diff --git a/branch.c b/branch.c
index 243db7d0fc..46ae7f0035 100644
--- a/branch.c
+++ b/branch.c
@@ -20,16 +20,9 @@
 #include "run-command.h"
 #include "strmap.h"
 
-struct tracking {
-	struct refspec_item spec;
-	struct string_list *srcs;
-	const char *remote;
-	int matches;
-};
-
 struct find_tracked_branch_cb {
 	struct tracking *tracking;
-	struct string_list ambiguous_remotes;
+	struct string_list *ambiguous_remotes;
 };
 
 static int find_tracked_branch(struct remote *remote, void *priv)
@@ -45,10 +38,10 @@ static int find_tracked_branch(struct remote *remote, void *priv)
 			break;
 		case 2:
 			/* there are at least two remotes; backfill the first one */
-			string_list_append(&ftb->ambiguous_remotes, tracking->remote);
+			string_list_append(ftb->ambiguous_remotes, tracking->remote);
 			/* fall through */
 		default:
-			string_list_append(&ftb->ambiguous_remotes, remote->name);
+			string_list_append(ftb->ambiguous_remotes, remote->name);
 			free(tracking->spec.src);
 			string_list_clear(tracking->srcs, 0);
 		break;
@@ -59,6 +52,51 @@ static int find_tracked_branch(struct remote *remote, void *priv)
 	return 0;
 }
 
+void find_tracking_remote_for_ref(struct tracking *tracking,
+				  struct string_list *ambiguous_remotes)
+{
+	struct find_tracked_branch_cb ftb_cb = {
+		.tracking = tracking,
+		.ambiguous_remotes = ambiguous_remotes,
+	};
+
+	for_each_remote(find_tracked_branch, &ftb_cb);
+}
+
+void advise_ambiguous_fetch_refspec(const char *dst,
+				    const struct string_list *ambiguous_remotes)
+{
+	struct strbuf remotes_advice = STRBUF_INIT;
+	struct string_list_item *item;
+
+	if (!advice_enabled(ADVICE_AMBIGUOUS_FETCH_REFSPEC))
+		return;
+
+	for_each_string_list_item(item, ambiguous_remotes)
+		/*
+		 * TRANSLATORS: This is a line listing a remote with duplicate
+		 * refspecs in the advice message below. For RTL languages you'll
+		 * probably want to swap the "%s" and leading "  " space around.
+		 */
+		strbuf_addf(&remotes_advice, _("  %s\n"), item->string);
+
+	/*
+	 * TRANSLATORS: The second argument is a \n-delimited list of
+	 * duplicate refspecs, composed above.
+	 */
+	advise(_("There are multiple remotes whose fetch refspecs map to the remote\n"
+		 "tracking ref '%s':\n"
+		 "%s"
+		 "\n"
+		 "This is typically a configuration error.\n"
+		 "\n"
+		 "To support setting up tracking branches, ensure that\n"
+		 "different remotes' fetch refspecs map into different\n"
+		 "tracking namespaces."), dst,
+	       remotes_advice.buf);
+	strbuf_release(&remotes_advice);
+}
+
 static int should_setup_rebase(const char *origin)
 {
 	switch (autorebase) {
@@ -254,11 +292,8 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
 {
 	struct tracking tracking;
 	struct string_list tracking_srcs = STRING_LIST_INIT_DUP;
+	struct string_list ambiguous_remotes = STRING_LIST_INIT_DUP;
 	int config_flags = quiet ? 0 : BRANCH_CONFIG_VERBOSE;
-	struct find_tracked_branch_cb ftb_cb = {
-		.tracking = &tracking,
-		.ambiguous_remotes = STRING_LIST_INIT_DUP,
-	};
 
 	if (!track)
 		BUG("asked to set up tracking, but tracking is disallowed");
@@ -267,7 +302,7 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
 	tracking.spec.dst = (char *)orig_ref;
 	tracking.srcs = &tracking_srcs;
 	if (track != BRANCH_TRACK_INHERIT)
-		for_each_remote(find_tracked_branch, &ftb_cb);
+		find_tracking_remote_for_ref(&tracking, &ambiguous_remotes);
 	else if (inherit_tracking(&tracking, orig_ref))
 		goto cleanup;
 
@@ -293,34 +328,7 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
 	if (tracking.matches > 1) {
 		int status = die_message(_("not tracking: ambiguous information for ref '%s'"),
 					    orig_ref);
-		if (advice_enabled(ADVICE_AMBIGUOUS_FETCH_REFSPEC)) {
-			struct strbuf remotes_advice = STRBUF_INIT;
-			struct string_list_item *item;
-
-			for_each_string_list_item(item, &ftb_cb.ambiguous_remotes)
-				/*
-				 * TRANSLATORS: This is a line listing a remote with duplicate
-				 * refspecs in the advice message below. For RTL languages you'll
-				 * probably want to swap the "%s" and leading "  " space around.
-				 */
-				strbuf_addf(&remotes_advice, _("  %s\n"), item->string);
-
-			/*
-			 * TRANSLATORS: The second argument is a \n-delimited list of
-			 * duplicate refspecs, composed above.
-			 */
-			advise(_("There are multiple remotes whose fetch refspecs map to the remote\n"
-				 "tracking ref '%s':\n"
-				 "%s"
-				 "\n"
-				 "This is typically a configuration error.\n"
-				 "\n"
-				 "To support setting up tracking branches, ensure that\n"
-				 "different remotes' fetch refspecs map into different\n"
-				 "tracking namespaces."), orig_ref,
-			       remotes_advice.buf);
-			strbuf_release(&remotes_advice);
-		}
+		advise_ambiguous_fetch_refspec(orig_ref, &ambiguous_remotes);
 		exit(status);
 	}
 
@@ -347,7 +355,7 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
 
 cleanup:
 	string_list_clear(&tracking_srcs, 0);
-	string_list_clear(&ftb_cb.ambiguous_remotes, 0);
+	string_list_clear(&ambiguous_remotes, 0);
 }
 
 int read_branch_desc(struct strbuf *buf, const char *branch_name)
diff --git a/branch.h b/branch.h
index 3dc6e2a0ff..c2e6725491 100644
--- a/branch.h
+++ b/branch.h
@@ -1,9 +1,25 @@
 #ifndef BRANCH_H
 #define BRANCH_H
 
+#include "refspec.h"
+
+struct string_list;
 struct repository;
 struct strbuf;
 
+struct tracking {
+	struct refspec_item spec;
+	struct string_list *srcs;
+	const char *remote;
+	int matches;
+};
+
+void find_tracking_remote_for_ref(struct tracking *tracking,
+				  struct string_list *ambiguous_remotes);
+
+void advise_ambiguous_fetch_refspec(const char *dst,
+				    const struct string_list *ambiguous_remotes);
+
 enum branch_track {
 	BRANCH_TRACK_UNSPECIFIED = -1,
 	BRANCH_TRACK_NEVER = 0,
-- 
gitgitgadget

