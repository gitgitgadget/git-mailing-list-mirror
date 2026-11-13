Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794580129;
	b=Ra83/NbAs4fgoIdtO3TaMyZvLCkOm0q5kzsVxZLRkg6Og5M4j0efuXkEhS/yQ/1jLh/P
	 OZ6eT0DIHQ2RnSdtDBkYcvP0E/xSGMy1qtwAoi4A6bsnxVp8AdRdPXd4CWV5FwJb7Ac6m
	 aMP2t11MSbhqZSXVlZRA3ZI1091u7n2YsMnzvZueGCWATi92YRurJ5w3mXg4d8arIc7wC
	 vGpOGl7Y1YpebL2YHAsw2ooLK7pEuIugjS6Jxqp8OzffawWI3KLue4MBk+UgaEfXQWx6E
	 bCZOV3prQOXsJpttIpSzkyjBll3+hqVq8cBkANnlIY0UDei6IHLmcl0I23pi2vkuKvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794580129;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TF7HE61UWN3qwbvSbDt1QTXd3Thn2U/deOOhW78yQYg=;
	b=HvZ/h3GdSJbvoRCLTdaLAaE8Yf3gULlY1UBg1ILdUy6HZ/6e0CIp17wiC8/IM+oRErk8
	 1Tic8VCGj9XhTLX8BA7SjEfYB57Cwc99wBClNkQA9zuBeCv5yyLrO+Bms2gcfxr9P0TYh
	 1MhhrQysqBnCdaClY5VXB/59MpMt5jMlxiMU8Cd8dlFWYKokijDqnMikqhKJxFA7mnFCl
	 PagkzDtpNmKTcYiMEJl/hVHwOFLlhoeiuHquNea0APkBhYPI3F7/kSsZU4flDILE/3kdi
	 aBrMFpUlsqVWQYatCZbVQSr9vI/c4+635Rjd/McZTyyeYhQyCWKMGrgxQBAD1XJiJQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QDEz2DKb;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11194606A880
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 14:28:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11194606A880
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QDEz2DKb
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4bb55cda775so4648365e9.0
        for <git@vger.kernel.org>; Fri, 13 Nov 2026 06:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794580127; x=1795184927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TF7HE61UWN3qwbvSbDt1QTXd3Thn2U/deOOhW78yQYg=;
        b=QDEz2DKbjPHUnfuX35Pj9+bcCbSIfjKQbnaD43uGvpHN1d/jBn/395nHWEC1lNWafb
         i1N43hVWkqfw38FkpbI8AHUQC1/wJ9U0cT7XYWjbonz4pwp9scdI4kxRAtK3h2xQgmQW
         nr85/FYuhonLFCOSmN4XK5Xz6riERlA12Jt1H3fNx2frAvMlorl7wzGPcv3zeYhOovza
         cDHsEauMWLjX06tEJFecxieeeIyhlHKhogmYI5hDqnyz4BY4E2srNlKSMexiFnNr8i8b
         TzbWGM13w4g2vkSTmSTP3wWgfPUW3ez28SEIj2R36dF/ZxlSlBt9Tn1EDXKZsxvsZS8D
         LtKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794580127; x=1795184927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TF7HE61UWN3qwbvSbDt1QTXd3Thn2U/deOOhW78yQYg=;
        b=keJEHKPzIj0zheizGx5WtGuvinW//FfaZe6NLCXsn6vT+CviXWNu30Qh3x8ctwFAIj
         e9TKy8ngnpNL8WhLxNJajt2YLV3Uu41fNkMDFCXhHP+2RJk4j2Sx88/DHL44yGHtEd/K
         8Y2uJPw1Q8KpjsIwLtXyuyKaRw1PSb2nkdYfWxBOh5vWRwGFMDmgDqAEbVLfoLme09/j
         nCVY87HjmTfbhYVe2NMbzfvSQVdKT44GktYz7FROqAW3ouyNyIhqPt4d94PU8b1J1fOc
         A+/uYqfikqP9hlpQW5tqZxTeJHPZnWYoIFEsOBkGt2u2UWtngs3en8gsIUAyOFwxkeFw
         EC9w==
X-Gm-Message-State: APuU4Z+vYSYXKpa+rOnsTcjPi7NyFxId9lNukmzjhv1nkaYYBYl4efM6
	BcqnSE/+ljqkcETjqkMpGQ7jE3R36UmZ4SqC4VDFGijgNB1hOsysyk0eCABiVPa5
