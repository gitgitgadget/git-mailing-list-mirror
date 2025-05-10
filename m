Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0022820C489
	for <git@vger.kernel.org>; Sat, 10 May 2025 23:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746918738; cv=none; b=k0rXvHcfQFplei06yJZ+giGEYq/NuGY+EkSbRjKZqrAFHXscw3+sh3J4wrzLZQEVzF4T2t2cf5BtubJSo5KMtHud4KO8b7N/Qu73QH92V5jGpdjwlCCIGXVyJTvYws4+P8EDS5pUHvxFgM9oZOFdL2j+KYnK5ABkzkHUgwXx250=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746918738; c=relaxed/simple;
	bh=Izsn2RCJAIoDsKqg9EV5JdQRF6RE0MOSeX7jzArFoSg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oS1+npPA/9qcJRu3MA8JZ1KbhYIRIzpclFXs+21s/dL+0di/iUFYMZRoZtLmIwoKvhQmzt3iiQqn02JS+JAscPE5330ztA5KtU4ANfO4VEZhrLvoQvOYuyQyfIxgm2x65pDm38m4H0fJ24AKl5mVor8nhrkhEBjE9zdERVlgBAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MFswj6na; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFswj6na"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4ddb0fc22a8so1159960137.1
        for <git@vger.kernel.org>; Sat, 10 May 2025 16:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746918735; x=1747523535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uFdajRRNcHCjp4iosC7DFSVg21ucQmSoXhN2uXFq1d0=;
        b=MFswj6na68h5IcXQ2ft+MZqBReMS195vRirycpabpYQR5jY0ztVElYTBsTS4vsY1Id
         2gnDQLau9ZyAQ+kKtbLFLdU+EkZg2XkF+Wju/4pYRMh4Mh2KyAZrY0sRAvYsexUD3o8l
         EML3WVk9VooZ7yhljGpBBtDudc0qG2+h34vwb6gRtcuncQrMm1WR7aYNFiwfKAM4C2YZ
         +abddaZ4Ud9gYeuKPH4PbpVBHc/q5oeAqxxnK/Ii20eyqJw5zyMKalcjVio2ru7cCJMk
         jxmJDlPokIM9s4o8EGYz6Y/uyU6c31Gk+ABk3Ha6h+FklO/GYcu5pLzgghifjBEp/UaW
         RLyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746918735; x=1747523535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uFdajRRNcHCjp4iosC7DFSVg21ucQmSoXhN2uXFq1d0=;
        b=fQaRW9umJPVaQIRasgRHkHelG0UYEwhhAZLjeCxtDMVkvbgeoEf4jh63nH+YeGY/+F
         ga/uphpwnw546r15kwzmWVd2eJp5Mtvb+rnJ0U8RqpzsvTBdmQTQjq6rnaQjY55z24M1
         Wq+anYH+9EOQvLABMF/1xjxL12BYnsrOwzMGdSp8e4yC6OhlYV3A9io+WpAdF8UXi7/q
         QEqvM6h4D6Ri5Y1S6Z3sZXxAJxdeVEHsiJVSSVeM+PfO23u7WU8pINqM5TD0ME0sQr7N
         2b2jko/y5Z4ElKbQPHha+O/y487HMeLw83qzy+fGqQ+mzRyzJ1IMGjsr+eQo+5lwoK5O
         hE5w==
X-Gm-Message-State: AOJu0YxojbVsFYRGmwbRde29tu9y7kkUTKHyq4ZxeGks4T+jBzjEF6c0
	fayGgfJxZvfaQADR5c3QkVew2dI1aaZA83R7kzDUSFFmU38b0czy83FL8g==
X-Gm-Gg: ASbGncvA0Xl8xeYMDefaOCDgmKn1/81OT4Wod9766GqNVqWKlfCSG5HTPr4vbTj/qI4
	IkNFepth/bUbnOfttnvgX2u19vaF4jk/gqtIW6u7XvCWx1gith9Gq1AE2VVvDMhV5c92KOaE2TD
	hO75duFxCBER2J17SY0hSVWOkQykLR6CxOeXsDIi7ETqn8JtF5NbaqQwAbx7oxfZJtbCxpYWxf5
	DFW8+tdxGd6mGs4zEtCi39WsXU4VBlX9HLFAcvwlZFqIcr0SQkbnC+FcPxVmgytQO/NSjNYytlY
	HanRgUQ2/Pto3K2O5UNlnNSbubp2KlTJR77izLju80/H7l+pepFHCVPd
X-Google-Smtp-Source: AGHT+IEkRJK3GkLi3F1AnFIcK9AEDIeCByL5RL0PO9rmKyRST2naEUvCv9JSDwK9juIUbTFiGoPstQ==
X-Received: by 2002:a05:6102:2b99:b0:4dd:add1:d7bf with SMTP id ada2fe7eead31-4deed35c730mr8256466137.11.1746918735074;
        Sat, 10 May 2025 16:12:15 -0700 (PDT)
Received: from rodrigo-pc.. ([187.101.108.231])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-879f6171564sm3047085241.13.2025.05.10.16.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 16:12:14 -0700 (PDT)
From: Rodrigo Carvalho <rodrigorsdc@gmail.com>
To: git@vger.kernel.org
Cc: Rodrigo Carvalho <rodrigorsdc@gmail.com>
Subject: [PATCH] t1001: replace 'test -f' with 'test_path_is_file'
Date: Sat, 10 May 2025 20:09:09 -0300
Message-ID: <20250510230909.65519-1-rodrigorsdc@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'test_path_is_file' is a modern path checking method in Git's development.
 Replace the basic shell command 'test -f' with this approach.

Signed-off-by: Rodrigo Carvalho <rodrigorsdc@gmail.com>
---
 t/t1001-read-tree-m-2way.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1001-read-tree-m-2way.sh b/t/t1001-read-tree-m-2way.sh
index 4a88bb9ef0..2e8d9384e1 100755
--- a/t/t1001-read-tree-m-2way.sh
+++ b/t/t1001-read-tree-m-2way.sh
@@ -362,7 +362,7 @@ test_expect_success 'a/b (untracked) vs a case setup.' '
 test_expect_success 'a/b (untracked) vs a, plus c/d case test.' '
 	read_tree_u_must_fail -u -m "$treeH" "$treeM" &&
 	git ls-files --stage &&
-	test -f a/b
+	test_path_is_file a/b
 '
 
 test_expect_success 'read-tree supports the super-prefix' '
-- 
2.43.0

