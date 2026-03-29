Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEBA275B1A
	for <git@vger.kernel.org>; Sun, 29 Mar 2026 10:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774779490; cv=none; b=KpTJ3IW6iAjH3h5toVxzBBoQJYMd1JURLSsB1DFrt7zedXcB0XcC5hp6WCmgKgZAtJwQ3FYWiST6j3yT4zY9wCITkkRfm0aPBCDSEoOMn9ZCGTr0vfdb1iUZ/xob5rVFne2lphHL7wrbbCWJEQegMFxpSBmERTyxuX9VbMkKmCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774779490; c=relaxed/simple;
	bh=FMCtFJmpm39xY+mwKXr44y8FcgThpizWsoSnOuYlV+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nv9ib8Mg4fgeHdmLzxnxdT0QT6weOb/s2xptjgw4mxozHWonPCSYg7drAr0sxHofE6n2Yk7NiysQXfl0cczTs+PVfDmkKtfJQBAPzNr1ApOfKejFYuFWF8m5zL+gBIPxRloTQilvX2dwZ3iZHdlhv7taxhWn5032/IsoBq9k/yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fvzlDQCC; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvzlDQCC"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ad617d5b80so23932875ad.1
        for <git@vger.kernel.org>; Sun, 29 Mar 2026 03:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774779488; x=1775384288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=liU7z2jClfphzOjlhP+dLwawT//1e8rt3k26slAczoU=;
        b=fvzlDQCCXluBDPYeaRy5/opFW/sb+p8Y0ROe6nwLRpPPhNvVFC8EcKTWBs63a03iKS
         KU3DNpgwGlLNgCre1/6cmBVZyEoN0T0yx08fx7SaKwBjhhrhb/spTfMsYHr1y3xwYV/z
         stagafuK7dBTBICkkxM76qWOUKPuIlKlRmSLAikzyoPcpZ6uE47y/gLJnwAr+cqlSKY1
         7J5xMXcNmGuBLgfSRXxeVJwud89izrVibouPRy2fSZbGvp8oEv9f002xiq667nwR96Uj
         XgVGjiudedjEAnv3rDxgmdqzNZjcRwg+7Vxh7+E160bLaxntWMXwshgegqJjBAkQbtHp
         6rsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774779488; x=1775384288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=liU7z2jClfphzOjlhP+dLwawT//1e8rt3k26slAczoU=;
        b=mkm5Y0vqnhAQHGqwW0ntZU2MdSP6tOv6Pm32ojg/s+Y4KeKduAuARQG0RydhWee/Zb
         hzehWnm17qgE2JiJsTuvozOM1ugg0140VyNKbmOwpM7HdVKrWcQiEojR0xayClAeHJy+
         Y6Aq9Ahj8dwZIXSAewDGDn5s8G/ZcJdrr/Luze0uAYSmlJESyGZmLEVgclcEowY4fTUT
         Xd6TRVTVz6iUOOJtMsLpmlDV21KcS16ZHCHFVR0M7vdoqFdRG95TitfQW5MTlLXem9z/
         I05YKB0t5Se2OuTNetzDkGBmHWSEqo8Sg96HP6tZ9cr5IPaF3TAUCefMWtb6oifajJhO
         Gj1w==
X-Gm-Message-State: AOJu0YzUaW5/FyqZF3WlxwmKsD6dZ9llkSAM8wE9lE2TN9DQ57qY0cuu
	PndwPfDJbVo6Xn7ZQyaHYrBXGfVYSw37BxPAJ5UBLUW09Nr/apybizRgKrpLCw==
X-Gm-Gg: ATEYQzxbVjw+ryzwn+PCXYjbLXsbDw/D4TIGoG5CT5LJfa8uw1mlk6WM5pr+KcO2Hd5
	yZX9DHZgx5ET7xf+6xSd3uPvGrGJj89mBMsVUB8B1ByuGPjaXQYmWUzLWU6d+L806OYwfGfAThM
	cXgsrvuuC5VoO6gtNHlFNb00khj+mLe0lyNZy0CapzH0DDZTTiAvBOqcPkKLmUSVXQfvmqe6mT6
	LWuJyJ2KPG5tfGWUWTIM7BhxooWt5LTwT/cCLQpXHMAjHuoV5PV6IvSh1rEqnZGHijzDcLdH9sI
	Y0lpI3iEXvH3WX4IympmqMjaq/Wmqe46l6XteHvE53+f3f25oncvr0gLUaxQA65AWYwAr5KX3Yk
	q40yNkC+LBJ/9FNT8eA8jfNdUhxIBHq0sKlZLjvrRxYurn8Lb9t3Hq/yFUuwjwhTrvD1v5Fy7IE
	BRhEaXOB4yKkNxIjezwUjdjeP3hwhd+XWSXUfQltQJ3qU=
X-Received: by 2002:a17:903:a86:b0:2b0:7177:d5e7 with SMTP id d9443c01a7336-2b0cdcc82b6mr89044465ad.31.1774779487622;
        Sun, 29 Mar 2026 03:18:07 -0700 (PDT)