X-Gm-Gg: AYBFou0HyNH3V9JSuRgAZC7GsfKkSzfSF+A4uOhpu+aBPbj2yAbaG+agIZfD7guYlBc
	ZYC15XuesHCEQoXoh7HqPWSQJaWw+oGzv0pZ0LF5Tiql47cGnH4wI3AJWavlTuYOcisVqi4g1eq
	BLWdLuZoiqRUHKuQMyxdAmFI4xfRo3IPteXxKVktOyJ6GSKkChYGuLzoJUdhz1rZenSU8yx7hXV
	xZyBbiq96tSHAeDPX4tTLEgBDSLt4PMM/83RBtQ8chI+tAEeOnHg/3L4YF7pt6kWN7CmstyNMZz
	Qvf1hY9WJaa+kCDSZT5EsrW9+Z2BBQhoaH2uXEcn58m0FWFXhObev9xKqFL/YlQpJK1KvjnDGkI
	QTADbw5Qp2oa0IiYRY5VNFBEUwA+fQdX03R8FfqFkC9dZ2cdaHV5jA+gAzpylnB1ksHDZL+rEfW
	qWg03axHh3zQ+ezPhGcUefHNMUa/fIkfbs17eH77CVIaYwuWF4qDC1qNeZyDz5So0OJpEKv5cg8
	mP6I0kcpc1MEp/d5YwVFOjf3YXyWi/87AJNKcp2wjgsvCSu72bbkmECxppQBERv0uj2XZpoef09
	KyRXVtZbDvAfpf/utvcVbNLA5XaIjDPRuB/kXkapZwYkDSsHDmuWJDyTTEVWNtjnA9GAo9zpkUD
	z7MC2DnN24P7XbghhT6vnpCEkIvAeVQ==
X-Received: by 2002:a05:600c:4691:b0:4bb:5e8c:13bc with SMTP id 5b1f17b1804b1-4bb5e8c13e4mr9747645e9.7.1794580127193;
        Fri, 13 Nov 2026 06:28:47 -0800 (PST)
Received: from KURSA (ipservice-092-208-105-158.092.208.pools.vodafone-ip.de. [92.208.105.158])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb55ac1159sm60033285e9.4.2026.11.13.06.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 06:28:46 -0800 (PST)
From: Caspar Duregger <caspar.duregger@gmail.com>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Caspar Duregger <caspar.duregger@gmail.com>
Subject: [PATCH 1/4] object-name: do not read a peel suffix as a reflog selector
Date: Fri, 13 Nov 2026 15:28:01 +0100
Message-ID: <20261113142804.7465-2-caspar.duregger@gmail.com>
X-Mailer: git-send-email 2.56.1.windows.1
In-Reply-To: <20260212040708.GA1894049@coredump.intra.peff.net>
References: <20260212040708.GA1894049@coredump.intra.peff.net>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To find a "@{...}" reflog selector, get_oid_basic() checks that the
name ends in '}' and then takes the last "@{" in it.

For "HEAD@{1}^{blob}" the final '}' closes "^{blob}", nevertheless we
take "1}^{blob" as the selector. That is not a number, so it goes to
approxidate_careful(), which accepts it without complaint as "now".
The name then resolves to the current value of HEAD.

We only parse the whole string like this after peel_onion() has
failed, so a peel that should fail succeeds with the wrong object:

    $ git rev-parse --verify 'HEAD@{1}^{/no-such-subject}'
    <object name of HEAD>

Only accept a selector whose "@{" is closed by the final '}'. Reflog
selectors never contain a '}', so no valid selector is rejected.

Signed-off-by: Caspar Duregger <caspar.duregger@gmail.com>
---
 object-name.c              | 6 ++++++
 t/t1508-at-combinations.sh | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/object-name.c b/object-name.c
index 6546685760..13e4dc0f21 100644
--- a/object-name.c
+++ b/object-name.c
@@ -712,6 +712,12 @@ static int get_oid_basic(struct repository *r, const char *str, int len,
 					nth_prior = 1;
 					continue;
 				}
+				/*
+				 * The final '}' must close this "@{", not a
+				 * later suffix as in "ref@{1}^{tree}".
+				 */
+				if (memchr(str + at + 2, '}', len - at - 3))
+					break;
 				if (!upstream_mark(str + at, len - at) &&
 				    !push_mark(str + at, len - at)) {
 					reflog_len = (len-1) - (at+2);
diff --git a/t/t1508-at-combinations.sh b/t/t1508-at-combinations.sh
index 87a4286414..10a8c3ad9d 100755
--- a/t/t1508-at-combinations.sh
+++ b/t/t1508-at-combinations.sh
@@ -84,6 +84,10 @@ nonsense "@{-1}@{-1}"
 check "HEAD@{3}" commit old-two
 nonsense "@{3}"
 
+# a failed peel must not be retried as a reflog date
+nonsense "HEAD@{1}^{blob}"
+nonsense "@{1}^{/no-such-subject}"
+
 test_expect_success 'switch to old-branch' '
 	git checkout old-branch
 '
-- 
2.56.1.windows.1

