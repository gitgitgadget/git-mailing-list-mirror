Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97D23DFC8F
	for <git@vger.kernel.org>; Fri, 22 May 2026 11:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779449511; cv=none; b=RutlXdhYkeEr8rMou2nxIFps22H4ARc1NyIXoQn9yrhYRg16/PMoncCiOoyaqmqeMNtOuCp3iCrla2ZCFnTrU+pi508I1MKN3HXhuoCYsp1e9sGKI6Rm3G3Ve8pD4brVhovGOsbhSgFRjxEnsLd0ereVErJKVo/tqRcE5G430c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779449511; c=relaxed/simple;
	bh=oKz3sEt7lh/fjS1/0vatJBFyfleu9LUHmjd6QQ00m5U=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=IpTBoXSQ8bnsMCWLKvqoWsT6DpzkXSAzZIJbzHBtyptLYHaTqOmTAfD4Ant2B5Onfy2R4ry5rscNEL2lAcbkUUsRz4VJW6xxv30G/6gUCYZ+DoOYmocMG25lvJ+RoImi6XLbuaIIBm2hR5tLHy3Y+3u75IhgmhwqmZZf2OAAx+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rpJo1OlE; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rpJo1OlE"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-65c7efdb7d8so7637715d50.3
        for <git@vger.kernel.org>; Fri, 22 May 2026 04:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779449504; x=1780054304; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x/glIeXR7THHDW1s6TFrahl0hUXeyIf1kSLMx9rrYd8=;
        b=rpJo1OlEwJLzMdEpvM0bMKs7TvM+gy5nHVHOPwVaggsh8GMoS2Jwa0jI10ZRKgQVFc
         f+/7FkeUMo3r4WYp7fpcw/rhlUPTDdLGEWPhxHTaA9bXlX1QLqNs0+LGwDxML91j5OVa
         x7zZbg6XBaIqIoDcEz3h8NkgWpabLYs4dEtHV+S855X2RaioqASjAi+gDh2srWZurFDQ
         z3nHk2N/bPK+5CJ82gCeaKog0IZOB6uUuGRDVBjar4k+IHp/3TQYVdbMUBO+LHwjgWd9
         d+XHiBq3rW5sDqmuuQrcrTgk1yywxhi9IDCO6A52g+/9A3casTJcgeQoCFbihdyJgaUQ
         cexQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779449504; x=1780054304;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x/glIeXR7THHDW1s6TFrahl0hUXeyIf1kSLMx9rrYd8=;
        b=aQxNhtIUEH4F9e/zdTg0zrScDgC1IkhyP6c5QsU/nciipKy8va/7J68Oey17zm0KqC
         S4hlAj2BTYNVvb1y+3RCgkW/Cb1BciMg9NMjZNScbt8sV5+DfhuOW1fw/F6qIn6C0Jju
         C2qgrpgTNTV28TBGmoD7hHVcG+6Jhef1a8eIXdOro9Gispd8s467XED3OtMO+mdHcsig
         v3fsZPhGnyXCS8LMuPDPU9y1MqUAKhv2AnaejHz9GLWoX/QYR+xyej15JgMw9q43l/72
         4R3RTP7npY7fP9smPoQQvBCNiBaQ4ZBO6qY8IW9sfahdOEjX5cI76NPMILUTmk8R3xQj
         HgTw==
X-Gm-Message-State: AOJu0YzwXQ+aJj9nYHqJ4KzZd597vOqRMwBvT1ne+iFUld9FfJOcTn+0
	kO8DNq9wDojb+u0QDK2XchkqrYXrosDRUE4WxawpLKGGCzDZzYTX1bTgWckzOL57
X-Gm-Gg: Acq92OEXsgpcOwuyFeXtMAEXJ59zqoFLgs3AI6evargiE0XhQ9LgI+37Yd8lyOZz/cs
	wrT3E2QiykesrqUi52z2O1eo2jdiLQCwsbd4XLO0mGpuH9coeKpdKhYfIzFriniR7boe/VtDiZ1
	UbzRpkfgAFkh7I0JrYB+PYfwOJS3hL/aJsCfFqVGOeUzq8R3EhqqcZu6T2SJFrXxBMSI4QNG/uL
	YWcpqB6QLQoBvfbTQVFsvWzwSrgDsCbBQO15+OdpGvxgb9AAQ9p6lsB8UCKpm5gvJVCPsCqxr2D
	r9DQCuiX9A3TD+Di51bLtzenKI9shonpjg2RPZgZ9sUDVUg6mvSFxpyi3dMajxtKgfYNybwAmHt
	vItzMQGHqb70jujDOiSmDAjIqeVLgNISQ/saWhatu+YT78NbH88UNEuhp6MgE9tlvS2eOUq7J+d
	9EB3xEhsZxDww3oXS6xXMyiCqStQUTm6yguR14
