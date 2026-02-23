Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579E5343203
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 08:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771836983; cv=none; b=c4y/PyjO35ayEZm3SayW83MfjgrNKLrPtkM14S4XDm4umGS0qIqLT4nNowb8phKB4MLBMMkuD90gZfQ4aVyKivJUheZ4ety6M1L89kMsIArBkkdNFIwoO/Ou/3mXMDos9Jpbm/BAGJYC+28BgF+M5iLnrgfKR+A/EfDGzZ/jwRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771836983; c=relaxed/simple;
	bh=mz+mWwIS8IxWWjpGWnPw8aUakSGI6hk7e74LRtq22Pk=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=kDTZRHTTq0ghS3Kz5M1ICNWrFrwR22iUQFWbBmyEkDgxIh+lU+MfdcTeo2JcrykOUf6JeFn/5jewdGWnyiBb0C7AyNGNKYSMkk4qg/ZMMYTpnhHoxhpN/wFSD/Rb7s1iXtTulT2gAZr/9uMnTFDq3HdULVXflxOuju/O+pCVN0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jih59F1l; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jih59F1l"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-50334dd44d2so50538431cf.1
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 00:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771836980; x=1772441780; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JbC8orVLJP0WLE2r7ZamYDKq4ciz8x98E2J365Tco2Q=;
        b=jih59F1lIhL9JF0jfT269Ddh08YaULF8yVJ2CXSDcP0JW/5zXn2SpgPBxpA7OEY1cm
         ovZbZm28XzwTPB0GLB2Jy9OhVUGqUhf13Ud5o6IyWToib4tRs0bQxLo8EORoKdUaQAc6
         e7S01NWw9mDYztp/LItWxyBY7ARs1cbeGLrO/CTyh65ZAX9tnd58sgyfDyEUdInZWlJ5
         TMNnDvAJRgiU49z4fW3SOefoeBpldVGfjJt+W78ekBchCcVv4vsM4ZS9RboKxFUPfUdv
         G/bQTVgUnZomk+lbRY3OmOFzsihdF+jum7JapGYWcyJlrvYnMKBvdVqTRkn8G/CL1V19
         YLng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771836980; x=1772441780;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JbC8orVLJP0WLE2r7ZamYDKq4ciz8x98E2J365Tco2Q=;
        b=TaZpbPxQ6cQeuegDWBD659/eN61WJsfyEDyQ88BX1u05IDtacOPQ3sftn5IlySIevw
         zB+D+gKZOhjnVpv/cynh4EW+vWN4cs6PvlBwK+HAsPemZDjAcbabfvj45kXgJ4psdeP6
         x12IWu+kuED28nWSM51g6EDbDCv0j6lWaFh8wSM4MIDR5Syiozd8IimtIILsNOoDuvrR
         H4qpbW1S2Kiey060skdnMExVxX1x/MIKSm4GUCWeeaONsHmpVs73TtPeGTkW4bjFOGnF
         0fDkr+9+RwpVJi1oxYXXITpF7sFpBV2CZ/JkZFe6CrJgGZAgk+XVnCAYo665kptrKs08
         DIxw==
X-Gm-Message-State: AOJu0Yw4J2VsOOsDL+YyWigS+jCfgy3w3vnaIyyk+SpM2CXD8+GqjxxS
	NUvq8i/P+R7cDHc9OOB3YdcmH82UWYDK93xleQLPYXlrZYRo4xqxLWeXBBgsxQ==
X-Gm-Gg: AZuq6aLcc9I19RC8m4zzOjgQIaMKW4jqkRim6kvrZITCcRJ/UP1xPzmw9Xl50mjdR3q
	FfMeyrguRGeSvOk/AybWfwKVW2/beluVxq26LB7Nbo+RmB/Um7LGFJpRPcroO4Y8oTvmcgAlgUJ
	J+JGoyItWDqbdOmF7Eku6NNBt60AJhiE6kYWd8iAs1ZXaW8RyjA3e0MyPLrbKsmEhZ3UQDaYD8x
	1OFmFcTeQ8A7FNUkFFkjoyTNICWAqDYekRYSu4ERACiyMgirpvKFNWODRCPWONFONXbWkSwGDIz
	CofvyE6Dz/HTNPtevLxdlkPYrdNrqWFZE6anFbLQqPQkDCTlYjSWGUkW/gG4zr6WKvnzj0mMuRo
	RXyOHcetrumj2jDGiwCA0ZlJn1v++RGm3Iuu37dk+oxnqqCPwyjHX0n8aiIsuMHQGbObP/1NqrS
	CbDYagQbM983OS6mVd2VnGGIqEEWk=
