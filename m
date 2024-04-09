Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869F1158A37
	for <git@vger.kernel.org>; Tue,  9 Apr 2024 21:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712699822; cv=none; b=g9/IqJtOjpbjsJdFnm/OQrN6teEJGh9aNnkOx4yWPrMrBywvDqQY7x9RqqwEpKlW7vCxC8T6xZClIQM4rIq5ceDkVhgw7ygKJv/CRzoeXKBQvO9vFIWMu9ZlZn9NzVkS2jc5SVUZ9OlRlsBbyOPucdNNd+b1Yv2OYX7V+gFY3M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712699822; c=relaxed/simple;
	bh=3hy5UwOtuFS4dIc6nIIiKvN+c/YITts//vNu261p+aU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=QNip5ItLlaLxB4PyYem8InztyHt/Gvgmh3u/bOnxdIsnRqzDWdL4EjrMb4asm+UQMvRtRS2tlH/kEH4vwJrwrA/heiAT4wmz9NccUVzEIxpQ5DZz5dxSMqVzHfKLEQdnV4D5Iu30IOf2LMWfvQTMeZGQ0f7Hpot3vuPkBDsko+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X9iBzSbO; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9iBzSbO"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-416c4767b07so1720185e9.0
        for <git@vger.kernel.org>; Tue, 09 Apr 2024 14:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712699818; x=1713304618; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lux/KgFIK1lW6Byknm7s+RfYwSbjJEEB4IGrwl4tIrE=;
        b=X9iBzSbOg2+wpGezbkxJOIhtBajaK1nch1k0b63SWWQbs40oTi7uFWV3cbPXx+6cgz
         7TyyIXNQ++NWAzWJeGWgo7CXJDDWI4Gg6529MiUAW90A18fGIwR7QBqM10zf4gkZ3Vog
         4Ul71JIlNpUGbToxn/d79iJt9u8lxiRaqHNSuziMTe0Bmz11q993vKRY3brAHdxFWFFm
         XJKyCJZYH3Ci5xwDLCeg8xB+5GY9FpQVpExdtSa0OLZ24BFTdVEUAkRxWwcCnMfKSS7X
         ewsRYb76o0lkb40rW9dav8AIZkTLTXMDP3ljkKpUgCp/mR8m/SL7czZ5SXRT2f68SVTa
         Gatw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712699818; x=1713304618;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lux/KgFIK1lW6Byknm7s+RfYwSbjJEEB4IGrwl4tIrE=;
        b=q4JD/N9xJKdia1AKbjwxfVS4s1rryGZfrFRK9U9lPYC9KrKFOWyB7ThxFQ0JaSwqs3
         pXRh5QLVbAU1VCkLdY4aB8EPu4lg7Si1On8vnZ7vsHKqPCvuhhZFpK1ks4QGdD+0/iUq
         l1hTyAAGOI6uzSAiq46Xwi5KtcBpk1tknNnTrQEUEQrweRRL9VQzVzMxkQfn2Ipo7n8T
         tIkmjp3p6upUbMcirn1eus3Ww2cHVPVdEo0eB8nsly1e/vnt1vcGhk0XtvbLxWBkDXCx
         w6XaTPBBSVESv6N3Rahiirou+6lWifXwnGWudfnzIZ7kdkCrubSLAgm+7MRBSQmfcmSp
         7O0g==
X-Gm-Message-State: AOJu0YxKbuyXIRT62uhcYJv8s8cD0s5oF968QjftmDmpqIXexDVB4+9V
	cWB9dDIv7jxnLwIX66IW2ZsHoL05rPz5KyOtQbh1tbJzbkQHjl0KN3iJRMaw
X-Google-Smtp-Source: AGHT+IGaD0fHZJp6UYKb2bbWusnDCs4r+M6Kr/Y4zEHP4B5SEh8mQKhrxWyYL+/e7jPVCejbNMSPKw==
X-Received: by 2002:a05:600c:4e88:b0:416:a6ff:bba0 with SMTP id f8-20020a05600c4e8800b00416a6ffbba0mr672383wmq.11.1712699817906;
        Tue, 09 Apr 2024 14:56:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i7-20020a05600c354700b00416928e239csm213391wmq.35.2024.04.09.14.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 14:56:57 -0700 (PDT)
Message-Id: <1f65dc5ba3ded5b90ed929aa3884574e8b26cd9b.1712699815.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1704.v3.git.1712699815.gitgitgadget@gmail.com>
References: <pull.1704.v2.git.1712366536.gitgitgadget@gmail.com>
	<pull.1704.v3.git.1712699815.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 09 Apr 2024 21:56:48 +0000
Subject: [PATCH v3 1/8] MyFirstContribution: mention
 contrib/contacts/git-contacts
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Jonathan Tan <jonathantanmy@google.com>,
    Emily Shaffer <nasamuffin@google.com>,
    Patrick Steinhardt <ps@pks.im>,
    Matthieu Moy <git@matthieu-moy.fr>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

Although we've had this script since 4d06402b1b (contrib: add
git-contacts helper, 2013-07-21), we don't mention it in our
introductory docs. Do so now.

Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/MyFirstContribution.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
index f06563e9817..00f4c63cb9f 100644
--- a/Documentation/MyFirstContribution.txt
+++ b/Documentation/MyFirstContribution.txt
@@ -1116,6 +1116,11 @@ $ git send-email --to=target@example.com psuh/*.patch
 NOTE: Check `git help send-email` for some other options which you may find
 valuable, such as changing the Reply-to address or adding more CC and BCC lines.
 
+NOTE: If you're not sure who to CC, use `contrib/contacts/git-contacts` to get a
+list of reviewers you should include in the CC list. In addition, you can do
+`git send-email --cc-cmd='git contacts' feature/*.patch` to automatically pass
+this list of emails to `send-email`.
+
 NOTE: When you are sending a real patch, it will go to git@vger.kernel.org - but
 please don't send your patchset from the tutorial to the real mailing list! For
 now, you can send it to yourself, to make sure you understand how it will look.
-- 
gitgitgadget

