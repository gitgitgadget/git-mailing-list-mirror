Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8EB3806B4
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 21:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781300962; cv=none; b=MlgZC4qRjr7yCIpJEBiDte5MZdxkOJJayJhXpNwdixNhHGGnZTT7oULhwJTWFCosCzBwzxjdZG3YgHviYDeuguZGepCVMz8bgjiR4IeCrPuCVksw/6jlWEqNzQ4sASj9uLvgKQNeTSokW1puib/ZXrEiBpEBPphLY5b1gapcHJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781300962; c=relaxed/simple;
	bh=Pu+wM7pxc3t5Ms3QwqOstw478gIP3kZuWZEP6CuFJg0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pu1rDrLmYeqk96hcFHMGkPiECT5zUf7ksxFoLtraIPs5izWCi3a8YEgaAdxoDqqY5lVNqxNmi1JYhMwpCt88Gr5Liod97rI4uzw3FyoqGFlyH/peljh3ymxj+D3mhjP9UJ/XXfFFeKOWuEXss5B0WetVWwLUMD3Q7CUZ/La5C4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hucFOGx2; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hucFOGx2"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8ccf18ef922so20084276d6.3
        for <git@vger.kernel.org>; Fri, 12 Jun 2026 14:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781300960; x=1781905760; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kuwB9N30uvGAQOWalLGYby7tCjanWIHClR7t2Kq1jP0=;
        b=hucFOGx2EVmJgU1CCb1xZTsXPt3cfx1GvuA5+BUTNI9YyDfg5N5Ins57SPHvSxCZHb
         QBUm6b8+oDQ6aKX2M4mVj2s1o+ZfC9G004GWl66sCaYke4Z3rEKG2PNlCZqM7fU9gOl6
         du4jRALezIj4MMFRW5F9Py4Gfkl4ubP9syj+yaVN+8J5QhP7QM4WYV6XGbfTQ2SoRHf9
         ILQ9gUB+0sDyl8CiztywB13X07eJ5uRysgw8s5M8saFP7Shbd/128H170RTLQC/OZvIp
         FoBwLZAgh3+Y+0z0V6jkf4umD9VpJduk5ybLcE6YiLkedAx2cnWge6I5JrZJvvW+X55m
         mWKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781300960; x=1781905760;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kuwB9N30uvGAQOWalLGYby7tCjanWIHClR7t2Kq1jP0=;
        b=MMKNHWeA9SWZ8QCs9hotd7GY16PIel4hbFq8iHIKUzoxaQ6D9QWnf8hQ9c6RoxIdbU
         hb8LdKx4jscz1/Ba7Ml7YMnpmdqcPE5oa4P6dhUSN+Lx5VHWKFndJ6BPbRkjHQJI1TPM
         6tpQ1aEij6/WAyHat2qpr87BwSQdC5NKvIxQ17LyACJSQewYhIruoQr+ziMTX8fI4hbj
         GtSVp1vnYfkcJSqel4BWJEnGY5vKShHUfnck1z/U1LpjzvvF5wlNlCOsS5qTi3+pKpDk
         6VVePW8sxOjNcRQGUXlGVs7gLVj+DCqID5lHawgDrOLJMIoP98BBgALVMIgFQMmcyfl2
         OM0w==
X-Gm-Message-State: AOJu0Yxvdk8XRVajygtFE3iMh7z5tEu2j/oAF0J3wUu5T1XJLe6hYGQJ
	a6h2DQxbUGw8Lv4a2TMDnYjQ65LssDUZ8oyrQOkPD0RBMR4RLSMr+91lT5MAO24Z
X-Gm-Gg: Acq92OErvBUcuY1y+mQ9luOfE68/saCIMqJGbrc7DAaMSGqTfsdr7C/uYu+R5wQr/G8
	oSGK2/lDp9MHfqn+MU3eBmlv632Jurnjd1aTo71KWBbQnE9GwvBhsxyQT36tGmTyV1KhLvGLRqR
	qI6AEzkccgesPb/xoE+ByQljp/eEH/IoMKUKh5F+DYlMGAljQTaWkcDG4ObDD5lsJwqYlS0mTM+
	9NtwCCh2O6fP5zQq4EdJc3pR7NV0WgpDfs8IE0f703n67YBpRw7eHwJrtH0t/031/QGexRV7zfW
	w2xKxtHd8w/z8mbcpfHylTOdCQkmoO/NktWBLjeK1MTO2zaII6ZPHX3gGQWW6kAthTdCqlCJmR8
	YPaQ1n81ajbeNseouMNLLGpBNpaxgEuM4wojR4keeLVQnesZskqbL0aM9T0pTGTUjIpk/+h3s5k
	ra0bd5E0DrFOfGzWsE+q+YitNdzx8MKe00oyi8Fi5t9JMBy2AvgDyUI9+pHd2eAF1Bc1l+XwQah
	fMLRa/v8JhKZudFYC+/cUqsDFR51ODXUCHJ6Pz9fb9qXmlVDiGI4ZvFnCKr+wCeuU4ZZJfNQ0kP
	lSECMEmau7vjM5C3SCn+mi4iVDSt8mJSuDMmXak/uN9GBonQZooyQaa7t4P79WJk
X-Received: by 2002:a05:6214:5008:b0:8cc:2a92:11b6 with SMTP id 6a1803df08f44-8d44c5acd58mr20464586d6.9.1781300960090;
        Fri, 12 Jun 2026 14:49:20 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4808:6353:5c00:980:d7de:1287:a424])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d302114676sm36593136d6.20.2026.06.12.14.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 14:49:19 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 12 Jun 2026 17:49:12 -0400
