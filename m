Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33101F5E6
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 02:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760494797; cv=none; b=tkHKAExrjyTOinwwVnJDiF1IgT6yoGXfDeCe7MJw0eNUkuP7TDiQQaN74AlbtdfNWh6G4YoxRXnpnHSA91q2T1AW74CqCQIeFIu2CTehRP2QUwYh+DfJnNtSNfAGoC2Zu4vg/LVZWCiN19jvBCQ/s/7OOcsL+/oPnCUWmWSLGXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760494797; c=relaxed/simple;
	bh=xflKYS59tR63ohk/22ID4DjrBE6Zbl5ZgJUJM6LK6Y0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IrdhJbmnqnhVpoN7R+vQsTpPRvYeyHOAnb4Yeurklx5uTjCvls5Eb/3q3dzCn8BQQs5IEiTwosfAUZC/TI+cSIsJqQ6UZvH37oo157FtCgnZwGVwih4b24ixdsLka2XPOUu1Nilfaodm+JSRMMnZzGE+Sn9mzIkd5C4aZ7IQkT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U0CZ6/eA; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U0CZ6/eA"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46e6c8bc46eso39858855e9.3
        for <git@vger.kernel.org>; Tue, 14 Oct 2025 19:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760494794; x=1761099594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eJXDhKeE3R7JKt1hmA37QVsVn4nq5gDy5nq2zInKnLg=;
        b=U0CZ6/eAe2hHvAT0M1tIQas4CnxSB45h2L7LanBts6Br9mdGhWexokuTMdrAUztr/Q
         FiplQHOcjktXy6JJwD/y0tWMQeF6SdmeT0NgAre5cHczfG3gH600ZYFuGgbBAKfUAI2o
         izzf8z0VAAxS+izHu0YrV7ZSek2HlFv5AleB9Aid4k53I1lCYjrQI/ivWuGaHQzL3TFl
         /thVYn4DvN2T8zu2kCcanlcKA5rd9KkU2Figcf8pYMzxa69SQqL86n9/i6jPOw5Y3iMc
         ItxjcOZ/xDUmjGNFTHX+xEcjfM9f91XxwwTltjP+/1mAmMcghazKh3SULrBw0UFK63nF
         Gkeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760494794; x=1761099594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eJXDhKeE3R7JKt1hmA37QVsVn4nq5gDy5nq2zInKnLg=;
        b=bHr6jYDL0IISjdPZKlz/vRfQkho0Fw84zA9gOqa606rE/NmWQUhRbyT1weZ245TyZP
         zkh9CU0ulyV13HJWsM6PgzVSbmUrdc4wpgAEkLgdtdlQdYI5cBRDW/sjXngmmGAg9HRV
         q09yTIkl3Ar8zvUQ5YnEFwaQrKeS6FDW3jwRIyOMCLT5D1xyT8VMFzBYDS4yIft2wgkV
         UpdbyShuDsX344SSu0Wfsrp5rehvYARUiKIwcbK+8ykiD3bKYuAVSQwH2yX1nisV9H3A
         Milfyxv291Ce73fayu0YtuvbuHJkj3EmiEGmh7VIPHRiZT8Qp+farTmQCODtLK10GdIx
         r4Qw==
X-Gm-Message-State: AOJu0YwQ5dedbg37LDWOL/gBJWOn5wTIcpCpeXRe+3PI/YrJ9sC7P+fV
	prOuGpdUTZ+yjhXTHdoobVlDjFJ504+BSlsaJ15SDcWId/DduYgvq5pJ
X-Gm-Gg: ASbGncsfmYROyv24KMFMI/wSM/oBUWtZY+DsS0OR1F3xgTXIz2kw7mM0O++mOBuwYs9
	8YUIKWkQ87qOv6MJVwBSKVsO4DRlfoLiHO8kEWO23JUL0L9jhijiytU+KOj/C7+R7L6oWAscJRE
	gnPQs6fG/8/xqr8xhra24L47r1Zu2kssbkeGqCxWpndq8thrd1hZ2L8H4WGAFvobqGLsXu45QQG
	YLYkv4n0CqYVYRPrgDYQ8fvg0Gedyk5hBo6QLEEES0OLG1rff707kegiES4AGDFg4jL4GCVwFPD
	a0SxnvE7DVgP3+QWjYiEYhABQ3kPww+g2FrmkJ37X7YYyK1NaKiScX5KLj2xJt6Zgr5WKFE/wVe
	r3jKyIWls9lHRBq8z4dumI0/yXye18qTBza+Ii+BSjGg3k1k7
