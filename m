Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78441E491
	for <git@vger.kernel.org>; Tue, 14 May 2024 21:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715721334; cv=none; b=Z+kUFQe4HqehUSe4O2tJ0cMJ1QHY5r7a9pHfHlMW2G1leNZ4f7dZ++z7m5MGCzlBK+pnYAkMg3NTfdFbLAbxfTjnzbU8OsTTOvJsJvT2kJm3X+zO8kjYVhbeqCC5SRzdjHU3gjpsZ6yS2FLMS9pMfq4zycLBe2kQubvj6S//Ahw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715721334; c=relaxed/simple;
	bh=vcfESte53NibxVAqyCi0QeXfX6iRnzeIeYsAHL9zOEA=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=M9HBJN1duc3Mv4IvJuY57CAsTammuH8/yRqbOroFQjp+6VQNIKTdqXUbsDYO8rU6IsthuAGfrpLMUpb+2VnMEbFAVyJCAkP6em3t+NEbTIxLD7OwgD18iwWfMzE8fUyrg5I4Qtm/0KmVrhXmKCTOJ7zkuOg25bLK4tcEX3auEL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M27sOnqo; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M27sOnqo"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-350513d2c6aso3391552f8f.2
        for <git@vger.kernel.org>; Tue, 14 May 2024 14:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715721330; x=1716326130; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XMLFt6i6xQPwGwAmXXE3XsaSnmCdbXxClxYYxBGTmB8=;
        b=M27sOnqoAHy01qf4oHIdZFzXwOc+I6Wqi9uPkgDhWrqCW4Xpi6eAnfAPswD8OBytbI
         z+EJmdYbB6VLA/Kite5Gi3Tz5MkY0zgPZA3NnoGoOzEV9UAgsGSkYJwvW2UXv+f4n+Ka
         lYGr3Z6h+YVe+ftfMemMfqkdYSx/teo0X0aP0LQ3uujCaM/laZrI2qHO24cwvrDNPW1f
         5mR9cAiADc1GQWStAwZoKpDX57EUVP0xzsziM3KWz2GTEtS96DoBRS1AeIuW/xxkU3jS
         y40EjCO8OK80q0aCTjuhNCimtPRBCj32KcwUXNs6Myx8hZoJRY0dtC2vWaOXEKbu0Lfa
         5+Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715721330; x=1716326130;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XMLFt6i6xQPwGwAmXXE3XsaSnmCdbXxClxYYxBGTmB8=;
        b=E6bU0HRbHnXOCuCJqVLmfg5MFq/2ACuejP6RrCuRyBKM9FK7q5lOENGKfTbG8Ui429
         hF7L5sNLjc+zqhM32i3VSY/SJAMvVmu5MPkiWcAEbn7WHYNULwZrIGa8oKynZSRMb7fn
         ySoLlDKTImqojyRxtLRUZAtdzCuYa/2d/0sRqMfGh22/GStmUWqJ0wqmhsMs7ayrB6d5
         BZ4BqbcV71u+yvKNwXNKAQTPI8Jgyu/+YX2NhHQcnmmWPUOwqGD79S2It8BJuDgGlihA
         NuOgw3GGfR0stqCKMi+56kxk8NSAvOHPWoclXr+kToWMP+VOQXB3oCmgSikWVFuo2Pln
         5zAg==
X-Gm-Message-State: AOJu0YyDkEnQHhbBeQxNuKj2aeKMd5rFnAqcjwPfNK25o2JIdhcQZquH
	Tj+/d1hiIkWK2J+5Z2sK01K1TPRHpIE4SICGcbPHBCqUzqx8oyKjgZBCLQ==
X-Google-Smtp-Source: AGHT+IEtHefBdCzHZZlaFyXHRUMH5wmqJMRPFz1iXJn0eJoORf9RqZOV1dEOfemyWwTpjVctDITBmw==
X-Received: by 2002:a5d:6981:0:b0:34d:9d2c:8eaa with SMTP id ffacd0b85a97d-3504aa62ceamr9803214f8f.67.1715721329025;
        Tue, 14 May 2024 14:15:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b896b00sm14519228f8f.45.2024.05.14.14.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 14:15:28 -0700 (PDT)
