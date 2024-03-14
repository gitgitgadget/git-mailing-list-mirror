Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF5F53AA
	for <git@vger.kernel.org>; Thu, 14 Mar 2024 04:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710388824; cv=none; b=g5RSD5uybqtDZE5t43ZqLCU94MXg0OdSRDQyboAVzmi6XvWcE0LUSWdfDsjNFnslhDyRCjnmN1KJfydL0tfqycLXr3WZxlElZVZGbkK6gEdWZbQuoLYAwPt9cNkoHa4cj8cJ6sMWpL3A/X8Dt+Pz4X6QrHDktVVLJl2UjoYtPRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710388824; c=relaxed/simple;
	bh=AHcDQ8iA65FdE5oamf7JYL5TOT1+ja1vjD/QfwO2LXI=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=AXLKtdFKe1udRW6uuZQF2GrsUGOfO2EqelWC910eASK7O9+6qLQRmHlfH8wJMeOA38W4uPkqYhidVVS93RvGPXQV2rei8y2DDVYwBJXiUAC5IxzT4Dn2G1G0METw+kAsHKiHujA3KFCzTi/fGM1gAw5rbWe3cHUHSI+Q8NWIWgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MYUCG2Df; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYUCG2Df"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-413f3b1c455so346995e9.2
        for <git@vger.kernel.org>; Wed, 13 Mar 2024 21:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710388821; x=1710993621; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8qVSvUT+XaDSGvJckwRoJVcCqjv3cGkzCQJeSP0zwaE=;
        b=MYUCG2DfQmVNmycigN5owqc6HoqsqxU+qdWxhxXhYM3R9kxaZ+ALo9ZPuzbI9MuL2q
         +s0TGaw7zfpK8DpbY2Go5jQ5g1idNuo3dB15Qzfo/xwjv90tEiYneLfM/a1Wo5+Fxu1r
         tnppCR/cdt66p34jAubgFx0EDJ3Qo4/gVmFRkFNLFyGq/LkUGebJ/gBlfDG50aXMsFc3
         fCGI4LHamp1pAmgnKQ1BZ3prA45K0g5JLWV5TK46ZCqPixxNUiUwYgJR05K/lwRzDvqd
         imua5YHT6V4+1Lyxb6go5CdrDhZaDpzCkNa537xVMYLUqoMKU8OiDZHJDu4WMfRcp5p9
         P3zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710388821; x=1710993621;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8qVSvUT+XaDSGvJckwRoJVcCqjv3cGkzCQJeSP0zwaE=;
        b=kM+45lPVkSdvhiL4rlurDFIGyxILPGaf+Ia00aE8TPSuYer29vZLuwGTTzRPsBoFaP
         1I0DfFO7Qe6MXJd2sAWrbspPMd9NM0iixvjmOxALVKGpl7L7nPXBgAr4y0TjLtHCPHAN
         jVO7EPxJgS3ecvO5JIJacSivQYFLcAIuW9KFv5Gn+h/rEu2FDYxlvS8a51Q5P5c4Zg8M
         ggid+cT4rJr7kjxERCVw/ZD5+yRx5bZe3DxatdG85BygHWfU1HekbSadJYAmqrOrL+jC
         rvytYdciB0bQMhaS/VI7r+LNjobZ1e2Qgt7WD9en1C6BEdZx7OgCwKWBof8U3H756MRM
         asDQ==
X-Gm-Message-State: AOJu0YwzTXJBgylLDEq8OpDRUSGlAit7v2LjUdS5F2la76ulAyWkqrcH
	G9fcmxlvY3vdUN12tPsI8NnJoXEWelOT4kOZyO4CNsm7SsThfsJ/cC2x3CJF
X-Google-Smtp-Source: AGHT+IGJr5JlAEBCL4HgfiF0tCS2plzvD7s6hpDedV+9KOQM+n6sHQgPSUZ9GugEeeIz7s2+oEZ0UA==
X-Received: by 2002:a05:600c:548e:b0:413:117c:a4e with SMTP id iv14-20020a05600c548e00b00413117c0a4emr479792wmb.27.1710388820957;
        Wed, 13 Mar 2024 21:00:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x14-20020a5d54ce000000b0033e891d97d6sm575448wrv.107.2024.03.13.21.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 21:00:19 -0700 (PDT)
Message-ID: <868cec05ed53e780660d98c08b5a306af3cc363e.1710388817.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1693.v2.git.1710388817.gitgitgadget@gmail.com>
References: <pull.1693.git.1710260812280.gitgitgadget@gmail.com>
	<pull.1693.v2.git.1710388817.gitgitgadget@gmail.com>
From: "Jiamu Sun via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 14 Mar 2024 04:00:17 +0000
Subject: [PATCH v2 2/2] doc: update doc file and usage for git-bugreport
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
Cc: barroit <barroit@linux.com>,
    Jiamu Sun <barroit@linux.com>

From: Jiamu Sun <barroit@linux.com>

Changes since v1:
- Update documentation and usage string for `git bugreport` as
  suggested by Junio C Hamano

Signed-off-by: Jiamu Sun <barroit@linux.com>
---
 Documentation/git-bugreport.txt | 6 +++++-
 builtin/bugreport.c             | 3 ++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-bugreport.txt b/Documentation/git-bugreport.txt
index ca626f7fc68..112658b3c3b 100644
--- a/Documentation/git-bugreport.txt
+++ b/Documentation/git-bugreport.txt
@@ -8,7 +8,8 @@ git-bugreport - Collect information for user to file a bug report
 SYNOPSIS
 --------
 [verse]
-'git bugreport' [(-o | --output-directory) <path>] [(-s | --suffix) <format>]
+'git bugreport' [(-o | --output-directory) <path>]
+		[(-s | --suffix) <format> | --no-suffix]
 		[--diagnose[=<mode>]]
 
 DESCRIPTION
@@ -51,9 +52,12 @@ OPTIONS
 
 -s <format>::
 --suffix <format>::
+--no-suffix::
 	Specify an alternate suffix for the bugreport name, to create a file
 	named 'git-bugreport-<formatted-suffix>'. This should take the form of a
 	strftime(3) format string; the current local time will be used.
+	`--no-suffix` disables the suffix and the file is just named
+	`git-bugreport` without any disambiguation measure.
 
 --no-diagnose::
 --diagnose[=<mode>]::
diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index 32281815b77..25f860a0d97 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -64,7 +64,8 @@ static void get_populated_hooks(struct strbuf *hook_info, int nongit)
 }
 
 static const char * const bugreport_usage[] = {
-	N_("git bugreport [(-o | --output-directory) <path>] [(-s | --suffix) <format>]\n"
+	N_("git bugreport [(-o | --output-directory) <path>]\n"
+	   "              [(-s | --suffix) <format> | --no-suffix]\n"
 	   "              [--diagnose[=<mode>]]"),
 	NULL
 };
-- 
gitgitgadget
