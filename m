Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9183A17A2FB
	for <git@vger.kernel.org>; Mon, 29 Dec 2025 21:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767044702; cv=none; b=WCG0ZGwIbRKRz2KYVGDL4SXISz/D6o14gltc5CjlmUasHXsm0jIO5rOpevdEwSJtVPZhfExZ+zq1RjPqFvUtXE/zxNxPto+nTY5iBbnIrokpOZo+QJPWi5FQAQYKcMqiTd7ziAs9uhzKvj9TgzFKfQkP2jnCNiges8HAWPVfni8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767044702; c=relaxed/simple;
	bh=uqqvTzAc/tZqCuVEgOeRZ8jD8lWrhQR+xut6cG6LEJo=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=bexcSTpSr7YOiciJpXvFNJAORaH4MG8hWlTGqgghKI5zPYY+8+dCKQb9rFvyC+IAM1k0GWYcHeGw3TpQERWglSV8IQKhrvi2cN9IOLrmKe0XeQ+oYk7tGs2CjiuviRoTUTw3DBfWFzxnAODMzly+YQTSjizewn2UaCmwtHp/7eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CXTw8LB+; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CXTw8LB+"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4f1aecac2c9so101341321cf.1
        for <git@vger.kernel.org>; Mon, 29 Dec 2025 13:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767044699; x=1767649499; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cWPgiowJBizJhOHeOQeQYRzjOCDXYxtwpxKCbxcaVj8=;
        b=CXTw8LB+QBoYeCeRsGMAaQQBSQMTkrg+TX/hAGPPScJPnhNizyGH5rwfPCKJB1hHz3
         gbjDQITZBaRu6liudHwKKGE4Zt7iVZuJxtCUmyGrssxQAi3IODIpBcmBubATZurV15m3
         f/4mmEHpY0ky2wvnrzUnkYLLOXdr5M3Yl2ZGxbvshVMO9D/REwiWuqManv53OkPjOr6y
         cHzNSz3oiMcnsoS591HoMetqC0DpobUXievXEY8cqlRT0AxbPzRR9AV/gRWcQA98bRpY
         2zCLWt1l/4Ntq58j7JollDqJ94EXmABffgLLJ8ytQskHNI/gSvsWcwpllh37Wg+xChDr
         ggKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767044699; x=1767649499;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cWPgiowJBizJhOHeOQeQYRzjOCDXYxtwpxKCbxcaVj8=;
        b=jHF/ZZAjTI38HdOwE19Z8OCaBZA7Jzyvird5xWbaqdNlI3xpvinRzuTC7I4zFM3uoy
         S2/hRxzU6rFO7ugUGdIK+nuIDl9WDRVmv4X6vikW0hx4pyLSLESbqJz05fkyx3tFmmv/
         eU1rx2OZBwcM8MIejlWKVfvlKbaRng/weOgT4DxxriDJwyf5KFWj+9yKJieZXXYCqDiy
         /PvokZ5YJbsU3ndq78sr8jFspBx47Y2wal+xBiVdxd/sPsrS6qrglH1rfFZh2gfnWmys
         pWUqFQDVRDFUOs06kX1qqXUTx0oyo6+9S7tsFfLVTmfGjAmsMcqYGlpaEAEVfIkfvAcb
         FcxQ==
X-Gm-Message-State: AOJu0YxfsFA2uK6KHCkIBT1670JpHD8ZgENcG3AySeappVgB8PUilcDX
	Czu3i+RbPf+v02PCWK5zcjI0WEh/ZEWfJ301jBhKMvb7Xog6W+hsOIFFyatJD5Rm
X-Gm-Gg: AY/fxX7gffd8cD7BnScJNk5ULjdwMZTWUSDpmAABxiiol+1aFpww/s5a0tG3iSDvzIZ
	SLXTnqGEdI68MYiMxRVtNZkhdZsX8IWaJgCjH1DZu98K1QwVxoyplzVjmWduYgweHf7MQ3kOz3M
	ToH3z5ZksL54QVjVAHtejyGGoNX+sM2Y9R2xW1y3dsVz6rwnqAbXphnE5Dzhk5TT8H6O3WO35ox
	7BbGsXKtoZmSAwXl67oIDaOUoRCpd9Hn6GUNGO0aHfwSWxH865mrIlRP3UVE791KLIOI5Ccn+4I
	1CGXBpbiCRAELDTBvpltgZZkRJln5yNZ03EDLtCdpRPIDBsVVSpf/ytgpWDAfOT8j+EionqnoPw
	cBqty+vs//c1ExBSYuMoFX0bUjN0em6AEWgWLsk7t3RVF0xaRtbBw+nRN+JxiO3sC2iq/q0xC/s
	42pv6tfNScHXu6aw==
