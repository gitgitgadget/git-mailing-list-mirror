Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0173282ED
	for <git@vger.kernel.org>; Wed, 14 May 2025 15:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747237807; cv=none; b=Lz+9I1kY2cB37MBdp8/miWF8dNUSG/uAHdvLB2PH3C6tSjWw4a9ola5OQM3gWzs/R3yx0anKSIE27m7FGxxMF82vYZMbGxTgjQBh0bgie5OBNppxAEuHJXwsBl1u/1dvrw6wuUs8VbEgaJYxY/V4uRIwtJh7QecmUFRLDK7WYBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747237807; c=relaxed/simple;
	bh=vun2GvhCmhfq25mudbj0Keo+bne6DhQseNlPA7UnUQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jfl6U7xaXkRfmdSHwRZpys+nXAVgqyiw/WhRpWHkBMxiMfAwV8gkVugkeLPbIZDS0OU2MvWimxkXP8wObSrvLfCEqwNRB2B8gxsjp0QQJebppXbmiYlg+vCzGMOqCMDRwQ+GEo140rrU12VmjKXqA2+33JHdQgZOCsu2rHS9oMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EAR+ZT8n; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAR+ZT8n"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-30ac24ede15so8977415a91.2
        for <git@vger.kernel.org>; Wed, 14 May 2025 08:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747237805; x=1747842605; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jc1FDED3+aLJYLRUa/oNnILUVxqPV6zTQA7E3hJnjck=;
        b=EAR+ZT8nXHCCCew9e9bEeseJlw8T6L/VThR2zypMR4BFDROumzBypowmZJpQFmj7LI
         jWtAFR0G08flWZVSEEHTZ/b0X1BevLGZpNHetMkv//BM7hGflgaEkp1IpplJ53nxtCqJ
         MAMYUuJ3bjXBMQqdFxD/zvC/VRom0XFfBYyPqDOt0s18QADicguW93rn8+5rZoTWoTHP
         evXLI1VXH/EszqjBJXGAu3Majrw5JrDizzCIIhsG3CZuOV3MtCBLYfW6u46QjOpVtMzS
         xD6LJbpPzepcyjgfY+slFdNVvAUO8tuxgNLegf55wfzV70yMekKmZNTTLcol97HLFXxR
         p4Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747237805; x=1747842605;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jc1FDED3+aLJYLRUa/oNnILUVxqPV6zTQA7E3hJnjck=;
        b=YnSA/3EUOG55ICJ41aBKX+D4W+xg7mb1UvE68V7ctAS4tlBHutF2VKG+RaA+2KOBTl
         XNUtL1JW7eGt4WLFLZ8sRcZ3fgXVcW+T6PJb84SK1MOvaT2I5l1+IkaJTECMgcTP6uPT
         FV3W3PxzeRPXoCPBz/3g348/u06AZQhb3u77c/dz3tEG07UHT+sfl2czw9vxRP6m9vcj
         CyizIf15Xiiwy52DdVUWfDGeQBGhIjLxR9iqnubxaClxDGhShhzrZJhvW42v3GqLCVWt
         8aPUNDV0L4xsIdXmqPKxQAlUw6gRLcv6IseLMgJflUYx+aDcYZlNVqrGG6XsXFYd1ME4
         WflQ==
X-Gm-Message-State: AOJu0YzpKW4J9XPklGWp2P4m0h75JPpOHgv9Jgruken8fBzbWZfArJn5
	8Vf2khXRnKdz8mZxNOSciAcT3iyt8auBYtvStzSOdlDXPdNQCH63GyVMig==
X-Gm-Gg: ASbGncvPCiM5Sgd5dQFETVafZGZdF+u0l9mK++JbansrzDjIqVQfuufWYqA47XP5obq
	ntePvISCFnFT1l5v0z/iRAn3R6Wkta5pBwbANM+UyIUwKYldETopREIChRedeWvwJHuhuwKottV
	tRPR6kZiGRylJlS1GDhq2QB+ISrtiQ/F6X37WrtTw5rndduaojrqPajYsqhTcowk3aYSv8eDpb1
	5mLUSCDEHfAwABqZENmEcAdpl3lF10bT/vI0r/s4kwriMEyYOfIfWx08KeMvDZXktgUsIEKsdTB
	kEwfMw8p7n18Q33NFYQ7SGHd04ArM10xmSn58dCUMWSaNGWDvyyieZyq9A==
