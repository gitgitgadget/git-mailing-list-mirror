Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B5240E8D7
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 07:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788765465; cv=none; b=cnoaGD2INVrLhiYcEM2T8qeA8ertPhucCbewXWsDsqD2Te8vsLSRffF3ZSpPDoZRkVQqbmvnIulfkmHSyuEwJ8fVLpjxpj3SpLnzyl8YISD9/maUVYfvPc2Lw0Z8X2lCz8ckygG16rF9Xyj2wMPtZMYVVL08EfQxztPZ2CiS1Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788765465; c=relaxed/simple;
	bh=I8UUNp/uKdvaw3b5IJ7gRM36NSfqj8iP2CcR0ivkYHg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jGkuMq8ZSbHORfBKkpL6fpZv02yRiwFb79MRW02j5PLKSmFcYHWhUOWcCZuglt/1FuD3r0yrQvoQdFxbtbnvKYjZ71dTZcVVCcYLpgEYp1L1Te8Xyn4tec/L87yvEXc5biLV3u/hTxxC6wjIdUPudERalwUElMf1ZsIb1tJR5iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=hXJjqnrv; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="hXJjqnrv"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6b1334a3b16so2305725eaf.1
        for <git@vger.kernel.org>; Mon, 07 Sep 2026 00:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1788765462; x=1789370262; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uDBd+T3QO2ozsWg9nSSCZV9uW24OTsRDIXqyWbC2kFE=;
        b=hXJjqnrv4b/bZ23g/vvLutvn5eV1SHYd8FYesuuaTy/Ot/DwKRIGZs01q8x9oxbltX
         XnPWN3pN4IpzEE7Vn+W9CWRHhffr+ZaeCWERV9/nFAuCsjq01lWDQmtIZ64pLJnZM/LJ
         4sId39zYU1pYO5bJnoYRNAEf8Q66J3Aqg0MW6gH06LOKBtr69DRB0TotFARoGZ4ojGlN
         sWlnZErcxLEHtuLIdCyWhOHzamlv4c+Xx4Yh6mmvSPShp7I44tHFUUyOZ5pH/JCGwUWQ
         ntD2jJHGBEKzXlrYqSNSHYxVMU6ayMdOmKnja4m9RSm1L3yKDPFqeFvNARhS1XrDFE0n
         qzGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788765462; x=1789370262;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=uDBd+T3QO2ozsWg9nSSCZV9uW24OTsRDIXqyWbC2kFE=;
        b=JPww55Ph6m8Phno4SPvQ68yJl05T+X7DGUPxMahWI6oWWrW5kEzLJoY/e4efhmsVvW
         kuNaqmbuXsd5GyN3HzhAOHxY1EETgvVipiayfvkOuIurcRbCyoH2gXhhro7v321mFVMz
         uHcE5lpzRUx4mgnjybLUFyG5QkONVBzZwkm5AHTPa8cbXVhbBJusIbiDG/S19iIlh1b+
         B+jI45L5GgFyu/uSzKQ6uS93jwQiA/fHKf4r8YM/5FX7NrU8CHkiz1/wvGY/F2A1RUAJ
         UDbxo2fpEURriwuNixcOnuq5GKoDaSKDNZWYrnTiBdSutDQcFHlPlCzC6FJKmAWK7+g8
         My8A==
X-Gm-Message-State: AFuF++mfD5gaiLBuRPQgkEFWdHD6YQfTqxEv8Ko4+lRK45T82DE6Inoe
	vAw43P4D2yRnCzyb89lFc7tel1JhLvi6q/foR3W+WxFDE3ThnLAdk7FZZNiZ0Gdn7mM=