X-Google-Smtp-Source: AGHT+IEQJe3BCMjAHcAU+VjnMoCfYDCdmVJquKSj2Dm4cAfZ3nL4+ljCni1JcLQ5JYrpFkeozTJmKg==
X-Received: by 2002:a05:6000:603:b0:401:5ad1:682 with SMTP id ffacd0b85a97d-4266e7bf04fmr17702809f8f.14.1760494793955;
        Tue, 14 Oct 2025 19:19:53 -0700 (PDT)
Received: from ubuntu ([105.112.225.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5cfe69sm26924070f8f.32.2025.10.14.19.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 19:19:52 -0700 (PDT)
From: Olamide Caleb Bello <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	gitster@pobox.com,
	usmanakinyemi202@gmail.com,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH 1/2] [Outreachy] gpg-interface: replace strbuf_split with string_list_split
Date: Wed, 15 Oct 2025 02:19:42 +0000
Message-ID: <aea3b80a8883c4dac4e05defdee3eb82b83fe8c9.1760490943.git.belkid98@gmail.com>
X-Mailer: git-send-email 2.51.0.463.g79cf913ea9
In-Reply-To: <cover.1760490943.git.belkid98@gmail.com>
References: <cover.1760490943.git.belkid98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

get_ssh_finger_print() accepts a signing key and then uses pipe_command
to execute the ssh-keygen command, gets its output and sets it in
fingerprint_stdout.

The string in fingerprint_stdout is then split into 3 strbufs using
strbuf_split_max(), however they are not modified after the split thereby
not making use of the strbuf API as the fingerprint token is merely
returned, hence they do not need to be strbufs.

Use string_list_split instead for simplicity.

Note that strbuf_split_max uses 3 to specify the number of tokens to
extract from the string, while string_list_split uses 2 because it specifies
the number of times the split will be done on the string, so 2 gives 3 tokens
as it is in the initial instance.

Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
---
 gpg-interface.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index 2f4f0e32cb..043a808577 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -14,6 +14,7 @@
 #include "sigchain.h"
 #include "tempfile.h"
 #include "alias.h"
+#include "string-list.h"
 
 static int git_gpg_config(const char *, const char *,
 			  const struct config_context *, void *);
@@ -821,7 +822,7 @@ static char *get_ssh_key_fingerprint(const char *signing_key)
 	struct child_process ssh_keygen = CHILD_PROCESS_INIT;
 	int ret = -1;
 	struct strbuf fingerprint_stdout = STRBUF_INIT;
-	struct strbuf **fingerprint;
+	struct string_list split = STRING_LIST_INIT_DUP;
 	char *fingerprint_ret;
 	const char *literal_key = NULL;
 
@@ -845,13 +846,12 @@ static char *get_ssh_key_fingerprint(const char *signing_key)
 		die_errno(_("failed to get the ssh fingerprint for key '%s'"),
 			  signing_key);
 
-	fingerprint = strbuf_split_max(&fingerprint_stdout, ' ', 3);
-	if (!fingerprint[1])
+	if (string_list_split(&split, fingerprint_stdout.buf, " ", 2) <= 1)
 		die_errno(_("failed to get the ssh fingerprint for key '%s'"),
 			  signing_key);
 
-	fingerprint_ret = strbuf_detach(fingerprint[1], NULL);
-	strbuf_list_free(fingerprint);
+	fingerprint_ret = xstrdup(split.items[1].string);
+	string_list_clear(&split, 0);
 	strbuf_release(&fingerprint_stdout);
 	return fingerprint_ret;
 }
-- 
2.51.0.463.g79cf913ea9

