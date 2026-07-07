Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418A41EB5C2
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 21:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783458109; cv=none; b=NbzlFxwB5/QJgIM7ND5f3mx2fU6wTU+Tfh+XMy6lj793ykFYNANjr8UpKkCmrCeFInbaGRXiG8afbCBvFG7KnWsqjE/QvLjWYGcj//KKzjRWJD8Xi8UUxTe3mn92aCwA952xtXvOKaP3YhVXGffF+ZRcyp00fH3gyK2Knjs1gV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783458109; c=relaxed/simple;
	bh=i3WtXXk6bKMFVEEepyvH+7PSNDegoZldngpIZRJ176s=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=trQ1Bivv32mOCFYKARBppiuyXRDbfRweovCw+qFQTbfEmMuMH2MJojplT9dgDJDmCvSPU4psYueVGao1SFWQtg5Nkz3z5tU/nkRWOrrYIDkaa5Nxx/2pkcIleJp3h6JJfzZweJhcvCcK3ZYN9U8eliyEeC0ru5n4mPHoCWh2ANU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cVnyFvgD; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVnyFvgD"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-92e5c92c389so235809685a.3
        for <git@vger.kernel.org>; Tue, 07 Jul 2026 14:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783458107; x=1784062907; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6/aE4CY4lYvL5+7/iVew49HEQ4mURhyFE3uioOYJAgg=;
        b=cVnyFvgDav+E/w+BfVJKplmEQKlv5OlOyUZqp+4hcf9a6Un4xOC6QIR5Llg+pmcIr2
         qcAxlvfMn8pm5Y2gRoqke9CP1VLIlOlhX0bjN6dmpJfF69Ia61ccN0kFmAAil/t6SLxP
         c93Z++yW7zbZFtA322up7qqBR/CFaSUG8vV0qKyhTaLLlieGK/16wjOfsSmwfshqQeG6
         zk4ZMDbigIa0Shb9NIOJaZlvJ36Sf5hnmuRrFdsvAf1lI8x8W3zkhrIVJO6sDJe87nkg
         sNZdSOJ2MGqRUEmFyQMPT8rML6wXC/HMV5oWEqMNYl4vZR4Mj8OJEuG5692OxtYv2FoM
         6NfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783458107; x=1784062907;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6/aE4CY4lYvL5+7/iVew49HEQ4mURhyFE3uioOYJAgg=;
        b=PeuPhyqhrMrQLrfSRfokem6ZJ2wmO6DvxmnPIaGx/5s3GfnGYMgpg2P9ljiYTGHI/o
         qTLw3s405QwbFVq/jSFb8G7HvSAwy07veH3X/YTwqNrOJbQkougnruIpHcFqote0WxSo
         u0LRrphIrKyK0AzrcbYTYAQgJa6DP8GMWDZ5IQ+qtYk3E74UGn5aWi9tzBFCqqCavULl
         Ar3MsTbFUbXlCWz4Ty4abmkQZsdQCM7BdwDa6nSSUfxf7PFlNibycWoG1qpPD1R3X/ei
         RMQx5bXfPNOY//nF7Die+0HLsooM64NtEzY0uVcSIGMevF+sQxtslnfPxOfLOUov5INy
         aGrg==
X-Gm-Message-State: AOJu0Ywv5Gox8U9bBsTVuX5osyDlTMZPTxy7uo5A/VIw/bJUOt/Bgw+6
	4A9Iug0+w0dxnT7i19F5p8hz5KX/xXrPHALNUVJ6XVM26S7Y0g0jRn5/bhmY9A==
X-Gm-Gg: AfdE7cmXHp3FoqAoY+7yJPMiXzvxEyEDmWSzmzn71/rVzenEOPKqhHNIAqa8qbzV5P6
	uMnEFRob01dAM36r3BR7MDhpSK1SCTo5l15Bv1csTyJCz7UWlsh90XxvAqChzHzGOJFZ1UA5kZx
	hCVTiOekoeP9/zOhLC9mnyYTCRQAkPOgM9XUXtSCfv2n/CXR065V11UybzqKUufgSz47koqwusa
	DsOfKrY5GmEceBJFY8HOAHSC4lPDzb2/aPjoULYAXCutInRUKXo/N7I8cECdTy3lC/J/8CPAC4N
	Iw6uWtmzVUkMc0sh9PcQEA3jPnmgG7luG7csVJXkUbaFgdvOQmipDSqJfPnc5474DVeQ+ttFCci
	4P9LNoVFIX+4TDk1o24CBq9JGOfqkVex8VoaUAbXm7T8N228LdjU/kluwoIylMcK54h25XO3BTa
	96aqHeALNFKqkYE1M=
