Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795648955;
	b=K2Uv8bMgC++rw5HlSvc+DWsCTfcTmJCtzlaJciEAm5TX08niOHLfJs05okmOK61Su8N6
	 4+em2qybHqss5/76xi9tm06kiA39THg4s18z5Gcy6XXRjXFMaXWj2xYCXBtJT7EPEPDA7
	 qxIYhYD5gdkQfI7v0A2VU35kbiBbChqUvWXOLScntApVGSm9Oh5eaENY1eqfFYA00YqIm
	 uXAs0Ob2zRAl7dX00xkGDmULJ/hMv/Nod2J93JG+hP7epl65/B4Ih8xqIeUgplNf4elwP
	 5JVlaMmNu4LCJO6xwAoNJW5F5Us7Z/gA6STWSf5nVhrjVi1F2m6GxMgKUbMbAwR67Lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795648955;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=2u3jrDOycnwCJSCu6AjzHY7QW4o9MbEblv+hlyeZbYY=;
	b=VILECccTyaAghxLPWWbcV567yjosYIMqu4yGJGQvaeQgneBpJCush0kcqFWheF5gwQdo
	 BPfA1aalqDvPdIPZLnLDJFfWSfD8UACd4xJknCDUQksva2CQoS0fI3dKvbb70YpJYdpWJ
	 9ZqeasFrW2OqAGItNIVoP0X5mEjOoMBAxblsbDCva7ppmiGA76ZpXe5nfejAyJIRQOvC+
	 zxhIRAvkYghKpHjcduLTwQcOYwGjgfFNjGu/YO4/4yj0wfcU3Vx7Ri7vNq7atXCdyRcf6
	 rFWsmMchZp+JVw/FxCk4iVT8VOLjuKQ9QiJ7j82P4aZ8KdTqdnUiu5D/+nmtfPZuPtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dIAQVI33;
	arc=none smtp.remote-ip=209.85.161.45
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B400606A31E
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 23:22:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B400606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dIAQVI33
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-702dedeb70dso3754193eaf.1
        for <git@vger.kernel.org>; Wed, 25 Nov 2026 15:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795648953; x=1796253753; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2u3jrDOycnwCJSCu6AjzHY7QW4o9MbEblv+hlyeZbYY=;
        b=dIAQVI333B979VIrKwmVztVKViZwPCg+4uaKPKAqnBP1Xh4nQuXhsA5AMYbacPme3C
         AVspUZ493iSgW0guTO6l5seLyp+abl3i6FWePQnh6YQVU8hf0zjfjaW3KSI3kKB2ISic
         BFBm57SI3p9ZidCtPLMYOSOZsV3Es3NufFlMR+jW5EUs+2mLbdKzUcxQA57sVjZbcH7A
         Sorq/LW8Fvd5rWGXPjNhmvBhZn3OJPuX1ol7atk/wWq8xxS8yt3PUYfClDbVZraXjkDG
         cEw4ZZWudJcL846q10ixWnvyQwM4ZOPveIwxbbD+8VVu0FWbCLB7Q2hKV/gtaZsodAkp
         GuBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795648953; x=1796253753;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2u3jrDOycnwCJSCu6AjzHY7QW4o9MbEblv+hlyeZbYY=;
        b=YqAA60cF3STCGYgxZc18SmOZ+fmpRKH/aR3kZRI5i4bwRVtPCNFAjcRkr0iejIasGS
         GA4EnQIrzXjwHL3/uwgibngVMiVplJ6pC8mPmhDxiyqQgVd1sua7QeDd9OcD5B4ib60M
         HyfNnZsy7MLYn1vunmAjV81UFFQbpHoWwQnNbqLi8IdMeiBqFy7GxlkCoMzlp1K7oeVL
         Q5MUT9rdijO6aJau3Xc/CUNtxp30Gc4BOyj7q9Pdj8Z8cdBhJ9LagemXvf8fyGL/EF8N
         3gkyVmMB/7XoIadF5TMuK2dR/bt6z0EzmiThx3X4X0T0SfMzcuPltdzeNzEiWm8HZnVx
         ZoRQ==
X-Gm-Message-State: APuU4Z/zToCj+6QddYGHxNV4uAuND19AqKW47DHd8hH9SsksS6pc2Tzp
	kcIPYMKzu6/1Ql9SEc/VY1QxF2p/x7LaJ4JOdQ59oxFy7+ll0GvpANIF+WDmr8ve
X-Gm-Gg: AZFdTZfBBy+Utern71+BEJYYHqtB7zlLYQh7/xh+HhQ2y8/56P3f61gh4IOtbSZAsMb
	XT3p3CZF0jRvsRFIiu+0UMYQ17QDBX7+yHCJeLCEvYTR6ng+sMIrhuej2IEHWzZvoVdPdL3MEcM
	lOba8DSDhs3LC2YNcjSUmEmmBd1n4WGSz0k/kyirDnv2hcLkBir00bQXkwUG6CPkX+2gmdI5ZRb
	OLIbjiCFu1ijIykd7AZym9TIJJtNQFTYaEbakZbZ+yOVQzH0unQMNIYF1dLxV5dJOc7OtPs9Q7T
	onVPFZ5oDZsv7UCShnKEPb9siYPa5XQc2HYKpuHgkdRHqWTcYJ9dlwUlP2IRsRBlcq9cxsu9hn6
	+7lcqo+yaocqbmMyZzG4eZXbxLvBAULii8mBzjz5X0tmo/pUYpJ3XzOvFi2FaSigpofwrgUNC8g
	ALMRcJJWrNkHV35PCMHVkvDfEoi8tywqr7Mk3KSVn7llpW3kEXNnsV2YBIQjX218XIzxdwzrdGI
	e8EJ3c/KPUbQT2jXbgrPdXRWI3RDKk+uR1Ggo2Y1VEfaYIumqrJblIHSgVGRG/9u1keY7pa5NDX
	7E7rKWbVIpHUkgmimqov+14/WCz4G/E=
