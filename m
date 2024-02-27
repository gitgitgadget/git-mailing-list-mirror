Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727D913A87C
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 13:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709040506; cv=none; b=ZuVC4IbstzzglsfeVgXakpE5p6FF32M5VyQYh/ACBEGSeEfKJHMP5Islyf+HVoLoth+/po0DlCNbFsJ2dkOcsOmlQYphOFl3lKZmLwSj70ahRJawcGT5VdEFH27y9wry54wkLYLKyTUaB4U2eUSkHTTZloDuvCIJ2mj46Z8NyKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709040506; c=relaxed/simple;
	bh=gv66eBLhDDMa/bUvrDB18EkBJeaylFup2EPYSDOPTPs=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=IvNZgNgJ8mLcAqMLMIY5JwK78MVGqs8ASAcHA1u+yleSwEIxjctDP8KVEtdsGmmbfwUg6HR4RTG2tA53n4fJs0xQ9aWFiwPWQ3K3E0peU/1wWaeHj+uIQgLBSTP8p+oxe7h7UJa9PXLqArmfZ4Ed6dDQL0tnFTufwVh6kCMnse4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQ7ZdNzE; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQ7ZdNzE"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d109e82bd0so51609221fa.3
        for <git@vger.kernel.org>; Tue, 27 Feb 2024 05:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709040502; x=1709645302; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AxAUXiGT63nYBmXHUjmJAc1ZPHjMmqWUqVtjjXn0p0M=;
        b=BQ7ZdNzEcim7f4nZjQrPNGFXF/VUCBikLdISbEwcxkZ1Q6JN+B5z8WxnVtYYK97J4M
         qY4dvCmZFX7gJGzjUxL6dwi0s6r87V0D7pHcW3yKqqg0JDyPPbET0Gid+y9l1Yfybhlu
         hsB8rxE7Y12Ska+jIQsdQ6zG3xChe82BiHBS0IdlNSKmBcFelv/JYxM2TuoF+HkbOUOp
         8Xa5Ro6XDv94Lb0NGi/QA2A3mBriHthvbC+208x2X/6KPVi3AMMUSlc2gANyt5pmMy1W
         JEOuvIi8FlBHTZnpKEpXeXzX6kY6fAhXNeXkX1Ctn/VLcsNOQEJZnHVCeI6iGwrh9DEU
         DX8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709040502; x=1709645302;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AxAUXiGT63nYBmXHUjmJAc1ZPHjMmqWUqVtjjXn0p0M=;
        b=K3kL7ktyUY9InIsHFpuu7fMnirgMQcoc/rE9G3PTcT+Cb7XmJ+Rw2hMq0gEWynkxqd
         i16gTJw0EGVqN3l4xoAho6AkdBuMxWOaUCJyVtPTTNQzPPWgKfFLsOqn79dQX38+4gme
         SV79QcTNOdodkaj+xSFNQZ1VkBYMAwdBo5pXZTUk961s4ltOLDZKBarTeNrTUdP/RTHf
         0DFHvY/zXwHsUv392X23wJGabWrpaE8I8DChAg37/SICNF55iKfzImcUsDZbr2C+qTfz
         0apFGTQ9M1CWCkqtq4QTZBgLnQdOC5RkgC9Jh0NhHuE5IWh8f5HICLlzCMYrPHROCIH1
         BF2w==
X-Gm-Message-State: AOJu0YwZRw+cqTNxb5/WrFVD9SLFb4Slu7V01DYbvnAbxdFVYnraHaJZ
	ZZuFLoITxt6U+z3aqYcDSA3nm9r+n1Lf21Wz1f7cq1JCQ1O8OM6LOaFGLlRD
X-Google-Smtp-Source: AGHT+IFi269MWDJi8FIhvmAlEMSeB+/lxv/bhe0cqVSuLaW6PgUn/fLXqiJnWY3edm8DSXOjgsV8PQ==
X-Received: by 2002:a2e:8519:0:b0:2d2:35af:e8a5 with SMTP id j25-20020a2e8519000000b002d235afe8a5mr5295400lji.24.1709040501493;
        Tue, 27 Feb 2024 05:28:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n1-20020a05600c4f8100b004127ead18aasm11459291wmq.22.2024.02.27.05.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 05:28:21 -0800 (PST)
