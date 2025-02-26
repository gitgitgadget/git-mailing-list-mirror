Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794632163AA
	for <git@vger.kernel.org>; Wed, 26 Feb 2025 13:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740577778; cv=none; b=WFHKx9bBYbibrRatvSXqvlBrrGp11NwYcsq/xD5sjrrgzLZ04FuMffhTmYtPEbEkIIIIQO1wI57HB1GXKhkPhuLslXRSMNjtio3zXfBBQ+9chsuQ284TsqgSSd16mII7BdvyVAQB7Arkr9IEnTNpLgO8zeTFqHcCgDWe4lumMTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740577778; c=relaxed/simple;
	bh=91zfuoLoQwgrw0TlcEswgv67DDwoA1hs2npm5rnt8rU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MymVu+7yx4/Qz/Vm5R55f7ekJ0/oTlXom6cL7KsZZ1lrjO9RinEliGJqPk2fNaGYAqrqwIJsPp4hfoMGK1IqkJ0bpdn8dSVe7wn4r0zWnfv73lVbym/ONzMpNDN3JDlJrSQw+ucpvGSSVlHSwyzCuwcl5gwe2/3RaOPMknPCPz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Na6xTuTt; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Na6xTuTt"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-221206dbd7eso141884405ad.2
        for <git@vger.kernel.org>; Wed, 26 Feb 2025 05:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740577776; x=1741182576; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kn5rEPmZULamx/qgElC3YO1aE9Gj/Fu7ltZCF1dh5ds=;
        b=Na6xTuTtNLyeDpgiGko1pv2sBsc0gjpnD24qGrvYUeV+tnHJ8wcDbgOfgo/6yAf9co
         /rJUGLJJaGqqwgF2+qv8OOyUrr2AT++U95RlGyoy6ZUBpDjsZTScvrNYh6KG9nx6Z3wk
         yiUKeATAgCPlahkqOZfg29aZ6Ki2y3/VSIdUfO1Kui1PJOfndh3oFU6R+y9dkejoVKNd
         SA0e0J/myKhAg6ZiWQDAPjtXXrTWBiJzoufqMcSejmvaRGMw1JYTWiik47VVyFL8Gekg
         /y9XP9PFBS0mD4KpchwY5MIgHUBqaDwGqMdj8e8ElLOS1ikSlRXigrTPrPMZ3v0ziqyl
         8uWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740577776; x=1741182576;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kn5rEPmZULamx/qgElC3YO1aE9Gj/Fu7ltZCF1dh5ds=;
        b=t637L+68zhxipSpQ6cg+7s7HSUzK4k89u8GUWe8fdbZTIZ13QTTiHWpAORRDO0vvzy
         UGRWe+QMYpB2sbuv+MhgvWICyItnHFnSm3GKAElO602vhz2FRUN/bEyzc4/kVMEjOTeV
         ikD7DXIFXYxoT6hdoL0UEr1jJ1j9XlEbqJ/Opjp0/vQ4YqOYucmvbfUoNQM1cCkZ1jlV
         qW4FV7DgEq9ekNC/vvbYRz/7s8ZvsnKWRDam0H0mQNCmMBvIAjbSsspm+K4WHPG9J+JH
         VKMyfMC6dwpyjZyKWccBIYdQVAbktzAQxXDoHZDLj1dW5UceEbXnjhdJzHFXX4Duq6sl
         BxOQ==
X-Gm-Message-State: AOJu0Yx+dBP/dBzExAtV4ZqSZjoyWcqU5R8kMSfSalrZsAxjFSzIho3S
	YcdCzoHJoILnnGpJg3oqUPQUv+Tm02bGo/PEZKXWLaSr5FCOI0Z+SkBePA==
X-Gm-Gg: ASbGncvfMLHuTbHH5wm88Sm7GjVM0FD74ULodNv1XYh1KweYtDdx5tqCsaL7hi3XKAE
	IlWIb2TZdRspRj4ZHCKbZ2cUaBx7nHLWftlYhuO3KJFFm81/8Nk5W1f0HQUQFi8bAM5PiuNkzTn
	AIxJ7rx5e+Jm2gUSxc7bTTFHZoAQeYCoToGs1+PR+fJfMyUtQLsnEmLU0q4nQ34LetZv3IkiGX4
	e9oQqwboMN+/iDIUJgiUfm/qEN9L5hkNK8zfzQs0kX4thNq0Rn9rkjs5ajYGl9d6oZO/TcgM3tk
	c/B6ak2NFb9IUFqzFKwjUg==
X-Google-Smtp-Source: AGHT+IFo+c4NtH1VRUYqZKUnND4CKvYC2/v0d56OcJ/CS+WNGta86T4vCN/woRoU/Y6s5ovmwMVX1w==
X-Received: by 2002:a17:903:94c:b0:220:d81a:bebf with SMTP id d9443c01a7336-2231fe0f976mr62910395ad.0.1740577776158;
        Wed, 26 Feb 2025 05:49:36 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2230a0a3befsm32352005ad.165.2025.02.26.05.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 05:49:35 -0800 (PST)
Date: Wed, 26 Feb 2025 21:49:45 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v7 2/9] builtin/refs: get worktrees without reading head
 information
Message-ID: <Z78b-XOIvgbQvufQ@ArchLinux>
References: <Z78bmBSrDR20GY6g@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z78bmBSrDR20GY6g@ArchLinux>

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
 worktree.h     | 8 ++++++++
 3 files changed, 14 insertions(+), 1 deletion(-)

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
index d4a68c9c23..d23482a746 100644
--- a/worktree.c
+++ b/worktree.c
@@ -198,6 +198,11 @@ struct worktree **get_worktrees(void)
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
index 38145df80f..a305c7e2c7 100644
--- a/worktree.h
+++ b/worktree.h
@@ -30,6 +30,14 @@ struct worktree {
  */
 struct worktree **get_worktrees(void);
 
+/*
+ * Like `get_worktrees`, but does not read HEAD. Skip reading HEAD allows to
+ * get the worktree without worrying about failures pertaining to parsing
+ * the HEAD ref. This is useful in contexts where it is assumed that the
+ * refdb may not be in a consistent state.
+ */
+struct worktree **get_worktrees_without_reading_head(void);
+
 /*
  * Returns 1 if linked worktrees exist, 0 otherwise.
  */
-- 
2.48.1

