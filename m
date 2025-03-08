Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F228462
	for <git@vger.kernel.org>; Sat,  8 Mar 2025 01:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741395620; cv=none; b=L9jApkXQXkcOqrIGqZiX1TqSl7N3Vfgf+VVyIxKJ5j1yC366MK3cSrkBFC6qYQDWz0vE/W+iNh2Da+Jd8MdeGF+wzAg07HliU1CPeq51fgghxpd60Fb64rkelggzar6iS3WdZX7EMBTOb6jgWy7FHn/O3xGJNkZNulEhSjsXBgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741395620; c=relaxed/simple;
	bh=NV7jRDT3Y9XvoTs25+FmEwI4hj6Kl9xiG/4EmmM/umo=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=Gtx2gg6J+496rGydop3IFWkpctiRCImVnuH/DQowNuO7M5KI/poQ9s7z4JzbZgI7qIE0oRlcvRSzuvegJ+kmc2BOmh4g8bJ97s7xH5qPXzTdsqrlBaDxewgTIOaw8CafI0dzCsu/aT0TKiokQyuwGOXsJy1nXEnR0uUDcXEGuOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RTfJ2Vv4; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RTfJ2Vv4"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aaedd529ba1so283823166b.1
        for <git@vger.kernel.org>; Fri, 07 Mar 2025 17:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741395617; x=1742000417; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7hpeoHGdbyIFjlmlqCprt6qTj/iT0tMxhOn0N3RaK34=;
        b=RTfJ2Vv44DMZ8E0IiJSYzNCxT4LF6+orivC3la8/KOUwo1HZN1QJ3QvXkhKlemAuML
         1NnHvvIAwFv2oAXezKQmrpN3PMX+DpZ2AL8zeLk/SY9IUvsmuOwP/kG8oHabaSeZXxDN
         eQ4nwVkAg2fsbkSYE4AyyCkXUyB/F//id26MnOi0UGxwtrNi33BcO6lFW6afw5h7riQR
         qtXupeLQc+MBY9mjb6zx8ebkrCp4uHzu4TZ8t7aIqs+nVcX/VFlvzZWA8k7CaidXe0JR
         s2nr/FQXGNTJAWqQfTxii+KOEsZSNgY0jiSxwXc1Q6dVCSewQ6Cjm7/KbQjiBHOX2/r2
         WcSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741395617; x=1742000417;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7hpeoHGdbyIFjlmlqCprt6qTj/iT0tMxhOn0N3RaK34=;
        b=wz5vjsLsFfQaINoz25DkOJll+joyt5DW8zNGojmDPAVRizQjlRQWTVCkYvTQk+75sT
         lp1FIvj2JjdcRSry13HhRb4mLll0bMMkw6IUpTG31AvH1xJyNCzA+f/rICUND7fMU1hJ
         yDI1lXb/actoT/YZqviIUqXfcifYIKyyTF5TVfPDnT37TQ0d5gkXLo6TUUO3A7O2MCzJ
         Pz2EQ6DYZrpwMfA3R6nhYJTh5WtFqleFbTT2UGUdqxg9oNASvN1ZRKBJhdIg6vA14+pB
         YULlioOLenjKx2VmLAsxbmW8D918dffPtKU4HRl7YwvileB0dxCrSla2cL5321r2PO2B
         BqpA==
X-Gm-Message-State: AOJu0YwGFHfgh0iYGFCVNsRkUXDQp4PRWwuVA+kmqYN9R6+fLvo/XG5E
	QGMQDHRKhxeFACwLcGRQcdQirhpiwAKVLls5+4NRQBop4kHwTPanRq63gg==
X-Gm-Gg: ASbGncugRmh0Yi4SL1PViG3/w3VQfKftdC1yUQkL7O1HytMR3390UaThhCmR8cZ1NBP
	zk7MBd2VJm+jbWQEdhdNqGN2NCziQ396v3kyZ834DTqVt6e6eBDqIErNhpOMraFzYtz9whtd5FR
	0gL67NcZ3cvEIeWDi1ykTAMyQs5H7YawGK7w356Ktt4mOwWWo9EvArLSPr+0emNpyRTriXaQgTL
	Wtgvmbfbf1k/ZjLYLvl3f9SHl1xY2jDZiCMzMY8rX8+1IcdywuqK6OKnOOou0mHYhyu2PcQ1pYW
	M1xajxU0QvUOviDjcbN3uq7v8SWTnmxxolfSDnKG6ExNyUrLIbFPKosR
X-Google-Smtp-Source: AGHT+IHcghRt8HRI9a1vHNSAvXrR1109ytatxgjKVKh0Bc3PG/2LJWiQNslHx9M8FeNrz7/Oi7uFUA==
X-Received: by 2002:a05:6402:5201:b0:5df:6a:54ea with SMTP id 4fb4d7f45d1cf-5e5e22b92e8mr12774993a12.11.1741395616549;
        Fri, 07 Mar 2025 17:00:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac239485d34sm353768266b.66.2025.03.07.17.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 17:00:16 -0800 (PST)
Message-Id: <pull.1876.git.1741395615315.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 08 Mar 2025 01:00:15 +0000
Subject: [PATCH] diffcore-rename: fix BUG when break detection and --follow
 used together
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
Cc: Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

