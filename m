Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793055202;
	b=Dg8OaBHYPgKhC2MQ/cElr4KfC9pEf36nvM4HuC+9lJP8YSQO549X15JNkxOkLd3ONkpM
	 aAyLibqMuEFkwsJU5OPjYdoptca+izhz3esa5ZMGTC18j1TKPsiEida2TfqCO6fhngiVh
	 ZZ2YC7THnGupzaOZLVbpUEGqzMcLQl1ybdJe7bvBci+PhDJv4yh2MeOebEsKAYReM/yDm
	 TnF9OOdIO6ziuCMxUwvyipKwT1gGl/v3kvJFUSmUx+1wSGeL+VgjEU/uEnu4MCKypd5Zh
	 QseLN7cSF6A5XePkaj3rbIgo4vK6AyxvsYiCWYw0EyjLUeq26GrbdA6YplfZAqsub7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793055202;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Subject:Date:Message-ID:User-Agent:MIME-Version:
	 Content-Type;
	bh=U5ynTKuToVm495Z+lftUwKri3ukXrP/gP34lWlf+8UI=;
	b=w+R7d92nRRyq/TvEe8ici7FuGJs2vnWKVJvyW3qDg0Lycmc5ihabk1RZdIzBT3owRqME
	 ExqpnBJhSYkBDbpnmjO6lbxv1q1GZV5CoILb31UjdHPKkOMnkwSIAX10FIoBix9SqKK0d
	 9gBr/H9QFisCuuRsyKfOCLpFywNsot7P7BeXgSZtpGA6veqGGEuQ3NpdeUt+8eHm2K2IG
	 Q+rwhee+KHU2Xktw+HmxMlDUbXFM6t4AqIwryWUHRwJS5W0a4XqvB0NllVCDBqd7fVTYD
	 DdErS8zb2jh/lmHE4+9a6U+sfjpMjD0dAG7KCrRucB/1366I3Dcronqp/mZc3cKdF8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=hT4g9PN3;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=KOw8LVzZ;
	arc=none smtp.remote-ip=103.168.172.156
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F58606A330
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 22:53:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01F58606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=hT4g9PN3;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=KOw8LVzZ
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3254714009C5
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 18:53:21 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 26 Oct 2026 18:53:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1793055201; x=1793141601; bh=U5ynTKuToVm495Z+lftUwKri3ukXrP/g
	P34lWlf+8UI=; b=hT4g9PN3XxCNGOyXI6VYA12U4xwvgW7ifjIbez6+d/hoUnzQ
	9ugpoC2nrPoWfqIkwBp6LW+rpBKbNqmBRiMtcA+hBbQfU/+YBASp8/GIErafMOmP
	9dJCaYzOOYY/2vkCX1Ibka+tUS057m0MGvsAx0E8x/dOYJv7gqkEygqzK73YG/9z
	mBsLB06O2gtRxtHtohfIKUWU7OW5NmMxI2WlD6qasP6qIHrvrtPgK3IVD9UcXRGd
	fCPxGjKmM6lj6xiHkdq5yxXeSqmxX9N+nz7+QOJTvzFIsNTUoTkSjpzUOqXcGuLY
	+uApTXn3HFIwVOFJH/1jo8QU/6MTjEY/JAGfiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793055201; x=
	1793141601; bh=U5ynTKuToVm495Z+lftUwKri3ukXrP/gP34lWlf+8UI=; b=K
	Ow8LVzZfK0mC2jT4GQx5yW907ceb9C6tkghq65c45+rm4riTs3zyJMRKN1cIGwrX
	aUakTyZnOQLndkSyG7LS12UHRo2aZBDje0w3clTlaXXIF2fCeJHNV0feEXm4LpLp
	j3W2OxV2u0/qmgzKEsFwV6ZlwfVgM8tNtH19bZljePu/AT/4Eu5BQiQmw3RMGMyq
	TNLB/+PpoXb/L/MpZj6zjRQio3wbGl2zenv4PjrVOWox9gX/KKdrLoMzsoq5GHYi
	fNz6SqRPDTdBTIsyd3X0RFRMTVGOXvr+ibyle6NszcRC7mT17yWWaKmOZIeROqyG
	bPiZzg+26VwSuFyGhhExw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793055201; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:BPPzYOUvA2+2iaiqnpiv8cN9P8dWraJjAYlYpdZ8kY6tIkQ
	vQcxbIqdV93TnaO1ZoiYLNMdiatS6w/Uyn1PdqBPdottiBAXguFWbVbZkfO8iA5Z
	/Yh9lDcGSHNR7HAxJdorjxmw0dM+XzbLeYLoAWyui6St8ZS0mxTNZwDQ4GroNGIq
	Znthq9FhABziRHJ+ZlG5/Lr0pDjyNgv1yABxACENrCiRLrQ66E/ZtUAhJTXxT0nU
	4NyutZQuuW4SbGMQumeB4Cqev5W6hncZ2E3FJk7mbf06yqOnCtc76Sg6rOIJ7Ko0
	CgjqyiG5ndkuidJJTXq4x0oyn4Cyp+1lOe42G+A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=9;
	hn=content-type,date,feedback-id,from,message-id,mime-version,
	subject,to,user-agent;
