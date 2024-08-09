Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED461946B9
	for <git@vger.kernel.org>; Fri,  9 Aug 2024 15:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723217878; cv=none; b=Zvr3xleUIgCrOc13+vVKKcRtAQJbqLEdZpVSyIbZBUXQuK9cf/DrR/oN2bJ5wm5rTKbJFCnaWYx0lwFmcfI3oUzKIIxfLJITL9RbIpYgFTlTLBbut5P+EbI3GcIfrS9n+7apIk7+67IG6gBZQsZRanWZhEjtRWg+8JVXzy3lpfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723217878; c=relaxed/simple;
	bh=U2pCY2N3WnN5sCm6RC+jq8Q2UPwvWJ18ZQEGvDhb17s=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=QpINB1vh1DSB718tCYGRDKvLHwqX4LB4siY2rORIl4p4dEKiwJOros8T0cn1PpNjQQTuypb5SF71JFtSsHPdyo5uH/DktuC0iyh2SLfet+ZndpjQsK1H0MiFI028Wd+tFTnuSkW8Z64op3FeiB3oPdq1QhzOBgMUWP3hXiGgYZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eqVS2vCV; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqVS2vCV"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-428e0d184b4so14743075e9.2
        for <git@vger.kernel.org>; Fri, 09 Aug 2024 08:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723217874; x=1723822674; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SgGlmrXIHYvUtdMOgjeby3huyy9bif67kYYgdG8pz8k=;
        b=eqVS2vCVKZrfCcBwhwlsc8FLKXhL53+cg+XN0X5K5b7n4XbTbXAFTbjxvpNiXmwy/E
         dSh6aLcXsAcn3zBZjk/2GjYda7Xd6wbGRepRFevQKe2Tr3mTOD4BOe7IjInnOqnjLCG1
         gtiXTj4iNqanUqvObaT2+u202M1AKQKoZgMHdK9SZecQHMnfeSurpx3Alcvc9HH4JQQA
         n6d1ol9moLaSLb3pJwWPd6Q0T17FPnp3bEjEX3iFTzRdkAgTWJ15Ot4jRraja4XonMHp
         NZXbvEq+FfUhLy2R4WYvFrAXbP8h1+lR5sFcrkAQgM1nZYjMdLjZKrU3Rllr6jkvbKs9
         MO0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723217874; x=1723822674;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SgGlmrXIHYvUtdMOgjeby3huyy9bif67kYYgdG8pz8k=;
        b=hkG4MP8wGglVZSLVeGqgXpOekE+wAeXzGaW+uOS4wTs4JJ2CCQKNzqMdTNXxA/amqI
         4HnNQMP00f8fU9cXg+4Do3ZtIVLXhXmbaZlL0JuNnawZYjol8bvshc6Ke65I0UU7sOt8
         OXZKMQrLj0QEe+OaEaLwmJKYrAJiuP1nthT8PgHJT2WDqIxi9N0vOyIgaFFic/5QZ/R0
         qDLmHPxB4v58DbiwytzG/d9Js0djdGSTyBGuRNvjtVKeRxNdKOMrp9IFWHoRCrBS/hp4
         RZudV6RvP2bpiBVHxcdiAPFcrJfiyJjZlJQOPSOkJIXS7NmKR6+e1mLc/D7jTpSbt36+
         +ALA==
X-Gm-Message-State: AOJu0YzBavLZ1tWyXQYRf7KtEPb3uNrVTFrE/fhx9kbqdfIa4RcV+izj
	Ps8J7bnv6zyRq2gzl5c4NpFzY79FSOfXQZICnw+skF1vk+LbUF8g8yy5jQ==
X-Google-Smtp-Source: AGHT+IEsKNeVYygSq4GDZKTs5tw4BTlcBA7mAU3eJSn8SFdtD+9hErGqYIhUiLjwmvYWCX4VAeGMIQ==
X-Received: by 2002:a05:600c:1d8f:b0:428:1d27:f3db with SMTP id 5b1f17b1804b1-429c3a59fffmr13783805e9.35.1723217873698;
        Fri, 09 Aug 2024 08:37:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c7618b9sm82157345e9.30.2024.08.09.08.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 08:37:53 -0700 (PDT)
