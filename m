Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A221E5B84
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 17:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742404834; cv=none; b=lQMGyYKlJhyFm4hHifgZQPldnEOe86y4MPaFpKHXcmZdtSjgecsACRjvvE9s1ZsBxnQTDbXAEwPPtfPmeS2cs9LA/4b36CW8KNtcZZ/J0HBIdIvYuziH/3abU9QsoFREKpfnDHnCdoVzKMWN7QIQKzxSwoaoiLuwkHiLm0YwA7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742404834; c=relaxed/simple;
	bh=8dhV5nvcBm405GBe6kcUc4v3lnx4AjFgVTCBm/MIFpE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jTSHy74bLQ1cAsuBGAraaXI8SYGcHTNfoNcPnCsNK8/DJgjX2U/s4wu+k9+LfJ+3PyBONMBZr8brpoGHBEyolXkWJhqDhKRnnPWXikEEyCiPcI2NopIymjhxuSCXa9PhfJW0go9xNpgL3Bh9ZR8wlWMJMQbKbne7jDCk3YHRbsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j47TPP80; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j47TPP80"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-225b5448519so140121475ad.0
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 10:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742404830; x=1743009630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QHC8ustxVwuIaQBCVdDr9llLsraw+z8ocCQE1Cm2Aj4=;
        b=j47TPP80Po3WqVDGpIjv0/o+9fEANWDIKp8f/ZeDXXGoSAjIeYN0S9Rv5/wwmlGB53
         xTWySvAXAjaC6+nFgG6I+JN2YSdTkaEkwogeDwCr2T19ILfYbOGDUXP+gXZp22M6EItH
         7X4x74VmlK6WpitCATn5qKFuo7BFXFjmSUVl01ImJDMJo03vhHpzgHyd1NrmGkYlMOWF
         pqeIWZVX889PxUVeExMF1S7TopfZGd9l12FPmhWkpCPSfte5y0mt9/IBk+I5fr8r/jPq
         OWTG+kSAvnQqD21C0r6muVvf43Ujy39g7dmqfNuVLlOhiq/P4WYWcOLUaKMSM9J/NlQS
         Efcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742404830; x=1743009630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QHC8ustxVwuIaQBCVdDr9llLsraw+z8ocCQE1Cm2Aj4=;
        b=jeX5Wwqu0k8wbQYQ6dS1gbVAxViSyx9D0do0fx9nbtbpHwGOueBbGrcaoJji7IP0+V
         Bqw3Vck03yVU3ar4HqDTOmL+9sS5Rio6/DDrmBAg94kAr5ExkyRuEFaPEheIS4ldo1Vz
         XZj/EKti90bc5OjHqpFkNkZmZE4CjFSy0UQ7BD3VwmfKmZrRqbvOOFjGwqbxBJKtKprH
         Zrhw7Uvsgp0qoBhLN3h8FT3tnlG0ewdOlQ7Mre+57198RnUxfgsjNzCHmVfMRv/we1xP
         m5BFzuHmxIp3Rg4dxt2g9vlnXHlelZ9kIt/AaGY8GuPC4tJO2/UWxqz1fzce2RcfQVi1
         k2zw==
X-Gm-Message-State: AOJu0Yyio0aUBKuIWADYloG76sqDbFymbEVqQl4FueBZGXaOdQOtr1Ca
	zF9wxMV2fpdplk5NiwsuXJhIpVE6MVrcZZT6pvjUDtD1lInLkiQzWc6Tlw==
X-Gm-Gg: ASbGncukMv903qsxzO7ozbW213nhYcFDKhe3yfMuMEhq+vq/dO4DJ598LRvlc8bl/QP
	crDZWHr+GVLIUVn+0q21IfLlGe24ndPr9fyfngnZPfjx/DbGx5ale0ab23zp4ZTsVDvyav2a1YS
	aXTdyWIh6zraOnRbnzwz8BrXm0L22QUdc3zpF9z2ijQNA3hjr4E56pyC1/tb2Nvfmq5EFlVpfdA
	8z5HFRJqkzCFMLDEqjBlyQm3LJ1DqSO5hIfRAmgzagpCpEImFmLkQy5JX6eNhUlsLtMFqxFjuAJ
	7rgT/gtxHc2rczegzn85xyf1ceRy8JAeP9BDvQOzAG0yJHG+Fb8BZsIKdkPtZpiz1bZV/2yi1Xs
	=
X-Google-Smtp-Source: AGHT+IFjKgtfqL/p3zi/ErIaHapC2c/4mX8z8fsmPSfidyGctwvgnPmNyLRRzF3Oud1PLJxp9cFbCw==
X-Received: by 2002:a17:902:e846:b0:223:37ec:63d3 with SMTP id d9443c01a7336-22649a2f067mr45086365ad.18.1742404829945;
        Wed, 19 Mar 2025 10:20:29 -0700 (PDT)
Received: from localhost.localdomain ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd3c59sm117240305ad.218.2025.03.19.10.20.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 19 Mar 2025 10:20:29 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC PATCH 2/2] t4018: add tests for gitconfig in userdiff
Date: Wed, 19 Mar 2025 14:20:16 -0300
Message-Id: <20250319172016.2115-3-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250319172016.2115-1-lucasseikioshiro@gmail.com>
References: <20250319172016.2115-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add userdiff tests for gitconfig files. These files define sections and
subsections, with and without indentation.

Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 t/t4018/gitconfig-section             | 5 +++++
 t/t4018/gitconfig-section-noindent    | 5 +++++
 t/t4018/gitconfig-subsection          | 7 +++++++
 t/t4018/gitconfig-subsection-noindent | 7 +++++++
 4 files changed, 24 insertions(+)
 create mode 100644 t/t4018/gitconfig-section
 create mode 100644 t/t4018/gitconfig-section-noindent
 create mode 100644 t/t4018/gitconfig-subsection
 create mode 100644 t/t4018/gitconfig-subsection-noindent

diff --git a/t/t4018/gitconfig-section b/t/t4018/gitconfig-section
new file mode 100644
index 0000000000..866aa70b24
--- /dev/null
+++ b/t/t4018/gitconfig-section
@@ -0,0 +1,5 @@
+[RIGHT]
+        # comment
+        ; comment
+        name = value
+        ChangeMe
\ No newline at end of file
diff --git a/t/t4018/gitconfig-section-noindent b/t/t4018/gitconfig-section-noindent
new file mode 100644
index 0000000000..75a401b24b
--- /dev/null
+++ b/t/t4018/gitconfig-section-noindent
@@ -0,0 +1,5 @@
+[RIGHT]
+# comment
+; comment
+name = value
+ChangeMe
\ No newline at end of file
diff --git a/t/t4018/gitconfig-subsection b/t/t4018/gitconfig-subsection
new file mode 100644
index 0000000000..06243db626
--- /dev/null
+++ b/t/t4018/gitconfig-subsection
@@ -0,0 +1,7 @@
+[LEFT]
+
+[LEFT "RIGHT"]
+      # comment
+      ; comment
+      name = value
+      ChangeMe
\ No newline at end of file
diff --git a/t/t4018/gitconfig-subsection-noindent b/t/t4018/gitconfig-subsection-noindent
new file mode 100644
index 0000000000..a100b81cf1
--- /dev/null
+++ b/t/t4018/gitconfig-subsection-noindent
@@ -0,0 +1,7 @@
+[LEFT]
+
+[LEFT "RIGHT"]
+# comment
+; comment
+name = value
+ChangeMe
\ No newline at end of file
-- 
2.39.5 (Apple Git-154)

