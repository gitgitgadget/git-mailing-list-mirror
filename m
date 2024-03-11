Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD2354BCA
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 18:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710183368; cv=none; b=s6H9SGxprRGj1Vznfca89ojJzEfT51R8lJ21qvCLI99rP41nphkPCKNtVulS4pDiWcSEzP4OfOYevsNu5+21kk/xLa9vMV4CHkmFrOKm9ho3rEyl54WzJ7tLkZSgJ/Oe7P72q7pe5kN3X+HkZKGgTlbVWoQ27xS+r1zgwPP8ES8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710183368; c=relaxed/simple;
	bh=Q9mC0HVSU2O6KkbwKf/kvCMmLLxFf3tY5p4J3a87LA8=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=HVwXgfGW3o6pZr1TPQ1frEuI2GzhjM9pswjcqx3EptRhJKZUDN2gix8dpHvLk95v9JlxuOg0fTW8/gYUbpRTHUxcyBL6pLy/cF41+I5mBHtweD9rI170CRLwJgioimdyokmGte1uL6aceqrMhl5J7SJ+utTMO1Q6UyvCcM6gzUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QL+eyiff; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QL+eyiff"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33e94c12cfaso1267458f8f.3
        for <git@vger.kernel.org>; Mon, 11 Mar 2024 11:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710183364; x=1710788164; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DRdSL+V7jMot64FfpKDpV7DizO46WJ4pPaJ4th8i6HQ=;
        b=QL+eyiffXoQC/Mnz9LxutCoepfHn8Np/dkt89KN9kLKpzjr3i0J8L80EaeNe1TYaDK
         h9B38jo5XzMZgO5mfRoz0Qx8iAA/n7QXNDtZt/nyJoD1p6NGlsFGRhzgoc3VZJn4BBDz
         PcyMDvQTlfhucTpNwYdt8Q79KPsuN3ujPFuyexsyXgnHLbXBNeD+VDvo7UkCs7mgawHV
         3p4+VzAqcTtz2wpr6LEXZvFwAICuhN7aifoYjtF63lN8VKIduW7GMAQ8U/6G2GcJqumG
         HxAJpr845+34Zf6akhXDTQEj9wX0m26pK5rygA/sTW6ILNdN1ZseMa8/2c61a2wMmljA
         ZEqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710183364; x=1710788164;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DRdSL+V7jMot64FfpKDpV7DizO46WJ4pPaJ4th8i6HQ=;
        b=vn/cVL3ocxFI+VKHSZqvMy1rdR0Z7ODj8vbcSlSPL6qMJEYHTHd94xwZJQic/vGo97
         bzd/ASaKJDECiXXT2ad0AxILBIT4kP7zGtHDz4WW3+9Zi4/o/zQvPIF2Jb9tzpmpzYVk
         ItETbiAGrneDpELSetwq/d0f1FkdVgFwp+QtB+E5Gfa4n/TJZ3cijmwN7LO/0C1WmrJL
         xdv1pU6eTVFCqpitk5oJmAWG8hShD/P61XIddxQXlHrL69CuN+2VWBa7aegjAswoKNsI
         Ll7Xxij2UCqHc5e2Z7A4x4IZ1ERlRUfBc0G8nO+2gKOgkZeeLQpUCOisT5rmQbiGFasa
         9HeQ==
X-Gm-Message-State: AOJu0YyV775G4YquGs7r5y/4yuZUNjcfesz0bYxBSaeDl53G+sGumKJt
	NTVzJJaoPTg7J8tOahEUT8WUniAhwvgHCubN3h4LbPm8etoRbueKCVS4cWqo
X-Google-Smtp-Source: AGHT+IF0tZH+XZEGK3wZZNVCNq/3KwiW4/uMy9A1DwWB9LidTrmfRW2Ez1Td9iDADywJNjObq9XT3w==
X-Received: by 2002:adf:fc0c:0:b0:33e:a1ec:bb69 with SMTP id i12-20020adffc0c000000b0033ea1ecbb69mr185008wrr.40.1710183364212;
        Mon, 11 Mar 2024 11:56:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bo3-20020a056000068300b0033e9d0b3faasm1852807wrb.82.2024.03.11.11.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 11:56:03 -0700 (PDT)
Message-ID: <765d7240311e145b43bbe40f00436f3854a4a177.1710183362.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1689.git.1710183362.gitgitgadget@gmail.com>
References: <pull.1689.git.1710183362.gitgitgadget@gmail.com>
From: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 11 Mar 2024 18:56:00 +0000
Subject: [PATCH 1/3] t1006: update 'run_tests' to test generic object
 specifiers
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Victoria Dye <vdye@github.com>

From: Victoria Dye <vdye@github.com>

Update the 'run_tests' test wrapper so that the first argument may refer to
any specifier that uniquely identifies an object (e.g. a ref name,
'<OID>:<path>', '<OID>^{<type>}', etc.), rather than only a full object ID.
Also, add a test that uses a non-OID identifier, ensuring appropriate
parsing in 'cat-file'.

