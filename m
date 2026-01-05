Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A0F2F5331
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 10:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767608275; cv=none; b=MQVhWHBQ9ZReqAzSUeupEr9evyQ9dSizqKXL/72h3hPlHCxLh6/sxpH0u7BfzJmUKwNnXrVR/3sROzQTNvd+07Qg8VxrLYxoXuQb16ZaqYT+rLAfoZ7sUtV+CpKC5Ik1hYqMgqFSTNi5n/vNAk3zwkAoITPqYQoqORyyYoy8/lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767608275; c=relaxed/simple;
	bh=VpIY5xFO1N5CAV2EZWBZMbZCQ6EsA9WMLu1EHlaj0w8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=KvG2SLFzQHjDhkboDjOds9tXqyeXfcQ+SdFsNh0cGt7g6FEHnQ5lW7Hrw3cbqAkX3Yxg8f7qDuov/I+x5o7jfy73k6jB1mX1ZRcMvHxYCx2qr6jK12IFQdlc2N/JnhrSW6yN9ZJ2tSsmn4yjiGtvC7YLYFBMyn4JXpiasGJwkVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GM9dRabV; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GM9dRabV"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8b1bfd4b3deso1258475485a.2
        for <git@vger.kernel.org>; Mon, 05 Jan 2026 02:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767608272; x=1768213072; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W8iricQB0zRxxNEdHtg8AS746kiCiT3Tp5jEpCb9OFw=;
        b=GM9dRabVzSBGjBcQfW8S9hboGWVufqx8trjNFeuJZ6Et2oVynkGVZm75c6zLRxYjMi
         LS6X9oQny6RrQWQLzsCuPoxdBXvr1O6UtHrSeW/CqI8/eEeq8HjAe5cXa2b30eLFvivD
         V0DUf2PVuDuW5SjD7ArqpCckTvj5yGYlog0X2agqb9rCgcaaYlklce9vtTVam2ejgnBS
         QkthwQ0mR5Ztg+RykcsRrjlL/7Rt+E1ZiqJOS6HAo5OvbhVRfgetQuq8oqbYNd+zyNGN
         p3YooC8uc66sqf+BAkRLFYfJDxYx9E2TtfTvSoAK8sAPubnY2IYqtaCflSKYxo38WVi9
         KGyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767608272; x=1768213072;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W8iricQB0zRxxNEdHtg8AS746kiCiT3Tp5jEpCb9OFw=;
        b=f9BIEemKgGmjhnd5kHcZJv7V9bwKAchixS6z1Wf+ykqm3YuyySlt7/g6f2sulP4Cvt
         T4uTCf36rg3wf1bjOvk+OUEzQ6AlGdOm2kV6Kg+4sgfonvyUnkpv/aAuXDZYUXimNvX2
         UwCx4qkeWOJUXyjOVmjpKsFxnGoSiIP90lgrOnZQD7UZbLTjDIqAZUuFyqZWyU4CgImj
         +TY7J/AYtGqnm6/pn0F8H92wNHupHDCOIiNu5cxRiDvXJotV4AzujkW6J6pOIy6aHFjW
         yDFIuWM+cjVHLXhLZRWdLAHJVCpMO/Dh0HynQ+Gpr0hLr7qz0wvteL0omtbnUGSNmNF2
         dLsA==
X-Gm-Message-State: AOJu0Yx6BD5JBt7McTSq144ZdbuhMRXHAZpdKCdqLEbPlzrtuQGjAxd0
	w3qVLbewXG9rn9Rz3pWhZLYNLKgpQHxKDjKLQffdomuNkHx7vWAUM77wsH3k3A==
X-Gm-Gg: AY/fxX4XdIQN14pRjtI7XYFqLbz5ol1oDVxGWbELmMjB67lt9Udaa010Kmes4v8zeZX
	iWpqJZAjoknq1sck5SNeQlnvJPlblbMLqxak4JmNY0b6DhUk/RQqMhGdqb81ZKD8Wdv74lSXOE5
	I2OXHNvl8xNJm/dfYr7begRUN2pXI34w7RPMSZ9rrhWUu2lZwOrVw9/b8tBEr0aejTIjKzp2QXq
	bzSbvxKPAdEaCc4x5uVCquZ2S7p/0Mq833d3hDLPCn/PuhO6yKlC1MlyDhMuJNbixcBzN2LdQOt
	gfeN1/ioUtXPAN2zlw7vV+/7UfeYO/N74zCwfao9C7rEzHVsWacJdB0GcoL+u/+R73aKm3YjNsq
	xNH5D+5hhdIrLsNhRI5awNsxf9jj/eqFMaSGQKXZs2SmW+DOiqbCN5rMveQICo7oYGdTeSfzSlI
	ULP0Zs4jzXA4JA4g==
X-Google-Smtp-Source: AGHT+IFhZAKesA4fOGDMKb1/wXw/nvK62UPMd60iKjEzZS0i8oPNWKzeFk6G4JvIGkRkAlsH9OhRgg==
X-Received: by 2002:a05:620a:85a:b0:8b2:de6a:ca with SMTP id af79cd13be357-8c090120478mr5947924085a.52.1767608272004;
        Mon, 05 Jan 2026 02:17:52 -0800 (PST)
