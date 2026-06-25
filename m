Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C943D25785C
	for <git@vger.kernel.org>; Thu, 25 Jun 2026 19:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782416629; cv=none; b=D6aQvAHUpD5782iRGfd+1hv4X8BEaw/+D4hIaae1Fb0wG41PxrtfK7VB8VbkAalh/rDtg5eHMMItyiR4zAMQuK7a8ZKtox+ISMf1tfvoxOf23mHeZ0Kt/MBUcRcJSHyNbfFFJGjXKt7NLLYNGjrs5wMfSaN127MERE6nl9v4tow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782416629; c=relaxed/simple;
	bh=LVxFjyBwAWCHt3r4dT0PoLUMBFU9KecLOVZyUVud7fo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ljCtlRib3LxMCtynhTEY1otWfo3JMq0DYXcn/YWrk7vXeM3LCZXLVxbhnhXv+oIgC82Fq4dlwTRDKKjTnErG1IYXsjLMmG9PVBA8DTegtFm583NBREGlJDPfBTiudzj/wfS6brSkZXapl5/nwKN6ulERbvqcBPPGU/3XdCjNMRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jZnpAh3g; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZnpAh3g"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2c6b3f71648so3032235ad.2
        for <git@vger.kernel.org>; Thu, 25 Jun 2026 12:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782416627; x=1783021427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FEZglQG0jwFuAAVAf8iRnupfNLunTYcRJMx7Zt2zCzA=;
        b=jZnpAh3gAXyjo4OtNZr6if6tWkr1o4FCNOwciZulj6bIbSlCo0zT/8R9mb9LcvQzph
         zdl7l0dRa4/JK0p5la+pgcAt6bInvsUMK0BfQs60CjEP/tfZL0htrNBYkWEtGmTbh+Mh
         +EVB6FoA62yN98aRUXFTfaKbK80Db9XfG6vS8aYZyS8nk905LgiOrDeKK2xlG+0OmVHG
         eYn01ulAGstF04I9j9tlA0ZLBZPmiSeejd3os0r46UE5Hfx6vNY2kE9mfMjlepCHk1T1
         xc/0ziiFf2EbJLU4qzJLms/VKGrw5zbaEuSbe00WNxHGs+d+/W2JgPeOH/7QG1/Obn0M
         z34w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782416627; x=1783021427;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FEZglQG0jwFuAAVAf8iRnupfNLunTYcRJMx7Zt2zCzA=;
        b=EteeSuEv/D2kFyfYnlBTOMQ00hMSieDxxk9UrFJ4D8YILyz58H7R4q0FxZJkGmrE+g
         YoNJ24ynZ1kc4B2IObN4b70X4p/XeyRzzSBjLT/4BrWI6izIUiA4kL8uzv83FX2v7Cf0
         KfUbydWvsKkZtpFg7/ZGY0oD3rC/B0HsVgW43fjP6FPmHDKsfr4RHjq03OwrjlID4ouq
         Cmkb9ZG6bqyZiX5kxtr7YmhOHuPNOHx/bl2yWOMKa8rnp4HkdajxNR11bhnwUC7Gb3X7
         x2AyPktadfhxftj1Pg/GsC8omQrs800ZgfIy40GEiAcrFEjRQhhYAJo6ViC4I+oEOV+N
         ZPZw==
X-Gm-Message-State: AOJu0Yz8yJTJOOpGQqK77FG62hSfeqiAwJXqeg4eyxKOHkOQvnSck4Y8
	St2+5i5bMQ8vAO3I2hNP9xkQ+wMBOKxoUsS7EEaqVS2gHz9ycUys1LHFLO4gXQH9mfY=
X-Gm-Gg: AfdE7ckvlY63sAOc+XfGFSXz/rvjOOWCgGFSmGcUeZsc+LQp085B5cAMmgppjJp8m48
	G0kOWJg/Ft3EGp496c143EMEGRRMf5EA2Or0/yOwg5se16suZz3wVQ45PyY6jClN0WuRlzTva3D
	uKZV65KGowg7TnxG4nf9MpVHwd+kKsiQRdhKV7iXPx2PkYWemEHSgRemoOpwSUiHKi74TEsFbme
	t/uQwDaclVGh1nBFs5EVTb0mi/HDG8BDbvScgfuLwLV6RoPk8XV0p+3cHXfArleCMP2jfT84URu
	RjAtcqejk59xKYy/sjrT3q4DEkgKoReiXiM+7r7245g9iXG3uopXC6kzO0iNtHr/C/sUWG4cCUE
	3r2xVdwAEGfAQCvjkVDMxB7f2tHP1Dkov+HXMt6qCAp0NugqsCAW3LUOHFwQTZMYoeHYl95r8Qe
	D9B953bvbRbyTK3hn6e2v+dep+DfZMpohkK0CCjzItfrgaAYerIg8=
X-Received: by 2002:a17:902:ec91:b0:2c7:f7e6:99f8 with SMTP id d9443c01a7336-2c7fc9d5f54mr38344535ad.9.1782416627004;
        Thu, 25 Jun 2026 12:43:47 -0700 (PDT)
