Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA9617736
	for <git@vger.kernel.org>; Sun,  2 Jun 2024 15:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717343014; cv=none; b=t2D/UvtsSyhQLd2a9DD+eCL8Mstxt+yFjehEMSHguE19VOdb7vq5LlLlEjFWkpeCvCeh8adJUCT855oj4xVD8xhWf+5Y5WKjgW7dWllmblgTfmvXcpqSg24kwa5yAaQqPCv2Jz113QOGVj/cnGjoBOUiET2D9RE9ecV+huyr/64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717343014; c=relaxed/simple;
	bh=Qh/J6ceza050EFKPEUHMmmP9KRuVpeK3e8GNA7HMvmk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Z9ekwJiFhcMFAyeHvk3EEBf14j2sLgyXw5l1qh4hTSRk25NWgzdtKb37vf/gV+jL/EPKvct8gknP+YWRnvEPwSHGE9AxkGy3crRkEq5m/7w/ZxgfB2nNvqHnmAQ0lDjX1J77nCd0Lt6NbLxm+x0j9hqGOcknyxXquYlPcI1QXV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PwHK0fyI; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PwHK0fyI"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42136faf3aeso5109925e9.2
        for <git@vger.kernel.org>; Sun, 02 Jun 2024 08:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717343012; x=1717947812; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hPjPtzf/M3cRFJj2bAlVeZ0gQRsY3cNyp+/4VykquP0=;
        b=PwHK0fyImEvAYDidTdtmyehwN5+7HtHV/0W9oayx+lVzq4aBayE0tV7aeb95AwYA2b
         AQYNr+SQayw44GweFsyvuWp5Yq8kRZjDVrdZN7pgdmOrmkCN/BF+2Ok5vGRoSufYpEHp
         6b+r0fjaFMrIE1dqlQBl+iS3oKxAVg8iPjhjoK2x4UG8DPMhscvvzMHHPzsHgkTHWW31
         OBR4my/T84mzxQQWSdHLwPPiqVnWC9Evv4O49hsWFjFTf+Lb2KQaSbxT4wydJ0gzz4TG
         Ge/YJYMMNGyIX1k9QVIeAD/OiJKEpq01Wkk9MQeymQT9lY6AD54HRRakPb3TEVpbhDLx
         8fTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717343012; x=1717947812;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hPjPtzf/M3cRFJj2bAlVeZ0gQRsY3cNyp+/4VykquP0=;
        b=Bj192hZ4LXL/kgdgyWMhVlwvpnxwH77k3g5LDMiXLDbGW7kIWMyJB3f0UvDF1JoyJZ
         IZnCJNPvXrqvmTtINzMpIWWycUH460gNPLLJq5lw7sme/rjuHffYEhcXlFQEBvq1u6Zt
         3PJg2lM3fPBwfk3d70VU0EgIRkfwqCpRnR+ZIYAMne807GOPpB+IoDRbYmUjPBX5ZhR2
         Jas1FTLeGyIv6bU54+JFH6oEhd6yQ6kQa/ETvpn0jux8hcFdGs+VfBGGk0mDtBrXLKcF
         HP3LgRRvHcG1d0NyMpypIAAnJDe1ISHJk1sauv8cN0LRLdPTZvbkok44z8ivZKswix4l
         sqqA==
X-Gm-Message-State: AOJu0YxlUWcwgaNQwNtet4Qq7JDHD/rzVo2ob82EzrKNDbfzX3NyLc1j
	vveMEbs15LPuFfb0KJQZGkT+csJRcsWZe/qgH5FhqmIwPCaVbZG96dLR2Q==
X-Google-Smtp-Source: AGHT+IHBo8iKPqv/JEvfz5iB/MpGZjZdxzngP7zhJKt70L+kTwR3PVPLtmZSfzEPR93dKkufTtMesg==
X-Received: by 2002:a05:600c:5117:b0:41c:2992:a3be with SMTP id 5b1f17b1804b1-4212e0adcf4mr55835825e9.29.1717343011589;
        Sun, 02 Jun 2024 08:43:31 -0700 (PDT)
Received: from gmail.com (12.red-88-14-51.dynamicip.rima-tde.net. [88.14.51.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212b838b83sm87433795e9.10.2024.06.02.08.43.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Jun 2024 08:43:31 -0700 (PDT)
Message-ID: <a852d45a-e148-4326-9662-14469abbfceb@gmail.com>
Date: Sun, 2 Jun 2024 17:43:30 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 4/6] pager: introduce setup_custom_pager
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
 Jeff King <peff@peff.net>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
 <199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
 <b7e24b08-40a1-4b18-89f6-e25ab96facaf@gmail.com>
Content-Language: en-US
In-Reply-To: <b7e24b08-40a1-4b18-89f6-e25ab96facaf@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Introduce a new function setup_custom_pager() to allow setting up our
pager mechanism using a custom pager.  If the custom pager specified is
NULL or an empty string, use the normal pager as setup_pager() currently
does.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 pager.c | 17 +++++++++++------
 pager.h |  6 +++++-
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/pager.c b/pager.c
index 925f860335..21a7d9cd60 100644
--- a/pager.c
+++ b/pager.c
@@ -74,14 +74,13 @@ static int core_pager_config(const char *var, const char *value,
 	return 0;
 }
 
-const char *git_pager(int stdout_is_tty)
+static const char *git_pager_custom(int stdout_is_tty, const char* pager)
 {
-	const char *pager;
-
 	if (!stdout_is_tty)
 		return NULL;
 
-	pager = getenv("GIT_PAGER");
+	if (!pager || !*pager)
+		pager = getenv("GIT_PAGER");
 	if (!pager) {
 		if (!pager_program)
 			read_early_config(core_pager_config, NULL);
@@ -97,6 +96,11 @@ const char *git_pager(int stdout_is_tty)
 	return pager;
 }
 
+const char *git_pager(int stdout_is_tty)
+{
+	return git_pager_custom(stdout_is_tty, NULL);
+}
+
 static void setup_pager_env(struct strvec *env)
 {
 	const char **argv;
@@ -132,10 +136,11 @@ void prepare_pager_args(struct child_process *pager_process, const char *pager)
 	pager_process->trace2_child_class = "pager";
 }
 
-void setup_pager(void)
+void setup_custom_pager(const char* pager)
 {
 	static int once = 0;
-	const char *pager = git_pager(isatty(1));
+
+	pager = git_pager_custom(isatty(1), pager);
 
 	if (!pager)
 		return;
diff --git a/pager.h b/pager.h
index 103ecac476..2166662361 100644
--- a/pager.h
+++ b/pager.h
@@ -4,7 +4,11 @@
 struct child_process;
 
 const char *git_pager(int stdout_is_tty);
-void setup_pager(void);
+void setup_custom_pager(const char*);
+static inline void setup_pager(void)
+{
+	setup_custom_pager(NULL);
+}
 void wait_for_pager(void);
 int pager_in_use(void);
 int term_columns(void);
-- 
2.45.0.97.g9fa538478d