X-Received: by 2002:a05:620a:31aa:b0:92a:f65e:1e95 with SMTP id af79cd13be357-92ebb4f62d7mr883870485a.21.1783458107003;
        Tue, 07 Jul 2026 14:01:47 -0700 (PDT)
Received: from [127.0.0.1] ([20.115.94.225])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90c9314bsm1262305485a.23.2026.07.07.14.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 14:01:46 -0700 (PDT)
Message-Id: <pull.2353.git.git.1783458106037.gitgitgadget@gmail.com>
From: "Henrique Ferreiro via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 07 Jul 2026 21:01:45 +0000
Subject: [PATCH] unpack-trees: avoid quadratic index scan in
 next_cache_entry()
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
Cc: Henrique Ferreiro <hferreiro@igalia.com>,
    Henrique Ferreiro <hferreiro@igalia.com>

From: Henrique Ferreiro <hferreiro@igalia.com>

Diffing the working tree against a commit with a pathspec can take
time quadratic in the size of the index when the pathspec matches a
subtree whose entries are the first entries of the index.  Fix it by
having next_cache_entry() record how far it scanned in cache_bottom,
so repeated calls no longer rescan the growing prefix of
already-unpacked entries.  On a Chromium checkout (~500k index
entries),

	git diff HEAD -- .agents/OWNERS

took about 8 minutes before this change and 0.07 seconds after it.
The same diff without the commit, without the pathspec, or with
--cached was already instant.

Add p0009-diff-pathspec.sh, which builds a 100,000-entry index whose
first path lives in a subtree, to guard against the regression.
Comparing v2.55.0 with this change:

Test                            v2.55.0           HEAD
------------------------------------------------------------------------
0009.2: diff pathspec subtree   7.16(7.12+0.01)   0.02(0.01+0.00) -99.7%

Signed-off-by: Henrique Ferreiro <hferreiro@igalia.com>
---
    unpack-trees: avoid quadratic index scan in next_cache_entry()

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2353%2Fhferreiro%2Funpack-trees-quadratic-scan-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2353/hferreiro/unpack-trees-quadratic-scan-v1
Pull-Request: https://github.com/git/git/pull/2353

 t/perf/p0009-diff-pathspec.sh | 27 +++++++++++++++++++++++++++
 unpack-trees.c                |  4 +++-
 2 files changed, 30 insertions(+), 1 deletion(-)
 create mode 100755 t/perf/p0009-diff-pathspec.sh

diff --git a/t/perf/p0009-diff-pathspec.sh b/t/perf/p0009-diff-pathspec.sh
new file mode 100755
index 0000000000..0f1dccfbb4
--- /dev/null
+++ b/t/perf/p0009-diff-pathspec.sh
@@ -0,0 +1,27 @@
+#!/bin/sh
+
+test_description='Tests performance of diffing the working tree with a pathspec'
+
+. ./perf-lib.sh
+
+test_perf_fresh_repo
+
+# The entries exist only in the index, which is enough to
+# exercise the index scan.
+test_expect_success 'setup' '
+	count=100000 &&
+	blob=$(echo content | git hash-object -w --stdin) &&
+	{
+		printf "100644 $blob\taaa/file\n" &&
+		printf "100644 $blob\tf%s\n" $(test_seq $count)
+	} | git update-index --index-info &&
+	git commit -q -m initial &&
+	mkdir -p aaa &&
+	echo content >aaa/file
+'
+
+test_perf 'diff pathspec subtree' '
+	git diff HEAD -- aaa/file
+'
+
+test_done
diff --git a/unpack-trees.c b/unpack-trees.c
index b42020f16b..ed9fef453a 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -671,8 +671,10 @@ static struct cache_entry *next_cache_entry(struct unpack_trees_options *o)
 
 	while (pos < index->cache_nr) {
 		struct cache_entry *ce = index->cache[pos];
-		if (!(ce->ce_flags & CE_UNPACKED))
+		if (!(ce->ce_flags & CE_UNPACKED)) {
+			o->internal.cache_bottom = pos;
 			return ce;
+		}
 		pos++;
 	}
 	return NULL;

base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
-- 
gitgitgadget
