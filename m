Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C51147C74
	for <git@vger.kernel.org>; Tue, 25 Jun 2024 17:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719337212; cv=none; b=ZhkrXFC2yq5DiJGSPlIrlT4wHGFzcxmFacgWm2I/na0VZhccVZmOYgGlh2lwEHQ56gN/+XlRAUeJBbtKlil8gIwK1TbVw00yHAI/6iggibSbUNmvPPlUfIG+yy/tx4O6bL58g0YWkwn1Adh0b+WSrqcaeHYJhDG7isjzjTtJIi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719337212; c=relaxed/simple;
	bh=/cZ1HueBLXv1D4w+L11jbLDFm1XV1wXUUm6PU473iVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LeKvSBKOrIKJXwmK8Hqga8kFSlHHxcxgjhD9Ym6Su2tK7rarDvE9nDHLfUu/l7QEhvQCS4SUDp1bKeYd8zvsBeHZYMpKkLCKLLDTJmb5bqvvUiJTG1g1UTl6ai4f3sdhdPD3a0nEu7kCYRK8gWrUz7XZ0SS54yPzFyX+Nm8UbLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=cUSZwbJg; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="cUSZwbJg"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-795569eedcaso306085885a.3
        for <git@vger.kernel.org>; Tue, 25 Jun 2024 10:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1719337210; x=1719942010; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rvkxjfmXzuvpa0ad46fYcL5t/G8FT2GID4hxoaI33Ok=;
        b=cUSZwbJgyqUR8gOIAKRnT64uXCFdNI2/CYjoDUsavBxI/tVZM8uiZlovUlzwcr26hL
         rS//3tfLqiFtNUrzGtf7P/NY7QU8JgFy/Hx/RyixPjrz0XGMgv8bJYty8sZ5WOl/6MrR
         59JJUCSm00epHM5rqnpq6RNAVnSTXXxSIGvm4hKrmvCHTRoUcWSmt/+vyCMSfnwDKViw
         lXCvbWFn2ZvmrAbvX2dW90dn9oqHFk/G0sDCzmQ19Oj5shQIEL2hnfWjErav2/sr/liH
         ngv+8EkL5+9CeeKa5E9zA8Tp/+f4DvgAVfTEgh4leGv2SBpWBCiVa8sYOYanqWhvDxJA
         e0Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719337210; x=1719942010;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rvkxjfmXzuvpa0ad46fYcL5t/G8FT2GID4hxoaI33Ok=;
        b=hKCpsVI1r6kArXlQf/u6NZSL2qCspsfg0SHLJ0obI+4Pa8Dh4CF1mFAL0+d/s3+GOc
         e8DbHwijnu9qFRjtXc9M7W22Qzb470Xbsx7rbglK9SHHNZ/j5fgIk8ikYXfpoz/ZL/A+
         XgoajJ9d2fMrcU/EdmS8EIgzkmqUXwOkEZWBMr57Dx9v5rwyqDOBxWTd4hz+JdJcOlSh
         B3VqHJ/21CFbsBEvJ63lMA9amriMwcYzxekwdk+bq7xBNaGqED1HCiAAaWlKVDtDuDwg
         /U/Y9PUvKnk9fyp1EKdlakBXp9DsTjKAQK+LexvLaIIwujHi2JgZ/oYS9FF39kz3bP/9
         CbXQ==
X-Gm-Message-State: AOJu0YzyRzlv+GA7CBtW1VqV1jVGaH9U1eqvuUyJXJFy/jNRoWzvqOqD
	QNTV3Vl4YZAV2q8/g8qakYkIVLtdKfVgZl4jW3a361XyrumtxKg5QlWAWSCLwzsRQzIoDq6qK3n
	CKWQ=
X-Google-Smtp-Source: AGHT+IFDfJD5Zkr6Q/xaLyfE5gNhXB4qSAz7/n/uSvjn4GWXTNrUyPzDGlqs4gXy+dU23/Kqg0Sa1A==
X-Received: by 2002:a05:6214:4c05:b0:6b5:9fa:3224 with SMTP id 6a1803df08f44-6b54099a199mr84670156d6.13.1719337209185;
        Tue, 25 Jun 2024 10:40:09 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b51ed16142sm46863236d6.31.2024.06.25.10.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 10:40:08 -0700 (PDT)
Date: Tue, 25 Jun 2024 13:40:07 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Jiang Xin <worldhello.net@gmail.com>,
	Jonathan Tan <jonathantanmy@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH v7 14/16] object.h: fix mis-aligned flag bits table
Message-ID: <242f023135cfc2301576786172639cc5664d3449.1719333276.git.me@ttaylorr.com>
References: <cover.1706741516.git.me@ttaylorr.com>
 <cover.1719333276.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1719333276.git.me@ttaylorr.com>

Bit position 23 is one column too far to the left.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 object.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/object.h b/object.h
index 669b6a18fa..d2f9de6bb5 100644
--- a/object.h
+++ b/object.h
@@ -62,7 +62,7 @@ void object_array_init(struct object_array *array);
 
 /*
  * object flag allocation:
- * revision.h:               0---------10         15             23------27
+ * revision.h:               0---------10         15               23------27
  * fetch-pack.c:             01    67
  * negotiator/default.c:       2--5
  * walker.c:                 0-2
-- 
2.45.2.664.g446e6a2b1f