Message-Id: <pull.1712.v4.git.git.1723217871.gitgitgadget@gmail.com>
In-Reply-To: <pull.1712.v3.git.git.1723059768.gitgitgadget@gmail.com>
References: <pull.1712.v3.git.git.1723059768.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 09 Aug 2024 15:37:48 +0000
Subject: [PATCH v4 0/3] keep track of unresolved value of symbolic-ref in ref iterators
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Kristoffer Haugsbakk <code@khaugsbakk.name>,
    Jeff King <peff@peff.net>,
    Patrick Steinhardt <ps@pks.im>,
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <avila.jn@gmail.com>,
    Linus Arver <linusarver@gmail.com>,
    John Cai <johncai86@gmail.com>

For reftable development, it's useful to be able to print out the direct
value of a symbolic reference before resolution. This is currently possible
with git-for-each-ref, but since the iterators do not keep track of the
value of the symbolic ref, a separate call needs to be made each time making
it inefficient.

Address this inefficiency by keeping track of the value of the symbolic
reference in the ref iterator. This patch series also ends with a commit to
use this value in the iterator through callbacks in ref-filter.c.

This series started with [1] but I decided to send a separate patch series
since it is substantially different.

Benchmarking shows that with these changes, we experience a speedup in
git-for-each-ref(1) on a repository with many symbolic refs:

$ hyperfine --warmup 5 "git for-each-ref --format='%(refname) %(objectname)
%(symref)'" "~/Projects/git/git for-each-ref --format='%(refname)
%(objectname) %(symref)'" Benchmark 1: git for-each-ref --format='%(refname)
%(objectname) %(symref)' Time (mean ± σ): 905.1 ms ± 13.2 ms [User: 56.3 ms,
System: 628.6 ms] Range (min … max): 893.4 ms … 936.9 ms 10 runs

Benchmark 2: ~/Projects/git/git for-each-ref --format='%(refname)
%(objectname) %(symref)' Time (mean ± σ): 482.2 ms ± 26.4 ms [User: 34.7 ms,
System: 410.6 ms] Range (min … max): 459.4 ms … 541.8 ms 10 runs

Summary ~/Projects/git/git for-each-ref --format='%(refname) %(objectname)
%(symref)' ran 1.88 ± 0.11 times faster than git for-each-ref
--format='%(refname) %(objectname) %(symref)'

Changes since V3:

 * Added blank line to separate declarations from statements
 * unconditionally set referent member in base iterator in files backend

Changes since V2:

 * Style tweaks
 * Added a NEEDSWORK comment around fallback code
 * Stay consistent in the meaning of a non-NULL referent member in the
   iterator

Changes since V1

 * Use the return value from refs_resolve_ref_unsafe instead of using an out
   parameter

 1. https://lore.kernel.org/git/pull.1684.git.git.1709592718743.gitgitgadget@gmail.com/

