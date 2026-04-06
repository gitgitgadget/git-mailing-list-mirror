Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB67A390988
	for <git@vger.kernel.org>; Mon,  6 Apr 2026 19:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775503686; cv=none; b=GE7JRq5igAMYqtHjZBU7GhHLOHu99rDjU7lvXgInb+VWBu7kBis5bzxhk6Q2tNBnIPkdXABlFKnhSOuMU7s+fxV00qXcaJk2X4MVLUeepvwC3tTmyFOX7XXnBy5G/YCc8OrkDDJz5gmtZp5gz81DJRJJ6tOpH4QXA6oADAKONGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775503686; c=relaxed/simple;
	bh=Ari0zVBkfE43UH4bmdn/a3SFCnxDAnh+fqA+3Jgnhwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ez7RM24I9xSYXoKh2NjbUvJpV4fJnxyguhk74J1KkZ0twE2pivKEkN+KEh/jucbME8X4sR8RC2SxaEzjIFCkj3dAKVa0/gXF/JYcOkke5aSmdiKGA6Y2uv6SbMsu7y8+gDUGwtuFcnLKHtfwq7j6Qt6km4AvXkzEVVwlN4vkzcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=btMndcUR; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="btMndcUR"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8d933da14f0so62571585a.2
        for <git@vger.kernel.org>; Mon, 06 Apr 2026 12:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775503684; x=1776108484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5M5RQc75RnAhIBm88J4JX5bYDHqhK+qJyxB5bvWSHa4=;
        b=btMndcURZPtngMEA9ULafTi/MdpGtz3rL/CP1/57Wa/a3oUFe6PXTQ4Z62kdQzGPeY
         M6MBZ+PLdMEoO+RJ1G4Qu1E4vUiYp2//bjBHvga5UvuBp3dlU0Tdz74VZMq9kC9v6ERP
         Zw7XN7phLonTz5LB9wRbtedHJj9h5blSeeJs03lyMEN1/6dpUOpVXiuw2+uoKpuAsLWM
         cybODuqBvgWEzuKPO8OPTrrZJln+lR8bBT3RnrvX/o++QfotWh8b9vwYihhtXkxvU4Xp
         VW+zeiUbZTRgIJma9Khr9OJ5uT8SwbD+/CJJ8EFHYEDF9K1PS5XT+V9J4dOB/57YQYUu
         XSrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775503684; x=1776108484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5M5RQc75RnAhIBm88J4JX5bYDHqhK+qJyxB5bvWSHa4=;
        b=YLOaA1NdqXjMuh0dMDUh/zkk5AdeniapyVBMGYEtL5nVOIKx82sSh3urCqRQJOt1x4
         IYErGB88oQ1i8v+8zVndafroackimizcTCTVEFzmJgL4hIN50K79k1kLF0fM7IvJuq5q
         iWaYHcKtzvpPEejikPMTLtkRDH66cnmcFbCsJe5oTRWBuEhP0b3/kwtc8kEIinRlgnLt
         J/W5xcwkfPSRlPdQ/pk0E65LDNyqxoVRaQag94Ji2BDi9tMUugDC4eVvDliNLF+CRuL2
         v0RI+znSakI0S1U9eI9f/MolpT+61b0WwW1X8hdvbDAuRX9+eCJtF2aZoORVLOpB3tp3
         uGpQ==
X-Gm-Message-State: AOJu0Yy41Ogkq2YPWe6Br9xzKkbXj/gv0RJ3Mheh9CnjgxPiS7oD4h3M
	byuYCrd70wriaDEdX9TPGBJ1OZC5R1dU4VR5vAjQ/Z14pQoEBla2qdISIuROcRv+CgM=
