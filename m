Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9211F31A97
	for <git@vger.kernel.org>; Thu, 18 Jan 2024 22:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705615799; cv=none; b=BRsx6jnd98LAkybVKZh/FHpQ+XcBd3uPOx3tbnTIhr/mXNZR/0Q4z2FWfDk+S0fBfV/DX2/ggKvmP2mNUZV1pcUNaEQY0hKUZeAGbLHN0QTJGLuizFJf1gDRDFEfuOq44wIilc4Q5EZfqFdTy4hrl/OOS+NVC3tR/uD6vq8ubTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705615799; c=relaxed/simple;
	bh=qbTHPBjJXyt+PmpDLa7IfZ21FFrJ9+apYlEFExBTiPU=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ZoNSmfJUKUqZOnnq6J7raJx8geEjtHfGJBpW614SfdgrhibB6Q7FK9zv/I4xuk80Hu3OQ6+dLE70SEil7FN9/DRJ8pbyjh4uUzInBzpkU6dQm1xCi6PVEBLaYv0QXVbZjC8TC3VmXF3CbP45QDSqNint97vqeoUx6l/7EQS99jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VpHzIHgO; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VpHzIHgO"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40e9d4ab5f3so909715e9.2
        for <git@vger.kernel.org>; Thu, 18 Jan 2024 14:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705615795; x=1706220595; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xgwCesFR90ub79Pp1cP/Q5nps9BTn9IwdgrSBcM3P0Y=;
        b=VpHzIHgOtF68iWAkCfznrlHXqPphtOm+uAtS9LwVHS48vdxP7rFGa3GOiRf0b7NZRT
         57ioajvCyqavll9X9Se3DUkfWTXKq69r2i0+NFXUf4l3FldRjxgIwfMM9n1vlIB0g59B
         j175FNX+Y3DEI+sZxeTZXhOawYGvp89XcLSw4eNOcfL9d/luoWpinhYWXnexdtqU541D
         xpaFxy4dKFzpb+9vdJhkJ5h0K5stKwG6MTd+OEvu4jpmqrxtL0j1J9EIyoa1tK5cbxXV
         4VZXyr3La7g50T32KP5MFfu3c6QskNJ02CIPSXQjzLeju995MiibenZUD2emFj0bBTP3
         Zspg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705615795; x=1706220595;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xgwCesFR90ub79Pp1cP/Q5nps9BTn9IwdgrSBcM3P0Y=;
        b=IWwDfKl33N3KUyAAalYdxmgxbS5TYnCN/Ha8OFmg94bIBZrtR2pg3KuySITYJtfbbZ
         n6PN7peBhSFY06PFpuPAH2xh7Wz5djWfeeqrXbj7DlCUE31z7WC6Tl3LMIeUFg29yq9w
         w+9N5qlYwNeoaRtEW5rxzvHKo4COtfRJC15OaDnSQdjESiKqf2WhOb88UOBDVo/UD4l1
         5xfXu/BxsL3CPRC6+60/64GtYCSxiyeCDPZtJBJEGjiCRicWfX0lVmTiUFCVJ5uU7jyr
         PxAhOYW5EVe6kK0jiqjaZMHEZi5C5qbyG1lMNmfvqAUb/VTZR2xB8GPLwZbrIyQNMNHy
         URzw==
X-Gm-Message-State: AOJu0YybeaXWAU2OUMugwY10+RgYYIuimLVOee6Tb/LHoM26YX9/4BYe
	r68pePScqkyDubpjRP+Mp4O+p1vq93vaXeClReQyorrdDhvJwfqAVoEwQwwx
X-Google-Smtp-Source: AGHT+IFbUI5UGlhnObGBjoahY/kqhO1dD6Il3Ihgyk9IOwkDzDaMpRf4SmcCy0yFKXplFVmDcIuiwA==
X-Received: by 2002:a05:600c:4191:b0:40d:3b88:4516 with SMTP id p17-20020a05600c419100b0040d3b884516mr1035843wmh.95.1705615795322;
        Thu, 18 Jan 2024 14:09:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id iw7-20020a05600c54c700b0040d604dea3bsm26528233wmb.4.2024.01.18.14.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 14:09:55 -0800 (PST)
Message-ID: <pull.1648.v3.git.git.1705615794307.gitgitgadget@gmail.com>
In-Reply-To: <pull.1648.v2.git.git.1705592581272.gitgitgadget@gmail.com>
References: <pull.1648.v2.git.git.1705592581272.gitgitgadget@gmail.com>
From: "Antonin Delpeuch via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 18 Jan 2024 22:09:54 +0000
Subject: [PATCH v3] merge-ll: expose revision names to custom drivers
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
Cc: Junio C Hamano <gitster@pobox.com>,
    Antonin Delpeuch <antonin@delpeuch.eu>,
    Antonin Delpeuch <antonin@delpeuch.eu>

