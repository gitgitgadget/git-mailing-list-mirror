Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1971A37CD42
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 21:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792012961; cv=none; b=dkuIYfT2Vg5wlpv7TiqhmwtgyXkIdH+8tOK6DWA8bHL+VF58/rx0Mvh1NGRpbo+XMQNte5fkVTcGenQHn1cnAcG+kx8/kixHcFSTpX2PKCMUpU1SpcnP9MNrbgfn9P2vRydlUkVP94whHzBrJC7nzb2kOdUavYLypNVSnLQFcRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792012961; c=relaxed/simple;
	bh=r6ucId/1kAfGfyBjIsGoz4hX/jFGimiE8mPAdn6usPA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=cezl26QUBhgeFYGfiBKtFlv5BQlcL1TYuZ9e2lRgdwrNwVlu+qIYP79wi+OQCghby1/zYuhAk6xm0SUe0YHCQ+CwWeWpW9tzrivuVaOuQo74zxtjAEQG/kxwAqkcSh5qj2/U23++GvzLzcxragxVdxpGXPIhf8E2qdY9uGl0nIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CnwkfI+U; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CnwkfI+U"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-49e08af5fd4so403174fac.1
        for <git@vger.kernel.org>; Wed, 14 Oct 2026 14:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792012959; x=1792617759; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=r/GHaov8mpBd+ssmehry7fT6d8OjYJvEl5qPHYnRbpo=;
        b=CnwkfI+UHkYZEyjiZPzLSLr/N1kI/SWf2q90FxgxIZHBXK0OpmQ7+CdZyziUm/GW0n
         zINTas+tnuNxQP9v/xlp1rORX7XP0CTK9kvgUkxkMD0bzbKbA8mSViTHaU1wCR5WB2Ja
         BErK+NJM5mmgqqg4/aFK8SQNMmuaY/K2AP8qm1PxL1kTpjPytuTca7xOa/+AUjn80xnq
         VkKX7XvY5/DExBSqnnok313mn6WgxvErCzQJ5PX/oaPE5A1xMo/nQ11q+LHYQbW1jmSa
         Sh+G6dcf0Won60kiq7yhtwskYATqgNbPgLOvP/E35VkQUl/fmUbzvQygnOC88SMWlHhn
         1ukQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792012959; x=1792617759;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r/GHaov8mpBd+ssmehry7fT6d8OjYJvEl5qPHYnRbpo=;
        b=zYXvrP15HJQAN5v7RcYEnXPZCMT3qglNybg0q/zILeoxC/zlENwMuZGfag6HJpW3sV
         /NA8c1s+HZrR4GmNuK+IEIyYgdPyjqKvYxc9fIevqueUeNcdJ+lA/aKv0AAaIF+GR714
         jCrMSt5suEMhwx5cg2JRIzzpvwfbiDHaInEor948P6leVHT4cf+2gtS3qP9EYOpPbcOj
         mIhEKcdxkMebFUj9JMuXerudwa7JVNtQadfRyzUukgGY3lbwZx8Fj33z4sKausaAcUKw
         FyEN00toVgINV+Clpy69bD1Vnn1OPNzpIXczivWcciB0BDo48Rz4thUrozx5nyfM1Krn
         Fxmw==
X-Gm-Message-State: AFq9FYL2qM0aWyZEvHR+O276icX+xT8bn9ewqyoEZfKQrTe0yMYwxiK7
	D56is3rgO+Hg7FRjDEDGslV8QLCPeW7jlWsUf7PwpghyXAHJghI8kB0s7mSbB/WyCRE=
X-Gm-Gg: AYBFou3PcD70V86Q8CWMj+biNM428e8ge1DRQRFdGOYkVcprTmC2LLXiA4TK7Db2rex
	6/hO6ZU60or/Tf4HhnbjZ6EfvC95rCson63YA4oobiPLvfBFAmKezG36uf/snqvWWnWUvwWtq56
	W1E8BjENW6wSHwgs6QL+TBSS9o0i/7sgoWJe+PTJIDP9+p5znKyktoRQdtNYlSq2t3SWRtIty12
	ORVFQ34U/u0p6pnYzO7Pwk2LUYo0flYTySJ7HScn0gqNJR6/qKmqjclSxSyYoUUbgTmB5mLU/6K
	9eaIKccGFAavhaRnRI3gR7dVXqtPlNoL3SWFLaGyAkEfDwgII7UIJ/fUpkPwBo9jLnQRBO78BgG
	BY5ehjio1BbkkMSwdki1s9O9s2ySFDIWjpVeC3YQltyiB9jbhPK42SeG1NYFAcWkdXBiofNpTDz
	/6+7b5hLKUh8t+lUbNBUXNpSVz4ZIEUhilD6Cz2PGA9S2xo4sMgtTKXqDhqIFwtxWk5Tn3RIsXI
	g==
X-Received: by 2002:a05:6870:d14b:b0:48f:e107:9092 with SMTP id 586e51a60fabf-4a2a8b4c2f7mr14043242fac.59.1792012958853;
        Wed, 14 Oct 2026 14:22:38 -0700 (PDT)
