Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F141318ED9
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 22:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775861764; cv=none; b=uqjxV9aMaRKkjRNUaXwkGJwzSxONOsZwOtLnUd/mlOD7otDazELobjYC098Dvo6ILzvdpeWqswNpvjhBnRfm6RnZRCbV3ag2hgewhyG8XWghSbGD7aAyEwk6KokkrjrJn3dZWuBKBsotnQFU5gokXAU1Rjv+k8t2j/T72SfmDto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775861764; c=relaxed/simple;
	bh=2m6T23dC2qIthhPhYJIxzVHQsgMxgBlqHfsbePiqC2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TDmSlnZA3z7FQ0gaFZP+KXrSzv1F3JfHnXnuE+DnM9wxmZqKNvYy0wD4ec2AC1U5yuo94ORChUfzdIgnE8xAxPOUgY1Yjtvc4fW5PNtsb4x5jaMgQ8ZnDrkErsxmEUdM4R9iLsYA9HTyVy6yrdLXV+Yh6cVfm+7JuHcX08ueWMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gVuFh39D; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVuFh39D"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488a88aeec9so32612035e9.2
        for <git@vger.kernel.org>; Fri, 10 Apr 2026 15:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775861761; x=1776466561; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YrKkg0df3B45xT5iemLm+oOcy+sqgnc1QFtLLaVMsZ4=;
        b=gVuFh39DUMEwDv5XSWu4EKqRZWhrs0TBcHbRHNNyP3FDjWj15d6YJcBtA/23i2kC2b
         tMbYWlTgLZPtKFca/l5OsKGPgl5FB9mUeqgUPTzkJ66wJsQ4UhsekJZZPfW0JUzx6POk
         zO8x2XlRVjKYBjjmX0xw5/8dsMwAqWE5Fl/QrhJWUOVbigE+e90oc3uNu7bd+Jm9OWIH
         lcPjKRxdXNafNQfefZ472+fMMRMCrdSUNiclbtN/nnFFqo0yAKa/dm0ZU1cmfBqeCPLr
         Ygxghvhwmek0ChA1nEW1D/4g+88oXgmn5tlKCNzqZYa5p5K6uBoqWEy0//cNjdhOHJcD
         XzsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775861761; x=1776466561;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YrKkg0df3B45xT5iemLm+oOcy+sqgnc1QFtLLaVMsZ4=;
        b=PSJB5Xm0V0o55UJc4i9GXVNIjl4gb4Xnu5SJMMKNKovW44B2c/bu2R4hkAypYakgea
         lj1U/YrvR3gOoqpgUN+dbp0lhulW/ou2sHwgaXC0b5iJX/Y9LpmmkVRSr9aDA7k2GtYA
         tIe4XtCmk1mEw0IKXkiJoTz/p7OfP39580+JnDkyKVlun3gttEl5gGYMZcBbDJ3oXxk6
         7tutF8btY+y4vP/J7Qs4OoB6sP88oRMKpkeTMxOOEq2H5AwYI5hShmBCor6Oz4zFxjgl
         Jo70fupyinXCMJCAoyYNezo/S+mOr3AHSVHBOodCiE0dCHDJDWFMey6h92VQmsByxetK
         2T3g==
X-Gm-Message-State: AOJu0YwUUitLDMKzzuXPNFpKgDMYovZYFMMwmPJRnABCcnbGjcpqkXHC
	4pKkaof0MgBbF/HrSJDVgEXCfwCUxZnEa+ZDdkrxV6905oWsG+sWLOvEYfrob0wlSBQ=
X-Gm-Gg: AeBDietqsd7Ukn4QeBMxmJ1Uq0BbHdRuw2Uq55OJqz3x/3GU+0jPSR3CjyeXNCnCHaO
	9aanQx9IDNWqyyGJIhd4vZu1zlmc111fil9bMT/n1jUYNgs00uFb7f1MN1pbvMldxjb9TWPEsoK
	zAa3Nwh/6DMb12MxIF3th8WeZyXv1gNE6PLF9VxDppuJVgitoQXLJXNtdhUB4TmRhi+Gg5ZN44O
	yqICGX5TgKOJD9Y4/g/C454rKSBmwNaUXSAHbUX0M67/HUKWCsGW5bExO6ENCVHrhJy9pYF2dpY
	ZZ0VTxAovCw2mkNRzUXvJ9HhaStE7kppIkcRbJhOeG8gQTyA7HTjCCX98eCu6VWqyIIzmuVMUUo
	WokAP2wUFBHn/KP96mgFemuEU3b0p9MlglJwxmgTUQ1K2B8KgZbcFEOO4ZnUbOzf9jkDRsCjSpV
	EXNru7uVW1St9IJnZw8JCLzgcehKxjARmhbRCMQZXufrc=
