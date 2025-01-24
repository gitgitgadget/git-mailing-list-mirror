Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE1F2B9BC
	for <git@vger.kernel.org>; Fri, 24 Jan 2025 12:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737721362; cv=none; b=oZmJOJUOWPxgIf0UBZIZEqSSf/4fMBjjNy9lbP/046SR+btjiErChrK7mCPzzd/ckEcfAMbfe6hNRyxN1DiL5IEd1GWBvywSUQL2xtne+Bpf9QlrSVVcOJIL25ahU+F19T/DpbvcQolr1kci48f7ZyZao9A1Kz+jfyWZZ57j/1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737721362; c=relaxed/simple;
	bh=zI2kW4kSYFc2wf0pQpoOSH3r4W8g0Sk+jGtKTOVb5Zo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i3Co6FcIZ2d/ltGHcQsQAjeGJEY+kI2s3vc8PAbGEUsy6WUGWKrFRTrsHNQ6SjXwDSLzZEHND9apmO1axbqhvUtmP2uRgGAkDAoE2aJaGOCYFM6l5J6ueuYaimsAHfLtq8BZNtctsDSttEiTlScvlOOevc3V3OzaqGXvX9+KR6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mL7EqA7A; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mL7EqA7A"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ee8e8e29f6so2907288a91.0
        for <git@vger.kernel.org>; Fri, 24 Jan 2025 04:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737721360; x=1738326160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gpGzGxY7oS9vaBZmel27t8qPVdpHHnYzoe18NAokJLQ=;
        b=mL7EqA7A/pfWScXtpS+/OgxyfNd+5APxqtpQ9sPP/7K+ihiDjguZTc4nE7VxLwIrZz
         2jan04oqt8dPLwpb6GoK79THwjZtLlQ4y7xteW8e6i0eeVTb5ueM+idJh6qKcIw4YcRG
         CcIwhyIYYpCpQVpnBn5dK0FgWCac6zWLqaQrT6wKgXU8RsK8ppar1tezrYB0v+P6ZoXm
         GN6Iv9Z7A4YCOKQjMu45AzDIEys68/mmgAfdl+xI9B89D0jz+Bk7yLp6RmD5s1IDf5E6
         nVHcDxGHe2Y04tJJnY65EHR3xIgr/6qeg40LArtR74iRLdghYDC5ojxkXn+64fyba3/4
         UlVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737721360; x=1738326160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gpGzGxY7oS9vaBZmel27t8qPVdpHHnYzoe18NAokJLQ=;
        b=DjRJQJvYNgW9yO657XWPeAMQKQrnivNz7JOtAZ6O3ZfsOYh7TriNM8Uex09W9y5qp0
         2utvVov5NUaX3ltzDi2IGBC+QG0+JNEq1Ey2OA5sxpQFIwp6EGkK7WNcbzKdv+gaoh4K
         +EaHLAaizqSmIYT1BenLlnxfUuMwWItkY4AEN7B0KasUifM/NibLw4OhCa8QOqy5QW+8
         A7gqpHd2vUoUJ9BIBCNzqtHFDvzGD3SAKjz42/l3OjCQTGPvCoOZYWlaPamIskiG6VAW
         GNEJoNY/p6WTCpAopWLjh3tyvLWbsjwlXijU6cnZ3iObKHJQJAQJT4HYJPK/wVVOmQtG
         aujg==
X-Gm-Message-State: AOJu0YzNv553QyxvVdFaYBbcP3HpInUq1X4jnYRdA0Y0N4pEbu8rDhp6
	ybvrxvmG/99m9MoMtRfHfsTth78aOxgcN4g9xE8FaVOsZ5qKRRFY3+mYkIeFi2M=
