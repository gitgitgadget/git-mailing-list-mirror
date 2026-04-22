Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068DF33ADA2
	for <git@vger.kernel.org>; Wed, 22 Apr 2026 15:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776871565; cv=none; b=AhxMVCwnL0+Pc0wu6zKqe71Ncnzd20druCFh8mzandg9s4ti7Gw7a5jpwGP7vQFaPTzIrS3y3FMDS6ec5PWxDOL5E86BhA6nhBxMcOQttFk7ALX/LfbAVHGBxtDr3KWUTDh8elxFqS/v65xHg8ONNwLIGhtpD+2263XU6Z6Qh3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776871565; c=relaxed/simple;
	bh=JAC6FCVnS8LZJlgFOt47UAl75jnVWTQXWfxCxlLJRu0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=l/mXhtSupxO0PPRueXSL9NH/HGVufooISmqgk79Nt6ASCbwZsIryDT3M52cADKZ5RuzIEBlWcaeQCiAwSb8cfkpKgFNrXG+4vLHBkRln+668DVCRdgfhnTiosvskb/iew0hr5yoIeeOixxlsIDKzVmEH9d9VEQrbkhluFvUzmQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L+FsWNCs; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+FsWNCs"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2c15849aa2cso7560801eec.0
        for <git@vger.kernel.org>; Wed, 22 Apr 2026 08:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776871560; x=1777476360; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r67y3iNe+tw951VS7Kan0yPDA/rLqRtRlnQT11Au20w=;
        b=L+FsWNCs1cDQMo7F+xhH2GhGVyF7tjisDNX9x0GxYG0xhm88kUzGLftXNpnyX99wdM
         yO02pcFRHfAH1RTahGyKpPrDrSqxvsAZEFxMZRn5bHSfHqI809x+2iyaLW3+WviMKRUS
         Oy09do3YK4+qlv2L+Wbo3AkAVaawDcV0iWyKI4hUIs7ouNBs6J5Vl6LEpcrkBF0idh66
         5EGPQf2IENdeYSFCCyzToL+LzqL1rhWf+uQLeOxArPz3GTrkOnK6G90t6GSFPn0pVdoy
         5/Kx6XmWM0fvplVsyW06GQowME4F9xa4L8ebPgDxcANEbQVz6KhJuHGB/zCmSljrcPw4
         +SOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776871560; x=1777476360;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r67y3iNe+tw951VS7Kan0yPDA/rLqRtRlnQT11Au20w=;
        b=ePHRh3Fxrd0lUcyuxWqDeLfiHwiIxY5xhbgBsTP8/qyOoMwrmm4P2CGEo8wB4ZxoLv
         rWZbKZmZW+N3gRcUP3/udEGk5zP+na6J0UeyC7U3bP3ax/g/jmqnM4lypya+h72j7vD3
         7PaIvvttOE824GoG9CA+okDfozq9SwfYEa74fQnGm3VPUzTfV74gKR3R24pH9kiziAvm
         geX93wZglKOLMskPxcN7R7RzvBHSrAkhJ0vT9n80x2RjoW1qXlEkMtYTNzS2Cp7OLytN
         utDHNI4jkfjf9IG+S8FshEYnkvT8wbTMKFjeN0hqPKV+a713bj+ZwRMi2+7EFxLdn0aW
         MP3A==
X-Gm-Message-State: AOJu0YzTQfM9Lylo1++tOaylwFFNRCFO6ytixrju503CXXCz6bE0cgmU
	xIIrO5QMiSZAE/OBBJXIxPuxlOdQUEiNRLFTNgI5/JKzGXgjGHWI79x3G+0FSA==
X-Gm-Gg: AeBDies2sEr+kcEsjXqOYvGaGQHVOZI+JyaRzKFKjz1/RnDtAXEFzZyYcZ08/+4+cS6
	9QufVc6KGwIemftGW7ITFoprLLQfbKnBbHRT1dqxYj3Vo8LmJeZsy8HqOhXbDJTjpO0OfX38sIZ
	CXeSIzWs/VCaxYNSFdoCrJaWlf5iDgq8A+ijNMccP/kzcwp5bs+MA9iOkXkmk4uorTUJ+8dWASA
	x00aTscMtnjC4+3CJzETXHtZkbv6kytYVHiDI1ke7BmXyBxGHAX2vlQ7BBl7wBWkOT90Ov5/Obf
	VoYA2t3lRrvLWLhVUiBs6/krNIyYxO1J3fa78K5ZmxSmkSd19cnioSaH6+xB3OTZocRDpi11BSl
	MF1iN4maayyK43Rb/7v7MW0eKc4755NGHDOiDM5WAhBc9280lJG+cFmSTjLg4qEuVB4ugljFba/
	h1EeHpDXpo7w40oUMZQgQSLG8KBYKYC5nfvL9TDA==
