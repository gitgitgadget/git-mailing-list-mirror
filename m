Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74006264612
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 03:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791344612; cv=none; b=XCKXYn708CqCgHe22v3X4BM7+CB346HHnVl9YZvu3FazGOCidCL7xj33mYSQe1iaskYZA3zRXIZNnYdL99oZocVxT/JdvN1U3wFh47u0htqPBC6bxBwbxC/1azTcjyy3kVxhYRJ6USu+hzd+HPGte6bHHQXkj2N0Nn0T692rgHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791344612; c=relaxed/simple;
	bh=vS2hj9MGoy+va3sqJzI05yeAqW/OQ61UUnYhKhu2mL0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fwHg55iMb+RJQxwyM1k+IVtcAHu/++BT0+Pzk4T8K/Bq+tJV4Jj57YtK21MCjFbPaN03ED8htGCXuPxCIyuh1bnMbFnQZsQijvA9vfpqoDi7WTEfpJX2s6qQwLFhhsDI9U8r5prcxHo+qSZYNnKXuWCm8OR+/IpwQW8RvAGlHFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e5qUfyJ9; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5qUfyJ9"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-3514e7cbbbaso2652851eec.1
        for <git@vger.kernel.org>; Tue, 06 Oct 2026 20:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791344610; x=1791949410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d9R7YS3vZrMjnuMVHLcmM6fHPd0EzluGLC5nOTSxXcg=;
        b=e5qUfyJ9OTEFMmJZJQMsma9rvFtGvH2ZyhafFsY0bjI3YWdiySz4is9NPI608IaUb1
         SlZUSlWmBFpPoE5DVSukd/ri3SohcBNJM10MWZ++KZwFe/nJJpevHqEp3kpvz3UL8LCu
         nvLZE7IEP9LLyYZwIY010Rfipxk1U0a6t/ZSJmNZ1U32Kq1xlnrB6hE8jlsH9SIcOh0o
         qoeMHeqQXlvbstIysNYeIFABzLbiWFRY+Qsm+y6lL3ffHUfMzu20VkSM+y0HsmSUDF+W
         l5Jg+ozSnpmAqFWv/8h/M0Twzl8a0RKAZY53fsyDjetrgB87Nck/s0HXCY/0ikfPHmA0
         5j8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791344610; x=1791949410;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d9R7YS3vZrMjnuMVHLcmM6fHPd0EzluGLC5nOTSxXcg=;
        b=1lKYBuejxfWakCxceYaENdpHusMz4VqDte/hSx6d7fE3DQrjRTu+OdvACyHVf92wQC
         f+ljSuoW52IqybQrFQF1kcFxt/fPFEAD9yNu9NxXzlt4xBQnzffKsWbO+2BJGoMJY9w0
         Z77TDXKcI/BevFnBeqgh/LBfkMEh3cHwM1/cGRNbB7V00YfmqUE2ptgsneV10W3Sykhh
         4Gq2Zt4UHu7ZHiWkC1ecws++b6ZmauGvLzUnIdRp2vPM6hU5hz8wlvsDYX3wQHAhpH1e
         yFNhcICubG7sdW0cf2UtPE9Pgc4/ChmWoMo55uBRF0IkLgIpT//dyk1sE9HGOkMElfXk
         0y5A==
X-Gm-Message-State: AFq9FYI7zF+UKeFA2wVU2rKCK4w4z3pburhEc17YK4HMuwOm8nyi6Zur
	Hrbn2aL7U/6bi3u12OumfSkXVT/wepRSm5IE1qSldhqPC6K3Mrgbv2R93cdHAxcEXm0=
X-Gm-Gg: AYBFou0k0P6pBRmiur39V2oKJfaeQNwWvmgPdR7pVM0RJL/sh01rYvEYKNzmvFbFXSV
	H0rBcQLLElYk8NmKrvC0jS0oYvlz2GlJzFeR+18UiiD30uxEAgoIhTHtNXm3cZwxah2CYNiHwAG
	aa7gV7SUgN0e36E0v56rwAIkMi2YtFmzCVxWyX15Kw7i6KW/TdrNlxOtJ19TCPjtJ6gQENxBbCr
	pq28Nv1NVmLL3EjwX9TYeb+tmN1oMbUqceLiWU7VLG0Lwb2yXVNeKporl2ZATgiliL4uRLIkGaC
	Zs2MeergqxRVN5bVN8YYk3WavVomfA5lmk0vOa+YVqOL7zWqJPaZ5gTlF8A79+A3mttf5YIFzBq
	u9s0eIFJkoiyirE5UdKz7wYIwQOmHRG+JwG3E3K7ICYbgEOeWnn/+nedO8eQLs+CDTheSoRtls2
	B4Wc+CC08zc8gDEP14hXhSKy0g+iedjbIKQapRgp2Bfvt6ab9OCPn4QoQk36FME60jqn+RDLO8V
	Up2zZY=
X-Received: by 2002:a05:7301:6e8a:b0:339:79c9:a711 with SMTP id 5a478bee46e88-3515de46f1bmr875311eec.33.1791344610190;
        Tue, 06 Oct 2026 20:43:30 -0700 (PDT)
Received: from archlinux ([2409:40f4:3002:dab5:166f:4758:5a34:37b3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3515b02d552sm5100452eec.28.2026.10.06.20.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 20:43:29 -0700 (PDT)
Sender: Dilshad <hello.dilshad.in@gmail.com>
From: Muhammed Dilshad A <dilsheddilu123@gmail.com>
To: git@vger.kernel.org
Cc: Muhammed Dilshad A <dilsheddilu123@gmail.com>
Subject: [PATCH] test-mergesort: plug memory leaks in sort_stdin()
Date: Wed,  7 Oct 2026 09:12:05 +0530
Message-ID: <20261007034205.32619-1-dilsheddilu123@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sort_stdin() helper allocates an input buffer and a memory pool for
the list of lines, but returns without releasing either. Discard the
pool and release the strbuf after printing the sorted lines.

Add a test for the sort subcommand to t0071. The existing test only
exercises the test subcommand, leaving these leaks undetected by the
regular leak-sanitized test suite.

Signed-off-by: Muhammed Dilshad A <dilsheddilu123@gmail.com>
---
 t/helper/test-mergesort.c | 2 ++
 t/t0071-sort.sh           | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/t/helper/test-mergesort.c b/t/helper/test-mergesort.c
index 791e128793..3b8c428b14 100644
--- a/t/helper/test-mergesort.c
+++ b/t/helper/test-mergesort.c
@@ -61,6 +61,8 @@ static int sort_stdin(void)
 		puts(lines->text);
 		lines = lines->next;
 	}
+	mem_pool_discard(&lines_pool, 0);
+	strbuf_release(&sb);
 	return 0;
 }
 
diff --git a/t/t0071-sort.sh b/t/t0071-sort.sh
index 2236a7e956..97890da29f 100755
--- a/t/t0071-sort.sh
+++ b/t/t0071-sort.sh
@@ -8,4 +8,11 @@ test_expect_success 'DEFINE_LIST_SORT_DEBUG' '
 	test-tool mergesort test
 '
 
+test_expect_success 'sort stdin' '
+	printf "%s\n" c a b >input &&
+	printf "%s\n" a b c >expect &&
+	test-tool mergesort sort <input >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.55.0

