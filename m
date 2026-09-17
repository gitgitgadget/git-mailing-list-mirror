Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E40F502770
	for <git@vger.kernel.org>; Thu, 17 Sep 2026 17:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789667575; cv=none; b=JfP9pRFje1rdEqFjlAaAmYxheIi2EpTQf3UEa+dNUH5JqVu1hOVYW9IdEZqhUamo6mO4FOwZsjahRx45pO5DnjQaMvPxM8xT11jxgWc99tUGOARZ2rCSPqbIPGXxsege7GNoptf9DuodRU7/zDKvWIYBXlUaJA/GIZ8oc2E1Kd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789667575; c=relaxed/simple;
	bh=MAXoujpGgcE23ZLFwmsPlJubDgK0nqMRG5DFgTwI8RI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=SnD0Oonmt5VdnRDA/1lnON1WccUsT/cQymK+/RDvDUZMPY6V6omwjIrGOo3UOsKZD59dDwGsMx2wA7zDdpTy4+lFHfD+IOWnjIwI2XaN/UxkLA6oC1YpS37Z0nFFQbadyURbXR6P0v6EiXjELLZH4+zoGd5fjBDIzqRf1f2zUEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GSd62eUo; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GSd62eUo"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d8fb334e72so11507885ad.1
        for <git@vger.kernel.org>; Thu, 17 Sep 2026 10:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789667572; x=1790272372; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=reArE9NpRiCp84MeJcoQRgKHv+cvznGY0HBIjFloRXA=;
        b=GSd62eUoATx4B+2WNmRvGY/7iw8NhaeOjHXJke2z2hAuexRUPqIugctclusAGtZXTl
         f2htFmjjvgD3o4omg4cYBFBNyucVNEHccwj/ttsG7O+pA2gcIVvygIla5BDwBUWcvpeG
         413yd9khcnsS8gUE1lv9tJpD10Q5YIFloSxFWs/hBqnwicZupxqVUBW7S6ZBwAGyNuUr
         8XoJb13FFfQ1cg58sOKSJUYzihPw4lbAFGb64C2LRxYUvneTUc2caGpo/j2wmygPbgYQ
         ieKN7IyQ/iptiIzvssdcpr2/wUV1+lsa7Nz5swPe8KiVJ8B8uGpKTwiPXIsBNmCPsc35
         HHSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789667572; x=1790272372;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=reArE9NpRiCp84MeJcoQRgKHv+cvznGY0HBIjFloRXA=;
        b=AovKgztnZMq52y+MBpv+tWSF8hJJHHBlDY3QiceAECTxQwS2YhMes9NmkaDgPtRkbe
         Quaf4oV8Z5mw1r2eajhJnPf+STXzAaJiHiTlFVPJQY4GUyTCKR4XgaQYy8kIQRulyCKj
         aNSWtSlyn6xfOkmu1RZa8r3JQXmkqhqx9WRSbyNIHvtlJ5olj4uTKLOwrtSplRr0wPOp
         JqOCJQcdH5J28p8PKqMYc5udhNTYiCzIKnBSTqxg1z7GWg3FShK8Lqls5ABWYYXnomGj
         bUfr1PMY6dh8WYdlLXHkazvV33XvH4Oe0G8usW90eqPldGK3EqUITv0zKNdHyhX/+vp6
         xA9A==
X-Gm-Message-State: AFuF++mHekhc6UMZxtWt/c6x9LOY+TtjL1KOSSJAZq9zSSy6xykD6NCA
	1RyW6mkv+LTePlMlCN9NwN1G1L9ygvN2kycZDan8Hbz9timzOT9ZWt23XR/VeQ==
X-Gm-Gg: AYBFou2TJ6ZZgMtm+BBNXAfn8Fda1D8bbInYU7Ys4uk+CKqpujG0TZ4YfPP50Tx5pzw
	W3xdlPJNfPesRuE/OyaUgaOTde9dpAdDmTZRM+s/4YPW0AXwFhQxBjhOhzvvVYejuNnlq8ki0AV
	TBkyi6Oz5Cj7z+bdfr+khpWFUVqIH6LKfu4yEJb0nLT4cT+oRM/gae67b2IYjFyLWwqo7KLLvUP
	rzGKkb9AIpkaDEcrh7FeNncRpNPm1K+hPqLx+mbKt8Z4ZTStdPMZYhKT7ypDt0RHRxgmldJatln
	qb3/XTT2utseULMAncBdFhNQlue0eErgIN0uWgW/jt4tFSpG0VOtAFp6CJG2Ag+67QqKanDZEW1
	SHD33g6RTuZ+kxZLDTmQL/svZP+ldEiTyec41MKNS6WlvZydnrNGZ6jT9dXR1q70tSCzfce78qv
	xy6fQEUKWgRyaYCVYeBGruvxvpoylx06KnS/wUBKCEqP437ogUjYM1XeHT9AknXGrWVY7XuC9B
X-Received: by 2002:a17:902:ef02:b0:2d0:cc92:f7a3 with SMTP id d9443c01a7336-2dd8dc009eamr162736695ad.2.1789667572446;
        Thu, 17 Sep 2026 10:52:52 -0700 (PDT)
Received: from [127.0.0.1] ([52.157.33.34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89f338a9sm30966285ad.83.2026.09.17.10.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 10:52:50 -0700 (PDT)
Message-Id: <60599d24542722b1393483a0b0ff6eff2325ad36.1789667556.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2231.git.1789667556.gitgitgadget@gmail.com>
References: <pull.2231.git.1789667556.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 17 Sep 2026 17:52:36 +0000
Subject: [PATCH 7/7] test-read-midx: check midx_fill_entry() result
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The `--show-objects` mode of `read_midx_file()` uses the output of
`midx_fill_entry()` without checking whether the lookup succeeded. A
failed lookup or unavailable pack can leave that output unusable,
allowing malformed or concurrently changed MIDX data to make this test
helper crash instead of reporting a controlled error.

Reject the entry unless `midx_fill_entry()` returns `MIDX_FILL_HIT`. The
unchecked call was introduced by 86d174b7246b
(t/helper/test-read-midx.c: add '--show-objects', 2021-03-30); later
incremental-MIDX changes expanded the possible failure modes, but this
remains a test-helper robustness issue, not a production Git attack
surface or an arbitrary-code-execution vulnerability.

It is unclear why Coverity reports this issue in Git for Windows only
after merging v2.56.0-rc0; The issue was not reported before.

Assisted-by: GPT-5.6 Luna
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/helper/test-read-midx.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/t/helper/test-read-midx.c b/t/helper/test-read-midx.c
index 83b07c6236..412089563f 100644
--- a/t/helper/test-read-midx.c
+++ b/t/helper/test-read-midx.c
@@ -90,7 +90,11 @@ static int read_midx_file(const char *object_dir, const char *checksum,
 		for (i = 0; i < m->num_objects; i++) {
 			nth_midxed_object_oid(&oid, m,
 					      i + m->num_objects_in_base);
-			midx_fill_entry(m, &oid, &e, NULL);
+			if (midx_fill_entry(m, &oid, &e, NULL) !=
+			    MIDX_FILL_HIT) {
+				ret = error(_("failed to load pack entry"));
+				goto out;
+			}
 
 			printf("%s %"PRIu64"\t%s\n",
 			       oid_to_hex(&oid), e.offset, e.p->pack_name);
-- 
gitgitgadget
