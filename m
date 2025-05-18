Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AF2209F45
	for <git@vger.kernel.org>; Sun, 18 May 2025 07:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747554218; cv=none; b=K3JZoedhzaMNC9e45EJryb5eyUsLSW4EdKyC4qvlfQYcn/AqNO20dgandUJY7vu5w/fPZVq+2R4zmSL61MG5c3aiaAksEfqeIqYGjoyaY9hsZSF+jOQIO0UCkvgQG7f2ZaIytOkjxjaaUz6dVU0Kz5RzWP1a8V3KVRBv2KmAc6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747554218; c=relaxed/simple;
	bh=Yb1ek0lClboIairr5Vk5ApHD+LIwZEvsKfwlWEKMWuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M1JIg1tVQiJ6W+Bk/kjkf0FMtCDESGNRxdrR/gxQQO8znxocrgYXhTiom++hIpemoTog/IqmiwqJrVRKqTPwNN/C4j3ghbf2ma01mxbSoNriBokrt0fv82jKCyRMZK8J1XvsfhtY/Ka48ZHYK6aMEisVMUNFfJn/2C2g3PzMuxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fOD0OdaE; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOD0OdaE"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b26ee6be1ecso1326039a12.0
        for <git@vger.kernel.org>; Sun, 18 May 2025 00:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747554215; x=1748159015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CdtSdPimipaF6pT2LJ2ParwcPUaiMGRS9ZOpCEqNRpM=;
        b=fOD0OdaEU5Mkhwhz75uW9UJHvlqCPqMVusLlUP5CbezHQEZyiVhM8Ke/zsQjSNVN/y
         0Vf1UZKgKtQmLqPsokNhQN3Tk/3DDJTO/4oQii75wVluP0Kt3IZZV8svfTNMLaoh790q
         FpZdRHakh6J+2xxaleSV32AjcUKzF60hJ79m7cEIoca4T5CsPhW10l1e9+ICNGLSJUUy
         79u/WVb6uSushfp+aJWVH51k4hlkas3dZYSf/6USOkOP6G/gTpU2MjLL6VGLaK6ZHrbj
         xZ/x9OCKHl8TCE2U7IRwK6HeqNh89MWp0u6+9vdlAb8tty47IzOcbgnx7BcZEAtZnxcx
         jnEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747554215; x=1748159015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CdtSdPimipaF6pT2LJ2ParwcPUaiMGRS9ZOpCEqNRpM=;
        b=knf2cjahl6TnDUML6uQGwcmeTcEdyzWNAR6HunYRU3CgANh620obkH0qmc109tWEuu
         cUmLP3KtjojjEjbYgIFPNa/HpKk9uejz/sIlX8epAe7NewIfqiTXmNyh49o1ScuCRYho
         hav76sOF3cPLPeDC1WieQ1xV8yPBb31PYfkMDcwTMgf/X+FY5LoCenMpyA6Ei4SVuROr
         zGnk8KnRo4D6jNLOMCyra0gmqzsuy1klG4kFTgccGfPmJaQQbj7+5z66FhbY6iGjmZOs
         0YW8SskbjPAmLJUahN752+Zv8b7+SCDElZGzsMdjMNS8xVMlP089Hyng/8mbP/kByqLq
         gbew==
X-Gm-Message-State: AOJu0YyYKdy+o+QTQcdneGDrgKZZYr5zurY1K9nri4Su+z7mfgxEVlm7
	qvvv71phtyNyqA8F3UxscVKiOD0/C6SOemNYxHd6Ynq6u8bV+yIDfvy6vcwrYC1k
X-Gm-Gg: ASbGncuxTQ3KHsiqnJgQBw9B5fRvCaP8/Tgqtd0bpMeT/XbRFKavFEUmZGGCqoIaj0x
	whOZja+ILTIkjSHoPUimNwpSdsX6yis6/qTjHNYYikhX2AIOXC0T6MpRDdMD35uJtpaorkwYbib
	X66jypNQFivpMCd5TF9xxWFJMjn0ErQiuGvtvMv6bDqvRhRVDlcPkIwvPHAs52IyCrlUUXc0k+a
	KfgqfJRVRtO6gLtN32o3arhY7oRR/QBLylfLWr/waW5ju8PQhjy0U3Kc6e9ANDLsxRj2ynbulQw
	NynKiRITIoJ5OOpYcJ9KtXCpGGh94m9tOIh1DHqTMUr7Y6AegdN1vlPBAXeeoQ/Z62bp8eRIeef
	huw==
