Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AA318DF8A
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 02:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725935367; cv=none; b=WoNMn16LZqtW6R/G0JW5wqwOiiDu8F/hS13eDWDlZ3lCy0Dd6dw6l6djkWIZb1EUvExNe5yql1Gwxr6CE0UMmsZwi6akPzBcQ7o5q378JbngLOZb4jVfYFDkYgPvdiiQ5qqxe/5/8GOFSleQMaAuaEbNn4v2mJin7BG1fEDSQ7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725935367; c=relaxed/simple;
	bh=ifQ83hbRE5yqDTpJrNdcF14o3YllgMV5MBsIYbFKVxA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rzvjMT7v+sf9yXTKSkZmkFs74FNSZZPKnRWuww0UWjNmYuv0+otBtvBNjoDSrglEeUjlvA89IW8dIKGA2FndbP7vyoWFCx7w1kD6/B3mbzRNyEEr6lqYkOAaYvaEoUKLG0Tam92o7grm5J1N149RqwWCDTWKMmUAM2h/6EUPbOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GHCZ/WrT; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHCZ/WrT"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a8d446adf6eso264418066b.2
        for <git@vger.kernel.org>; Mon, 09 Sep 2024 19:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725935364; x=1726540164; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K4Mnie54Dh3iZv+PphkgpjdEIdhOk5JVZexOv4i+0ow=;
        b=GHCZ/WrTqaWVLqDUQ9rX6+ofOQvEYPrSSXPqUjPxlvOEX6FYTA65/gfInGiox5Gnvb
         o8y71oXJgxDgyBcyR/uxsI9uq0z2cL+EzhWXQK5Yfg+ZwstI61MRAVBqOwcpxxpaR9r2
         bEtcgUguPZLBKxDSwle9mIswfb7//LdhEM06eVcCjFL7j7ZRilKqDKoihN3nxdIGYm2z
         nE5kJftb1q0uUwCiTea7WPETEupGnePZLLXIDTrGGOoLA+5cad9Qb1RitMAXjhqe/eeB
         G5kvRoRnKqjaA+9+z6hnmk69jH80jPrYxf+ps9uC8TfnhRYF624Tp7/Hcokn39Os0orw
         wqnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725935364; x=1726540164;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K4Mnie54Dh3iZv+PphkgpjdEIdhOk5JVZexOv4i+0ow=;
        b=EZFPjTsJQE885jEcaHLgDsbwx2tGhW+IQgaAzeHL6dRc6kv7xHoZxOu36z6MkCnSZ5
         JhOHRCLn7V0t6KXyGMVW9CD2EQ5W8lO2sHP76BlITQdbnn3s7yMsxn9kblVZFkHu6fYO
         WEvj2rbgz+VK+GzSIN8DtBT3tbbdO39SsIcsAzGmT0qSZOOMZ2mqhg3YyZj6cIW+BPp7
         DdkyxeSt0ju6AvD5dgFrU9MoaBwAtD1mncVZo5WhZ2PkvTMKkNsj+4tzPrkllvxM8cBp
         5kk8rDH5ZPoisFJiCmCfUByre5jIn6TVfITX9bTZwyU0uDIZbgaeGUUTlAO9YE2i3cD7
         RBcA==
X-Gm-Message-State: AOJu0Yxt7Gql2xh9R6PW5t4Y4echaT9o+/pO4ZDyzjEJT41xLdxt5ixg
	l4JfHS+zgfAWw4wvZ3LVd3d5Tzj2cERePLjdx77aRt+zwUTL7VPqnj+PCw==
X-Google-Smtp-Source: AGHT+IHjJ9hmJmrn8q+ft3O83udhA3wLHXFpQw57OcsPf9qsoX+OuxcpT2hQmpCttWA6U7m93d+Lsg==
X-Received: by 2002:a17:907:d2df:b0:a86:43c0:4270 with SMTP id a640c23a62f3a-a8d245135a8mr613095666b.13.1725935363588;
        Mon, 09 Sep 2024 19:29:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25926eddsm415283766b.49.2024.09.09.19.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 19:29:23 -0700 (PDT)
