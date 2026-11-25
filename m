Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795636173;
	b=WBb4SQG1DiGJJTBSFkSIX4NKco50PwxJqQPZCEL1JyJQywxQj5Dplz4DwD29EhQuJGtl
	 Pvav08r4sI6RnNM0+DamHeH30lK56pTxXbTdqMtaRrFOETvnmTELu7EdTxTfHN1wossVN
	 axupxuuN6j2VeAvOmxB4iV+hiW/cyCTyZUhLRrtHPmG10C8rBRPnorsgFPKbcCfxevdyD
	 c7hDeVYvYXhPBkrUziv8DrsYuFgnv/wt+wSDCGYONyZ+5rRL02VGo1VkNxWyIpIE0WvlW
	 9sjtMFBtJyrWNn6AFQwgCnfxfvvlgcMHvRIzjecR9b/P8vvNJ5Lfr6Qt6ikkLv8nusQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795636173;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=ug03BjMObMkzJA03sg+7wwQPtepb8q/HJBcmJwlyLcY=;
	b=MN7rhdBeIKLhUAki8VrhPn+mVMJV1GfSk/isYwHhM2jgBkpiTDTuitczjrY/CEWxmHc1
	 32RnYwLwTflw7JwcTGTOAiA9k9I/rS+sSBBzISGIN/+aRIjwPlzZbnBavSSbx9tWuWgLe
	 sO/NlHNe2yHN1i7sEvjzG+TUPEmGR+LtS/aU9v+12cyCo2BAcSexShNj5y5OC3hNRf1gn
	 x7SZ4vGrkbL8OFOre7y/PUHQmFwz4heIGWZ+bVE42bdTdfo3NO8NqFgp9YRndpB/lD8Hr
	 O6JPB2Zs8Uw8FjXrUeelhS2vxukOz4wiO1yc3TFBipTE32tOdPquRA8NRj27GPa+dfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XTYADcz+;
	arc=none smtp.remote-ip=209.85.210.49
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF329606A31E
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 19:49:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF329606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XTYADcz+
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-843b6f8e2c7so6379308a34.1
        for <git@vger.kernel.org>; Wed, 25 Nov 2026 11:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795636172; x=1796240972; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ug03BjMObMkzJA03sg+7wwQPtepb8q/HJBcmJwlyLcY=;
        b=XTYADcz+4mlKiCZ9aB1pKl0CuATht4lTjW5l2Lqs6PHAoOu+waZiw9l8qSEphqzKxW
         97xZoBVyXjzko+u6p8BQfi0PqhDiZsLl+h9yM1sLrDpquH9/WNsmNbUf/+wdZPFgXxmU
         1bdA/TgQIY+8kaCzAw6lkHOlvncRQNB+52x3oBq6EuGqZwEqSRWz96d2Tetl+siL2sLa
         jmTZJCVcXCoX+t45pN0YTlTzzsqt+BpPaNfWlhCdBLKvvftd/CsRifVqgqq/WYv4/apZ
         ynxCr73fDJ7TLKqjEPXAIdFl5L+ajWulNEqpnRf0gCKvPM0uxPxxu6zCbYjNgAc99aiR
         y5PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795636172; x=1796240972;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ug03BjMObMkzJA03sg+7wwQPtepb8q/HJBcmJwlyLcY=;
        b=JIJOSSrTzgB0njnRwic5fa9gKbEt8tTkzGf6ynueHH5Wh4RWPX+k0v2EF+znOPquPp
         4S/0j4Aq8MgOWgRZBGSFD84Ad2qicxzsIfbhyJBOOoQyobZw8yZdF5rXu63eiBIKFHLe
         bVX7Z1AQl7VJAwLShpXNuIuoCIe9YQfuhEdEDGNR1MlsYTIjpM4OiHpTkwcuovhbvoHl
         Mc+l7enpuiY0AI25l1QXxLDFC+Vr8zOFqQEBV1UeNTkSqirNvt9u6SGtfb3CJtcGtz0A
         XvHE+8r/kil9XZa7l8M+oJrZQdq4TRkBQIy0pXr21lwOG15HYl7BVMZe/4h12OJA7SMD
         kLAw==
X-Gm-Message-State: APuU4Z+Ix2CoOOpNoBGyF/qrVMnDZ2LqJj7UlFOc+oTOEvX44ILHWif2
	rQnK4S5Fq9u7Wsp4FfjZhkhT0iLrn8mGnUQqHJqZ5m4jbmvGKZY03/dSy8s+6A==
