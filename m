Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED2D78F30
	for <git@vger.kernel.org>; Fri, 21 Mar 2025 16:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742575161; cv=none; b=BpDqxeC96yYcIYEHBNG+arUYJTSBjmu9L28jjmI9NRDE2eC+PVgsIhfDyGRjnxO/1f5R7OD4zrrwZ7TMDaLHWvKlNMXTBZxBjDjowCkf86yANqLBZrIc1vdVKqCCnGpGvZhmQqJaMAnR1HHDFJBPzyIBirMAmNk0NK5SIF4XQsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742575161; c=relaxed/simple;
	bh=MDFUNZlcB1/DQnf2Bg7WulmVeGVtB66cPj6Gw0uQ5no=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RfA0RspTFhrTjwk7t9kWLOiOPLdH9lr9jv+famgyNeengqf7qqXwYjVyyM8BEMB0qr6zf75eRcTFwStRznm/xKzzO6hzuUHrn9KFWOwk1hl9Pbjvj3j76lHcAowpt1882FY5i5TvWJVXaqvKImD5rk6+vvUzGrmHm4gvu7e13I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m2pSZlkV; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2pSZlkV"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac2ab99e16eso435606566b.0
        for <git@vger.kernel.org>; Fri, 21 Mar 2025 09:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742575158; x=1743179958; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oLmzeK9gakIQf9flDiks/rHpH+AC3XjvwG6Mx0qEuh8=;
        b=m2pSZlkVUtVlfBvRE3N3LrxY9bNPGDIFYWmJroKe11BnNt6jwJTytjkASOtI1UpkfF
         cOzHrQxo8mhGCqhKTZMaKqmyGag+ZcKcWY0KzV/RrbUdBQnAp91GegiqH04gDWe36xW1
         KJzJ4SD+glwRembgeWE1DYsr+qvngOl14JCHxcQ4GQ1RMuk0HCKxo3yyuxGu9Q1Hvzp8
         MF/TIob+W8hf/usUq98rvJ5lwwlPTEwlf7i/MgpCvmRdmfbzAFGl6Qwt1wneuXrJt5bF
         vYOoTe3F9I7wPItDOoQDqGELZuAhYeRKDHoowaOqIA5fru+9o3uYHP2/dbuu++qYDUIM
         dV+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742575158; x=1743179958;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oLmzeK9gakIQf9flDiks/rHpH+AC3XjvwG6Mx0qEuh8=;
        b=XLeF/HstNfjGSdVEIFI8lOnpFHnclqjT2sF0P7LHPxm7Szw1WIVFZ/zCmLWTfxhIMw
         CBVUT+/P6DKCmaBQUxI8uzObXQhBz8nQ8Ue4DKQhD1JkcX/Go3jeZL4tpXnk+R6tldsw
         qXD59G+v3JIMdhom32c20mBFLgH5PC1fhRqan7NGG/k14ypDhLZJUm2nQXLpu3viA2XH
         TOZnRI1PfttaSEZoadaEhBVECI6QKFpNP+ytyLGB2U9si7xaByU5vrF+nzGLx9sBoE3T
         tCJMw9oyJeSGDWu58smXdwkYqhHXnK2TgtH6b3wt00N6y2ltR/zRaJFKfg5BeR86Ip8s
         CiSg==
X-Gm-Message-State: AOJu0Yyom0q0QmZ/Z2cavQV3fORSkq2FSIxJJYo+A56Gu4RMwt/x7+vt
	t0+BWbH0zC/vBOGqKJ17lajDXkJW8PloSscikn7cvYRAWlzklM4vPdxVptQU
