Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358FC343D69
	for <git@vger.kernel.org>; Wed, 26 Nov 2025 22:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764195527; cv=none; b=p30gzI6lbXhAKZimxJBqXR8/KQZaCfOC+ZYCMqXNrHTzuJmIe6nNjxs/cskLNplSefEgBWOOJLqD9f1lz+UHooQs1lJARZ16WtTMWyX1UluTScyPDvJWrS5dT2ZeeVxEbkJf7tiCaBf2KBLfj9iBgdSFGjGrvJYf4dlSLAJGEjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764195527; c=relaxed/simple;
	bh=3k6bqjjnlztHpsifPMUtgR5RZfSWNxM3Uzkep6i9M6U=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=jG5yzUFsNLamYYhX6QMeo0phsZFLe3e/bR2FoM8Na1UIZ3n2rJTZyEEkDw4NRMPQrZLaxGCjv8DfIKpZ/BVUPgoFIN6bm0ZR7k/ue939Qkk2ELsad35/mH4GQdD7K2K1HzPWjlJGkvP9vSNzGOyMJ87Fw1QoTgVFRd4X8XwPvKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iTgdpISD; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iTgdpISD"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8b2da83f721so28961985a.1
        for <git@vger.kernel.org>; Wed, 26 Nov 2025 14:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764195525; x=1764800325; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GceZ9+OZZ98kWyysR3AcFabFf+Q15YT1bAxxCps4o5o=;
        b=iTgdpISDpc+vapvXhHj0yR3a9xZ22UcSScAnKqiKIh0xmKWq9vUPXW1G49SGcEhIRQ
         W5x+am26RfmlQs4EeHobViS3IEwRHONMJ4zsO7TcDFgtaTMYTZQTyexGB+IAgao64VDU
         RANADWf5ZPPEaRuU0qFArrELU5uRjpqpysrQLljlV5mhAgH7pXqZpQghZp1/+HsKkm9B
         yibxMGPb/Sp1ctd/Toqb+feWIU42NgOjG1SmcUmD+i6xosQAwXEX+laxvyx0LTkAeZLY
         tDKf3IFaANdpm3mLTxr8j+QUWGrkupiPIiIJGm9K3KaEPnwBItRIL4MuaVjoiaUIaqJF
         CjYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764195525; x=1764800325;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GceZ9+OZZ98kWyysR3AcFabFf+Q15YT1bAxxCps4o5o=;
        b=oXIGa8e+4agP1yBiLnZAKxQmyzTY33wxukFd8WUNtEb+/WK7qzn4LQqKm21+jxIeZc
         B2cqpHlBby10BO5xxvwzkk9JNuoRtwomBMJxRBuVmyqU+zcRByvWncJo11zppZPFjp2h
         8tqfsHf02C1ucPBeXUeVnXXfy+HMW08SaCHzcXgW5Llelq2KCbq/gXdnkC2ixaWonsqo
         X/2iB6y0nl9DVboZ95KEdxNaWKf0bodwszqkBBD/Pd73NsZ18a24HxCABMFQlZhUeQjn
         dXqnG3I8QSIx9PwmLdHnGLAKL/tEQqeAswEGTEXgXWjGPsgly0qrYIDAhljkbAIAncGg
         k6aA==
X-Gm-Message-State: AOJu0YyFGlHYVb6jGgnkcmr90VzZO4K2ONfp4yd1fzVn3Da+n3/bUJ8+
	+X9t81Ag6ZO1NGD3wDDbbocutCDY8IH0ias+EMXshn6XbjNRm+Lwti6zEmhbEydV
X-Gm-Gg: ASbGnctU0ZRJLfz3dJRyOqefccTDQkZk4o18wKQZ2NbSb+V2G6vYH6rP6PdV1k9RY22
	25QgPUN+sw57S9Q3C7sQI+wY4lzwqczenemdtHGRPpQgcbOu3W71/smX7IN+LhjmQcYvJYJ3p3Q
	7HCLS9BTnaGxmn1imB31UbtH8ED8RFPorKDsMmZkLYdELSdBWFFPKcwUn4B3jEdTR8zkjV1rJIt
	/HaiQcXtzz/uvSMvITPuUArTu+1i4Deb4oULEnbDX6Tb9j44IF8jXZ7KDGhy7vXTtVUV64maAr4
	icDznshzLnYKgB3a/miRKcoL7EoKfWFXF+2ELD00/HBWMS4vHsMUWfRS/n1U9JcI+aiLvk77doV
	5eU687TKJYFGxduFltE+UTFdFUosjeGZlTt79EQSH0Zh+S5AwragOazMho+EgpRYrKnxyhnR0HR
	hm1HbSbxbgF5Y=
X-Google-Smtp-Source: AGHT+IHuwHRYjaXleqhRRLjP5fwYNqbG8qEy31OaoyI2GG3w2aOIJ5vv9DddVWBmNfeucjJrqykWbA==
X-Received: by 2002:a05:620a:4049:b0:8b2:e922:5280 with SMTP id af79cd13be357-8b33bc422acmr2754792985a.7.1764195524716;
        Wed, 26 Nov 2025 14:18:44 -0800 (PST)