X-Received: by 2002:a05:690e:2506:10b0:651:cc9c:af0a with SMTP id 956f58d0204a3-65ec97a2faemr2679468d50.15.1779449504520;
        Fri, 22 May 2026 04:31:44 -0700 (PDT)
Received: from [127.0.0.1] ([20.102.47.193])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc80dcf4a9sm15716516d6.2.2026.05.22.04.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 04:31:43 -0700 (PDT)
Message-Id: <6e6580270e05c868c4b5e683ab7232d2dd297251.1779449498.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v11.git.git.1779449498.gitgitgadget@gmail.com>
References: <pull.2285.v10.git.git.1779403204.gitgitgadget@gmail.com>
	<pull.2285.v11.git.git.1779449498.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 22 May 2026 11:31:35 +0000
Subject: [PATCH v11 3/6] branch: prepare delete_branches for a bulk caller
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Johannes Sixt <j6t@kdbg.org>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Add no_head_fallback and dry_run flags to delete_branches() so a bulk
caller (the upcoming --prune-merged) can ask strictly about
merged-into-upstream without a silent fallback to HEAD, and rehearse
deletions with the same "Would delete branch ..." wording as the live
run.  Existing callers pass 0 for both and keep current behavior.

When no_head_fallback is set, head_rev stays NULL through to
branch_merged(), whose "merged to X but not yet merged to HEAD"
reminder otherwise compares against HEAD.  That reminder is only
meaningful when the caller actually cares about HEAD; for the
bulk caller every candidate is known to have an upstream and HEAD
is irrelevant to the decision.  Guard the block on head_rev so the
NULL case skips it instead of treating "NULL != reference_rev" as
"diverges from HEAD" and emitting a spurious warning.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/branch.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 96f6ae6dec..08c1237624 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -170,10 +170,13 @@ static int branch_merged(int kind, const char *name,
 	 * upstream, if any, otherwise with HEAD", we should just
 	 * return the result of the repo_in_merge_bases() above without
 	 * any of the following code, but during the transition period,
-	 * a gentle reminder is in order.
+	 * a gentle reminder is in order.  Callers that opt out of the
+	 * HEAD fallback by passing head_rev=NULL are not interested in
+	 * the reminder either: they have already established that the
+	 * branch has an upstream, so HEAD is irrelevant to the decision.
 	 */
-	if (head_rev != reference_rev) {
-		int expect = head_rev ? repo_in_merge_bases(the_repository, rev, head_rev) : 0;
+	if (head_rev && head_rev != reference_rev) {
+		int expect = repo_in_merge_bases(the_repository, rev, head_rev);
 		if (expect < 0)
 			exit(128);
 		if (expect == merged)
@@ -226,7 +229,8 @@ static void delete_branch_config(const char *branchname)
 }
 
 static int delete_branches(int argc, const char **argv, int force, int kinds,
-			   int quiet, int warn_only)
+			   int quiet, int warn_only, int no_head_fallback,
+			   int dry_run)
 {
 	struct commit *head_rev = NULL;
 	struct object_id oid;
@@ -260,7 +264,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 	}
 	branch_name_pos = strcspn(fmt, "%");
 
-	if (!force)
+	if (!force && !no_head_fallback)
 		head_rev = lookup_commit_reference(the_repository, &head_oid);
 
 	for (i = 0; i < argc; i++, strbuf_reset(&bname)) {
@@ -331,13 +335,20 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 		free(target);
 	}
 
-	if (refs_delete_refs(get_main_ref_store(the_repository), NULL, &refs_to_delete, REF_NO_DEREF))
+	if (!dry_run &&
+	    refs_delete_refs(get_main_ref_store(the_repository), NULL, &refs_to_delete, REF_NO_DEREF))
 		ret = 1;
 
 	for_each_string_list_item(item, &refs_to_delete) {
 		char *describe_ref = item->util;
 		char *name = item->string;
-		if (!refs_ref_exists(get_main_ref_store(the_repository), name)) {
+		if (dry_run) {
+			if (!quiet)
+				printf(remote_branch
+					? _("Would delete remote-tracking branch %s (was %s).\n")
+					: _("Would delete branch %s (was %s).\n"),
+					name + branch_name_pos, describe_ref);
+		} else if (!refs_ref_exists(get_main_ref_store(the_repository), name)) {
 			char *refname = name + branch_name_pos;
 			if (!quiet)
 				printf(remote_branch
@@ -1027,7 +1038,7 @@ int cmd_branch(int argc,
 		if (!argc)
 			die(_("branch name required"));
 		ret = delete_branches(argc, argv, delete > 1, filter.kind,
-				      quiet, 0);
+				      quiet, 0, 0, 0);
 		goto out;
 	} else if (forked) {
 		ret = list_forked_branches(argc, argv);
-- 
gitgitgadget

