Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BB2BA34
	for <git@vger.kernel.org>; Fri, 21 Mar 2025 14:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742567442; cv=none; b=mgkMVr49goQlLTbc7ez7z+nhVlrV5KK/ddElJk/sIUkxoZ3ije3s2o2ajcZ1nuN8nvllP9N7Ub0Vu5uVBhS41tTdGPw4+TpsURlyYHi5ALoHNVoQkszHJowLmRpYZyiildCe/fE71tIfbSh6EZD36DuAzcY9rhYAZbILNUbySqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742567442; c=relaxed/simple;
	bh=83uTiZGIGDPswk7Ho2ng5L/UIZFlSDUoSBkMyU0ecyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K/ihM/U9aDQ2pBIvA7WvgK65qn5TajitCA3ns4LvQxjKYAZ/jI8pRIeOuq/chtk9b9UufleCRwoeik48JYR91AuMbcaTyfeF3gq09KbpegFuKRUo/coyhWOFi6JiF3C78BN/KxQ+K70WOFH+ERZBetQ/htquB31nG8A2/0GPW1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i1PHdb+a; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1PHdb+a"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-224171d6826so6247355ad.3
        for <git@vger.kernel.org>; Fri, 21 Mar 2025 07:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742567440; x=1743172240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zAy4G4N7Vbf0MuGKmf17Q+uZ4kyK5QMc3eJXl/cIouo=;
        b=i1PHdb+aSCSmg20iYsMV3YCbCsX1ZoeI/wp9twizEZHVSzzBSfLBIP0B1fAgZe1XSV
         BnG9E37Fzp48pwjf1gultu09FGi10UEJ/Dpr2O/8cJUBUYPX2YVIFBaCORCaNZp4Hk36
         GNBedtIDU7VphHleTCibHZDBPsAB8FdSSXXk8/dDUIxZMmJPPUtXRI3hGqLajN8a+6vV
         QMDFrMLTTc+W7LBctBFU65QzOTUjBAfa6afRRyvDBGi+PAej5nXuIgNlSRU4NzLOK86w
         m0iryKqlZBHe5EGUnYiMGwo8voEO5+MdWNMaCUBOjkDpPJn8w+TXFN7myEZ/Hjc72diV
         aBOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742567440; x=1743172240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zAy4G4N7Vbf0MuGKmf17Q+uZ4kyK5QMc3eJXl/cIouo=;
        b=NMpYv3IVKG0E0acNFboUQwBJYM0wM+/6SSRh2VNhdhKwi0KKjHWU+b3S1VT6WvOEL5
         Clel8M47ZV2XMLzIKK9r6XeXC+ADEGeT3ZHqziBdmQ0yqkRI8F0cMsKuuvDAX4Nvvn13
         tQrju8hb3ZGs4UdPN14X1w9oDH0qUCUiuQXz0EdPYrY7H0uNHnhbNygFKP6lTeLTqZUB
         4Zfop6DGm2Ch35/90Hx9kpBrNlUOPO/PwO/yB4lH2Qc7prc0O4D0oojcogJnwKZVwYez
         HU5hqrGkDgJDKX9Xhb8rVmbI6F5bC+lTvTf99xgy3PBO7eLNXnnfHkJLHwDSEqN8omCy
         9/oA==
X-Gm-Message-State: AOJu0YyylR3/LqNfoCVUD5+dwPl0fUTAVaFl2XCl56VCZQyCDRa/otUb
	UQM+j7ZvtphvZDBQxWVbdJJeSX918Gb9Ar6w7PhcrxAztq9Q5MeT0OraiaUX
X-Gm-Gg: ASbGncu8aicPxSLAIpuAsokzX3+dtRzwuHvkmLmnGQsHShvaOg5VEkvOKv+Cqk3FqPK
	hzmrqG17UnV0tMSpYTa7zQI5nje2srEDCgKyQlW0XzJrfk04Yqo76r+rXqC+kjh0crrm5El5dw2
	C3W23G/IL7SC6ipyC2J1INx4GQfAc1ukHYJlACOPFP8TBNj2s0Yz0W+aFo+LUbVy33Ao1jU4DB7
	gmSc2dIF9AnHYpf1SwbWBOQ88GdhQJ8XQliA2qwy0+g4s9M1utxKwEEKpSScLDWpIeXh5WqPEAZ
	wn0PrQB4z8cMCRFKPv6PvnhxC6W7iPgZfmes7BKad56BfHfIVgUucca+3puz78toJ6qNaTDo5uU
	zXjQ=