Message-Instance: m=1; h=sha256:liPUa07U9ED1cz9aMPsA2xvuhBe4rcyxHk5k6TqHPx8=:8nnh1bLVCCofSWoLWoCaJcAnJTbl5kpwGEtbPOLD968=;
X-ME-Sender: <xms:4dnfareoZASwxM8YARZ7hGQ2lhPnHoJCJscYy8JGjs0o67SH6DxAkQ>
    <xme:4dnfanPft2Hpy_eIKAmkIw4aT5eLswfRYH6PSeE3nSvMWQ-KQFqOL_LC8JiAsWuhd
    8Y85xfsAwKpxCW3O_xu0shRrYtbYulUs58ZaovkjCFim9x5s1mMv6c>
X-ME-Received: <xmr:4dnfaiJsWLqu-rLIWJQdil3MKj3x7z_AaLEI5sIS0MBS6UpCPoe91JBVxXAm90u8wPSIvh2I3pZ1MBtlDtEwAxxFTA6dfxkM5P3I>
X-ME-Proxy-Cause: dmFkZTFsnqNDOUS8Hs7jIURqAdhAdmw7TEmxhrSbG1tQmVohnhK02N7sOPudK7t37snV6K
    8BUpWd8UQkq3AnxZUhAMGwvXi2jjmr7QUr54lt87v5GOa4fFBn6qj6rdr4cDt+roDyVm6F
    xpBmVIf1c0rIG8HfQ5LIV63kjkzSdqnzgh0XcKO5UMSX0ve20IPza1rISP+3JoQwnzHMtr
    k7PvON5PdhpNluzUGyolFHaKBZKsJTirVRFumSPp7rx9Xoe+HQPyK91+mIKq7VvPgvJAiu
    M1BFLHQYLTSzc+PcFE1hDWU6k8ZwWeL/v9dfwaMJTqOGYjpJA7qHlFJgMxSgaP/4/g/oe1
    CozpATS/R2Yhy4lVHtQBLKCZfp40OZ0vcx5QHGYHNPBgxbj0iOZD0ZpuGhAPC6fyYuQDj3
    /r0kD2Qq26Qdouu+H60l+FKhT9b1g1qYUuoJkkfZd6rnNUMIvYLnupPffNm4v2W9maTAeQ
    8jbzh6/B6cTcCPcxrVlXnu9gcCkQ9ol1D46AeSN6eVHTappwuXfDn8yr/xhxUYl7Gmsjua
    dWQa6j5glwwrXnSw1eMKRdpj4PZRkXijncBUXuN4Bp4nWin2xtrE4RAGGZWzWOm+4fyEXg
    ko9IRsn2GWjzY9ksyhihjT16XTU3/tXN7V4gYCudL5sFNPGQEi/mV+bSxkVQ
