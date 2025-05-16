Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94432E628
	for <git@vger.kernel.org>; Fri, 16 May 2025 01:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747357395; cv=none; b=nEzA40jeEm2jDWP2qi2SdJ8nCJGrU7iR9WkKmwO1YuMliHZEEI9Q8CcITkHblfngo/evXKEVo0K3ROynDvxW9MdeE3P0CQLcxE2i4UrdndyXyENwejLBUJX3PjhVWKj7jgUcJmrGExaBMcz1pt1w8n+0XvnjDS8L1uCk+yNQCzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747357395; c=relaxed/simple;
	bh=IVJww+4GlLtAMVsokTKMIiE8dQS9CQc+LkulBess/5s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Op3G//GAX7ZNFlYzy3G6Fw/ED9jPid7osjc9E0tsr2oikA0CG0wopcwAN19QxltZLCGx/ROGzkCvZPH1s0B11JaP1fRc9VpI1NkUzjUiRFvjV20uWeta7kALUbVBgSHTlL9xnmb8XwRqBwywefy6aHZMRtT+uK4R1QTY53JuCtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LKakqeHe; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKakqeHe"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-742596d8b95so2129983b3a.1
        for <git@vger.kernel.org>; Thu, 15 May 2025 18:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747357393; x=1747962193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FDAtJ4VTHEsXaoADe3OxtkRNpOW+E1knX0uh/RZ9pow=;
        b=LKakqeHe99eFxkuFDtlunrZLPztujSWbYb0DQCD8t7/5oUBWrSSL7degg1vZmXhYvO
         yjNJyB+j16jDGhq6GtAgE9cTY8pUs96BAfKDdeJD42F70u++AD25eITjdBzdguVU0jhy
         H8Wf9lMl9tVWzllnZuWcDztXfeYzC0U487wppXLp4uR80+K8TZm2sTHutiOwm2WeZ2zt
         2Rq/YBLxd1vkXxH2D8a6ciloHPQRWTgcbtrqpJkWSOZCGm8WIHvvjvUK5UVFKTdSQLyo
         xIl/jq7pdL6KfiOWJVFGZXKQUD0p5BiRLSnAa7nmQw49IN2Z2dn3tRC3ikz+1tnChO3E
         wrlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747357393; x=1747962193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FDAtJ4VTHEsXaoADe3OxtkRNpOW+E1knX0uh/RZ9pow=;
        b=lJqQEvWYmj6Z4Bw4rzzzm0G/sANcfMSgl7cTJ6uXyG3T7FePplKyEHbNiP2Mx7ACd6
         8G46qsHD2LEM45ge8DLhlEvYhu+3KJOqBoGgTQvYlRxTl8EakK03ymkvPWLXF7k+j8x9
         qIiO1ozUIdqjXf5MQLzH8Q+eyT22NSijxrC/slC8ERUdM11EAowkiLq56RxKk9+rVH6i
         xF2UoTwvQ/cKxi0O/HMc2Grszte8UWoI0rYXRSmcxdMnkvvQu6G4lhDnPrT2HL6ot455
         PJ4cToy0HJfqJHM8b3ecm0dUkDwsXIKHp4xeHGc74HL57C14bHkSJ30Wv+jNgasZDkgh
         j3LQ==
X-Gm-Message-State: AOJu0Yybjwq61Xrawd5bCd0LIW0uF7/AxXx+5P8izID9zBjqtPbT4w76
	N+Aw9X1r76bkvWUR2iswth94cw3j+NQGuKRlHbJtgXjRXMvNuxNFUwMiEegbDg==
X-Gm-Gg: ASbGnctoeUQmTtshYCu24nrVLPZJykp5KjPkvz2SAZ0qNsJhrv3o6X3djWyNHKkvEgC
	CmxF38tHRn6eykS3EAaIfo08nQIE3wW+Z8pTbCZx4hmuAbD16hFrlJZlxVXXRpWQnD0tXwqOZFU
	zeOSmp3MSn6Kvoyuc0C+4v7M3dTLDzewKALs7OK1/qDGfQ0oX63Q3/H4nC7mvonCmZDHzuxi8Ip
	UC/53KLk54+nnEkqXiUdZEod2f31KJ6bFBcEPRHoS9PcTXBxXhhJcp069xKNi/AMVAzf7noxpEn
	IKVu8CLts3qIeo2ZAx4WvzATHp/lEn2JAkiJOSuijnPlBZKCGpQoW7i7OamciXxYWGC51eE7n5i
	QR5oLeSHoyr9GlPQ=
X-Google-Smtp-Source: AGHT+IHZN341soxsNlzCpIgddPfEQhx05mgHSIPd2khL0YSDA0ExuZzti96RRWPQGTdlufUYb0tJYA==
X-Received: by 2002:a05:6a00:114e:b0:740:6fa3:e429 with SMTP id d2e1a72fcca58-742a9802ff9mr1584705b3a.11.1747357392625;
        Thu, 15 May 2025 18:03:12 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:32:86ae:c830:7026:45db:9f87])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9738f13sm437329b3a.74.2025.05.15.18.03.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 15 May 2025 18:03:12 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	karthik.188@gmail.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC PATCH v3 2/2] json-writer: describe the usage of jw_* functions
Date: Thu, 15 May 2025 22:01:59 -0300
Message-Id: <20250516010159.27042-3-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250516010159.27042-1-lucasseikioshiro@gmail.com>
References: <20250516010159.27042-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provide an overview of the set of functions used for manipulating
`json_writer`s, by describing what functions should be used for
each JSON-related task.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Patrick Steinhardt <ps@pks.im>
Helped-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 json-writer.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/json-writer.h b/json-writer.h
index 0e8e6c3ddc..8f845d4d29 100644
--- a/json-writer.h
+++ b/json-writer.h
@@ -28,6 +28,34 @@
  * object/array) -or- by building them inline in one pass.  This is a
  * personal style and/or data shape choice.
  *
+ * USAGE:
+ * ======
+ *
+ * - Initialize the json_writer with jw_init.
+ *
+ * - Open an object as the main data structure with jw_object_begin.
+ *   Append a key-value pair to it using the jw_object_<type> functions.
+ *   Conclude with jw_end.
+ *
+ * - Alternatively, open an array as the main data structure with
+ *   jw_array_begin. Append a value to it using the jw_array_<type>
+ *   functions. Conclude with jw_end.
+ *
+ * - Append a new, unterminated array or object to the current
+ *   object using the jw_object_inline_begin_{array, object} functions.
+ *   Similarly, append a new, unterminated array or object to
+ *   the current array using the jw_array_inline_begin_{array, object}
+ *   functions.
+ *
+ * - Append other json_writer as a value to the current array or object
+ *   using the jw_{array, object}_sub_jw functions.
+ *
+ * - Extend the current array with an null-terminated array of strings
+ *   by using jw_array_argv or with a fixed number of elements of a
+ *   array of string by using jw_array_argc_argv.
+ *
+ * - Release the json_writer after using it by calling jw_release.
+ *
  * See t/helper/test-json-writer.c for various usage examples.
  *
  * LIMITATIONS:
-- 
2.39.5 (Apple Git-154)

