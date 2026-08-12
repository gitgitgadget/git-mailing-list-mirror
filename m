Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE233594A
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 06:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786516961; cv=none; b=s2DdNbFuw1sVRr2bEG0lDjG82gDhEGKYhePkmGtJlUrFTvcM1RmOWY+5SDr13JyXmK/qdnwameOVICR7mggPwvwL+upTMhD0fPB8RkQ5JqiPBrjcwLa5+9zOMdZJpH+CLgHwkRFIxgUB52KrAKCc2PoHS1WV4GgKgM12FGpmHm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786516961; c=relaxed/simple;
	bh=YZnhFKL4LqA0pDv6QHKj+IyDLNliBLS349NgSpoF+UA=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=ZltY9DbnofcX4s7x8xnSj9FBz7Qt36iB6Tn9KVya5AYH/Fp1+m5ZhdGTgj/7bvyIzGxa8A7TN1GRAq6ckTA7zVX4QqHrbsPfERmgGmtzUC6SHzediDuOfs5s11KYTt2oKBY7K9qLQu0fRYAhkBcfOgQUKOaOEB3JBCYL9rJmC5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YC1pMXAy; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YC1pMXAy"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38dfe910e9dso722076a91.3
        for <git@vger.kernel.org>; Tue, 11 Aug 2026 23:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786516959; x=1787121759; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zTNpjTmEPW63uRayPKP0DFNBhhtdhiDAjCUp35ubvZ4=;
        b=YC1pMXAyu2IgnYgO19uFnAJ8mE45GZOrMZSV75NZ/F+/axqxHaZHgPdQmA7PCZa9CR
         aOLW6F7yWSIJqawz8ERwSDGZJeX64iRj3uOZHELXuYcxfk7/hj4x14ASl6ipQ8CUxVGi
         YOtomYjHnH4UEH2+4u3shV1Nn5j9SmcuB+eg24pPFpz7OjLGz3F+E69RdT1mdX4UTcJ+
         u7aKkuFebLEmj/GR8BaNHGHrpMyMzeUg/K0ExznBCVTepVmb5tn3ekRFk1+Aw16RyjVu
         pWRyAuyiCgJWZx/tzeU/h4qGWOyjdikJWU1scic6xHy/eVdCFqbN4pn1IIeEn4rWKd5H
         L0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786516959; x=1787121759;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zTNpjTmEPW63uRayPKP0DFNBhhtdhiDAjCUp35ubvZ4=;
        b=cY2qkOZx11cmHjxGxwwoAnZNftyyxXRjlIpJQKWk8hARn904QZlyhdIL62dsnFJ7ES
         usq9zwJ6rJOa/eb86npIlyDhf4hUM/9P3MBrCSXz8UufZM/6v6xREIPYhlv5rfcsQ/uo
         rpBfifAqJ7a9iREvdVWpxZM8VbfWA+Bf983jGkLJLcnKktbG+Q2ra4J7JGuIJjtwUS9x
         c4FcZZmlHD/bWOCljKUbI7zL7Ruxmv5bnrGnTsuhOuDkc0CpYcjrItseaWWliwyJ15mv
         XXu5X5uAcoh2aDAgYCbYTb4ATBULLa9AQH1V8fb8XZ0p89OdX6rXmexK9gNki0XYD/A9
         kMkA==
X-Gm-Message-State: AOJu0YxDQeKBT5b4AXJtxYBMf6KSlJeA6SfrMtd+Pas+BF2cIeHWQZNK
	GTJXVP9CCL61iyxUICxmOa+qnosEtjx7YCgMe3hy0GJb+Q6eeyHCaWa7X4vd7g==
X-Gm-Gg: AR+sD127PwJlXPGu08/nehDt91XBSd9ZwFvetWWJqFsrx85DrWKUb56G1UfqG8IeQ5B
	oOFbwpWTfi8WEvKhecgDiKDOng8IBem2MIBVpRUmLB3bfHLq/wfYrmMyqeP6ZMmTWlgeTa6xbw9
	8/EI5NDRp7wVLYW9bjB7XNedJyiohpROhXiVvym4Ifh8JPJw322XyLXWTOW03KMye2b1FsZjJWv
	G0cLFxpdPNC6LeyCkXGHYI5JwtijdRDHCtUDvcW1njexLNvnB/MXNMokeu/V8Dhw3XXotIjMqUF
	JKN4cW6tcemqVEsbJ5qK0ic4vTmbDICKXi5XVbnL+b8WyhOro//Tok7dkuEsr8i2RYf9CUuRp4c
	g8luSOA5lAji5YdeiX7rjo7dfXGFV4uM6qG7a6a7Myp7ZwIM+IRFUp8qxSVWkPn7j7HuHAnmZ0P
	HBtf9rh4H+QEYFnZoNxx40FZ/Fi+eYcD8nW2tGOvsCpvsZffmV1p62LawgkggcsQ==
X-Received: by 2002:a17:90b:5112:b0:38e:9e9d:9209 with SMTP id 98e67ed59e1d1-3930144caa2mr3342545a91.17.1786516959445;
        Tue, 11 Aug 2026 23:42:39 -0700 (PDT)
Received: from [127.0.0.1] ([20.189.186.1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392f94ad832sm2260820a91.9.2026.08.11.23.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 23:42:38 -0700 (PDT)
Message-Id: <pull.2035.git.1786516958048.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 12 Aug 2026 06:42:37 +0000
Subject: [PATCH] diff: avoid misleading statement about -l option
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
Cc: Elijah Newren <newren@github.com>,
    Elijah Newren <newren@github.com>

From: Elijah Newren <newren@github.com>

In commit 6623a528e00b (doc: clarify documentation for rename/copy
limits, 2021-07-15), the wording around rename limit options and config
variables were updated to point out that only the quadratic portion of
rename detection (or "exhaustive portion of rename/copy detection" as
used in that commit) was limited by these options, because exact rename
detection and basename-guided rename detection (which both run in time
linear in the number of files) still run before this limit is checked.

However, the short help message wasn't updated at the time; update it
too.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
    diff: avoid misleading statement about -l option

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2035%2Fnewren%2Fdiff-l-option-doc-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2035/newren/diff-l-option-doc-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2035

 diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index a68ddd2168..0aa910a2c0 100644
--- a/diff.c
+++ b/diff.c
@@ -5871,7 +5871,7 @@ struct option *add_diff_options(const struct option *opts,
 			       N_("continue listing the history of a file beyond renames"),
 			       PARSE_OPT_NOARG, diff_opt_follow),
 		OPT_INTEGER('l', NULL, &options->rename_limit,
-			    N_("prevent rename/copy detection if the number of rename/copy targets exceeds given limit")),
+			    N_("prevent exhaustive portion of rename/copy detection if the number of rename/copy targets exceeds given limit")),
 
 		OPT_GROUP(N_("Diff algorithm options")),
 		OPT_CALLBACK_F(0, "minimal", options, NULL,

base-commit: 7264e61d87e58b9d0f5e6424c47c11e9657dfb75
-- 
gitgitgadget