Message-ID: <pull.1657.v3.git.1709040497.gitgitgadget@gmail.com>
In-Reply-To: <pull.1657.v2.git.1708608110.gitgitgadget@gmail.com>
References: <pull.1657.v2.git.1708608110.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 27 Feb 2024 13:28:06 +0000
Subject: [PATCH v3 00/11] The merge-base logic vs missing commit objects
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

This patch series is in the same spirit as what I proposed in
https://lore.kernel.org/git/pull.1651.git.1707212981.gitgitgadget@gmail.com/,
where I tackled missing tree objects. This here patch series tackles missing
commit objects instead: Git's merge-base logic handles these missing commit
objects as if there had not been any commit object at all, i.e. if two
commits' merge base commit is missing, they will be treated as if they had
no common commit history at all, which is a bug. Those commit objects should
not be missing, of course, i.e. this is only a problem in corrupt
repositories.

This patch series is a bit more tricky than the "missing tree objects" one,
though: The function signature of quite a few functions need to be changed
to allow callers to discern between "missing commit object" vs "no
merge-base found".

And of course it gets even more tricky because in shallow and partial clones
we expect commit objects to be missing, and that must not be treated like an
error but the existing logic is actually desirable in those scenarios.

I am deeply sorry both about the length of this patch series as well as
having to lean so heavily on reviews on the Git mailing list.

Changes since v2:

 * Moved a hunk from 3/11 to 2/11 that lets the repo_in_merge_bases_many()
   function return an error if non-existing commits have been passed to it,
   unless the ignore_missing_commits parameter is non-zero.
 * The end result is tree-same.

