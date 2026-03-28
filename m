Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39EA301460
	for <git@vger.kernel.org>; Sat, 28 Mar 2026 14:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774707158; cv=none; b=HkSexoXUJkJbB0fAegjj7yK6Jvbo3SJ4dwGnNpuP1Nju/hmhZz1wwoacZW0UwnoAUMgrVmJn+lDokI6X3buGtdmbgJu2DvsAQvyiXb8gza/4FfaIbpHqYCrQYz6xOV+sMTSjbpUTnxEafsVBWNTTO3o4pNCfkMvylpoMLZZYvos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774707158; c=relaxed/simple;
	bh=/nrU60v5QPLz+YHRvvl9WgogY4cPLn9wx46INY/aLZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RAohSM2tZAKsxxpuVXAtp007lojupMJ8Ll4dOSad+IhhL+b9IcsWGwqAmx1z55N6Diltm5VpJk9dAHxHhtkixczJOiJULsUqfU5ver9cDUGnF2HAzhkCPxyasN8Ff26GvEa+qMRcjIZozEjavuvlL2vzHfK/wABqNioyjTzRR+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M0kL/3Qw; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M0kL/3Qw"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a871daa98fso23822485ad.1
        for <git@vger.kernel.org>; Sat, 28 Mar 2026 07:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774707156; x=1775311956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AtjNgTJyslb/ba0Olsnlk72evZ2RNvNcD4uEwRzAo7Q=;
        b=M0kL/3QwjdYOcHCOhhrIgiD9udI9jTENSmMAmCL3ukO6JUlBPRQmKET6oNplCSJziq
         odcoUpA2vTwDs0lk5y9srbWDVQnMJDgctyYqWrFAK33jq9Hq2wbsCIJd3HabYHVGtzTg
         iSbpQKDG8mESx0LdclWJGRdR9Cc12h5h02raRUACBtiInmTVQJP02A3Gl6WfnZUOoqpN
         NzrDKEFz2OXCiWxYq7Dj1lUaQqlp22rzIEf+8/bnZ1hZ5TtcBpQt6icvpbKzd/yMWEpL
         0dVysVZKDevPijuB5kIQ7xCjEM8hGICmMBbxLyjYZ8O6wYFQ/5YSadVa6FeFHa8VDxhL
         6D0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774707156; x=1775311956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AtjNgTJyslb/ba0Olsnlk72evZ2RNvNcD4uEwRzAo7Q=;
        b=fmymkIYlgTVezgVRYC1JLOYYOuhM1nwcQXaA8FYFJVbDrsgs5tEuvHWx7yfKsGfpH8
         dv3o6VPVM8UY5hCjS7Y5PFHuu54XesxPkR3EBXt3FyqBAnLxsDUwNgiJD3VL6g6yYNdC
         5vEoHcJvkcfokbHG03fa3zNPTIKGDH/ld4JHMQqM6s6RB4PGxbc/jaUNCAk3jd9bwF6j
         ngNtbIr4ytTVy/ZULL+FyMB2/lFsFvU/tPoXHmiGaSQaQAhkQBzbdysH+9UVE+diSdzP
         2cL+8Go+bE2yet4TuWyGNsHYnSXTN5sE8EuVybMn0iK0gKgc9+ahQmJ9zcTujsYw8u+J
         9IXA==
X-Gm-Message-State: AOJu0YwxqlMo+A9cmRIAON3QNw3fhsbqOf2zxhrVxcPzkXnbsN0ILpX5
	C76Z4PGVjdWaK/aca3Uk+fsMkpTpRzrLgOVhhS8OOjf3sWLigrDtXd81caPHvw==
X-Gm-Gg: ATEYQzxT07O8t4TMI7ar/uvkhRUL3vU1sy3PbiY/RVrYFcvRNeDIr4c/XvakLRQ+Mfu
	FnlrIOwtL5QIyY2B6XzOGTNYX4jXSr2WyP1iVaUq9eiv1uZqOvPbwKVEdO8HQ1M84ntx7uDx+jB
	xjn0XhlwlXnLQ//vblM/aGKxI3Gn7BUAK0XkVOW+IsYxe7CmlGDh76+XMHNeoWubmotlGHLKd6U
	mLP4rLHkAwXhJt0bRjE3TI/xMAMy+eg8CRvsMRccG5HiXWGJQ3AOaI7CfBXFWGh6pcG8GuNDCbg
	HrJ9+XyLyb34u6tPb8O5xe1nlDMmVc4bX3/aUrO3rOlVZiCP/z1mEvNSpN32BCnMYmAJr86VmpZ
	Q2Od0uE+s5CFO6uIQlTL/gBlVR7IDlE4ibTBiTsB8nwE2RX3c/Z3vBPOkuC0Gvb9OW7AnhEtIL5
	dmUWrkZvb9zyPsXoQuvGB82G876ejmiazN/26s3UDnUA==
