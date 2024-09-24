Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52681AC88D
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 17:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727199146; cv=none; b=NSBpAK0Q9loCV8VvEyB9GekySwR0Oq2d8z69BJOgWA1oLzX2QPKWh3i9SfQ5z4fsIJRAUSdSCmp9yCurADU2WB66VBoQKqEyQQvKz3EVKl+qX8y0sx5j3TVxbPmEXgOofLYmC1P3b9F6F617L9JVUe15yKPxu0+5R5+XV7jOxEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727199146; c=relaxed/simple;
	bh=47viyOdQ+rZFEkFy2ZAwA7b7p3pfn58pQhJKlAzk95k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kw+7ezOjUn5jNUJKNiwIS4U8ZZCxEzUjrCnYZlsafDR2smzpPtSubCm0jEATvmbpSwImSP4sE/bw2jy+Jn/Jq6kCL7aHSkk0NGF6wmKOCTLTn9EbVaxix8VPn3rmduMnttbl9o6OLX7xG0mCh1C8ZnYGXx1dZe2FNwYH4E/L5yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=C8HwDS8S; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="C8HwDS8S"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6e129c01b04so21034507b3.1
        for <git@vger.kernel.org>; Tue, 24 Sep 2024 10:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1727199143; x=1727803943; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n6DPp10fMWHJ8BaJ9Ge3DySgWYiOYFrdeB2UwMuQsKo=;
        b=C8HwDS8SETgyGteKO4sOgdSwSdNAQrKqDzcyPNeR3sV0Ir7Mt9JUqIrexhe84XDOe2
         9aSWhW5rCf9rUGWlr35lKKkDu0ILFkcgSjVxLxHCGXbsEAmi/pybufZLUP4fOjwuVvgY
         BKNybqCJZHh/0OaxuXZCnVlni9qy8//EttaTMbdcLRRy3ecT3KHRhlUH99CaqrLilnbJ
         ThpObF1rOhKoiWMA+et7wb+UuwK+yS0+BUYJjSW6KN0ydvwgUoMODR+mbhCkb6YHz/e0
         0dlh7l6BWcxeI/Als8mW1zPcc5Kb0NOZWsAmkUCTz2aTNobOOZKV4wdiu/35lHb1bNPr
         HHIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727199143; x=1727803943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n6DPp10fMWHJ8BaJ9Ge3DySgWYiOYFrdeB2UwMuQsKo=;
        b=LqBFbVDpQJQ0xtZMnATjiDcEVCuTj72nxHLCyBVMZwlVEhbRl27U5kQ5BwmKp/w6Ea
         bFDBTQr3InsbUF1nWzDf7IB9prebQtFc1xCb4EK6J+4LD0QPZKBhh6iNV6l8QW+9zO2C
         1CHgxTeN/hYQbzOW9+lvDFXHKkpMFL7+G2bHxyql0jY+vvlBWUjt9FS4KKRlFFGvyF1c
         Ey21bcWQT1Y6UqxUunNpon60rJDCMycMHoFTTB2xMMxWY09690wsYhre34U0wL+KFiFl
         WtDAlDtxQHXg3PkPC/hVFqqkbgyPi6/7FBhh6b4ao1vCobN2cDyQausTNq6st+1YDvd/
         kqnA==
X-Gm-Message-State: AOJu0Yzkd9LQkyvTQhl3vjreK2UI7OANBtMcgiK9+I7HWlykVWr2f7WA
	DtM5IcpMyl/maAzYDmw/LL0+CvSLxhlIn/xLp2xAFmenPNbn70h4udTknarw4rRdw+CZmtY4QYy
	Eg0c=
X-Google-Smtp-Source: AGHT+IEMHjKqLBPETsTYKdED3wIciEZEa0C0zyo+of7Yho5InJGjmHbA9gvij7Drujmbt81xgvRivQ==
X-Received: by 2002:a05:690c:dcf:b0:631:78a1:baf with SMTP id 00721157ae682-6e21d6e1c69mr2073357b3.6.1727199143330;
        Tue, 24 Sep 2024 10:32:23 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e20d15ef56sm3138737b3.76.2024.09.24.10.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 10:32:22 -0700 (PDT)