Subject: [PATCH v4 1/3] commit-reach: reject cycles in contains walk
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-ref-filter-memoized-contains-v4-1-5ed39fd001dd@gmail.com>
References: <20260612-ref-filter-memoized-contains-v4-0-5ed39fd001dd@gmail.com>
In-Reply-To: <20260612-ref-filter-memoized-contains-v4-0-5ed39fd001dd@gmail.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>, 
 Derrick Stolee <stolee@gmail.com>, Elijah Newren <newren@gmail.com>, 
 Kristofer Karlsson <krka@spotify.com>, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1781300957; l=4091;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=Pu+wM7pxc3t5Ms3QwqOstw478gIP3kZuWZEP6CuFJg0=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QMQLgPOt1nW5/HROmstz5UFvVTsJsPs4YyKGHDZbT8GrhESofkgLGyr0W/TEGdyrpl/KMqipM5J
 2vK7NkkWTTw4=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

The memoized contains traversal used by git tag assumes that commit
ancestry is acyclic. Replacement refs can violate that assumption,
causing it to keep pushing an already active commit until memory is
exhausted.

Mark commits while they are active and die if the traversal encounters
an active commit. Other failures in this walk already die through
parse_commit_or_die(); using a second reachability walk would only add
a separate policy for malformed history.

Suggested-by: Kristofer Karlsson <krka@spotify.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 commit-reach.c | 12 +++++++++---
 commit-reach.h |  3 ++-
 t/t7004-tag.sh | 18 ++++++++++++++++++
 3 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index 9b3ea46d6f..e1bedc596d 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -708,7 +708,8 @@ static int in_commit_list(const struct commit_list *want, struct commit *c)
 
 /*
  * Test whether the candidate is contained in the list.
- * Do not recurse to find out, though, but return -1 if inconclusive.
+ * Do not recurse to find out, though, but return CONTAINS_UNKNOWN if
+ * inconclusive.
  */
 static enum contains_result contains_test(struct commit *candidate,
 					  const struct commit_list *want,
@@ -765,6 +766,7 @@ static enum contains_result contains_tag_algo(struct commit *candidate,
 	if (result != CONTAINS_UNKNOWN)
 		return result;
 
+	*contains_cache_at(cache, candidate) = CONTAINS_IN_PROGRESS;
 	push_to_contains_stack(candidate, &contains_stack);
 	while (contains_stack.nr) {
 		struct contains_stack_entry *entry = &contains_stack.contains_stack[contains_stack.nr - 1];
@@ -776,8 +778,8 @@ static enum contains_result contains_tag_algo(struct commit *candidate,
 			contains_stack.nr--;
 		}
 		/*
-		 * If we just popped the stack, parents->item has been marked,
-		 * therefore contains_test will return a meaningful yes/no.
+		 * A parent may have just been popped and marked, or may still
+		 * be active when replacement refs create a cycle.
 		 */
 		else switch (contains_test(parents->item, want, cache, cutoff)) {
 		case CONTAINS_YES:
@@ -787,7 +789,11 @@ static enum contains_result contains_tag_algo(struct commit *candidate,
 		case CONTAINS_NO:
 			entry->parents = parents->next;
 			break;
+		case CONTAINS_IN_PROGRESS:
+			die(_("commit ancestry contains a cycle"));
 		case CONTAINS_UNKNOWN:
+			*contains_cache_at(cache, parents->item) =
+				CONTAINS_IN_PROGRESS;
 			push_to_contains_stack(parents->item, &contains_stack);
 			break;
 		}
diff --git a/commit-reach.h b/commit-reach.h
index 3f3a563d8a..f908d305b1 100644
--- a/commit-reach.h
+++ b/commit-reach.h
@@ -73,7 +73,8 @@ int ref_newer(const struct object_id *new_oid, const struct object_id *old_oid);
 enum contains_result {
 	CONTAINS_UNKNOWN = 0,
 	CONTAINS_NO,
-	CONTAINS_YES
+	CONTAINS_YES,
+	CONTAINS_IN_PROGRESS
 };
 
 define_commit_slab(contains_cache, enum contains_result);
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index d918005dd9..67309494d2 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1611,6 +1611,24 @@ test_expect_success 'checking that first commit is in all tags (hash)' '
 	test_cmp expected actual
 '
 
+test_expect_success 'tag --contains rejects cyclic replacement histories' '
+	first=$(git rev-parse HEAD~2) &&
+	second=$(git rev-parse HEAD~) &&
+	third=$(git rev-parse HEAD) &&
+	test_when_finished "
+		git replace -d $first &&
+		git replace -d $third &&
+		git tag -d cycle-a cycle-b
+	" &&
+	git tag cycle-a "$first" &&
+	git tag cycle-b "$third" &&
+	git replace --graft "$first" "$third" "$second" &&
+	git replace --graft "$third" "$first" &&
+	test_must_fail git tag --contains="$second" --list "cycle-*" \
+		>/dev/null 2>err &&
+	test_grep "fatal: commit ancestry contains a cycle" err
+'
+
 # other ways of specifying the commit
 test_expect_success 'checking that first commit is in all tags (tag)' '
 	cat >expected <<-\EOF &&

-- 
2.54.0.548.gbe7bb2469c

