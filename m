Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A554F13EFE9
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 14:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709043606; cv=none; b=tAIIQSCWC6WxKWBDK1f1jCcSwx01mU8yrSn+LeWLCuTgkpcqZsWPfstQzPMDx0kQUtXvHmfkE8Y6PNHaTaqeyOYneCmNtTktYP2YouA7h8DQlvmv2EcS0anlpSMiicv4LLXgRDIynEZ1HcWWELPDDJtG3CCjPjLSCnOixBuNDeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709043606; c=relaxed/simple;
	bh=WQP4SVmnPYY1pNODPkAQmPZ+70EERLfPesotpQgk8xk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a6/Hsfq64vyOHUodAqUvFweUvmU7p9BUHp6EXOVy0AzOtQ74LRhQzppKQb9QlJCy4hJnQSlFmND27u4MAFpo/V32GnXVoDfa0n8WJ9ZzvcCUQhkkzObC2/ldrDr/aybd/aujS/o0iw5uBKmNOhqan6myzinpKJuk5TDcy673/0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lwgt9kTO; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lwgt9kTO"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a3e7f7b3d95so495400066b.3
        for <git@vger.kernel.org>; Tue, 27 Feb 2024 06:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709043603; x=1709648403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k3ZVwX/Tnt0iQUJkcUBRAuTTatfyAkULK9qOPPp02T4=;
        b=Lwgt9kTONIs3+TVQ/IMh5i5/SKeQQ1Kt+NUoVJ9CMTdo6/ci/S+yWs6TgoEQG5eOWH
         iqZz2xis25GdcFyn+k9UKAiLQWo8hBUsiVFFUcicyfIk92+FbzTUwYkN19DghH6yVkQd
         FyFPegk+Kr1jq3C58vF+r1iVKNFvo8psFIt46W5rR78eB59ZnsRs3/etaZZSA4lLkodI
         PXf/4/O4oUzHEqvsNGLXgCxR+aRGi3Nd9o7eCr1NnWdE8DI3DSIh3uYtvVEcSZEng1iI
         8MYqX4z2hwmdXNnroCbbAOo70LiuhfEMiNN1Lw4k79rg7/Gk+6aIalEZLBGN5V54Shat
         aCgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709043603; x=1709648403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k3ZVwX/Tnt0iQUJkcUBRAuTTatfyAkULK9qOPPp02T4=;
        b=gG3wCudaRfQm94wPreHjzz8sn6lBW/2GqA5FlIJ55zO4r4/NaIw/x3704V39ikcDAf
         Uy76RuqAIWrsLQfHRdDHUJK1uaeQIZthom547psZvBEGtYkShBXK/sniykNQmZoNJdM7
         MkDJKyCeq9J6hL5IOEzf5yk6Q/SIbcBQ6rDMQShZXiO1MkiR3I82jQFAxwmv39qBOb6K
         i/vQjngAL6JeWMzZOshAbEmaN9tOfDsnQUw6/fh2cE9VzbCfe9bV8Uhe4hobjBJiv90G
         EO71/REAzY2A9LKict3PUUIuxn55ZRN88GvUCvnVp5mHprren6MR3jmfDAufmCfQxZrY
         l2Ng==
X-Gm-Message-State: AOJu0YwWP1KFJ6diwR/Z+y09/8fn1ihQCAbcmAWxrOWv2yRjA7VNTB0I
	bQOSsHc5+99MUMkOV76sbhxl1DaBLyP7nG7dDAmDpDlgFvDMiCGN
X-Google-Smtp-Source: AGHT+IHYo0KjthbxQFej8dtzn6NsKi5IOhJz0dWJw7WunZVTeVSllEAu24GTUVod4+e2swwYSjbsVg==
X-Received: by 2002:a17:906:3659:b0:a3e:da6:85f8 with SMTP id r25-20020a170906365900b00a3e0da685f8mr6592791ejb.30.1709043603166;
        Tue, 27 Feb 2024 06:20:03 -0800 (PST)
Received: from host-sergy.. ([154.72.153.222])
        by smtp.gmail.com with ESMTPSA id s24-20020a170906bc5800b00a3efa4e033asm805915ejv.151.2024.02.27.06.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 06:20:02 -0800 (PST)
From: Sergius Nyah <sergiusnyah@gmail.com>
X-Google-Original-From: Sergius Nyah <74214119+Sergius-Nyah@users.noreply.github.com>
To: christian.couder@gmail.com,
	pk@pks.im
Cc: git@vger.kernel.org,
	Sergius Justus Chesami Nyah <74214119+Sergius-Nyah@users.noreply.github.com>
Subject: [PATCH 2/2] Subject:[GSOC] [RFC PATCH 2/2] Add test for JavaScript function detection in Git diffs
Date: Tue, 27 Feb 2024 15:19:47 +0100
Message-ID: <20240227141947.71447-3-74214119+Sergius-Nyah@users.noreply.github.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240227141947.71447-1-74214119+Sergius-Nyah@users.noreply.github.com>
References: <CANAnif-OganZLi0Cu_uq=nveC+u5n14c=o_DQHT-wFOqQ9Vs0Q@mail.gmail.com>
 <20240227141947.71447-1-74214119+Sergius-Nyah@users.noreply.github.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sergius Justus Chesami Nyah <74214119+Sergius-Nyah@users.noreply.github.com>

This commit introduces a new test case in t4018-diff-funcname.sh to verify the enhanced JavaScript function detection in Git diffs. The test creates a JavaScript file with function declarations and expressions, modifies them, and then checks the output of git diff to ensure that the changes are correctly identified. This test validates the changes made to userdiff.c for improved JavaScript function detection.
---
 t/t4018-diff-funcname.sh | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index e026fac1f4..e88e63bd1f 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -11,7 +11,7 @@ test_expect_success 'setup' '
 	# a non-trivial custom pattern
 	git config diff.custom1.funcname "!static
 !String
-[^ 	].*s.*" &&
+[^ 	].*s.*" && 
 
 	# a custom pattern which matches to end of line
 	git config diff.custom2.funcname "......Beer\$" &&
@@ -119,4 +119,25 @@ do
 	"
 done
 
-test_done
+test_expect_success 'identify builtin patterns in Javascript' '
+    # setup
+    echo "function myFunction() { return true; }" > test.js &&
+    echo "var myVar = function() { return false; }" >> test.js &&
+    git add test.js &&
+    git commit -m "add test.js" &&
+
+    # modify the file
+    echo "function myFunction() { return false; }" > test.js &&
+    echo "var myVar = function() { return true; }" >> test.js &&
+
+    # command under test
+    git diff >output &&
+
+    # check results
+    test_i18ngrep "function myFunction() { return true; }" output &&
+    test_i18ngrep "function myFunction() { return false; }" output &&
+    test_i18ngrep "var myVar = function() { return false; }" output &&
+    test_i18ngrep "var myVar = function() { return true; }" output
+'
+
+test_done 
\ No newline at end of file
-- 
2.43.2