Received: from [127.0.0.1] ([64.236.141.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c096783a81sm3688079185a.9.2026.01.05.02.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 02:17:51 -0800 (PST)
Message-Id: <b62a9feb4ddefb34945a83fd7d76c81c871ea144.1767608269.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v17.git.git.1767608269.gitgitgadget@gmail.com>
References: <pull.2138.v16.git.git.1767568882.gitgitgadget@gmail.com>
	<pull.2138.v17.git.git.1767608269.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 05 Jan 2026 10:17:48 +0000
Subject: [PATCH v17 1/2] refactor format_branch_comparison in preparation
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Refactor format_branch_comparison function in preparation for showing
comparison with push remote tracking branch.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 remote.c | 82 +++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 48 insertions(+), 34 deletions(-)

diff --git a/remote.c b/remote.c
index 59b3715120..7163a8ec28 100644
--- a/remote.c
+++ b/remote.c
@@ -2237,42 +2237,21 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
 	return stat_branch_pair(branch->refname, base, num_ours, num_theirs, abf);
 }
 
-/*
- * Return true when there is anything to report, otherwise false.
- */
-int format_tracking_info(struct branch *branch, struct strbuf *sb,
-			 enum ahead_behind_flags abf,
-			 int show_divergence_advice)
-{
-	int ours, theirs, sti;
-	const char *full_base;
-	char *base;
-	int upstream_is_gone = 0;
-
-	sti = stat_tracking_info(branch, &ours, &theirs, &full_base, 0, abf);
-	if (sti < 0) {
-		if (!full_base)
-			return 0;
-		upstream_is_gone = 1;
-	}
-
-	base = refs_shorten_unambiguous_ref(get_main_ref_store(the_repository),
-					    full_base, 0);
-	if (upstream_is_gone) {
-		strbuf_addf(sb,
-			_("Your branch is based on '%s', but the upstream is gone.\n"),
-			base);
-		if (advice_enabled(ADVICE_STATUS_HINTS))
-			strbuf_addstr(sb,
-				_("  (use \"git branch --unset-upstream\" to fixup)\n"));
-	} else if (!sti) {
+static void format_branch_comparison(struct strbuf *sb,
+				     int sti,
+				     int ours, int theirs,
+				     const char *branch_name,
+				     enum ahead_behind_flags abf,
+				     int show_divergence_advice)
+{
+	if (!sti) {
 		strbuf_addf(sb,
 			_("Your branch is up to date with '%s'.\n"),
-			base);
+			branch_name);
 	} else if (abf == AHEAD_BEHIND_QUICK) {
 		strbuf_addf(sb,
 			    _("Your branch and '%s' refer to different commits.\n"),
-			    base);
+			    branch_name);
 		if (advice_enabled(ADVICE_STATUS_HINTS))
 			strbuf_addf(sb, _("  (use \"%s\" for details)\n"),
 				    "git status --ahead-behind");
@@ -2281,7 +2260,7 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 			Q_("Your branch is ahead of '%s' by %d commit.\n",
 			   "Your branch is ahead of '%s' by %d commits.\n",
 			   ours),
-			base, ours);
+			branch_name, ours);
 		if (advice_enabled(ADVICE_STATUS_HINTS))
 			strbuf_addstr(sb,
 				_("  (use \"git push\" to publish your local commits)\n"));
@@ -2292,7 +2271,7 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 			   "Your branch is behind '%s' by %d commits, "
 			       "and can be fast-forwarded.\n",
 			   theirs),
-			base, theirs);
+			branch_name, theirs);
 		if (advice_enabled(ADVICE_STATUS_HINTS))
 			strbuf_addstr(sb,
 				_("  (use \"git pull\" to update your local branch)\n"));
@@ -2305,12 +2284,47 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 			       "and have %d and %d different commits each, "
 			       "respectively.\n",
 			   ours + theirs),
-			base, ours, theirs);
+			branch_name, ours, theirs);
 		if (show_divergence_advice &&
 		    advice_enabled(ADVICE_STATUS_HINTS))
 			strbuf_addstr(sb,
 				_("  (use \"git pull\" if you want to integrate the remote branch with yours)\n"));
 	}
+}
+
+/*
+ * Return true when there is anything to report, otherwise false.
+ */
+int format_tracking_info(struct branch *branch, struct strbuf *sb,
+			 enum ahead_behind_flags abf,
+			 int show_divergence_advice)
+{
+	int ours, theirs, sti;
+	const char *full_base;
+	char *base;
+	int upstream_is_gone = 0;
+
+	sti = stat_tracking_info(branch, &ours, &theirs, &full_base, 0, abf);
+	if (sti < 0) {
+		if (!full_base)
+			return 0;
+		upstream_is_gone = 1;
+	}
+
+	base = refs_shorten_unambiguous_ref(get_main_ref_store(the_repository),
+					    full_base, 0);
+
+	if (upstream_is_gone) {
+		strbuf_addf(sb,
+			_("Your branch is based on '%s', but the upstream is gone.\n"),
+			base);
+		if (advice_enabled(ADVICE_STATUS_HINTS))
+			strbuf_addstr(sb,
+				_("  (use \"git branch --unset-upstream\" to fixup)\n"));
+	} else {
+		format_branch_comparison(sb, sti, ours, theirs, base, abf, show_divergence_advice);
+	}
+
 	free(base);
 	return 1;
 }
-- 
gitgitgadget

