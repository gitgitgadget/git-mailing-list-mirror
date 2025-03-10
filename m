Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76B9153BF0
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 01:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741571461; cv=none; b=fE3uNjgiGhaWAHnRh9De4ydzVlFeix0JA9mEZD8Gbjjaqy9ycvFYECjXHvVX27QFubOQKaJVfX634skoh0i6sc37bwJCXALxU6sN8BmIxB4/Va/YFjrOlct7LBvnQHqCQr1JjJs+k3XUk2kp/flDkoC8zzfONNvdvfUfTYZAP+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741571461; c=relaxed/simple;
	bh=bk2pipRcl7Jr7yDwVdV4c0AnrxSonCVPPy4n/XzJ2Y4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=h9vx1iFGG0YJoTPXM5Ez/40uYj+2wS8jvzAPZ3LD+u9+Ess6C5mLXqHTn/r/OcP1VYKQWfgLPJM2kOAEIwzqcLwlMzdAtYmXtx27U7/Kue/9SvWMNhhF2D6SmwgrvIuUTLpqFShLzUlDdGpm8WFewGwXNw5mWwFC/lMWyH94vVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZGQgRxZs; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZGQgRxZs"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e5e0caa151so4936437a12.0
        for <git@vger.kernel.org>; Sun, 09 Mar 2025 18:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741571457; x=1742176257; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pvMwJcMbiCXTth/rFKePIReiguNV1rrRIPP1zqupXQc=;
        b=ZGQgRxZsnFM3blYk363ya0Pzp+eVqyMWugQjvouGWXBbpiEQ9uIDbrRZBtQRu4plV/
         pAbgDv+WIsRAaXkM0pkLwJbdw1LotGL6Wv4zEdNGM85jOCcMsepuaO+BPmAkxsnMxYIW
         /UeMaCXjvlIEfS37LJ87aBHGkahR2ETNo8m2aoXn33Wtgoe4s2lK/v/+zHMWYUsT6G7Z
         ChH4gMsnHvpVZwxOA1ztQPr8IUEjyklrpxzzaI5wMagGhfh/NMe0Tm3vIOrm2zyiYEfd
         MLMXm+/ScRx26FqzAVVlWFIH8Oq8DuIzB8OlShVH2ImdpOGXwMJ5LQ/0JbFexoYcT94U
         WJ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741571457; x=1742176257;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pvMwJcMbiCXTth/rFKePIReiguNV1rrRIPP1zqupXQc=;
        b=jZrbSiq0lFx7UIXQ4+Tcb957+0ZGoH7GjVr98IopTC0KcYEHgpeCvirBCq7JB/5Suq
         2bGJmOki1GNNCewacrNKRBhWwz/2weA6skDSkOYsA5p+24+zq0p3TZWo5cdgRq6zIDXx
         +PUMYNtbGdl7R03WH7VeKLLPAZfkinvq/dstifswI1BhIN7e0Pbsbr6YxvVu527FgdUP
         XZK5PwiyNtrlfSPwn/Q8/Evgaf9EiGGnbkar80QZrkrf8+6BULhVaeF+9Y6bULePthxZ
         7+6fLew/cHx18OEgIiY4sjg4JirbgHlB+ugtEFNIbsYgo3P/4t87IG3bmj8XHPbj3K6c
         A8mg==
X-Gm-Message-State: AOJu0Yy8Oq+aWMoAtCUVW8I4yFePrBDL8UK0HW+j/WEx+1id5spV4KH7
	oxZ8nhnWk75BkUcgzi+LNdDmTcgCGpK2tUKm4dPzLe+2eEwAF7dj4GijQg==
