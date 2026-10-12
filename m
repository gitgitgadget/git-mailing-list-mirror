Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A284C4F48
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 19:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791832650; cv=none; b=mcrqAussZs9vMUqlfcT0J9AccSA4Q+ooGfmLy6fdHyah98G3VV4hzg3Vb/nFrDOywPUK2ipkD42nHu5yGF9iSp+Fj6KHBB55cFDZYqre1nD6FvnE5sDtosI3w6Z4HDlA9PizFLfKlu9ONssmHdOL1DKG+Cd0Kc3aTVpb1ZuypLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791832650; c=relaxed/simple;
	bh=d/rqLDN7F/oXpIZ7u7BlPIlYRwp8hpvE0IBda0M5vqA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=RJ9Q33I6uXg2TX2plimQBhbx/GPuRIhs/mmk8qZvluZPTFDyWKocr7HudvPEG49TQ8IG8JIxsvSNOZPwmLtAXvNhvMjg6QIyTVPC19OOOHdkLthH+7YI6EYzxv03hHVaAdoMGv/bLHJi3O9PXeqHpei0cTHk4UwYEqip3nIVg8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XQjYqSGh; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQjYqSGh"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-92ed3993c1eso137186785a.1
        for <git@vger.kernel.org>; Mon, 12 Oct 2026 12:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791832647; x=1792437447; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ozLbDcpG3ULWbik8ZzlfyDGMF6OulgTsJ1I0LNeYJRc=;
        b=XQjYqSGhfTq4Pqy5Tejc2z2XJ4byhcOOo0tiW0rF2YqDsBRkVckzG40dhEmapX0U0o
         85xiN1ibPNEjhEkkSGy6StYXK5AMyIHQ+o5Bych+MpQf0oTus+DNNR78zHnA5pTn2ml4
         LT8QHbB0zSNpgkiQhsORdNHU8mT+O1bfgT1d58cm2V37UYOj9DNv1YLGZzZnNCmCEIZV
         5/1D2TQDjxsqLdZRCWMr0eWRLKKjzl7KDPPXxG2qcbG4PKkliMkZms7ukb8b1wIeyUot
         oHgcgXbfUXfDCBs9b1Q9GRwwALBjouD72ifk4IDxPMobN/S5mX/VLF3myUmLk1IBF0D1
         UqRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791832647; x=1792437447;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ozLbDcpG3ULWbik8ZzlfyDGMF6OulgTsJ1I0LNeYJRc=;
        b=IoiqpDdD1qSVF3tNP9Peg5rWIrbbq6aYM9yWFbmRvVr82zY7MGZygrfv9UTm1ADqSQ
         BVlfHDCnvTSW8ooh46sGHWAtrVJ/BlfpYXftwEhYVh15hXsCiVmFnCoAU8aht0wBLj/u
         UW5dhaBuROgXw0PIgBQ46NsqIK2drzpJpXNmfCYUnWmSBn1djuGRy6PTjQJ74x2MXxTn
         oolPtXwoiA+ADZkXXdowkS6PFkGA24hXoNL+1ASV6oVp+6k8xgZ3FCLhDllyI/f4GKMb
         sygSem5j6co68NI/n3HhGpJwzpNV7u0pp1pJBq6Ysakmg6MIPt/TlcU5QHJU7eVMbhFu
         KAQQ==
X-Gm-Message-State: AFq9FYJVzeYhL5EtzuCfTMEUx14SFxgFjQVuYcPbaFA8sF5mK2vreqle
	F0tV1W7MFif8FW652X7eexzbiTPPc+sFvhRR6MHFcLHU6YW23pObruAldHd+kA==
X-Gm-Gg: AYBFou2WXB5MxbVUzQaTPyMpN/9QlrdufvBcSLPg3HxM5NRFIX7/dZVcqjukVv/762f
	cPiYR2YT4iBF5NpuWfN4TvSk4opQI7sCEjFkTwlkJjmZi07kpuqcAHeJhtfu7+HsLF+Jou5gg56
	D1FaJ/slDbhLOxi9xQlMuiKn2DkeQQT9pFDb8FfktZYRykHZ4O84f6fBfTFmsXI3bSckdazeo/r
	Xcxe6EBhv2VD4SqjMGP8sp/py0wwH53K/BsfQ5hFgtWj/lOYlow7+SEfzgsqCYFTGa9cviOJMs6
	KA+dqcLtgIztD9Hu4dCd+oIovyey2u5gvSeAacvpWwz+qxepryi1h3x+Ds0vQyJy36hZpxJ7TbG
	Ik6fV4I3GjIa8rMpCfF6kReOPssDnvsF1bbCWKt1LC1B5bjOQfQIosHPBjXWYGOyESEMe2rw2F2
	LuvpUHnUTH3FoUwl55wKi73QiczWe4syNy6volw76Zvgu3tqemy6hvKHqAg9abPwYN5ORGRyk68
	LSJNF/Tug3Jag==
