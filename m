Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3F122E3E7
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 20:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739997241; cv=none; b=fTcs2ctab3cWwuo15ExrDsOWXRgSZ8rYIgvS5WAWfBCX0sALcNEUAL3vzzv2F27ssQnd236zNRu/gxPMdcVf4yO+9lD2fZonAGOmiU7W6qLbIiGYYUNjTbZwtqwBjKN9Axw6tvmH1nFSCY+EhxaCLpzNxmSmhx5jypMlF0m1SuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739997241; c=relaxed/simple;
	bh=lmdrQ9vTlj4xW56z4iL7G8Rk96J8eay6EKznetfTDc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AARNvLol999MHVmkeafh/iJJbVHZQCPTfUqaoiCFcH2hRvP1odpvfV0+tXR3FnXB58/XFwAzMGgieBJvA81RD1SdnhX5bXXE2pB3F5hNZ051fRW9Qk8+RycxGj3PzX7GzXKWj6ogBptvnlzGtQlCy7mceu6jVsjuA5Uk7no9k5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DP9tgkl2; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DP9tgkl2"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-220e6028214so3391405ad.0
        for <git@vger.kernel.org>; Wed, 19 Feb 2025 12:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739997239; x=1740602039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dU7o73/CRtObgslu50QcCkFZIY8xHmANhFXdxqsNHXY=;
        b=DP9tgkl2ApYTKdrCLa9f/YX/ycgwoTHGAk+ZVaAcf6Ahjttr76HazOVmceVA+MQz7V
         q7wDHDaCFkMTH1m37WfK0obyvhmg217junLq+YUskn855SJ4NTvJ2Lmy0AuSqFVYneEi
         qU39fjTyKzK+61aRiYqigUt5/5EX3mvr8z2dxE6fJMuvV4K/jEcC4n6q7FzMaiZ/BsoV
         2m+4fyBEqx1AOiz1yMxVMwtTJNNMClD4tLA13UQ5Uc0PNFslX2KW+0mVKmIsZYu2EiSE
         tzKm/vmuvDQvA+6Ybeu/wLzFgVflLYh41NsoS5jRLsJVT3jb1gToMOSnaW0UdJ1X0KHi
         JvHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739997239; x=1740602039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dU7o73/CRtObgslu50QcCkFZIY8xHmANhFXdxqsNHXY=;
        b=Fio+hYkRj9oVK9B1e+4TKkB6OOD41pmPoUhP8f0CAYP3L6aYGFQbQMpTnkQ3iD2PXf
         zE/lJgJ/jn9l9Ytf9n/zg2KdCb2aOinSYc3B2gwE2pTz3Rjq2OFBeVxjeimAON+l7EU5
         cRaiqMBJDPrCdZ5emHEWQ9CMJxRCbcYfEL5fZqeBghpzTSoU1odfy5mmW8GQOLPuCY4v
         PCcUyu53ke7P9jY6WY6YUUNe7PoAIt1sLRoYmE/ngPuJYoGKMwbw48Ztv6iZWzKdNVFB
         vBJeqCxVqjxeNp6IwCzUAXdTZcdsvpjlT8mSPS2lt0oUysxMnI1OeyGlRk3uYtodNTA+
         GyzA==
X-Forwarded-Encrypted: i=1; AJvYcCUY2oCeiC5KYtI6i83cNBT/tPpbHvdCz4V4BQ5Y8qSAsLe2u6jl6pAOoqBY2pXo7A7E4r4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6Gok4U+ZGSlU5L3fpTWJm4ndicXbJTznkH9WOo1h9I4IFyHI2
	Xe7UjiqlV/gFokpHiIM0vYwh3RmLyRw5VHJi13C5G+RbWTmRrpMd
X-Gm-Gg: ASbGnctCGylpsMc66qsoN5cTQj4zaVuhCJlzFiifF6uRBhxGEsE2mJ2T03+cirSEqIB
	SRniWxyJOtpDcv5O9OvoceCs2cW/vF854zraRe3DKNjk1J9MyibZCU54UTmy3I41x0dMGH+rS1B
	uEz6jREeDBCStrobd3lekFZcLp7DM6gdBwPv31lZwCH9hI85ETRlo2qMlX6HdCw+zM3lqoFKGHP
	pyscbF7rNOlauIjBRCLgUn6ootsSEY4R34WyvrO8h0eftHY0r76MbhC3d0ic4eepIY9FSLQglmR
	aRbUznyJRxXNlAzUTIyb86gjzHdG2v/3PgDvTJIU
X-Google-Smtp-Source: AGHT+IF2avUkQPwRnqEFUn2LAJPzsuaZ7CWvkQvRmyXQT4zA76YeCNnBLF4Z6ffk5osLboicAxwdTw==
X-Received: by 2002:a17:903:41c3:b0:220:eade:d77e with SMTP id d9443c01a7336-221040a8e2cmr328796965ad.40.1739997239107;
        Wed, 19 Feb 2025 12:33:59 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([202.164.41.66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d53499dasm107791355ad.12.2025.02.19.12.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 12:33:58 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: gitster@pobox.com,
	christian.couder@gmail.com,
	git@vger.kernel.org
Cc: me@ttaylorr.com,
	chriscool@tuxfamily.org,
	johncai86@gmail.com,
	ps@pks.im,
	shejialuo@gmail.com
Subject: [PATCH v2 01/12] builtin/verify-tag: refactor `cmd_verify_tag()`
Date: Thu, 20 Feb 2025 02:02:49 +0530
Message-ID: <20250219203349.787173-2-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219203349.787173-1-usmanakinyemi202@gmail.com>
References: <20250214230210.1460111-1-usmanakinyemi202@gmail.com>
 <20250219203349.787173-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move `git_config()` call after `usage_with_options()` to avoid NULL `repo`
check.

When "-h" is passed to builtins using the RUN_SETUP macro, `repo` passed
by `run_builtin()` will be NULL. If we use the `repo` instead of the
global `the_repository` variable. We will have to switch from `git_config()`
to `repo_config()` which takes in `repo`. We must check for NULL `repo`
if `repo_config()` comes before `usage_with_options()`. Moving `git_config()`
after `usage_with_options()` eliminates this need, as `usage_with_options()`
exit before calling `repo_config()`.

This will be useful in the following patch which remove `the_repository`
global variable in favor of the `repo` passed by `run_builtin()`.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 builtin/verify-tag.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index f6b97048a5..f0e7c2a2b5 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -35,8 +35,6 @@ int cmd_verify_tag(int argc,
 		OPT_END()
 	};
 
-	git_config(git_default_config, NULL);
-
 	argc = parse_options(argc, argv, prefix, verify_tag_options,
 			     verify_tag_usage, PARSE_OPT_KEEP_ARGV0);
 	if (argc <= i)
@@ -52,6 +50,8 @@ int cmd_verify_tag(int argc,
 		flags |= GPG_VERIFY_OMIT_STATUS;
 	}
 
+	git_config(git_default_config, NULL);
+
 	while (i < argc) {
 		struct object_id oid;
 		const char *name = argv[i++];
-- 
2.48.1