X-Received: by 2002:a05:7300:dc88:b0:2be:171c:5048 with SMTP id 5a478bee46e88-2e4646cbd46mr11013765eec.5.1776871559994;
        Wed, 22 Apr 2026 08:25:59 -0700 (PDT)
Received: from [127.0.0.1] ([128.24.160.246])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53d2cfc1dsm22913339eec.22.2026.04.22.08.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 08:25:59 -0700 (PDT)
Message-Id: <e6c79f0661b97d0081ae36b17be8ccb3b9ec64e4.1776871546.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2085.v3.git.1776871546.gitgitgadget@gmail.com>
References: <pull.2085.v2.git.1776266066.gitgitgadget@gmail.com>
	<pull.2085.v3.git.1776871546.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 22 Apr 2026 15:25:46 +0000
Subject: [PATCH v3 7/7] send-pack: pass negotiation config in push
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
Cc: gitster@pobox.com,
    ps@pks.im,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

When push.negotiate is enabled, 'git push' spawns a child 'git fetch
--negotiate-only' process to find common commits.  Pass
--negotiation-include and --negotiation-restrict options from the
'remote.<name>.negotiationInclude' and
'remote.<name>.negotiationRestrict' config keys to this child process.

When negotiationRestrict is configured, it replaces the default
behavior of using all remote refs as negotiation tips. This allows
the user to control which local refs are used for push negotiation.

When negotiationInclude is configured, the specified ref patterns
are passed as --negotiation-include to ensure their tips are always
sent as 'have' lines during push negotiation.

This change also updates the use of --negotiation-tip into
--negotiation-restrict now that the new synonym exists.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 send-pack.c           | 39 +++++++++++++++++++++++++++++++--------
 send-pack.h           |  2 ++
 t/t5516-fetch-push.sh | 30 ++++++++++++++++++++++++++++++
 transport.c           |  2 ++
 4 files changed, 65 insertions(+), 8 deletions(-)