X-Received: by 2002:a05:620a:44c4:b0:93b:d7a2:dd2b with SMTP id af79cd13be357-93ebd282089mr1756895485a.59.1791832647285;
        Mon, 12 Oct 2026 12:17:27 -0700 (PDT)
Received: from [127.0.0.1] ([52.224.247.165])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ef5090050sm56785185a.40.2026.10.12.12.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 12:17:24 -0700 (PDT)
Message-Id: <pull.2224.v4.git.1791832644.gitgitgadget@gmail.com>
In-Reply-To: <pull.2224.git.1789169384240.gitgitgadget@gmail.com>
References: <pull.2224.git.1789169384240.gitgitgadget@gmail.com>
From: "Ravi Mistry via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 12 Oct 2026 19:17:22 +0000
Subject: [PATCH v4 0/2] blame: ignore revs in HEAD:.git-blame-ignore-revs by default
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
Cc: Junio C Hamano <gitster@pobox.com>,
    Abhijeetsingh Meena <abhijeet040403@gmail.com>,
    Kristoffer Haugsbakk <code@khaugsbakk.name>,
    Phillip Wood <phillip.wood@dunelm.org.uk>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Ravi Mistry <rmistry@google.com>

This series teaches git-blame(1) and git-annotate(1) to automatically use
the HEAD:.git-blame-ignore-revs blob by default if it exists, so local runs
match hosting platforms without requiring manual blame.ignoreRevsFile
configuration in every clone. This restarts the stalled attempt in PR
https://github.com/gitgitgadget/git/pull/1809
(https://lore.kernel.org/git/pull.1809.v2.git.1728707867.gitgitgadget@gmail.com/)
and addresses https://github.com/gitgitgadget/git/issues/1494.

Changes since v3:

 * Patch 2/2 caps the size of the default HEAD:.git-blame-ignore-revs blob
   at IGNORE_REVS_MAX_FILE_SIZE (100MB, matching ATTR_MAX_FILE_SIZE from
   3c50032ff5 ("attr: ignore overly large gitattributes files", 2022-12-01))
   via odb_read_object_info() before calling odb_read_object(), skipping
   oversized blobs with a warning without loading them into memory.

Changes since v2:

 * Patch 2/2 uses sb->repo instead of the_repository in
   parse_default_ignore_revs_blob().

Changes since v1:

 * Split the series into two commits.
 * Patch 1/2 hardens oidset_parse_file_carefully() in oidset.c and
   peel_to_commit_oid() in builtin/blame.c before exposing them to
   upstream-controlled content at a well-known path:
   * Reject lines containing embedded NUL bytes via memchr() so trailing
     bytes after a NUL cannot be silently ignored.
   * Pass OBJECT_INFO_LOOKUP_REPLACE | OBJECT_INFO_SKIP_FETCH_OBJECT |
     OBJECT_INFO_QUICK to odb_read_object_info_extended() and peel tags one
     layer per iteration so missing OIDs or tag targets do not trigger lazy
     promisor fetches or pack directory rescans in partial clones, and
     verify that each peeled target matches the tag's declared type.
 * Patch 2/2 reads the committed HEAD:.git-blame-ignore-revs blob (in both
   bare and non-bare repositories) instead of reading a file from the
   working tree, matching hosting platforms even when an untracked file is
   present or a tracked one has local modifications. The tree entry is
   checked with S_ISREG() so non-regular entries (such as committed
   symlinks) are skipped, parsed in memory via
   oidset_parse_buffer_carefully(), and bypassed without reading if cleared
   via blame.ignoreRevsFile="" or --no-ignore-revs-file.

Ravi Mistry (2):
  blame: harden ignore-revs parser and tag peeling
  blame: ignore revs in HEAD:.git-blame-ignore-revs

 Documentation/blame-options.adoc |   8 +-
 Documentation/config/blame.adoc  |   9 +-
 builtin/blame.c                  |  74 +++++++++-
 oidset.c                         |  81 ++++++++---
 oidset.h                         |   9 ++
 t/t8013-blame-ignore-revs.sh     | 235 +++++++++++++++++++++++++++++++
 6 files changed, 381 insertions(+), 35 deletions(-)


base-commit: fa7f9290efe2bd22dd736689597b474b93798e11
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2224%2Frmistry%2Fblame-default-ignore-revs-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2224/rmistry/blame-default-ignore-revs-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/2224

Range-diff vs v3:

 1:  2e12486c0d = 1:  2e12486c0d blame: harden ignore-revs parser and tag peeling
 2:  72a87d1c34 ! 2:  76d597dfa8 blame: ignore revs in HEAD:.git-blame-ignore-revs
     @@ Commit message
            reading the object so that non-regular tree entries (such as a
            committed symbolic link whose blob stores a target path rather than
            revision IDs, a subdirectory, or a gitlink) are skipped instead of
     -      being read and rejected as malformed object names. The blob is parsed
     -      in memory via a new oidset_parse_buffer_carefully() helper in
     -      oidset.c that shares line parsing with oidset_parse_file_carefully().
     +      being read and rejected as malformed object names. Its size is checked
     +      via odb_read_object_info() and capped at IGNORE_REVS_MAX_FILE_SIZE
     +      (100MB, matching ATTR_MAX_FILE_SIZE from 3c50032ff5 ("attr: ignore
     +      overly large gitattributes files", 2022-12-01)) so an oversized blob
     +      is skipped with a warning without being loaded into memory. The blob
     +      is parsed in memory via a new oidset_parse_buffer_carefully() helper
     +      in oidset.c that shares line parsing with
     +      oidset_parse_file_carefully().
          - In build_ignorelist(), ignore-revs entries are processed starting
            after the last empty string entry. This ensures setting
            blame.ignoreRevsFile to "" or passing --ignore-revs-file "" or
     @@ Commit message
          add comprehensive test coverage in t8013 for the default blob lookup,
          subdirectory invocations, bare repositories, uncommitted and untracked
          working-tree files, CLI and config overrides, committed symlink
     -    entries, and comments and whitespace handling.
     +    entries, overly large blobs, and comments and whitespace handling.
      
          Based-on-patch-by: Abhijeetsingh Meena <abhijeet040403@gmail.com>
          Helped-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     @@ builtin/blame.c: static int peel_to_commit_oid(struct object_id *oid_ret, void *
       	}
       }
       
     ++#define IGNORE_REVS_MAX_FILE_SIZE (100 * 1024 * 1024)
     ++
      +static void parse_default_ignore_revs_blob(struct blame_scoreboard *sb,
      +					   const char *name)
      +{
     @@ builtin/blame.c: static int peel_to_commit_oid(struct object_id *oid_ret, void *
      +	if (!S_ISREG(oc.mode))
      +		goto out;
      +
     ++	if (odb_read_object_info(sb->repo->objects, &oid, &size) != OBJ_BLOB)
     ++		goto out;
     ++	if (size >= IGNORE_REVS_MAX_FILE_SIZE) {
     ++		warning(_("ignoring overly large ignore-revs blob '%s'"), name);
     ++		goto out;
     ++	}
     ++
      +	buf = odb_read_object(sb->repo->objects, &oid, &type, &size);
      +	if (!buf)
      +		goto out;
     @@ t/t8013-blame-ignore-revs.sh: test_expect_success 'ignore-revs-file peels chaine
      +'
      +
      +test_expect_success 'blame works when HEAD:.git-blame-ignore-revs does not exist and ignores untracked file' '
     ++	test_when_finished "rm -f .git-blame-ignore-revs" &&
      +	git rm -f .git-blame-ignore-revs &&
      +	test_tick &&
      +	git commit -m "remove .git-blame-ignore-revs" &&
     @@ t/t8013-blame-ignore-revs.sh: test_expect_success 'ignore-revs-file peels chaine
      +	git rev-parse DEF_B >expect &&
      +	test_cmp expect actual
      +'
     ++
     ++test_expect_success EXPENSIVE 'overly large default HEAD:.git-blame-ignore-revs blob is ignored' '
     ++	blob=$(dd if=/dev/zero bs=1048576 count=101 2>/dev/null |
     ++		git hash-object -w --stdin) &&
     ++	git update-index --add --cacheinfo 100644,$blob,.git-blame-ignore-revs &&
     ++	test_tick &&
     ++	git commit -m "overly large .git-blame-ignore-revs" &&
     ++	test_when_finished "git reset --hard HEAD~" &&
     ++	git blame --line-porcelain def-file >blame_raw 2>err &&
     ++	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
     ++	git rev-parse DEF_B >expect &&
     ++	test_cmp expect actual &&
     ++	test_grep "warning: ignoring overly large ignore-revs blob '\''HEAD:.git-blame-ignore-revs'\''" err
     ++'
      +
       test_done

-- 
gitgitgadget