X-Google-Smtp-Source: AGHT+IGkpX/0+nSLNxsV5N4HpfjlxFyR4Y5+TVep5fKf2LAfeZHKA+73o/GrCXz1WugRTPNTQ7YHfQ==
X-Received: by 2002:a17:902:ce8f:b0:223:5c33:56a8 with SMTP id d9443c01a7336-22780e15328mr57733385ad.35.1742567439706;
        Fri, 21 Mar 2025 07:30:39 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c005:b018:5841:514c:af52:5598])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811bafabsm17054835ad.139.2025.03.21.07.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 07:30:39 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ben.knoble@gmail.com,
	jayatheerthkulkarni2005@gmail.com
Subject: [[GSOC][PATCH v3] 2/3] docs: update function signature, add UNUSED macro
Date: Fri, 21 Mar 2025 20:00:21 +0530
Message-ID: <20250321143022.5406-2-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250321143022.5406-1-jayatheerthkulkarni2005@gmail.com>
References: <xmqqa59evffd.fsf@gitster.g>
 <20250321143022.5406-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modify function signatures to include struct repository
for better compatibility. Also update builtin.h
accordingly and use UNUSED to prevent warnings.

Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 Documentation/MyFirstContribution.adoc | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
index 7b856be41e..45efe117ab 100644
--- a/Documentation/MyFirstContribution.adoc
+++ b/Documentation/MyFirstContribution.adoc
@@ -142,9 +142,13 @@ followed by the name of the subcommand, in a source file named after the
 subcommand and contained within `builtin/`. So it makes sense to implement your
 command in `builtin/psuh.c`. Create that file, and within it, write the entry
 point for your command in a function matching the style and signature:
-
 ----
-int cmd_psuh(int argc, const char **argv, const char *prefix)
+int cmd_psuh(int argc, const char **argv, const char *prefix, struct repository *repo)
+----
+Before proceeding further, we should use the UNUSED macro to suppress warnings about unused parameters in the function.
+This prevents the compiler from generating warnings when certain parameters are not used within the function body:
+----
+int cmd_psuh(int argc UNUSED, const char **argv UNUSED, const char *prefix UNUSED, struct repository *repo UNUSED)
 ----
 
 We'll also need to add the declaration of psuh; open up `builtin.h`, find the
@@ -152,7 +156,7 @@ declaration for `cmd_pull`, and add a new line for `psuh` immediately before it,
 in order to keep the declarations alphabetically sorted:
 
 ----
-int cmd_psuh(int argc, const char **argv, const char *prefix);
+int cmd_psuh(int argc, const char **argv, const char *prefix, struct repository *repo);
 ----
 
 Be sure to `#include "builtin.h"` in your `psuh.c`. You'll also need to
@@ -168,7 +172,7 @@ Throughout the tutorial, we will mark strings for translation as necessary; you
 should also do so when writing your user-facing commands in the future.
 
 ----
-int cmd_psuh(int argc, const char **argv, const char *prefix)
+int cmd_psuh(int argc UNUSED, const char **argv UNUSED, const char *prefix UNUSED, struct repository *repo UNUSED)
 {
 	printf(_("Pony saying hello goes here.\n"));
 	return 0;
@@ -199,6 +203,9 @@ with the command name, a function pointer to the command implementation, and a
 setup option flag. For now, let's keep mimicking `push`. Find the line where
 `cmd_push` is registered, copy it, and modify it for `cmd_psuh`, placing the new
 line in alphabetical order (immediately before `cmd_pull`).
+----
+{ "psuh", cmd_psuh, RUN_SETUP}
+----
 
 The options are documented in `builtin.h` under "Adding a new built-in." Since
 we hope to print some data about the user's current workspace context later,
@@ -285,6 +292,8 @@ Modify your `cmd_psuh` implementation to dump the args you're passed, keeping
 existing `printf()` calls in place:
 
 ----
+int cmd_psuh(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
+{
 	int i;
 
 	...
@@ -298,7 +307,8 @@ existing `printf()` calls in place:
 
 	printf(_("Your current working directory:\n<top-level>%s%s\n"),
 	       prefix ? "/" : "", prefix ? prefix : "");
-
+	...
+}
 ----
 
 Build and try it. As you may expect, there's pretty much just whatever we give
-- 
2.48.1