X-ME-Proxy: <xmx:4dnfaoHf_hsDYn2EmBaxFqaAw4zOBlaXCvpjS9gkv2sXDOPMyWwzcg>
    <xmx:4dnfaqSNBbtQpqw_gzBtUlea1mRkFosDjcpbMGK1vq4YtcUkQb94oA>
    <xmx:4dnfakGSZgeYcnZZAZZvw0OWzy2CCuoys4Xwpm1qcyrXEcwOzua8sQ>
    <xmx:4dnfam9ek1sjfOuS7_W1--0vcw0z6w3Q0IUVrMHAN27_t3vxYeVaeg>
    <xmx:4dnfam1ep1GbLXOmijD-uTqAqj5QWmKb4J1yNVVMiMrd2ciNo6-0Af6f>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 18:53:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: Excerpt from "What's cooking" draft
Date: Mon, 26 Oct 2026 15:53:19 -0700
Message-ID: <xmqqmrs0nkf4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Here is the list of topics that graduated to 'master' since the last
issue of the "What's cooking" report.

Thanks.

[Graduated to 'master']

* ak/sequencer-head-refdup (2026-10-14) 1 commit
  (merged to 'next' on 2026-10-19 at 2ff8066fce)
 + sequencer: don't clobber HEAD ref name in worktree lookup

 The branch decoration logic in the sequencer has been updated to use
 an allocated buffer for the HEAD reference name, preventing it from
 being clobbered when evaluating branches checked out in other
 worktrees.

 Graduated to 'master'.
 cf. <xmqqik34qd6s.fsf@gitster.g>
 cf. <837b7d72-a767-4c51-9693-8fd95d14a58d@gmail.com>
 source: <20261014165824.2214234-1-andy.koppe@gmail.com>


* ic/includeif-hostname (2026-10-15) 3 commits
  (merged to 'next' on 2026-10-19 at dc388c8226)
 + config: learn the "hostname:" includeIf condition
 + t6500: get hostname from "git var"
 + var: add GIT_HOSTNAME

 The conditional configuration inclusion mechanism via 'includeIf'
 has been extended to support matching the machine's hostname, and
 the system's hostname as seen by Git can now be queried using 'git
 var GIT_HOSTNAME'.

 Graduated to 'master'.
 cf. <xmqqjynin4iv.fsf@gitster.g>
 cf. <xmqqa4oi67tx.fsf@gitster.g>
 source: <20261015105859.3184108-1-bellacaselli20@gmail.com>


* je/doc-promote-git-help (2026-10-16) 1 commit
  (merged to 'next' on 2026-10-19 at 67e49ef79c)
 + doc: use `man git` to teach users how to navigate the docs

 The earliest part of 'man git' has been rewritten to explain various
 ways to use 'git help' to get help.

 Graduated to 'master'.
 source: <pull.2242.v3.git.1792178103727.gitgitgadget@gmail.com>


* mb/fast-import-reference-pending (2026-10-14) 1 commit
  (merged to 'next' on 2026-10-19 at 7dfc4734f0)
 + fast-import: allow 'from' to reference new commits and tags by oid

 The 'from' command in 'git fast-import' has been updated to
 correctly resolve references to newly created commits and tags by
 checking the internal object table, preventing a crash when the
 objects are not yet available in the object database.

 Graduated to 'master'.
 cf. <xmqqqzhrq4ye.fsf@gitster.g>
 source: <pull.2252.v4.git.1792012956734.gitgitgadget@gmail.com>


* ps/ci-housekeeping-and-modernizations (2026-10-14) 8 commits
  (merged to 'next' on 2026-10-19 at c0cf13277b)
 + ci: improve reftable test coverage
 + ci: drop now-dead Python 2 coverage
 + ci: switch away from EOL'd Ubuntu version in linux-feature-testbed
 + ci: rename linux-TEST-vars job
 + ci: switch away from unsupported i386/ubuntu image
 + ci: drop unused "linux-clang" logic
 + ci: fix "fedora-breaking-changes-meson" job
 + t5004: fix test creating an archive with large objects under SHA256

 Various CI jobs have been updated to use modern OS images, drop dead
 code, and remove redundant jobs. Support for Python 2 in CI has been
 removed, and the linux-TEST-vars job has been renamed to
 linux-feature-testbed.

 Graduated to 'master'.
 cf. <20261015070605.GA2556608@coredump.intra.peff.net>
 source: <20261015-pks-ci-housekeeping-v4-0-c2c88f1b198e@pks.im>


