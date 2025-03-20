Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A20226520
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 17:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742493423; cv=none; b=Lwki1GUzRKfotg+Myid9UfU/nrvjkqUEhiKYhNffYtdNuKueOl0ByPgVIFGsHg8kTIRyJFoiYu6ey0O8Y38Qu238IbErc/MgpzUt4L5kXcUZ6uI8AWd8HIcVZNeip97swFklunI2VHm2/oY5VQC3lIyyQz91c1a38GhUCLAR8SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742493423; c=relaxed/simple;
	bh=vU+seeiUhq6+boGZW9tWtB1TL6/CqI1cewhnjEAMIPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o8Zd8Dp8vR8XDhU0sjBLuM4xkbhMIfxLqcL7hARQWRMdC7alqxA9jLfWXZhtPYlguP9DxcIrgz8w2kkiXqbuI7FIEd+YyxA3z3JHlmqpf0GkckwhzAuNXRWhVkYaHcUBcTrgH8amXsh5vhj+MNYv9HcSScBHG7lvn1YC7z9+Ql4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=BbUZbxhW; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="BbUZbxhW"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7be8f281714so141851185a.1
        for <git@vger.kernel.org>; Thu, 20 Mar 2025 10:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742493421; x=1743098221; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nZqE9BGm06SVb8mpErQU75JgleTZK1unD+cCdMUkCTU=;
        b=BbUZbxhWExr83pcPTuy6+isIMKsglqwtMiYnc272+ApG+qXn4aK5fkxy76WKWuN1uq
         zqC9C2sE2HuGTYzIsFSGJGV55UjaXP4UBDrnuXlNbdmz88O8gnQziVlQRMCfgdQUem8u
         czZFBRaKpRn5DM99IjXuKya/Cgh5JR2jwLjzxaXQwTIEETN4t9mHjBL9Mn9TPi7mjjlL
         CR4ZmRJELnUglhMkZhoY1cEMNU6OeXRVl2fJGKJGi0Vj5mxswWNdV8SKAhIsdtZv1N6X
         qvzZ8rvt6eCB3G6PH/j6TJwor5IzFml6Sj4F/bneZvISF8D0IfoL0flU8/vcaoZhb4rw
         BYdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742493421; x=1743098221;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nZqE9BGm06SVb8mpErQU75JgleTZK1unD+cCdMUkCTU=;
        b=oSXQuF9xSA2gGlAq488jYfH0Xmz+3z3sK3ZXSlUh1Usvz8LyHZtHbDxlv7ho6qNSAB
         rE6D0kuiuH9dVb+lw40or3V7uWZIO/r03taFRCpO5lIqufHVLNjIYCZhm4/dUil7tr+G
         k9744xckN5EM3TYEg9zwgozgFE2dLDGAx17RzoJpJoc4jEK9Ph9ex0NxnlIjPwazkt9z
         POTKFDNY8LVwl8EYpZuJznLei7r9Ci+bPtJjVZWbjO3C/NUl8IPO34n+7WTI83VBI5RH
         jNIIWGhMaTyxQwjPN5u83TI4Vx6Aped7N4ZDlmKk+SLWuUWMOgwd4H/VrfsFTJ/GtW9J
         GcnQ==
X-Gm-Message-State: AOJu0YwdHTkichX5DuqcmxafC17HemMTrLsbAvqnwdC6jOTTkilwoyKo
	4zdHtyMsWVgDC1BtPgRfG+RyRlTJ25BTmfzb6AgbFQKKLXHIrqd3kv7PfvlJtkp17QoEFVDJRSd
	Gj/k=
X-Gm-Gg: ASbGncvCfz+cPqTZUxzBSDRhWlKhno1H1mdV/UKw0/eKHj6YjddagwHX2M3cjqOvprL
	h3WWmjeUkCP6Eqw0ygq6MqBX6Sm9ZkHFUJOyx1CMjycsR6Ya/H4j5BM0c1EMXznurfp6+jDFnKF
	xRjduNtAFnl3jIwmDA5LYVzoWKRxF41gz6mINhwFu2qAHcbznn3A15kw8/tFS45xQEXAdgj3Vn8
	O2gr8j1KeBHkzDB7a6In1JKnnJNoWobzmaWc0VGyLqcPBk9/TJ4oNP4dPeQ0ceSH41rCoZQct3E
	nrGa31pxcR1zqI/X5a9aNcLT7f2d3uAmPDc+nigeQ77z9zhKy4neVogXCGTobpT4cbtCpAAuuPN
	Tqo6BxwGAdrXIJKjGtQWMb9+Tx5k=
