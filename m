Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92493D905C
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 15:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776266079; cv=none; b=KDDLCZ2hXalw9JCE1Vj7jAFuibD9UF1looyDHxkXZeSoXCK1xzeUQvW/IOPYCa8Xgfj0c2hEhIJi3MCV/0cAw9VehhDzZhwcx3/SCgSTwqXrW9Ll26yyP8mMGxh/Iq0dXsmBcI3xYzbNesH/CYD/Q1E5329/9vAUrGRIc9GkbJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776266079; c=relaxed/simple;
	bh=4kKRrh6iWTWDkh7hXNmftQ/1gi+KYd29B6x8YsMXsF8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=TZHKvQbZixHPPmTwNFL7KYK2v24RK7998YKvN9q8rF2aRyYe+k+sszh5GrD+cHZXFUwPTXClWbxPKFfdq0mcHXV+pODuDjS5csQ5u3Oogtx8j7zu3rvVMUk1C/Rox+9nN0MR+He2btxtyuaIX1FRZrnhWcpDTCKu1+KEZOKBLmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EU4zBmY/; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EU4zBmY/"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-50d876329bbso71321431cf.2
        for <git@vger.kernel.org>; Wed, 15 Apr 2026 08:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776266076; x=1776870876; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VrAOCSZN1wMadZ+KL52RcackNA/HFoOHy0Rkasuh4Ds=;
        b=EU4zBmY/3KvlBBSHsMnQMOVBUM2NIrvWm20RTMULx4lm3vxrE2ufsoPhaUgHj2wzap
         2KnSSEPN0Ff0RoKWmeU6p6AhJGChQhMNgUsooNO6uxgryGkY9fesz9wSu8czjRmhRzHj
         IWRjjtNnSIH9ZHVG+SUbV2+n/t/0RwoyUGDxlTpev+Zyhpyz6eUK1T4I+VecPA+jA97E
         +YCHxcE2jyBTtW3QsvhNG/9VMVINuCMlCLGggGfVy02H81D7ZtnbJx1RUXZ4R5aLBlD4
         Y1rw+LFlfExaE9E8bTQ3gDy0v6mXY5ayv7BLu1ci19IMSUC0EObm2DvHNrXsMmZ+GDF/
         b4wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776266076; x=1776870876;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VrAOCSZN1wMadZ+KL52RcackNA/HFoOHy0Rkasuh4Ds=;
        b=W1QFPSwMRSU8RPMHonMC3iXT4w3aeGZrruNeUPjCKpLH+edNi8Uf3BxNljb6FFgQBd
         YAyNe3IREwVp9B34GxTW6bR21sUiNuktyoTEQ5wMlLxEm6KCgjKebol8ZPlL+rAO/r15
         o7dxM7aXi8cu7dLIE03Q9ZvGU4HMGdE/01w+QBqzpzFiIyP0OfIN6LPE0jA96HYFaH0L
         xap75NFGgiSKi407GCHAq+0evrCshkAZ+uBWzS5qAA6YjoIe309VyNQSCuwxE8k687lv
         JuoWUlF0OUJ8BBNgwAZnzlZRAioZO+9QwQ8MbDPO7iJ54qurP88w4shcDHiH0zagpNAg
         BS9w==
X-Gm-Message-State: AOJu0YxuGMs6YCx0TvPPQxK+vfND/hFlh8lTbLzWjn5zHSs/Ub2+gxA0
	+Q4ShbRWejJOyDKcT1bXycdyIAF/KpYCZROafhBwx1EHf3dljfLqPUOoBHfEhg==
X-Gm-Gg: AeBDietlA6UIli7bkIhgakNfMAGbywW8VkFfmkCsUA2xmTYJFXL3dLZIuZ8Fd5E6843
	gFF8Yg14K2EO1nHa4Bil9WihjJcigf8F67i6a9P8yPjWM5NYSdPnyQtiEOMvu9bl9MVToK4+ieS
	CXQVtmsdvg0BlEmIPjQ604Rbr7B4QuMn9THDvOzNYl6mGT5qCeI/frMuy8rpSjenYRL4TTk/se4
	o56dZbgCvI2skllzosT+ehINTU6HzT32TPhlq9up8Jtv6PxkLo/rWJkpi/aQZ2IHUDy48wMChaD
	QaiMcO11szgoQSrUBsmSwZb2umO/0xHYAGnW+EsHWmTu6uUgZRGEgb9Fn94ojJ7gJHxqYfEiK7m
	MZO/f0Bu+QgGOuyd7Pfjl9XfWl6xqhlwkv61B74QStDHA1nkdeZ9AmzQVbA0Y/Z/RoV80cE6uBS
	dIUNsSQA+uOyDmtGfysVBcxwGk
X-Received: by 2002:a05:622a:90:b0:50d:a644:69b1 with SMTP id d75a77b69052e-50dd5b00a3emr326901071cf.25.1776266076330;
        Wed, 15 Apr 2026 08:14:36 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.13.164])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e1b016a2asm17578491cf.31.2026.04.15.08.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 08:14:35 -0700 (PDT)
