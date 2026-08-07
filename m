Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02866353A64
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 22:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786140435; cv=none; b=gpAML1QUEHx1zqpkbNEzKP/jLURhiydB0pZWbReQm+AvM2YUA8zDER+oZQ/3WnhmQgxS8zTKpkZxiVob2TvBqwJY9OiUYw0nRVA+pjjCiHUnmylWIpU4ukilIsYRi1MkUx+WgPKP81KRwadGFGE29Kme1FxOYUZQOiOriNGRrNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786140435; c=relaxed/simple;
	bh=SUnVFvl7CwakfRhybDBKDnOSgzVmmE+01FmBfK2gX0o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jDnjW6ZrvY2ptkoA/bYJrvJYumYagqH0DsNAUqjoLK23b4IPZlxlM7MIKZq2ZTfZuNvw0VSxI57cd6pJmLOB7ILlZ+khfxyW1hXESJzjG7tiR73R/Sw6vayE50rX1lQDbnkxzHFvankGP9L1mABV8J15ss0yw99vP8++o3lpbog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i9W01Dio; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9W01Dio"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-495635a85d2so414015e9.0
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 15:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786140432; x=1786745232; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DE9JDImRbggnFUEy/aIBwUx1YDtqkPOScxx9VXW02Uc=;
        b=i9W01Dio1ZgBSmg8zj6XfWPsVyB5gETtOb+VuvrVl3Y34Cc8VnigBUubFcCzEdYlmG
         /uA3bjihOC/KciwON4AkX0H+9nZZn2lnTy7McPuB98qt4fjE3xsQANz7WcDmAiSAPiPw
         byn3DpLS8y0kPvnM20Tt7OoEVrmnZQBdPMvwZTEv9pDnCVrsLyIexGuab0VgAxR7AmNm
         9MuXU0O7mVkfBlW1W2wrnYvU0NSuTepR3v1wIhV301+9DE1W6lueSjqgKbGd/bWz92V1
         quSUqdiMYGzVh7O2+fSwtmRwJoIRg5hjFUfqrH0eIux3mOwHCL+nI7FGkwQf3L3fDnRn
         hr2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786140432; x=1786745232;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DE9JDImRbggnFUEy/aIBwUx1YDtqkPOScxx9VXW02Uc=;
        b=Lkc4ER4TkfaUGgu69AyJXyB8CmvQNeldaYnRYIzGOl3jGuorzoD8A9euszceO5JC3D
         IxDPNpyATEbBYsHHRCPl8IEJwYpb499aocBpTvs4OeymL2G8o+ICRa8ZFtptXI/igmN+
         RrJDzUKb4yMWmNPpcWL/mzuNGEQtkXnFAeTVqO1/URpA9NseXPzWwrjXtrTwMFcvfYSQ
         WusabPPSZ6y6AT5MpeMJFxpLF96ewRQcY7O2qVH3tilQkUEDKPw89k6cXwrHGBQD6GH1
         Z2DH6dZgtmvuqF+oJ4FpAV5pIS/1goulBhqyLxi39EbRkksR7Z8Yss8DYfpZdHadfQsJ
         ikfw==
X-Gm-Message-State: AOJu0YwH9DCo1vfcDqPWUoNz6ZxAr7Ws9+iG6hIKJqJbfuBN3rjIP8lU
	GNDXeKn4TzPAcYWIhLJRtHahfVCTngKMhIzBxGdUaqkw9fx46N2GjuFW