X-Google-Smtp-Source: AGHT+IFDM6/9jwagI1PfIRXxmDWNPBFLzqIpFIRUlQJRyc7x72J2dE/mZQlsAcK7eNCwU7hFlIzzsg==
X-Received: by 2002:ac8:5d14:0:b0:4eb:e287:3a76 with SMTP id d75a77b69052e-4f4aad6ef71mr441731201cf.24.1767044699066;
        Mon, 29 Dec 2025 13:44:59 -0800 (PST)
Received: from [127.0.0.1] ([135.232.225.16])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f4ac55fde7sm223921921cf.12.2025.12.29.13.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 13:44:58 -0800 (PST)
Message-Id: <pull.2027.git.1767044697712.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 29 Dec 2025 21:44:57 +0000
Subject: [PATCH] diff: avoid segfault with freed entries
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
Cc: gitster@pobox.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

When computing a diff in a partial clone, there is a chance that we
could trigger a prefetch of missing objects at the same time as we are
freeing entries from the global diff queue. This is difficult to
reproduce, as we need to have some objects be freed from the queue
before triggering the prefetch of missing objects. There is a new test
in t4067 that does trigger the segmentation fault that results in this
case.

The fix is to set the queue pointer to NULL after it is freed, and then
to be careful about NULL values in the prefetch.

The more elaborate explanation is that within diffcore_std(), we may
skip the initial prefetch due to the output format (--name-only in the
test) and go straight to diffcore_skip_stat_unmatch(). In that method,
the index entries that have been invalidated by path changes show up as
entries but may be deleted because they are not actually content diffs
and only newer timestamps than expected. As those entries are deleted,
later entries are checked with diff_filespec_check_stat_unmatch(), which
uses diff_queued_diff_prefetch() as the missing_object_cb in its diff
options. That can trigger downloading missing objects if the appropriate
scenario occurs to trigger a call to diff_popoulate_filespec(). It's
finally within that callback to diff_queued_diff_prefetch() that the
segfault occurs.

The test was hard to find because it required some real differences,
some not-different files that had a newer modified time, and the order
of those files alphabetically was important to trigger the deletion
before the prefetch was triggered.

I briefly considered a "lock" member for the diff queue, but it was a
much larger diff and introduced many more possible error scenarios.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
    diff: avoid segfault with freed entries
    
    I found this segfault in the wild in a pipeline that was using the
    microsoft/git fork, but the error can be reproduced without that fork.
    It requires partial clone, though.
    
    Thanks, -Stolee

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2027%2Fderrickstolee%2Fdiff-segfault-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2027/derrickstolee/diff-segfault-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2027

 diff.c                        |  5 +++++
 t/t4067-diff-partial-clone.sh | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/diff.c b/diff.c
index a1961526c0..72661d635c 100644
--- a/diff.c
+++ b/diff.c
@@ -7046,6 +7046,7 @@ static void diffcore_skip_stat_unmatch(struct diff_options *diffopt)
 			if (!diffopt->flags.no_index)
 				diffopt->skip_stat_unmatch++;
 			diff_free_filepair(p);
+			q->queue[i] = NULL;
 		}
 	}
 	free(q->queue);
@@ -7089,6 +7090,10 @@ void diff_queued_diff_prefetch(void *repository)
 
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
+
+		if (!p)
+			continue;
+
 		diff_add_if_missing(repo, &to_fetch, p->one);
 		diff_add_if_missing(repo, &to_fetch, p->two);
 	}
diff --git a/t/t4067-diff-partial-clone.sh b/t/t4067-diff-partial-clone.sh
index 581250dd2d..72f25de449 100755
--- a/t/t4067-diff-partial-clone.sh
+++ b/t/t4067-diff-partial-clone.sh
@@ -132,6 +132,41 @@ test_expect_success 'diff with rename detection batches blobs' '
 	test_line_count = 1 done_lines
 '
 
+test_expect_success 'diff succeeds even if entries are removed from queue' '
+	test_when_finished "rm -rf server client trace" &&
+
+	test_create_repo server &&
+	for l in a c e g i p
+	do
+		echo $l >server/$l &&
+		git -C server add $l || return 1
+	done &&
+	git -C server commit -m x &&
+
+	for l in a e i
+	do
+		git -C server rm $l || return 1
+	done &&
+
+	for l in b d f i
+		do
+		echo $l$l >server/$l &&
+		git -C server add $l || return 1
+	done &&
+	git -C server commit -a -m x &&
+
+	test_config -C server uploadpack.allowfilter 1 &&
+	test_config -C server uploadpack.allowanysha1inwant 1 &&
+	git clone --filter=blob:limit=0 "file://$(pwd)/server" client &&
+
+	for file in $(ls client)
+	do
+		cat client/$file >$file &&
+		mv $file client/$file || return 1
+	done &&
+	git -C client diff --name-only --relative HEAD^
+'
+
 test_expect_success 'diff does not fetch anything if inexact rename detection is not needed' '
 	test_when_finished "rm -rf server client trace" &&
 

base-commit: 9a2fb147f2c61d0cab52c883e7e26f5b7948e3ed
-- 
gitgitgadget
