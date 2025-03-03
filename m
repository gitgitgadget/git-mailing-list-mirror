Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8781C5D76
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 22:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741039319; cv=none; b=QowfDaDX0kYl19OmCdVKZ1zK4mCqYdE3EPGWvj5uiBjhhoY4VMIpUHOHdc5tJUjeHa+Z/FMsBebR5EdhQbS3BbU5cWdXoz7iR4sMSMShxKJryivNfTdBQcwOLIO572a0BNExOfFn8uLTsw/7xas05ePHl3EBkaWni3wy8DlyQAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741039319; c=relaxed/simple;
	bh=4iV7UjDFomA1xyvpdUD0tRlh4gdZXeHQoPPaiNgHNJs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kSPohwtwDOJzHp3w6JNw2X37UdOckk0J9iJFpa2QVasDJ/hULouFbUTySyfld/USWs/jsCu0TgLFtRITPlGdMKo17MFNWy0/rpbN5RAh9XGP9wWTo0dYkrGBYwvS1jDsxUMdGs/qkhidE+l9Fi4y7M5R4tprQ5/LTCGtdb+wreE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MEMq3SEV; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MEMq3SEV"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22328dca22fso74670555ad.1
        for <git@vger.kernel.org>; Mon, 03 Mar 2025 14:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741039316; x=1741644116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nFfGrdPvOoq1LEqsMBve5eDLP5VaJ95ZfRAcnK+W4fM=;
        b=MEMq3SEV+oywK0fn3IsQJo88AGF27HC68UDxFJKD5yvzib15p23QvsNDfngdUy3ETQ
         YKoVZPSYY/Tb8osOxsLbXV3jEHnmxVSoRlu8KtLy4MYudve1Jv4JQXIwhAJmZG1Egtx7
         zDD7brbFFdWmGlSrxKXNwXp7TgbV4yzNaAXfLJX6O53jpgI2zwIAm3WaSCCOs6LxXUrR
         AgIfXZDxmYJGeAB5sGwnm+oTEzAGxKp3UQRGpet1LLqfjtQa5wxMTpGMRv+sCMA1uSsU
         vnm1NTAhT7zh7+HyAOV5CKREhg8ZY3eVZAwwc5Ef/jfir3BTXDI4K3TkU9MMWLK6KdNT
         HKgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741039316; x=1741644116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nFfGrdPvOoq1LEqsMBve5eDLP5VaJ95ZfRAcnK+W4fM=;
        b=xBjEK2012tHhmSKdkevauFAEe/mY7XypG2sz9YUiEyySbeKom20+Sls2gFL0mxWXoJ
         uxEc8np7wUElzgaeoADyaorkwYB5/Hj5eWFL+DRsRVX4xVYTIFpcO0NNK08TynoZwdoL
         mQq5LGc4Xo0koFZwxG0gQyU6D6ykPixi6FXSLtz9CFk5YFuYit77FY9+F56vda4BtNFi
         BnWKiqlZeLamd257AvSLunwCkGlR0A4VOuMd2vLQFz95NrtFNMb9LNYPTTQWVr6hZ/II
         fonDN7Rj0xv59HhVoE0jK/zvTXtwJTx7CcHGu9UWtQPJ/dsV3gzCwbtUBFA1005KfYxj
         +lvw==
X-Gm-Message-State: AOJu0Yzpb9JDYaD0gQuPcfUHb4clkxPU6pF4jhsqZRvmxwbkIYrp2QzV
	UQGJS/d+YCpM7BNcajAvCHYkXQcMxZUsnD1gceNJrLFhTHgknb75TXbXFg==
X-Gm-Gg: ASbGncstDZ41vWH2ZWtFej0M0BTt/VkK+snBeBkRyA+0C4XxKYPFmoC4ZFUexhuBCvv
	Cyivr6iILeMV7T7TWM3BmYcsyPO8cynsROS5oMIjwfLUxFh2rY8FaCR7b+LS5GK0JoVaf46i/1M
	z0bmz27wSFUbFilLhzUkpDg3jKM6GuocZP0RYoQwVVvYlHNsrURIk7TBvcmjD6z/fd6Eygui6Of
	Tun9dnUWoPMzKYWWfQwZsYmOqpesisnO3HGJ+dA09VxmlhHCFKj7pI5uI7vcfKNEJdGdYmw8hXU
	hOwM/TauqQMFy/7gvahP+gRYsBYS0GeMZx+Q3TJJc6ruTeyAXFfHElQSeoDKVGHZ054a4Q4XjyZ
	J9G9cfc/fNg==
X-Google-Smtp-Source: AGHT+IGoz0hN6EHbleXWvYoDGJIZ3Xwca3DQP6deOH6MFpja6MtqODRswAl97AYvZaHWASAVJwjboQ==
X-Received: by 2002:a17:902:ec90:b0:223:628c:199 with SMTP id d9443c01a7336-2236926725amr198739475ad.52.1741039316495;
        Mon, 03 Mar 2025 14:01:56 -0800 (PST)
Received: from localhost.localdomain ([2804:7f0:b77d:283:5dd5:8e9e:2c56:864a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504dc7e1sm82746565ad.176.2025.03.03.14.01.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 03 Mar 2025 14:01:56 -0800 (PST)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC][RFC PATCH 5/6] log-tree: add subject prefix in output email subject
Date: Mon,  3 Mar 2025 19:00:28 -0300
Message-Id: <20250303220029.10716-6-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250303220029.10716-1-lucasseikioshiro@gmail.com>
References: <20250303220029.10716-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an extra subject prefix is provided by the user when calling
`format-patch --subject-extra-prefix`, insert it between brackets at the
beginning of the the patch subject. Don't change the behavior when this
flag is not used.

For example, this `format-patch` call:

`git format-patch -1 --subject-extra-prefix EXTRA -n -v2`

will create a patch with the subject beginning with:

`Subject: [EXTRA][PATCH v2 1/1]`

Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 log-tree.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 8b184d6776..d72ab25585 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -478,17 +478,21 @@ void fmt_output_commit(struct strbuf *filename,
 
 void fmt_output_email_subject(struct strbuf *sb, struct rev_info *opt)
 {
+	strbuf_addstr(sb, "Subject: ");
+
+	if (opt->subject_extra_prefix && *opt->subject_extra_prefix)
+		strbuf_addf(sb, "[%s]",
+			    opt->subject_extra_prefix);
+
 	if (opt->total > 0) {
-		strbuf_addf(sb, "Subject: [%s%s%0*d/%d] ",
+		strbuf_addf(sb, "[%s%s%0*d/%d] ",
 			    opt->subject_prefix,
 			    *opt->subject_prefix ? " " : "",
 			    decimal_width(opt->total),
 			    opt->nr, opt->total);
 	} else if (opt->total == 0 && opt->subject_prefix && *opt->subject_prefix) {
-		strbuf_addf(sb, "Subject: [%s] ",
+		strbuf_addf(sb, "[%s] ",
 			    opt->subject_prefix);
-	} else {
-		strbuf_addstr(sb, "Subject: ");
 	}
 }
 
-- 
2.39.5 (Apple Git-154)

