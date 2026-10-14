Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7F84EDCC3
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 16:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791995257; cv=none; b=r+lcHvsK1sAz9YiOF5ZXf1i33y9q9tvozMWjX2PnjgE07wNhr2PnoIpzOYwBPEB4pFghMQwFlLJBJwK39QokfDdvFt4M5jZib2OwP5bAfTYe+8/WurdWwuFolurDQ558QYrmJielVidHNCfVUgg0K/nU4yQdCjF3gJms3jJDjCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791995257; c=relaxed/simple;
	bh=vR1QolFluH0rFsSTop+ZkXt57ijoaEwkQsPq9nCkNFE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=m5C76nVQ25ZfJ5POVmjIiv6YGo5P8lSJE/HWbp1fJ/TPwricqWCfB+uMtBEfUS6y+EsvPLRbdWXzodDkK8wjZwrGO0pgs7vTstzU9g2cv1gjK2wXxAtRj0WTaHxWKa9rutuAvq+hfXLhG9LIrvozURFOWa0RJSjYrNhUNDfW0cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=olWb+43E; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="olWb+43E"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-81ae6aefdceso987818a34.0
        for <git@vger.kernel.org>; Wed, 14 Oct 2026 09:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791995254; x=1792600054; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XguwTz1KJXW9/SHJjLc2vKdiJcWnIXmUZhoVceCFyPo=;
        b=olWb+43EG3XyMLpvDRKmeP4FTocwo2TM8Mfb4Eme4cZcMD/0T89kuzoNtxlDLEPmY3
         sC0ysM8K4nQ6n3UAGebNREP7+SqSxKh36dHJi5nwXVlhJkSGm31FsOekyRj2fHgDUiYG
         ACZuI30hN9Wqg0yj7MDdkmHiCG+LKDPYSNQunjAq3eeP6z/OLy1DTo1EE8IK4VWJskno
         TvEz2AE7OUNr7DpRmv4nB0KRNErwlYqdbTvUIr1GYdnhg36vyQDZ/WrxoBDh+r/zxZtr
         IeJtvTRNcVGjqx1pNIPOi7qRrl50aowx5NOUq/mt7J4zygG10JsZ8c5sMRLJCRwa2+5H
         DtGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791995254; x=1792600054;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XguwTz1KJXW9/SHJjLc2vKdiJcWnIXmUZhoVceCFyPo=;
        b=lasT4V4bMDoyr1ifydwr/PSH2IWxZL1qkFp12ox6cC2sqpaiMxGYm1iTn7v9Xn7Dw2
         ZKd68Y1icml6cbyH0xpPfVwCTSuC9TU/PD7Fv9pdZt4hpspzg/K8MXKTDM6gK5+RWEKx
         8WclEAlsC9gt/Jzb/FKmvFaMhGBBtpQwyLyevl9ZGwl7k9bjI/Bz7R4nCTQ0cb2FpjId
         sNigiJg8UlGCbD+aH343IC6dtc04XdHm2gNJFdis1Tp+URkFh1iQf4THYwU7AncYJRHX
         Q2ZZfh7lzCNqPaW7AmVPQW19a5XPUrxfIH+TzZ7IFL9AIfoRhHOouHaxMVz0YfTijNOD
         55Aw==
X-Gm-Message-State: AFq9FYJT9wDg1dXjNtTCzvECGIx/j2gN4rsEZ0zGeSN2qvi7cvFOt6iw
	i3NU5jCOAQRwpJ8oJ2Z41kvnvuYOtCB6i/GLEvG6kHMXDH1trFR3H3xmGbCKxw==
X-Gm-Gg: AYBFou2GRQwFOQz5BZx2z/ZBV6Ntc/InsQ7qFonj/8kXtqz9RobK4X1vTNjDMjoBsTu
	jbv5+bKGMqESrKF5XNx6GzmmUYw9VHh2INHclI7mtQCJ/IL8cV4iipdLifUVnzbHcoSDuuAPbrs
	GRN23AL8aZBfB9m6NcwcA9swS2yibl6PrKncBiiJ8Kf8JpfxMpumX+7WOalMPkgSjb/9pLtcInD
	IjxCYxByPSy4Nzaxbp31nD4eVUYLzxNdH2bgQJKzpO1esnYIOsLo1eNC+jTQXjO6jK1TAgjms9H
	6riarrD2qAn1VZwAnYEhry3Djbkbe4gpKLrDRcCqB0XiBYR2Litfha4OILQKuyy0qaivmIR2YHP
	heQTLsP99XmibSyh+QFdzeHis3w1xB2iy/XvQrA4BPK10tSzpohfAYjHGQ8+c6I07LcwipH/Yw/
	NgppKYdsL325nRX4I7JAhD0Ib5u0CygPJkHafG8zPScoIU5+3bx4ypa05WOM/MpJSPXsIxXrlCw
	8iM