John Cai (3):
  refs: keep track of unresolved reference value in iterators
  refs: add referent to each_ref_fn
  ref-filter: populate symref from iterator

 bisect.c                    |  3 ++-
 builtin/bisect.c            |  4 +++-
 builtin/checkout.c          |  2 +-
 builtin/describe.c          |  2 +-
 builtin/fetch.c             |  3 ++-
 builtin/fsck.c              |  4 ++--
 builtin/gc.c                |  1 +
 builtin/name-rev.c          |  2 +-
 builtin/pack-objects.c      |  5 +++--
 builtin/receive-pack.c      |  2 +-
 builtin/remote.c            |  4 +++-
 builtin/repack.c            |  1 +
 builtin/replace.c           |  1 +
 builtin/rev-parse.c         |  4 ++--
 builtin/show-branch.c       |  8 ++++----
 builtin/show-ref.c          |  3 ++-
 builtin/submodule--helper.c |  1 +
 builtin/worktree.c          |  1 +
 commit-graph.c              |  1 +
 delta-islands.c             |  2 +-
 fetch-pack.c                |  2 ++
 help.c                      |  2 +-
 http-backend.c              |  4 ++--
 log-tree.c                  |  2 +-
 ls-refs.c                   |  4 ++--
 midx-write.c                |  2 +-
 negotiator/default.c        |  2 +-
 negotiator/skipping.c       |  2 +-
 notes.c                     |  2 +-
 object-name.c               |  2 +-
 pseudo-merge.c              |  1 +
 reachable.c                 |  2 +-
 ref-filter.c                | 17 ++++++++++++-----
 reflog.c                    |  1 +
 refs.c                      | 14 +++++++-------
 refs.h                      |  2 +-
 refs/files-backend.c        | 17 +++++++++++++----
 refs/iterator.c             |  4 +++-
 refs/ref-cache.c            |  5 +++++
 refs/ref-cache.h            |  2 ++
 refs/refs-internal.h        |  1 +
 refs/reftable-backend.c     | 10 ++++++++--
 remote.c                    |  4 ++--
 replace-object.c            |  1 +
 revision.c                  |  2 +-
 server-info.c               |  2 +-
 shallow.c                   |  2 ++
 submodule.c                 |  2 ++
 t/helper/test-ref-store.c   |  2 +-
 upload-pack.c               |  8 ++++----
 walker.c                    |  1 +
 worktree.c                  |  2 +-
 52 files changed, 118 insertions(+), 62 deletions(-)


base-commit: 557ae147e6cdc9db121269b058c757ac5092f9c9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1712%2Fjohn-cai%2Fjc%2Fsymbolic-ref-in-iterator-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1712/john-cai/jc/symbolic-ref-in-iterator-v4
Pull-Request: https://github.com/git/git/pull/1712

Range-diff vs v3:

 1:  fc3defd9c47 ! 1:  c4f5f5b7dd8 refs: keep track of unresolved reference value in iterators
     @@ refs/files-backend.c: static void loose_fill_ref_dir_regular_file(struct files_r
       {
       	struct object_id oid;
       	int flag;
     --
     --	if (!refs_resolve_ref_unsafe(&refs->base, refname, RESOLVE_REF_READING,
     --				     &oid, &flag)) {
      +	const char *referent = refs_resolve_ref_unsafe(&refs->base,
      +						       refname,
      +						       RESOLVE_REF_READING,
      +						       &oid, &flag);
     + 
     +-	if (!refs_resolve_ref_unsafe(&refs->base, refname, RESOLVE_REF_READING,
     +-				     &oid, &flag)) {
      +	if (!referent) {
       		oidclr(&oid, the_repository->hash_algo);
       		flag |= REF_ISBROKEN;
     @@ refs/files-backend.c: static int files_ref_iterator_advance(struct ref_iterator
       		iter->base.refname = iter->iter0->refname;
       		iter->base.oid = iter->iter0->oid;
       		iter->base.flags = iter->iter0->flags;
     -+		if (iter->iter0->flags & REF_ISSYMREF)
     -+			iter->base.referent = iter->iter0->referent;
     -+		else
     -+			iter->base.referent = NULL;
     ++		iter->base.referent = iter->iter0->referent;
      +
       		return ITER_OK;
       	}
     @@ refs/iterator.c: static int merge_ref_iterator_advance(struct ref_iterator *ref_
       			iter->base.flags = (*iter->current)->flags;
      
       ## refs/ref-cache.c ##
     -@@
     - #include "refs-internal.h"
     - #include "ref-cache.h"
     - #include "../iterator.h"
     -+#include "../strbuf.h"
     - 
     - void add_entry_to_dir(struct ref_dir *dir, struct ref_entry *entry)
     - {
      @@ refs/ref-cache.c: struct ref_dir *get_ref_dir(struct ref_entry *entry)
       }
       
 2:  0b6e732ad7e = 2:  6cfac5e51f5 refs: add referent to each_ref_fn
 3:  83b70ab8287 = 3:  9f609f4d0f5 ref-filter: populate symref from iterator

-- 
gitgitgadget
