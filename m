Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED8F481D0
	for <git@vger.kernel.org>; Thu, 11 Apr 2024 23:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712878347; cv=none; b=tDZv85N9uKO0FBWDkjQHx/+mGWpREVyKldEhB++mfSrleut2JJWGA9ueB0EHGkLLEUMbp29K4ZYBTo95R+/IcRjpkZaAdTIXWf/J5QYt/crDB7IozWws5mvPgqHyHOUrbO1zxygKHUfEjkdZKp7yk2vlgqwxUVtBnNz9IsiLf28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712878347; c=relaxed/simple;
	bh=fumMIhhIOjXaB15SAgFyp3TNFUgimmqu2qWllBUWrCU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=puGlkkv06UaMOJaGsyG+WQ0svIE0YFFJWsecKBLBFHHGvunke/dZ1JQE4IbZiZ/39weaSCR76nbK1sOjm2GHDC/INHZrefwsVSEe59n/BuyDwcsqteHUsNYPKYwu5mJBRI42fT4y6z/AacHY1KieKMDAn4zWPb2GvDoZhtahGM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Es6diJER; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Es6diJER"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-417d029bee7so2643395e9.1
        for <git@vger.kernel.org>; Thu, 11 Apr 2024 16:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712878344; x=1713483144; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f0KpQtM58p0btI4p3VnnhRuIBndaCfiIpHHeSFU9oU4=;
        b=Es6diJER28xgpo26WyGnfK4QL0xhjOXXyd4++Mqqx6UD+Mzktmc+BFbatv3bTQRqMc
         UbxSpAT+cghbj8pG+1XSBSPoHfaeMuMyakBJrY6Sq8rVNNU7vQ8l5Yp/EMyzu5lYD3GL
         uk4kZ6LWsK6mta2MWxPH8hS4xlLbdtz0MO5JgpIFD72uidPbQ6hKq9uVcOG+dyQNpG+O
         bpWE6B3mZLFxokYWGBOO9mhWvrKbpJ4izF5/rQYjXROJcI7bfBkJ/Epq0pxnDXhFS5sC
         xpdO5preiESLBtPE/2IJJj+1LLpch7aLvzMGbBP70ZfJ096AfnESsLcFaWxiO5sClcyK
         qIPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712878344; x=1713483144;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f0KpQtM58p0btI4p3VnnhRuIBndaCfiIpHHeSFU9oU4=;
        b=hzhLyZyXmxEy3yleiH1X2hNlZ/VBZHeJwgDen1ExI/FncPYDVkNa39yD2VM3ftb1/m
         czRibYainJvF3XvUBbJzxoxxmhPDmkb7i0KAsF1Utw1ayGXNOWE3Hbf8xqLudUDOqk/F
         MCGpJ7hevoNqanEMTdtlVh6KGEf+itBX/sYHPEUtcegTh2kg68DtHqmZFW0/DT8qhy7i
         oSQ+KQ9umTa4XQ+NsRkxuqBiibjGbs3dmQnTyB/E30bboNxX/hH+0ozskAlCrO0/rjvu
         0Qr+khY8ww/VDtgUdth5sNpIko/yDcbUX1JSIMI5XGTL9QgeYVywL1FbDaenl7NzUKga
         jRuw==
X-Gm-Message-State: AOJu0YwEeIY3qbYm6Nt8VBAq8I/8r0FauNNIjgQ1wyZONpEiMQEnKd4n
	QUlDgjEsi6bgMzk/dONn14rIqqfCl8v7Gm2bCs1WnK2LVuUteSUxDiol2g==
X-Google-Smtp-Source: AGHT+IHkRqwQgQpkEQbcao7ZJtPDNbPWVmDfwQ1wQfUxR8HX43vSaWU0imOqOoPL5cjpJTYREUMb0g==
X-Received: by 2002:a05:600c:1549:b0:416:af4d:e3dc with SMTP id f9-20020a05600c154900b00416af4de3dcmr979947wmg.12.1712878344220;
        Thu, 11 Apr 2024 16:32:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v6-20020a05600c444600b0041668770f37sm3730543wmn.17.2024.04.11.16.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 16:32:23 -0700 (PDT)
Message-Id: <cd941704176f66d3c98f717beb65a2ce276a129c.1712878339.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1704.v4.git.1712878339.gitgitgadget@gmail.com>
References: <pull.1704.v3.git.1712699815.gitgitgadget@gmail.com>
	<pull.1704.v4.git.1712878339.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 11 Apr 2024 23:32:14 +0000
Subject: [PATCH v4 3/8] SubmittingPatches: mention GitGitGadget
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
    Eric Sunshine <sunshine@sunshineco.com>,
    Kipras Melnikovas <kipras@kipras.org>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/SubmittingPatches | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 8b6e4bf0300..2226c09e6c5 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -408,6 +408,10 @@ are optimized for the workflow of sending patches, avoiding many ways
 your existing e-mail client (often optimized for "multipart/*" MIME
 type e-mails) might render your patches unusable.
 
+NOTE: Here we outline the procedure using `format-patch` and
+`send-email`, but you can instead use GitGitGadget to send in your
+patches (see link:MyFirstContribution.html[MyFirstContribution]).
+
 People on the Git mailing list need to be able to read and
 comment on the changes you are submitting.  It is important for
 a developer to be able to "quote" your changes, using standard
-- 
gitgitgadget