X-Received: by 2002:a05:6830:67fb:b0:822:a76e:95c9 with SMTP id 46e09a7af769-83095b27ebamr15641076a34.14.1791995254198;
        Wed, 14 Oct 2026 09:27:34 -0700 (PDT)
Received: from [127.0.0.1] ([130.131.239.211])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-83039a47048sm15150636a34.19.2026.10.14.09.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 09:27:33 -0700 (PDT)
Message-Id: <pull.2252.v3.git.1791995252623.gitgitgadget@gmail.com>
In-Reply-To: <pull.2252.git.1791653078449.gitgitgadget@gmail.com>
References: <pull.2252.git.1791653078449.gitgitgadget@gmail.com>
From: "Marc Becker via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 14 Oct 2026 16:27:32 +0000
Subject: [PATCH v3] fast-import: allow 'from' to reference new commits and
 tags by oid
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
Cc: Aniket Gupta <aniketgupta3001@gmail.com>,
    Marc Becker <becm@gmx.de>,
    Marc Becker <becm@gmx.de>

From: Marc Becker <becm@gmx.de>

During a 'git fast-import' session, newly created objects are written
to an in-progress packfile and recorded in fast-import's internal
object table.  Until a 'checkpoint' command or the end of the session
finalizes and indexes that packfile, these objects are not visible to
the repository's object database via odb_read_object_peeled().

Commands such as 'ls' (via parse_treeish_dataref() and dereference())
and 'cat-blob' already account for this when given a hex object name:
they look up the object in fast-import's internal object table with
find_object() first and read it from the in-progress packfile with
gfi_unpack_entry() when its '.pack_id' is not MAX_PACK_ID.

By contrast, when 'from <committish>' (in a 'commit' or 'reset'
command) is given a hex object name instead of a mark or branch name,
parse_objectish() parses the hex string into 'b->oid' and calls
parse_from_existing(), which unconditionally looks up the object via
odb_read_object_peeled().  If the object is a commit or tag created in
the current pack cycle, odb_read_object_peeled() returns NULL and
fast-import dies with "fatal: not a valid commit: <oid>".

Teach parse_from_existing() to look up 'b->oid' with find_object()
first, peel any tag objects in the object table using dereference(),
and unpack the target commit with gfi_unpack_entry() if it resides in
the in-progress packfile, before falling back to
odb_read_object_peeled() for objects in the repository's object
database.

Signed-off-by: Marc Becker <becm@gmx.de>
---
    fast-import: fix lookup for new commits
    
    Changes since v2:
    
     * use LLM-generated commit message (description is on point) by Junio
     * provide hash-specific OIDs in test code via test_oid

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2252%2Fbecm%2Ffix-fast-import-commit-from-existing-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2252/becm/fix-fast-import-commit-from-existing-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/2252

