Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E686C3EDAB1
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 16:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772208498; cv=none; b=k8YlslwsbKZEIy0fEsgWfTCpbNw6AE+havbQLxSSk029/q2KFHKlAM90CtlLQft3vAKX4SptfXFK+wVwkSa/jIj7KT393JGPYM8aT72Ay52Bltkhlf6bJfzUcr9BQ3pxnp14qLOJSgmnFDg4HG3V/Z/IITYeISHlD9jEzXde7yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772208498; c=relaxed/simple;
	bh=6vK+xxaC/InZk1ZkxH7xhwh+djpVBuvaot+/f7sxfIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vDArOYhWHhKMrx5f82XU+6lg/VPv7LNB770kskbScjp/dh7hJwsk9OGCrLxbAO4+m4hatKsNDhtCTX6k6n7A09KatNyHHcJeOngq2YC7PHHttGH6Oadxpn40Xdqvbpi+l9dZGNFntXWIrhCS0I6LvczmCf9baREmE6V87L8exkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ljzrmu+K; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljzrmu+K"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-483abed83b6so18294645e9.0
        for <git@vger.kernel.org>; Fri, 27 Feb 2026 08:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772208495; x=1772813295; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VxFCoXP1JDO4Z+CsM/annzkptJy7ZeWjhQT1rBTEXDc=;
        b=ljzrmu+KZTSnohgUYDNjrkPoFzVTeLA28wiT8QMtk1bLfrZedYnEopwMGNpL6ZzE+H
         CvPiQYBI4Ri54A+er5jfvl0tWKOpp5qDq7j79r4h1nGKidrLsv2NJ4Aaf15edb3O0WKL
         lvf4+tIdZSZZ7l0qSr+cwOIS/fpCNwFvzstRhkrNqm54sHm8Nb0GzXaarwz/DUoNfmF8
         kCYOYsRW4uTCE7a1tFmUCwcC9TgLJVNdYfqIv3BaKieJT9PW6qbdgvnqC4LXuSPKXzyR
         zGeZ0l0sAwzQr0eCZi+2LKC9oy1I12LRn1GBVDKY5SWIyZHFl0xsPyPfWSzkgdkj588n
         mu2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772208495; x=1772813295;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VxFCoXP1JDO4Z+CsM/annzkptJy7ZeWjhQT1rBTEXDc=;
        b=A33RYqzQ1B+TSKcQabYaPWe8kEcNtpO60LdkyNMv5blVMsqR4f5ahQ4cJNaaHcPmFN
         Zyafp/vGa3NvPS2Dty//XvmQUx2tQfk+w8jpNIJ9NF7TH/cAtcFdXYVJTlpew0H0cAei
         akMyq/NcDhzwNBri25TWtZfGAJ5CK8DrjxNULScn4Ht3OtcaIjEzE4d6KaiDw0NH6nMS
         cy4YFGoOye/io2jKedoMEkrv6Pwu1WvNYQTP76wIPtmA/4S99QbJ7QbqPHmat0FtdqyL
         AJJvMgqK+XSt5dAPH9vOyFrwKqnKJRH0Uxut1EDJ7zIss2hjcV4JnoPvFjPgByE7sFdd
         I4/Q==
X-Gm-Message-State: AOJu0Yx4ArPrMb9ntVXWbPkkdL/Pt5Sjd9oCGINdIAiafzFOPgvOW1tV
	DKLwB+TojzxL3EBBSFOYfGU+dlFgkDkACavUpB8zsbx9rVdSxA8xJJ5DlSS7FA==
X-Gm-Gg: ATEYQzwgZqVq/UGGsD37ny5vxG35zRbIjlDoaezBwY4pFTMoMzsUeJ2cazlP8aXD94p
	SV090FJ+LLS2YWITbI+95QbPTUPA1nZffDdKtFeq2bagafYl50Lhjn8sGxFzvYQoprd3m4hcozf
	d+j5tJIaUwjgJlA14UZaTOXWtzDpYFOQojc6qcnq3OGiPlSoE6WjjviRyfoXDp94SZ0rIQLabbG
	s2bS9cg/qwIJB13r8VgOFHqkGgF8h8ja6ZBtE8NJ2UtSegHy07tc+0XbA856n5t67aGaF6j06AA
	l8w9Azc6x5Mmxc3Ph7xGE33KIUt0aktHpeXVVnMDLVvN23LSG/YZsXtxhfCWIO9MyPG79a0FXq4
	TtCAAZ2asnub+oLxZkyyoSOaeVIVl8zGJ9TpIi1GrAW6JKqkIKDuT+htFgQf3pmuAW9wCx5I5/l
	Swfv97qqtRR4O1UNujNh2MNMaPzMDkhf+NKpM=
