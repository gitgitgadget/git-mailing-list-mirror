Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC957ECE
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 01:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705628339; cv=none; b=nFqNV9rRQBY6x3VK3uqI4Pt2fi7AB6dsNBmDuNb3g/mvuuctDF/j2E7+J4Te8+lLKqE0Ov3fZNcZ5NWqKHj1u612HRM26WJFzNFmF8Kc10W2ydWK/r/SngvEDFriIdLuozWf7VV+MOinqz9M6o7Nap2qATWNVbUIINqmxCV4818=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705628339; c=relaxed/simple;
	bh=vSu1L7Pnfx8DW2zVLu2TMwCWmQ/sq5KFZnV4WYH+ftQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G9a1MkrjLR4gS+xcMbSh7OhZpU/3kjlH1tqoWpCMtMsijo90A76Rp81jpCZn0pCHKK5ZmV8oEL+nAzk1e0aOuyNvG1lqLeyAqsAOID9VqMC1dhkGUPkFcduiSB2EIHkRBfTug4nKK5BuDfdh1biUc6IN+vH5WB4Gkkl7yhPkET4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hViuLkLt; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hViuLkLt"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6e0af93fdaaso177740a34.3
        for <git@vger.kernel.org>; Thu, 18 Jan 2024 17:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705628336; x=1706233136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t4sToo2hvx0+lPxDQmDpxqoMu0gx4pY5EozVQG4d8oM=;
        b=hViuLkLtC9wzF/z0S0GtctspSj8DHA2xXj2KoxHhbMO76C5+UASyc3D+No4KhQsB3s
         EYWgmBk+Ud6spsbiQA+iHndRsQ5kGphB2V0F0RoZTv3yyF/XZHRN+g166OArlSneAjg7
         EnTEhkdobcdn1oVGmj7vH7XjxmKKC27+2+vAiwTisyv5EtL2eu9mbNebZeAl7kJU1tlY
         ye2Jlv3wPR/KAOM55+KVGiJeL2yEGQaMj+KINFo/2PDY1V7op4OBO12KVLdm00tOFBD7
         HNuhBHudxE/1nHGcbUwUiT1kXylXl6/Km7bMVBfLbJviOAjnFys+yxXvIitEGPhKiTTh
         u8Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705628336; x=1706233136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t4sToo2hvx0+lPxDQmDpxqoMu0gx4pY5EozVQG4d8oM=;
        b=GMMNlw0ppVZSA0A+EDGCismWsaO84J9mS2P9zLVDVz2GkBKC8E1S/XKH+y06zaUZPO
         /kFpscwWYMTgVW6L4Dwe05xoicLXmXqC/uI45Qj4RKbDvEuAQ+PPTSVHbpMqAtUB1auz
         DIsrK0KzNdAg5ByhlfseKw1FXgBS8jzlAyNBi38lJEjsB7mfRRqy8or/GLzEpFJd5qwQ
         CYFMq8/qldqSD3HAYJshWzhyYPuXbD/XXu9Rj34OAE676zO3ZsGHVEMRMdlyrKukg153
         u/3UPJp0EiDK9QjyHaf0PoRdkZJgrzlQJwu6sSu4EoORwM5rXt6qff65TQu8Abo+72v2
         rTkQ==
X-Gm-Message-State: AOJu0YxDqCu5AgOrUQl6xy+IwndnIAwPhXIqVRuCKNTE7Wcn4kyQ5MTH
	0dEsYXSIOik6YIUY7mHdjF+2Jxr/VZvUn73KeoiHv69v2KJAeAELWJnAJYvh3r8=
X-Google-Smtp-Source: AGHT+IGAANJqrtu6CPlziphpFl/HeXQhwX9BsfPmHlImwj8oYPrfUX9UeB2coc4mcCHX8T7Q81L7WQ==
X-Received: by 2002:a9d:6384:0:b0:6e0:ccf1:9b34 with SMTP id w4-20020a9d6384000000b006e0ccf19b34mr1803475otk.53.1705628336235;
        Thu, 18 Jan 2024 17:38:56 -0800 (PST)
Received: from localhost.localdomain ([2402:a00:401:a99b:65e8:f5a4:7adb:5726])
        by smtp.gmail.com with ESMTPSA id 200-20020a6302d1000000b005bdbe9a597fsm2242965pgc.57.2024.01.18.17.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 17:38:55 -0800 (PST)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Subject: [PATCH v2 1/2] t0024: avoid losing exit status to pipes
Date: Fri, 19 Jan 2024 07:06:31 +0530
Message-ID: <20240119013745.2476045-1-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118215407.8609-1-shyamthakkar001@gmail.com>
References: <20240118215407.8609-1-shyamthakkar001@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace pipe with redirection operator '>' to store the output
to a temporary file after 'git archive' command since the pipe
will swallow the command's exit code and a crash won't
necessarily be noticed.

Also fix an unwanted space after redirection '>' to match the
style described in CodingGuidelines.

Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
---
 t/t0024-crlf-archive.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t0024-crlf-archive.sh b/t/t0024-crlf-archive.sh
index a34de56420..fa4da7c2b3 100755
--- a/t/t0024-crlf-archive.sh
+++ b/t/t0024-crlf-archive.sh
@@ -9,7 +9,7 @@ test_expect_success setup '
 
 	git config core.autocrlf true &&
 
-	printf "CRLF line ending\r\nAnd another\r\n" > sample &&
+	printf "CRLF line ending\r\nAnd another\r\n" >sample &&
 	git add sample &&
 
 	test_tick &&
@@ -19,8 +19,8 @@ test_expect_success setup '
 
 test_expect_success 'tar archive' '
 
-	git archive --format=tar HEAD |
-	( mkdir untarred && cd untarred && "$TAR" -xf - ) &&
+	git archive --format=tar HEAD >test.tar &&
+	( mkdir untarred && cd untarred && "$TAR" -xf ../test.tar ) &&
 
 	test_cmp sample untarred/sample
 
-- 
2.43.0