Received: from [127.0.0.1] ([20.161.78.68])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b329537d39sm1460444885a.23.2025.11.26.14.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 14:18:43 -0800 (PST)
Message-Id: <9b8ce6ba2bcc802ae38b2e1223d7d93b03fb2a1b.1764195516.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2010.git.1764195516.gitgitgadget@gmail.com>
References: <pull.2010.git.1764195516.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 26 Nov 2025 22:18:35 +0000
Subject: [PATCH 4/5] scalar: alphabetize and simplify config
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
Cc: gitster@pobox.com,
    ps@pks.im,
    atthewhughes934@gmail.com,
    johannes.schindelin@gmx.de,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The config values set by Scalar went through an audit in the previous
changes, so now reorganize the settings and simplify their purpose.

First, alphabetize the config options, except put the platform-specific
options at the end. This groups two Windows-specific settings and only
one non-Windows setting.

Also, this removes the 'overwrite_on_reconfigure' setting for many of
these options. That setting made nearly all of these options "required"
for scalar enlistments, restricting use for users. Instead, now nearly
all options have removed this setting.

However, there is one setting that still has this, which is
index.skipHash, which was previously being set to _false_ when we
actually prefer the value of true. Keep the overwrite here to help
Scalar users upgrade to the new version. We may remove that overwrite in
the future once we belive that most of the users who have the false
value have upgraded to a version that overwrites that to 'true'.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 scalar.c | 60 ++++++++++++++++++++++++++++----------------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/scalar.c b/scalar.c
index fb595fab3a..d73f9d85c7 100644
--- a/scalar.c
+++ b/scalar.c
@@ -127,10 +127,33 @@ static int have_fsmonitor_support(void)
 static int set_recommended_config(int reconfigure)
 {
 	struct scalar_config config[] = {
-		/* Required */
-		{ "am.keepCR", "true", 1 },
+		{ "am.keepCR", "true" },
+		{ "commitGraph.changedPaths", "true" },
+		{ "commitGraph.generationVersion", "1" },
+		{ "core.autoCRLF", "false" },
+		{ "core.logAllRefUpdates", "true" },
+		{ "core.safeCRLF", "false" },
+		{ "credential.https://dev.azure.com.useHttpPath", "true" },
+		{ "feature.experimental", "false" },
+		{ "feature.manyFiles", "false" },
+		{ "fetch.showForcedUpdates", "false" },
+		{ "fetch.unpackLimit", "1" },
+		{ "fetch.writeCommitGraph", "false" },
+		{ "gc.auto", "0" },
+		{ "gui.GCWarning", "false" },
+		{ "index.skipHash", "true", 1 /* Fix previous setting. */ },
+		{ "index.threads", "true"},
+		{ "index.version", "4" },
+		{ "merge.renames", "true" },
+		{ "merge.stat", "false" },
+		{ "pack.useBitmaps", "false" },
+		{ "pack.usePathWalk", "true" },
+		{ "receive.autoGC", "false" },
+		{ "status.aheadBehind", "false" },
+
+		/* platform-specific */
 #ifndef WIN32
-		{ "core.untrackedCache", "true", 1 },
+		{ "core.untrackedCache", "true" },
 #else
 		/*
 		 * Unfortunately, Scalar's Functional Tests demonstrated
@@ -144,34 +167,11 @@ static int set_recommended_config(int reconfigure)
 		 * Therefore, with a sad heart, we disable this very useful
 		 * feature on Windows.
 		 */
-		{ "core.untrackedCache", "false", 1 },
-#endif
-		{ "core.logAllRefUpdates", "true", 1 },
-		{ "credential.https://dev.azure.com.useHttpPath", "true", 1 },
-		{ "gc.auto", "0", 1 },
-		{ "gui.GCWarning", "false", 1 },
-		{ "index.skipHash", "true", 1 },
-		{ "index.threads", "true", 1 },
-		{ "index.version", "4", 1 },
-		{ "merge.stat", "false", 1 },
-		{ "merge.renames", "true", 1 },
-		{ "pack.useBitmaps", "false", 1 },
-		{ "receive.autoGC", "false", 1 },
-		{ "feature.manyFiles", "false", 1 },
-		{ "feature.experimental", "false", 1 },
-		{ "fetch.unpackLimit", "1", 1 },
-		{ "fetch.writeCommitGraph", "false", 1 },
-#ifdef WIN32
-		{ "http.sslBackend", "schannel", 1 },
+		{ "core.untrackedCache", "false" },
+
+		/* Other Windows-specific required settings: */
+		{ "http.sslBackend", "schannel" },
 #endif
-		/* Optional */
-		{ "status.aheadBehind", "false" },
-		{ "commitGraph.changedPaths", "true" },
-		{ "commitGraph.generationVersion", "1" },
-		{ "core.autoCRLF", "false" },
-		{ "core.safeCRLF", "false" },
-		{ "fetch.showForcedUpdates", "false" },
-		{ "pack.usePathWalk", "true" },
 		{ NULL, NULL },
 	};
 	int i;
-- 
gitgitgadget

