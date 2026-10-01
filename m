Received: from mail-dy2-f40.google.com (mail-dy2-f40.google.com [74.125.229.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FC63BFAED
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 18:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790880268; cv=none; b=nFjmdkYnKDg2U0B5Z5Cy/nC1lbVrHXTn2/ofrQImu9cZYZ15KEivrWzUXE6FKHBp625346/R/gmmbH5pPF/TE2wiW5BgDqAbLH29SA2BbiuLdXJ4KK22F6IQ6RhaevLatWi53q9oJE1t+sfwWkYzXhDCp9sZ0BxgIXid2gIoOSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790880268; c=relaxed/simple;
	bh=YCCD/vWmNelmC0AZVGb8tm+fSwrC3McNlNHkl9BguAo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=aoYco9BKxbuDBUuLV+TE9dSiIF6AUQebgu4i3XKE6R5qmFP5Nhjg8EWdpGA6xd5+3e6M0I9boySnfycHWVCAySeWjTMoTMTPcSDiVrGYQwNNXlgMkdWQ9SsIqABrtQ6/cYLm7g69+0I274FeQLpMKKVQxhFHgK7uqlkVoEsKMWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i5Cl8LJi; arc=none smtp.client-ip=74.125.229.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5Cl8LJi"
Received: by mail-dy2-f40.google.com with SMTP id 5a478bee46e88-34ea9118159so789445eec.3
        for <git@vger.kernel.org>; Thu, 01 Oct 2026 11:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790880262; x=1791485062; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gTUUhatDD7C7zkRXDzt+zFFftUPXGCOEbAAM65X+hCs=;
        b=i5Cl8LJihAAXpf4hmUSnEqlJXImfS2UXMijFHblapGNkSKr+Q0JYiuelNgH0fruiCy
         1f8DZGoYpDewGVR7PoBBkqq3UMwSWjPQ8EdRiJEJLkDGA97VFdV3xJfpAXWooiQalp/X
         0jm5LBws7ciH0wiY0aL2QfIQXAofPCAgraG/8CYPjPmtumvacFWOYX43n15vAfHW1+vh
         PVmost7vnIBlbMdd7r9VO8f0+8Yaeyr2l9+uiFFBoi2L6wDAhL/YNRb4js91TI3ZhY36
         DfYWj0wdAJbx6i/4jupcwPhJzVc5tH9LhCJMqtLL6VFqZyo95I/Pg86gbCIfEjU7S4Ux
         XI+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790880262; x=1791485062;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gTUUhatDD7C7zkRXDzt+zFFftUPXGCOEbAAM65X+hCs=;
        b=ntS8x27BKQ7TqpcwT7XnYX6yge1+y1DWDwJ+dRmddnq+7zpn5p1tOOF/6d9fTRb7t8
         NokRwdEi0iITN8tMN9vAIHaNQo6+wLz4d8rSkxK++iq08nJ2F1sEQAMV4xjyIsPiRzKu
         ZEpOlVXeV2Y5p4lYoM3Qa9OYb6LPFDYjNhWGjy1OyF9WLjKUuV9EPwuhJJP2p7pQSDdv
         TRowV4LhxqE+rEknyK+wQ7JJATkNbdC648icQ5eZ4M6rrEzd3IkEabAuk4ZR4t5wm35E
         ihtYT0O6VYKb7jpRYm6ES1YsIpjyubWPbQcUN5CKDruX4ZW+iW5YBWLY90FnK7TD7R+b
         H4Zw==
X-Gm-Message-State: AFuF++ni+kpt+ML5fcc5imUTwXHeTrCLYpPI+7lkyzYMJJwrtDkxiKGi
	NreRGNTlapoNWJrfM0wO4z9Jw95HHHE25JGEM2ruqcfZv2hoN/MSwWWc17Mvjw==
X-Gm-Gg: AYBFou1yElJJY/j4+RwJuxqtttqcaXibJ/JFu3UhppNHpTDsYrwEcwMplCK+XZAqzCZ
	61QjlpoMmbk2Z/y/JfAE3/NOy8RioNe3zDH6tbJcpptLIrzgs2SaSDGwPnUzz2q61oxREEAn/hk
	dqgvBreB+5/PgGe6mrY0Ovn9YeuLGQsy7k/cW2CfWRHb4q1VW2+FJcgXAr85V3Ik9RRb1/C1Id4
	3+dksr4KKoyVYLiHLoshCTT0WY4kML1PqkGIA/hAIUg6NsjrMmOQtsO4ZaJjFMHkLvof1VDa/5V
	UySCplmID5TqsEs7Soxxa5HhNb9RRelhvLsQg1oMPtgqZpMPrJftAWC/RtM1hGPBdv0sKfgq0YG
	D1skAVAcGxn87y6l1qEDTqqRK0a96Vnlejozpq7yOp9GKa8EVsKCYixE4YDQhtKmVan4XepcP2f
	g9pDQci0HgxPA64DnRSh8uRYzYwByLXV+Xi+imk35Gg6yFRLZwGNYQ2dCO8tF75jQfjmpdEFadV
	kE=
X-Received: by 2002:a05:7022:7e8c:b0:144:ed18:47ab with SMTP id a92af1059eb24-14f5b311ec1mr37134c88.13.1790880261559;
        Thu, 01 Oct 2026 11:44:21 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.247.10])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34f14f98527sm205568eec.16.2026.10.01.11.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 11:44:21 -0700 (PDT)
