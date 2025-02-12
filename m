Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371D71DC985
	for <git@vger.kernel.org>; Wed, 12 Feb 2025 03:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739330839; cv=none; b=b4Q44xRqZ+ggpZrzhLauymK6Alh1DR6IXAi2dhbK/KZsSnsW/Gdwjcyt/pHMcYBnu2Xh9D17aPqysvGcq0flnymbgiGF5KzJ0Iay35ekP4teV67itozdYZFHFLCNthYgHBD7LdmexYCdEBGVueHZEHY+7xeRR+Tt2tMlARI1c+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739330839; c=relaxed/simple;
	bh=QO444lh6UAGvQI8NufzeyhxcB7Tn6BILaTBGCxPQnRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aA6BhBSBIp10O8IcxkUJZCbvwkFs5PIVBOvt/mfMsZD0d5A2l45oxfgo4Jmk3Sgw5fpqj9j5Lj8OJsm/KuhMKJjfElApygEUUW1R2Xl3tNrySDPq1h447Brg/no2Axx64OUdtFQnYx0yBhZcBZbp+I9UKZlwWjBnw3xmVPLnazA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQrGgoGV; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQrGgoGV"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2fa21145217so10114656a91.3
        for <git@vger.kernel.org>; Tue, 11 Feb 2025 19:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739330837; x=1739935637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=57U1MVJyFXhBLaUB6ZU7XT27Jt1zemFZbnQqBPCbRSA=;
        b=QQrGgoGVZ3/1rO6GuzX3+l+mAzQ+sQEpbMIRkYqCCVtkNHi5iy8FQm8cu1AeN6VyCy
         bd+BTdsVxnXqLeQOtZcPPCpuOImcPvweEXThzQI+Cq6PDQK768LRHrRyZAvkOYp5Vh/S
         9iFIoRNWQVSqLr4LkCWD5DXiwRB6myh+ao6T35Uqo0lGqeI3XH/0+z/BDcQekLDsHcG4
         t2iAR4OyQWHyFhVmsdr1dWR9F5E1+bTn7iMq/s6zD+gsTu2kUR2A/M5VjC9acEtC24wi
         9BOfEIwQzLfhCoyJdIwrrtsX33uYf5Y5iiJAmj5z/0dtrL5/UdBhVAyJ+4xAvX8xL9LM
         jnhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739330837; x=1739935637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=57U1MVJyFXhBLaUB6ZU7XT27Jt1zemFZbnQqBPCbRSA=;
        b=FTarkNXsidn36WzK0/gupmO0TgM1WMlXYLIF3QAOJU7q4GxQkK26U7eE5kEU6ImhY9
         KUkH6RBleTXKG7icly/3GLasLq8OT+ONGWZbbC+PRMJDhZvTehVOvX4laBGqumb271Hc
         vt1Rpy5fWCpnj4N+Z+PWKL6ox781rkODgvtCD3IcYDmvnZ1yF6HsY5DAv39kc1bp3hvp
         Qis/o1hWPARZbqrkE5hD82FXk+kbfW15oQ/4ZDfpjtmTINLv8t+ULbCqg8Q6+gMOOfWR
         4SCkwX6wZ864tI0Wv9AN4tx5dRkQs1NyqHaHUwYIl1mXxT20/9obiTuEXtV7Z11jZ1z4
         i2yw==
X-Forwarded-Encrypted: i=1; AJvYcCXcaEaIXWJku9Z3N6hjMkAZLOhqhwRi4COLDlv2xMcZPeJ6AbWXD2qaD9TLwlzZCQanynk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPXmvz4Q79ElbNv0mERt/Cja0QlHWdOoLai9PeJ9/eF0UMusS5
	YiPQznzeJGtQXxrfA3DhFzpSMQENzeuQu2FD0+u37s9QZq2+8LVF
X-Gm-Gg: ASbGncs/ag7oBNayL1B3NAryid+UdLtvQV1iIN/Kbh9p761UrsT9lyt1nUxmtYqNEiM
	MHEys23kJ3WEPOp95i1gAxSSeBFYQRZGOET488ddGZJjD86nIg9Z9PuVepCZH3TGzHGSkoVPaI8
	ySi4MzpFBom0C2p05ZXhUr+XK7aCEKDXqowL5HIQB9gEfAxOZ93eM10K0x4iKu2bvSD24A6Zfxf
	KcB6AqN7NAA20fqn+yl6gRO53N4Bt5MrSwRSe6NeJVAoxHqghGPC+Gw7DvAeh5DuGfrgxrU7z7W
	N04FltWvvSsDYcnJpQvE/6okOtOawqIQrxDwH+4=
X-Google-Smtp-Source: AGHT+IF8rvxC17BjoptkTCx0jiPHCwbkh+NZID4xOyxHBkuqq1rFBhEi66t24AxpJcq7yMu64gC0tA==
X-Received: by 2002:a05:6a00:4650:b0:72d:80da:aff with SMTP id d2e1a72fcca58-7322c37ebbbmr2084217b3a.9.1739330837308;
        Tue, 11 Feb 2025 19:27:17 -0800 (PST)
Received: from gamma.hsd1.ca.comcast.net ([2601:647:5580:5760:508a:741e:539b:1c5c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048ae7f6esm10129577b3a.74.2025.02.11.19.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 19:27:16 -0800 (PST)
From: Illia Bobyr <illia.bobyr@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Illia Bobyr <illia.bobyr@gmail.com>,
	git@vger.kernel.org
Subject: [PATCH v5 04/10] diff: short help: Add -G and --pickaxe-grep
Date: Tue, 11 Feb 2025 19:26:48 -0800
Message-ID: <20250212032657.1807939-5-illia.bobyr@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250212032657.1807939-1-illia.bobyr@gmail.com>
References: <20250206014324.1839232-1-illia.bobyr@gmail.com>
 <20250212032657.1807939-1-illia.bobyr@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

-G and --pickaxe-grep seems to be on par with -S and --pickaxe-all that
are already mentioned.
---
 diff.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/diff.h b/diff.h
index 49ece3..787bb 100644
--- a/diff.h
+++ b/diff.h
@@ -606,9 +606,12 @@ void diffcore_fix_diff_index(void);
 "                try unchanged files as candidate for copy detection.\n" \
 "  -l<n>         limit rename attempts up to <n> paths.\n" \
 "  -O<file>      reorder diffs according to the <file>.\n" \
+"  -G<regex>     find differences where patch contains the specified regex.\n" \
 "  -S<string>    find filepair who differ in the number of occurrences of string.\n" \
+"  --pickaxe-grep\n" \
+"                treat <string> as a regex in the -S argument.\n" \
 "  --pickaxe-all\n" \
-"                show all files diff when -S is used and hit is found.\n" \
+"                show all files diff when -G or -S is used and hit is found.\n" \
 "  -a  --text    treat all files as text.\n"
 
 int diff_queue_is_empty(struct diff_options *o);
-- 
2.45.2

