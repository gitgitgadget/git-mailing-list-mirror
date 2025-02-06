Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D8F1FE45E
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 05:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738821422; cv=none; b=lhxbSxhEjYwdYmmkgg3fu7QUGtVNR2kqQNn2ZxhdBW++gkvAiJLTsZL1cvdo6VLhcYXqwnpddxn66LRws5hj62gBp7+72854fmBBlHZt4o/gLXFkN1i/J3ovOo/A7Oq6RaPZ4yNdGbLM2dC+vb4RoNDcCKasAevtEm6MX9Pb4tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738821422; c=relaxed/simple;
	bh=Pw3z9o+kUxJpZxKRgSvXpacK5lCJj5GH/n7+SaPqQLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rYRPwHnRpsVwUCvnPay27RUVX81cNw121t2rl4Jbcpu56rKjtFukTLwePzhhQXRWZukICAEYki+3mgNgqiqAZy31DxiPo9rPlAS3Dqjl2GS9xDMQchnWgS+fdYMGHvCWymwo54aQmpJMWxKsKkySwZqI2LznzkMM+7aNUu6ko1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QkvqcNyj; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QkvqcNyj"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21f2cfd821eso9462775ad.3
        for <git@vger.kernel.org>; Wed, 05 Feb 2025 21:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738821420; x=1739426220; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h1Qe1T9rOx9zjzY4gdVYk5gvUXaPpIeOaRjiZtE7aaY=;
        b=QkvqcNyjge13T+en5ah0BWdJ8W0KN/lhwLh4hKwQd+RKYpVgJr2HIWBbu5sWH6nxiG
         rOgttBtOGVzBZdSpK8YCzc9knJ++1e571oT37LBHK+8FLRysh9SLmQtFujePdnKtcU86
         lquMeg3ceUAo0lX5izUBLSIuMcMnUECy85UJOEPudH0FMkWOZhd4Ek0KK0j/I9B5rWvQ
         yB2sckeIrQx5R/tFRF4v7Y7CGb8d21b+YGRL8wOf57hDRJY6K2BhoHyGooO11ohZ6iS9
         d9RKUZIIzZixk+xiNM7aZ2tMffU4EkGO7jCtBjvWFSxrg0crCscZ8+DKg6xf2uqJzlAm
         TsDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738821420; x=1739426220;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h1Qe1T9rOx9zjzY4gdVYk5gvUXaPpIeOaRjiZtE7aaY=;
        b=QyzD/tmw+RmUeuf4Ffv2pVRSR1k0I81hnOMDt4moWDebtMpFdyL/j8BvJ3syF4rjdz
         gHKGD8pLoO9pDNNbLto1DAs+vpqqZJal4aC2a+WxINGsfSrsQ8jg3YZl5jmj14xmVdu9
         0lt7RN3Eze27ZFON8rEICTF5xFr0vmbr1lBKtyUIpzKgu8vV/5feYiy0Kwp3xz3uOoe9
         KsFIQSwdJUZw5hcLfEBbSwsr+3rlTz1IiPJC4nC1yuQoeW04gX8FkgWo6KwSDXMliBXg
         g7Je++bBv0ROoTfBQHBFUwbOM4Hf4Vneu+tERAOS2LselSRmzkdo/P1m31kea+ZW2J3j
         m3fw==
X-Gm-Message-State: AOJu0Yw0cxSe0sSlF969sMz2bmPNDpiX3u1gQuXSh4PWzJmCgFje87Pp
	G4OP1x6s61YjWF2ItWtGRFSec0CguZJTwDcUJAvQ/FiWy426Uhr1ujd0Bw==
X-Gm-Gg: ASbGncurmomIbk3kC+/Nf6kuxZIQxIHQfn7lskGUW/JtkGXu68ejGcSDamV1StoJIc3
	4gZRrPyN1SpVo5fw3jYqPTKHuiCESU+ZwSHBtrLlJN1rOy4uY+qQKuLE2jRKqgC1fMa07jZVWjd
	6QrlEO/vi+2VhuOb0neQi/kkzSlIqC2Cn7iA3D7H6VzxMYoTst6tIjdvdUZU49OYSHGOpzyhVHN
	5YScngPROX6lNR0peqL+Y0DHqM5lesXZIQLecDs+b92PjD+rqzM2TRlezh1SEOtdsOYkA==