X-Received: by 2002:a05:600c:190c:b0:47e:e8c2:905f with SMTP id 5b1f17b1804b1-483c9ba7b9fmr51101975e9.8.1772208494875;
        Fri, 27 Feb 2026 08:08:14 -0800 (PST)
Received: from lorenzo-VM ([84.33.161.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483c3b770e7sm124939915e9.9.2026.02.27.08.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 08:08:14 -0800 (PST)
Date: Fri, 27 Feb 2026 17:08:12 +0100
From: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [GSoC PATCH v2 2/2] t4052: add test for diffstat width when prefix
 contains UTF-8 chars
Message-ID: <984fa10d728aad049d0430472e85f1ed0e5ea4de.1772136203.git.lorenzo.pegorari2002@gmail.com>
References: <cover.1771894207.git.lorenzo.pegorari2002@gmail.com>
 <cover.1772136203.git.lorenzo.pegorari2002@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1772136203.git.lorenzo.pegorari2002@gmail.com>

Add test checking the calculation of the diffstat display width when the
`line_prefix`, which is text that goes before the diffstat, contains
UTF-8 characters.

This situation happens, for example, when `git log --stat --graph` is
executed:
* `--stat` will create a diffstat for each commit
* `--graph` will stuff `line_prefix` with the graph portion of the log,
  which contains UTF-8 characters (ANSI escape codes to color the text)

Signed-off-by: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
---
 t/b                    |  0
 t/t4052-stat-output.sh | 30 ++++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)
 create mode 100644 t/b

diff --git a/t/b b/t/b
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/t/t4052-stat-output.sh b/t/t4052-stat-output.sh
index 740bb97091..cc4665047d 100755
--- a/t/t4052-stat-output.sh
+++ b/t/t4052-stat-output.sh
@@ -413,4 +413,34 @@ test_expect_success 'merge --stat respects COLUMNS with long name' '
 	test_cmp expect actual
 '
 
+# git-log will print only 1 commit containing a single branch graph and a diffstat.
+# The diffstat will be only one file, with a placeholder FILENAME, that, with
+# enough terminal display width, will contain the following line:
+#     "<RED>|<RESET>  ${FILENAME} | 0"
+# where "<RED>" and "<RESET>" are ANSI escape codes to color the text.
+# To calculate the minimium terminal display width MIN_TERM_WIDTH so that the
+# FILENAME in the diffstat will not be shortened, we take the FILENAME length
+# and add 9 to it.
+# To check if the diffstat width, when the line_prefix (the "<RED>|<RESET>" of
+# the graph) contains UTF-8 characters (the ANSI escape codes), is calculated
+# correctly, we:
+#     1. check if it contains the line defined before when using MIN_TERM_WIDTH
+#     2. check if it contains the line defined before, but with the FILENAME
+#        shortened by only one character, when using MIN_TERM_WIDTH - 1
+
+test_expect_success 'diffstat where line_prefix contains UTF-8 chars is correct width' '
+	FILENAME="placeholder-text-placeholder-text" &&
+	FILENAME_TRIMMED="...eholder-text-placeholder-text" &&
+	MIN_TERM_WIDTH=$((${#FILENAME} + 9)) &&
+	test_config color.diff always &&
+	git commit --allow-empty --allow-empty-message &&
+	>${FILENAME} &&
+	git add ${FILENAME} &&
+	git commit --allow-empty-message &&
+	COLUMNS=$((MIN_TERM_WIDTH)) git log --graph --stat -n1 | test_decode_color >out &&
+	test_grep "<RED>|<RESET>  ${FILENAME} | 0" out &&
+	COLUMNS=$((MIN_TERM_WIDTH - 1)) git log --graph --stat -n1 | test_decode_color >out &&
+	test_grep "<RED>|<RESET>  ${FILENAME_TRIMMED} | 0" out
+'
+
 test_done
-- 
2.43.0

