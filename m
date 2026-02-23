Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7AC345729
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 08:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771833708; cv=none; b=ZcZbV1NEZUHkvdNpLc51OdgTcLa8PO+sSjJLoDkeEJr7+ajNmdYj0hXR9tpXsXTmoIWTIc/Zpx76bxsGubvoomzlDHZai7JEV3d39Q7ceh1H4Yc4MizqLy2JhcZM4ju8os071nvU1cIVMPELKkpSZwpuNfsmTR1Kz0iigFhgSto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771833708; c=relaxed/simple;
	bh=QmJVmUy/2i5fMhlHepiv2FVNGtOhuZ9Ovc8CWFrisbg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=L2RpKMS/JfTrIGZ/BQndumClTnlMKE+dTD9BqCX4q4IzuKhZHnpTCIHNGvZ/4sesg0pzjCAtnT8A6yAawAYmwOfTS/vca4BTT4w7DyPO7pwR70HCWpmgHAAI0z0KeAENAv8f1R7gZij5CbkI1iRr90U3hNKf6fxXgePrqla7mq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XRvYcDqC; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XRvYcDqC"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4833115090dso37904085e9.3
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 00:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771833705; x=1772438505; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nHX4QFlm7fgADo3uFrTEBUmc5UlwMbcDNXa7QnZ0j20=;
        b=XRvYcDqCAWkRP/o+DsHn8iU1/vm/5BqKVsiHhh5Gv+MtUyeIjv0ETLBQSnDS+bIFQg
         YTn+x/rzxJsFJ41O+KfnVpWsDjKMiJAkJu/z//xLoYVYGuLenBaikIprucYkQzl2BIpV
         B+2La5Kntwbo+n9oYSprB2wF87Vp8XnksEbLdjFiuU3Ztk3nXptkjNWnJNc1iGF3Krto
         7X4U0zv9SoLMA+8mqt5HSD+cGg+oKpMfBRoT6WZx9lJPJkmF5YRkiXa4FKZqgRJpT3St
         WEsw01QJhYDxv8mtMf7nbHF/yz+rwjVlQfShVP3a49J3+71Ix7Wko5o0Ks8P9OxM4qiY
         haZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771833705; x=1772438505;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nHX4QFlm7fgADo3uFrTEBUmc5UlwMbcDNXa7QnZ0j20=;
        b=H3XoDGjLrue5hVj9OkIxPR2Rj0HT+y+iwHXPXk7ojivS5MdCAcDatF+gzP1OyMcqi9
         Zo0+bo0bBo53AgjXhuXjnEX6AcYrgWxgcBDLertNmvQm/wKpDVLhzho7cgJIe1sDhClk
         So7wUBZjUbST4dI2ImLfPQeHWDN1ooh0fo8+764jDJaZ10/fHaKgNE5g/lWoAz5UqyRG
         zwFn1A89DPCll8j8BLbpcgIp9ymtAmxVsqPEswS9mrGcRO91WZxrUQ297rAbo25fSoSo
         T4xXUL+PfBsUqprRlMXVxZCIWDqRBkbsaz65jVlz/vjXlg+gVTq8xmz23Hv7HBPzIg5F
         nuaA==
X-Gm-Message-State: AOJu0YwWHnEDBecEmulRQeKU0tRvK1pbudd99/A9GZruqQDa35yYCtwJ
	mylfvbf31z/7Qhp/4T9VTtUgbNvr0JYIRtuaPg4s8T7J17wMXdaQ1Me3
X-Gm-Gg: AZuq6aKkfH3088zgMPeuKh5YtTktBPKdQ0TByxxhA/zOEoGT+Yge6cT4IOT5rNZMk5M
	Qo/n8iPBkAfKvlmGutOT7O60FJDZ2BOEZ3s4ck6xsuGonTpnR/F6jZ8I+kCbPhvtggzFRfnsrYl
	WmK6OM2kMwjNhJ6T32GNAUmGu+UlyLEk9tLY+mJrQnLYbjVG85d3Sg33rJEMNZWIIMs3L+zxI/m
	prZxAemTUXPwvQLH5u8Fc44dR2UdwZ9oRhoKyIggGKKtBW6DxA4fMQIw4sRdBpgNG952nUqMWei
	Ejr3BQdFa/OMLC66ykqHtuNOqSrNdjJ66VbTkk8CAxqDddDuvmYoHjvHw5C/oAaGtcTtiLbMutF
	SJqI2F1o2vECVRq7tcBApQl+Nw2CLZEIZNaYLOaO7KDj5vEzHYm+yiWIrKYBIjWoQgL1YM3ygSH
	Lr/4Pw27LwJSzW+BdVTUlJtNiaEXoglyY=