Received: from [127.0.0.1] ([172.171.7.194])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a6dfb41355sm2889219fac.5.2026.10.14.14.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 14:22:37 -0700 (PDT)
Message-Id: <pull.2252.v4.git.1792012956734.gitgitgadget@gmail.com>
In-Reply-To: <pull.2252.git.1791653078449.gitgitgadget@gmail.com>
References: <pull.2252.git.1791653078449.gitgitgadget@gmail.com>
From: "Marc Becker via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 14 Oct 2026 21:22:36 +0000
Subject: [PATCH v4] fast-import: allow 'from' to reference new commits and
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
    
    Changes since v3:
    
     * align here-doc indention in test with expected style

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2252%2Fbecm%2Ffix-fast-import-commit-from-existing-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2252/becm/fix-fast-import-commit-from-existing-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/2252

Range-diff vs v3:

 1:  25113432c6 ! 1:  0daef81925 fast-import: allow 'from' to reference new commits and tags by oid
     @@ t/t9300-fast-import.sh: test_expect_success 'Y: rewrite submodules' '
       
      +test_expect_success 'Y: reference pending tag or commit' '
      +	test_oid_cache <<-EOF &&
     -+		pending_commit sha1:85b46dd918355ff17b4109ec738723d42f235a04
     -+		pending_commit sha256:17e650f097a4db6fe069c96935360d3ccc9b35c4018728c5f311a4217c2ced3d
     -+		pending_tag sha1:ec6c4db71feb5f66615214dad2324ce030e777a7
     -+		pending_tag sha256:85edc5eac315bc680677b2fc71622bd77476f057eb8dc8ed6a497803a24f1f46
     -+		EOF
     ++	pending_commit sha1:85b46dd918355ff17b4109ec738723d42f235a04
     ++	pending_commit sha256:17e650f097a4db6fe069c96935360d3ccc9b35c4018728c5f311a4217c2ced3d
     ++	pending_tag sha1:ec6c4db71feb5f66615214dad2324ce030e777a7
     ++	pending_tag sha256:85edc5eac315bc680677b2fc71622bd77476f057eb8dc8ed6a497803a24f1f46
     ++	EOF
      +
      +	git init reference-pending &&
      +	(
      +		cd reference-pending &&
      +		git fast-import <<-EOF
     -+			commit refs/heads/main
     -+			committer A U Thor <author@example.com> 1712563200 +0000
     -+			data 14
     -+			commit message
     -+			M 644 inline test file
     -+			data 14
     -+			dummy content
     ++		commit refs/heads/main
     ++		committer A U Thor <author@example.com> 1712563200 +0000
     ++		data 14
     ++		commit message
     ++		M 644 inline test file
     ++		data 14
     ++		dummy content
      +
     -+			tag newtag
     -+			from $(test_oid pending_commit)
     -+			tagger A U Thor <author@example.com> 1712563300 +0000
     -+			data 11
     -+			tag message
     -+			# no emty line after tag data!
     -+			reset refs/heads/other
     -+			from $(test_oid pending_tag)
     ++		tag newtag
     ++		from $(test_oid pending_commit)
     ++		tagger A U Thor <author@example.com> 1712563300 +0000
     ++		data 11
     ++		tag message
     ++		# no emty line after tag data!
     ++		reset refs/heads/other
     ++		from $(test_oid pending_tag)
      +
     -+			commit refs/heads/further
     -+			committer A U Thor <author@example.com> 1712563400 +0000
     -+			data 21
     -+			what about 2nd commit
     -+			from $(test_oid pending_commit)
     -+			M 644 inline other test file
     -+			data 19
     -+			more dummy content
     ++		commit refs/heads/further
     ++		committer A U Thor <author@example.com> 1712563400 +0000
     ++		data 21
     ++		what about 2nd commit
     ++		from $(test_oid pending_commit)
     ++		M 644 inline other test file
     ++		data 19
     ++		more dummy content
      +
     -+			done
     -+			EOF
     ++		done
     ++		EOF
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
index d9de2ef0d8..73c6e3d448 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -3938,4 +3938,47 @@ test_expect_success 'Y: rewrite submodules' '
 	)
 '
 
+test_expect_success 'Y: reference pending tag or commit' '
+	test_oid_cache <<-EOF &&
+	pending_commit sha1:85b46dd918355ff17b4109ec738723d42f235a04
+	pending_commit sha256:17e650f097a4db6fe069c96935360d3ccc9b35c4018728c5f311a4217c2ced3d
+	pending_tag sha1:ec6c4db71feb5f66615214dad2324ce030e777a7
+	pending_tag sha256:85edc5eac315bc680677b2fc71622bd77476f057eb8dc8ed6a497803a24f1f46
+	EOF
+
+	git init reference-pending &&
+	(
+		cd reference-pending &&
+		git fast-import <<-EOF
+		commit refs/heads/main
+		committer A U Thor <author@example.com> 1712563200 +0000
+		data 14
+		commit message
+		M 644 inline test file
+		data 14
+		dummy content
+
+		tag newtag
+		from $(test_oid pending_commit)
+		tagger A U Thor <author@example.com> 1712563300 +0000
+		data 11
+		tag message
+		# no emty line after tag data!
+		reset refs/heads/other
+		from $(test_oid pending_tag)
+
+		commit refs/heads/further
+		committer A U Thor <author@example.com> 1712563400 +0000
+		data 21
+		what about 2nd commit
+		from $(test_oid pending_commit)
+		M 644 inline other test file
+		data 19
+		more dummy content
+
+		done
+		EOF
+	)
+'
+
 test_done

base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
-- 
gitgitgadget