X-Received: by 2002:ac8:5906:0:b0:4ee:2352:1bb1 with SMTP id d75a77b69052e-5070bba117emr110235751cf.5.1771836980530;
        Mon, 23 Feb 2026 00:56:20 -0800 (PST)
Received: from [127.0.0.1] ([135.232.177.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8997e7747f0sm63327326d6.51.2026.02.23.00.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 00:56:19 -0800 (PST)
Message-Id: <pull.2053.git.1771836979176.gitgitgadget@gmail.com>
From: "Md Ferdous Alam via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 23 Feb 2026 08:56:19 +0000
Subject: [PATCH] merge-base, ls-remote, ls-tree: fix error message formatting
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
Cc: Md Ferdous Alam <mdferdousalam1989@yahoo.com>,
    mdferdousalam <mdferdousalam1989@yahoo.com>

From: mdferdousalam <mdferdousalam1989@yahoo.com>

The CodingGuidelines state that error messages should not begin
with a capital letter and should not end with a full stop.  Fix
the die() messages in builtin/merge-base.c, builtin/ls-remote.c,
and builtin/ls-tree.c that violate these rules.

Signed-off-by: mdferdousalam <mdferdousalam1989@yahoo.com>
---
    merge-base, ls-remote, ls-tree: fix error message formatting

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2053%2Fmdferdousalam%2Ffix-error-messages-misc-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2053/mdferdousalam/fix-error-messages-misc-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2053

 builtin/ls-remote.c  | 2 +-
 builtin/ls-tree.c    | 2 +-
 builtin/merge-base.c | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index fe77829557..51d7579ca1 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -128,7 +128,7 @@ int cmd_ls_remote(int argc,
 	if (!remote) {
 		if (dest)
 			die("bad repository '%s'", dest);
-		die("No remote configured to list refs from.");
+		die("no remote configured to list refs from");
 	}
 
 	if (get_url) {
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 113e4a960d..7670aa77a3 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -406,7 +406,7 @@ int cmd_ls_tree(int argc,
 		usage_with_options(ls_tree_usage, ls_tree_options);
 	if (repo_get_oid_with_flags(the_repository, argv[0], &oid,
 				    GET_OID_HASH_ANY))
-		die("Not a valid object name %s", argv[0]);
+		die("not a valid object name %s", argv[0]);
 
 	/*
 	 * show_recursive() rolls its own matching code and is
diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index c7ee97fa6a..e337f283f7 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -47,10 +47,10 @@ static struct commit *get_commit_reference(const char *arg)
 	struct commit *r;
 
 	if (repo_get_oid(the_repository, arg, &revkey))
-		die("Not a valid object name %s", arg);
+		die("not a valid object name %s", arg);
 	r = lookup_commit_reference(the_repository, &revkey);
 	if (!r)
-		die("Not a valid commit name %s", arg);
+		die("not a valid commit name %s", arg);
 
 	return r;
 }
@@ -131,7 +131,7 @@ static int handle_fork_point(int argc, const char **argv)
 
 	commitname = (argc == 2) ? argv[1] : "HEAD";
 	if (repo_get_oid(the_repository, commitname, &oid))
-		die("Not a valid object name: '%s'", commitname);
+		die("not a valid object name: '%s'", commitname);
 
 	derived = lookup_commit_reference(the_repository, &oid);
 

base-commit: 7c02d39fc2ed2702223c7674f73150d9a7e61ba4
-- 
gitgitgadget