From: Antonin Delpeuch <antonin@delpeuch.eu>

Custom merge drivers need access to the names of the revisions they
are working on, so that the merge conflict markers they introduce
can refer to those revisions. The placeholders '%S', '%X' and '%Y'
are introduced to this end.

Signed-off-by: Antonin Delpeuch <antonin@delpeuch.eu>
---
    merge-ll: expose revision names to custom drivers
    
    Changes since v2:
    
     * change the documentation to use "common ancestor" rather than "merge
       ancestor"
     * fix indentation issue

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1648%2Fwetneb%2Fmerge_driver_pathnames-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1648/wetneb/merge_driver_pathnames-v3
Pull-Request: https://github.com/git/git/pull/1648

Range-diff vs v2:

 1:  6dec70529c0 ! 1:  aebd26711fe merge-ll: expose revision names to custom drivers
     @@ Commit message
          Signed-off-by: Antonin Delpeuch <antonin@delpeuch.eu>
      
       ## Documentation/gitattributes.txt ##
     -@@ Documentation/gitattributes.txt: command to run to merge ancestor's version (`%O`), current
     +@@ Documentation/gitattributes.txt: The `merge.*.name` variable gives the driver a human-readable
     + name.
     + 
     + The `merge.*.driver` variable's value is used to construct a
     +-command to run to merge ancestor's version (`%O`), current
     ++command to run to common ancestor's version (`%O`), current
       version (`%A`) and the other branches' version (`%B`).  These
       three tokens are replaced with the names of temporary files that
       hold the contents of these versions when the command line is
     @@ Documentation/gitattributes.txt: When left unspecified, the driver itself is use
      -will be stored via placeholder `%P`.
      -
      +will be stored via placeholder `%P`. Additionally, the names of the
     -+merge ancestor revision (`%S`), of the current revision (`%X`) and
     ++common ancestor revision (`%S`), of the current revision (`%X`) and
      +of the other branch (`%Y`) can also be supplied. Those are short
      +revision names, optionally joined with the paths of the file in each
      +revision. Those paths are only present if they differ and are separated
     @@ merge-ll.c: static enum ll_merge_result ll_ext_merge(const struct ll_merge_drive
       		else if (skip_prefix(format, "P", &format))
       			sq_quote_buf(&cmd, path);
      +		else if (skip_prefix(format, "S", &format))
     -+		    sq_quote_buf(&cmd, orig_name);
     ++			sq_quote_buf(&cmd, orig_name);
      +		else if (skip_prefix(format, "X", &format))
      +			sq_quote_buf(&cmd, name1);
      +		else if (skip_prefix(format, "Y", &format))


 Documentation/gitattributes.txt | 12 ++++++++----
 merge-ll.c                      | 17 ++++++++++++++---
 t/t6406-merge-attr.sh           | 16 +++++++++++-----
 3 files changed, 33 insertions(+), 12 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 201bdf5edbd..86a0946bb9e 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -1137,11 +1137,11 @@ The `merge.*.name` variable gives the driver a human-readable
 name.
 
 The `merge.*.driver` variable's value is used to construct a
-command to run to merge ancestor's version (`%O`), current
+command to run to common ancestor's version (`%O`), current
 version (`%A`) and the other branches' version (`%B`).  These
 three tokens are replaced with the names of temporary files that
 hold the contents of these versions when the command line is
-built. Additionally, %L will be replaced with the conflict marker
+built. Additionally, `%L` will be replaced with the conflict marker
 size (see below).
 
 The merge driver is expected to leave the result of the merge in
@@ -1159,8 +1159,12 @@ When left unspecified, the driver itself is used for both
 internal merge and the final merge.
 
 The merge driver can learn the pathname in which the merged result
-will be stored via placeholder `%P`.
-
+will be stored via placeholder `%P`. Additionally, the names of the
+common ancestor revision (`%S`), of the current revision (`%X`) and
+of the other branch (`%Y`) can also be supplied. Those are short
+revision names, optionally joined with the paths of the file in each
+revision. Those paths are only present if they differ and are separated
+from the revision by a colon.
 
 `conflict-marker-size`
 ^^^^^^^^^^^^^^^^^^^^^^
diff --git a/merge-ll.c b/merge-ll.c
index 1df58ebaac0..13e0713fe82 100644
--- a/merge-ll.c
+++ b/merge-ll.c
@@ -185,9 +185,9 @@ static void create_temp(mmfile_t *src, char *path, size_t len)
 static enum ll_merge_result ll_ext_merge(const struct ll_merge_driver *fn,
 			mmbuffer_t *result,
 			const char *path,
-			mmfile_t *orig, const char *orig_name UNUSED,
-			mmfile_t *src1, const char *name1 UNUSED,
-			mmfile_t *src2, const char *name2 UNUSED,
+			mmfile_t *orig, const char *orig_name,
+			mmfile_t *src1, const char *name1,
+			mmfile_t *src2, const char *name2,
 			const struct ll_merge_options *opts,
 			int marker_size)
 {
@@ -222,6 +222,12 @@ static enum ll_merge_result ll_ext_merge(const struct ll_merge_driver *fn,
 			strbuf_addf(&cmd, "%d", marker_size);
 		else if (skip_prefix(format, "P", &format))
 			sq_quote_buf(&cmd, path);
+		else if (skip_prefix(format, "S", &format))
+			sq_quote_buf(&cmd, orig_name);
+		else if (skip_prefix(format, "X", &format))
+			sq_quote_buf(&cmd, name1);
+		else if (skip_prefix(format, "Y", &format))
+			sq_quote_buf(&cmd, name2);
 		else
 			strbuf_addch(&cmd, '%');
 	}
@@ -315,7 +321,12 @@ static int read_merge_config(const char *var, const char *value,
 		 *    %B - temporary file name for the other branches' version.
 		 *    %L - conflict marker length
 		 *    %P - the original path (safely quoted for the shell)
+		 *    %S - the revision for the merge base
+		 *    %X - the revision for our version
+		 *    %Y - the revision for their version
 		 *
+		 * If the file is not named indentically in all versions, then each
+		 * revision is joined with the corresponding path, separated by a colon.
 		 * The external merge driver should write the results in the
 		 * file named by %A, and signal that it has done with zero exit
 		 * status.
diff --git a/t/t6406-merge-attr.sh b/t/t6406-merge-attr.sh
index 72f8c1722ff..156a1efacfe 100755
--- a/t/t6406-merge-attr.sh
+++ b/t/t6406-merge-attr.sh
@@ -42,11 +42,15 @@ test_expect_success setup '
 	#!/bin/sh
 
 	orig="$1" ours="$2" theirs="$3" exit="$4" path=$5
+	orig_name="$6" our_name="$7" their_name="$8"
 	(
 		echo "orig is $orig"
 		echo "ours is $ours"
 		echo "theirs is $theirs"
 		echo "path is $path"
+		echo "orig_name is $orig_name"
+		echo "our_name is $our_name"
+		echo "their_name is $their_name"
 		echo "=== orig ==="
 		cat "$orig"
 		echo "=== ours ==="
@@ -121,7 +125,7 @@ test_expect_success 'custom merge backend' '
 
 	git reset --hard anchor &&
 	git config --replace-all \
-	merge.custom.driver "./custom-merge %O %A %B 0 %P" &&
+	merge.custom.driver "./custom-merge %O %A %B 0 %P %S %X %Y" &&
 	git config --replace-all \
 	merge.custom.name "custom merge driver for testing" &&
 
@@ -132,7 +136,8 @@ test_expect_success 'custom merge backend' '
 	o=$(git unpack-file main^:text) &&
 	a=$(git unpack-file side^:text) &&
 	b=$(git unpack-file main:text) &&
-	sh -c "./custom-merge $o $a $b 0 text" &&
+	base_revid=$(git rev-parse --short main^) &&
+	sh -c "./custom-merge $o $a $b 0 text $base_revid HEAD main" &&
 	sed -e 1,3d $a >check-2 &&
 	cmp check-1 check-2 &&
 	rm -f $o $a $b
@@ -142,7 +147,7 @@ test_expect_success 'custom merge backend' '
 
 	git reset --hard anchor &&
 	git config --replace-all \
-	merge.custom.driver "./custom-merge %O %A %B 1 %P" &&
+	merge.custom.driver "./custom-merge %O %A %B 1 %P %S %X %Y" &&
 	git config --replace-all \
 	merge.custom.name "custom merge driver for testing" &&
 
@@ -159,7 +164,8 @@ test_expect_success 'custom merge backend' '
 	o=$(git unpack-file main^:text) &&
 	a=$(git unpack-file anchor:text) &&
 	b=$(git unpack-file main:text) &&
-	sh -c "./custom-merge $o $a $b 0 text" &&
+	base_revid=$(git rev-parse --short main^) &&
+	sh -c "./custom-merge $o $a $b 0 text $base_revid HEAD main" &&
 	sed -e 1,3d $a >check-2 &&
 	cmp check-1 check-2 &&
 	sed -e 1,3d -e 4q $a >check-3 &&
@@ -173,7 +179,7 @@ test_expect_success !WINDOWS 'custom merge driver that is killed with a signal'
 
 	git reset --hard anchor &&
 	git config --replace-all \
-	merge.custom.driver "./custom-merge %O %A %B 0 %P" &&
+	merge.custom.driver "./custom-merge %O %A %B 0 %P %S %X %Y" &&
 	git config --replace-all \
 	merge.custom.name "custom merge driver for testing" &&
 

base-commit: 186b115d3062e6230ee296d1ddaa0c4b72a464b5
-- 
gitgitgadget
