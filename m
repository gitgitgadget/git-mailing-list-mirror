Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86759625
	for <git@vger.kernel.org>; Sat,  1 Feb 2025 00:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738370768; cv=none; b=VI/VoRH+vL0UyrzvaVoVbxZtRbvJ4HIqWHxZO8fVAyOBosILYx1mkAMfpOqO5gh+clxgYXsmOrWD0WC/BABKULfSZ8Xrdh59Ne6ZCu5KHEselk9YUk13LxCXdt18KymiQb8Xuq/vE1vZSUAd9xPDPCrv+kZ7n0AJHhPenbhHsfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738370768; c=relaxed/simple;
	bh=eEl+/zgNUzw0lhNll6DDdz+MktUuzSvjYj4G+jUWU0g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=b7m93npfyPZ+uKK4ZnZ0L76UvFuXGKnXrINyKkc8h5NurKTaGlOlPcrWb5n5zxMTvBJdXtM6tbubjTazptVob8KRgmPrHx9U+8zV/Z35GeKN7gQfV2TpfqHDIUr1VLkolgSkIQZtofd4dI0A3YIw+5EEgR8xklv1Ou0EIGLuPsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=koBVAVYB; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="koBVAVYB"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2166022c5caso40935885ad.2
        for <git@vger.kernel.org>; Fri, 31 Jan 2025 16:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738370765; x=1738975565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wjWQEK6rOgZG3Hoae3/XGQJcBq4DNMC8e98+7TwTHng=;
        b=koBVAVYB+bphlBzqESbiiThc2gbBAoXIttYCYRZ4c7JGdLnbLg6za6PlQlthjzyYAR
         9nOpwywgNXRHB4j3OTp4KyYNAw8IhN7dgZjg5v4QLsrOk7ftUJ/pVoGnVY5n9kxMNBpv
         NEGZ8XKLkcI5EIE3yh75fW/gbw8pe3Jkg8J7xIh0Z1tneWH2mVxSGJbPJiVoz/jdfYOD
         4zzdh0nMco2QSfC2XWaIzK+ujxvgisZqzZ1WYAcppxo+gDeca9X2uGjgkw0Dgw+Cl/nV
         JaBkUtRORzAOmsJ+xIb8zNZhut201s3W8mAF+9zd7ZvrXt+eIbQv0XliyE42lbpAWzNH
         dgMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738370765; x=1738975565;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wjWQEK6rOgZG3Hoae3/XGQJcBq4DNMC8e98+7TwTHng=;
        b=TxWAKApR4qJsB5FYFj18zxxYgERB3zySZduGjy6c1ZKpify6+pJwBJi5M3jWChlOj4
         v9BTcOFRaIqHRbCxUS01l3IbwoZF467+YMd7BXNBoycQOAn7VSiKaRNiNzWzvNVajl75
         33pYzBKUcPladRU8hQsNJcW5i7+UGq1nq7/GBCv09+BembTjS+tw+VwGyxK9Ly/qKoYy
         V4YtDil35lNYzf4kxSkVjryltg9KoTkGY8TSBRYnC9yMmBWyFs8oMvmlyN2Nchx5IipK
         86X6A2KV3OeQ3PE9RHmDgM7nEx8jnwUB1QUUD/9YIdndtGNu51e8Epm0uju60L12GuxH
         F2/A==
X-Gm-Message-State: AOJu0Yx7W+O+b/n7pjCLgE4brWKRxCRoww0IWKqoR0/vtmU2rIRNJTxE
	BYQKLfB+zd8jvgoHXR9KK8kzkKwN1ikMysyHdK/Ts0pzo7T0MnnemKSmL4JBIvY=
X-Gm-Gg: ASbGncuilnvcWFeLh7rn/P+vZx+iftgpbnJ1gjZyouQr7xFjA0UeEJuDXAVDHBW3yC8
	v9tUNeO3MGx6ZtCFkOnIhkdEMgHnige7e4py/s4qm0WyBZwfvoVmG4E/5W7HWalKwRyk+tY+D8P
	zh9icQAuPw1EfUpU3MtppmGVSNIu6ipuIo6Ym7ZaARnbl3DUSKJ6TRJ5UxTmhDIenEmqD5nu5Fw
	xU06kHhMILcYyNfNHGwnU1hHERd2DS/dmeFw9a2z1svqnbtGPV7twPPAjuv6sUmbX/ScyK91XlA
	XTemw6ydhB0gGAotoONjs8VGAsUmjQia