Message-Id: <pull.1719.git.git.1715721327429.gitgitgadget@gmail.com>
From: "Tom Scogland via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 14 May 2024 21:15:26 +0000
Subject: [PATCH] archive: make --add-virtual-file honor --prefix
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Tom Scogland <scogland1@llnl.gov>,
    Tom Scogland <scogland1@llnl.gov>

From: Tom Scogland <scogland1@llnl.gov>

The documentation for archive states:

  The path of the file in the archive is built by concatenating the
  value of the last `--prefix` moption (if any) before this
  `--add-virtual-file` and <path>.

This matches the documentation for --add-file and the behavior works for
that option, but --prefix is ignored for --add-virtual-file.

This commit modifies archive.c to include the prefix in the path and
adds a check into the existing add-virtual-file test to ensure that it
honors both the most recent prefix before the flag.

In looking for others with this issue, I found message
a143e25a70b44b82b4ee6fa3bb2bcda4@atlas-elektronik.com on the mailing
list, where Stefan proposed a basically identical patch to archive.c
back in February, so the main addition here is the test along with that
patch.

Signed-off-by: Tom Scogland <scogland1@llnl.gov>
---
    archive: make --add-virtual-file honor --prefix

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1719%2Ftrws%2Fhonor-prefix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1719/trws/honor-prefix-v1
Pull-Request: https://github.com/git/git/pull/1719

 archive.c              | 11 +++++------
 t/t5003-archive-zip.sh |  8 ++++++--
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/archive.c b/archive.c
index 5287fcdd8e0..90086a1708f 100644
--- a/archive.c
+++ b/archive.c
@@ -365,12 +365,11 @@ int write_archive_entries(struct archiver_args *args,
 
 		put_be64(fake_oid.hash, i + 1);
 
+		strbuf_reset(&path_in_archive);
+		if (info->base)
+			strbuf_addstr(&path_in_archive, info->base);
+		strbuf_addstr(&path_in_archive, basename(path));
 		if (!info->content) {
-			strbuf_reset(&path_in_archive);
-			if (info->base)
-				strbuf_addstr(&path_in_archive, info->base);
-			strbuf_addstr(&path_in_archive, basename(path));
-
 			strbuf_reset(&content);
 			if (strbuf_read_file(&content, path, info->stat.st_size) < 0)
 				err = error_errno(_("cannot read '%s'"), path);
@@ -381,7 +380,7 @@ int write_archive_entries(struct archiver_args *args,
 						  content.buf, content.len);
 		} else {
 			err = write_entry(args, &fake_oid,
-					  path, strlen(path),
+					  path_in_archive.buf, path_in_archive.len,
 					  canon_mode(info->stat.st_mode),
 					  info->content, info->stat.st_size);
 		}
diff --git a/t/t5003-archive-zip.sh b/t/t5003-archive-zip.sh
index 961c6aac256..acc8bc4fcd6 100755
--- a/t/t5003-archive-zip.sh
+++ b/t/t5003-archive-zip.sh
@@ -218,14 +218,18 @@ test_expect_success UNZIP 'git archive --format=zip --add-virtual-file' '
 	fi &&
 	git archive --format=zip >with_file_with_content.zip \
 		--add-virtual-file=\""$PATHNAME"\": \
-		--add-virtual-file=hello:world $EMPTY_TREE &&
+		--add-virtual-file=hello:world \
+		--prefix=subdir/ --add-virtual-file=hello:world \
+		--prefix= $EMPTY_TREE &&
 	test_when_finished "rm -rf tmp-unpack" &&
 	mkdir tmp-unpack && (
 		cd tmp-unpack &&
 		"$GIT_UNZIP" ../with_file_with_content.zip &&
 		test_path_is_file hello &&
 		test_path_is_file "$PATHNAME" &&
-		test world = $(cat hello)
+		test world = $(cat hello) &&
+		test_path_is_file subdir/hello &&
+		test world = $(cat subdir/hello)
 	)
 '
 

base-commit: 786a3e4b8d754d2b14b1208b98eeb0a554ef19a8
-- 
gitgitgadget
