Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CD82DEA61
	for <git@vger.kernel.org>; Fri, 22 May 2026 02:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779415890; cv=none; b=cqG7spLjBxFEMGnhPyG1yKbGtcXkfwiOuzrVcgPmXDxhPRN8NdOqUdAtn7dplUOzBsASQxkZx0OYPHK0esrQAeEu+9tI6yaWoWAZnRXoFED1MYAY9lrh+1xCg0maoCisyKMBwGwkZQNo7MlT1fu4MrTtP1InxP19vlIyBxg961M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779415890; c=relaxed/simple;
	bh=84yWYtu8Ukcf8m2E5HX22zWAIn4XWBj6rYLxv8aDgTk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=pvJQkQL5Wbgh6JMZobjlsIQiqOUq4Vm4Z32Bw+AFsrCmb1mG09LKm8dm01E6qCL5MLDcrwh4xcAe6jGZDuLAe0tm09fkaDxb8XHz3NiEHblSwYuGE6BXJrKG4pOv8G42jmCmSn++7O9quTpFu/ZtNZzPbfnakxhds2U6aiKv/7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pKMVqZ9d; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pKMVqZ9d"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8c9166b26b4so81118846d6.0
        for <git@vger.kernel.org>; Thu, 21 May 2026 19:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779415888; x=1780020688; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AyGWZR2tdn1LCnaMOm/4BTqwL+ZMt1fcY7hE1un/QlA=;
        b=pKMVqZ9dWyWel02IQV8pTtqFQ/GZMQst98i8hYmr/JmvZZHus16qeOWNUlwb6I8nlR
         sDOXwKkxdFVm7H72fyWzvEsenePTbrg5P7v/4q9KRjxuqdf4GzI+U0/WMmGayZCUfYjR
         K4jQtc8Eh8w5hvRJfyOFEgI4GSVx+ofO3h21fLUHH9H5mMzTsPAnVe5JwpVuK7nRB0hq
         bvkHab1HpAX6hLRYfeWQKSHThwhn3yk2Ru5TENQhTnQTDxZ8u8CTbRZzIP55dyJK4iW8
         tjmW1xHF7Wy0lu1/vhkCexLOo3CJyiyMnlIJUIJDXUn6VfDMgngWWPS4u+AHQqmVj1i2
         rFRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779415888; x=1780020688;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AyGWZR2tdn1LCnaMOm/4BTqwL+ZMt1fcY7hE1un/QlA=;
        b=VUe4jcWAsQ4PBTW4dBZSEnnCSfE0yUo2QFO3oWgQ/HrB5yRVQE5mE7GfMnMxUEPn8D
         JJeHmhfu4du6og5g3DKMyuLBPQATYu3FtFqTrBdcKRSXogsCPYfGJV2qygC39vdMNBai
         ev9NZd5u1T1JJF5CvW5WzwRfxRj48cN4I9LgCxOk4yvIFRaDj2RVGddj6Z1JAJN8ogc8
         nd1JlTLYj8w0Wkqr1phGDXXpoGznEkmUyrg89bwbFfeVHXYgqx631WjYuns9BkAKPXol
         p9msxE4OSMBkJybKS3SpR8ct4SF9NuYupqlWt4aesxSvF0NYONbV2VAE3nvvUPfSbvAg
         XBBQ==
X-Gm-Message-State: AOJu0YyjQ+v+NOd/N1KnJu5j55GjDWOJlWa6EsbxgPJDhrUT0co56n7e
	xkDGEG7t0VeqLKMOirCZ4T1Neio4GIhX/eLx2Yw93WUCDAH0h+44QE8Z62D0WA==
X-Gm-Gg: Acq92OEqQwkPlgJQ1b8qEbQCFIwfT4Dk3nT5eWLWQlxVAVUbxkm/RC2b1e/IG4vjD20
	LaViJWUsL40DrY1oSzM+EttFn7od5QXWnIPz9V4539nr77TcJ5jwXr/OiHVOBHEaayAxdxgDYN2
	cgexrvvdjMNh2kjqs9lfvfYiS4RBCzAODxZIt5vsCWrEIShNtESVzU61RkfZ20bnkBNb2kVKjB4
	PZUga+8M8wTTpVnm+VcEf7+MgfqiJQPKLi6WrBzADjxulLNeA59L0t+u9jzJk3m5jDWGoSkq1g1
	c/14OOEB5Gtow8DuEvU3E+3RK+O9tWcCpzYNtnuFQKoSUqkirzBriA0UBNDlB9i67QJDgBUxp+o
	BAXMLObGhK5AEsd0yFqF3501ud3WEi2gaRyzWoQ9BGEjCdrXFi+bp0zX8vawVb+psi3fKrx1dg7
	qc6uk7CnWkgjkFo03IRazM21eD
X-Received: by 2002:a05:6214:4014:b0:8cc:3546:262e with SMTP id 6a1803df08f44-8cc7b52843dmr36159006d6.14.1779415888398;
        Thu, 21 May 2026 19:11:28 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.117.81])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc80dcf895sm5541446d6.1.2026.05.21.19.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 19:11:27 -0700 (PDT)
Message-Id: <3bc127c8000f353e612f654b358394fa5520c435.1779415884.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2120.git.1779415884.gitgitgadget@gmail.com>
References: <pull.2120.git.1779415884.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 22 May 2026 02:11:21 +0000
Subject: [PATCH 2/5] userdiff: add diff.<driver>.process config
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
Cc: Michael Montalbo <mmontalbo@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

From: Michael Montalbo <mmontalbo@gmail.com>

Add a new per-driver configuration key that specifies the command
for a long-running diff process.

The name follows filter.<driver>.process: a long-running subprocess
that stays alive across files within a single git invocation.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 userdiff.c | 7 +++++++
 userdiff.h | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/userdiff.c b/userdiff.c
index fe710a68bf..81c0bebcce 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -499,6 +499,13 @@ int userdiff_config(const char *k, const char *v)
 		drv->algorithm = drv->algorithm_owned;
 		return ret;
 	}
+	if (!strcmp(type, "process")) {
+		int ret;
+		FREE_AND_NULL(drv->process_owned);
+		ret = git_config_string(&drv->process_owned, k, v);
+		drv->process = drv->process_owned;
+		return ret;
+	}
 
 	return 0;
 }
diff --git a/userdiff.h b/userdiff.h
index 827361b0bc..51c26e0d41 100644
--- a/userdiff.h
+++ b/userdiff.h
@@ -31,6 +31,8 @@ struct userdiff_driver {
 	char *textconv_owned;
 	struct notes_cache *textconv_cache;
 	int textconv_want_cache;
+	const char *process;
+	char *process_owned;
 };
 enum userdiff_driver_type {
 	USERDIFF_DRIVER_TYPE_BUILTIN = 1<<0,
-- 
gitgitgadget