Range-diff vs v2:

 1:  d834e2fc47 ! 1:  25113432c6 fast-import: fix lookup for new commits and tags
     @@ Metadata
      Author: Marc Becker <becm@gmx.de>
      
       ## Commit message ##
     -    fast-import: fix lookup for new commits and tags
     +    fast-import: allow 'from' to reference new commits and tags by oid
      
     -    Queries for commits created during the same 'git fast-import' session
     -    result in a crash:
     -        < reset refs/heads/newbranch
     -        < from <new-commit-oid>
     -        > fatal: not a valid commit: <new-commit-oid>
     +    During a 'git fast-import' session, newly created objects are written
     +    to an in-progress packfile and recorded in fast-import's internal
     +    object table.  Until a 'checkpoint' command or the end of the session
     +    finalizes and indexes that packfile, these objects are not visible to
     +    the repository's object database via odb_read_object_peeled().
      
     -    Getting file content for commit has no issue (working implementation):
     -        < ls <new-commit-oid> file-in-new-commit.txt
     -        > {file content}
     +    Commands such as 'ls' (via parse_treeish_dataref() and dereference())
     +    and 'cat-blob' already account for this when given a hex object name:
     +    they look up the object in fast-import's internal object table with
     +    find_object() first and read it from the in-progress packfile with
     +    gfi_unpack_entry() when its '.pack_id' is not MAX_PACK_ID.
      
     -    During import, new objects may not (yet) be reachable via the ODB layer.
     -    Try to resolve requested tag/commit via object cache first
     -    to avoid crash.
     -    Add test to 't/t9300.sh' with references to a pending tag and commit.
     +    By contrast, when 'from <committish>' (in a 'commit' or 'reset'
     +    command) is given a hex object name instead of a mark or branch name,
     +    parse_objectish() parses the hex string into 'b->oid' and calls
     +    parse_from_existing(), which unconditionally looks up the object via
     +    odb_read_object_peeled().  If the object is a commit or tag created in
     +    the current pack cycle, odb_read_object_peeled() returns NULL and
     +    fast-import dies with "fatal: not a valid commit: <oid>".
     +
     +    Teach parse_from_existing() to look up 'b->oid' with find_object()
     +    first, peel any tag objects in the object table using dereference(),
     +    and unpack the target commit with gfi_unpack_entry() if it resides in
     +    the in-progress packfile, before falling back to
     +    odb_read_object_peeled() for objects in the repository's object
     +    database.
      
          Signed-off-by: Marc Becker <becm@gmx.de>
      
     @@ t/t9300-fast-import.sh: test_expect_success 'Y: rewrite submodules' '
       	)
       '
       
     -+cat >Y-reference-pending-sha256 <<\Y_INPUT_END
     -+commit refs/heads/main
     -+committer A U Thor <author@example.com> 1712563200 +0000
     -+data 14
     -+commit message
     -+M 644 inline test file
     -+data 14
     -+dummy content
     -+
     -+tag newtag
     -+from 17e650f097a4db6fe069c96935360d3ccc9b35c4018728c5f311a4217c2ced3d
     -+tagger A U Thor <author@example.com> 1712563300 +0000
     -+data 11
     -+tag message
     -+# no emty line after tag data!
     -+reset refs/heads/other
     -+from 85edc5eac315bc680677b2fc71622bd77476f057eb8dc8ed6a497803a24f1f46
     -+
     -+commit refs/heads/further
     -+committer A U Thor <author@example.com> 1712563400 +0000
     -+data 21
     -+what about 2nd commit
     -+from 17e650f097a4db6fe069c96935360d3ccc9b35c4018728c5f311a4217c2ced3d
     -+M 644 inline other test file
     -+data 19
     -+more dummy content
     -+
     -+done
     -+Y_INPUT_END
     -+
     -+cat >Y-reference-pending-sha1 <<\Y_INPUT_END
     -+commit refs/heads/main
     -+committer A U Thor <author@example.com> 1712563200 +0000
     -+data 14
     -+commit message
     -+M 644 inline test file
     -+data 14
     -+dummy content
     -+
     -+tag newtag
     -+from 85b46dd918355ff17b4109ec738723d42f235a04
     -+tagger A U Thor <author@example.com> 1712563300 +0000
     -+data 11
     -+tag message
     -+# no emty line after tag data!
     -+reset refs/heads/other
     -+from ec6c4db71feb5f66615214dad2324ce030e777a7
     -+
     -+commit refs/heads/further
     -+committer A U Thor <author@example.com> 1712563400 +0000
     -+data 21
     -+what about 2nd commit
     -+from 85b46dd918355ff17b4109ec738723d42f235a04
     -+M 644 inline other test file
     -+data 19
     -+more dummy content
     -+
     -+done
     -+Y_INPUT_END
     -+
      +test_expect_success 'Y: reference pending tag or commit' '
     ++	test_oid_cache <<-EOF &&
     ++		pending_commit sha1:85b46dd918355ff17b4109ec738723d42f235a04
     ++		pending_commit sha256:17e650f097a4db6fe069c96935360d3ccc9b35c4018728c5f311a4217c2ced3d
     ++		pending_tag sha1:ec6c4db71feb5f66615214dad2324ce030e777a7
     ++		pending_tag sha256:85edc5eac315bc680677b2fc71622bd77476f057eb8dc8ed6a497803a24f1f46
     ++		EOF
     ++
      +	git init reference-pending &&
      +	(
      +		cd reference-pending &&
     -+		git fast-import < "../Y-reference-pending-$(git rev-parse --show-object-format)"
     ++		git fast-import <<-EOF
     ++			commit refs/heads/main
     ++			committer A U Thor <author@example.com> 1712563200 +0000
     ++			data 14
     ++			commit message
     ++			M 644 inline test file
     ++			data 14
     ++			dummy content
     ++
     ++			tag newtag
     ++			from $(test_oid pending_commit)
     ++			tagger A U Thor <author@example.com> 1712563300 +0000
     ++			data 11
     ++			tag message
     ++			# no emty line after tag data!
     ++			reset refs/heads/other
     ++			from $(test_oid pending_tag)
     ++
     ++			commit refs/heads/further
     ++			committer A U Thor <author@example.com> 1712563400 +0000
     ++			data 21
     ++			what about 2nd commit
     ++			from $(test_oid pending_commit)
     ++			M 644 inline other test file
     ++			data 19
     ++			more dummy content
     ++
     ++			done
     ++			EOF
      +	)
      +'
      +


 builtin/fast-import.c  | 19 +++++++++++++++----
 t/t9300-fast-import.sh | 43 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+), 4 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index fbd919982c..574a03c484 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -292,6 +292,9 @@ static void fast_import_state_init(struct fast_import_state *state,
 	state->option = option;
 }
 
