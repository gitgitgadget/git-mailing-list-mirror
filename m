Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB07171099
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 06:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718088134; cv=none; b=ixmIJWe8xRByf7BF7c1MGEuaIxs5kb8qNoKw5v3on85QS7zOJjj2AHFOViILpP4yYI2UADwIhJ8pcIlU3rdtbmWqhYjDyIwzSqXe+TkC+9TP6ACwhbojDsaf2gToz3X58H1tYtSV3SOFujrSEemON+OcpVnBzOIJaGOlbPJiuPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718088134; c=relaxed/simple;
	bh=XLb5xiWA4dAF2Fx/JHqqeBya6F3OqFt/2QpQOAIOTOo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ePW4xEP2bZS8SSepZbyODthF1Q94OFoVcrId3wIyoPbzAbrncGcssAquJpaGNSOlN/RAWsLK+ZSvsdGhQk+UuBcnzTu+jHOcjnnpBxCBbwJ59MiJfs0BzLFN0gXRaxVcHSnRNCXgV2F9dck7K6kxniq43/PtlWFfRG/mUhNCLXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gi1raEU2; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gi1raEU2"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-421bb51d81aso5754225e9.3
        for <git@vger.kernel.org>; Mon, 10 Jun 2024 23:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718088131; x=1718692931; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G968azMSMZxhGCb7WK9dg8PxA15ncjcjODXB2hpkuVM=;
        b=gi1raEU2S/qA1LcZONWAt6ndsIGXscLaODeHywmCcQTvbfz02o8H8UWoICtLP5sdRK
         Z/kf3PBebYqQiRXW1tg5TIeDRNrL3U9RlF0JR+rVOQIEaHIbV9MdN1xJGNN9DsvkAu+j
         U4uPcjOF2TsT1/EFJtPSdbIGfVhJNm7ygaotSLsWPebFfQ3z/aYcKDDW1lmfhG8icN/h
         r4dI93sJl8xrGSY/2N4Mt2Lb+tiu7Z0WwQIX6VUDqQ1Hi0g7PXX9IiYjjIEhCjs9m6UE
         TV+dqSxbvIhEiPfbqXTDiBqbZdX+GAlQGnphceiqPKW/03OyteS92DJWxbxx0J9Ovj9i
         pToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718088131; x=1718692931;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G968azMSMZxhGCb7WK9dg8PxA15ncjcjODXB2hpkuVM=;
        b=kXHKGCWVm8/GGewTSSsC1rAqyaU1bkkzB5vcGw24EFKOehn20ZdPECez/KrSf1z9W5
         EkFMZRWYF9XY391xvKUdfSylXvBqdtFDhA4R47rRjVK4Pv0FXqZimBqXYdwUxGtuKfnK
         QHA2b6cm3HUwT9MXhAcPb8XBMHBal8qa5FFAw5B+IE0OvLI0/Qd+//OR3lx93EfveBRk
         mZgwwLT0x2s/NNyPgGt/zU2eSUnIYs85T9FK2QO3wLsOhLMAuts/5AlBlHg6lSBih7bA
         NjQd7yN/7zk1+PjInXszy63zuKu8kMEWt+sm6G2dBSfYkzgrlYd9k/GVRmasmKY1sBCX
         hcYg==
X-Gm-Message-State: AOJu0YzgjahXFGvQ+hmtAXrU/sHwX6/ex4TDjZRL2GeGfYR9hCgnAbPl
	vmPN4vp5EcwO6ateOSdA7jTQSGzDs600feBKL6zIl657DCmZRxJNCrrlsA==
X-Google-Smtp-Source: AGHT+IHZqylbFHAYkEaxLJKsofvuYoSodPXp91MggVKq6p9K0Z1fT+y9LkSGZdeU5sW/IMH/XK64NQ==
X-Received: by 2002:a05:600c:3c83:b0:41c:13f6:206d with SMTP id 5b1f17b1804b1-42164a2e9d4mr101812695e9.25.1718088130772;
        Mon, 10 Jun 2024 23:42:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215c2c7396sm164915905e9.33.2024.06.10.23.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 23:42:10 -0700 (PDT)
Message-Id: <d21c236b8dec9fd8c81a4224c1f63c511b04d8b9.1718088127.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1730.v5.git.1718088126.gitgitgadget@gmail.com>
References: <pull.1730.v4.git.1717057290.gitgitgadget@gmail.com>
	<pull.1730.v5.git.1718088126.gitgitgadget@gmail.com>
From: "Xing Xin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 11 Jun 2024 06:42:04 +0000
Subject: [PATCH v5 2/4] fetch-pack: expose fsckObjects configuration logic
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
    Karthik Nayak <karthik.188@gmail.com>,
    blanet <bupt_xingxin@163.com>,
    Xing Xin <xingxin.xx@bytedance.com>

From: Xing Xin <xingxin.xx@bytedance.com>

Currently, we can use "transfer.fsckObjects" and the more specific
"fetch.fsckObjects" to control checks for broken objects in received
packs during fetches. However, these configurations were only
acknowledged by `fetch-pack.c:get_pack` and did not take effect in
direct bundle fetches and fetches with _bundle-uri_ enabled.

This commit exposes the fetch-then-transfer configuration logic by
adding a new function `fetch_pack_fsck_objects` in fetch-pack.h. This
new function is used to replace the assignment for `fsck_objects` in
`fetch-pack.c:get_pack`. In the next commit, it will also be used by
`bundle.c:unbundle` to better fit fetching scenarios.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Xing Xin <xingxin.xx@bytedance.com>
---
 fetch-pack.c | 17 +++++++++++------
 fetch-pack.h |  5 +++++
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 7d2aef21add..3acff2baf09 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -954,12 +954,7 @@ static int get_pack(struct fetch_pack_args *args,
 		strvec_push(&cmd.args, alternate_shallow_file);
 	}
 
-	if (fetch_fsck_objects >= 0
-	    ? fetch_fsck_objects
-	    : transfer_fsck_objects >= 0
-	    ? transfer_fsck_objects
-	    : 0)
-		fsck_objects = 1;
+	fsck_objects = fetch_pack_fsck_objects();
 
 	if (do_keep || args->from_promisor || index_pack_args || fsck_objects) {
 		if (pack_lockfiles || fsck_objects)
@@ -2046,6 +2041,16 @@ static const struct object_id *iterate_ref_map(void *cb_data)
 	return &ref->old_oid;
 }
 
+int fetch_pack_fsck_objects(void)
+{
+	fetch_pack_setup();
+	if (fetch_fsck_objects >= 0)
+		return fetch_fsck_objects;
+	if (transfer_fsck_objects >= 0)
+		return transfer_fsck_objects;
+	return 0;
+}
+
 struct ref *fetch_pack(struct fetch_pack_args *args,
 		       int fd[],
 		       const struct ref *ref,
diff --git a/fetch-pack.h b/fetch-pack.h
index 6775d265175..b5c579cdae2 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -101,4 +101,9 @@ void negotiate_using_fetch(const struct oid_array *negotiation_tips,
  */
 int report_unmatched_refs(struct ref **sought, int nr_sought);
 
+/*
+ * Return true if checks for broken objects in received pack are required.
+ */
+int fetch_pack_fsck_objects(void);
+
 #endif
-- 
gitgitgadget