X-Gm-Gg: ASbGncv5vi7gb0mv18ctqbhA2I6qRu6/6P65D9mNYyF9vDpEHMs6r53Gb/zuZQJNTVx
	6A7XC+USUKbe7Gksztr9UkljRRs9swnXlyOfr78Xaz3auixVdESft0jELBJ0qPTgYQ0ZmctAYf9
	o3jDhAa6PjRSUx/czIBgKE/3mxKATLUo/AeMgQK17pbmipnnBVczb6GHIAB7N+bGH+Cs6IZqrUn
	4nrneHxUDOGZd8wSug7GpXdm5cFVS0YQYEBXeArVImAEgYlsCvmC/TpSMtsgXspGrc3dRu/Xp96
	or8u/ox94tuRlktudI1aDo+MsowIc9c4w84aXRYl
X-Google-Smtp-Source: AGHT+IFvLzIcS89ADVEIU9YH0NVdBQLtYKmvXIZpezNvstgwk1l9wSZ0/H0PAfdTuTv9YQIvGh54PQ==
X-Received: by 2002:a17:90b:4c06:b0:2f2:a796:26b with SMTP id 98e67ed59e1d1-2f782c65719mr39084495a91.1.1737721359624;
        Fri, 24 Jan 2025 04:22:39 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffb1dc56sm1685056a91.49.2025.01.24.04.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 04:22:39 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org,
	christian.couder@gmail.com
Cc: gitster@pobox.com,
	ps@pks.im,
	johncai86@gmail.com,
	Johannes.Schindelin@gmx.de,
	me@ttaylorr.com,
	phillip.wood@dunelm.org.uk,
	rsbecker@nexbridge.com,
	sunshine@sunshineco.com,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 4/6] version: extend get_uname_info() to hide system details
Date: Fri, 24 Jan 2025 17:51:39 +0530
Message-ID: <20250124122217.250925-5-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250124122217.250925-1-usmanakinyemi202@gmail.com>
References: <20250117104639.65608-1-usmanakinyemi202@gmail.com>
 <20250124122217.250925-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, get_uname_info() function provides the full OS information.
In a following commit, we will need it to provide only the OS name.

Let's extend it to accept a "full" flag that makes it switch between
providing full OS information and providing only the OS name.

We may need to refactor this function in the future if an
`osVersion.format` is added.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 builtin/bugreport.c |  2 +-
 version.c           | 16 +++++++++-------
 version.h           |  2 +-
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index 5e13d532a8..e3288a86c8 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -24,7 +24,7 @@ static void get_system_info(struct strbuf *sys_info)
 
 	/* system call for other version info */
 	strbuf_addstr(sys_info, "uname: ");
-	get_uname_info(sys_info);
+	get_uname_info(sys_info, 1);
 
 	strbuf_addstr(sys_info, _("compiler info: "));
 	get_compiler_info(sys_info);
diff --git a/version.c b/version.c
index 3ec8b8243d..d95221a72a 100644
--- a/version.c
+++ b/version.c
@@ -49,7 +49,7 @@ const char *git_user_agent_sanitized(void)
 	return agent;
 }
 
-int get_uname_info(struct strbuf *buf)
+int get_uname_info(struct strbuf *buf, unsigned int full)
 {
 	struct utsname uname_info;
 
@@ -59,11 +59,13 @@ int get_uname_info(struct strbuf *buf)
 			    errno);
 		return -1;
 	}
-
-	strbuf_addf(buf, "%s %s %s %s\n",
-		    uname_info.sysname,
-		    uname_info.release,
-		    uname_info.version,
-		    uname_info.machine);
+	if (full)
+		strbuf_addf(buf, "%s %s %s %s\n",
+			    uname_info.sysname,
+			    uname_info.release,
+			    uname_info.version,
+			    uname_info.machine);
+	else
+	     strbuf_addf(buf, "%s\n", uname_info.sysname);
 	return 0;
 }
diff --git a/version.h b/version.h
index afe3dbbab7..5eb586c0bd 100644
--- a/version.h
+++ b/version.h
@@ -12,6 +12,6 @@ const char *git_user_agent_sanitized(void);
   Return -1 and put an error message into 'buf' in case of uname()
   error. Return 0 and put uname info into 'buf' otherwise.
 */
-int get_uname_info(struct strbuf *buf);
+int get_uname_info(struct strbuf *buf, unsigned int full);
 
 #endif /* VERSION_H */
-- 
2.48.0

