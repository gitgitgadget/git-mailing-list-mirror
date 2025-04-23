Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D75D292904
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 08:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745396145; cv=none; b=bj/EIMNnLukG6wtGPGRZmvp6kp+CIeghMcV0CJzyqziryE1/6+nDRtvpg7erj+bT4oX7u2zjKqufjxZQHW/nocgD5H46fYjIF6a70cqdGCy/L7NXOF3PdLZvDAnT5seC+FNKmIHc9TpaHfdLGT81A66CxLRyJozaLTOxLZ84YVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745396145; c=relaxed/simple;
	bh=0ETgq2W5JBqC8pE6e2kgkbv8gEPcHm5n2rQEuN57XKc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m85fG4ncuzX/SYL1EW5FIT7rnoXXADmsyQjkKBF3999DEyewovUCeseW8dtQxYRLdlzntbpaN92Ne5rk4sHrMDOuJqQPI6plYPIESfe3YJg/Ec0lY5aDv/LIHAGOX+n9HTlBPLzD1JN3CTU3imdIJKDroCq5xo8FH59Fy7MjK7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QEa0yKJK; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEa0yKJK"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac2902f7c2aso937203866b.1
        for <git@vger.kernel.org>; Wed, 23 Apr 2025 01:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745396141; x=1746000941; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BQkQc7nSywrFDYuZJVQK7WPb9maE56joqk8zUhXaOLY=;
        b=QEa0yKJKM1FM4sjNBVGcHrnt2htqv9qhGqfTfHX5LwDlZANDJt79OsKSJBdGWSG3J/
         2P0Ip9bK7nrkM9kmWBjsmgU9Hf9cLKWAxyVwTBoq2FvrYF3LZ0/27F3VdSOzluGU6CWk
         rGxopTMMbjZ3JLIIN5xpvJ17nCtkheKaTmUlGVMBDVXhBbWdENBR7rUaJBUlg8WFQ62A
         hLQkg3q3dhquPfS4QZu+l6pBptLgx77uA4CGJw/mxgT+2TfMJTqnlrre+9E232sxVmdo
         O1ONZjymq1kveTwgPgYtLbHiVaLU4/7RPBPmj9kdIF0mjGnxJPuM2jYi7/NRG8GTp/lZ
         YuAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745396141; x=1746000941;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BQkQc7nSywrFDYuZJVQK7WPb9maE56joqk8zUhXaOLY=;
        b=PruDrhavOgC3WajlZ/LxjKMPP7AuvKZXZGPaKXwYZ1o/t+9WGHyDOM/YBRD8eOvRaM
         EB1kaO5v8s1xkNFVjJ15LbJN11sjWH0GXYXrDqlXxZHTXXacY+VBcFlOQCOKUCoXgIHy
         +AxVDtwCLS0Es9W729gafZelmn8+WWOdVgOxxcfA0W23KWSz/R8D0hLbOcVe8dWoYk/a
         SQALOUtQSMtQV0xOgQGiJDOCYHNHdtC1cymvg6v7RhJ/IQl4vol8EBmxTPwbTz1vOFaC
         LhDDMALjM9CtWugf2mguCKlAt+hUjIVcoOerhJkp5IKmF0gBblqfBJQnUCx3YsE1UMFz
         FHbg==
X-Gm-Message-State: AOJu0Yz+/E8YvJ8bzYeRGdF/T6GfNGDobt/HGb9rQcy+A6maolmDq/L1
	P2I8ijRLbhG/auGRAOBgQS+4G5f3XVW55i81cVezpNHeMgNDXxsZ
X-Gm-Gg: ASbGnctUOwsinUxpUR/COlrZ8L+3reelySrJ1JTrKn7ZiETHyILKoc2aF9KYom8g8Ri
	PlrBf0DjKJ7LGvV3I6B8TzDxKQXbCoiSxnwHd5Mcec4gs6mU15lCSF/KNmeje24mI+gTStINkkm
	ZoCi01rjEgbsnzoO4khwk+l4BCdF+qOqA6i2gZ7dF6Hn6/s/tVqPuzUqGgnG8B3ZENOITN6orGK
	YpP4hUCoxfXVSBend6KACF4s5CoLsTBANpA/s7CjBoL9lGzkK3qewor6/zfgy9LinY7Oohpaz2D
	4cCve1ZQsWMRYHUUe0iikfD6ZxG6BkHJSXrb3k1bQ8stSQk=
X-Google-Smtp-Source: AGHT+IFVzyYBQ9zyXNBoUkwb08aBfA7eO6OO+Ba0z4ADhsOME8hCO1PM6n4Mu68Yi8AgeAiSBZ55Sg==
X-Received: by 2002:a17:907:86a6:b0:ac1:e2be:bab8 with SMTP id a640c23a62f3a-acb74b7c1ebmr1532353666b.26.1745396140710;
        Wed, 23 Apr 2025 01:15:40 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:8764:66c7:f630:d3a4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb6ec13a5bsm766577266b.27.2025.04.23.01.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 01:15:40 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 23 Apr 2025 10:15:36 +0200
