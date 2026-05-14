Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E030335555
	for <git@vger.kernel.org>; Thu, 14 May 2026 16:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778775933; cv=none; b=deQlQ+ntucfykuJXLd1H2+tvJWSbr7DD+4SuZQJXwzDH1ioahYh7gSVji9Qvn19bFWryZYvdjihQsUJf8LdQrVeOo3TjbG7pGYragXoiQ/ydNRfLsTCwo9VXl0MDTweMVlLnYlXYgfBZWYPFKb0NRfcW30Ha3CRAun8iSigDc+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778775933; c=relaxed/simple;
	bh=/ItUo6QM5nG/RVXz8BFsd90humFf3Xs52FQbt3qibz4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=n0L0gmz49j6M9jFfI+zcQgc/7foR34Vura51JCuXRNq0/TEj26A+mZCD+0RoIU7HT2cCS/rPaaqR69VmmRNjn6MkBRWWn7Do5ZsYs1FX6AOjEozku5zclx5XtYwK+1ULXMNwdSEgF767//QUsWfBtKNOOftEXjHsHr9jZqik+Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fJSvAJuB; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJSvAJuB"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-366330b6751so5574749a91.1
        for <git@vger.kernel.org>; Thu, 14 May 2026 09:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778775932; x=1779380732; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pCqGHb+QsReGeYaILheX8f7gtHRqYgtXNEplvToi9oo=;
        b=fJSvAJuBbQYC2MGFapKWRP1xxTPienQQE2cv9wyt51bgBnHJRp0h7uWXbToslL6+6G
         XMgKFJBxPrZgb2WGE0JJh2YxUcoct7IBtyKbbjv9U/7GTi3PQsbNekmCZjiQP4aOkpTK
         MewJNbLsJYpZ+zg/kpQgLZsMPnSPnIJjnQfKOD5FQHkkbgf96+C6Zc41ENhdlBSedQpG
         P50xUcWuqL8Y14lB7yTXBPLzvEjqcMOKWgQ9cSAByjM/p+DuHpTwJdLT2z7PQygXEp0z
         Yo0qLumvxd2BTdjSowwbVzq4j9oPqHGFWsc+g3vySWpFj6lUYMOAzDGBsstt0rsXEdxl
         qQgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778775932; x=1779380732;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pCqGHb+QsReGeYaILheX8f7gtHRqYgtXNEplvToi9oo=;
        b=QS7pS6Uh4I9yxogkz0QdriB3eWuwueLuLXratQcNQn45ZR5W6+mRpBXOGJcaT3PxI8
         r5hTeq3BuMKu2qunJCGtov7O3Ne7/Q1dkEGqAT3Yc2X0hqGClf15znrKTzyp5x+TgG0f
         mx/9fRyCNKhPVnG0fff+JnZmgwU+1bDWVWGUcSJFg0k+6uju3hT0DIVTiwvHx/G0IzvG
         o1TUK4EZpYkLFcFJoK+UXvrtd1wlCHN0q3ePN2vNisek4/0B3h2ZrVS6L64juf9V8Dfw
         DhjxWI1SJHtv3ypeZd5nccQ3mP4Zm9KY9olMDzp/1iZGg3uXDPSVoW6MIromS+kqSAcz
         OWOA==
X-Gm-Message-State: AOJu0YxiUl0csYRVf11GVikBz0/oU5/XpQWetwAF00UDEy76Je6knhCd
	v/I6cCupyR3YRfSAy9VLIyIKlX5B0u5oNVruD5UsV6AHIh1gFmCwfaLhRNQkFw==
X-Gm-Gg: Acq92OEJg9raeg84XKptqCz1/aZI6a7017cD63RcO4PhcF3cCP1cNvSoVfya7Y7gnyt
	Q6q10b3yM/sjVrJ6rOPdmIml+ceC/pegsX7AllY5a1913ojPcvHR9jIKjyR0rPWhrN//j0kQbpp
	O7ArEE+UBrK2LVXiCfSVpAii1oo3NVNk52xceOF1MIyzgDSWkQV+qCLq7mW3m3hDfYHYGlfcu4Z
	l57cUZKCk4sfR4mNZLacRFx3DMII4IkYPhl47t+D3UhXkxg1YZpVBv8Z2VpcTyrOwp3jxM7hO40
	TzjRgMscJp0QNV4eT57yykGrWncArIJU5lEy6LsCO/uL3dF291YUPSpRNcWVwRIU75wWA+AI3ok
	uV5tspk4Y8uAzuZPSNa1935Jq4FtWoccNEjunz1cUFlisnQ44xEhFxuwRQxizt0noNYeC11CHob
	Zc3QwtJ/UVIvlu3nGiB0K3jfp4
X-Received: by 2002:a17:90b:3d82:b0:366:4adc:c51a with SMTP id 98e67ed59e1d1-36951a10fefmr132457a91.11.1778775931537;
        Thu, 14 May 2026 09:25:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.66.174.86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d11d6easm32382865ad.72.2026.05.14.09.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 09:25:30 -0700 (PDT)
Message-Id: <6ad11e2c28d9c3b3d5dcb8986b726d2d2db18cc3.1778775928.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2089.v3.git.1778775928.gitgitgadget@gmail.com>
References: <pull.2089.v2.git.1776472347.gitgitgadget@gmail.com>
	<pull.2089.v3.git.1778775928.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 14 May 2026 16:25:25 +0000
Subject: [PATCH v3 1/4] promisor-remote: document caller filtering contract
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
Cc: Elijah Newren <newren@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Derrick Stolee <stolee@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

promisor_remote_get_direct() does not, on its happy path, filter out
OIDs that are already present in the local object store: every OID
the caller supplies is written to the fetch subprocess's stdin and
ends up in the response pack.  The only filtering it performs is in
remove_fetched_oids(), and that only runs after a fetch failure when
falling back to a different configured promisor remote.

Almost every existing caller already filters locally-present OIDs out
itself (typically with odb_read_object_info_extended() and
OBJECT_INFO_FOR_PREFETCH, or odb_has_object() with no fetch flag).  But
the existing API comment does not state this expectation, so a new
caller is easy to write incorrectly (I missed this originally and wrote
two problematic callers).  Omitting the filter still "works" in the
sense that the desired objects end up local, but it silently makes the
fetch request -- and the response pack -- larger than necessary,
defeating part of the point of batching.

Spell the contract out so future callers know to filter (and
deduplicate) themselves, and point them at the helpers they should
use to check local presence without accidentally triggering a lazy
fetch.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 promisor-remote.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/promisor-remote.h b/promisor-remote.h
index 3d4d2de018..301f5ac5cb 100644
--- a/promisor-remote.h
+++ b/promisor-remote.h
@@ -29,6 +29,17 @@ int repo_has_promisor_remote(struct repository *r);
  * Fetches all requested objects from all promisor remotes, trying them one at
  * a time until all objects are fetched.
  *
+ * Callers are responsible for filtering out OIDs that are already present
+ * locally before calling this function: every supplied OID is sent in the
+ * fetch request, even if the object already exists in the local object
+ * store. (Only after a fetch failure does this function fall back to
+ * stripping already-present OIDs from the list before trying the next
+ * configured promisor remote.) Callers should also deduplicate the OIDs.
+ *
+ * To test for local presence without triggering a lazy fetch (which would
+ * defeat the purpose of batching), use odb_has_object(..., 0) or
+ * odb_read_object_info_extended() with OBJECT_INFO_FOR_PREFETCH.
+ *
  * If oid_nr is 0, this function returns immediately.
  */
 void promisor_remote_get_direct(struct repository *repo,
-- 
gitgitgadget

