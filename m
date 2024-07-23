Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9804E14B094
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 08:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721722879; cv=none; b=s1EnYultb5awV9YHhtjjg5H2yte83/YXwFBgoI5Ot8ExEZZvYCNfcndf24xArZdNtP8Z8A/oQdMajt41Ub+0NBKsRx//TlHdt8d0VyQFh0xBHR//4RE8mtMhoCNPKKrB1pqOIw20lS0Xa4wCturi5Hr64dDhhMKJXQVLvwejE6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721722879; c=relaxed/simple;
	bh=c57a5FZo8oc1XwZXmAykTqE3C++vUFM1nNGdVk7APJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fFOy285oMx5DrX0IhVGuYX/tHvBWul8gm3k2CzvrhDXjWLElGDNgRuYeLw996JstiuCvtEOuFDIPldKQg4jVe2glKlhp9kkqsFJfiOk9ilUfzSR+axo26Eyn+QVivKerWimH2nC3BGREP2QeLjwg4uz6LVVx4U0wv2rxi1brVtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B1xzti43; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1xzti43"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a7aa086b077so15712266b.0
        for <git@vger.kernel.org>; Tue, 23 Jul 2024 01:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721722876; x=1722327676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dGFI5dxykS0Ye5JgwzTOfeSKS/2TqbyMZWuGeO3hO3Y=;
        b=B1xzti43Sn5vkfUcSoiLOVQIVTw7IR9FTO3jMCGYu7Ld50s6X+IN2YlMltE2s86yId
         06gx5J3nMXn9V0ClABjjYeInQhv3FdZAxMze8ExSxLWUrYuR3oKBIdO+7zTBSeMDl0XE
         ITivgNgJ47DmPv3iBMrrjJ7QlFB1ZjQ+elpfeNeuWHlUpZrEKaDzBpIfMPfL1Vc2CyWj
         lksr4ZgTzLUy7ZXrSxtlueGguOYKA2vRYiWNPbGvFtlumwvrMSSirLiCYZLyUlHmZn6F
         JR8y0nFajOohnIrsvvhosU3BpSRr3EH1KERpeVH8iaAHrh2Ap/5wue2xsRMcwr2Rtry0
         BeCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721722876; x=1722327676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dGFI5dxykS0Ye5JgwzTOfeSKS/2TqbyMZWuGeO3hO3Y=;
        b=ByCPzkycMSPtLrA1JAyZmHpM7a69KPDIwAqBVu9Cgl9u6X9b+axLr+2/93GeR95AB3
         S8AqIBAQ3/dEzSWp5sNXxNBIDo2ciBICudGNi7PkQzhhYXeWLs3Zy+q/2jsDBekc5wYG
         vi5DHnOmrW6FyTCtJI1ZtNsa8cUOlx19tGdazSR1YKmJMq7k1jbmiE2X9KSUto7psCUq
         JK2pejHIxIVFXoJpS1lferFYkDKs9b97TGz83Ul6+iEcwblX6G/g4/B8i0m584xvXDCC
         iPuatMg2UA/blK4/LTJS1xSMVLLv+PDVJ6ZN9hHKW0NhihZBfW6JBR+lBubhwc9tiwwi
         vHBw==
X-Forwarded-Encrypted: i=1; AJvYcCUESPOPZuq1qfFEZc3j0eZrNe7R/w4JYae5MAC0orAwF+XcVVcxy0Giv/dBbpBgkSWUgXKmzNAUy0NZEJ2QEBNB0VLz
X-Gm-Message-State: AOJu0Yy3nh6wxjlzzc9bem6z2kTnU8603AjAVbJYrLS2gyd6ZzYno328
	27bfRvjnJyuHLrzJL31WKdMzynCHx3WbF67mlQwLcoNzGODB+pnn
X-Google-Smtp-Source: AGHT+IGn6eR1G0ifflr5Alp126/GGKm2dk1FB16ExrX39TkmK4PGK46ZNRxRIHFA3g9qR2J871nqwA==
X-Received: by 2002:a17:906:7950:b0:a77:e1c2:3ab with SMTP id a640c23a62f3a-a7a4c41487dmr648638466b.50.1721722875778;
        Tue, 23 Jul 2024 01:21:15 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:45ae:72d0:1982:e034])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a9f463194sm24026266b.112.2024.07.23.01.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 01:21:15 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: chriscool@tuxfamily.org,
	git@vger.kernel.org,
	gitster@pobox.com,
	jltobler@gmail.com,
	phillip.wood123@gmail.com
Subject: [PATCH v6 2/6] clang-format: avoid spacing around bitfield colon
Date: Tue, 23 Jul 2024 10:21:07 +0200
Message-ID: <20240723082111.874382-3-karthik.188@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240723082111.874382-1-karthik.188@gmail.com>
References: <20240718081605.452366-1-karthik.188@gmail.com>
 <20240723082111.874382-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The spacing around colons is currently not standardized and as such we
have the following practices in our code base:
- Spacing around the colon `int bf : 1`: 146 instances
- No spacing around the colon `int bf:1`: 148 instances
- Spacing before the colon `int bf :1`: 6 instances
- Spacing after the colon `int bf: 1`: 12 instances

Let's formalize this by picking the most followed pattern and add the
corresponding style to '.clang-format'.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 .clang-format | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/.clang-format b/.clang-format
index 5e128519bf..803b274dd5 100644
--- a/.clang-format
+++ b/.clang-format
@@ -72,6 +72,10 @@ AlwaysBreakAfterReturnType: None
 BinPackArguments: true
 BinPackParameters: true
 
+# Add no space around the bit field
+# unsigned bf:2;
+BitFieldColonSpacing: None
+
 # Attach braces to surrounding context except break before braces on function
 # definitions.
 # void foo()
-- 
2.45.2