X-Gm-Gg: AZFdTZcTX+5dnOCUliO3KOUawAoFFydDgMBE1hZpWQtIucGLJd5qEFJqElAsP86fP7r
	l5FWWSKiIQvvn1S2oi6/vG0pOaneplDQJ4dhfiv8yH4RTla0q9sLNZlW9S02bOD+9ee/OgzmIiR
	Lc+2UbXe5j7DbnKUNq+fqdm3njMT5i6spMesoR12OrjpNQGxqFa2S2q/vY5hhvOZ9PPyuznlDLF
	cwEhvKt0gvbMztwNiRGFJ9fnZf1+j8/ZjFn2BwHoGmBqZdwrkHDq/PReTneN1NLsVzdnkk4OxrH
	y3tyrt203zTbwq9s47sZOXN9UxbgSf05AVOEYye2wbWWFU2kwIO7II4H8Hv633ojPPzPDh7YuSc
	Q0mwhiXcvZK4NJfZGmzzc2wHRcQmrIr+DcxEmG1e9SX/InbZhMLbhAzMCdELexLxptCYn1t57ra
	iz/Dn9CtHfI3TByJD2E+NU8CTrpkALbmTAXxVYpTw5lf3hz9WR74vcGW1WenObP65cXVp/sfuvO
	G8JkMxkwJwZJN2pHltgtb5Lq5zeMqSJvph8OcDgML92DpuKnyXrB8qKh7ZAiSDBXzG8tIcTna6x
	9AJVdJdrxN0q2qzsIgj1JW8+Bi88P1ydZA==
X-Received: by 2002:a05:6830:91e:b0:862:a48e:24db with SMTP id 46e09a7af769-863159e176emr26733144a34.18.1795636171543;
        Wed, 25 Nov 2026 11:49:31 -0800 (PST)
Received: from [127.0.0.1] ([48.214.151.200])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-863169105b7sm14570069a34.22.2026.11.25.11.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 11:49:31 -0800 (PST)
Message-Id: <pull.2333.v2.git.1795636170423.gitgitgadget@gmail.com>
In-Reply-To: <pull.2333.git.1795635624820.gitgitgadget@gmail.com>
References: <pull.2333.git.1795635624820.gitgitgadget@gmail.com>
From: "Alessio Attilio via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 25 Nov 2026 19:49:30 +0000
Subject: [PATCH v2] pack-objects: handle missing promisor objects
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Alessio Attilio <attilio.alessio@protonmail.com>,
    Alessio Attilio <attilio.alessio@protonmail.com>

From: Alessio Attilio <attilio.alessio@protonmail.com>

Objects missing from a partial clone are expected to be absent.
When checking whether an object is in a promisor pack, do not BUG()
if its object info cannot be read. Such an object cannot be included
in the pack, so skip it.

Pass OBJECT_INFO_SKIP_FETCH_OBJECT explicitly so the lookup does not
trigger a lazy fetch.

Test filtered --unshallow and --deepen fetches, as well as a subsequent
fetch that repacks links to promisor commits with missing trees.

Signed-off-by: Alessio Attilio <attilio.alessio@protonmail.com>
---
    pack-objects: handle missing promisor objects
    
    Changes since v1:
    
     * Pass OBJECT_INFO_SKIP_FETCH_OBJECT explicitly to avoid lazy fetching
       during the lookup.
     * Cover both filtered --unshallow and --deepen fetches, and a later
       fetch after unshallowing a filtered clone.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2333%2Fkairosci%2Fattilio%2Fpack-objects-missing-promisor-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2333/kairosci/attilio/pack-objects-missing-promisor-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2333

