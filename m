Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36BE763F1
	for <git@vger.kernel.org>; Tue, 21 May 2024 20:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716324722; cv=none; b=XL94rVFKiR9teM5Ue2Gkf9qyVIfc343+joIgXjQCwPgSih51NKY+hnyXkptXlihHiwSShTaL2JijHJij1JAzvGpIoXyEB1CKD7Hb76xroXePssdFW1NFkCZ+9w1hb+UPPH7Nb4hQAPO7PKJI0FXhU4oie2zylECL6fCInynpUGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716324722; c=relaxed/simple;
	bh=9JXe4OF6h3NUBcKa5WGvNjG44DdH1oRSnt5Wp8XYDks=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=bMAHy5bzg08KJT9GnMrqxVcrnr29GH4VvJBM/TObY9KJLQkMl7nPOkt5nnSAedKVM1TWrJvxGunQY6/8u0DaQR7ByleIqNLvCXxES1VHFucq2VSNgjCCMWtvfvXtsQHQX7XllzI0AcPt/E7L0TUpfqs+MK8bIplLYKhcbXRrJzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DNXhQcOO; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNXhQcOO"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-350513d2c6aso3236357f8f.2
        for <git@vger.kernel.org>; Tue, 21 May 2024 13:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716324719; x=1716929519; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ykT/gjqQXOzOatYggcHpFMqqS0nyStJOdNbom3DUM8A=;
        b=DNXhQcOOA+RSKz9WrBH6Dwm9Cz/llCbGl0Zdw9bP2IDXLcmnQrHajp0ZeSjrRqBiig
         sacyK0RmOrr5r+pTz9EcbXB8jQ3pNYAQGWiVVCzN7uR17NFmaCw9OV9UEwmoqBlFUPJw
         lhMwMS191D/YpNB0npMDQo67wb5P/UFLX7mDh9YxAsnTJqaOJLtinuS+mJ45o8OjhD6V
         NqDg+7J6WF/R4tOGKqDKmjbqyVT/ocZqQu1OxkvilgLoAuHx7SduJ994Eq6eqmVH8l2L
         OrlSPU4DHWyBrz+Z4aaUaXEDKz/aJgcYvJZn6Ry4DqDsVD4StQNuo6SD+ouOb//y95fN
         MhMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716324719; x=1716929519;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ykT/gjqQXOzOatYggcHpFMqqS0nyStJOdNbom3DUM8A=;
        b=EpGp7FnPGfnbkYoyr4riCrycLaYrTa5SlgPyjH6eTtx6Q7cPowaWfbzqaWywmYJ+fX
         wy1rM6bydNlG2Gn8L7s0Eg/De0byooYpH5MBIndHtbvA9PgnztZhjdUooaL5IevJ1I37
         l1YbJLqKWtA3tOLKNqJJdSO1VF8XsVaqzkvCYP6KK9PKCEqE949sGeYnvVC1vH3ZMQoj
         GzA7NTKEZ9PlsQrLU82+wbDkwgVerxtNQEDduOD3GD0RvoZmp5MxWa0jDdrMhON/zx7z
         6qRsoJ/TBJuCfDDxVC1/i77vUPOnJYXazZx7vLWCkcd1bUOZYp3N7Im1Bkirl8foqzlJ
         mImA==
X-Gm-Message-State: AOJu0YyjsLEt9Yi0VK0Cnp4kxwyzgJg+mWwW70mlJ509b8pCEIFv7C6n
	Pp0dAt0y2fU7Yx/uma+8NOGk59oy1gSrfk9N7pq6ycVW6Hexgdq4MjOWpQ==
X-Google-Smtp-Source: AGHT+IH81ILjfktYhu5w7Sie2eVX1snz9MCqBre6Fg4uTCkPO0ByZjF/PqBYZkJmmScDuHwfO2MzMg==
X-Received: by 2002:a5d:4537:0:b0:343:efb7:8748 with SMTP id ffacd0b85a97d-354d8dafc70mr30759f8f.66.1716324719057;
        Tue, 21 May 2024 13:51:59 -0700 (PDT)
Received: from gmail.com (96.red-88-14-210.dynamicip.rima-tde.net. [88.14.210.96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b8a791esm32712389f8f.64.2024.05.21.13.51.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 13:51:58 -0700 (PDT)
Message-ID: <89511733-fe62-44ec-bb27-106c3d8b798a@gmail.com>
Date: Tue, 21 May 2024 22:51:57 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 1/5] add-patch: test for 'p' command
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
 Jeff King <peff@peff.net>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
 <199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
Content-Language: en-US
In-Reply-To: <199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a test for the 'p' command, which was introduced in 66c14ab592
(add-patch: introduce 'p' in interactive-patch, 2024-03-29).

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 t/t3701-add-interactive.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 28a95a775d..52d7830de2 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -542,6 +542,22 @@ test_expect_success 'goto hunk' '
 	test_cmp expect actual.trimmed
 '
 
+test_expect_success 'print again the hunk' '
+	test_when_finished "git reset" &&
+	tr _ " " >expect <<-EOF &&
+	+15
+	 20
+	(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]? @@ -1,2 +1,3 @@
+	 10
+	+15
+	 20
+	(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]?_
+	EOF
+	test_write_lines s y g 1 p | git add -p >actual &&
+	tail -n 7 <actual >actual.trimmed &&
+	test_cmp expect actual.trimmed
+'
+
 test_expect_success 'navigate to hunk via regex' '
 	test_when_finished "git reset" &&
 	tr _ " " >expect <<-EOF &&
-- 
2.45.1.221.gd3c11dbb1d