X-Received: by 2002:a05:600d:8444:20b0:483:afbb:a086 with SMTP id 5b1f17b1804b1-483afbba1e8mr41387125e9.29.1771833704731;
        Mon, 23 Feb 2026 00:01:44 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:f529:6f94:a480:7bd4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a3db3369sm117333775e9.0.2026.02.23.00.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 00:01:44 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v8 0/6] refs: allow setting the reference directory
Date: Mon, 23 Feb 2026 09:01:35 +0100
Message-Id: <20260223-kn-alternate-ref-dir-v8-0-0509c132a203@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAF8JnGkC/3XQ22oDIRAG4FcJXtfieDZXfY/SCw9jIk12i7ssL
 WHfvSa0dFkqyMCv+M0wNzJhLTiR4+FGKi5lKuPQgn06kHj2wwlpSS0TzrgCYIq+D9RfZqyDn5F
 WzDSVSgUqw9HGxDCT9vWjPZTPB/v61vK5TPNYvx5dFrjf/oDg/gcXoIzKmKV3MtqA6eV09eXyH
 McruYML3yBcdxDeEBtc1hls1kLtEfGHcAYdRDQkAgQndYg8+z0ifxHNWukgsiEiCCbbAUCxR9Q
 W6e1ENcRIZp2zQkYMe0RvEJAdRN93or3l0ZiYldsjZov0JjENAZ25sZqlkPIWWdf1G5WwLQlWA
 gAA
X-Change-ID: 20251105-kn-alternate-ref-dir-3e572e8cd0ef
In-Reply-To: <20251119-kn-alternate-ref-dir-v1-0-4cf4a94c8bed@gmail.com>
References: <20251119-kn-alternate-ref-dir-v1-0-4cf4a94c8bed@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com, ps@pks.im, toon@iotcl.com, 
 Karthik Nayak <karthik.188@gmail.com>, 
 =?utf-8?q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=8849; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=QmJVmUy/2i5fMhlHepiv2FVNGtOhuZ9Ovc8CWFrisbg=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGmcCWa7Ad6uDamtFTJFPFGEepDOdD9+Xemzp
 tHf1icEOvBWmokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpnAlmAAoJED7VnySO
 Rox/WTwMAKC0cB3J+YoqgjaC+bKHGkkEQfYq0vBkqfweVp0LRPvIlp0R2r60SS1Cs4G2eZmSuEu
 Ms1srqB52iOMne+BGBe7axdfIR1mNMFw2jg/RAWP+yjW8RegtYmcjS46U9yx+BayXNB/wwxDQaf
 IiOQ0Hvy0tOnUfBKXtoaYTpHpuLpaKVhdQ7ymDdiD5PQQ87J/zOPOUR9QR5Q2Oby2gfCuSRnhia
 /Lt4e4bhDTZstO58bXogcwXwowi4Hyw4OM0zuoRGzM3tMHM767pPaZ1P35/QNsVAuogIhSX/19w
 kDdj2uNcKJzySvvT830oT+wXVJEyuk5isFRjzSRTPiXWER6WJyEysXHGC6GvY/K9j9boe0TaBEy
 +Qoc3I61s1QTXISM0qqZt8VYyY7pRkUawvCbz/oxtoY9D2XZwXqxBg91NbVN4MjQlot6p67mI+4
 GAmhBb1fsiSKgeSeOJjuojpb4TjHLWL2+JWGkXjpmpt/Ks6+VIYfPUu4ovlAaKMIM5N+1JA3f65
 eU=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

While Git allows users to select different reference backends, unlike
with objects, there is no flexibility in selecting the reference
directory. Currently, the reference format is obtained from the config
of the repository and the reference directory is set to the $GIT_DIR.