Range-diff vs v1:

 1:  16a9cac809 ! 1:  a7e378ca3d pack-objects: handle missing promisor objects
     @@ Commit message
          if its object info cannot be read. Such an object cannot be included
          in the pack, so skip it.
      
     +    Pass OBJECT_INFO_SKIP_FETCH_OBJECT explicitly so the lookup does not
     +    trigger a lazy fetch.
     +
     +    Test filtered --unshallow and --deepen fetches, as well as a subsequent
     +    fetch that repacks links to promisor commits with missing trees.
     +
          Signed-off-by: Alessio Attilio <attilio.alessio@protonmail.com>
      
       ## builtin/pack-objects.c ##
      @@ builtin/pack-objects.c: static int is_not_in_promisor_pack_obj(struct object *obj, void *data UNUSED)
     + 		.source_infop = &source_info,
       	};
       
     - 	if (odb_read_object_info_extended(the_repository->objects, &obj->oid, &info, 0))
     +-	if (odb_read_object_info_extended(the_repository->objects, &obj->oid, &info, 0))
      -		BUG("should_include_obj should only be called on existing objects");
     ++	if (odb_read_object_info_extended(the_repository->objects, &obj->oid, &info,
     ++					  OBJECT_INFO_SKIP_FETCH_OBJECT)) {
     ++		/* Missing; assume it is a promisor object. */
      +		return 0;
     ++	}
       	return source_info.source->type != ODB_SOURCE_PACKED || !source_info.u.packed.pack->pack_promisor;
       }
       
      
     - ## t/t0410-partial-clone.sh ##
     -@@ t/t0410-partial-clone.sh: promise_and_delete () {
     - 	delete_object repo "$HASH"
     - }
     + ## t/t5616-partial-clone.sh ##
     +@@ t/t5616-partial-clone.sh: test_expect_success 'after fetching descendants of non-promisor commits, gc work
     + 	git -C partial gc --prune=now
     + '
       
     -+test_expect_success 'fetch --unshallow with tree filter when remote has advanced' '
     -+	rm -rf server server.bare client &&
     -+	test_create_repo server &&
     -+	test_commit -C server c1 &&
     -+	test_commit -C server c2 &&
     -+	test_commit -C server c3 &&
     -+	test_commit -C server c4 &&
     -+	git clone --bare server server.bare &&
     -+	git -C server.bare config uploadpack.allowfilter true &&
     -+	git -C server.bare config uploadpack.allowanysha1inwant true &&
     -+	git init client &&
     -+	git -C client remote add origin "file://$(pwd)/server.bare" &&
     -+	tip=$(git -C server rev-parse HEAD~1) &&
     -+	git -C client fetch --no-tags --depth=1 origin "+$tip:refs/remotes/origin/master" &&
     -+	git -C client checkout -b master refs/remotes/origin/master &&
     -+	git -C client fetch --no-tags --filter=tree:0 --unshallow origin \
     -+		+refs/heads/master:refs/remotes/origin/master &&
     -+	rm -rf server server.bare client
     ++for opt in --unshallow --deepen=1
     ++do
     ++	test_expect_success "filtered fetch $opt of a moved ref repacks local links" '
     ++		test_when_finished "rm -rf source target" &&
     ++
     ++		git init source &&
     ++		test_commit_bulk -C source 4 &&
     ++		git -C source config uploadpack.allowFilter true &&
     ++		git -C source config uploadpack.allowAnySHA1InWant true &&
     ++		COMMIT=$(git -C source rev-parse main~1) &&
     ++
     ++		git init target &&
     ++		git -C target remote add origin "file://$(pwd)/source" &&
     ++		git -C target fetch --no-tags --depth=1 origin "+$COMMIT:refs/remotes/origin/main" &&
     ++
     ++		# The fetched pack has the new tip whose parent is the local shallow
     ++		# tip, so index-pack repacks it into a promisor pack. That process
     ++		# inherits the shallow file and walks into promisor commits whose
     ++		# trees do not exist.
     ++		git -C target fetch --no-tags --filter=tree:0 "$opt" origin \
     ++			+refs/heads/main:refs/remotes/origin/main &&
     ++		git -C target rev-parse --verify refs/remotes/origin/main >actual &&
     ++		git -C source rev-parse --verify refs/heads/main >expect &&
     ++		test_cmp expect actual &&
     ++		git -C target fsck
     ++	'
     ++done
     ++
     ++test_expect_success 'repacking local links tolerates missing trees of promisor commits' '
     ++	test_when_finished "rm -rf source target" &&
     ++
     ++	git init source &&
     ++	test_commit_bulk -C source 4 &&
     ++	git -C source config uploadpack.allowFilter true &&
     ++	git -C source config uploadpack.allowAnySHA1InWant true &&
     ++	COMMIT=$(git -C source rev-parse main~1) &&
     ++
     ++	# Fetch a single commit as a non-promisor object, then unshallow it
     ++	# with a filter that omits trees. The commits below the former
     ++	# shallow boundary are now promisor objects whose trees are missing.
     ++	git init target &&
     ++	git -C target remote add origin "file://$(pwd)/source" &&
     ++	git -C target fetch --no-tags --depth=1 origin "+$COMMIT:refs/remotes/origin/main" &&
     ++	git -C target fetch --no-tags --filter=tree:0 --unshallow origin \
     ++		"+$COMMIT:refs/remotes/origin/main" &&
     ++	test_path_is_missing target/.git/shallow &&
     ++
     ++	# Fetching a descendant of the local non-promisor commit causes
     ++	# index-pack to repack that commit into a promisor pack. The revision
     ++	# walk must not die when it reaches the missing trees of promisor commits.
     ++	git -C target fetch --no-tags --filter=tree:0 origin \
     ++		+refs/heads/main:refs/remotes/origin/main &&
     ++	git -C target rev-parse --verify refs/remotes/origin/main &&
     ++	git -C target fsck
      +'
      +
     - test_expect_success 'extensions.partialclone without filter' '
     - 	test_create_repo server &&
     - 	git clone --filter="blob:none" "file://$(pwd)/server" client &&
     + 
     + . "$TEST_DIRECTORY"/lib-httpd.sh
     + start_httpd


 builtin/pack-objects.c   |  7 +++--
 t/t5616-partial-clone.sh | 56 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 65c2ad9a86..0b40b23b33 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -5091,8 +5091,11 @@ static int is_not_in_promisor_pack_obj(struct object *obj, void *data UNUSED)
 		.source_infop = &source_info,
 	};
 