X-Gm-Gg: ASbGncvXhABo4GYE2IRbtUNx5p7IP6cAjZmVLUj/Jx1qfuGak1eXgPUugCBF5bkxCBA
	ehwPyR8+IDeomAe7zHOpqr4mo25NHRtkE3PBqz0MvPZvX1tDIAn7C1LoYYqJTDKnb2P3G76NHHu
	TdTgRhF99DJei8vxVgETj0FnU1Fu9ehUvvQOOaA9qJGin83wghrPDp+JbKPZCE4R5mlLjsIeDhJ
	0IlH0Nl8f12hucfKf0/FajMdyrhpzS816aOvv3RlOT7FA+KoIqWbnYk+G1U2OiPI2+7H816KN8K
	IG9wgFMYoP9pe1THLezw1JaGn9dwRSEHCSdxIgOV9Zr8Ag==
X-Google-Smtp-Source: AGHT+IHzXqqbxWMrm5FSMsKv0rD5QOfsKCpgTT62PDaWk8fsvqBJyTq5DqxBuMKMGEPsFZ/mxkJtiA==
X-Received: by 2002:a17:907:9491:b0:ac1:ea29:4e74 with SMTP id a640c23a62f3a-ac252b5aa82mr1260421566b.28.1741571457361;
        Sun, 09 Mar 2025 18:50:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac2a65c7f7esm46493066b.117.2025.03.09.18.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 18:50:57 -0700 (PDT)
Message-Id: <a2ed1f2d4e3946c563f934fcaf149050d50f255f.1741571455.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1819.git.1741571455.gitgitgadget@gmail.com>
References: <pull.1819.git.1741571455.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 10 Mar 2025 01:50:43 +0000
Subject: [PATCH 01/13] pack-objects: extract should_attempt_deltas()
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
Cc: christian.couder@gmail.com,
    gitster@pobox.com,
    johannes.schindelin@gmx.de,
    johncai86@gmail.com,
    jonathantanmy@google.com,
    karthik.188@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    me@ttaylorr.com,
    newren@gmail.com,
    peff@peff.net,
    ps@pks.im,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

This will be helpful in a future change, which will reuse this logic.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/pack-objects.c | 53 +++++++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 24 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 58a9b161262..1d0992a8dac 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3196,6 +3196,33 @@ static int add_ref_tag(const char *tag UNUSED, const char *referent UNUSED, cons
 	return 0;
 }
 
+static int should_attempt_deltas(struct object_entry *entry)
+{
+	if (DELTA(entry))
+		return 0;
+
+	if (!entry->type_valid ||
+	    oe_size_less_than(&to_pack, entry, 50))
+		return 0;
+
+	if (entry->no_try_delta)
+		return 0;
+
+	if (!entry->preferred_base) {
+		if (oe_type(entry) < 0)
+			die(_("unable to get type of object %s"),
+				oid_to_hex(&entry->idx.oid));
+	} else if (oe_type(entry) < 0) {
+		/*
+		 * This object is not found, but we
+		 * don't have to include it anyway.
+		 */
+		return 0;
+	}
+
+	return 1;
+}
+
 static void prepare_pack(int window, int depth)
 {
 	struct object_entry **delta_list;
@@ -3226,33 +3253,11 @@ static void prepare_pack(int window, int depth)
 	for (i = 0; i < to_pack.nr_objects; i++) {
 		struct object_entry *entry = to_pack.objects + i;
 
-		if (DELTA(entry))
-			/* This happens if we decided to reuse existing
-			 * delta from a pack.  "reuse_delta &&" is implied.
-			 */
-			continue;
-
-		if (!entry->type_valid ||
-		    oe_size_less_than(&to_pack, entry, 50))
+		if (!should_attempt_deltas(entry))
 			continue;
 
-		if (entry->no_try_delta)
-			continue;
-
-		if (!entry->preferred_base) {
+		if (!entry->preferred_base)
 			nr_deltas++;
-			if (oe_type(entry) < 0)
-				die(_("unable to get type of object %s"),
-				    oid_to_hex(&entry->idx.oid));
-		} else {
-			if (oe_type(entry) < 0) {
-				/*
-				 * This object is not found, but we
-				 * don't have to include it anyway.
-				 */
-				continue;
-			}
-		}
 
 		delta_list[n++] = entry;
 	}
-- 
gitgitgadget

