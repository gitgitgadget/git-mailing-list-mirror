Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7180A1FCF5F
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 10:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737110821; cv=none; b=OgJ4oUZye0qPuYkrY05Y68rgq0atD7FreUo9xxRQ+0tWF1QAcxdkO8NHKOtBSzc2PxPzjnjajtSpcQJOcAFpLrGYH0sdYR1s8CDduronuhajPvsnV/XkEsjce4eqxric5oHICPX8/O/tAREAFPlqqHifximjG3TYQSK9z1JbvGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737110821; c=relaxed/simple;
	bh=uW/lQTkavtnsa1OWu9hrbkfka8oPmRobgYTtX264hjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g9Qy6/aehTMApQ3UMw4MZlbHjVzHs5c/ERvHGZkvFmS8JzgIA/hsEzPKg8iqAEWmvL5HdRst1tYzASRaeTEMZfOfLiINYpqY4x8r8c99SYoST8TxX2man6NG+s6h1MdU6gIBqmh/wns9NZGeNzY6NfPiDJ2jJ+o99nvIZt5ZN6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nKU/fDf1; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKU/fDf1"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2164b662090so35626745ad.1
        for <git@vger.kernel.org>; Fri, 17 Jan 2025 02:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737110817; x=1737715617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Z33A2SZFbMPHdEpR80wKv2/sMPf7sPRXmGeAYZpOP0=;
        b=nKU/fDf1swen/2lsjs+B8FG/i+i/kYelug5qSZ0bXdOg6ULs4HOUWG6vLZS/oB6HLa
         3Xch06dF8wkUd9Eb86rJva+JA04ygcNdFZ3iKElJbHle4MqoxHSq4vyMQNL45oNYIexM
         UWu+AUjZU2lsj/w5Um5KnD+UhzyllIQbDgnwVPAZsNql0Inlmx5mJsWOvg6VlYPpaPmK
         yUbumGEkWJAapEAy8MXRKWHKdaFg1VekcXa9J+g42Qr1pwvpPnzTVhPKMKgppmJjFDRW
         tq9mO5sNAimjhK+t5VLkGDKOW3aJbNQt7fx5hg41TGs6efp9Hp/oCU7Aw8E2xrMToX0n
         d5cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737110817; x=1737715617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Z33A2SZFbMPHdEpR80wKv2/sMPf7sPRXmGeAYZpOP0=;
        b=ol8s7rpua7LA4bQDCNnyyA3abA40r6VHp7yytBbs+DuVhkArBInzw0MqRdzyVRqwaa
         aEHWnVsqJJiMv/toLUl3s01j1c5jyxnJhxTLfsTB6Ba1n2UFcetiwrUgBUX3jb1KS0u6
         2q8Jk9dh1lMIJdpEAHxxiSH/Aun9GfTnwHFBnj3W54z3Sb8FOtxnTMS7KMiozFWqmpna
         D2ZgSaYSOZx+3Kpvdphlfq/RDrQT2n2q6DynNc44pFPLU6p4JXpqVHuTBPAVOkv1yNr3
         zOr46nz4Pz+e9q9uSihEt7DlyYhDB72FIzaN88kozoj4ihmh3j31TQVoEgKd0k/lDR0L
         bCqg==
X-Gm-Message-State: AOJu0YzHfO/5rzU5WC28y9KgdjkLiuNeBZ67Lt+xeEGAoYhv+xuzXhOV
	Bmna2ZFiZK2TDjjyqtxIcPH+oMdl4pdzggIlgjvqi5cS96t6LwCZ6UtKRghTFzI=
X-Gm-Gg: ASbGnctUaXWNe0C4d+Mx/K9WNWRUyz1SNmEFJidAPVXx/Ec62xlrJ3srRJMmOeTddUl
	qs2zB25tGT+58FmeTcRc608bH8vjzADaHAZtFNhLQIli7KiSE/Q9uP9ua1ii9wEdcV2UZUVmjq8
	w9hji5wrb98qn8yk1X0tSXVX+P6KmE3boTBv6QwAc3IQ1HjMFMr/mvGJh+1xI/bPI4NcNsqpd0X
	5e3ku1AAk5qOZnseOpFp6DAJZ2Tdkv80YnNFs2Q+oVxhyFiuK0vMgJb74UnuNkxusqc5teP/yp8
	0m4Lxg==
X-Google-Smtp-Source: AGHT+IEFoACeKCH1uG9TvSiHedGws80/XzcYKniH42ZqB89cU7BjxLsH9jysnL5OKB1iIvi5/WWwPA==
X-Received: by 2002:a05:6a00:1813:b0:729:cc5:fa42 with SMTP id d2e1a72fcca58-72dafbaa1c1mr4010673b3a.20.1737110817648;
        Fri, 17 Jan 2025 02:46:57 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([202.164.41.66])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72daba48eb8sm1574985b3a.136.2025.01.17.02.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 02:46:57 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org,
	christian.couder@gmail.com
Cc: gitster@pobox.com,
	ps@pks.im,
	johncai86@gmail.com,
	Johannes.Schindelin@gmx.de,
	me@ttaylorr.com,
	phillip.wood@dunelm.org.uk,
	sunshine@sunshineco.com,
	rsbecker@nexbridge.com,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 3/6] version: extend get_uname_info() to hide system details
Date: Fri, 17 Jan 2025 16:16:15 +0530
Message-ID: <20250117104639.65608-4-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250117104639.65608-1-usmanakinyemi202@gmail.com>
References: <20250106103713.1452035-1-usmanakinyemi202@gmail.com>
 <20250117104639.65608-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, get_uname_info() function provides the full OS information.
In a follwing commit, we will need it to provide only the OS name.

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
index 96f474c8e6..46835ec83f 100644
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