X-Gm-Gg: AeBDieuOE5qb1wbLcZsPuga+/nVhUkSpTiFopnrCR5FJtJwX0GVLvUe0AZTibCBuk0w
	Htjy0Yrv3yfSEuiAouIpFVgPq2A/x6A32t+dD9Jgd5i96HhF2CJb2BNG8Mn/vVDycbFmm9yVKLl
	ENKQFVPaIbZeZvGlqt6N42/z041Wb7JfPWh+282UEeYtg44q6SORwnH5knvTQyLC/xVr2c3PcsQ
	w2GJ8dK+IyVaICcWP2yIIHS282cTU+W6iaH3Qe5iWEzdtFxSKNbkrU0FEmme8MEm4xTU21EQeHr
	AD2ZWYXVHf0dGpjgjY2KUJKhDhSFDB6RY6i3HjyUs5ROepbycXEv9P2735loJ0ocQ/YHyEvBOW/
	d0BDlUoa+9pAVkk4Hu1sz1RGOcZp0e8XbLgGIsW0/Go1htrLqXXBxdX9e7ZXwlu0xiVVgNWtfBn
	Z9yBwGRazJk5nbExpPorUJPzL6WjSlvJbZqts=
X-Received: by 2002:a05:620a:1228:b0:8d6:39c0:e6a0 with SMTP id af79cd13be357-8d639c0ec01mr949227985a.54.1775503683490;
        Mon, 06 Apr 2026 12:28:03 -0700 (PDT)
Received: from st-davidlin1 ([70.54.98.79])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d2a1307586sm1123199985a.0.2026.04.06.12.28.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 06 Apr 2026 12:28:03 -0700 (PDT)
From: David Lin <davidzylin@gmail.com>
X-Google-Original-From: David Lin <davidlin@stripe.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	davidlin@stripe.com,
	davidzylin@gmail.com,
	ps@pks.im,
	stolee@gmail.com
Subject: [PATCH v2] cache-tree: fix inverted object existence check in cache_tree_fully_valid
Date: Mon,  6 Apr 2026 15:27:11 -0400
Message-ID: <20260406192711.68870-1-davidlin@stripe.com>
X-Mailer: git-send-email 2.52.0.ge17bebe515.stripe
In-Reply-To: <xmqqcy0bc4bf.fsf@gitster.g>
References: <xmqqcy0bc4bf.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The negation in front of the object existence check in
cache_tree_fully_valid() was lost in 062b914c84 (treewide: convert
users of `repo_has_object_file()` to `has_object()`, 2025-04-29),
turning `!repo_has_object_file(...)` into `has_object(...)` instead
of `!has_object(...)`.

This makes cache_tree_fully_valid() always report the cache tree as
invalid when objects exist (the common case), forcing callers like
write_index_as_tree() to call cache_tree_update() on every
invocation.  An odb_has_object() check inside update_one() avoids a
full tree rebuild, but the unnecessary call still pays the cost of
opening an ODB transaction and, in partial clones, a promisor remote
check.

Restore the missing negation and add a test that verifies write-tree
takes the cache-tree shortcut when the cache tree is valid.

Helped-by: Derrick Stolee <stolee@gmail.com>
Signed-off-by: David Lin <davidlin@stripe.com>
---

Notes:
    Changes since v1:
      - Use test_grep instead of bare grep (Stolee)

 cache-tree.c          | 2 +-
 t/t0090-cache-tree.sh | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/cache-tree.c b/cache-tree.c
index 60bcc07c3b..9fe057355c 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -238,7 +238,7 @@ int cache_tree_fully_valid(struct cache_tree *it)
 	if (!it)
 		return 0;
 	if (it->entry_count < 0 ||
-	    odb_has_object(the_repository->objects, &it->oid,
+	    !odb_has_object(the_repository->objects, &it->oid,
 			   HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
 		return 0;
 	for (i = 0; i < it->subtree_nr; i++) {
diff --git a/t/t0090-cache-tree.sh b/t/t0090-cache-tree.sh
index d901588294..0964718d7f 100755
--- a/t/t0090-cache-tree.sh
+++ b/t/t0090-cache-tree.sh
@@ -278,4 +278,12 @@ test_expect_success 'switching trees does not invalidate shared index' '
 	)
 '
 
+test_expect_success 'cache-tree is used by write-tree when valid' '
+	test_commit use-valid &&
+
+	# write-tree with a valid cache-tree should skip cache_tree_update
+	GIT_TRACE2_PERF="$(pwd)/trace.output" git write-tree &&
+	test_grep ! region_enter.*cache_tree.*update trace.output
+'
+
 test_done

base-commit: 2855562ca6a9c6b0e7bc780b050c1e83c9fcfbd0
-- 
2.52.0.ge17bebe515.stripe

