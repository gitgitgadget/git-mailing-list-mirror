Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1819224CC
	for <git@vger.kernel.org>; Fri, 24 Jan 2025 22:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737756983; cv=none; b=ey+Z9vc1L9KVHqrP2jsGWHG0Ce50hl1JsajrZTp0d6lpuYSQGwJzsoOsWYc21ydyPtPGh2Mv3C02kRndSVyI/xJWBRxlH8Phq/S26PbW2NWx+W2UPRHyvg8YNS4Fp4CrO4vvD6t/7DwSN0Af6/CMuYhKyL37M+ejlHhG7a61vA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737756983; c=relaxed/simple;
	bh=OJ3OIZ0m4iE6WxzLUBop0oNh6/8Axgfb6CPcYCnkyRs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=fQa9hTAZLsUHXpGBQpSjYpZuOWwb1oZbEt+ftNPPQNu53fTF/Y6uvMvtwa9E3wsUAj8vMEVU5nXkflLp8fhOBwb/Q0M+gtBVr0DTAfFlW3fIjhe9VyQ4OmEul0Qsu2+MsdGIaLTGR0H+o+2pIx+DxVcqP4BnNPI391DohWLbb58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dXBsu3iE; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXBsu3iE"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4368a293339so28652155e9.3
        for <git@vger.kernel.org>; Fri, 24 Jan 2025 14:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737756980; x=1738361780; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EppaanOk0NgyUYvWTzbOw/7fp7fWZ29YgC/252K1dBs=;
        b=dXBsu3iEpTtt2w7Bz6n2/pRobaOgfn3wVGB5nOZ4Nj9Hud1U0OHcBWuM5q9FCOiwfa
         C5SQrrOOm5u+EvuzGkAbGg2Gm++yzy+W+QRWyXNDvOxXuKQOVu9pkGbq+zHvT2likh8V
         9ERW8xPkSOV5poLxoo0rkpYn8JjQu4/DbN0LaE986ilqT5NZJvMbITdOrCZCSY2Rm5v1
         4rGreL8y7t+U2s8QvXzRVVYRpfuCDpWCGaRF46BCfZ3q+RuK5xPODzvT2ba0LXATaMyA
         dCo3WEJOpaUHZlfG3eAsfdMYP/IdM3vBvPaxYj0+XZKU6rykH4g1L8rZ19/IM538H219
         0z3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737756980; x=1738361780;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EppaanOk0NgyUYvWTzbOw/7fp7fWZ29YgC/252K1dBs=;
        b=bpIrocqw7E/n6D+5rEb8uZML+GAGvYxnuFfg78CSIBBlGDa7BMRUna/M09UGDx88Wn
         HjeYBr2MvDTz8JDIspO6jrmyYzjiWzvXb32gRacrycze574dl9OSHN+evPldXjsJbBXe
         EuoE6JJ8Fux0JsKcCsr4JSEIOD3b39mzSfiLzul7pOsuxZFBHyU3Ah3RaWYtbxDCqgEW
         Xy5htIY3Ch1RdKsKvrEgijwTxKCnVimI9HPTMkHNIYci3qbSv2a9axevo2BJdwel5vaF
         BRvJKYyCfeSJnwBfETD1KQiAl6mfnzvx90xw20ISmjN0bAMNw29ogI/Z7GH2XO2Y2WhU
         EWtQ==
X-Gm-Message-State: AOJu0YzMaB8Np9iuIyjkDsSV3X5a6VdYAf/3juVOTNSkVovrPvd/zAaW
	q7orwbaEzZqMn1nwhPDENqkJrTFkih+U9ewD+pANErRa3R6vkqoW9NSY5A==
X-Gm-Gg: ASbGncuVjfjC8ygRkGECfSOakurvvhK4MVAj0Wix+Mjm3dAX15C5QMPGVkI21Wj1oQs
	h3/9940BtdZdR7S1qlB+5pqR06gaAtfztqDo/FIimJ87D4qtNNOFDbq5wtIOr/NMM+Lyl+7+n4d
	TxflFDTrPfvZJY+EtasCkwE39d1hHE9C7t/kAbVuzOq81ZJZOIB0DrZ3Qgj7mQh1uQwfAX2DALz
	TrpPeLDmzrAc5Qzh3dvh4XO/7wXkLxj55EV1rUryw3OAfeJIsTVVT1v3J0CkTwLf9y3u0zaYiO8
	7mwCmJkub/ozOD0XXr9N8yl13eQmZLtC0x12+00MBkIXbh9bOM8zVlHwkCNUcYy2Fw8=
X-Google-Smtp-Source: AGHT+IFjn0DgbnX7j+p/jEJwBi4wJeSI2kRrLQA/NUibPqpDOiyKu3ULmN46I3vfCxQIB8jsXCaIBg==
X-Received: by 2002:a5d:5848:0:b0:385:e37a:2a56 with SMTP id ffacd0b85a97d-38bf57c0551mr29270470f8f.52.1737756980129;
        Fri, 24 Jan 2025 14:16:20 -0800 (PST)
Received: from ?IPV6:2a00:23c6:54e2:6501:5c1d:cdba:292e:e40e? ([2a00:23c6:54e2:6501:5c1d:cdba:292e:e40e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a188915sm3826581f8f.41.2025.01.24.14.16.19
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2025 14:16:19 -0800 (PST)
Message-ID: <13c7a38b-20b4-46db-87fa-3ed10ebe4ada@gmail.com>
Date: Fri, 24 Jan 2025 22:16:17 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
X-Mozilla-News-Host: news://nntp.lore.kernel.org:119
Content-Language: en-GB
From: M Hickford <mirth.hickford@gmail.com>
Subject: Subject: [PATCH] RelNotes/2.49.0: improve a description
To: git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


---
 Documentation/RelNotes/2.49.0.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/RelNotes/2.49.0.txt b/Documentation/RelNotes/2.49.0.txt
index bc82217584..af76f07d81 100644
--- a/Documentation/RelNotes/2.49.0.txt
+++ b/Documentation/RelNotes/2.49.0.txt
@@ -65,8 +65,8 @@ Fixes since v2.48
    using Python's http.server class, which has been corrected.
    (merge 76baf97fa1 ak/instaweb-python-port-binding-fix later to maint).

- * Document that it is insecure to use Personal Access Tokens, which
-   some hosting providers take as username/password, embedded in URLs.
+ * Document popular credential helpers. Explain why credential-cache is
+   unsuitable to store Personal Access Tokens.
    (merge a90ff409f0 mh/doc-credential-helpers-with-pat later to maint).

  * Other code cleanup, docfix, build fix, etc.
--