Message-Id: <8ec2b53d8265e1219b5f1279cadda2ac44c96ae0.1790880255.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2419.v4.git.git.1790880255.gitgitgadget@gmail.com>
References: <pull.2419.git.git.1790362443893.gitgitgadget@gmail.com>
	<pull.2419.v4.git.git.1790880255.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 01 Oct 2026 18:44:15 +0000
Subject: [PATCH v4 2/2] ci: point test failures and fixed known breakages at
 their file and line
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
Cc: Ben Knoble <ben.knoble@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

A test failure or a fixed known breakage gets an annotation that names
the test but says nothing about where it's defined, so a reviewer has
to search the script by hand to find it.

Find the line a test is defined on by searching the script for its
description as a fixed string, using the first match. Fall back to
line 1 when the description is not found verbatim, which happens when
a test builds its description at runtime instead of writing it out
literally.

A GitHub annotation is a single line, so a `%` in a test description
has to be percent-encoded as `%25`, or GitHub misreads it as its own
escape sequence. for-each-ref's format atoms use plenty of them, e.g.
`%(raw)`.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 t/test-lib-github-workflow-markup.sh | 38 +++++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 6 deletions(-)

diff --git a/t/test-lib-github-workflow-markup.sh b/t/test-lib-github-workflow-markup.sh
index 0d54496358..6fee4dfb22 100644
--- a/t/test-lib-github-workflow-markup.sh
+++ b/t/test-lib-github-workflow-markup.sh
@@ -31,6 +31,22 @@ start_test_output () {
 	github_markup_script_name=${0##*/}
 }
 
+github_escape_message_ () {
+	# % has to be escaped or GitHub misreads it as the start of its own
+	# percent-encoding (e.g. a literal %(raw) in a for-each-ref test
+	# description).
+	sed -e 's/%/%25/g'
+}
+
+find_test_case_line_ () {
+	# A description can contain characters like [ or * that would
+	# corrupt a regex search, so match it literally and take the first
+	# hit. The -- keeps a description starting with "-" from being read
+	# as an option.
+	grep -n -F -- "$1" "$TEST_DIRECTORY/$github_markup_script_name" |
+	head -n 1 | cut -d: -f1
+}
+
 github_annotation_ () {
 	echo >>$github_markup_output "::$1 file=$2,line=$3::$4"
 }
@@ -40,18 +56,28 @@ github_annotation_ () {
 finalize_test_case_output () {
 	test_case_result=$1
 	shift
+
+	case "$test_case_result" in
+	ok|broken)
+		# Exit without printing the "ok" or "broken" tests
+		return
+		;;
+	esac
+
+	test_case_line=$(find_test_case_line_ "$1")
+	test_case_description=$(printf '%s' "$1" | github_escape_message_)
+
 	case "$test_case_result" in
 	failure)
-		echo >>$github_markup_output "::error::failed: $this_test.$test_count $1"
+		github_annotation_ error "t/$github_markup_script_name" "${test_case_line:-1}" \
+			"failed: $this_test.$test_count $test_case_description"
 		;;
 	fixed)
-		echo >>$github_markup_output "::notice::fixed: $this_test.$test_count $1"
-		;;
-	ok|broken)
-		# Exit without printing the "ok" or ""broken" tests
-		return
+		github_annotation_ notice "t/$github_markup_script_name" "${test_case_line:-1}" \
+			"fixed: $this_test.$test_count $test_case_description"
 		;;
 	esac
+
 	echo >>$github_markup_output "::group::$test_case_result: $this_test.$test_count $*"
 	test-tool >>$github_markup_output path-utils skip-n-bytes \
 		"$GIT_TEST_TEE_OUTPUT_FILE" $GIT_TEST_TEE_OFFSET
-- 
gitgitgadget
