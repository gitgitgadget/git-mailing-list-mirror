Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04333EAE7
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 15:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765899237; cv=none; b=HF2MV0SnVcwhcspJ1u40rafNmFDmgW9KtQtDF+fJ8EvI/FyFDPddmfYh+CLVEDjxzeESxrmrwJR2QN67XsNoRknOB9o1+ANwF8+95TAZ9XVuUdC1pOKrqJZrBfbdYK9pzLUrTAhcN/cnLjmaRXDJXiHRFIPvmlPujmC0U1MIUGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765899237; c=relaxed/simple;
	bh=TeMQvmmS18VPjmfAXFzD9/BCzhesy/8vw41OOhopw0Q=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=SOhqWCy6eaz/l9XNuLXHahDssQzMHZ1ZAD4eNcmVb4pbWiSAyqmQfPteU+m/iBRAf2/jp2LM41YFFdQlD3SYHO5uG3ON+J8x4ujXDLG/2ANKBV27Vb/5pcMZ38ZKYRJVEKwIFbCWihtPEwGyntJNi9VsF+YH3fRTRn21d6PelzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VcrA7/lh; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VcrA7/lh"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-88a347c424aso30416286d6.0
        for <git@vger.kernel.org>; Tue, 16 Dec 2025 07:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765899234; x=1766504034; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I3nbzRIThumJblgjEJ4MmiV5Ecs7PPaqybPSRGgy3Jg=;
        b=VcrA7/lhUU/rODNoPm1Jnu7IWBO1apuZ7Lq1UIVIaAWOGWA7aA7gkYKn64EfOhx3yo
         V60kV1bSoKokQYIlEyLG4xzvWh3clJWGeWmbDV++X90QLNf572271J6dMYnENttL5LHS
         d+euxirK16aLzXkUL+/4u8nQpJ7CNe+le8JHdTizRPvRu7KWZ7Ww0HNOrjObif/W47eF
         zQhgN+Iv5ZKYzjHtJaZakGGM0k9wxRd2hGAyrq53QTTYSeONj9M0EFMTSQgGXQuqCyy1
         9i8UIfIFk1PvlCBz1wnnZ/bauGB58b1lH8J7lgRTcnseTeKnJjmn/FgbeKscF9EoTU8C
         2rEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765899234; x=1766504034;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I3nbzRIThumJblgjEJ4MmiV5Ecs7PPaqybPSRGgy3Jg=;
        b=r0h3vlBq4xDE0Yfwma+iyRX+tv8lE0wYU7M9WujICJz2qsAiz4cFXGEde4cbL29oUC
         jD/UrIBwLr9CcmOdWh4zOYk79Sxe1fwOLZlPFmvBrzHgZhUBdLRWXyd3ykVp0KQe4PM3
         KiN+ZZltucBSD1u5+oN2fpH34YDG4iGn4dS1elVQiEmjofvXrZLD+ZlEAwy4gTigdb2j
         1X5nqmUiqU7bkeximL5StqDNGbPOwK8VkfJzO2Qud0Z1NeMdx7xoM/LVuhabI5mswPeS
         SdRaLy3TqZfvVTxKZlwyMakanriIW+cuS45XswEzL0wdV6z9rmr78LY8tdJW5Jgj9G96
         aF9g==
X-Gm-Message-State: AOJu0YwuD5sBQ4hWY8yGoNS2cqHUB9shtkLMedhBSgGOCu26ClAqTR7K
	TlFV3+3MbzfU8nwzTpHDiZLeZl6DlrrWuIZ5CWLxuyQzDdl0OPUikaI9IQh6Ow==
X-Gm-Gg: AY/fxX6fULzfyTn5kp3VlpydRe/wBBUWLfFcw1fmkvpZx87NmxkLIhhXuuAhYTWSYja
	IEik1fyJQwBwPk++SQnUGiVVDL02SLOzsQG6tC9Ym4VMPAdqOUnR87QZK+OZ72Unq+UImvrvErH
	HTewm/Q9+t5EwPvijTbmmHAxBbE+hrh0ET2NQ74Hv99W2PhdZucWZo7FzDj89A1U1O9qZEuOtbQ
	ihOPjWFa1jjxLl2yXKx21M0Mp/OUlzpKhjZk2/EWABl7a9djMgvGupu5e/L42nkgzprKI+hprtB
	bK1w8TsxULfMMDhiZF5HIY6yrehqWAUW/uquTb/tuS3x1TOCyIjXHh7BrwJOJ1I+y2nxa2ZMlAT
	ZqhN++fXYGeeR1CNyv1lNT12vULbBOEDvvOYwo6FhcYoaaQP2F7iy//fjy8g/qAfeY4Ve0pTTI7
	cF5kahJbIQLA==
X-Google-Smtp-Source: AGHT+IHUmcivmTRi2yt+fvbPocJQ7lNESQhJCOtNFqw2My9PiABkhO0amOh/HDmxikuH0OmzSxmg+g==
X-Received: by 2002:a05:6214:509b:b0:87f:fffc:10a3 with SMTP id 6a1803df08f44-8887e112b12mr230299366d6.39.1765899234330;
        Tue, 16 Dec 2025 07:33:54 -0800 (PST)
Received: from [127.0.0.1] ([4.246.135.7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88987f398d1sm78128576d6.0.2025.12.16.07.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 07:33:53 -0800 (PST)
Message-Id: <dba281027a8fc49fc152a8d072761ea238aa54d4.1765899229.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2017.git.1765899229.gitgitgadget@gmail.com>
References: <pull.2017.git.1765899229.gitgitgadget@gmail.com>
From: "Karsten Blees via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 16 Dec 2025 15:33:47 +0000
Subject: [PATCH 3/5] strbuf_readlink(): avoid calling `readlink()` twice in
 corner-cases
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
    Karsten Blees <blees@dcon.de>

From: Karsten Blees <blees@dcon.de>

The `strbuf_readlink()` function calls `readlink()`` twice if the hint
argument specifies the exact size of the link target (e.g. by passing
stat.st_size as returned by `lstat()`). This is necessary because
`readlink(..., hint) == hint` could mean that the buffer was too small.

Use `hint + 1` as buffer size to prevent this.

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 strbuf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index 6c3851a7f8..44a8f6a554 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -578,12 +578,12 @@ int strbuf_readlink(struct strbuf *sb, const char *path, size_t hint)
 	while (hint < STRBUF_MAXLINK) {
 		ssize_t len;
 
-		strbuf_grow(sb, hint);
-		len = readlink(path, sb->buf, hint);
+		strbuf_grow(sb, hint + 1);
+		len = readlink(path, sb->buf, hint + 1);
 		if (len < 0) {
 			if (errno != ERANGE)
 				break;
-		} else if (len < hint) {
+		} else if (len <= hint) {
 			strbuf_setlen(sb, len);
 			return 0;
 		}
-- 
gitgitgadget

