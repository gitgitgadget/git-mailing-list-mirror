Received: from mail-dy2-f35.google.com (mail-dy2-f35.google.com [74.125.229.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71CC3C1412
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 17:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790272777; cv=none; b=JUjU2OoQho3nySKek1fiYibLs5ZQAZVbw6DgeBMdUHiGZKGRPsiEkfYLX6Y6z6uHs8CA16VvC4h3WWa2WtL07LQo7CGqIZArhd8WMgGobnCHV/1Y/3mymKUvjV9x9Mc++ysXtHxoPVdidGpRNHGZoKBziJO41jF6VMajDRFR4Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790272777; c=relaxed/simple;
	bh=beM6V/qYRfeQnLgjrZoRYUfiEQmaxE3J1q2s4zPxDf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sxhbKsR41X+8+sYHUDAS4avVbVJu/fMDzYWBBpJ1PJocKgxYc4w/KovZaGjJfn0uL61jGPmaIBjDSMm4e5zDZT+W2wvv6vttQ+ih/s1Xq9TwRA5vrbbAUWtF9Mv+QRnyttGS16Wrxdb7C2N0Qd0XK3yJ8FV7vQNk55ZgzDVPZ5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IsT6wQBm; arc=none smtp.client-ip=74.125.229.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IsT6wQBm"
Received: by mail-dy2-f35.google.com with SMTP id 5a478bee46e88-3381a6a05c9so9886eec.1
        for <git@vger.kernel.org>; Thu, 24 Sep 2026 10:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790272775; x=1790877575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DlFkUxbgY/VNtniIaFeFsJ+fuf9vIAb6/kQVBsYjnHA=;
        b=IsT6wQBmvhizlHUG9YdBDXKDY4YuWrMVfiS4gHcwsYL8NyyLBwu3LVQdCe96ZzO54D
         CfcVAXlese0GYzdTf3s4sm8Csrb9LV8+DdP7WUvE5R9b8PI3fm+kAf1XbS5Rasf2mMd1
         m95JOgFo5YMyNV5JUihyo7W36DvncL1Tm+2ovHK9tM3pAWuWmTlL1dy6XH4dsxjRzOPC
         PPQdgMkifJ41lk2ezYSID2vGvLKJwts6if6o5j2sRrGDyPucksfKUFTr5WNe04iXh9UR
         dTcNNApqJkZMD90ALmXgCJxnThgMwf4EKNbSbifs+q1Gj8tQCDULLIPCdm5+Y9xBBJVR
         xA8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790272775; x=1790877575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DlFkUxbgY/VNtniIaFeFsJ+fuf9vIAb6/kQVBsYjnHA=;
        b=qMdmtHEcTOjPlWbaK52VWyWCGrfrDqyWIa8WDDVHs1SfZ607PIM1uR19wxct+l5KYJ
         dRlHx7f9iZBFzNByE//fLfRD1fG2IhcewLqWaXr327EsgUwDjWImykOGy5jg1QuJDxIw
         EfNwGFdsq4oqqSftqNCr8z0UyuLLhV0DKke+w9vSaIP3yA21NIp8Lr2b5m7Iue9MCsBx
         YUH+4ti1TlOO97Kd0gGBF9yhHdw15ohgDHb2KQXeEyieXYWnQYqvRVu5QZSEUrCCUkXJ
         5QyTXb8KvyqLgjK09t3wrjycuv9OGRyP1yWbjvpSyekXJB5Gylpt0joBV5pCQXPTXMW3
         T14Q==
X-Gm-Message-State: AFuF++kCQ4Hy+GeD4JiwNKh7f/BsnoUh4thabcTX9dTwhtxWKQonUrwa
	F59wfsoWML8QEXU55CXCD4b4jEKF/ZFep0g3aALfgwhYioawKhwddEXW
X-Gm-Gg: AYBFou3TTiyrxIjkNGceVGhGj9IFJs/XIcYxsyV3K+co+a4jFnabb+70tVNofCU3Wob
	l23rRKdpW4O1XKf6NpZdp4q7+Nuiwve60sJmGR77POzTqeMNo38YvkI0utdbaytPuw2ghGpo0PN
	hoTWhGZRFbtNvDpOQa2UtewLDf4nrjJXmjg+EpN3sICTrvcgf2blY28Y+HCbYHs4V8DM1XXETh7
	/hK73hCnib1rSjD5GRKUZ4YhWtVKBem6d3lSOs7/7r0716zB5wj1XmkMxggStxp7HCmi8TWWwq1
	gYUvKUgPa/uFyUdmxfC9sDhgUjJmKh2EorjsqNjKQ7wp0SOAoNQ8qmrBbizXOEYDb1DWi6M6DDh
	OEkE+ygG08rKsjY3OIDU7TxNa9XG9fBDNqKMVcjZPY34dSE3HeHlSB6g/ZgJ4WlFfZPxKCWC4Oq
	DAfaOY/Ljz05KLgogSoMw0ePGRt99VK0yFz5Nuw7jzLWGdOLrF6prtETy6FQYfrEuKxZzwClJpY
	Mg4L4+6Fslsc8Y42s4=
X-Received: by 2002:a05:693c:41db:10b0:33b:dd20:f79c with SMTP id 5a478bee46e88-33ffeb46c67mr2707689eec.12.1790272774131;
        Thu, 24 Sep 2026 10:59:34 -0700 (PDT)
Received: from HP-V15.xu.edu.in ([125.22.10.135])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-341460f5166sm232890eec.29.2026.09.24.10.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 10:59:33 -0700 (PDT)
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
To: pushkarkumarsingh1970@gmail.com
Cc: git@vger.kernel.org,
	peff@peff.net,
	ps@pks.im,
	r.norouzi@proton.me
Subject: [PATCH v3] reflog: fix default expiry periods
Date: Thu, 24 Sep 2026 17:58:44 +0000
Message-ID: <20260924175843.8383-2-pushkarkumarsingh1970@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.321.g6cd5cfc5f3
In-Reply-To: <20260923102140.25475-2-pushkarkumarsingh1970@gmail.com>
References: <20260923102140.25475-2-pushkarkumarsingh1970@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The default reflog expiry periods were swapped when they were moved to
REFLOG_EXPIRE_OPTIONS_INIT() by 85658275702b (builtin/reflog: stop storing
default reflog expiry dates globally).

This caused reachable entries to expire after 30 days instead of 90 days,
and unreachable entries after 90 days instead of 30 days.

Reported-by: r.norouzi <r.norouzi@proton.me>
Signed-off-by: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
---
Changes in v3:
- Split the regression test into four independent cases, covering
  reachable and unreachable entries before and after their expiry periods.

 reflog.h          |  4 +--
 t/t1410-reflog.sh | 66 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+), 2 deletions(-)

diff --git a/reflog.h b/reflog.h
index b996712c00..3bdd1ca8a5 100644
--- a/reflog.h
+++ b/reflog.h
@@ -23,8 +23,8 @@ struct reflog_expire_options {
 	int recno;
 };
 #define REFLOG_EXPIRE_OPTIONS_INIT(now) { \
-	.default_expire_total = now - 30 * 24 * 3600, \
-	.default_expire_unreachable = now - 90 * 24 * 3600, \
+	.default_expire_total = now - 90 * 24 * 3600, \
+	.default_expire_unreachable = now - 30 * 24 * 3600, \
 }
 
 /*
diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index 8f78cf4b01..93b5b49e1d 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -153,6 +153,72 @@ test_expect_success 'reflog expire should not barf on an annotated tag' '
 	test_grep ! "error: [Oo]bject .* not a commit" err
 '
 
+test_expect_success 'reflog expire keeps reachable entries for 90 days' '
+	test_when_finished "rm -rf reachable-keep" &&
+	git init reachable-keep &&
+	(
+		cd reachable-keep &&
+		timestamp=$(test-tool date timestamp "60.days.ago") &&
+		timestamp=${timestamp#* -> } &&
+		test_commit --no-tag --date "$timestamp +0000" old &&
+		git reflog expire --all &&
+		test_stdout_line_count = 1 git reflog refs/heads/main
+	)
+'
+
+test_expect_success 'reflog expire removes reachable entries after 90 days' '
+	test_when_finished "rm -rf reachable-expire" &&
+	git init reachable-expire &&
+	(
+		cd reachable-expire &&
+		timestamp=$(test-tool date timestamp "100.days.ago") &&
+		timestamp=${timestamp#* -> } &&
+		test_commit --no-tag --date "$timestamp +0000" old &&
+		git reflog expire --all &&
+		test_stdout_line_count = 0 git reflog refs/heads/main
+	)
+'
+
+test_expect_success 'reflog expire keeps unreachable entries for 30 days' '
+	test_when_finished "rm -rf unreachable-keep" &&
+	git init unreachable-keep &&
+	(
+		cd unreachable-keep &&
+		test_commit --no-tag base &&
+		base=$(git rev-parse HEAD) &&
+		timestamp=$(test-tool date timestamp "20.days.ago") &&
+		timestamp=${timestamp#* -> } &&
+		test_commit --no-tag --date "$timestamp +0000" old &&
+		old=$(git rev-parse HEAD) &&
+		git update-ref refs/heads/main "$base" &&
+		git rev-list --all --objects >reachable &&
+		test_grep ! "$old" reachable &&
+		git reflog expire --all &&
+		git reflog --format='%H' refs/heads/main >actual &&
+		test_grep "$old" actual
+	)
+'
+
+test_expect_success 'reflog expire removes unreachable entries after 30 days' '
+	test_when_finished "rm -rf unreachable-expire" &&
+	git init unreachable-expire &&
+	(
+		cd unreachable-expire &&
+		test_commit --no-tag base &&
+		base=$(git rev-parse HEAD) &&
+		timestamp=$(test-tool date timestamp "40.days.ago") &&
+		timestamp=${timestamp#* -> } &&
+		test_commit --no-tag --date "$timestamp +0000" old &&
+		old=$(git rev-parse HEAD) &&
+		git update-ref refs/heads/main "$base" &&
+		git rev-list --all --objects >reachable &&
+		test_grep ! "$old" reachable &&
+		git reflog expire --all &&
+		git reflog --format='%H' refs/heads/main >actual &&
+		test_grep ! "$old" actual
+	)
+'
+
 test_expect_success 'corrupt and check' '
 
 	corrupt $F &&
-- 
2.53.0

