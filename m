Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DE2386429
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 12:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781786656; cv=none; b=HHzmAIkYs0MavPFyPZpIueOgsJYcl9E1EFrBB4pSIurDXO9PAjUt6gamABo5N7Ig+lFkbgw8ybtSYoExr2wwytw4p5yQzSTOUCDrumtmIHGukNt3Q9piIwbA9AW8/Eo/mPtZzAi5b+3qvEPGiFJJ6r5nJiYRJbp5RY7tFGZ2eKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781786656; c=relaxed/simple;
	bh=+pcQKsX2Od7PYmXpWgrGvYJyM8pJQOynDjbSAQBJKHU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=QrY1Or5pGe6PkiE3TIOJ/UWE5LoKKUlTDhYAd7eH31rWMcjY8Xc4Y88DD85RVaO4roAzMBNhBhwyMJw0lWZWGCrzS6XaUBc6MVWKlzYtpsX9sGwPc+JqRo7N+dx7Ma3mD32nf3o/HnSLui6UdlhObN+veKgC7BlQKSnY7dsfBAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SNHJJhT1; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SNHJJhT1"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8ce9de10985so9982356d6.0
        for <git@vger.kernel.org>; Thu, 18 Jun 2026 05:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781786654; x=1782391454; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fTrrKEcGxONzLUj//fMDW172QJl5AWztQkpBEFRtkhs=;
        b=SNHJJhT1dRUu8RalSuYjVeVYAFFBTdiTnbSAEVppMuXGmlxg1B9YMAZWahlvajD6KP
         1crIaD24EWG5zVlYvEvDGs3fNdNkGRqDnp19epG/q/innjB/3DIiPKnujhtU++MvxaBs
         iANmcqBeBrJhXIJfFCnYwzPJgOuN1UlRmNqnB+Yl1cBBwUjpm7F+Lxn5yLo/EUP/SJHm
         YpTMEgiVXj8u5GUPT1t/fcsuQXvhtLQOnZcz9T3dUe/9d/29mcBAeqKc41c4Lyhjdkr8
         Hg5SMqF9aogy8weHSPqVdMNi23Ln71sHtjarG1tgPZGYMgDP8kfD5Rqr2XMyg2YupSy/
         QMDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781786654; x=1782391454;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fTrrKEcGxONzLUj//fMDW172QJl5AWztQkpBEFRtkhs=;
        b=Gqb7F8JLgTcp4/w7vU9dl15Vl2GkFFwT7GiG92748O4OqC8g/uKSpJSrZrLGl7yiU1
         WtAMgN4cJQuYUUpmvh44U+RDhMifOBAIC+/ApFmWnaobtIDHe+euVDyVsASf5pKwDxiq
         dlLnficzQzkiumQbGyStOFLA0EfBfW03wGEY+KwPeAsy1rdaZ19PymdFVJKO2ZyRm76c
         MKRCJIa7k26I2rqnVevPpIEzeD+B74XIqwXekZPsxFxYWhs6bHtdPaWUDfSDNu/zMhLk
         G3LdxoYsPL2pQhLaP1WmPDVDzxj8Npq6t+alcWRDRmj5CFGR1+/jcMf+rDWDzsW8GRq2
         pRew==
X-Gm-Message-State: AOJu0Yxhh0ZusSanc/m/hCfvPA90jrwzPMeKourIz9HxrjMA6F9sSMkL
	z6RO1VkFKmAeNFPylH6pVyCoVAoxTr+PF9kqRfEeBiys8VeXZGxOul2kczeqgazf
X-Gm-Gg: AfdE7ckUZelXgqACy8Dh20tZflKbfLZx8R2EYVXkvflKnS28+oRV0uyeQ1eCO6tG4AG
	mbWtNxavEkQZrxN0SJ2kq3Pn8rayBA0MG6gzYVulmO4slNljEc/wMlh/h/U+g+vaHP1J7EHKJsF
	+U3bkZ0WGNXqNLSZL/0ArQy4okiZG5YX6wkRV1ANnH70du49FuhWpTEQrLdXmBWp3aOyKIDYSoe
	QeHFfl8YUcWmFhUMTEB6zYPBebpYYDZDpcB3V24514zEhFdUUE2jBtfPVHrF7RXuE6QFbfWXDFp
	aNAUwIEENuZJXUm3JoW1Clqmy+iNu3Ac1Sg6eUDl0lwTdA5f5LeAlOzuU7NrYMMHPLb5k7UtVVL
	JPL1LktBJik8ohN3jAOnUd3skqiP8j8Wkx4XXLlQpBh9JznbRJ3ZdguR/YSESIkl1dfql24NbX3
	Xg0XLdoP2JY27WuivG
X-Received: by 2002:a0c:e018:0:b0:8db:480e:6944 with SMTP id 6a1803df08f44-8dcce340996mr51671136d6.26.1781786654412;
        Thu, 18 Jun 2026 05:44:14 -0700 (PDT)
Received: from [127.0.0.1] ([52.186.174.180])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8dc7f9b4b3fsm39846466d6.31.2026.06.18.05.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 05:44:13 -0700 (PDT)
Message-Id: <f79689c23d962c117e374970686ae408f0163e67.1781786652.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2281.v14.git.git.1781786652.gitgitgadget@gmail.com>
References: <pull.2281.v13.git.git.1779565714.gitgitgadget@gmail.com>
	<pull.2281.v14.git.git.1781786652.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 18 Jun 2026 12:44:11 +0000
Subject: [PATCH v14 1/2] branch: expose helpers for finding the remote owning
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

