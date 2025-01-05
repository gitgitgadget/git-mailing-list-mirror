Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98671EA80
	for <git@vger.kernel.org>; Sun,  5 Jan 2025 13:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736084966; cv=none; b=hr8lyffdHPBml2Je6EAhOl3oS+WI04e232l/+z1dbA/eZ6uAKDgS+F+AgFJoAG7eCDHmg0XC+Qrwcn7eggdLUvff15AP00plnXYGDl6/d2iUeqaCgy9BVtgzJcMhTJU8N+3k3axsPKdvnKGYnfsVCNXfrsCOezbL9ay4awVcIfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736084966; c=relaxed/simple;
	bh=d3qR3ZFxaeWlmXlPs5P841hWHemZiaBfqce58HHAYqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MP1MiQiMriTap1Zva6Xq3SJW1Ez9TW+UcBt2ES70eG0+snKF6JcpxPoVWF/p93qP/NbD91Vv38CrmnNNg+NQOf5Qk6sQgzgEPAKRbRtLIolvZflGmlqYAo2RWD7mXg8aoGH6wVMwJ/QqRPbBHGaSYKu6Zysyo55xBPVheLCu4s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TrV2aTHT; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TrV2aTHT"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2164b1f05caso187905285ad.3
        for <git@vger.kernel.org>; Sun, 05 Jan 2025 05:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736084963; x=1736689763; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XKGrfoIJOmc3wq5aj4fqGaPQgHGOBpQN7ZgkCX+fcNc=;
        b=TrV2aTHTjnUKJxbtAMTfPX458HPpZpA1LIjA+2xk0kJOVi6gYHbl7sPIt3VjbpjqUg
         WD4moJPyEvML7FMNy3FaU8QSyvARHzp1kzWlcI95uIS1qwvrE1ViKU+UjTUpB5GcceEW
         FKVpbbmlw5/7r6utI6fOGcKOi4xAYHAVS42Oo51KREpy0NF9HoTvzRkqshAFKZH1oBAP
         48xc7c6DiqV6BA2h+eZvuDFYA9DyP7mpxLn2folczaFblSn76erWcgoJp1pAsR804wq5
         ab0hvpagLgW5ODt9bbl23z5zdx3pCVIGBJQ4KIE0Z82GbkdiDiQP77IcPCcFnTpEbqxG
         OmbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736084963; x=1736689763;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XKGrfoIJOmc3wq5aj4fqGaPQgHGOBpQN7ZgkCX+fcNc=;
        b=qKY+SXjemCO9MhHEU8GH4mlKfDh55W25QRNkGh97R3PMKmnD+Amm8adJj0cxaLGE5r
         Q9xucePp8OeEoyPt1PmltTSwVhlRCjzcMn+VIIv/g46j2GPSAaYYYEqZeUGxoy1vQUG5
         IxGblrStunG8q9LQNnAKtrLl9h5L7ABo780Wxt8w+MVSCep3pCwP4kVS8J19K01bLd4P
         YifYXvYPPPyY3RL28h8f4RDAx2AI5ej/dP9mzK0kAbEYITQnubY24fBD5J56WxmG6ydQ
         LXW2/6Bzq1DMTw9gZAJLAOHEyLzm+VZNB9g41kx8qQHw1opUOkaEZwCtoN7dtOlsobB3
         ZYOA==
X-Gm-Message-State: AOJu0YwAcZTYL+PIGnu54UZsCp/h8Vik/tosP9kqToYB2yvaDGk6mSRt
	f2vVInQUefbslgmOKHfUSFRrP4i2EyknHLQ6nJvMk8cmbnW8iQGwqmsQEw==
X-Gm-Gg: ASbGncs4faAp1zyrxEouZ2K9gXaY+xBPhF3rPxgaybsL/m+gw+lgARd4Z/k1snYzkeh
	F5UaYGixd4I5MzTgOaPq0edO+Qz64GAPNK6W4WJdZhuM7imIUyRu5ltfZ0WPj5q7XWoh4S3zRdd
	SYcMuK/bWEf56txt6iH5nJhjMvHUBPyYICPNHDzjkZnRuB6L71MV3fHIfIQlml1ccqrhlq2vkMP
	p3ismljR9a67qq/4EY7DSZ1mJkVQ+8YQAo=
X-Google-Smtp-Source: AGHT+IECb0q7jhuMaQrd9ZDuzD29bDj8FfoBinA7bSA8+1p1D8aGu1Fx/7WkSmUNWunJP5p1iZFNTQ==
X-Received: by 2002:a17:902:ecd2:b0:215:89a0:416f with SMTP id d9443c01a7336-219e6ebd0a4mr745748295ad.30.1736084963393;
        Sun, 05 Jan 2025 05:49:23 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca029ccsm274509155ad.260.2025.01.05.05.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2025 05:49:22 -0800 (PST)
Date: Sun, 5 Jan 2025 21:49:19 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 02/10] builtin/refs.h: get worktrees without reading head info
Message-ID: <Z3qN30z1NCXa3AX-@ArchLinux>
References: <Z3qNUizvHJLgMx1y@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z3qNUizvHJLgMx1y@ArchLinux>

In "packed-backend.c", there are some functions such as "create_snapshot"
and "next_record" which would check the correctness of the content of
the "packed-ref" file. When anything is bad, the program will die.

It may seem that we have nothing relevant to above feature, because we
are going to read and parse the raw "packed-ref" file without creating
the snapshot and using the ref iterator to check the consistency.

However, when using "get_worktrees" in "builtin/refs", we will parse the
head information. If the referent of the "HEAD" is inside the
"packed-ref", we will call "create_snapshot" and "next_record" functions
to parse the "packed-ref" to get the head information. And if there are
something wrong, the program will die.

Although this behavior has no harm for the program, it will
short-circuit the program. When the users execute "git refs verify" or
"git fsck", we don't want to simply die the program but rather show the
warnings or errors as many as possible to info the users. So, we should
avoiding reading the head info.

Fortunately, in 465a22b338 (worktree: skip reading HEAD when repairing
worktrees, 2023-12-29), we have introduced a function
"get_worktrees_internal" which allows us to get worktrees without
reading head info.

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
index af68b24f9d..74cb463e51 100644
--- a/worktree.c
+++ b/worktree.c
@@ -174,6 +174,11 @@ struct worktree **get_worktrees(void)
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
2.47.1

