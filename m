Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060151990AF
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 17:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724693832; cv=none; b=qIrYNv2ntkmPdqc5I6Esom/P/4lX0sZg4749CuZKu5sZq14LjsMRONaAyRUahJaR31vGNKi70po9muXH2xJE78+pEvDG4rsdqCZjqYQbgUDlav4bjsF6FAnDDb2dntdHMkqrnYRzzCjyDTQfd6zlkqpLBoKNaJK/Vr/Qcu5DaVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724693832; c=relaxed/simple;
	bh=DSl7hekdMnDoAjHiqUYtbINHq85mKyh0e02cyFZrG4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ABbF50MF+ag8vDsCd8CetgyG9zFnTAqQSiJrmXRkO6nqahVCfkEadK3dGP6QFvZSMDgqA3Ord9312gWJAUv1xouZTLGgNui3/AYU7PutQJLY18QlQ9s7QLWPS1rHKFeYQMHTEO+9o6BNiGTla9jzZTz7Qm5EExkDfo6x5RTRZ58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/OeyDSA; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/OeyDSA"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2705dd4ba64so3195345fac.3
        for <git@vger.kernel.org>; Mon, 26 Aug 2024 10:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724693830; x=1725298630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A1i/3k0KHYI1ce0MUl5K+nAbVW+OuadxhAW6a07t+jU=;
        b=C/OeyDSAjqKwP00fxYurV2T0KBZSNJ6O+fajid7jx8gV4AG1/TfItTOkpwaAmKf8Ro
         o0U3p4D5KFnX3rbDDzyx97SG1tM/Ns/ak96jzb58msSgzz3eeZyQO9BFLwYy8B2VB79n
         eVDP6JXEE9cmyFPVRB8kBl7OdASjy2r80BIkoEOQI2eJB/gtD/9TsU49tIqRXRzJG+zF
         Cfwem0ySZvdRf19A/6OImfvAcj2bvI3yHVzM9Zrponydjhi8jZFn093kt8fG3n60/R14
         dsfSRrroqEFai3HXfdTHucHlH5yB/T1eIJMhlG2oWjJfOpHHzow3X8+QiE4rO8Xf9YPf
         HaAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724693830; x=1725298630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A1i/3k0KHYI1ce0MUl5K+nAbVW+OuadxhAW6a07t+jU=;
        b=UK86bkIJVMY16y0043h+jxSFv8bJVite6Fa79URmjFW9ZAiIzkitSfukOxC+wSM5lG
         fYzH1J84p6U69cpK/XHvwudTJe6mCa51AbaJUtYE664pWkr7SYM3SaU5nDmhGTC9CIOT
         +FF6X0bgmPtREjnamC+LlBWYELinadReDAHl1PBzo4VyRY2rwGG353G7jsDtE4Kk+gM8
         Kp2i/ZDmzuCTxXbABMQz3hy/h3XL2GGGBKk8yiLUB+EVzcSY8Cbp98ZxPjrszDE3TTgC
         046Z3Ve9xzNrqcfBJ7Bz5gLlgSx50qm6f2sojZvqS+a6onf1ytDjft6U66/eOf5KjfBY
         qVPg==
X-Gm-Message-State: AOJu0YyudzyXTAPd56NefuZKVCz8nIFIiiCA0waUojR1CiWrHXdoaidt
	DBIX6uWOznsmI6ke1wbd+NYCV7cQmBVSQfb79EQ1NzkUP/TFJCMCF2/eEY80
X-Google-Smtp-Source: AGHT+IGimoJvDytFA2xKhkwrhQA0/zvqjeSqd4Wny74n8BIBwlv4aYfG6QIXc1eXw3/JYxMgwNyAog==
X-Received: by 2002:a05:6871:286:b0:260:fd20:a880 with SMTP id 586e51a60fabf-273e674bcc8mr11232830fac.42.1724693829712;
        Mon, 26 Aug 2024 10:37:09 -0700 (PDT)
Received: from Ubuntu.. ([106.216.108.198])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-7cd9acdd9casm7997999a12.53.2024.08.26.10.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 10:37:09 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 3/6] t-reftable-stack: use Git's tempfile API instead of mkstemp()
Date: Mon, 26 Aug 2024 22:59:43 +0530
Message-ID: <20240826173627.4525-4-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240826173627.4525-1-chandrapratap3519@gmail.com>
References: <20240823120514.11070-1-chandrapratap3519@gmail.com>
 <20240826173627.4525-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Git's tempfile API defined by $GIT_DIR/tempfile.{c,h} provides
a unified interface for tempfile operations. Since reftable/stack.c
uses this API for all its tempfile needs instead of raw functions
like mkstemp(), make the ported stack test strictly use Git's
tempfile API as well.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-stack.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/unit-tests/t-reftable-stack.c b/t/unit-tests/t-reftable-stack.c
index 3ae7478fbf..5cb79ad8fd 100644
--- a/t/unit-tests/t-reftable-stack.c
+++ b/t/unit-tests/t-reftable-stack.c
@@ -76,7 +76,8 @@ static char *get_tmp_dir(int linenumber)
 static void t_read_file(void)
 {
 	char *fn = get_tmp_template(__LINE__);
-	int fd = mkstemp(fn);
+	struct tempfile *tmp = mks_tempfile(fn);
+	int fd = get_tempfile_fd(tmp);
 	char out[1024] = "line1\n\nline2\nline3";
 	int n, err;
 	char **names = NULL;
@@ -95,6 +96,7 @@ static void t_read_file(void)
 		check_str(want[i], names[i]);
 	free_names(names);
 	(void) remove(fn);
+	delete_tempfile(&tmp);
 }
 
 static int write_test_ref(struct reftable_writer *wr, void *arg)
-- 
2.45.GIT

