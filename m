Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0A3183CA6
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 20:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741983535; cv=none; b=XZyFZhzrhzy6ak96UM980wT4+PhYvl/qblsbM44aVBncgPMrYfFcAQS7HjPstbjOk5ypDx4rNdRzaqNl56rsqVNjOI2/0aqannGrWttOo6kpobvPTpNDKG4GimyWBjJEu1dwPWCcGMo6Ui/Uxn2OgcXYafUc323nzqxSDcAVsHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741983535; c=relaxed/simple;
	bh=2GNzc709su22S17XvlV5TXqrW9utlBwDgZFC+SGNZUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DmXDqtqo4T4YeGTBC9/AqjxhL6b50kdYYDYwNpYdE1ix3A/RdZyFGIWHGlyhH1ay2hmpvqd8vVpsm7RxcOCGPcNxa3ky87wkePQ3hqILzJrziCndhLyMzsWnTaYTzZG7/gqRvo8F8YfY8DIwiFS34JO3mWo9SL/pffvPSF384uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=iFrOngTt; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="iFrOngTt"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c0818add57so270794585a.3
        for <git@vger.kernel.org>; Fri, 14 Mar 2025 13:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1741983532; x=1742588332; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KshCsw9BYsb+Zoj5mw5r3bskLU+1QkHFPw59rvGBRbg=;
        b=iFrOngTtHIw3G3dfPfFzGEl2rvnYDH3wVvjsYUtVVDDMW9dqh9bkQWlglcfMNKcNon
         E3gL9ZDtgM0KW6TgausqLpwsc1I3yXyaOU2LLl2mh5BvBxlUoEgEFyAmG+1m1eyAIygE
         flCEUrtkx3VsgUyheRVOnyGMwuwryJBZey0gxdoBG/ZPBVXlsxRjKx3AFMjs8kzh5cMw
         UubJnx/S/P/y52UiTeBEUqQFGhCEcgC6Qf6ao31oPKhPHA2bioF/HPj+SEPffiFdtfXR
         1Kwizq+Z1TGrasKuG4XN/9yUfpbqOlmELeIeH1dMO6TdcduxssH78IDYZxP7f8K9lALG
         vcRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741983532; x=1742588332;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KshCsw9BYsb+Zoj5mw5r3bskLU+1QkHFPw59rvGBRbg=;
        b=mG18d5vYmykj++d9EB13fThvulK6n1kLVLWUdlqRGGylzsZoC7hL71sksu/yIQ4FsQ
         bV1jl+Spu3c0xaoziq0O3UiHH022A8GhInlOcmwJxG3XIcSMmWhjqNkg5grO9GI3Kc0v
         lZKIA95QlGX1fH3E0Rmtgj1z6eivx6FCNLX3C9MenlNuc00RfVdSK8lVi63EdEBJYxn8
         JaZtimpt3m+FTibnxprntP2vKJYhLJ4hYx/f0Qsy9jHY6f1trwv0C8bWC0bKbscZM5aO
         xtUWXv48/ATPTt8rH/bTbwD91sqyRVkmrdoOS+aMLDLQpDg2auPKL5+4fakhtFgK0CNn
         q6/A==
X-Gm-Message-State: AOJu0YwaaYXctrgauL8LN0x1WIUUqyuFZ27TbzNEsu/bvnNtWtp8+W09
	rWYHxh2KgKi0sVAbuDWN2mseWEJclz8Xd2lj6AUYCvQkZHx04gos4fKEEKx/Fd1IhM4M9jhmZsm
	qGxU=
X-Gm-Gg: ASbGncsbvOQ3ue60KCsr5keipBXRoINIwGqkgZsVSRGREq58MEUQpIAlFYMH0B9wNhR
	hxzdzuOnCz8aTsBgQx9DpuUMCAnJvcSJTDj8xFusgEbgVJ8bWYWXeFOg1szyUdij/5RK0Kj1HL4
	PU9eNM9FrlqnqM/rip0RzW4TdsFG2P+ZYm/28H/g9q6ofvjynK8dJqIV5wxuIYFH4CTBdWShjEe
	R5rywDk64JRybN53Z/aZ4rzCwoqtQ0YM+9WB3wv8Zvd2rJO0ylxDXqX9FRDJZZe22GhRtPP/iPl
	OhNCy+wClvHBWHtCNHpFnsDNkNfRqw3HBVh7OXM7/ligd70i3glVcQuahWmBereA4WpRtGYmwFO
	agqfQaAm5KnCshPUl
X-Google-Smtp-Source: AGHT+IHHhzSJKbyAYFAFi4GVap+ADbRDu048EAh1c+tP4EQqYjHfGJ9dhxzldLyQ248WXeKvWqlKAQ==
X-Received: by 2002:a05:620a:4726:b0:7c3:c695:156 with SMTP id af79cd13be357-7c57c7d29a3mr428971985a.16.1741983532125;
        Fri, 14 Mar 2025 13:18:52 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c573c4f50fsm294636085a.12.2025.03.14.13.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 13:18:51 -0700 (PDT)
Date: Fri, 14 Mar 2025 16:18:50 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 10/13] ewah: implement `struct ewah_or_iterator`
Message-ID: <cb08ad6a62092b9521a11c0524f23bd8831c0409.1741983492.git.me@ttaylorr.com>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1741983492.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1741983492.git.me@ttaylorr.com>

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
index 67f8f588e0..e92341b8fa 100644
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
+void ewah_or_iterator_free(struct ewah_or_iterator *it)
+{
+	free(it->its);
+}
+
 void ewah_xor(
 	struct ewah_bitmap *ewah_i,
 	struct ewah_bitmap *ewah_j,
diff --git a/ewah/ewok.h b/ewah/ewok.h
index 5e357e2493..4b70641045 100644
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
2.49.0.13.gd0d564685b

