Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA97448D02
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 11:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784115243; cv=none; b=iDrXBssEUBCZbjAPa/fG3IshZWa0RUEXzRNuMh+aHmPhj5JLQxI63prTT4JtS5KrRtDFGftRvJPYIUPLbHc4Jw+tD/oIJ9qjfNdmxxFQCAhhP5W7L/8LbwXMYgcIY6r6s/5pRugIED363LC1dCInCHzhTI6IqMMDdCsNM2+RJNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784115243; c=relaxed/simple;
	bh=BnHJlAHTOx1xUU7GU5HUyZjYgFRJCjfkCm8r3fU7FbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cQq1lhzQfid1aZrw9EiQJLV7lWfmwKCGeWU6rNjszOPpFKrqAp635tD2e+cOvYpQT+lGIy/Zu9HSLSZZc9X5JuTlkBVWqrIjoMbEWEtSxg84MxGvjsQIyFmAicLTFvcE2AGokCFEmoG82xAuDJTL1soqtfn20zese2gWXN5k+dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sRe3D6PH; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sRe3D6PH"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cedda2ce6fso21345915ad.1
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 04:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784115239; x=1784720039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=09Fqbwpye3yYrKjhOLQkW21UVDxSCV4Qi+CfKtS/zg0=;
        b=sRe3D6PHOiq2DHG0dYQMbPZ5vVpYtVlP6OIviYl0EA9ZWH11tq+z3QLryT41isvm73
         65U1oRY8vCTjeMD0CPhEtSZDqeb20UqZcE4knf7pgtLe6NlYo/0932Q5q2kqVN2OM0eS
         hyvWBwsmwLwT1QEg9czhKWytpX1FmqOHGggX9YnhOfsmTs3jGTYLiAo8oUWBfT0PQyRJ
         c8uMCyKiQwha1tBDtbW4LWL0J+Cbbjr6OfW/5H/fS9nYd2LR0Q4CHibZoRQ6sbTWzO0c
         C1EwzUM4obR3/HHEXKCEOrRmegaMsViiaW5bIBNE4NezP/kuXE7QJmPHOXiTb4zH8yvX
         9/+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784115239; x=1784720039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=09Fqbwpye3yYrKjhOLQkW21UVDxSCV4Qi+CfKtS/zg0=;
        b=I1+ZH7NgHBbP0AeNwYBt0YeoSiw2GRH6mogkac9nLXqOGVwNn4IQgocJOiLGXzqruc
         awMgRAkq7U9A6Nh9ni6rjGdtAmihJeeo9wP4XL/8y858RrNsIEpYu0ISBHBfiDxZxgqj
         apwwlUw8vNzY2a1aMa3ez0IQ+rK0Q2HqbyEXUvpVsruS4oW2tASB4JiXs1Ho/nHIxbFx
         UD62BwU6gik8GH1QFLzlNuutVlK3CjlFjr2aR7XSlM97MilHnPgMEtN3bT0KQtWPHDGR
         CBvM1KmwRtJkxxor+oAkLFAOJGE2eT0mZw6otfOBdVaVAyspXjficUaEH6bzXL2o0XmT
         ptDw==
X-Gm-Message-State: AOJu0YwmoKDRNcaQYz3uVH74+oq+7aTPZ2vcgMHjoEPpuCRof49AhVIg
	5dMQLw3K+N9Qu2J4Zr5unbhwh+VxewoztcKKWeLMotJXdvswqAGW3/Jen9OCWJSy
X-Gm-Gg: AfdE7cmqd1l+2mz73hrdnXIlklWnfKk9dybrrkbCWyorMvJnT64RtH6uLKZi5pspLvB
	vA5vpzAEABl5XIOb1n17KlxMDKWkDMExh9U+ehloFQaJJgAjOTo3sH7XrcXZw37wwD/yEirB32z
	DljM6NT8yL2lGWz/2EqIm/8E5T9K0F3Ekd0nfPIfiWgAICMqJrSym6FmxCE+x1nQgyOvd8e5e8I
	DUDsa13/AZjKaDl0+GK41Fm0j38yzLnYzdW22WS7vI9XF9sFk8Cy6rkIaxACuiiePOEpX3SL5fP
	tq30O0w7On4Nv1f5bZnX5s3AIHtCjPkpYad0N9D9liMaz/MaxIof0oBvSn9pnNdbTmUOQcLcsyB
	2NUM+m4ELBpRciOCzu3dcL8LXznu3DHntrRFBwh8xnb54nreqa0+p2Uixg5urtUuFc6Tm7LKD89
	g9HroqiEjKZBsTSVtvbXkUkhd792j28TiFOb+qoR8K+1CHtCh1
X-Received: by 2002:a05:6a20:cf85:b0:3bf:9fc0:f6c2 with SMTP id adf61e73a8af0-3c356f753a9mr6888308637.11.1784115238552;
        Wed, 15 Jul 2026 04:33:58 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c54:64e6:6127:854e:5be6:3ddb])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13cd426ad8csm656741c88.3.2026.07.15.04.33.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 15 Jul 2026 04:33:58 -0700 (PDT)
From: Shlok Kulshreshtha <diy2903@gmail.com>
To: git@vger.kernel.org
Cc: Shlok Kulshreshtha <diy2903@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] t7614: avoid hiding git's exit code in a pipe
Date: Wed, 15 Jul 2026 17:03:44 +0530
Message-ID: <20260715113344.3490-1-diy2903@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The exit code of the upstream command in a pipe is ignored, so in

	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual

a crash of "git cat-file" would go unnoticed: the exit code of the
pipeline is that of "sed", which happily succeeds on empty input. The
test would thus pass even though "git cat-file" failed.

Write the output of "git cat-file" to a file first and run "sed" on
that file, so that the exit codes of both commands are checked by the
&&-chain.

Signed-off-by: Shlok Kulshreshtha <diy2903@gmail.com>
---
This is a microproject ("Avoid suppressing git's exit code in test
scripts"), applying the same fix as c6f44e1da5 (t9813: avoid using
pipes) to another script. A search of the list did not turn up anyone
working on t7614; please let me know if it is already taken.

 t/t7614-merge-signoff.sh | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/t/t7614-merge-signoff.sh b/t/t7614-merge-signoff.sh
index fee258d4f0..e58bf07b7a 100755
--- a/t/t7614-merge-signoff.sh
+++ b/t/t7614-merge-signoff.sh
@@ -45,7 +45,8 @@ test_expect_success 'git merge --signoff adds a sign-off line' '
 	test_commit main-branch-2 file2 2 &&
 	git checkout other-branch &&
 	git merge main --signoff --no-edit &&
-	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
+	git cat-file commit HEAD >commit &&
+	sed -e "1,/^\$/d" commit >actual &&
 	test_cmp expected-signed actual
 '
 
@@ -55,7 +56,8 @@ test_expect_success 'git merge does not add a sign-off line' '
 	test_commit main-branch-3 file3 3 &&
 	git checkout other-branch &&
 	git merge main --no-edit &&
-	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
+	git cat-file commit HEAD >commit &&
+	sed -e "1,/^\$/d" commit >actual &&
 	test_cmp expected-unsigned actual
 '
 
@@ -65,7 +67,8 @@ test_expect_success 'git merge --no-signoff flag cancels --signoff flag' '
 	test_commit main-branch-4 file4 4 &&
 	git checkout other-branch &&
 	git merge main --no-edit --signoff --no-signoff &&
-	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
+	git cat-file commit HEAD >commit &&
+	sed -e "1,/^\$/d" commit >actual &&
 	test_cmp expected-unsigned actual
 '
 
-- 
2.52.0

