Received: from mail-qv2-f42.google.com (mail-qv2-f42.google.com [74.125.230.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0BE293458
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 07:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790927403; cv=none; b=Ymu3d1xcpv7JHsoqaYkYZrZ6kQEwsnhnEFNbjIB39oueBuqmZ6Qzi3r9CVxuNl8Dza7QuZ4U7emU8rDaCjJThHhnXvk0g5J/rNUehRg4xTLzAmeIY2z0g7QfHVt3JVvrFrd7XFs3ffeJjrlFXbi4GR5JYFE3gY1icmHvVeghp6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790927403; c=relaxed/simple;
	bh=6VwNn028JFBk9xWl9N03rmbQZwBx7mCxSj4uDyUakmQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=mdS9paeDkjNl49DOXlsvjptXdqyqDiEW9sU2TLlVlDzwvxpLpz45FHB9/twXLNQ/R9KYYHIX+xBXPuhzFevJ8bgnWXBhyTNBoLcCnYnn+iLfgE+CKhoE1HoaerqJDsaKHPAIMFHcdFUJ4KyPtlytqtZ2n3p5a0zJU2ATegZhla0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ReqZblTq; arc=none smtp.client-ip=74.125.230.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ReqZblTq"
Received: by mail-qv2-f42.google.com with SMTP id 6a1803df08f44-917bef0d531so10533316d6.3
        for <git@vger.kernel.org>; Fri, 02 Oct 2026 00:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790927401; x=1791532201; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8KOFSAQr72vMVo64x5L4r6gluGnRxJOinezIPjkYrLA=;
        b=ReqZblTqihvTeOG9S4TQvWIqQKlm8CHU0Dwo6HNbtTf5kAVl//7RZaIusuaGn2L4xL
         u841Jz3kEK39u55Y279RKdi3moYUOXFONcW/twTBMTsKkXo5xnMO2XsAGJcjq15dA1sj
         9hqDqm5yfmuqha1PbgrkxcIqgcRKOqeWbQXx+oMNhEGDvxzy3eHsVIqqQDXj+UkG2mdL
         TkAKcz/gF/+dOetr70hu7qRjPGo6SpG4n9hQbzJVG1dzAGVMwmCszrs4w/8iVJ4s9ab9
         2lE4MK/f7sWwrN1mtsaWTy+napMJ3t/64nXfexnNo4uECHP3aUfVRl0r5tWpUiQ7RSE8
         mNVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790927401; x=1791532201;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8KOFSAQr72vMVo64x5L4r6gluGnRxJOinezIPjkYrLA=;
        b=fBprwRBlhYPEcku4rovvVW8+SSR4290lwYbc+TpSYrbZ5SDSKzHJm2hD9Cmz2ygvp+
         3PRHH5Hgbj83S6lBO00LJCW4uW6SxYe0yBZ4NXd/sMHTWd490BXoWucSZOhuLJWhXeZK
         BB5ERA+ieouE2qjO3lPe0Lz74oBOUiIj4HrvGB3LKExNR0rpfMbvpraExIHttfEmZvzM
         DDTI9m1P4RHKBK2dXCLij/cZfXfD8vbkLbmhVGwQz5gFjTZlg4ZnZPjeOdwmJ9dd7ZP7
         KQplOtYCIQenTbVVPILhsXdkP6JZ4/Zc6j92dvKw8rKEobqjbeqthVitGkv+3EOuo6k3
         MFhQ==
X-Gm-Message-State: AFuF++kRq8Ya45K3eOFjQ/x7R4q8gSMDpWvNfDQ62L4J1ttg8kjOy940
	DsOx4xAgAU0rXeKKPz+y8lam/TsmOZnowMzqk80cmwK6bV7SK6r/OWjD+HaC0A==
X-Gm-Gg: AYBFou1SgvLB/lvwW9s5r4u2/1PDwpq6yK2xRKb7eyfInPkEXAU9B5AUa0C757ZS9b0
	OAMyhf27YgjcSHOaYNIPUC2+74XT6vEl1w7Ek0uZIV+SchWHYb/OenfFteBQOeCMCFDE6nRdooD
	5JGKlctQNIBrLtZjHdM5SfssI7liN9KyflqIMrbMubkmgxO8KKe8a23+N8X/K/8mSkX0Cjrha5N
	D3l0kNhUv15k9kfffjPm2xrjtR9HNcjOBJTbuA3tb268VRf5MomB/wmfLSCK1gR+Wjm8Gf28qXd
	u44VyRBYif3nm5DzjgrvAlFUEnzPxIV+O0VnA34ymD27r1iGX4k1QPxqR7vw6c+t1SjUxfkJ3bU
	iqDQnWnYjbxuLugGc/RZ/pVZqmOROxqjjUfTvN7GTHkRi1kpknxV6nYPg9AoNQdFBMPujy7Qypm
	XqbS6oWBwQDVf1AHb734uG6xP5KamF14vxl+EiJWk9G4eivpQL0bINxnEn1+rL10ttAL7F0ixkl
	fg=
X-Received: by 2002:a05:6214:2242:b0:914:4eff:e88e with SMTP id 6a1803df08f44-917c01ba3bamr36551576d6.41.1790927400890;
        Fri, 02 Oct 2026 00:50:00 -0700 (PDT)
Received: from [127.0.0.1] ([74.235.143.215])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-917e0bcf9f5sm13796156d6.32.2026.10.02.00.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 00:50:00 -0700 (PDT)
Message-Id: <pull.2431.v2.git.git.1790927399813.gitgitgadget@gmail.com>
In-Reply-To: <pull.2431.git.git.1790797186658.gitgitgadget@gmail.com>
References: <pull.2431.git.git.1790797186658.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 02 Oct 2026 07:49:59 +0000
Subject: [PATCH v2] object-name: accept @{p} as short for @{push}
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
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Jeff King <peff@peff.net>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

"git log @{p}" fails with "unknown revision", even though "@{u}"
works for "@{upstream}".

The "@{upstream}" notation came with its "@{u}" short form from the
very beginning in 28fb84382b (Introduce <branch>@{upstream} notation,
2009-09-10). When "@{push}" was added in adfe5d0434 (sha1_name:
implement @{push} shorthand, 2015-05-21), "@{p}" was held back to
avoid confusion with a proposed "@{publish}" and talk of an "@{pull}".
Neither of those was ever added.

Add the missing "@{p}" for symmetry with "@{u}".

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
    object-name: accept @{p} as short for @{push}
    
    @{u} works as the short form of @{upstream}, but @{p} fails with
    "unknown revision". This makes @{p} resolve to the same branch as
    @{push}, in any case, and documents it next to @{u}.
    
    Changes in v2:
    
     * Commit message explains history.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2431%2FHaraldNordgren%2Fpush-shorthand-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2431/HaraldNordgren/push-shorthand-v2
Pull-Request: https://github.com/git/git/pull/2431

Range-diff vs v1:

 1:  f772f79954 ! 1:  1097f119a3 object-name: accept @{p} as short for @{push}
     @@ Metadata
       ## Commit message ##
          object-name: accept @{p} as short for @{push}
      
     -    Typing "git log @{p}.." fails with "unknown revision", even though
     -    "@{u}" works as the short form of "@{upstream}". Users who reach for
     -    the one letter spelling of the push destination by analogy get an
     -    error.
     +    "git log @{p}" fails with "unknown revision", even though "@{u}"
     +    works for "@{upstream}".
      
     -    Accept "@{p}" wherever "@{push}" is accepted, in any case, just like
     -    "@{u}".
     +    The "@{upstream}" notation came with its "@{u}" short form from the
     +    very beginning in 28fb84382b (Introduce <branch>@{upstream} notation,
     +    2009-09-10). When "@{push}" was added in adfe5d0434 (sha1_name:
     +    implement @{push} shorthand, 2015-05-21), "@{p}" was held back to
     +    avoid confusion with a proposed "@{publish}" and talk of an "@{pull}".
     +    Neither of those was ever added.
     +
     +    Add the missing "@{p}" for symmetry with "@{u}".
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      


 Documentation/revisions.adoc | 2 +-
 object-name.c                | 2 +-
 t/t1514-rev-parse-push.sh    | 7 +++++++
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/revisions.adoc b/Documentation/revisions.adoc
index 3fbfbd3d5f..68ce6f3dc2 100644
--- a/Documentation/revisions.adoc
+++ b/Documentation/revisions.adoc
@@ -122,7 +122,7 @@ some output processing may assume ref names in UTF-8.
   `branch.<name>.remote`). B@{u} refers to the remote-tracking branch for
   the branch X taken from remote R, typically found at `refs/remotes/R/X`.
 
-'[<branchname>]@\{push\}', e.g. 'master@\{push\}', '@\{push\}'::
+'[<branchname>]@\{push\}', e.g. 'master@\{push\}', '@\{p\}'::
   The suffix '@\{push}' reports the branch "where we would push to" if
   `git push` were run while `branchname` was checked out (or the current
   `HEAD` if no branchname is specified). Like for '@\{upstream\}', we report
diff --git a/object-name.c b/object-name.c
index 4eda8c8eac..6546685760 100644
--- a/object-name.c
+++ b/object-name.c
@@ -657,7 +657,7 @@ static inline int upstream_mark(const char *string, int len)
 
 static inline int push_mark(const char *string, int len)
 {
-	const char *suffix[] = { "@{push}" };
+	const char *suffix[] = { "@{push}", "@{p}" };
 	return at_mark(string, len, suffix, ARRAY_SIZE(suffix));
 }
 
diff --git a/t/t1514-rev-parse-push.sh b/t/t1514-rev-parse-push.sh
index d868a08110..5a4f16867a 100755
--- a/t/t1514-rev-parse-push.sh
+++ b/t/t1514-rev-parse-push.sh
@@ -60,6 +60,13 @@ test_expect_success '@{push} with pushremote defined' '
 	resolve topic@{push} refs/remotes/other/topic
 '
 
+test_expect_success '@{p} is short for @{push}' '
+	test_config push.default current &&
+	test_config branch.topic.pushremote other &&
+	resolve topic@{p} refs/remotes/other/topic &&
+	resolve topic@{P} refs/remotes/other/topic
+'
+
 test_expect_success '@{push} with push refspecs' '
 	test_config push.default nothing &&
 	test_config remote.origin.push refs/heads/*:refs/heads/magic/* &&

base-commit: a018953688f1b10bddf91bff8747068f5f4746a4
-- 
gitgitgadget