X-Received: by 2002:a05:600c:a30d:b0:488:d376:42cb with SMTP id 5b1f17b1804b1-488d68ab1b5mr47297655e9.30.1775861760925;
        Fri, 10 Apr 2026 15:56:00 -0700 (PDT)
Received: from lorenzo-VM ([84.33.160.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d681f28esm29233315e9.16.2026.04.10.15.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 15:56:00 -0700 (PDT)
Date: Sat, 11 Apr 2026 00:55:58 +0200
From: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Tian Yuchen <cat@malon.dev>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Elijah Newren <newren@gmail.com>
Subject: [GSoC PATCH v5 4/6] t7700: test for promisor file content after
 repack
Message-ID: <f631993c89586a87d7e5f08ca4df1502d5228464.1775861047.git.lorenzo.pegorari2002@gmail.com>
References: <cover.1775832056.git.lorenzo.pegorari2002@gmail.com>
 <cover.1775861047.git.lorenzo.pegorari2002@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1775861047.git.lorenzo.pegorari2002@gmail.com>

Add tests that check if the content of ".promisor" files are correctly
copied inside the ".promisor" files created by a repack.

The `-f` flag is used when repacking to ensure that all the packs
(created with `test_commit_bulk`) are repacked into a single new pack.

Signed-off-by: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
---
 t/t7700-repack.sh | 60 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 63ef63fc50..186a931ea7 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -904,4 +904,64 @@ test_expect_success 'pending objects are repacked appropriately' '
 	)
 '
 
+test_expect_success 'check one .promisor file content after repack' '
+	test_when_finished rm -rf prom_test prom_before_repack &&
+	git init prom_test &&
+	path=prom_test/.git/objects/pack &&
+
+	(
+		test_commit_bulk -C prom_test 1 &&
+
+		# Simulate .promisor file by creating it manually
+		prom=$(ls $path/*.pack | sed "s/\.pack/.promisor/") &&
+		oid=$(git -C prom_test rev-parse HEAD) &&
+		echo "$oid ref" >"$prom" &&
+
+		# Repack, and check if correct
+		git -C prom_test repack -a -d -f &&
+		prom=$(ls $path/*.promisor) &&
+		# $prom should contain "$oid ref <time>"
+		test_grep "$prom_before_repack " "$prom" &&
+
+		# Save the current .promisor content, repack, and check if correct
+		cp "$prom" prom_before_repack &&
+		git -C prom_test repack -a -d -f &&
+		prom=$(ls $path/*.promisor) &&
+		# $prom should be exactly the same as prom_before_repack
+		test_cmp prom_before_repack "$prom"
+	)
+'
+
+test_expect_success 'check multiple .promisor file content after repack' '
+	test_when_finished rm -rf prom_test prom_before_repack &&
+	git init prom_test &&
+	path=prom_test/.git/objects/pack &&
+
+	(
+		# Create 2 packs and simulate .promisor files by creating them manually
+		test_commit_bulk -C prom_test 1 &&
+		prom=$(ls $path/*.pack | sed "s/\.pack/.promisor/") &&
+		oid1=$(git -C prom_test rev-parse HEAD) &&
+		echo "$oid1 ref1" >"$prom" &&
+		test_commit_bulk -C prom_test 1 &&
+		prom=$(ls $path/*.pack | sed "s/\.pack/.promisor/; \|$prom|d") &&
+		oid2=$(git -C prom_test rev-parse HEAD) &&
+		echo "$oid2 ref2" >"$prom" &&
+
+		# Repack, and check if correct
+		git -C prom_test repack -a -d -f &&
+		prom=$(ls $path/*.promisor) &&
+		# $prom should contain "$oid1 ref1 <time>" & "$oid2 ref2 <time>"
+		test_grep "$oid1 ref1 " "$prom" &&
+		test_grep "$oid2 ref2 " "$prom" &&
+
+		# Save the current .promisor content, repack, and check if correct
+		cp "$prom" prom_before_repack &&
+		git -C prom_test repack -a -d -f &&
+		prom=$(ls $path/*.promisor) &&
+		# $prom should be exactly the same as prom_before_repack
+		test_cmp prom_before_repack "$prom"
+	)
+'
+
 test_done
-- 
2.53.0.584.ge8720aaf12