X-Google-Smtp-Source: AGHT+IG6cO0Ok0wQvH34GRmYEzmklwg+LViFEjxdS4T5rOtE/qtaadDnZjSF05NYbS4MeDXOVz4MAw==
X-Received: by 2002:a17:903:32c4:b0:231:ba39:d927 with SMTP id d9443c01a7336-231de3ada60mr128050835ad.38.1747554215553;
        Sun, 18 May 2025 00:43:35 -0700 (PDT)
Received: from fedora.. ([2405:201:c005:b018:6a51:b86d:8d8d:758])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4ac9fbdsm40131625ad.50.2025.05.18.00.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 May 2025 00:43:35 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	jayatheerthkulkarni2005@gmail.com,
	nasamuffin@google.com
Subject: [PATCH v4 2/3] docs: clarify cmd_psuh signature and explain UNUSED macro
Date: Sun, 18 May 2025 13:13:16 +0530
Message-ID: <20250518074317.73367-3-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <20250518074317.73367-1-jayatheerthkulkarni2005@gmail.com>
References: <20250518074317.73367-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sample program, as written, would no longer build for at least two
reasons:

    - Since this document was first written, the calling convention
      to subcommand implementation has changed, and now cmd_psuh()
      needs to accept the fourth parameter, repository.

    - These days, compiler warning options for developers include
      one that detects and complains about unused parameters, so
      ones that are deliberately unused have to be marked as such.

Update the old-style examples to adjust to the current
practices, with explanations as needed.

Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 Documentation/MyFirstContribution.adoc | 28 +++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
index ef190d8748..da15d43d1f 100644
--- a/Documentation/MyFirstContribution.adoc
+++ b/Documentation/MyFirstContribution.adoc
@@ -142,15 +142,31 @@ command in `builtin/psuh.c`. Create that file, and within it, write the entry
 point for your command in a function matching the style and signature:
 
 ----
-int cmd_psuh(int argc, const char **argv, const char *prefix)
+int cmd_psuh(int argc UNUSED, const char **argv UNUSED,
+	     const char *prefix UNUSED, struct repository *repo UNUSED)
 ----
 
+A few things to note:
+
+* A subcommand implementation takes its command line arguments
+  in `int argc` + `const char **argv`, like `main()` would.
+
+* It also takes two extra parameters, `prefix` and `repo`. What
+  they mean will not be discussed until much later.
+
+* Because this first example will not use any of the parameters,
+  your compiler will give warnings on unused parameters. As the
+  list of these four parameters is mandated by the API to add
+  new built-in commands, you cannot omit them. Instead, you add
+  `UNUSED` to each of them to tell the compiler that you *know*
+  you are not (yet) using it.
+
 We'll also need to add the declaration of psuh; open up `builtin.h`, find the
 declaration for `cmd_pull`, and add a new line for `psuh` immediately before it,
 in order to keep the declarations alphabetically sorted:
 
 ----
-int cmd_psuh(int argc, const char **argv, const char *prefix);
+int cmd_psuh(int argc, const char **argv, const char *prefix, struct repository *repo);
 ----
 
 Be sure to `#include "builtin.h"` in your `psuh.c`. You'll also need to
@@ -166,7 +182,8 @@ Throughout the tutorial, we will mark strings for translation as necessary; you
 should also do so when writing your user-facing commands in the future.
 
 ----
-int cmd_psuh(int argc, const char **argv, const char *prefix)
+int cmd_psuh(int argc UNUSED, const char **argv UNUSED, 
+	     const char *prefix UNUSED, struct repository *repo UNUSED)
 {
 	printf(_("Pony saying hello goes here.\n"));
 	return 0;
@@ -279,8 +296,9 @@ on the reference implementation linked at the top of this document.
 It's probably useful to do at least something besides printing out a string.
 Let's start by having a look at everything we get.
 
-Modify your `cmd_psuh` implementation to dump the args you're passed, keeping
-existing `printf()` calls in place:
+Modify your `cmd_psuh` implementation to dump the args you're passed,
+keeping existing `printf()` calls in place; because the args are now
+used, remove the `UNUSED` macro from them:
 
 ----
 	int i;
-- 
2.49.GIT

