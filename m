Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B413E1DB154
	for <git@vger.kernel.org>; Sun, 11 May 2025 14:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746972110; cv=none; b=I/8yMV8I2nXoPQPBoHiqRANZ6i4opACcNJLQCM2LUhiNHwGYyP9Y4IS2LR1vZlbj0+z9yD/NSnYyXJZJ29A4Fp+JXmed08jLld0elrGZJsKp0T1pQyxmbAEdsiHzf5vv6AbF129AdN0ltOA3fyj4diT88rjscR7WNH6CwJiThnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746972110; c=relaxed/simple;
	bh=0zvYiyMnaQiQ5QabCqGpBW/osAkoDplX8+m4nMpIQ1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OLpS9yzPrJWnzHVtR+NkzEeA9CGzV/fyGJ+99vnv5xlbjwAwD5bkTrgKiRAT3Ivgh6aIS7xZrp6ARmkGGztMzGffZw3IuuXVDxSa3RnUIstqIibpSI7aZ3/4b0NdSbY9RyANkO4aZCLyIVC/afzHMrqSbKcofOC2Be60hW2wNRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sp0TECFi; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sp0TECFi"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-30a99e2bdd4so3128151a91.0
        for <git@vger.kernel.org>; Sun, 11 May 2025 07:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746972107; x=1747576907; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8WNbHhZ2PnEP9BQbDxbZgMmEE99bsX0F6wT8P8n2WTU=;
        b=Sp0TECFiTDyBaf4eCFfusbbVU8NQl6VDnC6EYIIMWJ0seC+hmWP4NsApzX1hbhg6sL
         UrPa6NhvA9Z1DFMSIS6aiJkmn2DExzc8lkdStkBhIK5wi8iieaQcjfI2bOgV7tbKhyoo
         49oTpp965pEsVGJUXkhmXdbxenv9A07Xab9a4E4y4G1+w6YVfoYETK8gINwJVES+L7IV
         KgC5nL5ljAXWIt4wl7dNdWqRE8L28o7/4X9npt3rSsTkC5s5PDHg7Z9P/M1deR+TpiDc
         qKhBdymhCTqbbt88BDnhbTgOitOI/JO/JulKqA4D7dseZ1bXapHCd5zSO7jCyYI/SA5y
         fhow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746972107; x=1747576907;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8WNbHhZ2PnEP9BQbDxbZgMmEE99bsX0F6wT8P8n2WTU=;
        b=GeGmLI90ti8RpoOwkyDReAgibLNg8qsTV2JSxvkT9T6EtEBBghpLLUPWEbdk5Pxijr
         f4gzpNQJT4+twssFNeus0utNkrcXZkUUFNAGhgX7KCYM3HFijH5YcWy0YLewBHUC6abb
         /iHnT3cbEQSadax0Hjq1HqYloZoqxqPqncg5od43l5wRtjb3Vomny4I+53E428JC3+xa
         Cfz/jc736VqFQIAhHayb9aruiC6aB45ktjwl0et59b6Z7uX8hcftyGrgMeziLBl4HqJB
         H6KESeKyxc98AzwbNEx98INs/KRhtlZBs5e/FB6ka8ZOsKLJH5sWRcU7XZqQxGBggBUC
         fCeQ==
X-Gm-Message-State: AOJu0Yz3s6OCsdU8MD1KySZ5nHfVyySGJEulrTpiqBBBzHtV6cXp1vP1
	+S1Yy63A370Watp7KASgFMjR+34g/r4U0P8DfwSc1NMFipl6+J1PjC1EfQ==
X-Gm-Gg: ASbGncs5s2yk5Mw1U7jEMlF9+0/c5ra7IDCGI2zp2VFT1/35kB4YZxyuB4iyuwEAm+a
	UtE7d9nPPNDvBjSOw9DiRAElFHTlb759/002DYZPbEb24l3PElDqrEOuDjDrAj0mMNUSh7hhpHu
	hGp/8f+SavzmasqiYfdMWgwF1pATyV70XYX8xVu1+4iSrZpqMrbb+g+djN6VQ+EAxGNrar7Z/Jc
	neea+/EL5wlH/yWpUjH07MU7OlJuYUy2s8vWhieyMrcn5ySVYTgLAMFbpRgtwg54S1BTHnOEB0+
	XZcbdKQoA2hsPp/Vr+YFu/r6Eac8XEYi1lWKIzx3iZcq0QQ=
X-Google-Smtp-Source: AGHT+IFT9fWOU/Wzz5Bpwe8hu4dq3FeDcZd8LxfOlu11tuSrzOxOEfg/HaCBxvMACTKWWRj86hCx1A==
X-Received: by 2002:a17:90b:4a41:b0:2ff:7031:e380 with SMTP id 98e67ed59e1d1-30c3cff56b1mr15413946a91.10.1746972107349;
        Sun, 11 May 2025 07:01:47 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-30c39dd4484sm4945665a91.18.2025.05.11.07.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 May 2025 07:01:46 -0700 (PDT)
Date: Sun, 11 May 2025 22:01:43 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 1/3] packed-backend: fsck should allow an empty
 "packed-refs" file
Message-ID: <aCCtx2mqihlc0M7H@ArchLinux>
References: <aCCtQDnWII-knmEc@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCCtQDnWII-knmEc@ArchLinux>

During fsck, an empty "packed-refs" gives an error; this is unwarranted.
We should just skip checking the content of "packed-refs" just like the
runtime code paths such as "create_snapshot" which simply returns the
"snapshot" without checking the content of "packed-refs".

Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 refs/packed-backend.c    |  3 +++
 t/t0602-reffiles-fsck.sh | 13 +++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 3ad1ed0787..0dd6c6677b 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -2103,6 +2103,9 @@ static int packed_fsck(struct ref_store *ref_store,
 		goto cleanup;
 	}
 
+	if (!st.st_size)
+		goto cleanup;
+
 	if (strbuf_read(&packed_ref_content, fd, 0) < 0) {
 		ret = error_errno(_("unable to read '%s'"), refs->path);
 		goto cleanup;
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index 9d1dc2144c..e04967581c 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -647,6 +647,19 @@ test_expect_success SYMLINKS 'the filetype of packed-refs should be checked' '
 	)
 '
 
+test_expect_success 'empty packed-refs should not be reported' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit default &&
+
+		>.git/packed-refs &&
+		git refs verify 2>err &&
+		test_must_be_empty err
+	)
+'
+
 test_expect_success 'packed-refs header should be checked' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
-- 
2.49.0

