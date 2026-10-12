Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E32C1AA797
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 02:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791770467; cv=none; b=emaQV9HSmV/RShVRx+8ZU3KWuI3VjJWbB4nDR6HYOCCGQVqUaHJ/jpMkazKtZ7rl37lDMtWbM1+Z699D3Qw71A5KH5C2toPj8d4/KgYia3HQ8ynLHyN/29yeDxTXJMh3NWudQ057aK7ZSOtruSTpTHkbqpse0kXSc2EAkmlhdKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791770467; c=relaxed/simple;
	bh=IgoF8hHlb46Z1znyYSRuYfFT0+kYr3C3GG5Up6yzVbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nx+T4wTWI0UeL4BjcmY4BDQAtvlE5zT/xySNBrz6AGoqU+We9DIJm2kbmsDqOj49pk/DfLq9e0PX7K8GJ5uKofxq7Bll2mRQgduIWixCYGi8vOv/7v/IiO53rN6O31T/ZF8Ii3L//DDFHBRnAgntwm1apUhldrYgxzL4JOSHC+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fVDwSFUU; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fVDwSFUU"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-3514e7cbbbaso3603732eec.1
        for <git@vger.kernel.org>; Sun, 11 Oct 2026 19:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791770465; x=1792375265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8bpbWwXmAznsAhTsq8OyLE0/fv43JDVpOclCNEwStus=;
        b=fVDwSFUUkm32GDGExUn6E8CSxcdkCcoreCVv89ggcZJPFlt71cHpe6q418imQEVFqW
         Ka7nB59ee/0Wzf7mp9Fm8JIvPRE1d7nIO1FIBM5kzVHOZfw7SPLJyRJ4CTfOM6fTwiSt
         Zpt0Uf4t2mhe3p/71DCqznllbv8TXyl5wGXx4TQ4Efi68Y4+8eK0aAXKO/LvaOJAZT/5
         IQZJDidw3Hz/oeAH1X9ciupzV2Yy5vwlpRT79KRyVADV/9E6+8dRCNpjfCd2/Uq6TJKc
         G/jwaMNrofXn5voAfylQQko793FoXMR3FQ/ouuuKypyRVOigfjgz89DDx6qgP+caHA6t
         A3Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791770465; x=1792375265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8bpbWwXmAznsAhTsq8OyLE0/fv43JDVpOclCNEwStus=;
        b=saH1WXPIfN0ie7fVonvBTgp3HwkFgfuxAu4FUqrxNuXJRisdiwoqtL5Vc73tV9LxHo
         lOcioE9U0sjAPIMAQloJMThhp+Un83oCP1kZ9AWMbk2qU+cn+HzLEH6hfyPP2+Vcf5Cu
         SsydQztK0Zjha0RMks+pA/s7sZu3+nO8TVdeb9b3TV7gFzicq5c10++PExBf1ninFgHE
         c6ZYgVaNClxpzRvqLbulgqREEgDE4D0U7Kx8l44gEAaJ0rgP5Hq6Furq3/XEVQfjCoCg
         XZauZe2WHXqXpFhTMHsLzdy0K5XVCeuV7DzaNwn9t4a1c48E06h0M/WJI67JbHy4HPNX
         G3iA==
X-Gm-Message-State: AFq9FYLwHNmZB8NCDiEebAxR1RMdOLNahC0FFN5EH5C3m4d2kHgwMgRr
	31TTh+cWCorC8ltvEcM7QHBshSqTd+PvvWFfuzHS6QZe0YLSdh0RhDdkchH9+9zZ/Cw=
X-Gm-Gg: AYBFou0erIuelg1Tx26M3to2cfdhF0OfgNA5P5wZXk+ZYljuFBlUhb5WI580kExx1oq
	d48fZJL+yboaK9A7jWYtmItaGy17F5n/gnOSLv9QznNa0sajgewZ/RHQqdn99T/Oy5oSiUWYf7r
	Ln0TKcruqGSLFP1cnxDyjmV2fYzA8bWS5W2uAy+tKlp366SteTByJaVlIwoHXo8+ngA6+6M8MqG
	W8aDn69dt4peAtxVB5IVJrSbhdLeiHn49iOMXxglWSMTLOdV6YiOZ+S46zijpfE6EARCPzhDusC
	pA2fSZCvpZKhJU9qFR5h3XqOFDiji7njIdPTSNfgx63xhGoNHXRLmYctUgR/wQhOSLzzAS3edWw
	bjdvJffKbXC66EBUuOgXT0j+m9Z6AmBRj+gxFbS/YtGOAU3LR/vvUWx4V0lBrZLqV1cH39c3Pao
	wQf0YGGlJJ3aobeLg9V9eS/o3PPJCeaWgM/h3AZw4Bawp4KFFMy1Ms7eYFHYnFpKYK/q2tJUnJZ
	kq5KsRlhOCV9eIuwhOxjVbB5Dr9VmDk
X-Received: by 2002:a05:7300:e9cb:20b0:358:c707:4c3d with SMTP id 5a478bee46e88-358c7075049mr6669179eec.4.1791770465122;
        Sun, 11 Oct 2026 19:01:05 -0700 (PDT)
Received: from isabella-caselli-linux.. ([2804:14c:9e:81ad:adb8:bc9f:a8c8:3c2d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35a352d4b05sm7196412eec.19.2026.10.11.19.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 19:01:04 -0700 (PDT)
From: Isabella Caselli <bellacaselli20@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ignacio Encinas <ignacio@iencinas.com>,
	Isabella Caselli <bellacaselli20@gmail.com>
Subject: [PATCH 1/3] var: add GIT_HOSTNAME
Date: Sun, 11 Oct 2026 22:58:44 -0300
Message-ID: <20261012015846.2649843-2-bellacaselli20@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261012015846.2649843-1-bellacaselli20@gmail.com>
References: <CAK4AdTSnaAOk649a0GLe1M9C+cYuDa0Nwo54=HT47R53Q4ZdWw@mail.gmail.com>
 <20261012015846.2649843-1-bellacaselli20@gmail.com>
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

