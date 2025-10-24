Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC01123505E
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 08:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761295099; cv=none; b=ZLZmP97V5pEWGlxq8atRSDtpwZJ28FNtX3ikh36gBAmUH06/8boQ7Ou4QJE8tbPvONJj/rJw/amE/Q2nxAcJKI9Hmo0V4d/xqfXgoZ+PF9irFqBztwaU6o0MInHUHfFVp8kwaJoGhAy0VpE6LqDavx7CLLE49iIW+/Z4vxEqhCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761295099; c=relaxed/simple;
	bh=0du0eazVZmvQVa75/RIYUcw0ZE+CVr/cJrU6MbKgMxs=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=lV+EQ54nWd9pIiu/4KkMMpig6Ez4LSCL9Y3Q0kspxgC9s7gUCirG+Drtot/KHEWP9ROBZaLqeMr6kveXvUQu91MRtu5W6Q1kV1YRCtLV8gAIo82/YO38HzYh4Zhun2AZMebgziTU+SJWNxegG886JQRyRbDWhtyxeMrBJdGKH9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/Ku+jnc; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/Ku+jnc"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8909f01bd00so187004385a.0
        for <git@vger.kernel.org>; Fri, 24 Oct 2025 01:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761295096; x=1761899896; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/LfS6Qj9th7O+UAGS/KZHqtxynGgNhMsUCmexhCHEkg=;
        b=N/Ku+jncOf9TKIsHTWY8+BLxZ3fJNiof9PSBNboQE9cSHqQMlQy0zQl9x2lVcnEJZr
         Ha3fjPiUqKwsr6q8sNEtXarZZjqC2pENzL5egaQbfET9SMtEVwLs0MvMJzdyfC/Bgflh
         GmYnUhkUF5DxFkemiShJoYr+HorR4enMhytHTMPV+wxYZXY9uHn6Hq6m4xL59eoI4vvr
         5DfAq0RevXIt0BZnTe7CG+dssu6xkqMfeQR9Zr7F3jP0R1HKuYaj8rF9EFwFSQBeZUIa
         Vz5dhPzg3RawTqDdO+/waVK0bpTW/xRQFZv3Hok5lC41Gz6LdHW+2ENpBNV8y1+QMPjG
         /YVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761295096; x=1761899896;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/LfS6Qj9th7O+UAGS/KZHqtxynGgNhMsUCmexhCHEkg=;
        b=KJdgFBi6Sbv8BceGqImqNFSNYNY0Gjq7Yyx2Wbg4Zq4iFeDNc8zXol1gWwD5VQbI/f
         F78JlWXgiscXbzMgv09MV2w1c0yNN9LQLGrS9m6VeeiavOP2EdgavhpkQCP9OdyS8QEa
         WbJGtwEWAnEZhGD9TGXHYazjYoRsRHQbYB+6W1oL9gLgITibYTPVT86kYE6ned3wRNYK
         7jxbl1nfTD29wi2UN1HEE/pzRr6Rh0guwiWrHlSW9KGp9TB6eGuD64q9b6CITRV7P6tg
         Qz1A6m3ULGkkhn7AhapcrwAcJPxBTLNTlMqMuwCgDn8WLXaV900bj/p7nhJPwDorM+4I
         vy5g==
X-Gm-Message-State: AOJu0Yxpuyry6UAQZX4xctChSnWhOuntn8eMX0emf/UlHrHPb4CSYW7r
	WePCs7qhfMPCxlfMABV5SK5UE0EAxzh27W1Ezv1BsYNjDo7QhrU8jcNNHz+wkQ==
X-Gm-Gg: ASbGncsF1sygPXSgvyCFclz5rLkVHuuHfewUeoMlRh/pGZX76ZCYj3MCaKD0HJpa4Rv
	LGZRNiISnJ/Vh8X++OfCn9wFhBihMBcM4aeFQ4JQGHexJKKD9GggcbGVEgQoRuqiOWk8AGJdLoS
	kLA8QG8ltgyPdofB/DZuP6jqHGNewxRL8Wj4UeMxhUeP/3Z/kUnodOfvLmv11xKNqgoYyznbpO0
	vllpbDW9q6gHuDP3OvYo1SHs9zudWgazmsOwUzg0cqpinLvEQMtj/3J6Pb8ZlkIdwUcqwaO91k0
	SqZouG/5DuGgva3lqOBXJqeLnQ1gH4O84DP1G2cVIVIHeObkyHWHHi0gsFeOH31TnSqAT6tS3O9
	KdG8GkHT6wg4979meYVWsLiYFOj9sYojohh4rtePSaYNoW6NVVpRNEfwatHR43+03cKka+BBkrl
	fMGCbLNmiXne5dVVA=
X-Google-Smtp-Source: AGHT+IF3kddasSqI7dqYfUkTXlHvdFOYm3l8nJstMP8InHsvZnFea1Ydsv/YVa3IWbTarp/fts4Dfg==
X-Received: by 2002:a05:620a:29c9:b0:891:74fa:661a with SMTP id af79cd13be357-89dc03762e9mr156822885a.36.1761295096009;
        Fri, 24 Oct 2025 01:38:16 -0700 (PDT)
Received: from [127.0.0.1] ([145.132.102.101])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89c0dbcd225sm342456085a.12.2025.10.24.01.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 01:38:15 -0700 (PDT)
Message-Id: <pull.2082.git.git.1761295094982.gitgitgadget@gmail.com>
From: "RuanXinyu via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 24 Oct 2025 08:38:14 +0000
Subject: [PATCH] refs: add missing remove_on_disk implementation for debug
 backend
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
Cc: RuanXinyu <1096421257@qq.com>,
    RuanXinyu <r200981113@gmail.com>

From: RuanXinyu <r200981113@gmail.com>

The debug ref backend (refs_be_debug) was missing the remove_on_disk
function pointer, which caused a segmentation fault when running
'GIT_TRACE_REFS=1 git refs migrate --ref-format=reftable' commands.

Signed-off-by: Xinyu Ruan <r200981113@gmail.com>
---
    refs: add missing remove_on_disk implementation for debug backend

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2082%2FRuanXinyu%2Ffix-refs-trace-migrate-error-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2082/RuanXinyu/fix-refs-trace-migrate-error-v1
Pull-Request: https://github.com/git/git/pull/2082

 refs/debug.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/refs/debug.c b/refs/debug.c
index da300efaf3..dd49080836 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -48,6 +48,14 @@ static int debug_create_on_disk(struct ref_store *refs, int flags, struct strbuf
 	return res;
 }
 
+static int debug_remove_on_disk(struct ref_store *refs, struct strbuf *err)
+{
+	struct debug_ref_store *drefs = (struct debug_ref_store *)refs;
+	int res = drefs->refs->be->remove_on_disk(drefs->refs, err);
+	trace_printf_key(&trace_refs, "remove_on_disk: %d\n", res);
+	return res;
+}
+
 static int debug_transaction_prepare(struct ref_store *refs,
 				     struct ref_transaction *transaction,
 				     struct strbuf *err)
@@ -432,6 +440,7 @@ struct ref_storage_be refs_be_debug = {
 	.init = NULL,
 	.release = debug_release,
 	.create_on_disk = debug_create_on_disk,
+	.remove_on_disk = debug_remove_on_disk,
 
 	/*
 	 * None of these should be NULL. If the "files" backend (in

base-commit: 81f86aacc4eb74cdb9c2c8082d36d2070c666045
-- 
gitgitgadget
