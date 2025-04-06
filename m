Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D941D554
	for <git@vger.kernel.org>; Sun,  6 Apr 2025 12:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743941726; cv=none; b=HgjbDCllVhLzrwABGEfEMs0N/5p1XfC98DjpnprWe+R3HKoEgxYEoYivZsWmkkOTn7QSN7aIdO/QJEO+Chxh9fWAQfy0Vafru10qPRNMk3/FGmZMdIfbwp0bUF+2M/foL0zvCsbeLxZpazBsmR6dcx1fJxShquu9diTNLTGZJIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743941726; c=relaxed/simple;
	bh=/1D6b6Zi/5giW8NyDbqRZBQC/LiMTB5UX2VMTBZZdyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k+J/LbS8lIx9r8nyPZmA25dvofP+vjG3QmiuWRKZARySYaJlgcKR18+RdAxqn315Zepe7eSUXRCRJSdweJm89rb4Yq8K7xf7s4cMUvV5QiCekXchpj5+g1JSwxdiUR7f1ygPi2nb7jMpEGpsKKleGrYj1nu3RlGAUakwgQeXeEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jOMPP4Le; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOMPP4Le"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22928d629faso33509725ad.3
        for <git@vger.kernel.org>; Sun, 06 Apr 2025 05:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743941723; x=1744546523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=swu2TJ65hx7qmfn9aSDweEL8/RrH6GPS/CF64HUBn/4=;
        b=jOMPP4LeTjuMUZFP/IZo/AFrz90fZqkM512UB3P2Kq8y5n9WrNf/cKTYGAJL6d28i+
         pvHBmVToWMzjZtJqI4+MP8dKSqe8SVNC0UdEmn9BuLFrGayAYr29rzc8+G7zRCcWO/7A
         w1Y8mjZRyvco+2zqDsn4UV4XNxUUZ6BixFtPdcvLVBHHRKmorkXWMOuGXwFvVxzih5bx
         Tp9PilDLeDHcIcpzziVsxr9/kDqvu4Ywcvg+az/K5thEo/jC+tp7K7VCxVH8iRbZ5iM6
         XSJovfSSqrIfKsaiw8RclsF2xmv5gIgbe4pq8SUilH4Ge0GHDOIdMHUvWYidkrtzUUgE
         xP0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743941723; x=1744546523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=swu2TJ65hx7qmfn9aSDweEL8/RrH6GPS/CF64HUBn/4=;
        b=pXAJw1BPFWeDSLnB5YFci7IWITJuTkJkeKHFYz5eFUc7AZyu5NJ/0JpWsiX+Nv4EQT
         ZCufeBRSwk29/Bdg3pP9Hi/O0DtJ0pWeGxpDop2uCykXnXdNpygyH5wLUAmktNVmG0ne
         noe24FnwnKglru3NQJFt8rW1xGs0LhtiTWiSO7IMO64rysoP/599SOVilrlajA/fuDE9
         FRcKXdK28JvRXQi0iPu3uIePEZoAx85b2VYHyJ7jktF1Xph34ImAQXO3D1z1OJPsJvog
         u48xhARUAocVMHtPkFzhhmhTNTg++bxk+fRIoyeBbEwaYRm/uCLOjPJky3770xWZKuNm
         on7Q==
X-Gm-Message-State: AOJu0Yw5eDFTTLFsFIYHqpQopGljiXksOPKxE4wuD7AgUxDldjH7A8Uy
	CCa+5gzQcv599vheLXmi+jaKKJYFM4q4QQNDjX2eiQLN0wvpi9LbNAJji3nl
X-Gm-Gg: ASbGncvHy5AzVhNYK5+lOy1xftxYi3G8IeiXG2TQnWBNCkYG+pgbJRQaL9oPp5nOvsM
	AIc6w3bQANwrvKgzi+ufgfWPrefb6XzAkJanUJsI8JpDH+iuNp0vYQxrxSlyginULtD5fSFtcPL
	a9uwxyASrKgM84F7d5I7McT0EFtxO92GGXwVFANzPjRZVvxNw+GHw6fMDKNAy0p7+NDj/KJ8wnd
	8oaQz22GaEHZMhZ4Gwxq8bXOa6bX58wGe//UMJcy6MI+YyKDBESe8186TNWD53bzu1QRyzYaLK9
	tsqIeZoW9fHbccoNOHtOspqHpmiiVdsnlXEZ/vIMqgmvbJGTFKpYkl2u/cpB8uX4y70n4kCWs0e
	+R/9J
X-Google-Smtp-Source: AGHT+IGAsjZnkRstoq+DLeKcnVHLOsFTI+wGJuaotYic4+LGFESFHcOyohZt4O7GOPuEGmQvnFEC/A==
X-Received: by 2002:a17:902:db07:b0:223:4d7e:e523 with SMTP id d9443c01a7336-22a8a8e45a0mr110736465ad.50.1743941723575;
        Sun, 06 Apr 2025 05:15:23 -0700 (PDT)
Received: from archlinux.plaksha.edu.in ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22978772ee4sm62410865ad.233.2025.04.06.05.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Apr 2025 05:15:23 -0700 (PDT)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org,
	christian.couder@gmail.com
Cc: gitster@pobox.com,
	johncai86@gmail.com,
	me@ttaylorr.com,
	ps@pks.im,
	shejialuo@gmail.com,
	phillip.wood123@gmail.com,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 1/1] builtin/update-server-info: remove unnecessary if statement
Date: Sun,  6 Apr 2025 17:44:12 +0530
Message-ID: <20250406121513.154084-2-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250406121513.154084-1-usmanakinyemi202@gmail.com>
References: <20250329120327.105925-1-usmanakinyemi202@gmail.com>
 <20250406121513.154084-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since we already teach the `repo_config()` in "1a764cdbdc
(Merge branch 'ua/some-builtins-wo-the-repository', 2025-03-26)"
to allow `repo` to be NULL, no need to check if `repo` is NULL
before calling `repo_config()`.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 builtin/update-server-info.c | 4 ++--
 t/t1517-outside-repo.sh      | 7 +++++++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/builtin/update-server-info.c b/builtin/update-server-info.c
index d7467290a8..ba702d30ef 100644
--- a/builtin/update-server-info.c
+++ b/builtin/update-server-info.c
@@ -20,8 +20,8 @@ int cmd_update_server_info(int argc,
 		OPT_END()
 	};
 
-	if (repo)
-		repo_config(repo, git_default_config, NULL);
+	repo_config(repo, git_default_config, NULL);
+
 	argc = parse_options(argc, argv, prefix, options,
 			     update_server_info_usage, 0);
 	if (argc > 0)
diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
index dbd8cd6906..6824581317 100755
--- a/t/t1517-outside-repo.sh
+++ b/t/t1517-outside-repo.sh
@@ -107,4 +107,11 @@ test_expect_success LIBCURL 'remote-http outside repository' '
 	test_grep "^error: remote-curl" actual
 '
 
+test_expect_success 'update-server-info does not crash with -h' '
+	test_expect_code 129 git update-server-info -h >usage &&
+	test_grep "[Uu]sage: git update-server-info " usage &&
+	test_expect_code 129 nongit git update-server-info -h >usage &&
+	test_grep "[Uu]sage: git update-server-info " usage
+'
+
 test_done
-- 
2.49.0

