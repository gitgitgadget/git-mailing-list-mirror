Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91412FF661
	for <git@vger.kernel.org>; Sun, 26 Oct 2025 22:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761519271; cv=none; b=bws8AJG/Dfi7y6Ty1nhKj6tc8oYEQRqDbsxKEmZCKOksoMLzf5aH2N6LO4cXN+yZzUvb0UxXaXrxyszA+HcCW1MRtp22cgPzt7v2jONUV/AMOFyjjFMSGi00DjoEOWakaGlobNm2QEq0wMoT5qTSCeQyxq+khSh5rXJfH6VP8FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761519271; c=relaxed/simple;
	bh=4uDFLG5za3M26CzNT+CKy8SBhlLYVoeTgUBzRbz/9bo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YgJ18TfnThEnR1HF7IfIlaqpvN2pl5Ab9sBUsueimbYo4d9GbbuoI1ZUXxoPn6FVBBN4VEkYRM91UGuM1yZ1xIRHkaHWmyGUwKSTnnVW/yz33sAIfNqh7R7eiT+XXDGqotXuPy+V6/cMf6IEBUIRmQ6u37++XmK4otsAKQ90H6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GfWYEvR4; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GfWYEvR4"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-290c2b6a6c2so42431735ad.1
        for <git@vger.kernel.org>; Sun, 26 Oct 2025 15:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761519269; x=1762124069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h9TVDcQVMEiRFwjvUsgR+McSehncg/cp2lxFKTsgcuc=;
        b=GfWYEvR4f60g4Nj6HHQYqfZlODxrv9ShE9zjQtjMSafOBYs0r26st1VmVdr8E7z3sY
         loe8mtHysYCv2fN0EPebNrvDHONymNdQotWiizkk8Tg4s9dnaOGXW6p4LP7i+TKUU32E
         KAfejUz9fePOWEVEFRX59b3rmcNT8ga1Go+pgSOcO5ikmr4iXws/upKJVaF6JAPZrOZ6
         2TejM7niEIyEaMYn7Itu81gQjhIXt5sQVSTb0vA2dGI6GDwlcGFB6whmL/feFugfchLC
         1IKP/DIHVV7kGLVQM0oR2RdAPkOpXvJAhQL6oFQiNm8i9JUR+csjwU2sYrNBaBuMhfmQ
         HyGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761519269; x=1762124069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h9TVDcQVMEiRFwjvUsgR+McSehncg/cp2lxFKTsgcuc=;
        b=DvD8Y71tg9mpcrPr4oGhjs+MzX/xw4Ep7qp63g3mMew+KoqEZZi1w/ausf/MncrVFh
         rCYx8ny30Wxq1u3rFZrzXizjVwhKdlc9EFvfPb+iP6LnIKg63DdoebA/Ab20CROsliAg
         DUVpj6ROXeVj6Oz7ISKt+5l2aRwDdf4AS6wtf5XQUN0Bo2le4eShTulw7Mn+JHnXsYNL
         4my2zs4XOquV12xLlqkKVOrCFnNnrsEiyQh1Fv8X0xx2/Wau54HJjqZAGkfc/WbK+/wY
         X8c3j+7Y/IWY04jhbQdogiC/+trRe2KHTXLGhCXB8XZ5c2TppeX6SSEZ5vLKvqL7z124
         sROQ==
X-Gm-Message-State: AOJu0YwdGSIQ8Sy2Y2vYZbnKgeqhjGXlrIFI+DLydlK22S+PoA0EGgJN
	cxRKVxP9FOK/VOgKj/jVqNkUKKYhCi5kjUN4YUpvhGNPEliRVofyLhFEZ2FZReXs