X-Google-Smtp-Source: AGHT+IGn3/A4SgarqXW9pdmqUGVacEB+verODEBwrWFK5smvDhw1E1u1LoDl6C/oSZWiKA5GMfwAAg==
X-Received: by 2002:a05:620a:394a:b0:7c5:4a6c:eb8d with SMTP id af79cd13be357-7c5ba200eb2mr9988485a.58.1742493421008;
        Thu, 20 Mar 2025 10:57:01 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c5b92bc0e3sm16599385a.8.2025.03.20.10.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 10:57:00 -0700 (PDT)
Date: Thu, 20 Mar 2025 13:56:59 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 11/14] ewah: implement `struct ewah_or_iterator`
Message-ID: <0fbef17acc7fbf49fdb8b61efa2320bab94e3499.1742493373.git.me@ttaylorr.com>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1742493373.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1742493373.git.me@ttaylorr.com>

While individual bitmap layers store different commit, type-level, and
pseudo-merge bitmaps, only the top-most layer is used to compute
reachability traversals.

Many functions which implement the aforementioned traversal rely on
enumerating the results according to the type-level bitmaps, and so
would benefit from a conceptual type-level bitmap that spans multiple
layers.

Implement `struct ewah_or_iterator` which is capable of enumerating
multiple EWAH bitmaps at once, and OR-ing the results together. When
initialized with, for example, all of the commit type bitmaps from each
layer, callers can pretend as if they are enumerating a large type-level
bitmap which contains the commits from *all* bitmap layers.

There are a couple of alternative approaches which were considered:

  - Decompress each EWAH bitmap and OR them together, enumerating a
    single (non-EWAH) bitmap. This would work, but has the disadvantage
    of decompressing a potentially large bitmap, which may not be
    necessary if the caller does not wish to read all of it.

  - Recursively call bitmap internal functions, reusing the "result" and
    "haves" bitmap from the top-most layer. This approach resembles the
    original implementation of this feature, but is inefficient in that
    it both (a) requires significant refactoring to implement, and (b)
    enumerates large sections of later bitmaps which are all zeros (as
    they pertain to objects in earlier layers).

    (b) is not so bad in and of itself, but can cause significant
    slow-downs when combined with expensive loop bodies.

This approach (enumerating an OR'd together version of all of the
type-level bitmaps from each layer) produces a significantly more
straightforward implementation with significantly less refactoring
required in order to make it work.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 ewah/ewah_bitmap.c | 33 +++++++++++++++++++++++++++++++++
 ewah/ewok.h        | 12 ++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/ewah/ewah_bitmap.c b/ewah/ewah_bitmap.c
index 67f8f588e0..056c410efb 100644
--- a/ewah/ewah_bitmap.c
+++ b/ewah/ewah_bitmap.c
@@ -371,6 +371,39 @@ void ewah_iterator_init(struct ewah_iterator *it, struct ewah_bitmap *parent)
 		read_new_rlw(it);
 }
 
+void ewah_or_iterator_init(struct ewah_or_iterator *it,
+			   struct ewah_bitmap **parents, size_t nr)
+{
+	size_t i;
+
+	memset(it, 0, sizeof(*it));
+
+	ALLOC_ARRAY(it->its, nr);
+	for (i = 0; i < nr; i++)
+		ewah_iterator_init(&it->its[it->nr++], parents[i]);
+}
+
+int ewah_or_iterator_next(eword_t *next, struct ewah_or_iterator *it)
+{
+	eword_t buf, out = 0;
+	size_t i;
+	int ret = 0;
+
+	for (i = 0; i < it->nr; i++)
+		if (ewah_iterator_next(&buf, &it->its[i])) {
+			out |= buf;
+			ret = 1;
+		}
+
+	*next = out;
+	return ret;
+}
+
+void ewah_or_iterator_release(struct ewah_or_iterator *it)
+{
+	free(it->its);
+}
+
 void ewah_xor(
 	struct ewah_bitmap *ewah_i,
 	struct ewah_bitmap *ewah_j,
diff --git a/ewah/ewok.h b/ewah/ewok.h
index 5e357e2493..c29d354236 100644
--- a/ewah/ewok.h
+++ b/ewah/ewok.h
@@ -148,6 +148,18 @@ void ewah_iterator_init(struct ewah_iterator *it, struct ewah_bitmap *parent);
  */
 int ewah_iterator_next(eword_t *next, struct ewah_iterator *it);
 
+struct ewah_or_iterator {
+	struct ewah_iterator *its;
+	size_t nr;
+};
+
+void ewah_or_iterator_init(struct ewah_or_iterator *it,
+			   struct ewah_bitmap **parents, size_t nr);
+
+int ewah_or_iterator_next(eword_t *next, struct ewah_or_iterator *it);
+
+void ewah_or_iterator_release(struct ewah_or_iterator *it);
+
 void ewah_xor(
 	struct ewah_bitmap *ewah_i,
 	struct ewah_bitmap *ewah_j,
-- 
2.49.0.14.g88b49c1b34