diff --git a/send-pack.c b/send-pack.c
index 67d6987b1c..d18e030ce8 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -433,28 +433,48 @@ static void reject_invalid_nonce(const char *nonce, int len)
 
 static void get_commons_through_negotiation(struct repository *r,
 					    const char *url,
+					    const struct string_list *negotiation_include,
+					    const struct string_list *negotiation_restrict,
 					    const struct ref *remote_refs,
 					    struct oid_array *commons)
 {
 	struct child_process child = CHILD_PROCESS_INIT;
 	const struct ref *ref;
 	int len = r->hash_algo->hexsz + 1; /* hash + NL */
-	int nr_negotiation_tip = 0;
+	int nr_negotiation = 0;
 
 	child.git_cmd = 1;
 	child.no_stdin = 1;
 	child.out = -1;
 	strvec_pushl(&child.args, "fetch", "--negotiate-only", NULL);
-	for (ref = remote_refs; ref; ref = ref->next) {
-		if (!is_null_oid(&ref->new_oid)) {
-			strvec_pushf(&child.args, "--negotiation-tip=%s",
-				     oid_to_hex(&ref->new_oid));
-			nr_negotiation_tip++;
+
+	if (negotiation_restrict && negotiation_restrict->nr) {
+		struct string_list_item *item;
+		for_each_string_list_item(item, negotiation_restrict)
+			strvec_pushf(&child.args, "--negotiation-restrict=%s",
+				     item->string);
+		nr_negotiation = negotiation_restrict->nr;
+	} else {
+		for (ref = remote_refs; ref; ref = ref->next) {
+			if (!is_null_oid(&ref->new_oid)) {
+				strvec_pushf(&child.args, "--negotiation-restrict=%s",
+					     oid_to_hex(&ref->new_oid));
+				nr_negotiation++;
+			}
 		}
 	}
+
+	if (negotiation_include && negotiation_include->nr) {
+		struct string_list_item *item;
+		for_each_string_list_item(item, negotiation_include)
+			strvec_pushf(&child.args, "--negotiation-include=%s",
+				     item->string);
+		nr_negotiation += negotiation_include->nr;
+	}
+
 	strvec_push(&child.args, url);
 
-	if (!nr_negotiation_tip) {
+	if (!nr_negotiation) {
 		child_process_clear(&child);
 		return;
 	}
@@ -528,7 +548,10 @@ int send_pack(struct repository *r,
 	repo_config_get_bool(r, "push.negotiate", &push_negotiate);
 	if (push_negotiate) {
 		trace2_region_enter("send_pack", "push_negotiate", r);
-		get_commons_through_negotiation(r, args->url, remote_refs, &commons);
+		get_commons_through_negotiation(r, args->url,
+					       args->negotiation_include,
+					       args->negotiation_restrict,
+					       remote_refs, &commons);
 		trace2_region_leave("send_pack", "push_negotiate", r);
 	}
 
diff --git a/send-pack.h b/send-pack.h
index c5ded2d200..13850c98bb 100644
--- a/send-pack.h
+++ b/send-pack.h
@@ -18,6 +18,8 @@ struct repository;
 
 struct send_pack_args {
 	const char *url;
+	const struct string_list *negotiation_include;
+	const struct string_list *negotiation_restrict;
 	unsigned verbose:1,
 		quiet:1,
 		porcelain:1,
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index ac8447f21e..177cbc6c75 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -254,6 +254,36 @@ test_expect_success 'push with negotiation does not attempt to fetch submodules'
 	! grep "Fetching submodule" err
 '
 
+test_expect_success 'push with negotiation and remote.<name>.negotiationInclude' '
+	test_when_finished rm -rf negotiation_include &&
+	mk_empty negotiation_include &&
+	git push negotiation_include $the_first_commit:refs/remotes/origin/first_commit &&
+	test_commit -C negotiation_include unrelated_commit &&
+	git -C negotiation_include config receive.hideRefs refs/remotes/origin/first_commit &&
+	test_when_finished "rm event" &&
+	GIT_TRACE2_EVENT="$(pwd)/event" \
+		git -c protocol.version=2 -c push.negotiate=1 \
+		-c remote.negotiation_include.negotiationInclude=refs/heads/main \
+		push negotiation_include refs/heads/main:refs/remotes/origin/main &&
+	test_grep \"key\":\"total_rounds\" event &&
+	grep_wrote 2 event # 1 commit, 1 tree
+'
+
+test_expect_success 'push with negotiation and remote.<name>.negotiationRestrict' '
+	test_when_finished rm -rf negotiation_restrict &&
+	mk_empty negotiation_restrict &&
+	git push negotiation_restrict $the_first_commit:refs/remotes/origin/first_commit &&
+	test_commit -C negotiation_restrict unrelated_commit &&
+	git -C negotiation_restrict config receive.hideRefs refs/remotes/origin/first_commit &&
+	test_when_finished "rm event" &&
+	GIT_TRACE2_EVENT="$(pwd)/event" \
+		git -c protocol.version=2 -c push.negotiate=1 \
+		-c remote.negotiation_restrict.negotiationRestrict=refs/heads/main \
+		push negotiation_restrict refs/heads/main:refs/remotes/origin/main &&
+	test_grep \"key\":\"total_rounds\" event &&
+	grep_wrote 2 event # 1 commit, 1 tree
+'
+
 test_expect_success 'push without wildcard' '
 	mk_empty testrepo &&
 
diff --git a/transport.c b/transport.c
index 8a2d8adffc..60b73feb34 100644
--- a/transport.c
+++ b/transport.c
@@ -921,6 +921,8 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
 	args.atomic = !!(flags & TRANSPORT_PUSH_ATOMIC);
 	args.push_options = transport->push_options;
 	args.url = transport->url;
+	args.negotiation_include = &transport->remote->negotiation_include;
+	args.negotiation_restrict = &transport->remote->negotiation_restrict;
 
 	if (flags & TRANSPORT_PUSH_CERT_ALWAYS)
 		args.push_cert = SEND_PACK_PUSH_CERT_ALWAYS;
-- 
gitgitgadget
