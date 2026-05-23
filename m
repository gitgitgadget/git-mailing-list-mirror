Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B474B33DEF2
	for <git@vger.kernel.org>; Sat, 23 May 2026 19:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779565720; cv=none; b=ncwJQYYP8cIRUlALrEaFGq2EspzSwqrZjsn+NJDV8LbKpu9s+LBI3bXC1JwI3MiDRWMO6MNfJCNJRx/qt/QxZE0PyDiPCZYMr8Ur6WwBAMT+mWDj5GueXhHRrnCQ0Eb3ozAVvRoRXfYdX0tZyb/+HTUUSJQ/vuZy/l4WpPE6dZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779565720; c=relaxed/simple;
	bh=MepuzWGuhWF0cRIJVjI6qqPnLoRPBFo5vm78W5/gZtY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=vGir1sKuf8x89nBHrthIi1nUKQkQD4u3hTfFNeGM9bofteiU+Eo9CjZfc1GTQrs4g+Q9auEdauXJVgNd/bhYqGs1Svqc7nc4vOQRWyJmwf5VO0J4CFFX7KJp37Il5FkMYMeaYAneLjNH6AYMhS3RuUPJajAa1IEYY2YVE+xxKXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZcYh2L6V; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZcYh2L6V"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-914b5f85129so175490685a.3
        for <git@vger.kernel.org>; Sat, 23 May 2026 12:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779565718; x=1780170518; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vamZD5eIO25pSMiJh7diOlUoPx0d2aprA+fJT+SDULw=;
        b=ZcYh2L6VJ3mCvDkIscx9XqQGaMYDpAacaRwyk5JQWDO2qeUOiBCc9KGG4kw/PAr8OB
         7HMRD7G29iUNOYUHkcIBA+1jAilo8A5K/7fGIltJf2icGiMJc65FUNHPOfum+vTukHOs
         n4RQ2qbT49Gh5vjmZdrIqVOl/wsPR7pTsZNLZqZgj37GucxuuiVvDA3VpvjL4IJ9EFha
         0GYrY8CUtvF3Yv3ssM7h7Ew/SIMkc43BSnfCEaTuI8qylUdnQcF5CQ9tqB3nDd9LSjD9
         JrXLYUoZEm988X7QlDdqf9/937ZmVkMKSEi8bbEAGyxcvZl5FWI1jVTQOndutdwk3MTJ
         kz8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779565718; x=1780170518;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vamZD5eIO25pSMiJh7diOlUoPx0d2aprA+fJT+SDULw=;
        b=rwnFGPERrFrZrzGdzr4sxR4jsv0PzLeP4ZXcmmNKTYEmAPBHuGEA/gkOPxF9u7i+jQ
         /i5EedtYoRuTEQ4JGT16VCOX3paTI6Ss0vYHsE25k3DMZRMJyxtyV3/PjKjRGNtoOTz0
         6ug5IpMRC53OIuHSa9hvcWl3M9keAtJndEJlPg0tDd6vLADwcYZ7TYZVfmns+t+K1Rpy
         Sk6I9lsvECAGLdjpOAAKeHlcF68BcFeaqfBvwyAgiECtsUZclElPtXIx+S6cb0W7Y+wb
         A08yJqb68eVzy35WWe5jXxRm6joUgsBJE73Nq3Ch5bO/As4he8nrbHFLjajAW8rD8NQA
         oDdA==
X-Gm-Message-State: AOJu0Yw9blRV2a8Z//zp9FfnWwTmVsx0MBVSUly9fto372bz2L2CdZAG
	4NutB+1MsbYexcFymtCHP+fznfeBLNuWFVbK/DwPGtWHBpyKK6HTwYljdZJe4Q==
X-Gm-Gg: Acq92OHdsSfGqI2yWeFOLIw1sy70xWNXckUwqDNlE0ika2ELBNEEFdq/E8ahObD2R/c
	j/kmz/rt2DulO64iixoDS20AiG+Sm2pYebhGjcfL3s/o1S5iDax10oxQWke5TaW4QDJIy0OAYOx
	UCeeKlnA4LWCabLCA3fOnw1UJnxpf7+v68s9vWIZ72AxItfQlszic2MC29Bi/vfYwxoM1fQR8R+
	927brkf9cc3tYR27squWAc/dA5MM/iw2A1AHwd04OOUExNwwFHXF01clO8evEQZKD/n7RA9iqOQ
	W1vhthqBGz//n9gwjP0mCo89qu79b4zELna/XiG8koeCr1MUnTKiGKK/1ujyPafJIsjB2kDIV8T
	GJdtDYi/Fe9VlpEYS8nStM19JgJ9AEbErFbky6GrbpApfBaL+XPlb1wycyTJOZThNNVQ/BjLPC2
	MWxvuWd0ueAGuKp+EMfJBdureqcFs=
X-Received: by 2002:a05:620a:450f:b0:90f:6367:6e1d with SMTP id af79cd13be357-914b496b1efmr1212095085a.30.1779565717712;
        Sat, 23 May 2026 12:48:37 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.232.48])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc81323f7csm54374646d6.46.2026.05.23.12.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 12:48:37 -0700 (PDT)
Message-Id: <2369afad24a0983d2095eb554cfc7a8b4af5e519.1779565714.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2281.v13.git.git.1779565714.gitgitgadget@gmail.com>
References: <pull.2281.v12.git.git.1779358803652.gitgitgadget@gmail.com>
	<pull.2281.v13.git.git.1779565714.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 23 May 2026 19:48:33 +0000
Subject: [PATCH v13 1/2] branch: expose helpers for finding the remote owning
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
index 3dc6e2a0ff..0aafa1673f 100644
--- a/branch.h
+++ b/branch.h
@@ -1,9 +1,25 @@
 #ifndef BRANCH_H
 #define BRANCH_H
 
+#include "refspec.h"
+#include "string-list.h"
+
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