This patch extends the config 'extensions.refStorage' to take in
multiple forms of inputs:

  - A format name alone (e.g., `reftable` or `files`).

  - A URI format `<format>://<payload>` explicitly specifies both the
    format and payload (e.g., `reftable:///foo/bar`).

We also add in a new ENV variable GIT_REFERENCE_BACKEND which can be
used to override the config.

One use case for this is migration between different backends. On the
server side, migrating from the files backend to the newly introduced
reftable backend can be achieved by running 'git refs migrate'. However,
for large repositories with millions of references, this migration can
take from seconds to minutes.

For some background, at GitLab, the criteria for our migration was to
reduce the downtime of the migrate ideally to zero. So running 'git refs
migrate --ref-format=reftable' by itself wouldn't work, since it scales
with the number of references and we have repos with millions of
references, so we need to migrate without loosing any information. We
came up with the following plan:

  1. Run git-pack-refs(1) and note timestamp of the generated packed-refs
     file.
  2. Run git refs migrate –dry-run.
  3. If there are no ongoing reference requests (read/write)
     a. Lock the repository by blocking incoming requests (done on a
        layer above git, in Gitaly [1]).
     b. If the timestamp of the packed-refs file has changed, unlock
        the repo and repeat from step 1.
     c. Apply all the loose refs to the dry-run reftable folder (this
        requires support in Git to write refs to arbitrary folder).
     d. Move the reftable dry-run folder into the GIT_DIR.
     e. Swap the repo config
     f. Unlock repo access

