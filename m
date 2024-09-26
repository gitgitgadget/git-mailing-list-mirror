Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9E214BFBF
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 15:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727364165; cv=none; b=XTfNaKZBs6OaqukQ9AN+uPKmoCt0CEYSftGFKHbOod4TqerhtYz3Wiax9YwRa40+Jukne1q4XkmvrmXNWMTB8uq8HgPSm7MutZmXrioxJ2nelPgT2tp3lEgFe6w/0Rgof9pfbFNt5Z7f3UBYQYTSxNZUqgWzidz+Bdo6/OAVzrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727364165; c=relaxed/simple;
	bh=38km5qfmVKzvuvNxohccD4IGEExqYO6kwI5Az3NQtxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d2HWxCA9nJqVZDmjLzJzSQtpE4Zrtv1JYEv9PT8wVeborhA2RcoM21JFwXRweHKN4x7sCMhJwof+wrI6e0Tt8zd9XINAbNJtGt523AeAOvFQq6RtO30RnygXjgct4prB3P1VZGCn5W3KJuZudCHGGiSaUAotGp3i8X3KxHZsJBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=GpjUfscA; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="GpjUfscA"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6d6891012d5so10626267b3.2
        for <git@vger.kernel.org>; Thu, 26 Sep 2024 08:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1727364163; x=1727968963; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A/rI6LFPvKIn/KM6bPhkm4cF+Wnrb0QdVwN/LX0uztw=;
        b=GpjUfscA+/vqOWUlsss7wp3H8mM4o8ZFFqj7Zc6/jOFWM7q5YZB2zyHzPmBwtrvvbC
         NXukl5hjg9eTUj5gZHt1hEAXXZ79Om7xcogpAbYEcLsLoyr1nOols5QKHkn/SK8OvSdc
         sGd3nS5ETn/o6X2/3Nsd5TpbTmXH548w+EEe8di55ZLcU4Uv77KWb3SbbhS3DtaDg+Ez
         IFa78pIcYUpiyu2s1NrolvQ+d3Rq21U/LIzZNduG1VOxlgWoqP7o90gXEN6n5zJzRJ7o
         QedsubLU5EXKX3ntB3GwFxuocJwLNMnGCmfiVgeD6CLr6VitpwqT3J4neYF8b6KZjlfq
         oODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727364163; x=1727968963;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A/rI6LFPvKIn/KM6bPhkm4cF+Wnrb0QdVwN/LX0uztw=;
        b=JZS1KONwEcDiifybCgD5spMGC7RdFpRWGbXOwxxzgsTzzVtmoQRsuN98gVxFxJNYRu
         DQqjn1oc1rfCsVdobnrGFDoqCA2Y1zJvQSZS34PslHMsJrXETH/OAZbxyl9Cnsa4crpQ
         e5EKZfIg943fbNIPKr55CXGmDDgAEzoNE/zu+jHOtS7KYAak3vFG2b6xCYmq5jJy5fp4
         ymEXQIjyxDecCm7Mcclk7/Qyy73dKRoUkUlhVqYRc4vdrSwiykGKvg2zYIJW1pQcOatX
         dXLoijLMsxdmexM/Gc5ORtpUAzWsX4zfR2DAkIUbAN0vipA+/HHT06A73dN5Ve3v0dtS
         0/sg==
X-Gm-Message-State: AOJu0YwyCab5nvDgE7sqM6TxgmUuNgUnU8oN08QYa+2tHZ0pg/HYX8ap
	qQRqpb8ImBVQUAP7DICySxaj/9KX28shsEMLNfydniM8brD7Y+tgZBViOJGLepTwB7IgIkAdVkN
	gmfw=
X-Google-Smtp-Source: AGHT+IG+KgBP6ilsHuD2JDJ8UwHQ8ahEiEDQ1rIdc5WzQlmTxT5ZabfwFYGKLisC7LDs48xnR6W8nA==
X-Received: by 2002:a05:690c:10d:b0:6de:b23:f2a1 with SMTP id 00721157ae682-6e21d70a70fmr57482417b3.15.1727364162807;
        Thu, 26 Sep 2024 08:22:42 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e24538aff0sm142317b3.126.2024.09.26.08.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 08:22:42 -0700 (PDT)
Date: Thu, 26 Sep 2024 11:22:41 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 4/8] pack-objects: use finalize_object_file() to rename
 pack/idx/etc
Message-ID: <611475d83e261c1b1ddd29d5e711a7e2d75e0341.1727364141.git.me@ttaylorr.com>
References: <cover.1725206584.git.me@ttaylorr.com>
 <cover.1727364141.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1727364141.git.me@ttaylorr.com>

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
index 27965672f1..f415604c15 100644
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
index 61469ef4a6..e6a43ec9ae 100755
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
2.46.1.507.gffd0c9a15b2.dirty