+static struct object_entry *dereference(struct object_entry *oe,
+					struct object_id *oid);
+
 static void parse_argv(struct fast_import_state *state);
 static void parse_get_mark(struct fast_import_state *state, const char *p);
 static void parse_cat_blob(struct fast_import_state *state, const char *p);
@@ -2658,12 +2661,20 @@ static void parse_from_existing(struct branch *b)
 		oidclr(&b->branch_tree.versions[1].oid, the_repository->hash_algo);
 	} else {
 		unsigned long size;
-		size_t size_st = 0;
 		char *buf;
+		struct object_entry *e = find_object(&b->oid);
 
-		buf = odb_read_object_peeled(the_repository->objects, &b->oid,
-					     OBJ_COMMIT, &size_st, &b->oid);
-		size = cast_size_t_to_ulong(size_st);
+		while (e && e->type == OBJ_TAG)
+			e = dereference(e, &b->oid);
+
+		if (e && e->type == OBJ_COMMIT && e->pack_id != MAX_PACK_ID) {
+			buf = gfi_unpack_entry(e, &size);
+		} else {
+			size_t size_st = 0;
+			buf = odb_read_object_peeled(the_repository->objects, &b->oid,
+						     OBJ_COMMIT, &size_st, &b->oid);
+			size = cast_size_t_to_ulong(size_st);
+		}
 		parse_from_commit(b, buf, size);
 		free(buf);
 	}
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index d9de2ef0d8..9001e2572a 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -3938,4 +3938,47 @@ test_expect_success 'Y: rewrite submodules' '
 	)
 '
 
+test_expect_success 'Y: reference pending tag or commit' '
+	test_oid_cache <<-EOF &&
+		pending_commit sha1:85b46dd918355ff17b4109ec738723d42f235a04
+		pending_commit sha256:17e650f097a4db6fe069c96935360d3ccc9b35c4018728c5f311a4217c2ced3d
+		pending_tag sha1:ec6c4db71feb5f66615214dad2324ce030e777a7
+		pending_tag sha256:85edc5eac315bc680677b2fc71622bd77476f057eb8dc8ed6a497803a24f1f46
+		EOF
+
+	git init reference-pending &&
+	(
+		cd reference-pending &&
+		git fast-import <<-EOF
+			commit refs/heads/main
+			committer A U Thor <author@example.com> 1712563200 +0000
+			data 14
+			commit message
+			M 644 inline test file
+			data 14
+			dummy content
+
+			tag newtag
+			from $(test_oid pending_commit)
+			tagger A U Thor <author@example.com> 1712563300 +0000
+			data 11
+			tag message
+			# no emty line after tag data!
+			reset refs/heads/other
+			from $(test_oid pending_tag)
+
+			commit refs/heads/further
+			committer A U Thor <author@example.com> 1712563400 +0000
+			data 21
+			what about 2nd commit
+			from $(test_oid pending_commit)
+			M 644 inline other test file
+			data 19
+			more dummy content
+
+			done
+			EOF
+	)
+'
+
 test_done

base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
-- 
gitgitgadget
