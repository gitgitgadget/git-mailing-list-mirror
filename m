Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF65F47A4C
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 17:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723743085; cv=none; b=C5bO/atlbegKyR4msv0M4PC9cZQPIcq5dS3ROg62nr6pL0Xl8uDuZo2pJM0FLpIv1Cp2/3d9oEHnVRA/OqNk3t/fPiIuY6+7P7pcxm3uNS9NkRqcVmUlFp4q0ix6SqT96JstHHTJOxjgc9jOwxafyJBJhc1NTf1mUKY2RWa/S1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723743085; c=relaxed/simple;
	bh=Fd7qy4t3TDkFYCO6yq/P53pNTWe82vC1BWxAnCODuGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XNg/04li2BksbZ5AMdw/2xEC7MhrM6jOg7p8rK6f4U7mpim7OqWlSDDRwRS7hk4SYcIra7YNFEqeor8A5psiXed1JIw82PZUT2Ms3VuYYPsJwzfoj6F7WpJqy7vewAa8krl0wt5BJK5OOx1JwXVggcad1KlnrZJICRg/vyS1414=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=V/2SAAxv; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="V/2SAAxv"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-66599ca3470so11713077b3.2
        for <git@vger.kernel.org>; Thu, 15 Aug 2024 10:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1723743082; x=1724347882; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4LsIPCqLZSt0MQqlrgXtc1uo3Darr6zqOp+4k0akDmo=;
        b=V/2SAAxvo0qWh6pVjtWjOaESwqCoa673rc6I927ekoo2KYZJujz9CgW9eLAb1PuIoK
         7pLyf3f3O6M6zTBCIJ/+RIv9Cvb8P6jtybrPxKL0T31R6U4S5BhUbXf+6K9i9koDBqXA
         wSoOhwubu+GZQbaS0owrSOJs/kHqsjukqJpa6XU6r4gEj/zaoWEwQ5rrXt1vJcFm6ACx
         HHUo83sdK+TTZtdBCc7syz+SEsby4LGLh/wFeKXE9ZkmlhFlBznfZpuzl6Ey7mPzVeKI
         xUVYVM7D6OUA9olDN7UATyHydVO5Re/VVdfyZJy6HgFrXW+PZUzST4yEokSim7ka4qlx
         g52w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723743082; x=1724347882;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4LsIPCqLZSt0MQqlrgXtc1uo3Darr6zqOp+4k0akDmo=;
        b=XnArnQ/8xPpIHXQiVjDz7+4TSaFDsANl+nJGxTZ0nSZ5yDtUhg6jH/A78kx81AVMc5
         +V4LWoRmOJi4CpQQ3G2wcyX406PRPAs5wc56JAUUbcdJwo0JT1MsPozCRNcXqkjTILyW
         0VHz59axw4ieXK5zKS4g87qGUONumN95EVQCaq3PlH9Q80VpkBYheBNLOzgzso/4RO6F
         mBW/OVFoyfbSgwQICtMwecXXwvQtRNcBEpOMMX8xNbkgp+nP2s+DZUcun+ekVW/gGfo1
         N8wip8aElOjrlnD1VgMiQ2PoMUtdE16p7q43YI85b0Dro/3abfd1t3OvSv8lUzk5kqph
         lzTQ==
X-Gm-Message-State: AOJu0YwoIoVkqd1Gt5WRDiQPuidPOXzdHCSW7BoOdgIz6IZhTB/YbfI8
	y4zsCakWYK2cLZzD9xVVARtAGbHG8F8MCaXanh46X3G871I8ZC0tmhplRN8ZyydpY/k7MRp0upK
	u
X-Google-Smtp-Source: AGHT+IESMl3Y6fiK917WzAIJi/2tqKilnqGJmHQSzsZEr8F6cXZsSu3I8BUsUuLo1VEAjJrzcNs4FQ==
X-Received: by 2002:a05:690c:d1a:b0:64a:3e36:7fd1 with SMTP id 00721157ae682-6b1ba5f82f5mr3587337b3.10.1723743082050;
        Thu, 15 Aug 2024 10:31:22 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6af99db3f95sm3185927b3.30.2024.08.15.10.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 10:31:21 -0700 (PDT)