X-Received: by 2002:a17:903:2b0b:b0:2b2:4697:78fa with SMTP id d9443c01a7336-2b246977e18mr15325455ad.44.1774707155734;
        Sat, 28 Mar 2026 07:12:35 -0700 (PDT)
Received: from Shreyansh-PC ([2401:4900:88eb:4aec:1b3c:5de4:c8b:1b79])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2427a27f2sm33173855ad.67.2026.03.28.07.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 07:12:35 -0700 (PDT)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Subject: [PATCH v2 3/5] refs: remove the_hash_algo global state
Date: Sat, 28 Mar 2026 19:39:34 +0530
Message-ID: <20260328141146.1095115-4-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260328141146.1095115-1-shreyanshpaliwalcmsmn@gmail.com>
References: <20260325164833.1216577-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260328141146.1095115-1-shreyanshpaliwalcmsmn@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

refs.c uses the_hash_algo in multiple places, relying on global state for
the object hash algorithm. Replace these uses with the appropriate
repository-specific hash_algo. In transaction-related functions
(ref_transaction_create, ref_transaction_delete, migrate_one_ref, and
transaction_hook_feed_stdin), use transaction->ref_store->repo->hash_algo.
In other cases, such as repo_get_submodule_ref_store(), use
repo->hash_algo.

This removes implicit reliance on global state. With no remaining uses of
the_repository in this file, drop USE_THE_REPOSITORY_VARIABLE and the
dependency on environment.h.

Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
---
 refs.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/refs.c b/refs.c
index 2f8c8427cd..54ca87eda9 100644
--- a/refs.c
+++ b/refs.c
@@ -2,13 +2,10 @@
  * The backend-independent part of the reference module.
  */
 
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "advice.h"
 #include "config.h"
-#include "environment.h"
 #include "strmap.h"
 #include "gettext.h"
 #include "hex.h"
@@ -1472,7 +1469,7 @@ int ref_transaction_create(struct ref_transaction *transaction,
 		return 1;
 	}
 	return ref_transaction_update(transaction, refname, new_oid,
-				      null_oid(the_hash_algo), new_target, NULL, flags,
+				      null_oid(transaction->ref_store->repo->hash_algo), new_target, NULL, flags,
 				      msg, err);
 }
 
@@ -1491,7 +1488,7 @@ int ref_transaction_delete(struct ref_transaction *transaction,
 	if (old_target && !(flags & REF_NO_DEREF))
 		BUG("delete cannot operate on symrefs with deref mode");
 	return ref_transaction_update(transaction, refname,
-				      null_oid(the_hash_algo), old_oid,
+				      null_oid(transaction->ref_store->repo->hash_algo), old_oid,
 				      NULL, old_target, flags,
 				      msg, err);
 }
@@ -2379,7 +2376,7 @@ struct ref_store *repo_get_submodule_ref_store(struct repository *repo,
 	subrepo = xmalloc(sizeof(*subrepo));
 
 	if (repo_submodule_init(subrepo, repo, submodule,
-				null_oid(the_hash_algo))) {
+				null_oid(repo->hash_algo))) {
 		free(subrepo);
 		goto done;
 	}
@@ -2571,14 +2568,14 @@ static int transaction_hook_feed_stdin(int hook_stdin_fd, void *pp_cb, void *pp_
 	strbuf_reset(buf);
 
 	if (!(update->flags & REF_HAVE_OLD))
-		strbuf_addf(buf, "%s ", oid_to_hex(null_oid(the_hash_algo)));
+		strbuf_addf(buf, "%s ", oid_to_hex(null_oid(transaction->ref_store->repo->hash_algo)));
 	else if (update->old_target)
 		strbuf_addf(buf, "ref:%s ", update->old_target);
 	else
 		strbuf_addf(buf, "%s ", oid_to_hex(&update->old_oid));
 
 	if (!(update->flags & REF_HAVE_NEW))
-		strbuf_addf(buf, "%s ", oid_to_hex(null_oid(the_hash_algo)));
+		strbuf_addf(buf, "%s ", oid_to_hex(null_oid(transaction->ref_store->repo->hash_algo)));
 	else if (update->new_target)
 		strbuf_addf(buf, "ref:%s ", update->new_target);
 	else
@@ -3153,7 +3150,7 @@ static int migrate_one_ref(const struct reference *ref, void *cb_data)
 		if (ret < 0)
 			goto done;
 
-		ret = ref_transaction_update(data->transaction, ref->name, NULL, null_oid(the_hash_algo),
+		ret = ref_transaction_update(data->transaction, ref->name, NULL, null_oid(data->transaction->ref_store->repo->hash_algo),
 					     symref_target.buf, NULL,
 					     REF_SKIP_CREATE_REFLOG | REF_NO_DEREF, NULL, data->errbuf);
 		if (ret < 0)
-- 
2.53.0