Signed-off-by: Victoria Dye <vdye@github.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t1006-cat-file.sh | 46 +++++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index e0c6482797e..ac1f754ee32 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -112,65 +112,66 @@ strlen () {
 
 run_tests () {
     type=$1
-    sha1=$2
+    object_name=$2
+    oid=$(git rev-parse --verify $object_name)
     size=$3
     content=$4
     pretty_content=$5
 
-    batch_output="$sha1 $type $size
+    batch_output="$oid $type $size
 $content"
 
     test_expect_success "$type exists" '
-	git cat-file -e $sha1
+	git cat-file -e $object_name
     '
 
     test_expect_success "Type of $type is correct" '
 	echo $type >expect &&
-	git cat-file -t $sha1 >actual &&
+	git cat-file -t $object_name >actual &&
 	test_cmp expect actual
     '
 
     test_expect_success "Size of $type is correct" '
 	echo $size >expect &&
-	git cat-file -s $sha1 >actual &&
+	git cat-file -s $object_name >actual &&
 	test_cmp expect actual
     '
 
     test_expect_success "Type of $type is correct using --allow-unknown-type" '
 	echo $type >expect &&
-	git cat-file -t --allow-unknown-type $sha1 >actual &&
+	git cat-file -t --allow-unknown-type $object_name >actual &&
 	test_cmp expect actual
     '
 
     test_expect_success "Size of $type is correct using --allow-unknown-type" '
 	echo $size >expect &&
-	git cat-file -s --allow-unknown-type $sha1 >actual &&
+	git cat-file -s --allow-unknown-type $object_name >actual &&
 	test_cmp expect actual
     '
 
     test -z "$content" ||
     test_expect_success "Content of $type is correct" '
 	echo_without_newline "$content" >expect &&
-	git cat-file $type $sha1 >actual &&
+	git cat-file $type $object_name >actual &&
 	test_cmp expect actual
     '
 
     test_expect_success "Pretty content of $type is correct" '
 	echo_without_newline "$pretty_content" >expect &&
-	git cat-file -p $sha1 >actual &&
+	git cat-file -p $object_name >actual &&
 	test_cmp expect actual
     '
 
     test -z "$content" ||
     test_expect_success "--batch output of $type is correct" '
 	echo "$batch_output" >expect &&
-	echo $sha1 | git cat-file --batch >actual &&
+	echo $object_name | git cat-file --batch >actual &&
 	test_cmp expect actual
     '
 
     test_expect_success "--batch-check output of $type is correct" '
-	echo "$sha1 $type $size" >expect &&
-	echo_without_newline $sha1 | git cat-file --batch-check >actual &&
+	echo "$oid $type $size" >expect &&
+	echo_without_newline $object_name | git cat-file --batch-check >actual &&
 	test_cmp expect actual
     '
 
@@ -179,33 +180,33 @@ $content"
 	test -z "$content" ||
 		test_expect_success "--batch-command $opt output of $type content is correct" '
 		echo "$batch_output" >expect &&
-		test_write_lines "contents $sha1" | git cat-file --batch-command $opt >actual &&
+		test_write_lines "contents $object_name" | git cat-file --batch-command $opt >actual &&
 		test_cmp expect actual
 	'
 
 	test_expect_success "--batch-command $opt output of $type info is correct" '
-		echo "$sha1 $type $size" >expect &&
-		test_write_lines "info $sha1" |
+		echo "$oid $type $size" >expect &&
+		test_write_lines "info $object_name" |
 		git cat-file --batch-command $opt >actual &&
 		test_cmp expect actual
 	'
     done
 
     test_expect_success "custom --batch-check format" '
-	echo "$type $sha1" >expect &&
-	echo $sha1 | git cat-file --batch-check="%(objecttype) %(objectname)" >actual &&
+	echo "$type $oid" >expect &&
+	echo $object_name | git cat-file --batch-check="%(objecttype) %(objectname)" >actual &&
 	test_cmp expect actual
     '
 
     test_expect_success "custom --batch-command format" '
-	echo "$type $sha1" >expect &&
-	echo "info $sha1" | git cat-file --batch-command="%(objecttype) %(objectname)" >actual &&
+	echo "$type $oid" >expect &&
+	echo "info $object_name" | git cat-file --batch-command="%(objecttype) %(objectname)" >actual &&
 	test_cmp expect actual
     '
 
     test_expect_success '--batch-check with %(rest)' '
 	echo "$type this is some extra content" >expect &&
-	echo "$sha1    this is some extra content" |
+	echo "$object_name    this is some extra content" |
 		git cat-file --batch-check="%(objecttype) %(rest)" >actual &&
 	test_cmp expect actual
     '
@@ -216,7 +217,7 @@ $content"
 		echo "$size" &&
 		echo "$content"
 	} >expect &&
-	echo $sha1 | git cat-file --batch="%(objectsize)" >actual &&
+	echo $object_name | git cat-file --batch="%(objectsize)" >actual &&
 	test_cmp expect actual
     '
 
@@ -226,7 +227,7 @@ $content"
 		echo "$type" &&
 		echo "$content"
 	} >expect &&
-	echo $sha1 | git cat-file --batch="%(objecttype)" >actual &&
+	echo $object_name | git cat-file --batch="%(objecttype)" >actual &&
 	test_cmp expect actual
     '
 }
@@ -271,6 +272,7 @@ tree_size=$(($(test_oid rawsz) + 13))
 tree_pretty_content="100644 blob $hello_sha1	hello${LF}"
 
 run_tests 'tree' $tree_sha1 $tree_size "" "$tree_pretty_content"
+run_tests 'blob' "$tree_sha1:hello" $hello_size "" "$hello_content"
 
 commit_message="Initial commit"
 commit_sha1=$(echo_without_newline "$commit_message" | git commit-tree $tree_sha1)
-- 
gitgitgadget