Received: from Shreyansh-PC ([2401:4900:88eb:4aec:6fcd:e3ea:7ddd:8d9b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b242679bb3sm46199185ad.30.2026.03.29.03.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 03:18:07 -0700 (PDT)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Subject: [PATCH v3 0/5] replace the_repository with local repository instances
Date: Sun, 29 Mar 2026 15:46:38 +0530
Message-ID: <20260329101725.1092900-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260328141146.1095115-1-shreyanshpaliwalcmsmn@gmail.com>
References: <20260328141146.1095115-1-shreyanshpaliwalcmsmn@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series continues the effort to reduce reliance on the_repository
global state by making repository context explicit across the refs
subsystem. The patches focus on passing struct repository through various
ref helpers and backends, and replacing uses of global state such as
the_repository and the_hash_algo with the appropriate repository instance.

Patch 1/5: Making branch name helper functions (copy_branchname(),
check_branch_ref(), validate_branchname(), and validate_new_branchname())
repository-aware. (built on top of jw/object-name-bitset-to-enum)

Patch 2/5: Updating get_files_ref_lock_timeout_ms() to take a repository
and propagating it through files-backend, including callback paths.

Patch 3/5: Replacing uses of the_hash_algo in refs.c with the hash
algorithm from the appropriate repository.

Patch 4/5: Removing remaining uses of the_repository in reftable-backend.c
where a repository instance is already available.

Patch 5/5: Replacing the single instance of the_repository in
packed-backend.c, thus dropping the USE_THE_REPOSITORY_VARIABLE macro.

Shreyansh Paliwal (5):
  refs: add struct repository parameter to branchname helpers
  refs: add struct repository parameter in
    get_files_ref_lock_timeout_ms()
  refs: remove the_hash_algo global state
  refs/reftable-backend: drop uses of the_repository
  refs/packed-backend: use ref_store->repo instead of the_repository

 branch.c                   | 15 ++++++++-------
 branch.h                   |  5 +++--
 builtin/branch.c           | 14 +++++++-------
 builtin/check-ref-format.c |  3 ++-
 builtin/checkout.c         |  6 +++---
 builtin/merge.c            |  2 +-
 builtin/worktree.c         | 10 +++++-----
 refs.c                     | 28 +++++++++++++---------------
 refs.h                     |  4 ++--
 refs/files-backend.c       | 19 +++++++++++++------
 refs/packed-backend.c      |  3 +--
 refs/refs-internal.h       |  2 +-
 refs/reftable-backend.c    |  6 +++---
 13 files changed, 62 insertions(+), 55 deletions(-)

---
Changes in v3:
 - Fixed an import
 - better readability in patch 3/5

Changes in v2:
 - Made struct repository the first argument in function parameters.

Range-diff against v2:
1:  c0182252c4 ! 1:  5844440b73 refs: make branchname helpers repository aware
    @@ Metadata
     Author: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>

      ## Commit message ##
    -    refs: make branchname helpers repository aware
    +    refs: add struct repository parameter to branchname helpers

         copy_branchname() in refs.c relies on the_repository when calling
         repo_interpret_branch_name(), introducing an implicit dependency on global
    @@ builtin/branch.c: int cmd_branch(int argc,

      ## builtin/check-ref-format.c ##
     @@
    + /*
    +  * GIT - The information manager from hell
    +  */
    ++#define USE_THE_REPOSITORY_VARIABLE
    + #include "builtin.h"
      #include "refs.h"
      #include "setup.h"
    - #include "strbuf.h"
    -+#include "repository.c"
    -
    - static const char builtin_check_ref_format_usage[] =
    - "git check-ref-format [--normalize] [<options>] <refname>\n"
     @@ builtin/check-ref-format.c: static int check_ref_format_branch(const char *arg)
      	int nongit;

2:  857a8c40fe ! 2:  f7a9ea4204 refs: make get_files_ref_lock_timeout_ms() repostory aware
    @@ Metadata
     Author: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>

      ## Commit message ##
    -    refs: make get_files_ref_lock_timeout_ms() repostory aware
    +    refs: add struct repository parameter in get_files_ref_lock_timeout_ms()

         get_files_ref_lock_timeout_ms() calls repo_config_get_int() using
         the_repository, as no repository instance is available in its scope. Add a
    @@ Commit message
         is used as a callback, introduce a small wrapper struct to pass both struct
         lock_file and struct repository through the callback data.

    -    This removes reliance on the_repository global and makes the timeout lookup
    -    operate on the correct repository context.
    +    This reduces reliance on the_repository global.

         Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>

3:  46d5272aec ! 3:  00dba1a96a refs: remove the_hash_algo global state
    @@ refs.c: static int transaction_hook_feed_stdin(int hook_stdin_fd, void *pp_cb, v
      	else if (update->new_target)
      		strbuf_addf(buf, "ref:%s ", update->new_target);
      	else
    +@@ refs.c: struct migration_data {
    + static int migrate_one_ref(const struct reference *ref, void *cb_data)
    + {
    + 	struct migration_data *data = cb_data;
    ++	const struct git_hash_algo *hash_algo = data->transaction->ref_store->repo->hash_algo;
    + 	struct strbuf symref_target = STRBUF_INIT;
    + 	int ret;
    +
     @@ refs.c: static int migrate_one_ref(const struct reference *ref, void *cb_data)
      		if (ret < 0)
      			goto done;

     -		ret = ref_transaction_update(data->transaction, ref->name, NULL, null_oid(the_hash_algo),
    -+		ret = ref_transaction_update(data->transaction, ref->name, NULL, null_oid(data->transaction->ref_store->repo->hash_algo),
    ++		ret = ref_transaction_update(data->transaction, ref->name, NULL, null_oid(hash_algo),
      					     symref_target.buf, NULL,
      					     REF_SKIP_CREATE_REFLOG | REF_NO_DEREF, NULL, data->errbuf);
      		if (ret < 0)
4:  11aa886259 = 4:  5653c418e1 refs/reftable-backend: drop uses of the_repository
5:  c763732964 = 5:  18c1c67083 refs/packed-backend: use ref_store->repo instead of the_repository
--
2.53.0