Received: from i7-8700k (c-24-21-189-103.hsd1.wa.comcast.net. [24.21.189.103])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7f5ae4c55sm26895675ad.19.2026.06.25.12.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 12:43:46 -0700 (PDT)
From: Grayson Tinker <graysontinker@gmail.com>
To: git@vger.kernel.org
Cc: Grayson Tinker <graysontinker@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Fabian Stelzer <fs@gigacodes.de>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
Subject: [PATCH] gpg-interface: still print ssh signatures when allowed signers file is not set
Date: Thu, 25 Jun 2026 12:43:11 -0700
Message-ID: <20260625194330.3711-1-graysontinker@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"show-signature" errors when the allowed signers file is not configured,
which means that the user can't see the key that the ref was signed with
without creating and configuring the file. Change the logic so that the file
is only used when configured, and so the signature status is always displayed.

Example of previous output:
```
error: gpg.ssh.allowedSignersFile needs to be configured and exist for ssh signature verification
commit b437db5ddc38ebda223bbae2087eee90a7b1c6e2 (HEAD -> master)
No signature
Author: Grayson Tinker <graysontinker@gmail.com>
```

Example of new output:
```
commit b437db5ddc38ebda223bbae2087eee90a7b1c6e2 (HEAD -> master)
hint: Configure gpg.ssh.allowedSignersFile for automatic principal matching
Good "git" signature with ED25519-SK key SHA256:yTU4KFs/g6MY7biDSlVStB63Gi1rCKg7dOFDXbe0yuw
Author: Grayson Tinker <graysontinker@gmail.com>
```

Signed-off-by: Grayson Tinker <graysontinker@gmail.com>
---
 gpg-interface.c | 42 +++++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index dafd5371fa..ef3e1a0aa0 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -1,6 +1,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "git-compat-util.h"
+#include "advice.h"
 #include "commit.h"
 #include "config.h"
 #include "date.h"
@@ -480,11 +481,6 @@ static int verify_ssh_signed_buffer(struct signature_check *sigc,
 		.local = 1,
 	};
 
-	if (!ssh_allowed_signers) {
-		error(_("gpg.ssh.allowedSignersFile needs to be configured and exist for ssh signature verification"));
-		return -1;
-	}
-
 	buffer_file = mks_tempfile_t(".git_vtag_tmpXXXXXX");
 	if (!buffer_file)
 		return error_errno(_("could not create temporary file"));
@@ -500,22 +496,26 @@ static int verify_ssh_signed_buffer(struct signature_check *sigc,
 		strbuf_addf(&verify_time, "-Overify-time=%s",
 			show_date(sigc->payload_timestamp, 0, verify_date_mode));
 
-	/* Find the principal from the signers */
-	strvec_pushl(&ssh_keygen.args, fmt->program,
-		     "-Y", "find-principals",
-		     "-f", ssh_allowed_signers,
-		     "-s", buffer_file->filename.buf,
-		     verify_time.buf,
-		     NULL);
-	ret = pipe_command(&ssh_keygen, NULL, 0, &ssh_principals_out, 0,
-			   &ssh_principals_err, 0);
-	if (ret && strstr(ssh_principals_err.buf, "usage:")) {
-		error(_("ssh-keygen -Y find-principals/verify is needed for ssh signature verification (available in openssh version 8.2p1+)"));
-		goto out;
+	if (ssh_allowed_signers) {
+		/* Find the principal from the signers */
+		strvec_pushl(&ssh_keygen.args, fmt->program,
+				"-Y", "find-principals",
+				"-f", ssh_allowed_signers,
+				"-s", buffer_file->filename.buf,
+				verify_time.buf,
+				NULL);
+		ret = pipe_command(&ssh_keygen, NULL, 0, &ssh_principals_out, 0,
+				&ssh_principals_err, 0);
+		if (ret && strstr(ssh_principals_err.buf, "usage:")) {
+			error(_("ssh-keygen -Y find-principals/verify is needed for ssh signature verification (available in openssh version 8.2p1+)"));
+			goto out;
+		}
 	}
-	if (ret || !ssh_principals_out.len) {
+
+	if (!ssh_allowed_signers || ret || !ssh_principals_out.len) {
 		/*
-		 * We did not find a matching principal in the allowedSigners
+		 * We did not find a matching principal in the allowedSigners,
+		 * or no allowedSigners file was configured
 		 * Check without validation
 		 */
 		child_process_init(&ssh_keygen);
@@ -528,6 +528,10 @@ static int verify_ssh_signed_buffer(struct signature_check *sigc,
 		pipe_command(&ssh_keygen, sigc->payload, sigc->payload_len,
 				   &ssh_keygen_out, 0, &ssh_keygen_err, 0);
 
+		if (!ssh_allowed_signers) {
+			advise(_("Configure gpg.ssh.allowedSignersFile for automatic principal matching\n"));
+		}
+
 		/*
 		 * Fail on unknown keys
 		 * we still call check-novalidate to display the signature info
-- 
2.54.0

