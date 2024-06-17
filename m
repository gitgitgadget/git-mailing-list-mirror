Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFBB1662E2
	for <git@vger.kernel.org>; Mon, 17 Jun 2024 13:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632544; cv=none; b=q25BAuImffEeqz+RMML/awNazA1KARvWi1p1Us9WMhCgTIJ5KeZTCRIAvd0yII2tOnsp2Ueo/uyDi/N7LasK2f0t1Wd+fy3mwVCnfjPjG/toDmBiVwPEt2veRC08X5kOynFlxTAxzXezodz+CdqhGFxKI1OBdVER/vpaWjtkWyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632544; c=relaxed/simple;
	bh=XLb5xiWA4dAF2Fx/JHqqeBya6F3OqFt/2QpQOAIOTOo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Ov4MoK1NC8YJ+uShenzMeqAS2NJ2BgMgPcMYtZtfuwl+HTFA8SzyDsCnWa8pjdqaXDrbvp8RMh0l+oTyrif7wgUlC2NKLkhj64raBrtcwZuGrxg4oyTmkVhyAcGzpym2ip4daxdolL48X8BYwes+IA6Hq2Z5zZHwxqFiEPBwWf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wli6oukB; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wli6oukB"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-421a1b834acso36374845e9.3
        for <git@vger.kernel.org>; Mon, 17 Jun 2024 06:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718632541; x=1719237341; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G968azMSMZxhGCb7WK9dg8PxA15ncjcjODXB2hpkuVM=;
        b=Wli6oukBA1ab6ekM37HXw9pxnt/77NyHZJvZG3EVK6wghBVfO5guIjgr68ojlGUC05
         F290FLWY4N4FH697p8H38D1U7clc7M7vv0Xa88UERBVlERDzYtD5UblwXkENukf1wJAN
         7J788i7m8+U34Xol4LeY2AjBDr7Zseh971ydlX3Y0mbSnAAkNM/TDRgf8e9CkDQbUu7P
         6ILCwDHm89K9xiH7yIQQsJKgDBI9y7Abe0v5R87/7moRDuVB3cRahWOlDZMY9kPFIjug
         dDjeBNoY0Qr8em+VOfLw7QN/kcJZAx4TWiL9WKXWId41WWkBoCl6VCtt7HGe7SgP65vh
         cOgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718632541; x=1719237341;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G968azMSMZxhGCb7WK9dg8PxA15ncjcjODXB2hpkuVM=;
        b=JYqnC7q/q3F0HSRrET0k6lDTWP2yis1leoRS2E3sG87PkTSpYHSC/evIYHkF/CA+vC
         nGCeKZOt1vhZvGZCS2O14RkjaJDGWwsMYJysIREGMuv1dPA91DngCx79dHMNwqdAN3iE
         VkK3hSpIdjHB+/k29UBM1DgONo2wAAYqWg/+CwhFVnwHF6MItgUUteDKNsVIRvs43K/q
         FgUv182W07kYnZhvbHM2sYd3N1BuBynTwQnJwiQaorADFrZr21Xu2+OZIDqiS/wvQ0kL
         4Z5hHVK3TgF1+dGKa6he/2ip09MV0DCkXgMmIY7BdVavFsPc5PEAP1EdYc5tG68pSuRx
         CPcg==
X-Gm-Message-State: AOJu0YwflBy0d0TXlm5Vyy5t1k9sQWfG/b44NllQh5ICzGkqEt9fHdKK
	je/KFart/ycQGExPliTh+dwXVk3B+uts+uoE7cYSZGL56tik/eiAY66cRw==
X-Google-Smtp-Source: AGHT+IEq4qRLz84qxVsfbe4vawXEXSG/UsnJLL4GMzTKEggpAX8SbpO9PlDiJJBWNL0yZ4yZGxQ7FA==
X-Received: by 2002:a05:600c:4507:b0:423:490:174b with SMTP id 5b1f17b1804b1-4230490191fmr86524655e9.13.1718632540427;
        Mon, 17 Jun 2024 06:55:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f602ef0bsm157235885e9.18.2024.06.17.06.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 06:55:39 -0700 (PDT)
Message-Id: <3dc0d9dd22f64f79f7cddc453c43701f73f0e133.1718632536.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1730.v7.git.1718632535.gitgitgadget@gmail.com>
References: <pull.1730.v6.git.1718109943.gitgitgadget@gmail.com>
	<pull.1730.v7.git.1718632535.gitgitgadget@gmail.com>
From: "Xing Xin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 17 Jun 2024 13:55:34 +0000
Subject: [PATCH v7 2/3] fetch-pack: expose fsckObjects configuration logic
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