X-Gm-Gg: AR+sD101u7h1Zltt2cX0Jp9xXhwHki4upCA02ECZ476lTq4YHeWnAjtJcIJ9OgnoDu8
	ocy9TiSyqsctrl6M3uQPRAwzA4QocVrEhEPp1XPYovVqfk+UUR6wyuhwRf4tXdAYeKdJaVpu7oo
	TqKyuT2q6LM1ABcoIc7RLKUh5DR0+uKUuKQ1ruSHVrSggdOaM+BjMq47j6xNS9//pHYHf7fSluG
	WQYSf1HcKJrnPfUSpNPG4es0Qk0BbJeV0oH2bXujZ9S1AcStWzmY3uKFmTUCmUhA32y90MvtZvz
	7gFH/JJECWJEulIiPVq+XWCcrEPHk4QZT3DMGM0pRqToALHqiXq1JfTCpIsPodznPlGHRygR49F
	lMokCGl+CMg/Rr92YK6iCT5giN6avA6XAmjeNqh5VfpApWu3yNVlyMs5I5Emdgcev49/jnnp+8a
	q0AGHIz6OAOCieM6lXEN2iVzvRFhY14Z34EPHS8btqdoRKd7oYac5bjFl5i4iTWskLwV4azNMfd
	rTTfL1GTfuJO/PE5E+T3ptnWYKYISuN8+CZaF0sEGu+mmTxAQHSWsa/3RIV9LD/1IrsrPRuJDIP
	llRa9FCZy8XPHdBYlfqwg2qoJtKSRE67O+mvNgfGrU90OfSPMfxJUzHcjYX/aCSGVzv/z9FFL34
	q7xfTOjFXnfaNEKwtMZ91DBsRMmc4DDIwu2FZ1ru/mh4R691OvdDJbt54bU5+Snh1XCfi
X-Received: by 2002:a05:600c:840f:b0:496:c1f3:e8fb with SMTP id 5b1f17b1804b1-4994e71ffafmr331022415e9.8.1786140432210;
        Fri, 07 Aug 2026 15:07:12 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa (183.red-79-149-223.dynamicip.rima-tde.net. [79.149.223.183])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995c7b4499sm69478545e9.3.2026.08.07.15.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 15:07:11 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Sat, 08 Aug 2026 00:06:56 +0200
Subject: [PATCH GSoC v5 01/10] t5701: use test_file_size() to get the size
 of a file
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260808-objecttype-support-v5-1-86f22bec04b2@gmail.com>
References: <20260808-objecttype-support-v5-0-86f22bec04b2@gmail.com>
In-Reply-To: <20260808-objecttype-support-v5-0-86f22bec04b2@gmail.com>
To: git@vger.kernel.org
Cc: chandrapratap3519@gmail.com, karthik.188@gmail.com, gitster@pobox.com, 
 peff@peff.net, Pablo Sabater <pabloosabaterr@gmail.com>
X-Mailer: b4 0.15.2

The 'basics of object-info' test runs 'wc -c | xargs' twice to get the
size of two.t. The pipe to xargs is only there to strip the blanks
that some platforms pad the output of wc with.

Use the test_file_size() helper, which outputs the size directly, and
store the result in a variable. Because 'git rev-parse two:two.t' is
also run multiple times, store its output in a variable as well.

Storing them in variables outside the HERE-document has the added
benefit of preserving their exit statuses.

Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by: Chandra Pratap <chandrapratap3519@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 t/t5701-git-serve.sh | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
index 9a575aa098..51d5dd1ae6 100755
--- a/t/t5701-git-serve.sh
+++ b/t/t5701-git-serve.sh
@@ -344,20 +344,23 @@ test_expect_success 'unexpected lines are not allowed in fetch request' '
 test_expect_success 'basics of object-info' '
 	test_config transfer.advertiseObjectInfo true &&
 
+	two_oid=$(git rev-parse two:two.t) &&
+	two_size=$(test_file_size two.t) &&
+
 	test-tool pkt-line pack >in <<-EOF &&
 	command=object-info
 	object-format=$(test_oid algo)
 	0001
 	size
-	oid $(git rev-parse two:two.t)
-	oid $(git rev-parse two:two.t)
+	oid $two_oid
+	oid $two_oid
 	0000
 	EOF
 
 	cat >expect <<-EOF &&
 	size
-	$(git rev-parse two:two.t) $(wc -c <two.t | xargs)
-	$(git rev-parse two:two.t) $(wc -c <two.t | xargs)
+	$two_oid $two_size
+	$two_oid $two_size
 	0000
 	EOF
 

-- 
2.54.0