X-Gm-Gg: ASbGncvsTx/EymShZSdAPOeUIMYcblQcd3tnGfv7MCMIL4YWjdMHhb0IWptXW1aPAR8
	MaR0F7bR9T0M1IY3pfswihr8I8+3K/1utHdgx6YGl0qab/RHEHW5nn/4BDLgZqzEJRJwzLPUEA2
	2iLFEUrSbuuT8mcdy/3VbX5IG/0z639Zv29+cMRQ0DlMGywTKIu8HQRrRi+ptzljYR5LGpNDj9n
	5JM2Id86FMcwIqMI8trShnu/jc7NJksuaTTz4dRzel/B5gD3KdX9/hWzxxUy+ja4ZGYMPYwyUuT
	R3KHpMIEWgj4E6RWS+2KjPcPDGyoBo066g0szg7mnLju
X-Google-Smtp-Source: AGHT+IGrOnR+TUXcrjY/Q2/qeE3CeoJmZNuWzUGruWwO6hCs4GZYL5RWNtiGq+usvZegCb/Ijg6Gjw==
X-Received: by 2002:a17:907:9728:b0:ac3:26ff:11a0 with SMTP id a640c23a62f3a-ac3f251ac63mr423795066b.38.1742575157853;
        Fri, 21 Mar 2025 09:39:17 -0700 (PDT)
