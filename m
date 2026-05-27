Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1675837C90B
	for <git@vger.kernel.org>; Wed, 27 May 2026 15:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779897009; cv=none; b=JAjMQxXkbTD/JtmpniYc7bmDAmDltUhq5hyfRkU9jIvKo09tdO81Ej8C2U3xHhhoy+YOj1fVaHPYx+FXWMLIUDQRDl36qSCjnbI7ySNuhvupPTlqcIzd8rJ96IOyLGysAuGetMsxtQojZZuECaSKqk1cg+gKaYG4snT5JN+aUDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779897009; c=relaxed/simple;
	bh=QK7QQrzl6sUUJHWlCohx57yvG04D/Fj96gc8nrQEO68=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=qgrMHbDFH/Q6g4EXKZBNUSKDTdqWzVI8xVafOys4tZzwKq+eB73ufI/lv8Y6wl6fieziYn56XIizt3vVgwBNmx17fSodBm6X/pWNHeUtLr3BQaeyyEt8FzgJnJEES9R9gt7ZiyORvoERASIIgAHFo8QBfb8AgAjQBfMEJWmFiXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FXsM1uc/; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXsM1uc/"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-516da301e64so81772761cf.1
        for <git@vger.kernel.org>; Wed, 27 May 2026 08:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779897007; x=1780501807; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pbg3DvMuupzOQWgBS1ZhKQbRzi+lutCw8qMIotgespc=;
        b=FXsM1uc/SbC+QRy8OYPAjr13YM7uFsninXVwwUraznOVjf1uVFMUB8k/lCUTk7aQDv
         hZ4s/FjGkoRd55J+5UG5iHEVa0AGRoe73d3OCYin8r/t8g7ETIT0yUwMYzevztChUJ26
         My+0tlyapraL0DMm7zTonDb8yB7wge7UkyVzZxqtACZX993EOJMFIq0HtfP8VMIS9zsj
         /5BLZBkiGB0UOIkwhcjGW7KXUtRmWPZ1jYuvvol7279CS8i/H6MIQjymz/WJs8fmJRXC
         yzqmiXmRnPkzEY3IME1YLTFu1HkbLcjM+1OtaJek3Iou2snl8SND1GVWVM/EktelQsKH
         AXlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779897007; x=1780501807;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pbg3DvMuupzOQWgBS1ZhKQbRzi+lutCw8qMIotgespc=;
        b=PvUsGmon/un/ZCGsQT7jsxwIaF9y76d6311bHffRsbE43DG4Be2ZRqfvNE1TWD0bQD
         qbK6D2IOUT1IQNZS3nLLlDWHuQDJBLGslxM02oJ/lPfjLmrahD5wbLYer95CC1b5gYSu
         /nDMLOn0vI4F2dxrUIWY8OCN5/JhjCaK/OfTXNtsaKjxxGZJw8k8fUrCEh/3eMPDP8Jl
         oEtaJRS7HNdxS9vpvyoj+RVeEPYslb8yj4BllZhzkZDYElsCP3Z7d6WJbD66fS4WKswf
         oLi5njllTH4jlcLNvKD8UmQrllVl+PtIYJRD3OpdSFuU9K4gKAO14IQwZR33FipmNyZR
         xcKw==
X-Gm-Message-State: AOJu0YzJ77dbqcaKQhfAUlBZNBqKO6RbvAqaHG7IjMwWP0xvmjNh8504
	6V+8a3cPCdExipkyhpf64UPiG+iSfvUE6CLXZV5vKJFk0GPYk4L7j1zaKzyyQQ==
X-Gm-Gg: Acq92OETgfIQBxZ8Hz8fLBMw8lFCMHMeBuHV0rTB9dL+r1ZLvwG2xlB/juhaP8Rj/8m
	aAzUDQ/TNGG3kcq9z+MU0qrE34N8LHRRvG+yJnr28v/FYBRLVXdQGOFOj5ETq1F4wSwGXwFWreB
	l8Cmc4nyskoG/Z9NxdSN8YO/Mk6JLS9g69LlU9D9PifaDdnRwh6MaDEuRv/7ooFNOKs+uNSG2/q
	+sZoBKQxnp6k0XBTyulJg3omNbvS4LjUTSPL1rnEYhyLpvw9XO+HEbHxxwg+Ci/ygWZCIXpy4Th
	CVp4D/sx4bL9R7lfAxccv0VlDai0ig7muJBwX/cx4dVGaxhkKrZdMrsqpXphmofUIAB6NU/oCxn
	QmxglFy11D9vzIM9WOSGmQ80bGcg6ZLPGLl+KF/SnqHVejoVH26WhczTlCJMLN7RYgiEGOo+wF/
	u++LbVHMpgoftdctB0vgqzGT4qCqU=