X-Gm-Gg: ASbGncsWyfDg21O06GH1emG5RsOH+mAHv99FRCUDxb2qLcZWtm+hO4ANwkptFkoLG6S
	Cx/aQt2CZCv9mJBuQVUj+xAdz8+Vn2iuBK6OoC7jT7pBaxUdsAUr/TAEP5Y2CdtCF67DhbyMsJm
	rqwsW2EpX2/0v1EwsUBh/6LzsKYCw/CTokZ0uElUH+smaWJcR2/FRkJZ1nb/lYg7ta7jdqPEQ1Y
	uJ5+riXddilcOH/8cJyH7w7QRvDS/35gRFZ3Dhsv3OppdoBU4CYHZc7ZIcyRyit99sRItjQZtq2
	xdINUX6xTkrGudhKEOzHQaY2mFjXHsaqeDcweajHaGkbqMVJDGJ355WCfzmmsMD3Qj7U5C8ymtR
	GJ1Tctzvxgae6CT+4uj5bG9jQ7tX+Cv8zPsMRb9jeBKNFYZY+Q8tUwmdiXHI5yUWK5B+cmS0P7E
	e2yoOWMG6v4tWThFZZ9ynUwpulL3dKrLCLV2vp
X-Google-Smtp-Source: AGHT+IElqdEeTV0KbGDwUw4pT6GwqPxmXiTNSiJNuU1wIO1VrA3Ttrq0S3+1nrSRFsXx3gmi8uxdwQ==
X-Received: by 2002:a17:902:e88e:b0:267:cdb8:c683 with SMTP id d9443c01a7336-290c9cf1785mr426987605ad.27.1761519268940;
        Sun, 26 Oct 2025 15:54:28 -0700 (PDT)
Received: from localhost.localdomain ([191.181.59.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d0c6eesm59657435ad.42.2025.10.26.15.54.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 26 Oct 2025 15:54:28 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	gitster@pobox.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [PATCH v3 1/2] repo: factor out field printing to dedicated function
Date: Sun, 26 Oct 2025 19:52:07 -0300
Message-ID: <20251026225409.46647-2-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251026225409.46647-1-lucasseikioshiro@gmail.com>
References: <20250915223618.13093-1-lucasseikioshiro@gmail.com>
 <20251026225409.46647-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the field printing in git-repo-info to a new function called
`print_field`, allowing it to be called by functions other than
`print_fields`.

Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 builtin/repo.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/builtin/repo.c b/builtin/repo.c
index bbb0966f2d..3b071e9a50 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -77,6 +77,24 @@ static get_value_fn *get_value_fn_for_key(const char *key)
 	return found ? found->get_value : NULL;
 }
 
+static void print_field(enum output_format format, const char *key,
+			struct strbuf *valbuf, struct strbuf *quotbuf)
+{
+	strbuf_reset(quotbuf);
+
+	switch (format) {
+	case FORMAT_KEYVALUE:
+		quote_c_style(valbuf->buf, quotbuf, NULL, 0);
+		printf("%s=%s\n", key, quotbuf->buf);
+		break;
+	case FORMAT_NUL_TERMINATED:
+		printf("%s\n%s%c", key, valbuf->buf, '\0');
+		break;
+	default:
+		BUG("not a valid output format: %d", format);
+	}
+}
+
 static int print_fields(int argc, const char **argv,
 			struct repository *repo,
 			enum output_format format)
@@ -97,21 +115,8 @@ static int print_fields(int argc, const char **argv,
 		}
 
 		strbuf_reset(&valbuf);
-		strbuf_reset(&quotbuf);
-
 		get_value(repo, &valbuf);
-
-		switch (format) {
-		case FORMAT_KEYVALUE:
-			quote_c_style(valbuf.buf, &quotbuf, NULL, 0);
-			printf("%s=%s\n", key, quotbuf.buf);
-			break;
-		case FORMAT_NUL_TERMINATED:
-			printf("%s\n%s%c", key, valbuf.buf, '\0');
-			break;
-		default:
-			BUG("not a valid output format: %d", format);
-		}
+		print_field(format, key, &valbuf, &quotbuf);
 	}
 
 	strbuf_release(&valbuf);
-- 
2.50.1 (Apple Git-155)