Received: from [127.0.0.2] ([217.110.80.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef8e5105sm185576066b.50.2025.03.21.09.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 09:39:17 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 21 Mar 2025 17:39:14 +0100
Subject: [PATCH] blame: fix unblamable and ignored lines in porcelain mode
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250321-514-git-blame-1-s-porcelain-output-does-not-emit-unblamable-and-ignored-markers-v1-1-44b562d9beb8@gmail.com>
X-B4-Tracking: v=1; b=H4sIADGW3WcC/x2OwQrCMBAFf0Vy9kETUxV/RTxsm21dbDclSUUo/
 Xejx4GBmc1kTsLZ3A6bSfyWLFEr2OPB9E/SkSGhsnGNa5uTs2itxygF3UQzwyJjianniUQR17K
 sBSFyhsYCnqu46k+lbmKQBsioMXHATOnFKcPT4M9D467+wqZWl8SDfP5H98e+fwG7PDqnoQAAA
 A==
X-Change-ID: 20250321-514-git-blame-1-s-porcelain-output-does-not-emit-unblamable-and-ignored-markers-4af46f02847e
To: git@vger.kernel.org
Cc: jltobler@gmail.com, Christian Couder <chriscool@tuxfamily.org>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3750; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=MDFUNZlcB1/DQnf2Bg7WulmVeGVtB66cPj6Gw0uQ5no=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGfdljXWl9BhhTTa77Y9egBAWFFa7a48DmFhf
 IUHHwrcaCwjU4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJn3ZY1AAoJED7VnySO
 Rox/AC8L/ROvv/NkPBoNPHNic0noNV/dbXXvNZFsSyBMtHR6lHkG7rbJX8/C/nq8wYsCi9aSbPn
 14IHB75Y5ag+kB6t9HjatjJiNhtT1MTPLfwI9kYCV71BXamhpe6QEbeJKDzV+OmmQ8aUmppvuMS
 VooAxfZhZhIGLa8Prj7qg8ZU1Cvuqv11VBgqW0tJ4QK2k+maql5VFQaqdl8K34p3IbHm/C2YO/C
 fKRBbOr+A3dHVxwky9w4xBJXAlY7MiIT93khPeQFVpv5YGXSQOCS9AYWHQxrbJrRxARRe9HEITK
 /LGRzJAhBvNHdY3MPNx3IjJmuRJnWNAGtcQ+OQxH6OGcxkDttzDwMndOUSpFrlq0mlcdYyAF+NH
 ljS1yQinhlENbHHrfTdnBD2mDZq3fvg0Sezaqo9Z3kj7bEWE+s6P6PimNHt+18Qw3qghgXnlCiL
 1LzZjdLi5r4CT5T8uk8ro3Pu9MAlaOYD19P7vJcM92iO3ptpOiG2YOWZ9X1BUgWgEhUmmuJtbx4
 aU=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The 'git-blame(1)' command allows users to ignore specific revisions via
the '--ignore-rev <rev>' and '--ignore-revs-file <file>' flags. These
flags are often combined with the 'blame.markIgnoredLines' and
'blame.markUnblamableLines' config options. These config options prefix
ignored and unblamable lines with a '?' and '*', respectively.

However, this option was never extended to the porcelain mode of
'git-blame(1)'. Since the documentation does not indicate this
exclusion, it is a bug.

Fix this by ensuring porcelain mode also prints the markers and add
tests to verify the behavior.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/blame.c              | 10 ++++++++++
 t/t8013-blame-ignore-revs.sh | 30 ++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

Karthik Nayak (1):
      blame: fix unblamable and ignored lines in porcelain mode



base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
change-id: 20250321-514-git-blame-1-s-porcelain-output-does-not-emit-unblamable-and-ignored-markers-4af46f02847e

Thanks
- Karthik
---

---
 builtin/blame.c              | 10 ++++++++++
 t/t8013-blame-ignore-revs.sh | 30 ++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/builtin/blame.c b/builtin/blame.c
index c470654c7e..9a8d7ce7af 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -360,6 +360,11 @@ static void emit_porcelain(struct blame_scoreboard *sb, struct blame_entry *ent,
 	struct blame_origin *suspect = ent->suspect;
 	char hex[GIT_MAX_HEXSZ + 1];
 
+	if (mark_unblamable_lines && ent->unblamable)
+		putchar('*');
+	if (mark_ignored_lines && ent->ignored)
+		putchar('?');
+
 	oid_to_hex_r(hex, &suspect->commit->object.oid);
 	printf("%s %d %d %d\n",
 	       hex,
@@ -372,6 +377,11 @@ static void emit_porcelain(struct blame_scoreboard *sb, struct blame_entry *ent,
 	for (cnt = 0; cnt < ent->num_lines; cnt++) {
 		char ch;
 		if (cnt) {
+			if (mark_unblamable_lines && ent->unblamable)
+				putchar('*');
+			if (mark_ignored_lines && ent->ignored)
+				putchar('?');
+
 			printf("%s %d %d\n", hex,
 			       ent->s_lno + 1 + cnt,
 			       ent->lno + 1 + cnt);
diff --git a/t/t8013-blame-ignore-revs.sh b/t/t8013-blame-ignore-revs.sh
index 370b768149..2722eb4598 100755
--- a/t/t8013-blame-ignore-revs.sh
+++ b/t/t8013-blame-ignore-revs.sh
@@ -158,6 +158,16 @@ test_expect_success mark_unblamable_lines '
 	test_cmp expect actual
 '
 
+test_expect_success 'mark_unblamable_lines porcelain' '
+	sha=$(git rev-parse Y) &&
+
+	git -c blame.markUnblamableLines=false blame -p --ignore-rev Y file >blame_raw &&
+	sed "s/^${sha}/*${sha}/g" blame_raw >expect &&
+
+	git -c blame.markUnblamableLines=true blame -p --ignore-rev Y file >actual &&
+	test_cmp expect actual
+'
+
 # Commit Z will touch the first two lines.  Y touched all four.
 # 	A--B--X--Y--Z
 # The blame output when ignoring Z should be:
@@ -191,6 +201,26 @@ test_expect_success mark_ignored_lines '
 	! test_cmp expect actual
 '
 
+test_expect_success 'mark_ignored_lines porcelain' '
+	sha=$(git rev-parse Y) &&
+
+	git -c blame.markIgnoredLines=true blame -p --ignore-rev Z file | grep $sha >blame_raw &&
+
+	echo "?" >expect &&
+
+	sed -n "1p" blame_raw | cut -c1 >actual &&
+	test_cmp expect actual &&
+
+	sed -n "2p" blame_raw | cut -c1 >actual &&
+	test_cmp expect actual &&
+
+	sed -n "3p" blame_raw | cut -c1 >actual &&
+	! test_cmp expect actual &&
+
+	sed -n "4p" blame_raw | cut -c1 >actual &&
+	! test_cmp expect actual
+'
+
 # For ignored revs that added 'unblamable' lines and more recent commits changed
 # the blamable lines, mark the unblamable lines with a
 # '*'