Prior to commit 9db2ac56168e (diffcore-rename: accelerate rename_dst
setup, 2020-12-11), the function add_rename_dst() resulted in quadratic
runtime since each call inserted the new entry into the array in sorted
order.  The reason for the sorted order requirement was so that
locate_rename_dst(), used when break detection is turned on, could find
the appropriate entry in logarithmic time via bisection on string
comparisons.  (It's better to be quadratic in moving pointers than
quadratic in string comparisons, so this made some sense.)  However,
since break detection always sticks the broken pairs adjacent to each
other, that commit decided to simply append entries to rename_dst, and
record the mapping of (filename) -> (index within rename_dst) via a
strintmap.  Doing this relied on the fact that when adding the source of
a broken pair via register_rename_src(), that the next item we'd process
was the other half of the same broken pair and would be added to
rename_dst via add_rename_dst().  This assumption was fine under break
detection alone, but the combination of break detection and
single_follow violated that assumption because of this code:

		else if (options->single_follow &&
			 strcmp(options->single_follow, p->two->path))
			continue; /* not interested */

which would end up skipping calling add_rename_dst() below that point.
Since I knew I was assuming that the dst pair of a break would always be
added right after the src pair of a break, I added a new BUG() directive
as part of that commit later on at time of use that would check my
assumptions held.  That BUG() didn't trip for nearly 4 years...which
sadly meant I had long since forgotten the related details.  Anyway...

When the dst half of a broken pair is skipped like this, it means that
not only could my recorded index be invalid (just past the end of the
array), it could also point to some unrelated dst that just happened to
be the next one added to the array.  So, to fix this, we need to add a
little more safety around the checks for the recorded break_idx.

It turns out that making a testcase to trigger this is a bit challenging
too.  I added a simple testcase which tickles the necessary area, but
running it normally actually passes for me.  However, running it under
valgrind shows that it is depending upon uninitialized memory.  I
suspect that to get a reliable reproduction case, I might need to have
several more paths involved, but that might make the testcase more
difficult to understand.  So, I instead just embedded a warning within
the testname that the test triggered uninitialized memory use.

In short, when these two rare options are used together, fix the
accidental find of the wrong dst entry (which would often be
uninitialized memory just past the end of the array), by adding a little
more care around the recorded indices for break_idx.

Reported-by: Olaf Hering <olaf@aepfle.de>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
    diffcore-rename: fix BUG when break detection and --follow used together
    
    Bug dates back to Git v2.31.0, and was discovered and reported about
    four years later over at
    https://lore.kernel.org/git/20240920112228.3d1130f5.olaf@aepfle.de/.
    Sadly, took me about half a year to get back to this one...

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1876%2Fnewren%2Ffix-break-follow-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1876/newren/fix-break-follow-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1876

 diffcore-rename.c                   |  9 +++++----
 t/t4206-log-follow-harder-copies.sh | 18 ++++++++++++++++++
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 10bb0321b10..cb4be5be63c 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -33,7 +33,7 @@ static struct diff_rename_dst *locate_rename_dst(struct diff_filepair *p)
 {
 	/* Lookup by p->ONE->path */
 	int idx = break_idx ? strintmap_get(break_idx, p->one->path) : -1;
-	return (idx == -1) ? NULL : &rename_dst[idx];
+	return (idx == -1 || idx == rename_dst_nr) ? NULL : &rename_dst[idx];
 }
 
 /*
@@ -1668,9 +1668,10 @@ void diffcore_rename_extended(struct diff_options *options,
 			if (DIFF_PAIR_BROKEN(p)) {
 				/* broken delete */
 				struct diff_rename_dst *dst = locate_rename_dst(p);
-				if (!dst)
-					BUG("tracking failed somehow; failed to find associated dst for broken pair");
-				if (dst->is_rename)
+				if (options->single_follow && dst &&
+				    strcmp(dst->p->two->path, p->two->path))
+					dst = NULL;
+				if (dst && dst->is_rename)
 					/* counterpart is now rename/copy */
 					pair_to_free = p;
 			}
diff --git a/t/t4206-log-follow-harder-copies.sh b/t/t4206-log-follow-harder-copies.sh
index bcab71c8e84..9e00f33a425 100755
--- a/t/t4206-log-follow-harder-copies.sh
+++ b/t/t4206-log-follow-harder-copies.sh
@@ -54,4 +54,22 @@ test_expect_success 'validate the output.' '
 	compare_diff_patch current expected
 '
 
+test_expect_success 'log --follow -B does not die or use uninitialized memory' '
+	git switch --orphan break_and_follow_are_icky_so_use_both &&
+	printf "%s\n" A B C D E F G H I J K L M N O P Q R S T U V W X Y Z >z &&
+	git add z &&
+	git commit -m "Initial" &&
+
+	test_seq 1 130 >z &&
+	echo lame >somefile &&
+	git add z somefile &&
+	git commit -m "Rewrite z, introduce lame somefile" &&
+
+	echo Content >somefile &&
+	git add somefile &&
+	git commit -m "Rewrite somefile" &&
+
+	git log -B --follow somefile
+'
+
 test_done

base-commit: f93ff170b93a1782659637824b25923245ac9dd1
-- 
gitgitgadget
