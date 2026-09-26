Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722821D416C
	for <git@vger.kernel.org>; Sat, 26 Sep 2026 12:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790425052; cv=none; b=UpNfkmjK4jy2RppTg4w+Qp2zax6RnolchRdbKIyJtcAupctiU28JpEK65C3XxSGqy5CL/KN5dU8bfFQY78bi+BMs8ZerGifKaTZ86+Mgw6IslQHhOgnxh/sRRhFbsEWTy3qHUvRb1pKNmZSBgL1DG7i+6UXxig/AwkCA088LPBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790425052; c=relaxed/simple;
	bh=l0NZMfeE4lzd/X5xfK9ciYcG4VXyZpxCKCuph/2pTLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CHACn1gXQn8nZ8KwuaDK9gHniP+OA2C2Ne+PpoN3n8Z9olP9CSyqHRpfTxFB9P2rbZZu9d6vbDXiThTh3JaZIMen2pOLhUdv7FVliAB85egDXD0F2WSmZGUdf6sUpdUrjlvm/122vg0bZuzfEp8TBW9PXJQfvd2oG7ucVypJjsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pn/ahK7a; arc=none smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pn/ahK7a"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-66e50968489so1571432d50.0
        for <git@vger.kernel.org>; Sat, 26 Sep 2026 05:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790425049; x=1791029849; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f+NrjLsCLWWd027pKexVeBUqPCd1UlBkySnBmBeBwqY=;
        b=Pn/ahK7aJIHSDPmsZjeOZYL+3/dtZxK06+KTNamd1hfwKmhpaivJg+K0EUPY4CbigX
         UWM2QesjYfwC2twhPBUSb32MObIalEmL2t7h5LMYTtOS7JyUUdqbGc7OInOYu9/ZYA/E
         y4u1T1FmX4AfOZRZUJCDyQzTr3zrAscmC00xW+agveMNLwi5gVF/sJRjq4ptqWKEeeNN
         xPt4HMZqYE+5o/kcpp5A7Wj7O13ISucy1z+MxLXxQE5hNjFY8SlSkfzj60ALesUbd0zx
         s6kBXwGF6ZftTfJCI094rnbhYUA3QRYu/mLFExSpzb5BrveAdL/Ebc7AVM37J3dYRRR8
         NBeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790425049; x=1791029849;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f+NrjLsCLWWd027pKexVeBUqPCd1UlBkySnBmBeBwqY=;
        b=2W2ix0QZX60emtCQ5J3ofvcxJKtcBW+9m/g323nMFZ+/+OrtRAqLAERiVP+n+hHwV+
         CV1uTa81deYX7BX/KdP63V/PwSskE4hkSCJVhi6v1MwNo91cAiOo3PqNpAJfkAr87wuN
         OnFXKRYUGwXZJUWxSY4CklYQjPe9tThasCJa1BL4sIjaunbHDIzl66xLh/uqmxfIsrMl
         ImIX9fdhu+ADccE5s7MoSsXVi7GNBvIUdydWruTPbLYmAJTHICpI+8dR+98XnWBVJcxm
         StyByIVuByIWYfLqOaMUA/Oo8dSZGJ6sp+0HyrBghwMLbaxwvvrl1T5OfAc3xLJST57I
         ku9A==
X-Gm-Message-State: AFq9FYL9ygD2VZZXgeVT9XcM1LAv5NsxdO3Igjrvv40/83G4V9up1tOq
	tW/QESclKmztxqFYGwbwBQXb4hYRDkj1248+6WQqpsTCGDi3wrGlGq/kGfn2Ckad
