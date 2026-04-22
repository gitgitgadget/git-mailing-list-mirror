Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096F13314AE
	for <git@vger.kernel.org>; Wed, 22 Apr 2026 09:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776851407; cv=none; b=PF1c7c10k3lqSIJfKDVSTo3YnPTIoA8p+MyIK3fgGCaWMpsBSdxaJpJhb0X43UCb8dDFJ8UA+Vyqx0Gc2EgECBSrG/zRcNp4ePmTRnDjh8y02Ovpe/WfhCpe1Y+PCN+D8PmRzgYd7nS84J+K9XsNAF8WVMTQP6+zfC5ZaFoUfaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776851407; c=relaxed/simple;
	bh=u6ZJ7Q0acgXVf+LCbni9iUxfAYq9ceBv+MamWiykqAY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:
	 In-Reply-To:References:To:Cc; b=jYFgE/l0KtamTVBvDJNcdwWdir9Woz4LLjsrSD5FwRvhMYL9XqovElAta3CsFGBWPYG8iG/Kmv/ll7CAtEJ+zTXiNBxQFjCovvgJUUWvxl/xfU6mutsHd8vpzbdnGR4CeWxDbmjaz0mFJaXX+azJV/cA2wkXr+YYoNxR6Rvo/Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=blVRixT/; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blVRixT/"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48a563e4ef7so17005235e9.0
        for <git@vger.kernel.org>; Wed, 22 Apr 2026 02:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776851404; x=1777456204; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rai04+NX9M0J6ksypC9Fn7+wqjgtCWMXbBuABk8t1/A=;
        b=blVRixT/9qHsE9j7wLrIt3W0eFvZcAKgWhb+iaOqpdwOB0LnwC5qMS9fj7HffVPFB7
         vyCENOhUInY/WW/pcrLAj0lfCfWUUOnP5Kjvap9CKRv2wjYztvQn0DFXD5hriUMAnZt0
         m926HY+KBOGG6hiORT5rB2Vbn6lJs3naonyYVaGJsQP+NYB9VFQYrG0UG2++BhqfkcgA
         eJhbJf2fo/j/NXaB4pkMfs47i4OkRTWhEqu+coCRYs2FmuLK36x3EBu9vDWojp1pSE+W
         zheSJynRMUbfEkqQ4NHl1PRxQ2qUgS9BlFNd2ZZKDnWwou4+J+LiCh8ydtvca4EVdH3Y
         S/4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776851404; x=1777456204;
        h=cc:to:references:in-reply-to:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Rai04+NX9M0J6ksypC9Fn7+wqjgtCWMXbBuABk8t1/A=;
        b=e7pWEa/PEgwp+ryjAqtUG27IliK9KLlQDLRs96ECascIG99T4fTaPTDnH1rp9LEp7k
         OEVw/LK+2ctzZuGkvgd/w6uHpYLbjwXAYz0JfVo83i4aOsHc8FlSaVLiK2dDKkZm7x4G
         H8b/xc/1csA2vuAhU1ILi357cY3mudBeb5zDl4aQM9jLvEz4AFH0blCHzk9/YC95uaaZ
         1HevORMNpgVcqw50gYF8aTkPSKBwcUvJ3P0i2HgwGmVVIk980SG62YUhDLH5SjnsXup3
         CdxvV+E3tnVA0YO+1oakf0N0f6JtOjVR3VK5qdQkeE0BhK51nXRhiXiFmLY8PDhytr27
         eStw==
X-Gm-Message-State: AOJu0YxVr5q1ttfDoX+Tc9hNWouy9njyyndHCunBgTfYKaZxTNcEBPMs
	E2ZZ2Mha0cPoJoTDMagCYNfW/WYnFiyERKffIiFyq4ElR2Kgsai+CZGgsLG4OA==