X-Google-Smtp-Source: AGHT+IEaFU+Jmz36bu8ry0xKsTEzI7sY3x6K3wx2TZqNT+etA+j1u0HIk6VUeAdlx+nuZIcUzTX0nA==
X-Received: by 2002:a17:902:cf12:b0:216:386e:dbf with SMTP id d9443c01a7336-21f17e4617bmr95815395ad.20.1738821419754;
        Wed, 05 Feb 2025 21:56:59 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21f3683d7c2sm3868705ad.158.2025.02.05.21.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 21:56:59 -0800 (PST)
Date: Thu, 6 Feb 2025 13:58:41 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 2/8] builtin/refs: get worktrees without reading head
 information
Message-ID: <Z6RPkTOZOvBiLlaV@ArchLinux>
References: <Z6RPJI10-2QkwyqH@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6RPJI10-2QkwyqH@ArchLinux>

In "packed-backend.c", there are some functions such as "create_snapshot"
and "next_record" which would check the correctness of the content of
the "packed-ref" file. When anything is bad, the program will die.

It may seem that we have nothing relevant to above feature, because we
are going to read and parse the raw "packed-ref" file without creating
the snapshot and using the ref iterator to check the consistency.

However, when using "get_worktrees" in "builtin/refs", we would parse
the "HEAD" information. If the referent of the "HEAD" is inside the
"packed-ref", we will call "create_snapshot" function to parse the
"packed-ref" to get the information. No matter whether the entry of
"HEAD" in "packed-ref" is correct, "create_snapshot" would call
"verify_buffer_safe" to check whether there is a newline in the last
line of the file. If not, the program will die.

Although this behavior has no harm for the program, it will
short-circuit the program. When the users execute "git refs verify" or
"git fsck", we should avoid reading the head information, which may
execute the read operation in packed backend with stricter checks to die
the program. Instead, we should continue to check other parts of the
"packed-refs" file completely.

Fortunately, in 465a22b338 (worktree: skip reading HEAD when repairing
worktrees, 2023-12-29), we have introduced a function
"get_worktrees_internal" which allows us to get worktrees without
reading head information.

Create a new exposed function "get_worktrees_without_reading_head", then
replace the "get_worktrees" in "builtin/refs" with the new created
function.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 builtin/refs.c | 2 +-
 worktree.c     | 5 +++++
 worktree.h     | 6 ++++++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/builtin/refs.c b/builtin/refs.c
index a29f195834..55ff5dae11 100644
--- a/builtin/refs.c
+++ b/builtin/refs.c
@@ -88,7 +88,7 @@ static int cmd_refs_verify(int argc, const char **argv, const char *prefix,
 	git_config(git_fsck_config, &fsck_refs_options);
 	prepare_repo_settings(the_repository);
 
-	worktrees = get_worktrees();
+	worktrees = get_worktrees_without_reading_head();
 	for (size_t i = 0; worktrees[i]; i++)
 		ret |= refs_fsck(get_worktree_ref_store(worktrees[i]),
 				 &fsck_refs_options, worktrees[i]);
diff --git a/worktree.c b/worktree.c
index 248bbb39d4..89b7d86cef 100644
--- a/worktree.c
+++ b/worktree.c
@@ -175,6 +175,11 @@ struct worktree **get_worktrees(void)
 	return get_worktrees_internal(0);
 }
 
+struct worktree **get_worktrees_without_reading_head(void)
+{
+	return get_worktrees_internal(1);
+}
+
 const char *get_worktree_git_dir(const struct worktree *wt)
 {
 	if (!wt)
diff --git a/worktree.h b/worktree.h
index 38145df80f..1ba4a161a0 100644
--- a/worktree.h
+++ b/worktree.h
@@ -30,6 +30,12 @@ struct worktree {
  */
 struct worktree **get_worktrees(void);
 
+/*
+ * Like `get_worktrees`, but does not read HEAD. This is useful when checking
+ * the consistency, as reading HEAD may not be necessary.
+ */
+struct worktree **get_worktrees_without_reading_head(void);
+
 /*
  * Returns 1 if linked worktrees exist, 0 otherwise.
  */
-- 
2.48.1

