Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992AB2DF14E
	for <git@vger.kernel.org>; Sat, 27 Sep 2025 14:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758984658; cv=none; b=TL4if0DwmhnVd5E7L0r5JJbB6TukonwnCC79drCOX+884uE7yn3OsgV3wMmte4Aj8ge3FhkpF9x8J4Ex2QDHTxfXwE2H8B7z9QWIgd5yhLQAsooZJX03mjyxhw91eQ3K73n7t+QDgWgIfossxDtF3tFm6CU/uhTd5jrtUk70n+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758984658; c=relaxed/simple;
	bh=rhL7z2JuUNObAPJolsKbTI6C1GU/Lgrn+nn1ssbaLoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gst+5jXuBb0WmoeOG/6Hqu0JlwDsXohShT84EQUYJPItQRVK2DzNJeZZDW+S1rXvY+GARGaGv4MLFs0j98RxukxkCyxhCxTo7leCofe3726help0yrjKkne0a5+qUSc9hdtut38meAeiN8gHsUHlRgW7luaF1dQx9OsNp3KQ1LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mDnGtfe2; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mDnGtfe2"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-63c4b162a96so1723294eaf.3
        for <git@vger.kernel.org>; Sat, 27 Sep 2025 07:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758984655; x=1759589455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xISjwdtj2GzvnStBEQ4LDObogRyfw+Z5+EIiFS62pTU=;
        b=mDnGtfe2qJk6HIb69plqx71YDBk3XLZa5TcV5qolDLw8HxVO/Qt9ydqC4Tw0SiF61B
         v+w5OtNvuvMZxROs9LTUtYfwruigLcdrRtFnk9zjz0oyWvrOjpoXqNhuu4/sB3yIMr7x
         0V4CgyqJlVg6cYvgixhTOq+EhEpfwJcQ/7tTafVMYjVGfCyOMSD3CnxHmBIqSlcYW41f
         6tvILIDMvQPn1OujpeYB2Bx5xedBdnEL5AJcU6oSPXixzD/mEQI8Nh3EWdBUrAGOKOIa
         QdN9yogsrhSlfR5BpXRKIGJCbYzxg4scYhfYTbWGazwufzGPHG21vp8HHgN6XmbP/0Hi
         +5CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758984655; x=1759589455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xISjwdtj2GzvnStBEQ4LDObogRyfw+Z5+EIiFS62pTU=;
        b=uX32DRnDxtb8HNCWUg4m1IDx4gUzuvyHlELmW8hPcCUaXJNiYIEsBvkmUVOeg1BP17
         P+g8UR+idaF61iprwHI9YooNw/90YYmlxEPIHIZRyxGEju3XYspfAvomVFH8wJlBFPAe
         ZahctQNkE2xhcN50uw2es+LlxMb03kEknY94onSPxIn6W5CaX5WQlSq27wJev6EHl+zJ
         lRSTVJTaiLDV9DQobFHfZhNOdMOvM0g8rETH543AaB2iHQzvPLt21BOrkzeonirym6um
         7zh6Cr/qpHLBN1OC1eq3659JYue8YBtDAOGEtEt9kE+XYHzEFROUwPiaQfLWU6gDdp9d
         L3Ng==
X-Gm-Message-State: AOJu0Yx8OxCSDxuqrf0ve9hEzL7AiLUIURaPkH5uddpL2RAr5kGeMD4g
	qumb5KxnHZ49KZ7OF/4XYAn8PsrWVGRCBgQpwieoPBIWiOSeMk7jXFAdfuSZVA==
X-Gm-Gg: ASbGncuV/cjjFOvmjXkJPmJ/SWqibaIMFGC+T40kAYNU9492SwcEqgg11XC99J+8SLs
	o+MF/Z4aNlIFArkLulVTvnLF4/IFitQ5micbF2UNqMBFOyk8lnlIknumHDH3ynMFDAABWbiREah
	DVNmjjYgB5xALprfRRuAg4i2yRfaEXCIN+g6wp/pUl1zIR4Bynd3mHmyRP6Rko1iqT9br9BePED
	pfR7Or00CLYb5FulzE8ehIhxjp8lNcWz9E2zkiXhlWL1qYoTp9i1fjK8uOkCkRVUyeP0FqFcmIN
	Djhr4XbCKGHxzys8AoTJLFlDKr2AIjBnqpfbzDrBCGZjIKUywMOOtjQILBa33hogCo+cQU1AYVk
	Z67GK2sqUyvi1HQQSQMRSypGKAC0n8YYuN3l1R1t41A==
X-Google-Smtp-Source: AGHT+IGBUrcKKvrbC01tgW3a00k5GSSE0Yr06uC4CdG5YRTBi0H16cFNTKJvxV3SaCE7DIytLvia1A==
X-Received: by 2002:a05:6808:6890:10b0:43f:55f2:4c44 with SMTP id 5614622812f47-43f55f24ea3mr3833230b6e.3.1758984655402;
        Sat, 27 Sep 2025 07:50:55 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43f51258cf1sm1345401b6e.29.2025.09.27.07.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 07:50:54 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	sunshine@sunshineco.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 1/7] builtin/repo: rename repo_info() to cmd_repo_info()
Date: Sat, 27 Sep 2025 09:50:43 -0500
Message-ID: <20250927145049.723341-2-jltobler@gmail.com>
X-Mailer: git-send-email 2.51.0.193.g4975ec3473b
In-Reply-To: <20250927145049.723341-1-jltobler@gmail.com>
References: <20250925232928.3846-1-jltobler@gmail.com>
 <20250927145049.723341-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Subcommand functions are often prefixed with `cmd_` to denote that they
are an entrypoint. Rename repo_info() to cmd_repo_info() accordingly.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/repo.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/repo.c b/builtin/repo.c
index bbb0966f2d..eeeab8fbd2 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -136,8 +136,8 @@ static int parse_format_cb(const struct option *opt,
 	return 0;
 }
 
-static int repo_info(int argc, const char **argv, const char *prefix,
-		     struct repository *repo)
+static int cmd_repo_info(int argc, const char **argv, const char *prefix,
+			 struct repository *repo)
 {
 	enum output_format format = FORMAT_KEYVALUE;
 	struct option options[] = {
@@ -161,7 +161,7 @@ int cmd_repo(int argc, const char **argv, const char *prefix,
 {
 	parse_opt_subcommand_fn *fn = NULL;
 	struct option options[] = {
-		OPT_SUBCOMMAND("info", &fn, repo_info),
+		OPT_SUBCOMMAND("info", &fn, cmd_repo_info),
 		OPT_END()
 	};
 
-- 
2.51.0.193.g4975ec3473b

