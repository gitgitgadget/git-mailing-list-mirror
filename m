Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1BD38DD1
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 17:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727199135; cv=none; b=Y7HVL8gL+6trC6gayd5wLVNGIda92qbDJSXULJR4rTu23EVPAUa/ss1/mP3d6ocb9NJq6LaLlzauPaLvVWg3hWDG3XQc8tn3B1xGwMkFlJ0V3pVU1uFxbbW6IDS1hZhC5YD+yaf4lCM9KtBNStZwh58i94PyXwNKpzTBMMnG8Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727199135; c=relaxed/simple;
	bh=lyuGCn/y2ugP24lDv9u8fU/SQ4YYm60gWGmNJ3OBrsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zmp2mIQQ35TYoOVJhh9pJ50s4TVQQJxygNkHjKMSieLPDRdVt4PcM2gPDYmmde9UDVNiOlzhrXH5FP98sXtqIydlWBGysh2eASrR4KBdykoVcfrYKnMARjejV0hK0uEL2owfl60GfNYnckLI2vgfIYjcab2EaiYuSNS2jZSl3lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=h0d9WREN; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="h0d9WREN"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e1a74ee4c0cso5147605276.2
        for <git@vger.kernel.org>; Tue, 24 Sep 2024 10:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1727199133; x=1727803933; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NLFXXCQeg2YweClnyjFgATxeHCWdKZtflN4MsinISps=;
        b=h0d9WRENlrNAR0lr+sIOE+D6GC/ThE7KdTC387K5WJedTflo86O/MlQIMkVBD+LA6t
         UXeEkKxhTs5vYHTZMy1uYmPELPX9ZorAGuiaVu3lT6jC8ncdgXe3kFtpp2ZjZOc/1uW/
         tJpAJJOfmIhSKKoGPEX83WYyUYjoaSyJYHGsVLnpjXMHxsqNhLV3rnOP7JHhbX61S8Jy
         +DsuQdI0LdKN1iiQVh0lpRp1YKEnWb1J2RHQnPKHba5gJlDUcHuuud96inmGSnvJrQrk
         +/11vkzW7/tiS0fr8chK+dMlM9XKM9QnQ/8Q/p46JoCDD6+PtH3rT4jIs3ZtYB0gb+hb
         wSGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727199133; x=1727803933;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NLFXXCQeg2YweClnyjFgATxeHCWdKZtflN4MsinISps=;
        b=a8lBt2oSt3LxA9Ni30HtoGrCiu6DFehHuILxl0HvrL3yzazjLzbKsy29X4abA7UHM5
         gEXOUZQ9NIuXExK/xW2dN065XCtePfy9R7sU4v8lLEmDuDaaRdIDtiBbBCKEyyRfZkq+
         sBb8EwqJhvGZW8WEQ+a6YfkIUmRGbU79PyantD0fvK3izkSDnOZxNglOPqcmrItt6ReB
         Ep+u7A1oMu4PgFtI3IeIVkthENtunp4t979jQLFqaenlUw06fiJLzytsfnNkgeugYB/c
         XdXROJa7qsqY+WHNOsnD7E+Cw3XreZb/NZzptlHnLkSJWC+cn6CYnwCT96o49YdHd0s3
         xKDA==
X-Gm-Message-State: AOJu0Yy5YZBo8bEtXK2dr6gdJZdUoJ8mP8nFxxYuTlETaLOfIrzlOkLB
	BGvtv0sl5gbf/qmUy3PYt5F37VGKU555USiOfyebotjBR/8lL4r63ZlhbONrDxS+QociB9XOHAO
	snXU=
X-Google-Smtp-Source: AGHT+IHw4DkIUM70qBsyTvgrPm4Z9JTaRt0yT9BlkXGmRQcARQZ9KzLMIntZ+g8/g5SkE2n2xUUGbQ==
X-Received: by 2002:a05:690c:4246:b0:6af:fd49:67e0 with SMTP id 00721157ae682-6e21da1e9eamr1102417b3.46.1727199132820;
        Tue, 24 Sep 2024 10:32:12 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e20d04a335sm3103407b3.47.2024.09.24.10.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 10:32:12 -0700 (PDT)
Date: Tue, 24 Sep 2024 13:32:10 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 1/8] finalize_object_file(): check for name collision
 before renaming
Message-ID: <6f1ee91fff315678fef39a54220eae91632d2df9.1727199118.git.me@ttaylorr.com>
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

We prefer link()/unlink() to rename() for object files, with the idea
that we should prefer the data that is already on disk to what is
incoming. But we may fall back to rename() if the user has configured us
to do so, or if the filesystem seems not to support cross-directory
links. This loses the "prefer what is on disk" property.

We can mitigate this somewhat by trying to stat() the destination
filename before doing the rename. This is racy, since the object could
be created between the stat() and rename() calls. But in practice it is
expanding the definition of "what is already on disk" to be the point
that the function is called. That is enough to deal with any potential
attacks where an attacker is trying to collide hashes with what's
already in the repository.

Co-authored-by: Jeff King <peff@peff.net>
Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 object-file.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/object-file.c b/object-file.c
index 968da27cd41..38407f468a9 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1937,6 +1937,7 @@ static void write_object_file_prepare_literally(const struct git_hash_algo *algo
  */
 int finalize_object_file(const char *tmpfile, const char *filename)
 {
+	struct stat st;
 	int ret = 0;
 
 	if (object_creation_mode == OBJECT_CREATION_USES_RENAMES)
@@ -1957,9 +1958,12 @@ int finalize_object_file(const char *tmpfile, const char *filename)
 	 */
 	if (ret && ret != EEXIST) {
 	try_rename:
-		if (!rename(tmpfile, filename))
+		if (!stat(filename, &st))
+			ret = EEXIST;
+		else if (!rename(tmpfile, filename))
 			goto out;
-		ret = errno;
+		else
+			ret = errno;
 	}
 	unlink_or_warn(tmpfile);
 	if (ret) {
-- 
2.46.2.636.g4b83dd05e9f