Date: Thu, 15 Aug 2024 13:31:20 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 8/8] pseudo-merge.c: ensure pseudo-merge groups are closed
Message-ID: <c9a64b1d2a9d6b3fe1f5fb0a7303e043114fcd8f.1723743050.git.me@ttaylorr.com>
References: <cover.1723743050.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1723743050.git.me@ttaylorr.com>

When generating pseudo-merge bitmaps, it's possible that concurrent
reference updates may reveal some pseudo-merge candidates which reach
objects that are not contained in the bitmap's pack or pseudo-pack
order (in the case of MIDX bitmaps).

The latter case is relatively easy to demonstrate: if we generate a MIDX
bitmap with only half of the repository packed, then the unpacked
contents are not part of the MIDX's object order.

If we happen to select one or more commit(s) from the unpacked portion
of the repository for inclusion in a pseudo-merge, we'll get the
following message when trying to generate its bitmap:

    $ git multi-pack-index write --bitmap
    [...]
    Selecting pseudo-merge commits: 100% (1/1), done.
    warning: Failed to write bitmap index. Packfile doesn't have full closure (object ... is missing)
    Building bitmaps:  50% (1/2), done.
    error: could not write multi-pack bitmap

, and the attempted bitmap write will fail, leaving the repository
without a current bitmap.

Rectify this by ensuring that the commits which are pseudo-merge
candidates can only be so if they appear somewhere in the packing order.

This is sufficient, since we know that the original packing order is
closed under reachability, so if a commit appears in that list as a
potential pseudo-merge candidate, we know that everything reachable from
it also appears in the list (and thus the candidate is a good one).

Noticed-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pseudo-merge.c                  |  2 ++
 t/t5333-pseudo-merge-bitmaps.sh | 36 +++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/pseudo-merge.c b/pseudo-merge.c
index 6422be979c..7ec9d4c51c 100644
--- a/pseudo-merge.c
+++ b/pseudo-merge.c
@@ -217,6 +217,8 @@ static int find_pseudo_merge_group_for_ref(const char *refname,
 	c = lookup_commit(the_repository, oid);
 	if (!c)
 		return 0;
+	if (!packlist_find(writer->to_pack, oid))
+		return 0;
 
 	has_bitmap = bitmap_writer_has_bitmapped_object_id(writer, oid);
 
diff --git a/t/t5333-pseudo-merge-bitmaps.sh b/t/t5333-pseudo-merge-bitmaps.sh
index aa1a7d26f1..1dd6284756 100755
--- a/t/t5333-pseudo-merge-bitmaps.sh
+++ b/t/t5333-pseudo-merge-bitmaps.sh
@@ -410,4 +410,40 @@ test_expect_success 'empty pseudo-merge group' '
 	)
 '
 
+test_expect_success 'pseudo-merge closure' '
+	git init pseudo-merge-closure &&
+	(
+		cd pseudo-merge-closure &&
+
+		test_commit A &&
+		git repack -d &&
+
+		test_commit B &&
+
+		# Note that the contents of A is packed, but B is not. A
+		# (and the objects reachable from it) are thus visible
+		# to the MIDX, but the same is not true for B and its
+		# objects.
+		#
+		# Ensure that we do not attempt to create a pseudo-merge
+		# for B, depsite it matching the below pseudo-merge
+		# group pattern, as doing so would result in a failure
+		# to write a non-closed bitmap.
+		git config bitmapPseudoMerge.test.pattern refs/ &&
+		git config bitmapPseudoMerge.test.threshold now &&
+
+		git multi-pack-index write --bitmap &&
+
+		test-tool bitmap dump-pseudo-merges >pseudo-merges &&
+		test_line_count = 1 pseudo-merges &&
+
+		git rev-parse A >expect &&
+
+		test-tool bitmap list-commits >actual &&
+		test_cmp expect actual &&
+		test-tool bitmap dump-pseudo-merge-commits 0 >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
2.46.0.54.gc9a64b1d2a
