Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679D0200B8A
	for <git@vger.kernel.org>; Wed,  5 Feb 2025 18:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738781587; cv=none; b=XchgP5pXiCzmy+1j7guTFKK77klJ2x640b6xAZ07WNstk5vmai/8kEKsYYK/KPXovmTIuYEuXZxViVfub7BhvLUD9A3571vq6qyvziuiU1Jv06K658sxyIQzuKrK0w6wbwi4zuolikc2xoVpU3GHVO8jIp73Y8qGyufKYLq0J/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738781587; c=relaxed/simple;
	bh=42i8PUdjyKs+NSwGtLcbj9v39QXr3Du2dpk4eqznw+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cb27RTjdBiYAt2HYQzhke2lNzYkl/q30VMb4bMIeQztZIzD2l003I6Gsr8YQNAxLHck9gWmO3AaUYmQiize/AyNx8bHHa+9eTeDxINrWE2145gBca/guT/6OuIbQlmqp87UC4ESXwYR8FwtR/y8aAElyJiGfRodon3d4gceeXoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U260/HDF; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U260/HDF"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21effc750d2so2439865ad.3
        for <git@vger.kernel.org>; Wed, 05 Feb 2025 10:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738781585; x=1739386385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ST9UH+tJO/KD1eiPpPYLssoj13nQqfVGYdBzpY/GozQ=;
        b=U260/HDF5IMA/7Iw9dqn1UQSOvSwtkmdHyfWUC2I3eHyGsL58hhh/Jg4sKJpdXBIk+
         HYjhwPwDMocvFX3ArqQr8bTgeolns0+MQaTfncWS9BgjOaUUL+7LIRrWas0OYhyIzcxE
         Psac2wEkVI9cS5rTSKVwnstPO2o5xNEjwvIWBVt5uMiUbXECDOx+pqRO7Kj2McM/mO2P
         YsN0JU0DmlQfwZrAvxl5ANLAhBRF6n4Q5ID8Leo/xJzLz+9WPTP2iX1b9YbiO+KiC2Wt
         U8Mx4S/zj98zZyWpj+8UsinUrq+P6idoGik45nLyjuO2OQBTEfvT+Ib49BPeHHw6glye
         ZLeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738781585; x=1739386385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ST9UH+tJO/KD1eiPpPYLssoj13nQqfVGYdBzpY/GozQ=;
        b=berAHq8a7XeafAabwDcETfwtNGdKYuxXfR1FVUIvkg8AEB1XEVKqIA3MFtPD+NzHQ+
         ovioROtQs7BMd7lhaziqvLNt/Q+kpDstaU5oqREKuo89XRWKpwF5Ui11hhZdtowJsL+Q
         7ed5eI3QYOVUobkjNG9Ho942ekhxTpW4vxlYjkkSFtPuMCCD1ZPHbvNreKDPz1cn/8L9
         cPWohvXe86S30gzVQd1L/8BvcONSPCKU9M1IF9g0eUkFUOEa7HRNOAKrUpKNmkqnr5ME
         3cEtv1GjF0SPSFL2Bm94kqQst5/o+7OkLmAX36Pnx92jCeYTlbI5eMUSGjLifapCvsTo
         PG1A==
X-Gm-Message-State: AOJu0YxpZzGuAJfw7ZF9HvEO6YdRpdtALYr+JnRX8LD8ZEMhHzAohJvy
	ji62htlpXNeVe+mzl9amaqAABSDc0S57teBvsJG10Yb8jAqtIHHSLZyBddMtBRQ=
X-Gm-Gg: ASbGnctQkwtWu4CtyT3illsh0SudiM0BnwQ6N3XbuRMuI/nvz497QGOsDzjsa5KS+Gb
	ece26hJLX7HuZ0jBxic9VZtHFst1Q1+lChw3kwt2lYOLXjby9tGVjnQ+RezXGhCslFgPoBxbam8
	+2muvFlHzx0joPqbV42PQP+ACaZ/cwcemU6FkCO7R4veV9LTno3Ru1KGvu7/uWn5i0Encscsu6n
	f1wDulONwQr6qiutZFOFNoAeMzyPIxj4K4/s1GgoictFNpZczpj82D2bcb2QJ4qkGqB9DlRP9oy
	On0EVqTdn5m2ZbpUGGvZbThf8S7/DM2UHKu64xtS