X-Gm-Gg: AYBFou2/M0en4U41JZnDE4BTx9F/Xru9PF3z7AqsNUhAvUCM+BPDv9bhii5Xq78UwCr
	3n9gO43d5PXQwPqURxEkFbWDihS/nbuNDOvfOG4DwtOMsYaT72wPhbrUsCdIWFOHiPRwahFwhb2
	s6ZLjsTLcbUx42mivjKKuGW3LyU54gk3rZNRotSbjHQ6G8EgCReL0wLE/DKprPJX199nAGXTsgq
	mAs03czm3dunJWX+Er/Ce0BnlCwMCkKHQneh1Pjk1s22Lp5/PwwuYXJ2Mk8RpvOtoI5pgswXbnB
	rBz7ZEU6z72JVaW5Fe/isZ18EhWyG5BQll6oaCnkWZFb/zPcq6CnNT26PMU4qlOyYPnfX/wMYNM
	wBuz6Q0n9bnaQgGTFI0iWZKoSJuCv8NvhDEbfCAiENKFMzEu0h0EIMFSv/7zrrguavdQmsbqMzD
	50316QXK4ty9ADweG1LRTCU2rDoTasKRfrIf7Nm6ynYpHQn1En8MpPsLY1Shzrui39RgRwtCOjo
	2sehGKvI7ntqN4sf7jQcQ+c1ZweBzyMKWtfmiUSVsgoiVrInA8LbN5fZNpatSiV3eqmm6U6K9i9
	n9iXmWrDBVGk7LWCmSYCtg==
X-Received: by 2002:a05:690e:d05:b0:672:f50e:b8ba with SMTP id 956f58d0204a3-672f50edcb8mr3536659d50.56.1790425049131;
        Sat, 26 Sep 2026 05:17:29 -0700 (PDT)
Received: from merguez.lyrebird-fence.ts.net ([2605:a601:9092:700::6])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6740ee9d17csm2179151d50.5.2026.09.26.05.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 05:17:28 -0700 (PDT)
From: "D. Ben Knoble" <ben.knoble@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
	Eli Barzilay <eli@barzilay.org>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v3 0/5] stash: clean up index-mode test merge
Date: Sat, 26 Sep 2026 08:16:43 -0400
Message-ID: <cover.1790425008.git.ben.knoble@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7.dirty
In-Reply-To: <cover.1790168285.git.ben.knoble@gmail.com>
References: <cover.1790168285.git.ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

This small patch series fixes a bug reported by Eli Barzilay in the
interaction between autostashing, staged index entries, and
stash.index=true.

The first patch is an incidental cleanup, and the second re-arranges one
line to make the change easier. The third and fourth add missing test
coverage (which catch breakages from prior incorrect rounds of this
series), while the last holds the interesting bits.

Changes in v3:

• Change conflict label for current index
• Fix memory leak of merge_result
• Fix order of trees to make the correct merge (cherry-pick)
    • New test (3/5) to validate this
• Fix test in 4/5 to assert more details of expected state

Changes in v2:

• Do give branch labels for the incore merge, although they are never
  seen (and clarify commit message as a result, also keeping the
  merge-ort asserts). Phillip was right: without those, we do segfault
  on conflicts.
• Use the ui merge options to keep the same diff algorithm.
• Use merge_finalize instead of clear_merge_options, and reuse the
  options between merge calls if they are already initialized.
• Add a new 2/4 to simplify merge options initialization.
• Add a new 3/4 with a test case for conflicted index merges.

v1: <cover.1789853192.git.ben.knoble@gmail.com>
v2: <cover.1790168285.git.ben.knoble@gmail.com>

[1/5] builtin/stash: remove unused header
[2/5] stash: prepare merge options earlier
[3/5] t3903: test stash --index merges
[4/5] t3903: test failed "stash apply --index"
[5/5] builtin/stash: merge index in-core

 builtin/stash.c  | 85 +++++++++++-------------------------------------
 t/t3903-stash.sh | 42 ++++++++++++++++++++++++
 t/t7600-merge.sh |  9 +++++
 3 files changed, 70 insertions(+), 66 deletions(-)

