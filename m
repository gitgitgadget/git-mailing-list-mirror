Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7EA1D364C
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 22:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732054071; cv=none; b=PuIsEsru2Dx4TtpgWie4xqTEhxtvfGPJhllok0E9jrG9X1H+ySz/ThlzIfbQdZTal3C8fXPwEzOmbG05XzJCvzZa+2YbH/dRq3DEq3xRUZizVrIm7/1EDpj7tLxwcDIvmRl52m8ORmwyIB46whev6ylMPsqTezgFMDrAJ/2yiKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732054071; c=relaxed/simple;
	bh=jYaetPrjcSxeTEQb0wweiRM/qdhFVakCc1KsqWhpD2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o4TP88QONVsvonLQMSLJhhEufXQgnJCxF8yMBAFeyDCwmCkd6/n54RTWgcPTqVcQBNl7o9Bzd7DdgZtWJyVVae9cCUCA/SwFXM2DogjsdA5hNVnvhZAMKaNeWluA8ze3eOoqDIGqAUWThbq1P32E4KDDrweEkxhk7uNgZCXD74A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=EDG5yvk1; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="EDG5yvk1"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6ea339a41f1so40804607b3.2
        for <git@vger.kernel.org>; Tue, 19 Nov 2024 14:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1732054069; x=1732658869; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PfN45cfNAdGD0zNnhWLscXUecob0WYAy+1T5qaUB/v4=;
        b=EDG5yvk10MtOt3c48Qqoj2hwTnOp9rK+ntHQC6mA6tYgCO+hIQ+jNk624H2N/g2H9N
         uaB5Wo5L+BVOr3f/D+nGkUzIi9PiCZwS3CjNKioBUE9nujUlOlO2kTWBT1qJ0vPVZWTk
         10WdMiD+cZ1Uaim2U4EeNuamyzgkXkpyaRLRJJrrBvJfec6/mmnaDAV8GX91g50dCi++
         1MgZbSocQoNzHYCX9TXOpTtKhFAZ72rerHw/iCgmrA/LvwKsyCwuX/u8mC+C9OQnl70r
         LMVRWIMPp3rhOreEqxOfCy25tnhAfcCdxgWebxGPVIFn5I4axGlrcfFyUWpciC+zZpmZ
         ikIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732054069; x=1732658869;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PfN45cfNAdGD0zNnhWLscXUecob0WYAy+1T5qaUB/v4=;
        b=eGlyzf2UQh35BT5i8Ja5fkNT9s9uLwWx6rGUiJDt+IRBK/fsK6vCEWuF3Gj3Q8NbSj
         uZmRCUzN4chc+S7K8Nialn8zWBHjCyEcY2k3MU87v2vmTSpBBvUr4qI1nysNOuW80bsj
         AWhVcg7ChXNt7in4ITqt0AtPy79XBlZuGSZ2m2Q35IYVlDR6E1OjOG+c320yOEYjjzbF
         j7gACQr0mNAkx95JzxnsBaikBisU5BXYv7v40LiXKY1tUa4No0UPyqPPwFxYsrqC4KxX
         QqjLvbkYaBmImQLTcSk4ngC4VFKNiN4fGHjoy1xAjyJaSfDhhKQrW9YfaHY0iuhmNSbG
         TyHQ==
X-Gm-Message-State: AOJu0YyZ1Ml0ttf3Hwjq3JVZ5d3Y550xHH9Zrn8mnQICqC4Ogdcj0wYy
	nAZyYlJ0yqcVm8a6ra0G6sewBG0w+GzmC8IkSR4Py1AvTsDG4rweujah+7wD3KfKICEjHi4u2cG
	apuM=
X-Google-Smtp-Source: AGHT+IFOQ7H3g8AXiDajIQtpIeeanwK4GEBvM2XJ/62QuSgwKccde9x7pmHR2tdfraX0jegglPmu7g==
X-Received: by 2002:a05:690c:4b13:b0:6dd:d0fa:15a8 with SMTP id 00721157ae682-6eebd2fac11mr7302297b3.35.1732054068903;
        Tue, 19 Nov 2024 14:07:48 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ee7ea1adccsm16670887b3.80.2024.11.19.14.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 14:07:48 -0800 (PST)
Date: Tue, 19 Nov 2024 17:07:47 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 10/13] ewah: implement `struct ewah_or_iterator`
Message-ID: <e1b5f6181e38a526cee4bd1f08a397d88b776661.1732054032.git.me@ttaylorr.com>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1732054032.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1732054032.git.me@ttaylorr.com>

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
index 8785cbc54a8..b3a7ada0714 100644
--- a/ewah/ewah_bitmap.c
+++ b/ewah/ewah_bitmap.c
@@ -372,6 +372,39 @@ void ewah_iterator_init(struct ewah_iterator *it, struct ewah_bitmap *parent)
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
+void ewah_or_iterator_free(struct ewah_or_iterator *it)
+{
+	free(it->its);
+}
+
 void ewah_xor(
 	struct ewah_bitmap *ewah_i,
 	struct ewah_bitmap *ewah_j,
diff --git a/ewah/ewok.h b/ewah/ewok.h
index 5e357e24933..4b70641045e 100644
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
+void ewah_or_iterator_free(struct ewah_or_iterator *it);
+
 void ewah_xor(
 	struct ewah_bitmap *ewah_i,
 	struct ewah_bitmap *ewah_j,
-- 
2.47.0.301.g77ddd1170f9

