Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7199D34575A
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 18:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770834098; cv=none; b=apoFmNNjVR0ENe29HgNwiQ8Vu/A8FxHACgWh1s0r0wxmIOvx8Nil6vDDUG02+CDTgZGp26FLDCd57ITIaQ0Il8VDAANou8ikh1woZMWcZALggcHjY09uYox50hnhlxcPGOEpcN3rvl+/MvXzkhgDx/ysBqgHVvl06WNQt7iwVVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770834098; c=relaxed/simple;
	bh=Qcs4vdc/c1hXHVxS8y83hxujj0eunuNbTwNyp6bCEaY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NhmiMwn3D4bxihXpJL+JgtzIA0+rmsw/KaurzINcY+zZEsBvrmT3Ds7UklsznNcS9I0CPGZeuFqcXHWoN8susuvnJIL16M6h+G/pK7wmqGaCqgbp7MT3ctTeIVP4ig+GKTBkHTireH6T9jq4PMmK3uutTeQtWLwR/NxQ7AbxVXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iP0d+lIj; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iP0d+lIj"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-35622f00cb0so229125a91.3
        for <git@vger.kernel.org>; Wed, 11 Feb 2026 10:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770834096; x=1771438896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ceHMugt9OY5tltjWdjoju2v0Wxj7nbpwblBafzV3oYk=;
        b=iP0d+lIjmf6+YwZ73e+5aQkPjYWAaVE/tWigRExehr4VEc7iWI7gEVhkuq/LGaLPTh
         joTNxknjc7fADpkPGE+7oiNb7l4MzJJVYA1Wq+mSBDuNhzIjwGKiTd+W2YHQeFE6OgvL
         t20dDZI7rbjIWdBUzeeC2y7jFKlpPFK7K+PTnWv6MtkYWCwp7I9aTglOOQFwRAleFDmp
         RuSivQ5oxrk66ZdONCmrFJmhURwm9prmmgHuxjvVKsN/ZQ6CcUtGMN4LyOTAbNtJW1xq
         0LF2xNP0mksdKF6ZjL+a/A2Fx/poGXSXkANKvIViGw0XC1rFyT6l9fEPOd0NgLi3v3Nn
         q2xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770834096; x=1771438896;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ceHMugt9OY5tltjWdjoju2v0Wxj7nbpwblBafzV3oYk=;
        b=As+HqHe9xK7cwtdrzyPHTl3Ph2vv9a60WdeoMHppbfBQjGMsWHMLtuzt4NDW3OqK5C
         eWzvcxX8Mefil2Uyru167tuI6/9hReXwFRp7caaNU2YJLCun1fgD+KTrKoN/QfXwmsyk
         0W3Gkbcqyja3e/gMFtBsrm8/9BihTIYkj/G/y/RAzehtuLKL7CMbWLeslMqichHrnaHT
         /ockRfQFjmBYZN7OFUsQv6Qvuo4B8SingptmybNp0uqTdn4MLz6i18VvTZ7xMubaZsQ6
         zQT+aX8spI1H9ilAEFifn9emN65Z6vJxPjNbvwoJY5A7x5da9delv5ucISnGP09dVNvc
         fR8g==
X-Gm-Message-State: AOJu0Yz2vQbLq+vmB5A+IG8Eay6xBl72bQCKh4gUUaFDBE2LWuX2PVpr
	1kpuYJxUNXrBk+nl1//QqayixVgVkRiZCWyuNMt4cjD20QY1XHdKl5qzfmuI88f/Pw0=
X-Gm-Gg: AZuq6aJn/UqBKnKPfjS1RCtCBWzAveub1dT9/ZTndvK02CJC1cLTGXjKE+znHTu58c7
	aae0JXLqff2caSYiVfIJkLFyUZBQiZF8aFpSkv5yeWsjUAUOhHvBi5imtAFVqtivkl7w9xks9zO
	x0JT5xB/O2tLU5Yx5KPz/HCG+unPzyT5Pb32mwOtvGpSrQExvOyfIdxAVvoNIoU3wMNe0Jsimqf
	loXilJD3naJa/Ra+cUxCShwvvP9uOqSCYCHRnT8wAeP1FmwXL+nKtQ9xhvOCrVhVeOPDQnMxQrC
	6YmJIY/92WLW3zmzI4GnZ5GgYtqtEj3Wh3eS5wqrHtWGQWM2zoZVmeqqdqbDNbVBRKKXMl2zP1I
	mswdjJr0vWQZkAvzeb3Uf5kyNyATgaJQlN3j53MB68DKQj56h/8cyHrgptosCCIMPAtkMnQZxCJ
	/dFOB1sOW5m/Q8pTf4SVj3ZzWzW9AGrHKSCqF77e8=
X-Received: by 2002:a17:90b:54c5:b0:356:22ef:57aa with SMTP id 98e67ed59e1d1-3568f2b7605mr229232a91.2.1770834096260;
        Wed, 11 Feb 2026 10:21:36 -0800 (PST)
Received: from malon-Yoga-14sARE-2020.. ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e1967ca7esm2714331a12.3.2026.02.11.10.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 10:21:35 -0800 (PST)
From: Tian Yuchen <a3205153416@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com
Subject: [RFC] setup: fail if .git is not a file or directory
Date: Thu, 12 Feb 2026 02:21:22 +0800
Message-ID: <20260211182122.35352-1-a3205153416@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, `setup_git_directory_gently_1()` checks if `.git` is a
regular file (handling submodules/worktrees) or a directory. If it is
neither (e.g., a FIFO), the code hits a NEEDSWORK comment and simply
ignores the entity, continuing the discovery process in the parent
directory.

This behavior can be very dangerous. If a user is inside a subdirectory
containing a melformed/broken `.git` entity, the Git will traverse up,
attach to a parent repository and might execute destructive commands.

I tried to resolve the NEEDSWORK by using `lstat()` to explicitly check
the entity's mode. If it is neither a regular file nor a directory, we
kill the discovery process.

But I still have questions:
1. Is failing hard the desired behavior here? Should skipping it and
   continuing discovery be an option for the user, which might seem
   more fault-tolerant?
2. Should we die() immediately here, or return GIT_DIR_INVALID_GITFILE
   and let the caller decide?

Signed-off-by: Tian Yuchen <a3205153416@gmail.com>
---
 setup.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/setup.c b/setup.c
index 3a6a048620..a1b56de67a 100644
--- a/setup.c
+++ b/setup.c
@@ -1581,7 +1581,17 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
 		if (!gitdirenv) {
 			if (die_on_error ||
 			    error_code == READ_GITFILE_ERR_NOT_A_FILE) {
-				/* NEEDSWORK: fail if .git is not file nor dir */
+				struct stat st;
+				if (!lstat(dir->buf, &st) &&
+					!S_ISREG(st.st_mode) &&
+					!S_ISDIR(st.st_mode)){
+
+					if (die_on_error)
+						die(_("Invalid %s: not a regular file or directory"), dir->buf);
+					else
+						return GIT_DIR_INVALID_GITFILE;
+				}
+
 				if (is_git_directory(dir->buf)) {
 					gitdirenv = DEFAULT_GIT_DIR_ENVIRONMENT;
 					gitdir_path = xstrdup(dir->buf);
-- 
2.43.0