X-Google-Smtp-Source: AGHT+IHvp1hQ5KFUlXOsz2b0/ETfNAPUwrQ0VMVo4uo5DSHLYAHJx097L3yPCm10x1/PZd+O6mYHVg==
X-Received: by 2002:a17:902:d48d:b0:215:94eb:adb6 with SMTP id d9443c01a7336-2319813efb4mr70139005ad.40.1747237794258;
        Wed, 14 May 2025 08:49:54 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22fc7742ce2sm101295725ad.80.2025.05.14.08.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 08:49:53 -0700 (PDT)
Date: Wed, 14 May 2025 23:50:26 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 1/3] packed-backend: fsck should warn when "packed-refs"
 file is empty
Message-ID: <aCS7wk-ZCBRiHMqF@ArchLinux>
References: <aCS7O8tNekg_u9Wp@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCS7O8tNekg_u9Wp@ArchLinux>

We assume the "packed-refs" won't be empty and instead has at least one
line in it (even when there are no refs packed, there is the file header
line). Because there is no terminating LF in the empty file, we will
report "packedRefEntryNotTerminated(ERROR)" to the user.

However, the runtime code paths would accept an empty "packed-refs"
file, for example, "create_snapshot" would simply return the "snapshot"
without checking the content of "packed-refs". So, we should skip
checking the content of "packed-refs" when it is empty during fsck.

After 694b7a1999 (repack_without_ref(): write peeled refs in the
rewritten file, 2013-04-22), we would always write a header into the
"packed-refs" file. So, versions of Git that are not too ancient never
write such an empty "packed-refs" file.

As an empty file often indicates a sign of a filesystem-level issue, the
way we want to resolve this inconsistency is not make everybody totally
silent but notice and report the anomaly.

Let's create a "FSCK_INFO" message id "EMPTY_PACKED_REFS_FILE" to report
to the users that "packed-refs" is empty.

Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 Documentation/fsck-msgids.adoc |  6 ++++++
 fsck.h                         |  1 +
 refs/packed-backend.c          |  9 +++++++++
 t/t0602-reffiles-fsck.sh       | 17 +++++++++++++++++
 4 files changed, 33 insertions(+)

diff --git a/Documentation/fsck-msgids.adoc b/Documentation/fsck-msgids.adoc
index 9601fff228..0ba4f9a27e 100644
--- a/Documentation/fsck-msgids.adoc
+++ b/Documentation/fsck-msgids.adoc
@@ -59,6 +59,12 @@
 `emptyName`::
 	(WARN) A path contains an empty name.
 
+`emptyPackedRefsFile`::
+	(INFO) "packed-refs" file is empty. Report to the
+	git@vger.kernel.org mailing list if you see this error. As only
+	very early versions of Git would create such an empty
+	"packed_refs" file, we might tighten this rule in the future.
+
 `extraHeaderEntry`::
 	(IGNORE) Extra headers found after `tagger`.
 
diff --git a/fsck.h b/fsck.h
index b1deae61ee..0c5869ac34 100644
--- a/fsck.h
+++ b/fsck.h
@@ -84,6 +84,7 @@ enum fsck_msg_type {
 	FUNC(LARGE_PATHNAME, WARN) \
 	/* infos (reported as warnings, but ignored by default) */ \
 	FUNC(BAD_FILEMODE, INFO) \
+	FUNC(EMPTY_PACKED_REFS_FILE, INFO) \
 	FUNC(GITMODULES_PARSE, INFO) \
 	FUNC(GITIGNORE_SYMLINK, INFO) \
 	FUNC(GITATTRIBUTES_SYMLINK, INFO) \
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 3ad1ed0787..fb91833e76 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -2103,6 +2103,15 @@ static int packed_fsck(struct ref_store *ref_store,
 		goto cleanup;
 	}
 
+	if (!st.st_size) {
+		struct fsck_ref_report report = { 0 };
+		report.path = "packed-refs";
+		ret = fsck_report_ref(o, &report,
+				      FSCK_MSG_EMPTY_PACKED_REFS_FILE,
+				      "file is empty");
+		goto cleanup;
+	}
+
 	if (strbuf_read(&packed_ref_content, fd, 0) < 0) {
 		ret = error_errno(_("unable to read '%s'"), refs->path);
 		goto cleanup;
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index 9d1dc2144c..f671ac4d3a 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -647,6 +647,23 @@ test_expect_success SYMLINKS 'the filetype of packed-refs should be checked' '
 	)
 '
 
+test_expect_success 'empty packed-refs should be reported' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit default &&
+
+		>.git/packed-refs &&
+		git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		warning: packed-refs: emptyPackedRefsFile: file is empty
+		EOF
+		rm .git/packed-refs &&
+		test_cmp expect err
+	)
+'
+
 test_expect_success 'packed-refs header should be checked' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
-- 
2.49.0

