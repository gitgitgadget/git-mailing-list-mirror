Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618442F3634
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 10:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758882780; cv=none; b=HXm8SQBMV0iqf79VRT1Xpq4AcAAEjONYqVMJ3bOCGtEHl0eqvzJt9QXdGf2x3Oh6JSVqyxZqUXi9iNB3rFP+RhZguOXEvKghkyoHKQuCQ7rGJWlzm8jdvRWMYaUTIUNuUHf9psqzoRoSa3ViiMIswEP2KU2OY9OAJlVk5zax1XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758882780; c=relaxed/simple;
	bh=1pcfg0oeF7VgR2qMil4nxrpA0xLpEpO3NpqXwd15VVI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=YqYnX+TnJ2iiGZhRZsqv8ItEdVP9BCnuP3b4LO8cziQ7x9xUbX+dQJLSuE019aMwjqVnmy7Z49q9uymZttZfCJg5bnHW9AT14Uf7J18iqmw/ljEPYNYRsXdem3xTahsi1D3j3tri0R2Aa03CIxDBnqD0ovKY3Jb99uc/ZyLgHn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZOyO1X8j; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZOyO1X8j"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4d41154079aso11187741cf.0
        for <git@vger.kernel.org>; Fri, 26 Sep 2025 03:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758882777; x=1759487577; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JYA4ZJvkdG7KSH+Wn14M0Rd8cAv6f0TimgAcMrFtZBo=;
        b=ZOyO1X8jJ0KZjBZMrrVUfdF9/sNzAE5NmrpEjFPNc7BmdJoUHTSgWV7roW17LJin+D
         s7ESol2pkVir4eC9utTxdnP5w9IsxEdDafOnY5rQQ8C5nSNrDT0w9lk1fml+uODBZVZn
         jqF0+J6Bu+lUzWuTOCchtwh+9IG3Davocr2nV8EtYh70EQRns3EgWevAMP/vLZpOLmkh
         Wls9ogxkWnLdgUwlW8VDvliymidY/kPLvkLmDQxOpybBTpBowsafpPLj6SzEoD09S+f5
         QRzDNKB+njtbMYEXTBbwZaMO3kJ4WqMtqlIwimaVLH4g9ctVhdEXOXfocbGTImYYzVeH
         JpIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758882777; x=1759487577;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JYA4ZJvkdG7KSH+Wn14M0Rd8cAv6f0TimgAcMrFtZBo=;
        b=PZYrU4eDtvu/wiBG6yOVtUPOcDpqDHponVM0ODlDg/bwgpgfRIaZn4vbmNJ8vXbNpC
         9P1fJcHIylRACbiujlDRL5/MigPuCe+sVIqgMY6gRkWBu8RRZppHGFGeadoHSyGhGILp
         6ot4fx5RFJR5KRqPBfUtpm2Ir/EwVYxVtjuAnjqjQKjFbv3LhxZHLtbNs+6E/t9fJqnV
         d+9E2E9y2gtPHOSVT2J+GbKJ+IpnUAnVCXkCHj5cVo3c+W16j8eT+hVPTovtex76yt10
         4Je4x6WUiPu9bN2cbWmJ461GhYKa1AW1queWYbGJlxfNZDiBR4RaqEecZXBOYlKwbnrX
         wloA==
X-Gm-Message-State: AOJu0YydLjCZYfEfB9Cuc6CrTkvL6QH8l1CQ84ecUM7rDzQa+zweG/7l
	SBBAswl3/XR9gZxRuVcyYjnr32e8y/x6Bl/qr0jr3pPplGmsbJCALWAGIe9+ce+8
X-Gm-Gg: ASbGncvx+FyJZa4sqySUbu0IgQjCCvO1uQcPsGzA7Ja9dP6uhYG7FIVD6RQJGslfskH
	Xmg0M/KuwtAyqigy7b/2U+nNXmk1yzKiTockoXqAS6Pj4UuCZ2EdDf7OufH0JDcVyR50m8AfrjY
	2UR3G9YTmuMbGFElEIWTdeISUksHTkL9WTGJ2jxmR6eO2mGxKrkscKCEX9TC9vWTsJ0YujbJ0IS
	jT8M0SzhcWMhIMW+EUhZ9HYpvwh1QjF0LXWLyKAMQd/pD4TnEfxwAeT7xjSIzdanFwcvY1XVbAc
	rGpXL1cXlG3SeeCuMOH/adYoMtObUoq6k2wfu/2vGsJeHWqqDBfwZWo/3gUmeeBwuhFqQXI33zr
	xoDhgGBVPhKBseeJ9O+302g==
X-Google-Smtp-Source: AGHT+IH3rsuE9/XzH/srA+L0n7Mi2Cq4k9neMJJU4Ni7tndgRXW/9oCqPsFKZYXjT2uM+/uTI9h9ZA==
X-Received: by 2002:a05:622a:13d0:b0:4b7:aa52:a710 with SMTP id d75a77b69052e-4da4d126930mr90567281cf.80.1758882777036;
        Fri, 26 Sep 2025 03:32:57 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.87.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db0b9458e1sm23356031cf.15.2025.09.26.03.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 03:32:56 -0700 (PDT)
Message-Id: <fdd1327e7bbc0f42c11c354346859437eb29448b.1758882772.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1974.v2.git.1758882772.gitgitgadget@gmail.com>
References: <pull.1974.git.1758457356.gitgitgadget@gmail.com>
	<pull.1974.v2.git.1758882772.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 26 Sep 2025 10:32:51 +0000
Subject: [PATCH v2 2/3] imap-send: be more careful when casting to
 `curl_off_t`
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When casting a `size_t` to `curl_off_t`, there is a currently uncommon
chance that the value can be cut off (`curl_off_t` is expected to be a
signed 64-bit data type).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 imap-send.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/imap-send.c b/imap-send.c
index 4bd5b8aa0d..26dda7f328 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1721,7 +1721,7 @@ static int curl_append_msgs_to_imap(struct imap_server_conf *server,
 		lf_to_crlf(&msgbuf.buf);
 
 		curl_easy_setopt(curl, CURLOPT_INFILESIZE_LARGE,
-				 (curl_off_t)(msgbuf.buf.len-prev_len));
+				 cast_size_t_to_curl_off_t(msgbuf.buf.len-prev_len));
 
 		res = curl_easy_perform(curl);
 
-- 
gitgitgadget

