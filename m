Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1E8481643
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 16:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785946509; cv=none; b=BJipuPgh4/QeHGEye3f7nvJaDyXxBcwj9M6Aed2Oo1Rflzg/n3gknW42USpGQjClwn39vlRnmY2R6orMwRWvc4J9CdpzGNOaWNvfrNTIthAZgTAPOMrNhNltFSGQKTwJY7T9c89vRIj9BEc3pYu8+zu6Yqxaqde6UTAgmpXeglg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785946509; c=relaxed/simple;
	bh=L3o6qqhQZ7BC68wVWtn+1TSvLcxvxH2z7WmmE0nMvHg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=oFh/+jaSmsZ0CCSyjk6GYpv8KmLAoTXhYfK3fQr8xDH8j8R1/ku8U7urWN379ipvSyKgImYbAJROORy4Axl1BILl3TQLUgFDLj5GTTSquCQ9YMW3ONg+XvONzcO5oz3X33E6yLPsmdawyAfuNuMbfzw3CciH18ZtaSIRUjQg0x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MXHh4scl; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MXHh4scl"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7eb63dbd229so13068a34.1
        for <git@vger.kernel.org>; Wed, 05 Aug 2026 09:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785946498; x=1786551298; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=R7Y3WwE+PJ7Ix9pDJGYCLCOUA7mnFV2SgCNbvcdkvYc=;
        b=MXHh4scl7gBxRAfloWwhbuut1/AuouKy/CRXLp5YKR1qM5nfLwqkO/5174ShC/d99i
         TuGQSA75HIMeIynsoNdvj8EF7wjDTD71eA2hXfg+ob8UBMWPJRA3JTFYzVHOS1qWvdfn
         8nkm0BYzQk6LB76wf1xtacobVeT21gu3+hElKJod2URI8NffJEPudavLeqdmm5gt/HLR
         BpsStQj+cW38Ur5H45Mj3WI8ROtUowJL8nBADp4mMXR7d8lAeOPj8frzoPz06rBqRwpJ
         M0OAX9dUU99xciCAuZ+fFJenKyO+7f854tD02iXbljL3k7l2+Vje7OIPK7Dct47IFsLw
         6+0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785946498; x=1786551298;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R7Y3WwE+PJ7Ix9pDJGYCLCOUA7mnFV2SgCNbvcdkvYc=;
        b=NhK4i5i+f0h3rUOsPenWcmksZmvbFwLXRRDMYcssbDaDV1dZdWeDmtb8aWO++2PrWr
         Uhv1uyUFUawOIA1R65CgvpMO83vWWn+n+QDf8E62l2RBT0M9rSLVA+6a4o+nNns/Esbo
         zgwC8uPo/9svhk09KfmPN51PFRBYJHzlfOU8tNUdfaSLEnLdGOLQQw0injPo/vIV1Ky6
         xNEPzoPMq00iBa0AzDmXhwzpXsDAJMZ/LL8e42ihbT/u8OsvbdFomR4dD8rTOpHq78L9
         JxK2bKtUxXDOuDW8jnh6IotnkmZucfstvH7FfQ1f2QS9lMPoD1Sf3TQFfyc8ownwB3Ke
         kWvA==
X-Gm-Message-State: AOJu0YzjAuJerkYsqpUqFi4tQZyhTQ9OR6tJiL7dIlZ3ITg+Y7KRywSE
	Bb6FHRG5X0tHqI9QM3QuInCe951AV/qzibYFLsViYOEuffER3QvJPmN35zXPt9/R
X-Gm-Gg: AR+sD11J/GfHf/L/gSW1pH1EZgCJWG7/pakBXW6ppYYiH06rWI45ChDbfIXUzDHmMeQ
	3+VqjBlx9S9wVgntrTE9/C7M/POWz2QE7WIfEjHhJ14NLtndUqAcGpZtRdRAhYaW4fXNuRgmZAY
	0rRLX3ja8U5jUB4WBBOU/DxcGibT4d8EZtCxqSA0isW9crvBqOFl2pYj0t05uImes2kRFwUi9W5
	DT7bS5GSsVzHPWyqbT9f3EbItKRT/LvMo5DBB5CCz7xrap1O2Wkav2huj5RvrZFeQ43a5tjABDy
	jCfWEzIyqUZl4WXyNFcgz7WEcERrMgsTcW9MxeAISRV0qTwaJA0behb5ww+BZVkY1v0mJhbG5nu
	QnoiLdV+3atDKHYM7isiZ2VcUmFNK2DjBbY9my5CuvYs4+jNESHwH8rjmATC3gXwh/qADc/nMoz
	22+bgfOC4UHCY7LSIF1xP0agERJOCrBPvaQSLDLzSF9wM0lDE2bQ1+KWjkLtpP8BblnCxRDV3Cd
	Pde
