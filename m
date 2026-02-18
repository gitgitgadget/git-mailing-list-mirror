Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6020E326927
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 21:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771449599; cv=none; b=cgqcCVv6iVu7VNycszSAUbtUeINuPXh9JgNxFU0lBC7XfLFnDrRZMnVUdNkQzo4vO5FtIqPzhI92T971rv+NHsqn3CaTMNg+/6YdhsHYI2iR/hrRf5lWfA7Yo3fdUm9LJZK1GfrB6+RhxEkScHzTgoCPI7KYV1vHzWUytmZMcyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771449599; c=relaxed/simple;
	bh=n2t0x76fmKsEczEQDXULemT0TiDGgMFPSXkaN5MDxeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YzKcb/u+DxyuHto1DcasEVwHlhrnDUtppnVhDud3nJdG9xeAaZ075NtxN9LS2lAxqgY/l+hHmSMwTzwxwZmt4BZ7xIipMpztURcyUoS6LauhdqBBha+pKylbeRkh/hsBv6FIPH4z9+7QLnxUW87hiuFzWOkCKKBNV6nZCt7DTqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UYurskJl; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYurskJl"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-56743b33c67so150039e0c.2
        for <git@vger.kernel.org>; Wed, 18 Feb 2026 13:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771449597; x=1772054397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K68NDRUNGdsl5f8rO4pWcuGiyc2pypETSEcxjFI+kyo=;
        b=UYurskJlDPey3NNV7Cz91N5bQg/XzIavtInl/3lFwfvV3kBH3kGTRBlczdIMR8JtOu
         JMd99kx33oSm4xkONHF7eVUKA431sjlc4uJS5CyMZZeBA5KKDQbufUiWPa8Lyk5mqLE9
         NihPKbNUq1+lNp83Tp1oTgmOOf4SSti2ZOu+mBMa06K6VvmjqPJSShXfj+zQEjQx/pmO
         89HM7ZcLjNUSozZeYh4Nk0voNDk7H4dGBolhIJJvzBjNuAsg3nUAuVlST+ju00rdrDqw
         hv9tG7S5unFDAaFLmtMeOjYc4tb7mPFFlRfeFgVwgZQo7LntLkPMvLXiBvHLrEXaDPxc
         TYJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771449597; x=1772054397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K68NDRUNGdsl5f8rO4pWcuGiyc2pypETSEcxjFI+kyo=;
        b=Y8Xt18WcVNcFv0h5F4Yd/0dA7WK1n9YIVjfpIE7mIWpXe/VRNfnSX6lBG/RUKN4ES/
         5ZRD2PQ3A0lmV0w9OAHl3m/mqaliIt+aF3Iu4uoPKk9XJxJP7/GVi2+z7IoYK2Vorb3E
         /AW4bqOHuqvTv9talNPDyziFvNYtT+rt2zj3gqfByLhnXHPC8KK8/4x8Y2jt5/tnDPG6
         P3pVtvc93T/Helf0tP/RXi8TtOYsaVXcYU7fkIHceOwIahvNn9dUkdqjqngwKw5woZIi
         Fis1hV2/O2/bzyORGB5jf3ApBsERBEQqSUWmHmBi003LaqGtKk13buSy6UiODpHLAslP
         OViw==
X-Gm-Message-State: AOJu0YybwAEjFmlx/kgGlom+EG2uKdq6Jn3T24QW3jJIolI1Z3O+SVzw
	sNlpWjGQYHJYT9RIG2tB8jbRezCk9MIbCp6BPLaHtqQl5E8GUsctc34KxyazKw==
X-Gm-Gg: AZuq6aJxjXMvldO0WeUqUGIPoElxk2zFlh+/q8+d83kR1o+Ph0izytzC6PXKeJGMe41
	XSRuApMWEvBKdGrRDLwcOlWlnILUOABM40MPxA9fzE4nORCSptyzSS7MFrnFyaZBg3kpyvmCMVN
	KGqd4sdMpXmLqNyJYEOn5322wRTFYngspo+GYTq5kjQFIU0XzCh/VYHorBlA1xIA3voRkMq3OJp
	KxWZoWgPtp/6Y3gV9ixY2QiLna8aWi7SIvTgQom9cqm5W96qHcCrt8H18W+FBDi/6oNgm7VrUGt
	OcrCGRJrH1RYC3wfATPnDM6/e1pistLiV3I8tSPz1qbcLzCX7pkDHcDXUG3RK4kTwju91l15iwi
	2CVtn6O/KK56hTtMQKKgW4vfMMGM9uX0vsu4mrMeF9Sf1X6aWTI4a4l20dwASMktWCXk5OMqPzh
	uw3rLMyOxazXE1fjQ+lgngewHe0AFQKWpwycUiEJjKe72ocqiSB24Qy6ekl7QfdzjFYw==
X-Received: by 2002:a05:6102:26d4:b0:5f0:2451:5f5 with SMTP id ada2fe7eead31-5fe2ad17644mr5275381137.7.1771449597165;
        Wed, 18 Feb 2026 13:19:57 -0800 (PST)
Received: from localhost.localdomain ([2804:14c:c4:89c7:a068:d017:8d32:248])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94afcdc345asm12326301241.0.2026.02.18.13.19.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 18 Feb 2026 13:19:56 -0800 (PST)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	jltobler@gmail.com,
	avila.jn@gmail.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [PATCH 1/8] CodingGuidelines: instruct to name arrays in singular
Date: Wed, 18 Feb 2026 18:08:37 -0300
Message-ID: <20260218211845.96009-2-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260218211845.96009-1-lucasseikioshiro@gmail.com>
References: <20260218211845.96009-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Arrays should be named in the singular form, ensuring that when
accessing an element within an array (e.g. dog[0]) it's clear that
we're referring to an element instead of a collection.

Add a new rule to CodingGuidelines asking for arrays to be named in
singular instead of plural.

Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 Documentation/CodingGuidelines | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index df72fe0177..0158c57277 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -656,6 +656,14 @@ For C programs:
    unsigned other_field:1;
    unsigned field_with_longer_name:1;
 
+ - Array names should be named in the singular form. E.g.:
+
+         char *dog[] = ...;
+
+   and not:
+
+         char *dogs[] = ...;
+
 For Perl programs:
 
  - Most of the C guidelines above apply.
-- 
2.50.1 (Apple Git-155)