X-Received: by 2002:a05:622a:53:b0:516:e13b:77b3 with SMTP id d75a77b69052e-516e13b7e03mr244268741cf.59.1779897006609;
        Wed, 27 May 2026 08:50:06 -0700 (PDT)
Received: from [127.0.0.1] ([135.119.239.32])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc8131eaeasm170704696d6.44.2026.05.27.08.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 08:50:06 -0700 (PDT)
Message-Id: <99917cb3077e1c353c9e95cc88460484121d1f88.1779897003.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2127.git.1779897003.gitgitgadget@gmail.com>
References: <pull.2127.git.1779897003.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 27 May 2026 15:50:01 +0000
Subject: [PATCH 2/3] revision: introduce rev_walk_mode to clarify
 get_revision_1()
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
Cc: Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

get_revision_1() dispatches to different walk strategies based on a
combination of rev_info flags: reflog_info, topo_walk_info, and
limited.  These conditions are checked in multiple places within
the function -- once to select the next commit, and again to decide
how to expand parents -- and the two chains must stay in sync.

Extract the mode selection into a rev_walk_mode enum and a small
get_walk_mode() helper, resolved once at the top of get_revision_1().
Both dispatch sites now switch on the same mode variable, making it
obvious that they agree and easier to verify that all modes are
handled.

No functional change.

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 revision.c | 62 ++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 48 insertions(+), 14 deletions(-)

diff --git a/revision.c b/revision.c
index e1970b9c5d..9d0fc696d0 100644
--- a/revision.c
+++ b/revision.c
@@ -4327,22 +4327,48 @@ static void track_linear(struct rev_info *revs, struct commit *commit)
 	revs->previous_parents = commit_list_copy(commit->parents);
 }
 
+enum rev_walk_mode {
+	REV_WALK_REFLOG,
+	REV_WALK_TOPO,
+	REV_WALK_LIMITED,
+	REV_WALK_STREAMING,
+};
+
+static enum rev_walk_mode get_walk_mode(struct rev_info *revs)
+{
+	if (revs->reflog_info)
+		return REV_WALK_REFLOG;
+	if (revs->topo_walk_info)
+		return REV_WALK_TOPO;
+	if (revs->limited)
+		return REV_WALK_LIMITED;
+	return REV_WALK_STREAMING;
+}
+
 static struct commit *get_revision_1(struct rev_info *revs)
 {
+	enum rev_walk_mode mode = get_walk_mode(revs);
+
 	while (1) {
 		struct commit *commit;
 
-		if (revs->reflog_info)
+		switch (mode) {
+		case REV_WALK_REFLOG:
 			commit = next_reflog_entry(revs->reflog_info);
-		else if (revs->topo_walk_info)
+			break;
+		case REV_WALK_TOPO:
 			commit = next_topo_commit(revs);
-		else
+			break;
+		case REV_WALK_LIMITED:
+		case REV_WALK_STREAMING:
 			commit = pop_commit(&revs->commits);
+			break;
+		}
 
 		if (!commit)
 			return NULL;
 
-		if (revs->reflog_info)
+		if (mode == REV_WALK_REFLOG)
 			commit->object.flags &= ~(ADDED | SEEN | SHOWN);
 
 		/*
@@ -4350,20 +4376,28 @@ static struct commit *get_revision_1(struct rev_info *revs)
 		 * the parents here. We also need to do the date-based limiting
 		 * that we'd otherwise have done in limit_list().
 		 */
-		if (!revs->limited) {
-			if (revs->max_age != -1 &&
-			    comparison_date(revs, commit) < revs->max_age)
-				continue;
+		if (mode != REV_WALK_LIMITED &&
+		    revs->max_age != -1 &&
+		    comparison_date(revs, commit) < revs->max_age)
+			continue;
 
-			if (revs->reflog_info)
-				try_to_simplify_commit(revs, commit);
-			else if (revs->topo_walk_info)
-				expand_topo_walk(revs, commit);
-			else if (process_parents(revs, commit, &revs->commits, NULL) < 0) {
+		switch (mode) {
+		case REV_WALK_REFLOG:
+			try_to_simplify_commit(revs, commit);
+			break;
+		case REV_WALK_TOPO:
+			expand_topo_walk(revs, commit);
+			break;
+		case REV_WALK_STREAMING:
+			if (process_parents(revs, commit,
+					    &revs->commits, NULL) < 0) {
 				if (!revs->ignore_missing_links)
 					die("Failed to traverse parents of commit %s",
-						oid_to_hex(&commit->object.oid));
+					    oid_to_hex(&commit->object.oid));
 			}
+			break;
+		case REV_WALK_LIMITED:
+			break;
 		}
 
 		switch (simplify_commit(revs, commit)) {
-- 
gitgitgadget

