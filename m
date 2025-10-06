Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947B71BC5C
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 09:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759741258; cv=none; b=Qt3CQzqMoogJT65AugsNAx5xqKqXT12yLY67Uu5iFlWfetOhZVx0X7ZmerefqsYx08cD8EJTukU545+HWVCRA2lNu/+Bmx0CFkmFnhTc05yL3ROwVhDHWYTCuRfpEjIuPBJP6J+EWEt3/VfeoC6guQMPHTuzP3hEsMUL89LyUNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759741258; c=relaxed/simple;
	bh=ly2QFdyZ1kSCtl9gViJzxGHxd0og161ytDC3Ju36sI0=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=jtIXenRLAGrFZyXbZQI9JAtwaq37AN6bARpAjoTJLKfD/VP5fVcuD/zmIvNOGZa5JBTgbZfVVVu9cgivisQv2L7xwFm/Mxionrtv2uCLiB8J7VErq7QCp+JhjkT+qlwaJD8kQ7ysMzuOJ0gCSqzy8HQXf+44PZOEGgLswTbvKsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j0vHEnRP; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0vHEnRP"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-42d857dcf92so18080785ab.1
        for <git@vger.kernel.org>; Mon, 06 Oct 2025 02:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759741255; x=1760346055; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TtitBU40uwDndfBz4eT4vaLr7GUAeMlrFPgM0G8PIv0=;
        b=j0vHEnRPXjltlLYhdxGoPW6a2LnNDyVdkanE5UyUb+PPm6S2DeKC9ql+0TZS92e8hR
         IUFEmhjNrOYjqGMp2E4G0WulSUseI2ynepYOcHLlXLegSLwcnecn1/2Mi6Pq7eM9eicu
         BsluDXRYhx+LN/7AbtwGVSUYGm7is3ofLcJEIuzKlV0ep4lkWWLC6ft9XvAE5OvDUGQ4
         4CGDF2Z24hImAqPsPQ8yP/w624Ulsupa/HYwu9brRcZRpQUEHfdKs6km9zC5djBiJen8
         bPGIz1KCHpIh37UaJsTLk+a9Tvkps1TAP2/Hn+bTFRQMY8jrfVPAWJ1Rvy9bJek61xMv
         ggTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759741255; x=1760346055;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TtitBU40uwDndfBz4eT4vaLr7GUAeMlrFPgM0G8PIv0=;
        b=vpZpcBsVg3/7/wHfXyQE4VhGKITzEKjwjOtgseEWbGIux4wk6CZeEh8JtrjVBgMjI5
         LHSpFHWR8ggZ+hi+g5PqaqxGTehvwF1Vg3KksEUulZujO6NBo1Mh5bl1nMwtJdw9MZg2
         aSh6urIFFeo7EubhWbp+G7Os71JOqlN4dSIIIq/r+TEzkCruqcWEzKtciJI1zbMysy2m
         Gv8Q5/QLSQjvA+pz+ZiRR8NjOLyxuLTZpnJrrsapoWdmC1Oxz34m/OVbW70kHPqJIwP/
         NONoH+KqKnS2WpUaFayCaAxTk6cCv1i656dLws7C8WVCJkBDjuRkqz/jpZfPmjHWVnSl
         6K6w==
X-Gm-Message-State: AOJu0Yxsn5svRN9BjSi9UDtKsvqf9fTaA4A9wTB94mmJfxDLteNJcHdt
	T5FhkqwthVeCh3m0u/V8CZhvLLbFZhpgORUBwgGfRnvNBonkmLAjtcuzkE3jDQ==
X-Gm-Gg: ASbGnctF1nub1ObAo2lHi56nvr+Rn1Uqy6sNPWiFeENfuKzmCN8QipjpIKVCHs0GAgy
	hGxb1fv0ztHEeFCIyxhGyMZsZRb4L1VNChXna68mSHJ+Krqu/AWgnytLkQt9KjosQ2UKQNaJpb9
	w6b/VPhf19EX62ZCdX99/H7lqVVqUOQDRVEdc9z7WfQQUrUBTUZdq4T4FSPO1A2/YCEitVTT28Q
	uKJN8Km/89msh+aSQ7f9sImoq2dv94tG3hoS+ejR7tb2K76da3gEmxP4HOcXGmFfLwKxwfMOL/j
	VvUfxE2RcvJE0KaSDW/wtfmO8o1Uhpjt3fD4IQB+onIzJdWTczWueqFsYkA7ntA+I/Rd5is2htl
	cqxWJm1UlCY8KuhlnG/iPfedBEiL8glCgtQ+NRvlmpxQk2E0jRq1ytPRenz6o
X-Google-Smtp-Source: AGHT+IGG4pV8sGSZEua5XG97IIFmS+tw2zE+nYGj3YzTGNO/lml9b5/UeScHdW5FOwj4CCW4uDQSog==
X-Received: by 2002:a05:6e02:b24:b0:42e:7589:6290 with SMTP id e9e14a558f8ab-42e7ad34712mr184214785ab.12.1759741254923;
        Mon, 06 Oct 2025 02:00:54 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.169.132])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-57b5ea2dd8asm4701570173.22.2025.10.06.02.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 02:00:53 -0700 (PDT)
Message-Id: <pull.2066.git.git.1759741252581.gitgitgadget@gmail.com>
From: "Imvedansh via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 06 Oct 2025 09:00:52 +0000
Subject: [PATCH]  t1410: modernize test path checks
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
Cc: Imvedansh <veds17007@gmail.com>,
    Imvedansh <veds17007@gmail.com>

From: Imvedansh <veds17007@gmail.com>

Convert old-style "test -f" and "! test -f" checks to use the
modern helper functions 'test_path_is_file' and
'test_path_is_missing' in t/t1410-reflog.sh.

This improves readability and consistency in the test suite.

Signed-off-by: Imvedansh <veds17007@gmail.com>
---
    t1410: modernize test path checks
    
    Hello,
    
    I'm Vedansh and I'm interested in contributing to Git through Outreachy
    2025.
    
    I have successfully built Git from source on Ubuntu (via WSL2) and run
    the test suite. All tests pass.
    
    For my microproject, I'd like to modernize the path checking in
    t/t1410-reflog.sh by replacing 'test -f' with test_path_is_file in lines
    133-136 (in the 'rewind' test).
    
    I found 4 instances that are assertions (part of && chains):
    
     * test -f C
     * test -f A/B/E
     * ! test -f F
     * ! test -f A/G
    
    I've verified these are test assertions, not flow control statements,
    and the test currently passes on my system.
    
    Is this appropriate for a microproject?
    
    Thanks, Vedansh

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2066%2FImvedansh%2Fmodernize-t1410-reflog-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2066/Imvedansh/modernize-t1410-reflog-v1
Pull-Request: https://github.com/git/git/pull/2066

 t/t1410-reflog.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index e30f87a358..ce71f9a30a 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -130,10 +130,10 @@ test_expect_success 'pass through -- to sub-command' '
 
 test_expect_success rewind '
 	test_tick && git reset --hard HEAD~2 &&
-	test -f C &&
-	test -f A/B/E &&
-	! test -f F &&
-	! test -f A/G &&
+	test_path_is_file C &&
+	test_path_is_file A/B/E &&
+	test_path_is_missing F &&
+	test_path_is_missing A/G &&
 
 	check_have A B C D E F G H I J K L &&
 

base-commit: 821f583da6d30a84249f75f33501504d597bc16b
-- 
gitgitgadget