X-Google-Smtp-Source: AGHT+IG3FmRXhjfXm7gvhiIkyHyanNXRrGkjtXi5xBsOm3aozQ6cUyp/hCiR/4vAmvXygFQ97leRAA==
X-Received: by 2002:a17:902:cec7:b0:21c:17b2:d345 with SMTP id d9443c01a7336-21f17dde0eamr68964225ad.3.1738781585406;
        Wed, 05 Feb 2025 10:53:05 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f1e9f3ebbsm13754285ad.190.2025.02.05.10.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 10:53:05 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org,
	=christian.couder@gmail.com
Cc: gitster@pobox.com,
	Johannes.Schindelin@gmx.de,
	johncai86@gmail.com,
	me@ttaylorr.com,
	phillip.wood@dunelm.org.uk,
	ps@pks.im,
	rsbecker@nexbridge.com,
	sunshine@sunshineco.com,
	usmanakinyemi202@gmail.com,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 3/6] version: refactor get_uname_info()
Date: Thu,  6 Feb 2025 00:22:33 +0530
Message-ID: <20250205185246.111447-4-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205185246.111447-1-usmanakinyemi202@gmail.com>
References: <20250124122217.250925-7-usmanakinyemi202@gmail.com>
 <20250205185246.111447-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some code from "builtin/bugreport.c" uses uname(2) to get system
information.

Let's refactor this code into a new get_uname_info() function, so
that we can reuse it in a following commit.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 builtin/bugreport.c | 13 ++-----------
 version.c           | 20 ++++++++++++++++++++
 version.h           |  7 +++++++
 3 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index 7c2df035c9..5e13d532a8 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -12,10 +12,10 @@
 #include "diagnose.h"
 #include "object-file.h"
 #include "setup.h"
+#include "version.h"
 
 static void get_system_info(struct strbuf *sys_info)
 {
-	struct utsname uname_info;
 	char *shell = NULL;
 
 	/* get git version from native cmd */
@@ -24,16 +24,7 @@ static void get_system_info(struct strbuf *sys_info)
 
 	/* system call for other version info */
 	strbuf_addstr(sys_info, "uname: ");
-	if (uname(&uname_info))
-		strbuf_addf(sys_info, _("uname() failed with error '%s' (%d)\n"),
-			    strerror(errno),
-			    errno);
-	else
-		strbuf_addf(sys_info, "%s %s %s %s\n",
-			    uname_info.sysname,
-			    uname_info.release,
-			    uname_info.version,
-			    uname_info.machine);
+	get_uname_info(sys_info);
 
 	strbuf_addstr(sys_info, _("compiler info: "));
 	get_compiler_info(sys_info);
diff --git a/version.c b/version.c
index 60df71fd0e..3ec8b8243d 100644
--- a/version.c
+++ b/version.c
@@ -3,6 +3,7 @@
 #include "version-def.h"
 #include "strbuf.h"
 #include "sane-ctype.h"
+#include "gettext.h"
 
 const char git_version_string[] = GIT_VERSION;
 const char git_built_from_commit_string[] = GIT_BUILT_FROM_COMMIT;
@@ -47,3 +48,22 @@ const char *git_user_agent_sanitized(void)
 
 	return agent;
 }
+
+int get_uname_info(struct strbuf *buf)
+{
+	struct utsname uname_info;
+
+	if (uname(&uname_info)) {
+		strbuf_addf(buf, _("uname() failed with error '%s' (%d)\n"),
+			    strerror(errno),
+			    errno);
+		return -1;
+	}
+
+	strbuf_addf(buf, "%s %s %s %s\n",
+		    uname_info.sysname,
+		    uname_info.release,
+		    uname_info.version,
+		    uname_info.machine);
+	return 0;
+}
diff --git a/version.h b/version.h
index 7c62e80577..afe3dbbab7 100644
--- a/version.h
+++ b/version.h
@@ -7,4 +7,11 @@ extern const char git_built_from_commit_string[];
 const char *git_user_agent(void);
 const char *git_user_agent_sanitized(void);
 
+/*
+  Try to get information about the system using uname(2).
+  Return -1 and put an error message into 'buf' in case of uname()
+  error. Return 0 and put uname info into 'buf' otherwise.
+*/
+int get_uname_info(struct strbuf *buf);
+
 #endif /* VERSION_H */
-- 
2.48.1