Date: Tue, 24 Sep 2024 13:32:21 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 4/8] pack-objects: use finalize_object_file() to rename
 pack/idx/etc
Message-ID: <3cc7f7b1f67fe823834c36f3be20be8ee56e16a4.1727199118.git.me@ttaylorr.com>
References: <cover.1725206584.git.me@ttaylorr.com>
 <cover.1727199118.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1727199118.git.me@ttaylorr.com>

In most places that write files to the object database (even packfiles
via index-pack or fast-import), we use finalize_object_file(). This
prefers link()/unlink() over rename(), because it means we will prefer
data that is already in the repository to data that we are newly
writing.

We should do the same thing in pack-objects. Even though we don't think
of it as accepting outside data (and thus not being susceptible to
collision attacks), in theory a determined attacker could present just
the right set of objects to cause an incremental repack to generate
a pack with their desired hash.

This has some test and real-world fallout, as seen in the adjustment to
t5303 below. That test script assumes that we can "fix" corruption by
repacking into a good state, including when the pack generated by that
repack operation collides with a (corrupted) pack with the same hash.
This violates our assumption from the previous adjustments to
finalize_object_file() that if we're moving a new file over an existing
one, that since their checksums match, so too must their contents.

This makes "fixing" corruption like this a more explicit operation,
since the test (and users, who may fix real-life corruption using a
similar technique) must first move the broken contents out of the way.

Note also that we now call adjust_shared_perm() twice. We already call
adjust_shared_perm() in stage_tmp_packfiles(), and now call it again in
finalize_object_file(). This is somewhat wasteful, but cleaning up the
existing calls to adjust_shared_perm() is tricky (because sometimes
we're writing to a tmpfile, and sometimes we're writing directly into
the final destination), so let's tolerate some minor waste until we can
more carefully clean up the now-redundant calls.

Co-authored-by: Jeff King <peff@peff.net>
Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-write.c                          | 7 ++++---
 t/t5303-pack-corruption-resilience.sh | 7 ++++++-
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/pack-write.c b/pack-write.c
index 27965672f17..f415604c159 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -8,6 +8,7 @@
 #include "csum-file.h"
 #include "remote.h"
 #include "chunk-format.h"
+#include "object-file.h"
 #include "pack-mtimes.h"
 #include "pack-objects.h"
 #include "pack-revindex.h"
@@ -528,9 +529,9 @@ static void rename_tmp_packfile(struct strbuf *name_prefix, const char *source,
 	size_t name_prefix_len = name_prefix->len;
 
 	strbuf_addstr(name_prefix, ext);
-	if (rename(source, name_prefix->buf))
-		die_errno("unable to rename temporary file to '%s'",
-			  name_prefix->buf);
+	if (finalize_object_file(source, name_prefix->buf))
+		die("unable to rename temporary file to '%s'",
+		    name_prefix->buf);
 	strbuf_setlen(name_prefix, name_prefix_len);
 }
 
diff --git a/t/t5303-pack-corruption-resilience.sh b/t/t5303-pack-corruption-resilience.sh
index 61469ef4a68..e6a43ec9ae3 100755
--- a/t/t5303-pack-corruption-resilience.sh
+++ b/t/t5303-pack-corruption-resilience.sh
@@ -44,9 +44,14 @@ create_new_pack() {
 }
 
 do_repack() {
+    for f in $pack.*
+    do
+	    mv $f "$(echo $f | sed -e 's/pack-/pack-corrupt-/')" || return 1
+    done &&
     pack=$(printf "$blob_1\n$blob_2\n$blob_3\n" |
           git pack-objects $@ .git/objects/pack/pack) &&
-    pack=".git/objects/pack/pack-${pack}"
+    pack=".git/objects/pack/pack-${pack}" &&
+    rm -f .git/objects/pack/pack-corrupt-*
 }
 
 do_corrupt_object() {
-- 
2.46.2.636.g4b83dd05e9f