Message-Id: <5dcb20a1c5c1e6f5dd676c54fa6b001af9abe072.1725935335.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1786.git.1725935335.gitgitgadget@gmail.com>
References: <pull.1786.git.1725935335.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Sep 2024 02:28:54 +0000
Subject: [PATCH 29/30] p5314: add a size test for name-hash collisions
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
Cc: gitster@pobox.com,
    johannes.schindelin@gmx.de,
    peff@peff.net,
    ps@pks.im,
    me@ttaylorr.com,
    johncai86@gmail.com,
    newren@gmail.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

This test helps inform someone as to the behavior of the name-hash
algorithms for their repo based on the paths at HEAD.

For example, the microsoft/fluentui repo had these statistics at time of
committing:

Test                                              this tree
-----------------------------------------------------------------
5314.1: paths at head                                       19.6K
5314.2: number of distinct name-hashes                       8.2K
5314.3: number of distinct full-name-hashes                 19.6K
5314.4: maximum multiplicity of name-hashes                   279
5314.5: maximum multiplicity of fullname-hashes                 1

That demonstrates that of the nearly twenty thousand path names, they
are assigned around eight thousand distinct values. 279 paths are
assigned to a single value, leading the packing algorithm to sort
objects from those paths together, by size.

In this repository, no collisions occur for the full-name-hash
algorithm.

In a more extreme example, an internal monorepo had a much worse
collision rate:

Test                                              this tree
-----------------------------------------------------------------
5314.1: paths at head                                      221.6K
5314.2: number of distinct name-hashes                      72.0K
5314.3: number of distinct full-name-hashes                221.6K
5314.4: maximum multiplicity of name-hashes                 14.4K
5314.5: maximum multiplicity of fullname-hashes                 2

Even in this repository with many more paths at HEAD, the collision rate
was low and the maximum number of paths being grouped into a single
bucket by the full-path-name algorithm was two.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 t/perf/p5314-name-hash.sh | 41 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100755 t/perf/p5314-name-hash.sh

diff --git a/t/perf/p5314-name-hash.sh b/t/perf/p5314-name-hash.sh
new file mode 100755
index 00000000000..9fe26612fac
--- /dev/null
+++ b/t/perf/p5314-name-hash.sh
@@ -0,0 +1,41 @@
+#!/bin/sh
+
+test_description='Tests pack performance using bitmaps'
+. ./perf-lib.sh
+
+GIT_TEST_PASSING_SANITIZE_LEAK=0
+export GIT_TEST_PASSING_SANITIZE_LEAK
+
+test_perf_large_repo
+
+test_size 'paths at head' '
+	git ls-tree -r --name-only HEAD >path-list &&
+	wc -l <path-list
+'
+
+test_size 'number of distinct name-hashes' '
+	cat path-list | test-tool name-hash >name-hashes &&
+	cat name-hashes | awk "{ print \$1; }" | sort -n | uniq -c >name-hash-count &&
+	wc -l <name-hash-count
+'
+
+test_size 'number of distinct full-name-hashes' '
+	cat name-hashes | awk "{ print \$2; }" | sort -n | uniq -c >full-name-hash-count &&
+	wc -l <full-name-hash-count
+'
+
+test_size 'maximum multiplicity of name-hashes' '
+	cat name-hash-count | \
+		sort -nr | \
+		head -n 1 | \
+		awk "{ print \$1; }"
+'
+
+test_size 'maximum multiplicity of fullname-hashes' '
+	cat full-name-hash-count | \
+		sort -nr | \
+		head -n 1 | \
+		awk "{ print \$1; }"
+'
+
+test_done
-- 
gitgitgadget

