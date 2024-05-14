Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9B0181318
	for <git@vger.kernel.org>; Tue, 14 May 2024 19:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715716627; cv=none; b=LmCTICpT+gO/N+ZNGPuEdSxobfy+Z84kB8mDWJf5ggghHbC/zV0J6aOC67L4CdD/M2pNZ2xQmE0knKLMGGVifvt10xwTR9OecJnzqcYGZpJZa5N7X0Zm+xHqQpu4CyXVV48DIJrshO44npsJ0iEx8hLKyOyMZLWCsw0YN1lTxcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715716627; c=relaxed/simple;
	bh=ehEDVivmep7w6WGkel4lNQPZf1Xt4TZePOhGGrZXy5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P75CldDwjZ3DrHajIl6JX5F2Gp+qOW/SE049zYP1I8lnyH8/gSd6KlCWaKNlsRA/dHZNQMUZaNHQhdZZ2jhGB+BgZ4nsUTMWKY6TE5ERpNMnB/FJw+SszccXDqTt05a6HhVq0+0wvOBXOWzguHstbj38MsXiqXg+tx2yqFvo+RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=dddn6YLj; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="dddn6YLj"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-792c34f891eso506895085a.1
        for <git@vger.kernel.org>; Tue, 14 May 2024 12:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1715716625; x=1716321425; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zXpcyD6elpXjKhMRArstPpg3pnBL+H9lyD65uiqsPYo=;
        b=dddn6YLjkoN2ENaKF7XQe++slBq3Z05QZSk9Qe/FHt0XB9LHEkJIwNvtwx1mQW8lab
         B44onIVq0d/sGww5eIvUK7XUHxudUcLv4w0QPB2FCqBFqyc0CchZ7BaYWYc9fEiwCUtc
         hru8vtfJFKWjH7Xui2M8EtSuaDGOsWSv1x5jNupdlq7cefwguP/C6gThL3PAz23fmKkb
         Dl14b7FAKslZHfAlcxdszsQTGkAQc0K8QVOG6Pwm1w4Nj2h4ydEp891wrD5pCfpISxcs
         mCBs+j6nFnT90enIiSwNGYg6dXEd+p7QNtlnwCPt7cLsdN0pDXiNEY7Z6QNghZ5FRg8M
         9WpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715716625; x=1716321425;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zXpcyD6elpXjKhMRArstPpg3pnBL+H9lyD65uiqsPYo=;
        b=vKTiHzvYKUIlYcmvPgTY223uYb7Z40fo/9o3QuW9MICBCM0cXSsz9X0ZFY3FNdm7cz
         UMLuivYz3hd86Iidn5QqVPZKVN/1CyJIKb9pq9S2dFy6zliTB/d5oIWIrP2nw4v4M9/i
         ics01Rrjn5+dl5+1FFQp30yc4P9XZKW6Rd0oUbp+KXASqaiY3/QdZdDmW+ImpPvKzvTK
         gR0z6Ay5i1MtEjIV17R1Q+N0dGMeskPD0d4h/ODEpkPe13jt+s6TKBCvtNxNVqNnFoq7
         P67dT3OlPmCQwibsqInolXWO8MaiMCApNV0buET5utz+8o961JhqS44efu9QnzopWm64
         MgLQ==
X-Gm-Message-State: AOJu0Yyvv2QTl1E+j8C6mazYXzjrGZvJfdgtxiA6P67jZ0TybREpgd03
	IVCW0GjNHVVOAoc6+dLaNPyqJ3/42urMhEC3zqu30rceEVjINYMy3HQDa0DtMYNcyNmG4TN9MFP
	m
X-Google-Smtp-Source: AGHT+IFZzahmB72zz7OcBqPCZUa4VvXfsTszbH4/YcS+DJNhRdKglN0BxJq9GAR4seG/mHkFLFpRnQ==
X-Received: by 2002:a05:620a:9:b0:792:905f:667e with SMTP id af79cd13be357-792c759adfbmr1693785785a.28.1715716625267;
        Tue, 14 May 2024 12:57:05 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792c3ef7caesm541282285a.57.2024.05.14.12.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 12:57:04 -0700 (PDT)
Date: Tue, 14 May 2024 15:57:03 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/6] pack-bitmap-write.c: avoid uninitialized 'write_as' field
Message-ID: <f16175295f5c786fea2d56ebffc2b9a6beb07aa0.1715716605.git.me@ttaylorr.com>
References: <cover.1715716605.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1715716605.git.me@ttaylorr.com>

Prepare to free() memory associated with bitmapped_commit structs by
zero'ing the 'write_as' field.

In ideal cases, it is fine to do something like:

    for (i = 0; i < writer->selected_nr; i++) {
        struct bitmapped_commit *bc = &writer->selected[i];
        if (bc->write_as != bc->bitmap)
            ewah_free(bc->write_as);
        ewah_free(bc->bitmap);
    }

but if not all of the 'write_as' fields were populated (e.g., because
the packing_data given does not form a reachability closure), then we
may attempt to free uninitialized memory.

Guard against this by preemptively zero'ing this field just in case.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap-write.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index c0087dab12..420f17c2e0 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -112,6 +112,7 @@ static inline void push_bitmapped_commit(struct bitmap_writer *writer,
 
 	writer->selected[writer->selected_nr].commit = commit;
 	writer->selected[writer->selected_nr].bitmap = NULL;
+	writer->selected[writer->selected_nr].write_as = NULL;
 	writer->selected[writer->selected_nr].flags = 0;
 
 	writer->selected_nr++;
-- 
2.45.1.151.g7cc3499008c

