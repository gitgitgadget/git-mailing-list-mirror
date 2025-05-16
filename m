Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C2D278756
	for <git@vger.kernel.org>; Fri, 16 May 2025 18:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747419138; cv=none; b=TbKCpG32PBXv+nQS1OEFoOK0M4fV0r2NAJevEuZqNYOIyAKV2/x9hWtICSoyS5krbr4Q8Sqq+jkjhihqpzt/Sw6ZULVPlgxt0GriWHez5x9Y5bS6fObr9dLQzBVuKxKE+XnqG9p/gZ4x03ZbLjSGTM4WpdY4FOtXzGYfO1fYqPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747419138; c=relaxed/simple;
	bh=xtslHOoggnFc9miW7EizpZ10k1sLS6eAZOlN9lFv84U=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=nL+NO6nicCLgnBwk+05bDG6v7JXHjMA9miBR5pFxKI4zIhJmM/fKLo3iZFUN2RPtBkI5Y6ds+xcGCrpgtCSX/qmmJdRGpN/0856lHOkhlj08lny+Vl/0yMN/PRtFL5cV/hlmqkzkBbp094pSem6qaA8mhCUM0siYdohrxX6nZkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OfN78BRU; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfN78BRU"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cfe574976so16024415e9.1
        for <git@vger.kernel.org>; Fri, 16 May 2025 11:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747419133; x=1748023933; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iu2fvKiIxzxzpyr6tap3wqUNXrwH2JJN5UIHR4JIUTg=;
        b=OfN78BRUFCMtcjMI3e90zZDk0CtlyytMp8i/qkqfqmaVVvJTBXpocbEZwpW85Rsd3I
         qxGYh0Epb0uGkHnwFBL7CA1gLVoyxi8bBYkk4JsGNp6kRMmM4/lCNWZ9wCYrec+hwPCW
         sKZb9asfHDszEPwYh2p7I6Fy9Ww4SDqzaHJ9UgXwWRy90eRfqNKXvm9tqu5KVLzRekxx
         Kxv8FQchPpzWZHR7DEDhZpoilpuOkS+ZjCFIcw+iBQS491XlZB9dTprh/VRzRHKu0LCT
         SKmCuOyAFAqjD/BoiCLpv3TC3JNfXvzt9xv52MhpRHSaH+8pqzVSc8UyqnVBTi+mNKat
         uUtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747419133; x=1748023933;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iu2fvKiIxzxzpyr6tap3wqUNXrwH2JJN5UIHR4JIUTg=;
        b=naPq4UD0vQdGKiTdbuvGIPNhEIwmVvzy9+K9+iC7Uh8KJPyy2qqc3LrIO903nzoahj
         hOiTCkdo8JsQKCdbYb9oIA9WxmXXXibHqw462h2lz1e5/I3p7DBEgkSAgOQEUJYE6SLB
         8+daPIEmb7Y9CVTfWBoDMjdowfcNjfLvzMRt1a+axcdS+MqO9O0oUXqYHIYlm2pJukZV
         fOnYQPnhG/87GtdJiv0yjVLcoce0WKEYjtsyZlfJ1F1aCi5jOf00ki3qx4PQBlhfNVuk
         OwQpJCr7eA5SWyO25ZoiL2Z/N6jgIfq2bs+cvOAuAFDO4wJRFsRl86jGqm9RjM5rjFiY
         DEWg==
X-Gm-Message-State: AOJu0Yw+NTI+6S5tvaWbm4rCsOKcCvaT+eMyZYBVdD9+a8I6HMiQpZ35
	9PF09lQ59c3yz/DMjIkOrJiZYMIFoUryayIdQd9pdz0VSxJiO8tzbVUurnnkMQ==
X-Gm-Gg: ASbGncvnSW6Kh3siYFuCW8jtRt0+e2zTxNptZgR51OCCxBo49+MBW4lIud/JY2dZX2g
	hEtWNxQFBah3UKczscvMk5mstdPEPycmt3DN670u+HnARUkIHnF+k0guX2JPEHDOrnZyWzFfc4i
	y86lZ23YaBFtebpeBJTM+pQI9B0LRfPpDuL/5LXQpqQjK9mgkhO2aBX1skakdeZXDHxQ1Kv71q0
	bxaBRtKzt7MuXsHmntcgDWiF4B/DOdvsFWTm3vFbm76x5TY3uftvsKmDTISuiTKe3rfEoAjsnuD
	GLQlclxpBZ4BNrHtWVsrjuvUhrIyueQfozHGGkZcExiti1m0JzCe
X-Google-Smtp-Source: AGHT+IEGFKDyOyvKgHyVddvURrvJ9pgdS2YHONf8R55U3+Eagj9EVuWz15bzqyp0UVVfglnyBQ1EKQ==
X-Received: by 2002:a05:600c:b88:b0:43b:c95f:fd9 with SMTP id 5b1f17b1804b1-442fd60b907mr48833845e9.5.1747419133158;
        Fri, 16 May 2025 11:12:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f33690f0sm112856025e9.1.2025.05.16.11.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 11:12:11 -0700 (PDT)
Message-Id: <57c1cc20de0c80b84ad11a6546763826fe4b1a09.1747419124.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1819.v3.git.1747419124.gitgitgadget@gmail.com>
References: <pull.1819.v2.git.1742829769.gitgitgadget@gmail.com>
	<pull.1819.v3.git.1747419124.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 16 May 2025 18:11:51 +0000
Subject: [PATCH v3 01/13] pack-objects: extract should_attempt_deltas()
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
 builtin/pack-objects.c | 56 ++++++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 24 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 58a9b1612626..7805429f5d1c 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3196,6 +3196,36 @@ static int add_ref_tag(const char *tag UNUSED, const char *referent UNUSED, cons
 	return 0;
 }
 
+static int should_attempt_deltas(struct object_entry *entry)
+{
+	if (DELTA(entry))
+		/* This happens if we decided to reuse existing
+		 * delta from a pack. "reuse_delta &&" is implied.
+		 */
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
@@ -3226,33 +3256,11 @@ static void prepare_pack(int window, int depth)
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

