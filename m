Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0153531E84F
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 11:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792062065; cv=none; b=GRu+/O3FTSkREduF2ndGMdulMFlIBVZk3CqM/+LVNOVuh3CZzsGv9xEZH8JGPU0j/cjubqAB68h9HkfLe50TrcHAPNhjIet4Zn+WvgrxfKUybVDQe2YrqlSi//IxBI8e817d7B2ATJTfCkuKYOaO5VfnvTQH3i2GS2U/AW1UEjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792062065; c=relaxed/simple;
	bh=IgoF8hHlb46Z1znyYSRuYfFT0+kYr3C3GG5Up6yzVbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FyyUNGSKS8HyjlqTUJSD1CCyIO8nHG7VYRLoKMAXujscwLFSwCvo+uD0+s/l6PNKF7YTn8UK5wdiLoMvwFnJWix9JtEi+Aiw/1wpbetN1lY4KXPDUlwYaPG1E2PLJUh7NxZThmI4bnNXYUz3sBg0tBMc0usS0w/vU36Y1SC/5NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pIkwfEko; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pIkwfEko"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-9905e692905so270613241.0
        for <git@vger.kernel.org>; Thu, 15 Oct 2026 04:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792062061; x=1792666861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8bpbWwXmAznsAhTsq8OyLE0/fv43JDVpOclCNEwStus=;
        b=pIkwfEko/En2dbjdljn2X55sFERjfcF/YepMn6K0PKKOBFS72KPo9klDoXZsuKMcvy
         uATJ+014r1Cp4shVOFgjQeEPAPmUgSiKM0urNQ57ISSc9RwblgxsdVfp8nWBciBFEvGO
         oZIUBMpraraVAsld03/X08JpwgkH5NXY+s8WpMkPunop9ATtI7212Z/Rd0xEgH8x+O8M
         jsogM+TR4I1jH+2v3QfOGss+j7fdqOJaDuzeEMbIA5h5VaLumLZSR2gQu5P40BxKCSVo
         1hHLu+QYcD+GLE/GS0tROS3K0XdQL6PRLQckqYfctI/aP4JCbGseupX6kpWQ4QRnDCPz
         A1Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792062061; x=1792666861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8bpbWwXmAznsAhTsq8OyLE0/fv43JDVpOclCNEwStus=;
        b=NhhBCMUNgzPy8bEQcGADZptkCPE7eqMQGV+nPM1pmugymFSEMfAYtDLZ2b7YejkSCL
         t5+A09dp1BL58yv6utC93WUi++J2VRcvmvBS5lPJ2c9xBi1FucstFT0Lm+vWDCXsmEI6
         wRtHuWGd6qzCgWLg8ZmSRjT0ZIe1sxilX6lgjdQtkQ3Kves02rkmB5I6fmG0GoSfstQg
         8Pcw3/XJYaDZVFuPM10dqrlevgwgytG74/EclAYe5CqkrEf/8yzl9rhuVYGG4yIgc6/w
         dhPZPpmgyxMGkC7RInL5chTbX5Ck5SOG1owqYrEP8ofcQoKkvy0kzAfHa04z5Vxv0kK+
         rAyA==
X-Gm-Message-State: AFq9FYIQ9mmNpltEOpOW7KCQlODw4unu2aGL/syY6ZHDNFcMK2E5t7uB
	Cw+fd/KbAP0cqB85r64AzH3ZpN5YdtKe3rbtk6mJ6kVdvHc4iQcOn2iHAPtRhetzmaw=
X-Gm-Gg: AYBFou0FRTGd5hGT7XOXG+OGOeBKlbnYmG5E/dMdovnFEsruesApggfp/++2TQZLwUU
	Gxz5/AdKnI0r1w2mnIaR7k72/S6RdhMVNuFzaWYRAczC+l7coktTZaUhz6Zjw+P9SCeJ+qNGtCQ
	E90G0U/Plg2DTsCKrh3xoN5XiD6iHutx3fuevukHyPqs9PjHqS6rVrZ/rwBbBaNjhcW83DieFFP
	i/n7u0ng7YN/GMXKvaRU847Nh/9Kf1gvARuI0aJrOld9xkp6a1FomsCwUDxgVUJjH3NtRsyqXJs
	EHPKVtCGkvH/Wv+hUG8NWm6yggpyN1Zn7DfFUHNoSGHM0UsHFgDo7VWOtUPaZfRZ1K95fLgyEbn
	WLGAgrKiUwZ73EjkjIBxjInZ+tJu3/UALnz4IqXigCk6z1mJcXISmzIpQOJKftOlYfFsLodxJp2
	eWAdBTJnx2gBi1CMcXPihnOsxcCtVy+Cg5WbdklBGqeDbuCF1F6OkaRt+fHEWU9Sfqc5TwyYvc/
	G5zXRlLtdOSAzsggB9iJRxydDNKzVyXyA==
