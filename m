Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C8C40EB89
	for <git@vger.kernel.org>; Mon,  3 Aug 2026 14:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768011; cv=none; b=O81RkldXs0PeRAmXN8KzoZ5oIXp5Zeq92OdkGHDPwkL/p+0ioaiPkjfNObYrdLlIqchVYCiz2qZkl96B3SGQ31kgQbwhUCCzLCqQQFsIZGTx+Znjp2Nd1c8VjRv6acUBAFBQUvNI6JKWgcuZ0czG0ncsPTBtoq+0KlDle0y7Btc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768011; c=relaxed/simple;
	bh=hKA79GnUBgwIB8Q4nDFmuTe1wODwtJrnPExeeUuqJz0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p7GqVjXa8AXzM9PMGjvw3h5WCq/T4OM2gubfmtzahGcIMvWyAl526/iRSUjr/RaEyjMa4337eRjWnJQFlCCt8v4bmHVAhH2U2ZQv/q4CCyhfzZB5/8X9kiNn0TUdcyBBApMTn5LKueU/cWB5fzZW3nZoZgZqWV7UA+9pyTuKA2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rlf5DxUi; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rlf5DxUi"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4953de5be0aso14628325e9.0
        for <git@vger.kernel.org>; Mon, 03 Aug 2026 07:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785768009; x=1786372809; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bV8OoVinir7KgahkdlACxptLnUUMxg6kRA/EFL0xh/4=;
        b=rlf5DxUiESX5BJkI9QmW/OcZKl+NGC+BInoaKg9wci7lAZMkXJsrOYzNnq6d6/SB4H
         +gYBymayHqyK8pQ2uqv7vw9Htk0RXNReRAbSPw8SwrtA0SCos+ftscuU5FHVMoDPP/8T
         Jrpju0sNS+hhIPADIThfawtgAAocanSEdwTeuv/ySIiParRCQPI79tUxB5G2Mfh5acj+
         iW/kav1oS/sEmwoWF0TCfeVhlNNQ8jdzStddGkgIF1rM+m8AGGK2jq1waDOnphOkEmSV
         ArXMeOdc1BTrK0PfTXkZpd+uCWyglCd4TYTBKNEskpFqKd2LkcPoPU+xT/LBrNdLe3kH
         Bytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785768009; x=1786372809;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bV8OoVinir7KgahkdlACxptLnUUMxg6kRA/EFL0xh/4=;
        b=b/YeE49DoPmk+gOCfwvkWN44B1YnyLuKd2G3jFsZn2pCdKOi95buW4Lf9JR/fgHxrk
         EeyvcvwmSF2EgBHbFJpgnP5CqvXRJA6HpiajVMl4jWWIgLv5G7j4slnBjlcGCPa08fcl
         2FDmO3+0TlYyR6dX9Q2zpSOeHjGHEvAZOL+gtVvEFG2FF5I9fHPr/ta3flMBb7wOt6/+
         eKYKro6zom2TuBt4ddSexlXCPbt2qMnbzoi/8Yo3wbFcWLRiFYcL4hxq9nd24v9Nq1mJ
         QaNHIGSs2f05J0FmRvBWXkKZ2qjvAz+c6XPkqIQ2fn1I4s3TIAsE4yYxPAllu36TMn//
         JCWw==
X-Gm-Message-State: AOJu0YyxrX1VbzoTbuTGhQAd7yEPwdb7kfQJ0hikli40ZIFKvKfmjamT
	x/Gc+DhYmTglhoL+P8VNQaryjZhEF1URo/EkifSLmJGlv5sJIl/leNVw
X-Gm-Gg: AR+sD11iWZQveHHR2utWzLmoC8JOwUkCyQwjmmQK8YFqUlIf9PhDW4bHDDKsQNk4xIO
	KREvYT04to013+F5SvmhGYaNBkQnJiVgAKXQjWik4bKzqR+bdUe5QWvtuC5RJ30RKd1Y33TeO5W
	bkwh0Mr0tarQI2eijOwzsjOBI4QjSlkTEPQ2kkJXMVYTrnRC3A2jGQ0FJY1KCw2AK37DiMgwKzI
	HqzaGb2T1Ed9gPU9fqBLi5LkjmYLs32qKx2qEWojQzIdTsSfuIKhnWlRrkoDkpwnxzaxV/O3o6N
	UgccSE8LsNceZFODjqwWWwr3VW6fIr9ZND9ePDabcsoOViviABWXxej3NunezT7MbV0MlMc7DPR
	Ymig0nK5WFTrewn/YdzSSA54CNSSP7U0xH7AIV0dAXtf1G8rDf5qk+QoQJh5icTXTh0cL0N1yaE
	h4OXFAVlX02eeoS3I3szx4OvJzSyfNvEBxXuIqpvavJjZVdF/bCCUfVl6C+fg5NVlXM3p56SLBY
	H4IgTJPqAmyzVfx5F3f2m1DrHn3njl4w7wZjSH1z3r5CQrXeYIZLqTQ/x+hNCeyRIO57XU0hrwr
	ccpai7NolXN1NgPcZ9ZtSzGbbeo8uwrpfxFGmuodG/1lIgMjHJwI/WuQBS/8w/R7003p6UszLaq
	nvTVqeKzZRuWqpP7M
X-Received: by 2002:a05:600c:628c:b0:496:c0f6:78d6 with SMTP id 5b1f17b1804b1-4980c64b5a7mr251687695e9.2.1785768008512;
        Mon, 03 Aug 2026 07:40:08 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([47.58.8.78])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b86d66sm106482575e9.1.2026.08.03.07.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 07:40:08 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Mon, 03 Aug 2026 16:39:28 +0200
Subject: [PATCH GSoC v3 1/8] t5701: use test_file_size() to get the size of
 a file
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-objecttype-support-v3-1-7176fecf7950@gmail.com>
References: <20260803-objecttype-support-v3-0-7176fecf7950@gmail.com>
In-Reply-To: <20260803-objecttype-support-v3-0-7176fecf7950@gmail.com>
To: git@vger.kernel.org
Cc: chandrapratap3519@gmail.com, karthik.188@gmail.com, gitster@pobox.com, 
 peff@peff.net, Pablo Sabater <pabloosabaterr@gmail.com>
X-Mailer: b4 0.15.2

The 'basics of object-info' test runs 'wc -c | xargs' twice to get the
size of two.t. The pipe to xargs is only there to strip the blanks
that some platforms pad the output of wc with.

Use the test_file_size() helper, which outputs the size directly, and
store the result in a variable. Because 'git rev-parse two:two.t' is
also run twice, store its output in a variable as well.

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