X-Received: by 2002:a05:6830:6110:b0:7e9:e5df:5ee2 with SMTP id 46e09a7af769-7f1fef70aa8mr85034a34.6.1785946498430;
        Wed, 05 Aug 2026 09:14:58 -0700 (PDT)
Received: from [127.0.0.1] ([172.212.142.251])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f1df59d551sm3058518a34.20.2026.08.05.09.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 09:14:57 -0700 (PDT)
Message-Id: <762e716afe2b66b8a58a7c3d26ee9e7876710bf8.1785946479.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2175.v2.git.1785946479.gitgitgadget@gmail.com>
References: <pull.2175.git.1783615780.gitgitgadget@gmail.com>
	<pull.2175.v2.git.1785946479.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 05 Aug 2026 16:14:39 +0000
Subject: [PATCH v2 12/12] git-zlib: widen `git_deflate_bound()` to `size_t`
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

All four `unsigned long`/`int`/`ssize_t` receivers across archive-zip,
diff, http-push and t/helper/test-pack-deltas were widened to `size_t`
in the prior commits, and remote-curl and fast-import were already
there. With every caller prepared, both the parameter and the return
type can now move without introducing any silent narrowing.

For inputs above zlib's `uLong` range (i.e. >4 GiB on platforms where
`uLong` is 32-bit, notably 64-bit Windows), defer to zlib's stored-block
formula (the same fallback it would itself use, see
https://github.com/madler/zlib/blob/v1.3.2/deflate.c#L832-L928 keeping
in mind that for large sizes, the `storelen` would be relevant, also
compare with https://github.com/madler/zlib/issues/549 for a fuller
story) plus the worst-case wrapper overhead. The existing path through
`deflateBound()` is unchanged for inputs that fit.

Assisted-by: Opus 4.7
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-zlib.c | 16 ++++++++++++++--
 git-zlib.h |  2 +-
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/git-zlib.c b/git-zlib.c
index d21adb3bf5..ebbbcc6d1a 100644
--- a/git-zlib.c
+++ b/git-zlib.c
@@ -167,9 +167,21 @@ int git_inflate(git_zstream *strm, int flush)
 	return status;
 }
 
-unsigned long git_deflate_bound(git_zstream *strm, unsigned long size)
+size_t git_deflate_bound(git_zstream *strm, size_t size)
 {
-	return deflateBound(&strm->z, size);
+#if SIZE_MAX > ULONG_MAX
+	if (size > maximum_unsigned_value_of_type(uLong))
+		/*
+		 * deflateBound() takes uLong, which is 32-bit on
+		 * Windows. For inputs above that range, return zlib's
+		 * stored-block formula (the conservative path it would
+		 * itself use for an unknown stream state) plus the
+		 * worst-case wrapper overhead.
+		 */
+		return size + (size >> 5) + (size >> 7) + (size >> 11)
+			+ 7 + 18;
+#endif
+	return deflateBound(&strm->z, (uLong)size);
 }
 
 void git_deflate_init(git_zstream *strm, int level)
diff --git a/git-zlib.h b/git-zlib.h
index 0b24b15bd0..9248d11ca9 100644
--- a/git-zlib.h
+++ b/git-zlib.h
@@ -25,6 +25,6 @@ void git_deflate_end(git_zstream *);
 int git_deflate_abort(git_zstream *);
 int git_deflate_end_gently(git_zstream *);
 int git_deflate(git_zstream *, int flush);
-unsigned long git_deflate_bound(git_zstream *, unsigned long);
+size_t git_deflate_bound(git_zstream *, size_t);
 
 #endif /* GIT_ZLIB_H */
-- 
gitgitgadget