X-Gm-Gg: AeBDietGNFvPeqQ0MNuBIkUHkMQcamAf+nx471uxuomxTwhSv/iaav28XqebU2zZZOn
	CWgiUh7ut+pcUF1hiiZI1Ft1u+g/kO3jbaAHlKaEDxkNAZgAjxnsk3B4mfmr8m3Be7XwBK5Tcfb
	+dBOMX4Y31cCuv1K09tiie17gWiiWS57Pi2cnEtTDELsVjIXmESHrH2FXG1zUWs6sQAS0I0AvTj
	tK/k89CWCaWBC/U7iGOBY9C5BA6R6wPUjjTYDjdf7MLuhf2HTzB8qs/6v9nBSSd9w7cv0xWLV7C
	HuUDa+4lZMUD7SWgha9RrdkAk0KKQX754DDewIi9X4tgLJAbh1xLkcm3VVNSnRrq/BEW2Jdh+ky
	oK8uqIQqVISUHya5SO1GBvpIwahC4fNScfpGCxOVjOjZ/cKv8FhFl7ogTTCCGidn5Brj1H0gxA0
	CYjFN/0NMTsN/1PyuSfPl1pd3HUTv9eb7uw6oYZ8dM
X-Received: by 2002:a05:6000:288b:b0:441:1cf8:ca00 with SMTP id ffacd0b85a97d-4411cf8ca01mr12245818f8f.26.1776851404063;
        Wed, 22 Apr 2026 02:50:04 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:d134:6fab:9d04:f6a0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cb135asm48785006f8f.6.2026.04.22.02.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 02:50:03 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 22 Apr 2026 11:49:58 +0200
Subject: [PATCH v2] refs/files: skip lock files during consistency checks
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-refs-fsck-skip-lock-files-v2-1-9607571ae59a@gmail.com>
X-B4-Tracking: v=1; b=H4sIAMWZ6GkC/42NTQ6CMBCFr0K6dkxboYor72FYQJ3CyE9JB4mGc
 HcLXsDd+5LvvbcIxkDI4posIuBMTH6IoA+JsE051Aj0iCy01EamWkJAx+DYtsAtjdD5mBx1yGC
 Ny02lrEtPFxH7Y1TpvW/fix/zq3qinbbBzWiIJx8++/msNu+fn1mBAquzPEMtTXk2t7ovqTta3
 4tiXdcvhys8m9QAAAA=
X-Change-ID: 20260420-refs-fsck-skip-lock-files-c6f96b1cf438
In-Reply-To: <20260420-refs-fsck-skip-lock-files-v1-1-c2595e206a76@gmail.com>
References: <20260420-refs-fsck-skip-lock-files-v1-1-c2595e206a76@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com, Christian Couder <chriscool@tuxfamily.org>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4883; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=u6ZJ7Q0acgXVf+LCbni9iUxfAYq9ceBv+MamWiykqAY=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGnomcixnKMeiqwCA4Sk3DDWZAkVYyKBafnFX
 NgDYaiLdA+1B4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJp6JnIAAoJED7VnySO
 Rox/hzUMAKPFEe4EwDn5excSAeIebLtEiN/ErQ0OEpEnJov7WwgVaGoBNGOrp1nwVP+enk85DHG
 2bjPy28F3uAzPRF4619zwKzgoXdQ2/sziU1dIllSMNTaETF0kExEBuLakmLD54bKWPtjilrd5vQ
 H9PD2I6OLLEgpVv+r9R78qHwoiydGgAmjEUqvX9+0YceA4onIn6/8EkDiSX7OpAfuO39bdLyVLi
 UdmLj6/kP2af1rTlTy45Gue8emm1GrZuYIpLEkXxyD0IRoXbwenYNF9ISO4WkWtvIlCaFrXvxiY
 oU4BvWBgeYIdZcHCtBgghIugfCmTzRwBwm5518hpUP/ZBV2qYVRdHrC/YRvBc32rxQQi98paeLI
 iDQBGqeNQAnGFuXz0eGvidSRZ2ZIQ5hgiUqixlwmjdRJRjFUkIEkmQHsqlc1Bo7PnOEwUT8mGXW
 2WBpTS4BgL4E2v8BVkGyGtJlsilXJcS0YhCoTvEZJ9F14Vi6p5onjsdrcUJx9TIkofjikY6x1m2
 vo=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Consistency checks in the files reference backend involve two steps:

1. Iterate over all entries within the 'refs/' directory and call
`files_fsck_ref()` on each.
2. Iterate over all root refs via `for_each_root_ref()` and call
`files_fsck_ref()` on each.