Using such a route, scales much better since we only have to worry about
blocking the repository by O(ref written between #1 and #3a) and not
O(refs in repo). But for doing so, we need to be able to write to a
arbitrary reference backend + path. This is to add the missing
references to the dry-run reftable folder. This series, achieves that.

Since there was a long gap between v3 <> v4, the version 4 onward is
based on top of 2258446484 (RelNotes: correct "fast-import" option name,
2026-01-30).

[1]: https://gitlab.com/gitlab-org/gitaly

---
Changes in v8:
- Fix a typo/grammar in commit 4.
- In the final commits tests, avoid creating a file for text
  comparison.
- Link to v7: https://patch.msgid.link/20260219-kn-alternate-ref-dir-v7-0-16f27860dbdf@gmail.com

Changes in v7:
- Add more details in the commit messages.
- Cleanup some whitespace.
- Reorder the commits to be group related changes together.
- Add checks for stubs in the tests when creating new repos.
- Link to v6: https://patch.msgid.link/20260214-kn-alternate-ref-dir-v6-0-86a82c77cf59@gmail.com

Changes in v6:
- The biggest change in this version is that we now support using the
  environment variable with 'git-clone(1)' and 'git-init(1)'. In such
  situations, the alternate reference directory is created and the
  config is added to the repository.
- Add a new commit which moves stub creation/removal to the generic
  layer.
- Cleanup logic flow in `refs_compute_filesystem_location()`.
- Add more tests for usage with 'git-clone(1)', 'git-init(1)' and
  migration of repositories using alternate refs backend.
- Fixup documentation, commit messages and typos.
- Link to v5: https://patch.msgid.link/20260209-kn-alternate-ref-dir-v5-0-740899834ceb@gmail.com

Changes in v5:
- Moved around the commits, to ensure that the code to handle the config
  in the backend is first. Previously, we added the config first, which
  meant the commit allowed users to provide a URI but it was simply
  ignore.
- Fix typos and grammar and rename variables.
- Clean up the description and documentation to actually specify
  protocol over location.
- Avoid an extra memory allocation by detaching the strbuf value.
- Link to v4: https://patch.msgid.link/20260202-kn-alternate-ref-dir-v4-0-3b30430411e3@gmail.com

Changes in v4:
- Mostly re-wrote the code to also support worktree. Now, the existing
  backends will store worktree references in 'ref_dir/worktrees/wt_id'
  and add corresponding stubs in 'git_dir/worktrees/wt_id'.
- We also support relative paths in the reference directories. These
  relative paths are resolved relative to the GIT_DIR.
- Link to v3: https://patch.msgid.link/20251201-kn-alternate-ref-dir-v3-0-c11b946bc2fa@gmail.com

Changes in v3:
- Cleanup some stale code which wasn't removed.
- Localize strings which will be output to the user.
- Remove additional defensive checks which are not needed.
- Link to v2: https://patch.msgid.link/20251126-kn-alternate-ref-dir-v2-0-8b9f6f18f635@gmail.com

Changes in v2:
- Added more clarification and proper intent in the cover message.
- Changed the format from '<ref_backend>://<path>' to
  `<ref_backend>://<URI-for-resource>` as it much clearer.
- Added logic to check for the '//' in the provided URI and a test for
  the same.
- In the tests:
  - Use test_must_fail() instead of ! git
  - Fix looped tests not using the variables correctly and ensure that
    the test description is correct.
- Link to v1: https://patch.msgid.link/20251119-kn-alternate-ref-dir-v1-0-4cf4a94c8bed@gmail.com

---
 Documentation/config/extensions.adoc |  16 +-
 Documentation/git.adoc               |   5 +
 builtin/clone.c                      |   9 +-
 builtin/worktree.c                   |  34 +++++
 environment.h                        |   1 +
 refs.c                               | 126 +++++++++++++++-
 refs.h                               |  13 ++
 refs/files-backend.c                 |  23 ++-
 refs/packed-backend.c                |   5 +
 refs/packed-backend.h                |   1 +
 refs/refs-internal.h                 |  14 ++
 refs/reftable-backend.c              |  61 ++------
 repository.c                         |   9 +-
 repository.h                         |   8 +-
 setup.c                              |  96 ++++++++++--
 setup.h                              |   4 +-
 t/meson.build                        |   1 +
 t/t1423-ref-backend.sh               | 280 +++++++++++++++++++++++++++++++++++
 18 files changed, 625 insertions(+), 81 deletions(-)

Karthik Nayak (6):
      setup: don't modify repo in `create_reference_database()`
      refs: extract out `refs_create_refdir_stubs()`
      refs: move out stub modification to generic layer
      refs: receive and use the reference storage payload
      refs: allow reference location in refstorage config
      refs: add GIT_REFERENCE_BACKEND to specify reference backend

Range-diff versus v7:

1:  0f9fad1145 = 1:  8cc4b88f60 setup: don't modify repo in `create_reference_database()`
2:  cfe28f7464 = 2:  382b7b1964 refs: extract out `refs_create_refdir_stubs()`
3:  7a08fde968 = 3:  ef00e85466 refs: move out stub modification to generic layer
4:  b6988bf969 ! 4:  3e7d7042ef refs: receive and use the reference storage payload
    @@ refs/refs-internal.h: enum ref_transaction_error refs_verify_refnames_available(
     + * directory if working with a linked worktree. If working with the main
     + * worktree, both values will be the same.
     + *
    -+ * This is used by backends that store store files in the repository directly.
    ++ * This is used by backends that store references in the repository directly.
     + */
     +void refs_compute_filesystem_location(const char *gitdir, const char *payload,
     +				      bool *is_worktree, struct strbuf *refdir,
5:  4769fae36f = 5:  5b69104cd9 refs: allow reference location in refstorage config
6:  6bc3f09144 ! 6:  6a007df2ad refs: add GIT_REFERENCE_BACKEND to specify reference backend
    @@ t/t1423-ref-backend.sh: run_with_uri() {
     +	refdir=$2 &&
     +
     +	# verify that the stubs were added to the $GITDIR.
    -+	cat $gitdir/refs/heads >actual &&
     +	echo "repository uses alternate refs storage" >expect &&
    -+	test_cmp expect actual &&
    -+	cat $gitdir/HEAD >actual &&
    ++	test_cmp expect $gitdir/refs/heads &&
     +	echo "ref: refs/heads/.invalid" >expect &&
    -+	test_cmp expect actual
    ++	test_cmp expect $gitdir/HEAD
     +
     +	# verify that backend specific files exist.
     +	case "$GIT_DEFAULT_REF_FORMAT" in


base-commit: 22584464849815268419fd9d2eba307362360db1
change-id: 20251105-kn-alternate-ref-dir-3e572e8cd0ef

Thanks
- Karthik

