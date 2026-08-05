Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853423D4116
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 18:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785954675; cv=none; b=twG/ymxyJVmdM0NBTNytGK16jXIsHDv5FpX9ovkPaNAyp/7Y5/vPxMHJiDOkbogjMEin8cdWC2B0oSvkPCkCjLRKIR4bsX3Rerxo5NyhNkWdGbvFYnWfViqVQUlAk0w5+Yb+3T+3RQ1LxKANk+OViON7DoxuQ1h7+EjYKlsfdxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785954675; c=relaxed/simple;
	bh=My6xMcWiSQRC21O7e03KbFzyG+Lek3st4bEshLposLE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=BIw8fiLGlENi85wzaaLzMLuG4ux3iKkluBZfshZkHP1pjfEWN3aqp1j6tsEdYqHVHZrIjizniyKqpegEoDxquTRu2Wy4zy9oNvzMEG3LTwge5yNtdfVX17WYKocbUruN+1xUvfunvaHxnG8/Hua/sG7H7ptp7rNtlWwbKL7hQZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h3nuD1/S; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3nuD1/S"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2d0407aedd6so16179075ad.0
        for <git@vger.kernel.org>; Wed, 05 Aug 2026 11:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785954673; x=1786559473; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=czqKAQJUC/S5g5U+hEUPK7DNG0qtNEtNKLR4YJglJmY=;
        b=h3nuD1/Sh9WqgaHlK3V2a82KPSaBBPVrNCjUGYo6nMtHoWJ95KfrrFlihmwrTyQfDB
         3uPk9I3M+545APcU6u8iXZoBaGXk0xOiYcJYh+pIQ1/RYdmVQdoEwYaCGPURAIvjhhXd
         /eLZiGdwQd9XkAxjANYruGy4fCeIqew029IIjwAA1NdF69myhmL7WragRvpjSSi2QqhS
         Ne3gAbNF/Q8BiN4tK+1vJ0CJxIWM0vyn3jvQTLkAM16aEPCiHIhrVjBM0QR9bcHMH8ZA
         DiqhzP9saQpDrINbD4zscCoC+FoeSv8hPZpoVhU32NkeRDRCNWCiifa+Jf5IkBoSDOy7
         YkdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785954673; x=1786559473;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=czqKAQJUC/S5g5U+hEUPK7DNG0qtNEtNKLR4YJglJmY=;
        b=kJy/hkzph2CqWLoNtYB3WKqwSr8tIyZ3O2ZT5Ml0mj7YqRxnATp+S981gw+FiaA953
         if3qQrtn1jFh/HA1dt2+sl2QHtODHPoGNd+MKDQbyhG4wkmNNYRuov3jWoO/OeBL9BCF
         sf03Sc+zDU1z+0MN8DeMQFSyxJkmbdkD8fChVQx4CTS6FCN/CfPH1CusU8YouOzLZFLB
         Sxlx2l+h9+irqWXVqET8qxXhuqNfFLZV4WsL6nuyPuTygbVl6fFmfPCc6uyoomwOTUbn
         HBEclHzItlx8yLz9qUhWQoHywa20VdToz4BXmaT6Goj6qW7rOCirlVLvLMoCZNgk57r9
         wCvQ==
X-Gm-Message-State: AOJu0Yx/w9jXI42Ws2UHY09MTpxRVuGbO9BhqI1A5rK5AazCCKbY9nDK
	uj0WNjeADoQj7luaUqYYg8doHDq+WdpOSCc/rPOMy0ZxaN3xawNEU68ZTdSp9g==
X-Gm-Gg: AR+sD12sOf2gnXDVRSlu49YAAgR7RjcY4SDpdTTce1G9B+Mc/yZRv1+OHcsVBKio2gZ
	xYGPakL9XsRqWqy6fRMKGiI8hYIACYpEH/9VSosc5uKH0oBQrcWfsO6kKkevOVDdeYLRxS/BsLQ
	kwdHExYfbh8BUzzGn8oLvG4spdURv5t3P36m1kJnE6PpGx7q+2wmWyMwyJycWtGn1eYzl0a5XgB
	/e+1GQdM9DzRnSmy4NHtWQtevV1Rzyg6u3jq3yiND1IPyVj4bOh6dI9PJZFu6PZxDU78gmaU29I
	/u6iR9S2svmz6Ky8dD2C9H4B115eIBZBIp7PkLThSTbkSYRZYw23eSE/TGahyitF8bcOO5oT0FN
	M6ej+nTakTdyd7ZLn1RQrx70nIFzlPmSdzWk2iCJ8WxCnXsbyyZ0Byb8dI386X/V2scFN1C4vMm
	4Fbplr7m2vyhtEgX+BRJUGL6BxJhoaIWvGeg5U6SrmmaV38O4ixWK2Bg0oD6uUswr60Q==
X-Received: by 2002:a17:90a:d644:b0:38e:2860:253f with SMTP id 98e67ed59e1d1-3903c582511mr9390932a91.12.1785954672780;
        Wed, 05 Aug 2026 11:31:12 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.220.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fee06b438sm5325431a91.16.2026.08.05.11.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 11:31:12 -0700 (PDT)
Message-Id: <f0b1e13979bc41e10ac9fe7b042d8d4c1191c411.1785954661.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2179.v2.git.1785954661.gitgitgadget@gmail.com>
References: <pull.2179.git.1784069325.gitgitgadget@gmail.com>
	<pull.2179.v2.git.1785954661.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 05 Aug 2026 18:30:55 +0000
Subject: [PATCH v2 06/11] compat/pread: check initial lseek for errors
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

git_pread() saves the current file offset via lseek(fd, 0,
SEEK_CUR) and later restores it. If the initial lseek fails
(e.g., the fd is a pipe or otherwise non-seekable),
current_offset is -1. This negative value is later passed to
lseek(fd, -1, SEEK_SET) at line 16, which sets the file position
to an unintended location (or fails with EINVAL on some
platforms).

Check the initial lseek return value and return -1 immediately
if it fails, consistent with the error handling for the other
lseek calls in the same function.

Pointed out by Coverity.

Assisted-by: Claude Opus 4.6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/pread.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/compat/pread.c b/compat/pread.c
index 484e6d4c71..ac7d058cb8 100644
--- a/compat/pread.c
+++ b/compat/pread.c
@@ -7,6 +7,8 @@ ssize_t git_pread(int fd, void *buf, size_t count, off_t offset)
         ssize_t rc;
 
         current_offset = lseek(fd, 0, SEEK_CUR);
+	if (current_offset < 0)
+		return -1;
 
         if (lseek(fd, offset, SEEK_SET) < 0)
                 return -1;
-- 
gitgitgadget