Changes since v1:

 * Addressed a lot of memory leaks.
 * Reordered patch 2 and 3 to render the commit message's comment about
   unchanged behavior true.
 * Fixed the incorrectly converted condition in the merge_submodule()
   function.
 * The last patch ("paint_down_to_common(): special-case shallow/partial
   clones") was dropped because it is not actually necessary, and the
   explanation for that was added to the commit message of "Prepare
   paint_down_to_common() for handling shallow commits".
 * An inconsistently-named variable i was renamed to be consistent with the
   other variables called ret.

Johannes Schindelin (11):
  paint_down_to_common: plug two memory leaks
  Prepare `repo_in_merge_bases_many()` to optionally expect missing
    commits
  Start reporting missing commits in `repo_in_merge_bases_many()`
  Prepare `paint_down_to_common()` for handling shallow commits
  commit-reach: start reporting errors in `paint_down_to_common()`
  merge_bases_many(): pass on errors from `paint_down_to_common()`
  get_merge_bases_many_0(): pass on errors from `merge_bases_many()`
  repo_get_merge_bases(): pass on errors from `merge_bases_many()`
  get_octopus_merge_bases(): pass on errors from `merge_bases_many()`
  repo_get_merge_bases_many(): pass on errors from `merge_bases_many()`
  repo_get_merge_bases_many_dirty(): pass on errors from
    `merge_bases_many()`

 bisect.c                         |   7 +-
 builtin/branch.c                 |  12 +-
 builtin/fast-import.c            |   6 +-
 builtin/fetch.c                  |   2 +
 builtin/log.c                    |  30 +++--
 builtin/merge-base.c             |  23 +++-
 builtin/merge-tree.c             |   5 +-
 builtin/merge.c                  |  26 ++--
 builtin/pull.c                   |   9 +-
 builtin/rebase.c                 |   8 +-
 builtin/receive-pack.c           |   6 +-
 builtin/rev-parse.c              |   5 +-
 commit-reach.c                   | 209 ++++++++++++++++++++-----------
 commit-reach.h                   |  26 ++--
 commit.c                         |   7 +-
 diff-lib.c                       |   5 +-
 http-push.c                      |   5 +-
 log-tree.c                       |   5 +-
 merge-ort.c                      |  87 +++++++++++--
 merge-recursive.c                |  58 +++++++--
 notes-merge.c                    |   3 +-
 object-name.c                    |   7 +-
 remote.c                         |   2 +-
 revision.c                       |  12 +-
 sequencer.c                      |   8 +-
 shallow.c                        |  21 ++--
 submodule.c                      |   7 +-
 t/helper/test-reach.c            |  11 +-
 t/t4301-merge-tree-write-tree.sh |  12 ++
 29 files changed, 441 insertions(+), 183 deletions(-)


base-commit: 564d0252ca632e0264ed670534a51d18a689ef5d
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1657%2Fdscho%2Fmerge-base-and-missing-objects-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1657/dscho/merge-base-and-missing-objects-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1657

Range-diff vs v2:

  1:  6e4e409cd43 =  1:  6e4e409cd43 paint_down_to_common: plug two memory leaks
  2:  5c16becfb9b !  2:  f68d77c6123 Prepare `repo_in_merge_bases_many()` to optionally expect missing commits
     @@ Commit message
          passed to `repo_in_merge_bases_many()` to trigger this behavior, and use
          it in the two callers in `shallow.c`.
      
     -    This does not change behavior in this commit, but prepares in an
     -    easy-to-review way for the upcoming changes that will make the merge
     -    base logic more stringent with regards to missing commit objects.
     +    This commit changes behavior slightly: unless called from the
     +    `shallow.c` functions that set the `ignore_missing_commits` bit, any
     +    non-existing tip commit that is passed to `repo_in_merge_bases_many()`
     +    will now result in an error.
     +
     +    Note: When encountering missing commits while traversing the commit
     +    history in search for merge bases, with this commit there won't be a
     +    change in behavior just yet, their children will still be interpreted as
     +    root commits. This bug will get fixed by follow-up commits.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     @@ commit-reach.c: int repo_is_descendant_of(struct repository *r,
       {
       	struct commit_list *bases;
       	int ret = 0, i;
     + 	timestamp_t generation, max_generation = GENERATION_NUMBER_ZERO;
     + 
     + 	if (repo_parse_commit(r, commit))
     +-		return ret;
     ++		return ignore_missing_commits ? 0 : -1;
     + 	for (i = 0; i < nr_reference; i++) {
     + 		if (repo_parse_commit(r, reference[i]))
     +-			return ret;
     ++			return ignore_missing_commits ? 0 : -1;
     + 
     + 		generation = commit_graph_generation(reference[i]);
     + 		if (generation > max_generation)
      
       ## commit-reach.h ##
      @@ commit-reach.h: int repo_in_merge_bases(struct repository *r,
  3:  4dd214f91d4 !  3:  0aaa224b5db Start reporting missing commits in `repo_in_merge_bases_many()`
     @@ commit-reach.c: int repo_is_descendant_of(struct repository *r,
       		}
       		return 0;
       	}
     -@@ commit-reach.c: int repo_in_merge_bases_many(struct repository *r, struct commit *commit,
     - 	timestamp_t generation, max_generation = GENERATION_NUMBER_ZERO;
     - 
     - 	if (repo_parse_commit(r, commit))
     --		return ret;
     -+		return ignore_missing_commits ? 0 : -1;
     - 	for (i = 0; i < nr_reference; i++) {
     - 		if (repo_parse_commit(r, reference[i]))
     --			return ret;
     -+			return ignore_missing_commits ? 0 : -1;
     - 
     - 		generation = commit_graph_generation(reference[i]);
     - 		if (generation > max_generation)
      @@ commit-reach.c: int ref_newer(const struct object_id *new_oid, const struct object_id *old_oid)
       	commit_list_insert(old_commit, &old_commit_list);
       	ret = repo_is_descendant_of(the_repository,
  4:  53bdeddb4cb =  4:  84e7fbc07e0 Prepare `paint_down_to_common()` for handling shallow commits
  5:  ec3ebf0ed17 =  5:  85332b58c37 commit-reach: start reporting errors in `paint_down_to_common()`
  6:  05756fbf71a =  6:  2ae6a54dd59 merge_bases_many(): pass on errors from `paint_down_to_common()`
  7:  e3d37a326e5 =  7:  4321795102d get_merge_bases_many_0(): pass on errors from `merge_bases_many()`
  8:  9ca504525b9 =  8:  35545c4b777 repo_get_merge_bases(): pass on errors from `merge_bases_many()`
  9:  b11879edb73 =  9:  a963058d2ba get_octopus_merge_bases(): pass on errors from `merge_bases_many()`
 10:  602a7383f72 = 10:  c3bed9c8500 repo_get_merge_bases_many(): pass on errors from `merge_bases_many()`
 11:  96850ed2d69 = 11:  bdbf47ae505 repo_get_merge_bases_many_dirty(): pass on errors from `merge_bases_many()`

-- 
gitgitgadget