X-Gm-Gg: AYBFou2XrasH67e9LZ0NUxwM4TbBSxB2Dx8hwSd5+e1Kh2ERswAhl817jvkCnGFw83J
	cileS+IkWEEOArGIJxFo12LS1RGobjCA0/fUdF4Ftz7xv/YEYCQa/65lfDVFOLrUnqE3z1AX0P3
	N6TJvrlDlYw0g3BW1fmKSKmViUek8pQiNpvu+rA4DY4tqdgVtgQmE59TO/HP2Pa56TPQhpU/ueO
	XoglUhb89PtLczb12IrsFoNAxQ8nsvN/bRquzinFJCICAw/HSFcXMg/o11+5w1hd2+jxbIO8bzl
	9dVOin1Jr94evt0eQnnbLBvZWo8I9kRw4/3QrO84DqW6fz5uIMiI4sTxvojVD2sZYKL9OYilNAK
	7dn5ost/MizMr7RyUyjCte6z7fKbJindTatNUHFeKCXA5O0UIIbJxyavnrMb5g3+L0skBezAqpS
	pMyzIBjEGoG2PeSxbpQG97EF/cxMQsjLLp0QLvElKTKo3pXy+6363E29i34EBVaFbVwBKUBRdMd
	yJa0oaiGjlZrcWBIQ==
X-Received: by 2002:a05:6820:4b8c:b0:6b7:83d6:2930 with SMTP id 006d021491bc7-6b783d62ed8mr9845662eaf.51.1788765462140;
        Mon, 07 Sep 2026 00:17:42 -0700 (PDT)
Received: from brighamcampbell.com ([2601:680:c200:5c88::1fa4])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b6dea11aeasm12213600eaf.14.2026.09.07.00.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 00:17:41 -0700 (PDT)
From: Brigham Campbell <me@brighamcampbell.com>
Date: Mon, 07 Sep 2026 01:15:57 -0600
Subject: [PATCH] doc: Make asciidoc bullet items separate
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-maintenance-doc-bullet-fix-v1-1-dc08dbe61a82@brighamcampbell.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQrCMBBG4auUWTuQpFStVxEXafJXR+pUklSE0
 rsbdfm9xVspIwkynZqVEl6SZdYKu2so3LxewRKryRm3N7058MOLFqjXAI5z4GGZJhQe5c2x7az
 r2vHoe0t18Eyo+Tc/X/7Oy3BHKN8jbdsHCaRfLH4AAAA=
X-Change-ID: 20260907-maintenance-doc-bullet-fix-d351253f8a91
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
 Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>
Cc: Brigham Campbell <me@brighamcampbell.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1053;
 i=me@brighamcampbell.com; h=from:subject:message-id;
 bh=I8UUNp/uKdvaw3b5IJ7gRM36NSfqj8iP2CcR0ivkYHg=;
 b=owGbwMvMwCUWLsWS0KCyxZPxtFoSQ9a8VGFuESNXW81/hidlV2/KT3n3v2N3/fJp8dd35z3+7
 +8Zse5/RykLgxgXg6yYIovKrVnqFydbPzoYwT8BZg4rE8gQBi5OAZiI7QSG/zFVxsLy504/3R9a
 2XtB/3aIK0vLB4sLOZ3tZTZnbn7nY2dkmKPze/PDZVsUxXaGCj5TXq3f7P55lziXkklr910uQYZ
 3jAA=
X-Developer-Key: i=me@brighamcampbell.com; a=openpgp;
 fpr=24DA9A27D1933BE2C1580F90571A04608024B449

Fix conjoined bullet items in maintenance asciidoc file.

Signed-off-by: Brigham Campbell <me@brighamcampbell.com>
---
 Documentation/config/maintenance.adoc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/config/maintenance.adoc b/Documentation/config/maintenance.adoc
index da8be9f812..c778ab09ac 100644
--- a/Documentation/config/maintenance.adoc
+++ b/Documentation/config/maintenance.adoc
@@ -41,6 +41,7 @@ The possible strategies are:
 This repacking strategy is a full replacement for the `gc` strategy and is
 recommended for large repositories. This is the default strategy for manual
 maintenance.
++
 * `incremental`: This setting optimizes for performing small maintenance
   activities that do not delete any data. This does not schedule the `gc`
   task, but runs the `prefetch` and `commit-graph` tasks hourly, the

---
base-commit: 3cb9185f65410273787f74333cc027d2ea5daada
change-id: 20260907-maintenance-doc-bullet-fix-d351253f8a91

Thanks!
-- 
Brigham Campbell
https://brighamcampbell.com

