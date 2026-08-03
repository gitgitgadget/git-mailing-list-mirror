Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE56338AC7E
	for <git@vger.kernel.org>; Mon,  3 Aug 2026 17:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785777022; cv=none; b=bE44MwCSnABMHixAwi26BR3eNz+qMEmaKXT5c8OZug9fpgSaCamo/DmTbt7UTPmKPzIYlF1s+kedaK16WY4YEXIY9WCjWOpezE3t2YbUSvluY4EhIc+LfDR6mserpHogWUGblqP0YBQui7JZ2kbwwX5SntgPLmGxiBCgfwsRz4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785777022; c=relaxed/simple;
	bh=J+7q5flpfXMF7AjJ4Y2qaWAVka7L2gnoJOhESFEc/W4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LxgIe4pe/rEdzU1RlsHSpKICorKyDXNg7/7Oc4gdmQlQA/z+YJDrYwVZmqZKBaEgdlB3F/HRlOUQbhMun4TPskyLES21GHCb41SDXA6UgI1uxeYEJ8BLgn8VwmJxwPDK8GizjVCkZSQJIW8jV5R0fYBT8Ta1uCB+Cz5UId5ehK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rPtwCBR+; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rPtwCBR+"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47c2b362ee2so3215308f8f.1
        for <git@vger.kernel.org>; Mon, 03 Aug 2026 10:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785777019; x=1786381819; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=99OKhszIvQqhT9oqeKEHYoC5TGTPtmN6ndBplWCfpfw=;
        b=rPtwCBR+KdqlGHMXieNyWBEgYzwAuyGhdbtUU8VGZSoaDcdGYK4L61v0sn/5YF6+u0
         5vOLUv5pTnm+TV6y+cdPpZFM06S3ycxpqCzriSwWeVHyhxHnT0QvYe2ECDDuTYg9uAgg
         5VBRLGrhpI0j2L/KOz5nMjNGkf7eXKsLF6sHPCKcdiEnsvadPcola9XCrjTeF8G+p1XT
         PofriZXsuEtR8DBbY4zyC2glrCfziXQoojh0JBqb9A2YrzeXieI5GlxjewRVDMxlaOy2
         kiWoIIjMGtXKD3CD4aAZzBeuftcVPLU4/n69XWgPC82sk4BmPnFdV2rX0mvJKB/tlQvS
         h0+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785777019; x=1786381819;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=99OKhszIvQqhT9oqeKEHYoC5TGTPtmN6ndBplWCfpfw=;
        b=kCYfWsgY3aD6SmSbp9fugzxrn40aZhJ89hmAJjan73cRmRdczbyL8+W8F1CxIga5lm
         brCV/PFy85iOQzs8ANAo/H0thZjpD446L2kllWyjcY9coaGHPMnkco0T7WKw0L9/R2vV
         6HL0OH0SmX42QV0WLnkeqXLHKGGvdKqS0scIsplXozgEfROmk5E2MJc8TACgH3Ho6f9U
         5mo0b7ZwLPD64cdE/CCaVvaPTbLo8thYgecDZfV7hO9DdkEODfps2z37Ax8kMXQQha+9
         OIvtTfDHZptFhmwuPo7KdHUU5fjr2L7L9bRGh1jENVpNNATm2LE1qWmdKOeeqnsTpNsq
         yLPA==
X-Gm-Message-State: AOJu0YxK7D/0MGZi0iDUyuZqrGETvipOy4Oy80jCEAVNDjyyDDkqIgZd
	WvaTA4xRcgFtjaFsevkl/Ey+zB3GMyC+DBDGekJE19kNq9ootmf2LEpPYAcmYg==
X-Gm-Gg: AR+sD11HmEn/dxVaz+7trWb6me/c1FsnbvDEyjrPEOQ5h2Mu35DWUUAc5RmUh20kRV1
	xr+SS56hoVC9Xxcy3PgLm/McaAAAmmB49BnjCM+RroGppI72gz6xO0cVYtDU8fhHJP+kmi0JBW7
	eKSu/WzSiNH+xdn4PKF/VFpFb0j5ElRwV/PVt7KJBVe4uJOl8qGEWDxtgyODxHJdvZS3MtISS3/
	4kKQMbn3f1l4teQRhC4qXBWmWW6ApHfGfJyh1Sp0DCAwJo5wqNwwSlcwaJqoeyhI9A7+inrdWSl
	FSo/X2+WL2x/1Zm6sfHYscvjuOVOjwSkCGL2IyHy4tCV1ukbbi8aDOEOOTvC0HxMOi9nyjMf9aY
	QtcQ7mzEDV59GFZhZN44mrH/9yf4Ggap7jlHCLk6EUlArIQNzHV11eG8oaC15jUjeBTTQrVeuxc
	rfDdQfiaOp2IYSddhKkqIfYzX6d/+rMRqq7dEltM5VMwQApaJEvR3+QnKUTe+0svVf9X1dIhOOh
	Ib293v7egDyKhd//7shfaaXzSveAz5k8R5BsMqR9DdCsEE/Rh4UM+ExLzTE0LwPJ03Um4YN53zZ
X-Received: by 2002:a05:6000:2489:b0:47f:96e3:5309 with SMTP id ffacd0b85a97d-47fd729e7dfmr27157609f8f.9.1785777019008;
        Mon, 03 Aug 2026 10:10:19 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd456a5a4sm35218439f8f.20.2026.08.03.10.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 10:10:18 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"D . Ben Knoble" <ben.knoble@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH] mailmap: change primary address for Christian Couder
Date: Mon,  3 Aug 2026 19:09:52 +0200
Message-ID: <20260803170956.1162626-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.55.0.492.g44bba30fd7.dirty
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The `chriscool@tuxfamily.org` address is an old one that I don't use
anymore, while `christian.couder@gmail.com` is the address I have been
sending patches from for a long time.

Let's swap the two addresses in the existing entry, so that the Gmail
address becomes the primary one and the old tuxfamily.org address is
mapped to it. This way both addresses still resolve to the same person,
and the address I actually use is the canonical one.

Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 .mailmap | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index f8ede075ea..d518b388fe 100644
--- a/.mailmap
+++ b/.mailmap
@@ -39,7 +39,7 @@ Chris Shoemaker <c.shoemaker@cox.net>
 Chris Wright <chrisw@sous-sol.org> <chrisw@osdl.org>
 Christian Ludwig <chrissicool@gmail.com> <chrissicool@googlemail.com>
 Cord Seele <cowose@gmail.com> <cowose@googlemail.com>
-Christian Couder <chriscool@tuxfamily.org> <christian.couder@gmail.com>
+Christian Couder <christian.couder@gmail.com> <chriscool@tuxfamily.org>
 Christian Stimming <stimming@tuhh.de> <chs@ckiste.goetheallee>
 Christopher Díaz Riveros <chrisadr@gentoo.org> Christopher Diaz Riveros
 Clemens Buchacher <drizzd@gmx.net> <drizzd@aon.at>
-- 
2.55.0.492.g44bba30fd7.dirty

