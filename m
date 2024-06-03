Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F3113B582
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 20:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717447111; cv=none; b=gZCrIoho72uBSsBkOah2ztsnV8b8paTkMTGBRLZZcD+XkW4gGIDHB5Uab9b4ncMTC8fT0A29NZecKNo25MoaM/WzAZH9EeiiYAiHcLnaIHtYFHsFNAmI2kvzYkzXuLwtS+WfMvh9XEhSEg/6XY9YKfwEWqm2JxubxMgyhPychy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717447111; c=relaxed/simple;
	bh=EOJjdODlPJhnaMGb18ZE03E/7+Jhm4l9+dtHs8Ls8DE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Z2KSCAr/XvuUU9tmQeZlcpoBjSjDP3bMGSZ/JY/NgApiJvOJjrVOKT5KghnG3UTrcEJpl7yqm/0rO8bjO/zw71iUmZlTreqG87Uup6qIDm9gaipBgAnfOpaWHOfa4Yx4SBHIqsbpItKpbvKVOSggFxDn5AGwab3TsaQO08QoFOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=imf6kRb9; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imf6kRb9"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-35dcd5377c4so3854366f8f.2
        for <git@vger.kernel.org>; Mon, 03 Jun 2024 13:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717447108; x=1718051908; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=H8T0sbiTMEQG3ThFTq6CKv3Z8+03AZJ2MSll3LSYbEE=;
        b=imf6kRb9xquiHk+fOHLNScXiS0r7XWxHRcU+wdcgRoinuoQKp2znsrxdxbL2EUKO2/
         UhHw1JdKhOgboopblh5bd22MXskmIMAdFfUE7Sp1BkifLWIFrfrsYGJKhihei4kNMfzM
         LTfEvN5XIxX20qDs6qk0u2hGe7o79FFPxNCLGUE6TwjyuW3loVzFKTWpaFlmRzf2QwVR
         5l8WgDdlheZhmlrwPYtc2W0BicntYpJwxy3B3ubTaTP+aMcDWgzR9bFbCxfRu5WRcnXU
         jjAWHI4v1rPITHTLA7lZkQmCI3RA6kYGbeA/Tz1VuaCQ+1mnf2sxnHIdiIhmjNXjyHAY
         8zBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717447108; x=1718051908;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H8T0sbiTMEQG3ThFTq6CKv3Z8+03AZJ2MSll3LSYbEE=;
        b=LAJ6o2ytzABN8Nq7yPQ92bO60nYc9QKmsJxKhWgwaRPBgFPFWc7F/IDp+05ir2QRxL
         jzqVYa/1b/VujcSCvDyTPf/aUkKEWXXD3sdxXNc1Vq1cIbUwExuEoWYrDqr0hxO4g1S6
         Rtc/ySSAwPs1TCKv8zZ6y0pbAp9T6BFfPKPhJDuwPO/tpLKLROX+XP9xZyv65HxTp5Yj
         elc3iFwEAr3cboPNHDsA6z9THq+kV523dwAkn3xlh/jQbklG25AmEe8DpZbvTQX1dD9c
         h7fuW+hUIGDyu1xlDnYa8QM+OUPY/TNFMYez++x3u3ANxEfEWOsKTU5lvsm8C+99Re3T
         Ojzw==
X-Gm-Message-State: AOJu0YyjLBC55oQycrWk6PTs/G/we54a2ds/6GY+Yo2O3mMgk63DGGOH
	6U4TCIHRsAPxb3btGt05tqT9QIf9yiQo6C0oEL0o+WDuB99MGLW4wbKD1w==
X-Google-Smtp-Source: AGHT+IFUhzIUizjAt+ndHB410GA/sxAzVoEaIkshKJ338x7JKmmEJRDrLwdp+izFBxlFgxdqRgH3Kw==
X-Received: by 2002:adf:f051:0:b0:35a:6422:efc5 with SMTP id ffacd0b85a97d-35e0f34ddafmr6895532f8f.54.1717447107924;
        Mon, 03 Jun 2024 13:38:27 -0700 (PDT)
Received: from gmail.com (20.red-88-14-43.dynamicip.rima-tde.net. [88.14.43.20])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04d6e5asm9667386f8f.45.2024.06.03.13.38.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 13:38:27 -0700 (PDT)
Message-ID: <3fa0ade6-d710-47ce-8bcd-81d7821dfffb@gmail.com>
Date: Mon, 3 Jun 2024 22:38:27 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v4 4/6] pager: introduce setup_custom_pager
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
 Jeff King <peff@peff.net>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
 <199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
 <b7e24b08-40a1-4b18-89f6-e25ab96facaf@gmail.com>
 <1ef0ac3a-3be5-4fc2-93f8-46610f3d1880@gmail.com>
Content-Language: en-US
In-Reply-To: <1ef0ac3a-3be5-4fc2-93f8-46610f3d1880@gmail.com>
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
2.45.0.97.gb691764a17
