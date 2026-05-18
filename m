Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E293A359A68
	for <git@vger.kernel.org>; Mon, 18 May 2026 20:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779135591; cv=none; b=bB31+30VdQCxeidiG1rPukLX93L40+yWQQO6jFnbZERf368cbCmkAJo68fMLUYzNcZdxYmQI+VivHQ9PMmiqCUJ5sQCKrW2EhygNZe+dsLdtwNtyC7OqeFU60f6R2uxr9/0Afu+aAqOYfwVgyHpqRqCsclVppLD1Wbu5RZKsVSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779135591; c=relaxed/simple;
	bh=pDjSzlKKS+wJJZElTdJr8dTuES5kOlrDkNwqFCLFgaA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=mywi7O/XIc8L3Tiok4dh8mXCod8v5Zs6hXDY/mhUD8KLU5Ud5XU7Dmca4chU43efzMsVX/qVOcn9z3Bvr/vktZySpsAGkeXfqyl9Kvg652tVl/i4SwpMPIEs7I+/0WtKNqlUZPGppC7A6rbS5jolK7SoS8kMPycUYgLrlyxp3+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jaaLQDWF; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jaaLQDWF"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-912475287a5so305761485a.2
        for <git@vger.kernel.org>; Mon, 18 May 2026 13:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779135588; x=1779740388; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rUg0rC/FHezYk3D91oekp30JU+bz2n5LOm9fqY9pu3Y=;
        b=jaaLQDWFnsvFIpLqv4xHaoOPBo6bjQ0p/gbmx9C/K9r3mIlQ0tqaLI0SeRqKbwqAux
         Gh3UGHRXF2P2hXWQWaVuGMBD8bQEAYOGu40lZb9Jtc7TM0PZxwXyquORssitTU472WwO
         Wux1Hb6sxmlEGlM5Lx4BTimdmYJpwZgi8ORvEqxZ6A+WvmQdC3mk8w/880gVrbguN0yH
         qA07jsJXz/IPyO0IPq89BO3z1olyx9r5RONgVrXNwuownKkNEWwNRKhxjl3ps6D5ulH3
         bg8Ibb/OZXjN1f2fFVxko9ar94DJBTZ/S+uJptmAxoBSbc+tENJqKYCR9u/J9d7KvIOD
         E3LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779135588; x=1779740388;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rUg0rC/FHezYk3D91oekp30JU+bz2n5LOm9fqY9pu3Y=;
        b=HlS3EDrxvcgNZ/7vje/BJ6zBI41E8bBNNPgRIqwIRzAN2ud++Gi/HuDS79ZSm8iXcR
         Ckng2IAU3qryquxRGpF4PUcYcDLpgwJacPgFVhB8WP5lToxL4C6LzZOGth5nYiDjiYNJ
         F8Cj4kLwu0TzL79LVaeHIRH04lmHaA03LeDdW5WmO3kR+4VnhbZJj/2KJ7Q5CKIsvmfS
         ZMeuI37hbl8+M1VqXOceMcwgBPM7lCBeVylleWcVuu78wJNqzVhbIRw2J6DyKZR/VJMn
         mq6J3dhwJpu6X8NvZ7EWhO+2/6y21+AWT3KTVLY9rY9wVR7lbPGOP1bG3pfpfkyq+DIT
         agIg==
X-Gm-Message-State: AOJu0Yy0CXOGt+5YsX12qAF7qdqXXzUZBPL5ApVqCOV/nqTjINsRv0Cj
	OBehD6HHMTbFBZrVGt5klCGKyV4NbUjZX9ULpuiO0pvg7eFWWQ0TH5Ra41hYmQ==
X-Gm-Gg: Acq92OGOrlD1qLDvRloyZ8XvOeoibfjOvBeLe1sd5//dOfSRv+g6HqtFmfhumJVmYo2
	k/zAqc6KBSkq/seF8E6RNGwZIBJFtkSbFYBqql0/sxPiChmE4wM/08n0alSObZjnkw8dN/u+BHO
	yyK9/cqIVkGxgzIKJ4R6UbzgTby1vA5wVmC8TxHiSPasl0RVYvenFTKzmGbAIO2m/plS1hLP/u2
	37P9HXgnn6MnNlgGd0JX6OcdCTkI0JK+dxnUgDRiVm6TWstjiIgwRjUdoZHGUaNHqWsKRwhmSkE
	c1F9M1F8D84IKcPNwAF8z+mA4Kp6NcK/nG0gYZWJLPllhOGZ1jSsqZchsppnlSMuhU+N+vOnzVb
	iSKLNWTGKO/lnnD4TmESKpthruy9M7g8hcBSylMB1vN+O7J3hM0YCh3DVzIZ6KjWKGYnCpHVCKO
	8rBLQExAbIvRC1usaZuHJfwRpa
X-Received: by 2002:a05:620a:2890:b0:910:c78d:12ef with SMTP id af79cd13be357-911cf3f7626mr2507370985a.38.1779135588455;
        Mon, 18 May 2026 13:19:48 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.117.36])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bcf353b9sm1659048985a.35.2026.05.18.13.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 13:19:47 -0700 (PDT)
Message-Id: <ed0be32e2c67feba0836ea42e30afe1b80ae06a1.1779135575.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2085.v5.git.1779135575.gitgitgadget@gmail.com>
References: <pull.2085.v4.git.1778762495.gitgitgadget@gmail.com>
	<pull.2085.v5.git.1779135575.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 18 May 2026 20:19:34 +0000
Subject: [PATCH v5 8/8] send-pack: pass negotiation config in push
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
    Matthew John Cheetham <mjcheetham@outlook.com>,
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

Reviewed-by: Matthew John Cheetham <mcheetham@outlook.com>
Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/config/remote.adoc |  6 ++++++
 send-pack.c                      | 37 ++++++++++++++++++++++++++------
 send-pack.h                      |  2 ++
 t/t5516-fetch-push.sh            | 30 ++++++++++++++++++++++++++
 transport.c                      |  2 ++
 5 files changed, 70 insertions(+), 7 deletions(-)

diff --git a/Documentation/config/remote.adoc b/Documentation/config/remote.adoc
index 1951df154e..eb9c8a3c48 100644
--- a/Documentation/config/remote.adoc
+++ b/Documentation/config/remote.adoc
@@ -122,6 +122,9 @@ command-line option.  If `--negotiation-restrict` (or its synonym
 `--negotiation-tip`) is specified on the command line, then the config
 values are not used.
 +
+These values also influence negotiation during `git push` if
+`push.negotiate` is enabled.
++
 Blank values signal to ignore all previous values, allowing a reset of
 the list from broader config scenarios.
 
@@ -147,6 +150,9 @@ negotiation algorithm still runs and advertises its own selected commits,
 but the refs matching `remote.<name>.negotiationInclude` are sent
 unconditionally on top of those heuristically selected commits.
 +
+These values also influence negotiation during `git push` if
+`push.negotiate` is enabled.
++
 Blank values signal to ignore all previous values, allowing a reset of
 the list from broader config scenarios.
 
diff --git a/send-pack.c b/send-pack.c
index 3d5d36ba3b..d18e030ce8 100644
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
+
+	if (negotiation_restrict && negotiation_restrict->nr) {
+		struct string_list_item *item;
+		for_each_string_list_item(item, negotiation_restrict)
 			strvec_pushf(&child.args, "--negotiation-restrict=%s",
-				     oid_to_hex(&ref->new_oid));
-			nr_negotiation_tip++;
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
index fa54928966..a2d8958cb8 100644
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
