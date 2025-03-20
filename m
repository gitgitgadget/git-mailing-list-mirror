Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB5822652E
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 17:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742493389; cv=none; b=d5qLF2GLfQWlV7QXSLYhEHkMJtOrG+g+zi132dli5QNsJgB4zM3BNohttxkoDfPn4fV0sXYH4ms1K+kQY9n9eJ0s+aBA5c2AAaPfIwgF+xNElhszoOLtplUHEBkMyQpBrLpFRuOZKbKoP5h/RRT9vcDRSq/dq/acbysjWVyJDyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742493389; c=relaxed/simple;
	bh=KxLTthee5U4Y3fUySNU+8z1ecvU775a+xOYJpNHF8aM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gcltoDyAJZgpMSfKi3w6nxJsTjri050OzB/5zdGKBMZXXhK+NUMOowHF1QItMHpNxYox7jGY6jxcKHP3c9gwjKkbiAYXGVmGP+emQM5TYUiPCz3a4Y0ABLwUiQ/bg3Q0PKvaeg4NM6gPy+8XS8Gg7DerJMFQ9Ebp3QNxTbTWjoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=k5lRnyT9; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="k5lRnyT9"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c559b3eb0bso56101385a.1
        for <git@vger.kernel.org>; Thu, 20 Mar 2025 10:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742493386; x=1743098186; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4WkR0UuCZVk9W5hpkFegbCPqNJJHGLYVMhyEm/nPffo=;
        b=k5lRnyT9wq18DHJ2KDm7YEvIKE2NcJWX0ktbi8z0pZNZCC8K8AUGRBtoMOT4nr1Ymb
         yltpwNI3eSsittDrbJpyj8Tb5UO2TPsnJ2IbZlssmqZL5UrEQR5S6fdjlQNoyszx0hSe
         7epKZ1sCupaATNggLhhr7smzsC1gwbdWOX2p4taaqtMyuWEVulmWcb81ZwRr/R9v2RKf
         DDXruXC0NdVkgSIPS7nRT0Y/kby3qO1BnLJbDtwAl/fkeZJnxjz+18hFnzOHRouPQ4KR
         WFFO6iDVkSnuNbA+dLIJcGCBmNvbcHwAINVrHI99VJ9DKR/wT6MtjWjCbkqTSQLyl7QB
         7h6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742493386; x=1743098186;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4WkR0UuCZVk9W5hpkFegbCPqNJJHGLYVMhyEm/nPffo=;
        b=mEGOE50uel0GrM7N38eJekRjq5pyGddo0vFoe6ITGhMv+565OgC2971wXLiwfc9HdF
         AGwst7ZkbcGXS03d6zGc4XxFV41D4tBm9tPT4GUGyimlsZMx6uqiH0RjqFyW+LCsFzvn
         IqXki4VsOQG8I98OJkd7eTTMXldmFB1qrqJPBTQDkcDF2AJBJV9AOhQDlO4TMnAKw+B2
         tZ3daKWlOBXxE2/CuJspb2Bo6nG5ap3l9hMMdpuk49Y6Gxu7MuyoHEwk3ZTihn26eVdb
         AvPtfRa19FI+1MEdKrFHEH0AfCc3CQneNqu4JzW3V8+9XWBJQpkdbuBuYMdqYtGbuUgS
         WHxg==
X-Gm-Message-State: AOJu0YxBQ6WcLJaCJCd1JtqUasSxAPMYGReZKvFSZ/GV83Xw2KJTrScX
	kpWVocvr2JmWGHjxi731MNnhVgh1t7Q7ts5BU47BUA1x7I4ywIu9SxgzvJ9CneU5FRDYUd5WIbj
	ZXE0=
X-Gm-Gg: ASbGncsUsENWb984SwkwKzqpt9WkcHOqS7xW2aGflYioiQkIz2cD1YQEuHhqCzy19Tf
	M1lmNaWA9o/gA9/NMD62/wg55WWoMMAc7tzExMUiI1LyDnY1TKAS8fz8ql5dk2d+9A8GTQWBnFs
	qaEU4VLtoTTqLBZm0Se2xqYTpFRXKY6h/I2p0r56LjO9btCRG2hCL0/x35WU3rJWaQ0bomsLH5T
	Gt5+lqt8ONaFcfeQfCNNfj3pOEhDA2jPf0yKVibDj/734zdNrwHDUK5p35BVNjcg7zs1ii+qZuG
	3ZG5yzyrm3jyibMT8RRXkwQm4YI1Ws9DqR/cpjhM09SFxkU8qhUlgVGz3dmRMHnjzF9J0y9FLn0
	IvGkGfsguBK7KJsRO
X-Google-Smtp-Source: AGHT+IGNh15It4Y6fif5Doy9B1gAaEA4GZuELr/aDdAu3Nxqpf5ars5iU3H5TdEiYBaVmPu4sSeFsA==
X-Received: by 2002:a05:620a:45aa:b0:7c5:55f9:4bcb with SMTP id af79cd13be357-7c5ba190bf1mr15396685a.31.1742493386463;
        Thu, 20 Mar 2025 10:56:26 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c5b92b3f97sm16477485a.13.2025.03.20.10.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 10:56:26 -0700 (PDT)
Date: Thu, 20 Mar 2025 13:56:24 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 01/14] Documentation: remove a "future work" item from the
 MIDX docs
Message-ID: <6af65fdaacd5e50cc2e3cc0611d1cf08ef3aa452.1742493373.git.me@ttaylorr.com>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1742493373.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1742493373.git.me@ttaylorr.com>

One of the items listed as "future work" in the MIDX's technical
documentation is to extend the format to allow MIDXs to be written
incrementally across multiple layers.

This was suggested all the way back in ceab693d1f (multi-pack-index: add
design document, 2018-07-12), and implemented in b9497848df (Merge
branch 'tb/incremental-midx-part-1', 2024-08-19). Let's remove it
accordingly.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/technical/multi-pack-index.adoc | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/Documentation/technical/multi-pack-index.adoc b/Documentation/technical/multi-pack-index.adoc
index cc063b30be..dea6486f88 100644
--- a/Documentation/technical/multi-pack-index.adoc
+++ b/Documentation/technical/multi-pack-index.adoc
@@ -167,16 +167,6 @@ m->num_objects_in_base`).
 Future Work
 -----------
 
-- The multi-pack-index allows many packfiles, especially in a context
-  where repacking is expensive (such as a very large repo), or
-  unexpected maintenance time is unacceptable (such as a high-demand
-  build machine). However, the multi-pack-index needs to be rewritten
-  in full every time. We can extend the format to be incremental, so
-  writes are fast. By storing a small "tip" multi-pack-index that
-  points to large "base" MIDX files, we can keep writes fast while
-  still reducing the number of binary searches required for object
-  lookups.
-
 - If the multi-pack-index is extended to store a "stable object order"
   (a function Order(hash) = integer that is constant for a given hash,
   even as the multi-pack-index is updated) then MIDX bitmaps could be
-- 
2.49.0.14.g88b49c1b34