`files_fsck_ref()` then runs all fsck checks defined in
`fsck_refs_fn[]`. Step 2 goes through the refs API and only sees valid
refs, but step 1 iterates the directory directly and will also encounter
intermediate '*.lock' files.

Currently, `files_fsck_refs_name()`, one of the functions in
`fsck_refs_fn[]`, filters out lock files itself. The other function,
`files_fsck_refs_content()`, has no such check and would parse the lock
file. Any new function added to `fsck_refs_fn[]` would have the same
problem.

Move the filter up into `files_fsck_refs_dir()`, where the directory
iteration happens. Since step 2 cannot produce lock files, this is the
only site where the filter is needed, and individual checks no longer
have to re-implement it.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
Changes in v2:
- Modified the commit message to clarify the changes made and reasoning.
- Modify the comment in the code to be more accurate.
- Add another additional test for bare lock files.
- Link to v1: https://patch.msgid.link/20260420-refs-fsck-skip-lock-files-v1-1-c2595e206a76@gmail.com
---
 refs/files-backend.c     | 22 +++++++++++-----------
 t/t0602-reffiles-fsck.sh | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 11 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index b3b0c25f84..1504a1e2f3 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3864,22 +3864,12 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
 static int files_fsck_refs_name(struct ref_store *ref_store UNUSED,
 				struct fsck_options *o,
 				const char *refname,
-				const char *path,
+				const char *path UNUSED,
 				int mode UNUSED)
 {
 	struct strbuf sb = STRBUF_INIT;
-	const char *filename;
 	int ret = 0;
 
-	filename = basename((char *) path);
-
-	/*
-	 * Ignore the files ending with ".lock" as they may be lock files
-	 * However, do not allow bare ".lock" files.
-	 */
-	if (filename[0] != '.' && ends_with(filename, ".lock"))
-		goto cleanup;
-
 	if (is_root_ref(refname))
 		goto cleanup;
 
@@ -3939,6 +3929,7 @@ static int files_fsck_refs_dir(struct ref_store *ref_store,
 	struct strbuf refname = STRBUF_INIT;
 	struct strbuf sb = STRBUF_INIT;
 	struct dir_iterator *iter;
+	const char *filename;
 	int iter_status;
 	int ret = 0;
 
@@ -3962,6 +3953,15 @@ static int files_fsck_refs_dir(struct ref_store *ref_store,
 			strbuf_addf(&refname, "worktrees/%s/", wt->id);
 		strbuf_addf(&refname, "refs/%s", iter->relative_path);
 
+		filename = basename((char *) iter->path.buf);
+
+		/*
+		 * Ignore the files ending with ".lock" as they may be lock files.
+		 * However, do not skip invalid refnames with '.lock' suffix.
+		 */
+		if (filename[0] != '.' && ends_with(filename, ".lock"))
+			continue;
+
 		if (files_fsck_ref(ref_store, o, refname.buf,
 				   iter->path.buf, iter->st.st_mode) < 0)
 			ret = -1;
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index 3c1f553b81..13259821a0 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -87,6 +87,47 @@ test_expect_success 'ref name should be checked' '
 	)
 '
 
+test_expect_success 'lock files should be ignored' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		git commit --allow-empty -m initial &&
+		git checkout -b branch-1 &&
+
+		touch .git/refs/heads/branch-1.lock &&
+		git refs verify 2>err &&
+		test_must_be_empty err &&
+
+		echo "foobar" >.git/refs/heads/branch-2 &&
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		error: refs/heads/branch-2: badRefContent: foobar
+		EOF
+		test_cmp expect err
+	)
+'
+
+test_expect_success 'bare lock files should not be ignored' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		git commit --allow-empty -m initial &&
+		git checkout -b branch-1 &&
+
+		# invalid refname should be reported
+		cp .git/refs/heads/branch-1 .git/refs/heads/.branch-1.lock &&
+		# invalid refname and content should be reported
+		touch .git/refs/heads/.lock &&
+
+		test_must_fail git refs verify 2>err &&
+		test_grep "error: refs/heads/.branch-1.lock: badRefName: invalid refname format" err &&
+		test_grep "error: refs/heads/.lock: badRefName: invalid refname format" err &&
+		test_grep "error: refs/heads/.lock: badRefContent: " err
+	)
+'
+
 test_expect_success 'ref name check should be adapted into fsck messages' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&