X-Received: by 2002:a05:6820:55d0:10b0:71a:fb0f:810b with SMTP id 006d021491bc7-71b394472d7mr10821376eaf.29.1795648953414;
        Wed, 25 Nov 2026 15:22:33 -0800 (PST)
Received: from [127.0.0.1] ([20.80.111.51])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b8590ba0fsm1078623eaf.2.2026.11.25.15.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 15:22:32 -0800 (PST)
Message-Id: <pull.2333.v4.git.1795648951606.gitgitgadget@gmail.com>
In-Reply-To: <pull.2333.git.1795635624820.gitgitgadget@gmail.com>
References: <pull.2333.git.1795635624820.gitgitgadget@gmail.com>
From: "Alessio Attilio via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 25 Nov 2026 23:22:31 +0000
Subject: [PATCH v4] pack-objects: handle missing promisor objects
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

During a filtered fetch in a partial clone, index-pack --promisor
re-packs local links from the incoming pack into promisor packs. It
invokes pack-objects with --exclude-promisor-objects-best-effort to
skip links already stored in promisor packs. After a filtered
--unshallow or --deepen, this walk can encounter a promisor commit
whose tree is missing. The object-info lookup then hits a BUG and the
fetch fails.

Do not lazy-fetch while checking these links: this is a best-effort
repack, not a request to retrieve missing objects. If the object is
missing, pack-objects cannot include it, so treat it like an object
already in a promisor pack and continue. This callback is used only by
the best-effort repack started for an incoming promisor pack, whose
output is itself marked promisor. If the missing object was not
actually promised, this still cannot discard available data; the
object was already absent and any later access would fail unless the
promisor remote can provide it.

Test filtered --unshallow and --deepen fetches, as well as a subsequent
fetch that repacks links to promisor commits with missing trees.

Signed-off-by: Alessio Attilio <attilio.alessio@protonmail.com>
---
    pack-objects: handle missing promisor objects
    
    Changes since v1:
    
     * Pass OBJECT_INFO_SKIP_FETCH_OBJECT explicitly to avoid lazy fetching
       during the lookup.
     * Cover filtered --unshallow and --deepen fetches, and a later fetch
       after unshallowing a filtered clone.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2333%2Fkairosci%2Fattilio%2Fpack-objects-missing-promisor-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2333/kairosci/attilio/pack-objects-missing-promisor-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/2333

Range-diff vs v3:

 1:  cbe2fc475c ! 1:  b2112b07dd pack-objects: handle missing promisor objects
     @@ Metadata
       ## Commit message ##
          pack-objects: handle missing promisor objects
      
     -    Objects missing from a partial clone are expected to be absent.
     -    When checking whether an object is in a promisor pack, do not BUG()
     -    if its object info cannot be read. Such an object cannot be included
     -    in the pack, so skip it.
     +    During a filtered fetch in a partial clone, index-pack --promisor
     +    re-packs local links from the incoming pack into promisor packs. It
     +    invokes pack-objects with --exclude-promisor-objects-best-effort to
     +    skip links already stored in promisor packs. After a filtered
     +    --unshallow or --deepen, this walk can encounter a promisor commit
     +    whose tree is missing. The object-info lookup then hits a BUG and the
     +    fetch fails.
      
     -    Pass OBJECT_INFO_SKIP_FETCH_OBJECT explicitly so the lookup does not
     -    trigger a lazy fetch.
     +    Do not lazy-fetch while checking these links: this is a best-effort
     +    repack, not a request to retrieve missing objects. If the object is
     +    missing, pack-objects cannot include it, so treat it like an object
     +    already in a promisor pack and continue. This callback is used only by
     +    the best-effort repack started for an incoming promisor pack, whose
     +    output is itself marked promisor. If the missing object was not
     +    actually promised, this still cannot discard available data; the
     +    object was already absent and any later access would fail unless the
     +    promisor remote can provide it.
      
          Test filtered --unshallow and --deepen fetches, as well as a subsequent
          fetch that repacks links to promisor commits with missing trees.


 builtin/pack-objects.c   |  7 +++--
 t/t5616-partial-clone.sh | 55 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 87c3102e62..371f16c59b 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -5135,8 +5135,11 @@ static int is_not_in_promisor_pack_obj(struct object *obj, void *data UNUSED)
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
index 9636652362..44ce9a1ee8 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -790,6 +790,61 @@ test_expect_success 'merge does not lazy-fetch locally written objects' '
 	done &&
 	test_cmp server/only-in-C client/only-in-C
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
 
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd

base-commit: acba8bf9753134d9bde89f94369f775838a8c5fe
-- 
gitgitgadget