X-Received: by 2002:a05:6102:2906:b0:7c3:6e8a:d4e8 with SMTP id ada2fe7eead31-7cb3a12cb86mr4159560137.28.1792062056456;
        Thu, 15 Oct 2026 04:00:56 -0700 (PDT)
Received: from isabella-caselli-linux.. ([2804:388:d001:9f94:7eb9:62e0:e1e9:151e])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7cb35471536sm13099381137.11.2026.10.15.04.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 04:00:55 -0700 (PDT)
From: Isabella Caselli <bellacaselli20@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ignacio Encinas <ignacio@iencinas.com>,
	Isabella Caselli <bellacaselli20@gmail.com>
Subject: [PATCH v2 1/3] var: add GIT_HOSTNAME
Date: Thu, 15 Oct 2026 07:58:57 -0300
Message-ID: <20261015105859.3184108-2-bellacaselli20@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015105859.3184108-1-bellacaselli20@gmail.com>
References: <20261012015846.2649843-1-bellacaselli20@gmail.com>
 <20261015105859.3184108-1-bellacaselli20@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Git asks the system for the name of the machine it runs on in a few
places. For example, "git gc" records it in "gc.pid" to tell whether
the gc holding the lock runs on the same machine. Users have no way
to see which name Git uses, and depending on how the system is
configured, it may be a short name ("myhost") or a fully qualified
one ("myhost.example.com").

This matters more once the config can depend on the hostname, which
a later commit adds as an includeIf condition. Without a way to see
the value Git uses, users would have to guess what to write in their
config file.

Add a GIT_HOSTNAME variable to "git var" that prints the hostname
Git sees. If the hostname can't be determined, "git var GIT_HOSTNAME"
exits with a non-zero status, and "git var -l" omits the variable
instead of failing.

An option to "git config" to show the hostname was also discussed,
but "git var" was chosen, since the hostname is not specific to
the configuration code.

The test only checks that a non-empty value is printed. The test has
no independent way to know the expected hostname, as the "hostname"
command may not agree with what Git sees on every platform. The
includeIf tests added later check that the value matches what the
configuration code uses.

Suggested-by: Eric Sunshine <sunshine@sunshineco.com>
Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Isabella Caselli <bellacaselli20@gmail.com>
---
 Documentation/git-var.adoc |  3 +++
 builtin/var.c              | 13 +++++++++++++
 t/t0007-git-var.sh         |  5 +++++
 3 files changed, 21 insertions(+)

diff --git a/Documentation/git-var.adoc b/Documentation/git-var.adoc
index 697c10aded..e813ab4fd2 100644
--- a/Documentation/git-var.adoc
+++ b/Documentation/git-var.adoc
@@ -84,6 +84,9 @@ endif::git-default-pager[]
 `GIT_CONFIG_GLOBAL`::
     The path to the global (per-user) configuration files, if any.
 
+`GIT_HOSTNAME`::
+    The hostname of the machine, as reported by the operating system.
+
 Most path values contain only one value. However, some can contain multiple
 values, which are separated by newlines, and are listed in order from highest to
 lowest priority.  Callers should be prepared for any such path value to contain
diff --git a/builtin/var.c b/builtin/var.c
index cc3a43cde2..b427ebd61e 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -115,6 +115,15 @@ static char *git_config_val_global(int ident_flag UNUSED)
 	return strbuf_detach(&buf, &unused);
 }
 
+static char *hostname(int ident_flag UNUSED)
+{
+	char buf[HOST_NAME_MAX + 1];
+
+	if (xgethostname(buf, sizeof(buf)))
+		return NULL;
+	return xstrdup(buf);
+}
+
 struct git_var {
 	const char *name;
 	char *(*read)(int);
@@ -166,6 +175,10 @@ static struct git_var git_vars[] = {
 		.read = git_config_val_global,
 		.multivalued = 1,
 	},
+	{
+		.name = "GIT_HOSTNAME",
+		.read = hostname,
+	},
 	{
 		.name = "",
 		.read = NULL,
diff --git a/t/t0007-git-var.sh b/t/t0007-git-var.sh
index 2b60317758..f50c62a25e 100755
--- a/t/t0007-git-var.sh
+++ b/t/t0007-git-var.sh
@@ -224,6 +224,11 @@ test_expect_success 'GIT_CONFIG_GLOBAL points to the correct location' '
 	)
 '
 
+test_expect_success 'GIT_HOSTNAME is not empty' '
+	hostname=$(git var GIT_HOSTNAME) &&
+	test -n "$hostname"
+'
+
 # For git var -l, we check only a representative variable;
 # testing the whole output would make our test too brittle with
 # respect to unrelated changes in the test suite's environment.
-- 
2.43.0

