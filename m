Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B47E3290AD
	for <git@vger.kernel.org>; Sun,  5 Jul 2026 08:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783239882; cv=none; b=jwDya/2K7hF9UnNkj4f+BVNshh4JD0WzyFGufdjln3R8GXgf9PPQmcc1TF9XDyKRhR1+Pl9mJvh5IPvJuR8dc30TMuVneJ9s/+q8zT7fmVIPnrf+6DRiT6yTQPrE9ReN5bT/DQYMMT4Zr5aRF3qqn0NYPWRWEA7ERV6jBvJCqOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783239882; c=relaxed/simple;
	bh=TpUyXjcUeMf4sW/PJDwLKKEx6godQTdBUvHsScrI4A0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=o50aaLu5b/Daiwb+wGxGDhp3GuBS91Bir8QhheKuXRjbFkHT9Qz4UX6epZcOx2zZ4qK20x4+MWEGqmYR6ZLoLRnBdPEiLeJkirfmvh2v8xlVcOXWtdck03QAdxTEyQzMj5RIaazDNUuaJ5t0GZUgv2g+Bmoxqqs7X2kIloeKTUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MnEjJu/Z; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MnEjJu/Z"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-92ea24a2dbfso51789085a.0
        for <git@vger.kernel.org>; Sun, 05 Jul 2026 01:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783239880; x=1783844680; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ivMX+0mIcBtHw1VuMkm5NDui4oOxFh6q6jeBIRZUyVw=;
        b=MnEjJu/ZV+z7RE1ISRUggol0Nx/4u6Tv3uU9vFJcmff2Y7nsX9JIZ7e5zz8IzDLb0+
         vasSq22O90k5PDd1cXbZRVsMgiCuqp5rnLjWuvIQp9tHApr8jBXhGdjlOufKhc5J2f4t
         8/hi8iRRqdDW9P/xmQ8UcsTUt0F58hzP31k1j3ufpSv/+5iy9ZO/AlDWHzJ8m4f1v7Dk
         fsXtIMT/xGXH+vAWQ0jzR9kJQjC6PxJA6L0yZk6MSSvNsv4bjZbrAAJ/U6K5Y/pJ13L4
         Bz8deDf8JiPrWRr21prHp05HL+A+vq2SMm+9TIUJ1pFWdOGeQiC+tsppn74ZXYxpNccw
         0j+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783239880; x=1783844680;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ivMX+0mIcBtHw1VuMkm5NDui4oOxFh6q6jeBIRZUyVw=;
        b=fEtEgw5iMsIehk7M8LdiOGtgwy5GVhq012Iren4sp2qGzaPIv7I7ECGjmysQILXFwb
         YrNFdciU7rG0kqY0/d61qYe9vkO3pYIjWmWeTggp5C3qta6K3GpVrqM2C1FdoiGd+gYJ
         3dAWwPiOxCyTcoMnI8GlN1BYQbsvKA/9TbU5wzGa63qDh24sgcpZpWjduo2Dkfd8CVn9
         dS6EbOQj7KAdgiSE01+pWXt8v19+WFgqEyvbZbX4dmW1bF95V1ECavZQwuR2Cly5GAio
         YAMa5sUWnR+AM/u6MJ40C+Fw4oYKfd5UI+gU5rIXipEG9tAN3f7852saVoKS8rnKrTn0
         QYsg==
X-Gm-Message-State: AOJu0YyZvT62o1DRQwn/EavoR1i9qDfyMpDkI7seNgIr5egPR86cBmMc
	xM1H9JHyw/5Jqs77ME5p4hPo3VmXZFQM17LT7oKQu8ELgG6vAp75Wx7OgPOshw==
X-Gm-Gg: AfdE7cnrSFc8ZBswi46ykpgzdjXk2Wt/q0Y2M4yiLbCiSKn+vxdiU0/akl9+NkDQJNR
	oBAU/EFyAgPnw2+99P5fe2dn0nc/xCSkK3AcEcb4uRP3ewa4DGgUvvm8H2BovYcehZ94WhtreKc
	E4Ki7NOb0xgyp9ErXzfTkDeUYhUEbEdkLlBUcbCe6725jmPT2dKpGBmkc5fHGhByi1urqxao7/a
	8Z5L/Bf/oEQ0OFGWC2QDjZT1WEBT0uM2nrWLpJ4LHR+kxIiutWcTL3qM1PK22qRoPDqTZsDOl0g
	fNordT1yGQEUc+7O/eroLEfy4Ak9xhnY2gP4kPDfz+7ZUVXw8kdq+mIaZTSQpJNhzTkIqZ3hhmg
	jqtO8tT3JPa85Y0P122a3rkGSZs5sCaBPQF70Uuq+F6OLO5Puac0dSfOWle0i2dE1t3yKigRBzw
	qIsYZKMEpN6irSIvypLdzKohLgcqTE
X-Received: by 2002:a05:620a:6506:b0:92b:6805:9190 with SMTP id af79cd13be357-92e9a53a6b2mr840740885a.72.1783239880457;
        Sun, 05 Jul 2026 01:24:40 -0700 (PDT)
Received: from [127.0.0.1] ([135.237.130.145])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90ba754fsm635979685a.18.2026.07.05.01.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 01:24:39 -0700 (PDT)
Message-Id: <8c623cc28f5c86b33b03deec0c2d0b5486b08c02.1783239870.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2163.v2.git.1783239870.gitgitgadget@gmail.com>
References: <pull.2163.git.1782889472.gitgitgadget@gmail.com>
	<pull.2163.v2.git.1783239870.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 05 Jul 2026 08:24:22 +0000
Subject: [PATCH v2 05/12] line-log: avoid redundant copy that leaks in
 process_ranges
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
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When `bloom_filter_check()` indicates that a commit does not touch any
of the tracked paths, `line_log_process_ranges_arbitrary_commit()`
propagates the current ranges to the parent by calling
`line_log_data_copy()` and passing the copy to add_line_range().
However, `add_line_range()` always makes its own copy internally (via
line_log_data_copy or line_log_data_merge), so the caller's copy is
never freed and leaks every time this path is taken.

Pass range directly to `add_line_range()` instead of making a redundant
intermediate copy. The callee's internal copy handles ownership
correctly.

Pointed out by Coverity.

Assisted-by: Claude Opus 4.6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 line-log.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/line-log.c b/line-log.c
index 5fc75ae275..0179f138f7 100644
--- a/line-log.c
+++ b/line-log.c
@@ -1141,8 +1141,7 @@ int line_log_process_ranges_arbitrary_commit(struct rev_info *rev, struct commit
 
 	if (range) {
 		if (commit->parents && !bloom_filter_check(rev, commit, range)) {
-			struct line_log_data *prange = line_log_data_copy(range);
-			add_line_range(rev, commit->parents->item, prange);
+			add_line_range(rev, commit->parents->item, range);
 			clear_commit_line_range(rev, commit);
 		} else if (commit->parents && commit->parents->next)
 			changed = process_ranges_merge_commit(rev, commit, range);
-- 
gitgitgadget