Subject: [PATCH v5 3/6] meson: move headers definition from
 'contrib/coccinelle'
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250423-505-wire-up-sparse-via-meson-v5-3-d1e2be4b2078@gmail.com>
References: <20250423-505-wire-up-sparse-via-meson-v5-0-d1e2be4b2078@gmail.com>
In-Reply-To: <20250423-505-wire-up-sparse-via-meson-v5-0-d1e2be4b2078@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, toon@iotcl.com, 
 gitster@pobox.com, phillip.wood123@gmail.com, ps@pks.im
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3364; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=0ETgq2W5JBqC8pE6e2kgkbv8gEPcHm5n2rQEuN57XKc=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGgIoagVlthgzjVws2CUIDwsv0/lp8uwm7JCo
 eg9qFvNJo5A/4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoCKGoAAoJED7VnySO
 Rox/ZF8L/jsgtsOTrWHL1Wuxc/x4Apnk0r3u1fhpIU1e/yAVKiUMVj4n5+EAmUwk9bd5jNemp1I
 Cx9FPMWjQW1d40atZppd9QIdv9erKMGivMHAKQhUwibtxaQvU3cK29QV233PAK6DwCx7nmTDeh0
 Y4BJCPe0kOYPifsEN0yY+vfdWqLg1n47b3rL7A7AcqOEzS7b91t89OYINEp0q8IT0tUz+LLfF6p
 6tmtP5/NswKThSQNVh+U5JiIFFHNTgC9f8f9QL+qdXZ0sP3jYF2fwjG8jV4mUN5iZMUsEtFVaer
 +b8nuXPQMhHzlEuINszEpEAUcNMmsBuhIWtsD0leph3bpQyvtCadNw83nMpJbtZbEQdq84ilToT
 2Rmsf2mYTItGLnzMe0b3ZzSv+ZR0grL43XsrorOK7cAdSxrONA/iNGwLnR+L1UWK/qDGcxvOd2f
 +mHvSAJ8f0i1MZzmr7F2z+nWvLBudZH0ERO1nfQ1cNkJcMmMGRAbcsKeUnkXmgi2Hn4PEp+rwM6
 gY=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The Meson build for coccinelle static analysis lists all headers to
analyse. Due to the way Meson exports variables between subdirs, this
variable is also available in the root Meson build.

An upcoming commit, will add a new check complimenting 'hdr-check' in
the Makefile. This would require the list of headers. So move the
'coccinelle_headers' to the root Meson build and rename it to 'headers',
remove the root path being appended to each header and retain that in
the coccinelle Meson build since it is specific to the coccinelle build.

Also move the 'third_party_sources' variable to the root Meson build
since it is also a dependency for the 'headers' variable. This also
makes it easier to understand as the variable is now propagated from the
top level to the bottom.

While 'headers_to_check' is only computed when we have a repository and
the 'git' executable is present, the variable itself is exposed as an
empty array. This allows dependencies in upcoming commits to simply
check for length of the array and not worry about dependencies required
to actually populate the array.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 contrib/coccinelle/meson.build | 17 +----------------
 meson.build                    | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/contrib/coccinelle/meson.build b/contrib/coccinelle/meson.build
index 03ce52d752..4f07824402 100644
--- a/contrib/coccinelle/meson.build
+++ b/contrib/coccinelle/meson.build
@@ -8,21 +8,6 @@ if not spatch.found()
   subdir_done()
 endif
 
-third_party_sources = [
-  ':!contrib',
-  ':!compat/inet_ntop.c',
-  ':!compat/inet_pton.c',
-  ':!compat/nedmalloc',
-  ':!compat/obstack.*',
-  ':!compat/poll',
-  ':!compat/regex',
-  ':!sha1collisiondetection',
-  ':!sha1dc',
-  ':!t/unit-tests/clar',
-  ':!t/unit-tests/clar',
-  ':!t/t[0-9][0-9][0-9][0-9]*',
-]
-
 rules = [
   'array.cocci',
   'commit.cocci',
@@ -61,7 +46,7 @@ foreach source : run_command(git, '-C', meson.project_source_root(), 'ls-files',
 endforeach
 
 coccinelle_headers = []
-foreach header : run_command(git, '-C', meson.project_source_root(), 'ls-files', '--deduplicate', '*.h', third_party_sources, check: true).stdout().split()
+foreach header : headers_to_check
   coccinelle_headers += meson.project_source_root() / header
 endforeach
 
diff --git a/meson.build b/meson.build
index e98cfa4909..e147ddff28 100644
--- a/meson.build
+++ b/meson.build
@@ -633,6 +633,28 @@ builtin_sources = [
   'builtin/write-tree.c',
 ]
 
+third_party_sources = [
+  ':!contrib',
+  ':!compat/inet_ntop.c',
+  ':!compat/inet_pton.c',
+  ':!compat/nedmalloc',
+  ':!compat/obstack.*',
+  ':!compat/poll',
+  ':!compat/regex',
+  ':!sha1collisiondetection',
+  ':!sha1dc',
+  ':!t/unit-tests/clar',
+  ':!t/unit-tests/clar',
+  ':!t/t[0-9][0-9][0-9][0-9]*',
+]
+
+headers_to_check = []
+if git.found() and fs.exists(meson.project_source_root() / '.git')
+  foreach header : run_command(git, '-C', meson.project_source_root(), 'ls-files', '--deduplicate', '*.h', third_party_sources, check: true).stdout().split()
+    headers_to_check += header
+  endforeach
+endif
+
 if not get_option('breaking_changes')
   builtin_sources += 'builtin/pack-redundant.c'
 endif

-- 
2.48.1