* ps/odb-files-alternates-cleanups (2026-10-14) 6 commits
  (merged to 'next' on 2026-10-19 at 242a7794ab)
 + odb/source: drop `local` flag
 + odb: don't try re-fetching corrupt objects
 + odb: remove read loop for found objects
 + odb/source-files: make the second read an implementation detail
 + odb/source-files: fix performance when streaming objects with alternates
 + odb/source-files: fix performance when reading objects with alternates
 + Merge branch 'ps/odb-files-alternates' into ps/odb-files-alternates-cleanups
 (this branch is used by ps/odb-reload-alternates.)

 The object database "files" backend has been optimized to check
 packfiles across all alternate object directories before falling
 back to checking loose objects, significantly reducing the number of
 'stat(3p)' system calls.  Additional refactoring drops the generic
 'local' flag from the object database source interface in favor of
 backend-specific fields, and simplifies the retry loop for missing
 objects.

 Graduated to 'master'.
 cf. <atEMt5wgfblCiv5a@denethor>
 cf. <xmqqfqy5is5o.fsf@gitster.g>
 source: <20261015-pks-odb-files-alternates-cleanups-v3-0-bfc62fd780eb@pks.im>


* ps/pack-check-bigfile-threshold (2026-10-14) 1 commit
  (merged to 'next' on 2026-10-19 at d477f68a6d)
 + pack-check: fix bogus corruption report with core.bigFileThreshold

 A boundary check in 'git fsck' against the big file threshold has
 been corrected to prevent bogus corruption reports on packed objects
 whose sizes exactly match the threshold.

 Graduated to 'master'.
 cf. <xmqq8q40tczj.fsf@gitster.g>
 source: <20261014-b4-pks-pack-check-matching-large-file-threshold-v1-1-de6d8455eaaa@pks.im>


* ps/setup-enforce-repo-passed-to-create-repository-has-no-state (2026-09-28) 7 commits
  (merged to 'next' on 2026-10-17 at 68944adf51)
 + setup: enforce that passed-in repo does not carry relevant state
 + repository: adapt `repo_clear()` to fully reset the repository
 + builtin/clone: don't apply "core.sharedRepository" to leading dirs
 + builtin/init: move handling of "core.sharedRepository" into "setup.c"
 + builtin/init: refactor messy creation of leading directories
 + path: introduce `safe_create_leading_directories_no_share_const()`
 + path: drop useless `safe_create_leading_directories_1()`
 + Merge branch 'ps/odb-alternates-at-creation' into ps/setup-enforce-repo-passed-to-create-repository-has-no-state
 (this branch is used by ps/odb-object-storage-extension.)

 The repository initialization sequence has been refactored to treat
 the repository object passed to create_repository() purely as an
 out-parameter.

 Graduated to 'master'.
 source: <20260928-pks-create-repository-stateless-v2-0-a03612f703fa@pks.im>


* rm/blame-default-ignore-revs (2026-10-13) 2 commits
  (merged to 'next' on 2026-10-17 at 31af0a1889)
 + blame: ignore revs in .git-blame-ignore-revs by default
 + blame: harden ignore-revs parser and tag peeling

 'git blame' and 'git annotate' have been updated to automatically
 use the '.git-blame-ignore-revs' file from the working tree (or
 'HEAD:.git-blame-ignore-revs' in bare repositories) as the default
 ignore list if it exists, and the parser has been hardened.

 Graduated to 'master'.
 cf. <xmqqse29uyh3.fsf@gitster.g>
 source: <pull.2224.v6.git.1791922928.gitgitgadget@gmail.com>