-	if (odb_read_object_info_extended(the_repository->objects, &obj->oid, &info, 0))
-		BUG("should_include_obj should only be called on existing objects");
+	if (odb_read_object_info_extended(the_repository->objects, &obj->oid, &info,
+					  OBJECT_INFO_SKIP_FETCH_OBJECT)) {
+		/* Missing; assume it is a promisor object. */
+		return 0;
+	}
 	return source_info.source->type != ODB_SOURCE_PACKED || !source_info.u.packed.pack->pack_promisor;
 }
 
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 7cc6f58a31..bee6261411 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -747,6 +747,62 @@ test_expect_success 'after fetching descendants of non-promisor commits, gc work
 	git -C partial gc --prune=now
 '
 
+for opt in --unshallow --deepen=1
+do
+	test_expect_success "filtered fetch $opt of a moved ref repacks local links" '
+		test_when_finished "rm -rf source target" &&
+
+		git init source &&
+		test_commit_bulk -C source 4 &&
+		git -C source config uploadpack.allowFilter true &&
+		git -C source config uploadpack.allowAnySHA1InWant true &&
+		COMMIT=$(git -C source rev-parse main~1) &&
+
+		git init target &&
+		git -C target remote add origin "file://$(pwd)/source" &&
+		git -C target fetch --no-tags --depth=1 origin "+$COMMIT:refs/remotes/origin/main" &&
+
+		# The fetched pack has the new tip whose parent is the local shallow
+		# tip, so index-pack repacks it into a promisor pack. That process
+		# inherits the shallow file and walks into promisor commits whose
+		# trees do not exist.
+		git -C target fetch --no-tags --filter=tree:0 "$opt" origin \
+			+refs/heads/main:refs/remotes/origin/main &&
+		git -C target rev-parse --verify refs/remotes/origin/main >actual &&
+		git -C source rev-parse --verify refs/heads/main >expect &&
+		test_cmp expect actual &&
+		git -C target fsck
+	'
+done
+
+test_expect_success 'repacking local links tolerates missing trees of promisor commits' '
+	test_when_finished "rm -rf source target" &&
+
+	git init source &&
+	test_commit_bulk -C source 4 &&
+	git -C source config uploadpack.allowFilter true &&
+	git -C source config uploadpack.allowAnySHA1InWant true &&
+	COMMIT=$(git -C source rev-parse main~1) &&
+
+	# Fetch a single commit as a non-promisor object, then unshallow it
+	# with a filter that omits trees. The commits below the former
+	# shallow boundary are now promisor objects whose trees are missing.
+	git init target &&
+	git -C target remote add origin "file://$(pwd)/source" &&
+	git -C target fetch --no-tags --depth=1 origin "+$COMMIT:refs/remotes/origin/main" &&
+	git -C target fetch --no-tags --filter=tree:0 --unshallow origin \
+		"+$COMMIT:refs/remotes/origin/main" &&
+	test_path_is_missing target/.git/shallow &&
+
+	# Fetching a descendant of the local non-promisor commit causes
+	# index-pack to repack that commit into a promisor pack. The revision
+	# walk must not die when it reaches the missing trees of promisor commits.
+	git -C target fetch --no-tags --filter=tree:0 origin \
+		+refs/heads/main:refs/remotes/origin/main &&
+	git -C target rev-parse --verify refs/remotes/origin/main &&
+	git -C target fsck
+'
+
 
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd

base-commit: 1630431f326e15fcde608827b5ff38422528eb59
-- 
gitgitgadget