X-Google-Smtp-Source: AGHT+IEQZPk2bmFbKaaK7SyRgcSm7en9RTPmbjf2c8IfMRxRWLdDIworKLL7EAhSXrEuw4076aC84w==
X-Received: by 2002:a17:903:2f8e:b0:215:b75f:a1cb with SMTP id d9443c01a7336-21dd9fa74bcmr182248645ad.9.1738370765466;
        Fri, 31 Jan 2025 16:46:05 -0800 (PST)
Received: from bl4ze-rig.iitr.ac.in ([103.37.201.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de32ee0acsm35562235ad.111.2025.01.31.16.46.04
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 16:46:05 -0800 (PST)
From: ayu-ch <ayu.chandekar@gmail.com>
To: git@vger.kernel.org
Subject: [GSOC] [Newbie] Test Script t6423 Microproject
Date: Sat,  1 Feb 2025 06:15:56 +0530
Message-ID: <20250201004556.930220-1-ayu.chandekar@gmail.com>
X-Mailer: git-send-email 2.48.GIT
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello everyone,  
I am Ayush Chandekar, a second-year undergraduate student at IIT Roorkee.  
I've been using Git ever since I started learning about development. When I  
started out, I used to solve some problems/exercises related to git. It was  
very crucial for getting better and now as I'm looking forward to start my  
contribution to open source, I find Git! I read almost all the docs on the website, blogs  
and tried to understand as much code as I can. I just want to take a moment  
to appreciate how great all the documentation is. It's honestly the best  
I've ever seen out of any org. It developed an urge of giving back to git  
after I'd spent so much time developing things. I even started a small  
project of making my own git (obviously mini version).  

Coming to the topic, I saw that we need to submit a microproject, and I  
started to find my microproject. I stumbled upon the thread which mentioned  
skip bitmap traversal for --left-right in git rev-list. I tried to  
understand the issue, which I pretty much understood why it's happening,  
but I figured I still need to discuss it with someone. This is also my  
first post/patch on the mailing list, so I would love if someone can discuss  
about that issue with me :)  

The docs also said that only one microproject should be done, and for now  
I've selected the one mentioned in them, which is Avoid suppressing git's  
exit code in test scripts. But I feel that the ones mentioned are pretty  
small. Can I still contribute more by not calling them as microprojects? I  
can do it for more files, but first I would like to have some feedback about  
my initial patch. I know there might be a lot of mistakes as this is my  
first patch. Thanks for taking out your time for going through this :)  

Best regards,  
Ayush  

Signed-off-by: ayu-ch <ayu.chandekar@gmail.com>
---
 t/t6423-merge-rename-directories.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
index 88d1cf2cde..bdd19de3aa 100755
--- a/t/t6423-merge-rename-directories.sh
+++ b/t/t6423-merge-rename-directories.sh
@@ -5071,7 +5071,7 @@ test_expect_success '12i: Directory rename causes rename-to-self' '
 		test_path_is_file source/bar &&
 		test_path_is_file source/baz &&
 
-		git ls-files | uniq >tracked &&
+		git ls-files >actual && uniq <actual >tracked &&
 		test_line_count = 3 tracked &&
 
 		git status --porcelain -uno >actual &&
@@ -5129,7 +5129,7 @@ test_expect_success '12j: Directory rename to root causes rename-to-self' '
 		test_path_is_file bar &&
 		test_path_is_file baz &&
 
-		git ls-files | uniq >tracked &&
+		git ls-files >actual && uniq <actual >tracked &&
 		test_line_count = 3 tracked &&
 
 		git status --porcelain -uno >actual &&
@@ -5187,7 +5187,7 @@ test_expect_success '12k: Directory rename with sibling causes rename-to-self' '
 		test_path_is_file dirA/bar &&
 		test_path_is_file dirA/baz &&
 
-		git ls-files | uniq >tracked &&
+		git ls-files >actual && uniq <actual >tracked &&
 		test_line_count = 3 tracked &&
 
 		git status --porcelain -uno >actual &&
-- 
2.48.GIT