Diff-intervalle contre v2 :
1:  b6798c8a25 = 1:  6a165c4df4 builtin/stash: remove unused header
2:  1e2343c7fc = 2:  d9a9e18f3a stash: prepare merge options earlier
-:  ---------- > 3:  8b5ea5e6f4 t3903: test stash --index merges
3:  5bd4b78cac ! 4:  d39e16905d t: test failed "stash apply --index"
    @@ Metadata
     Author: D. Ben Knoble <ben.knoble@gmail.com>
     
      ## Commit message ##
    -    t: test failed "stash apply --index"
    +    t3903: test failed "stash apply --index"
     
         The next commit will refactor index handling for applied stashes, so
         let's make sure we cover conflicted index merging, too.
     
    +    Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
    +
      ## t/t3903-stash.sh ##
     @@ t/t3903-stash.sh: setup_stash() {
    - 	test_cmp expect actual
    + 	test_cmp expect file
      '
      
     +test_expect_success 'stash apply --index leaves everything untouched on failure' '
    @@ t/t3903-stash.sh: setup_stash() {
     +	echo unrelated >file &&
     +	echo unrelated >another-file &&
     +	git add another-file &&
    -+	git diff-files >expect &&
    -+
     +	echo conflict >other-file &&
     +	git add other-file &&
    ++	git diff-files -p >expect &&
    ++	git diff-index --cached HEAD >expect-index &&
    ++
     +	test_must_fail git stash apply --index 2>err &&
     +	test_grep "conflicts in index. Try without --index" err &&
    -+	git diff-files >actual &&
    -+	test_cmp expect actual
    ++	git diff-files -p >actual &&
    ++	test_cmp expect actual &&
    ++	git diff-index --cached HEAD >actual-index &&
    ++	test_cmp expect-index actual-index
     +'
     +
      test_expect_success 'stash -k' '
4:  e49936ee12 ! 5:  fde7fb7988 builtin/stash: merge index in-core
    @@ Commit message
     
         Reported-by: Eli Barzilay <eli@barzilay.org>
         Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
    +    Helped-by: Junio C Hamano <gitster@pobox.com>
     
      ## builtin/stash.c ##
     @@ builtin/stash.c: static int create_index_from_tree(const struct object_id *tree_id,
    @@ builtin/stash.c: static enum stash_apply_result do_apply_stash(const char *prefi
     -				return error(_("could not generate diff %s^!."),
     -					     oid_to_hex(&info->w_commit));
     -			}
    -+			o.branch1 = "Upstream index";
    ++			o.branch1 = "Current index";
     +			o.branch2 = "Stashed index changes";
     +			o.ancestor = "Stash base";
      
    @@ builtin/stash.c: static enum stash_apply_result do_apply_stash(const char *prefi
     +			merge = lookup_tree(o.repo, &info->i_tree);
     +			merge_base = lookup_tree(o.repo, &info->b_tree);
     +
    -+			merge_incore_nonrecursive(&o, head, merge, merge_base,
    ++			merge_incore_nonrecursive(&o, merge_base, head, merge,
     +						  &result);
     +
    ++			oidcpy(&index_tree, &result.tree->object.oid);
    ++			merge_finalize(&o, &result);
    ++
     +			if (!result.clean)
      				return error(_("conflicts in index. "
      					       "Try without --index."));
    - 
    +-
     -			discard_index(the_repository->index);
     -			repo_read_index(the_repository);
     -			if (write_index_as_tree(&index_tree, the_repository->index,
    @@ builtin/stash.c: static enum stash_apply_result do_apply_stash(const char *prefi
     -			reset_head();
     -			discard_index(the_repository->index);
     -			repo_read_index(the_repository);
    -+			oidcpy(&index_tree, &result.tree->object.oid);
    -+			merge_finalize(&o, &result);
      		}
      	}
      

base-commit: d38352cd43ab9745686d697872408bc3249a153f
-- 
2.56.0.rc1.315.gc6ed9934b7.dirty