Message-Id: <7cccf59beba5918dbeadf9aa57bcf82f2a2e9d85.1776266066.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2085.v2.git.1776266066.gitgitgadget@gmail.com>
References: <pull.2085.git.1775658970.gitgitgadget@gmail.com>
	<pull.2085.v2.git.1776266066.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 15 Apr 2026 15:14:26 +0000
Subject: [PATCH v2 7/7] send-pack: pass negotiation config in push
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
--negotiation-require and --negotiation-restrict options from the
'remote.<name>.negotiationRequire' and
'remote.<name>.negotiationRestrict' config keys to this child process.

When negotiationRestrict is configured, it replaces the default
behavior of using all remote refs as negotiation tips. This allows
the user to control which local refs are used for push negotiation.

When negotiationRequire is configured, the specified ref patterns
are passed as --negotiation-require to ensure their tips are always
sent as 'have' lines during push negotiation.

This change also updates the use of --negotiation-tip into
--negotiation-restrict now that the new synonym exists.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 send-pack.c           | 34 ++++++++++++++++++++++++++++------
 send-pack.h           |  2 ++
 t/t5516-fetch-push.sh | 30 ++++++++++++++++++++++++++++++
 transport.c           |  2 ++
 4 files changed, 62 insertions(+), 6 deletions(-)

diff --git a/send-pack.c b/send-pack.c
index 67d6987b1c..1bf17a73a9 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -433,6 +433,8 @@ static void reject_invalid_nonce(const char *nonce, int len)
 
 static void get_commons_through_negotiation(struct repository *r,
 					    const char *url,
+					    const struct string_list *negotiation_require,
+					    const struct string_list *negotiation_restrict,
 					    const struct ref *remote_refs,
 					    struct oid_array *commons)
 {
@@ -445,13 +447,30 @@ static void get_commons_through_negotiation(struct repository *r,
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
+		nr_negotiation_tip = negotiation_restrict->nr;
+	} else {
+		for (ref = remote_refs; ref; ref = ref->next) {
+			if (!is_null_oid(&ref->new_oid)) {
+				strvec_pushf(&child.args, "--negotiation-tip=%s",
+					     oid_to_hex(&ref->new_oid));
+				nr_negotiation_tip++;
+			}
 		}
 	}
+
+	if (negotiation_require && negotiation_require->nr) {
+		struct string_list_item *item;
+		for_each_string_list_item(item, negotiation_require)
+			strvec_pushf(&child.args, "--negotiation-require=%s",
+				     item->string);
+	}
+
 	strvec_push(&child.args, url);
 
 	if (!nr_negotiation_tip) {
@@ -528,7 +547,10 @@ int send_pack(struct repository *r,
 	repo_config_get_bool(r, "push.negotiate", &push_negotiate);
 	if (push_negotiate) {
 		trace2_region_enter("send_pack", "push_negotiate", r);
-		get_commons_through_negotiation(r, args->url, remote_refs, &commons);
+		get_commons_through_negotiation(r, args->url,
+					       args->negotiation_require,
+					       args->negotiation_restrict,
+					       remote_refs, &commons);
 		trace2_region_leave("send_pack", "push_negotiate", r);
 	}
 
diff --git a/send-pack.h b/send-pack.h
index c5ded2d200..112f31121a 100644
--- a/send-pack.h
+++ b/send-pack.h
@@ -18,6 +18,8 @@ struct repository;
 
 struct send_pack_args {
 	const char *url;
+	const struct string_list *negotiation_require;
+	const struct string_list *negotiation_restrict;
 	unsigned verbose:1,
 		quiet:1,
 		porcelain:1,
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index ac8447f21e..03b797cef5 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -254,6 +254,36 @@ test_expect_success 'push with negotiation does not attempt to fetch submodules'
 	! grep "Fetching submodule" err
 '
 
+test_expect_success 'push with negotiation and remote.<name>.negotiationRequire' '
+	test_when_finished rm -rf negotiation_require &&
+	mk_empty negotiation_require &&
+	git push negotiation_require $the_first_commit:refs/remotes/origin/first_commit &&
+	test_commit -C negotiation_require unrelated_commit &&
+	git -C negotiation_require config receive.hideRefs refs/remotes/origin/first_commit &&
+	test_when_finished "rm event" &&
+	GIT_TRACE2_EVENT="$(pwd)/event" \
+		git -c protocol.version=2 -c push.negotiate=1 \
+		-c remote.negotiation_require.negotiationRequire=refs/heads/main \
+		push negotiation_require refs/heads/main:refs/remotes/origin/main &&
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
index d1b0e9eda0..9903eb1a53 100644
--- a/transport.c
+++ b/transport.c
@@ -921,6 +921,8 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
 	args.atomic = !!(flags & TRANSPORT_PUSH_ATOMIC);
 	args.push_options = transport->push_options;
 	args.url = transport->url;
+	args.negotiation_require = &transport->remote->negotiation_require;
+	args.negotiation_restrict = &transport->remote->negotiation_restrict;
 
 	if (flags & TRANSPORT_PUSH_CERT_ALWAYS)
 		args.push_cert = SEND_PACK_PUSH_CERT_ALWAYS;
-- 
gitgitgadget
