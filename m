Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3203D226CFE
	for <git@vger.kernel.org>; Tue, 13 May 2025 11:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747134443; cv=none; b=mqGtakTDujcC4vjSgav/0Mlq5loICTU2WbUYWDPyAVIu4+JTuLb/Gk3pb+qs4wCiEcWAGXd3CI8mPLLxWR2J7aE2SZJwHehZuzIMzgj6KrH5P0JYbMZ+csPDIfzChTzI1hTjWnpnL+57MtDl7UgL5mqTPStBks/9kPy2tm1gH7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747134443; c=relaxed/simple;
	bh=CnCuJsicQQPLgjTNzeC8miMfVv7GaNOYXbazsFhw1TQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q3VRZNtKGsqPPcHGP4McukD/KUqfbP8wunwWW+cHCPeaI6Hxyk5dm0PFPGXgTm31RxJPJGyKOSdJORLmb1auzAlPYTTwEkaGtdI2xutco1xMePyM9WUSTZY3nUFzicj/5RT+b91DdIc0nvxKN69l0TfVqJjWoV3XWdKpSFQsDqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YFt2709R; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFt2709R"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4811fca8658so75812721cf.3
        for <git@vger.kernel.org>; Tue, 13 May 2025 04:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747134441; x=1747739241; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0dVFwGaobldEY+Oe/moDSgaEmOt6lRb6VUohVgS7KeY=;
        b=YFt2709Ru+wZ8k/h9F6CQSDDzYoDrhq1eDw0QoaDyWQrWXp116uUc6mo9cf0W5or8O
         Bx/DCBfZlY2Gyvpe2TkjktFWHBrJCZB/pgS0shtsnoRttDOmodWBIuq/a2BUo6mypq3X
         yjROIWuGkaJZ1ZV6ABZOy/e9xLx+9Qt9BqqmqQVgy2an1gcdYk5JoLuUAnHHTeCHVjP6
         u8ADRddpPDtkBty+wPu3yLrNedxUqNK+IW79laR8/kEMNKQldFsIqovjttjc7rNzN9UX
         YTLwLsOC7YN8A55CRGN5OYEvk5kLCBYmuvOXzetDkmEatod0HVWSTEvQTk0AzyGdtLmr
         dJ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747134441; x=1747739241;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0dVFwGaobldEY+Oe/moDSgaEmOt6lRb6VUohVgS7KeY=;
        b=gnEO7WVX3YQsqtw5teP4IJFn5PkyI9m7MVUi7YOhmu6cwUamnU717IQ4Ic5hcQrIr5
         XVF/R8oOeq09z6z6VwDaoQapE/f4IraEXr8s1N+vT8TU4LAM6gLeMEAWs8edCZGlsOT3
         sa4CVIb8oqlf0T8KpeoOBGmnr36yUZ8OIsV3kqTVl9O7Q4J5ZV+JgTeAccF8ridem8Np
         ou7wBm9f7UDY6tZubhdgfDkbIPqoLlIxZr1xU5vsAfDjTP7rO+kq5TLTaoCdK1McoFdy
         JdH8D2LBHu8u2TfmDQ4aRJN2dL3MvCUHT4DRS4c1/bt+9gU3OUW6pr6wnSwNkxeekszQ
         2G5A==
X-Gm-Message-State: AOJu0YyAJ/OJCvRdWA6EFX/TlHmJm+XVFnm3JZWKcaMZq4R9SQdapJkz
	pywN5tmmPnigGEoVC3sHbIGNUR3itF2DHxLjQCIMGyytnAnQab/hcJDbpA==
X-Gm-Gg: ASbGncvbyXeIk+gV3IWsR6ttVkCXG4KCOKmLdDEXGHskDho+tkRWlFAOOuQgElcOJv6
	j5922Je8TwXfiDtb6iFK2AaoLvvp6i8ijjD8ibHIkkGv4L5ZEPofw336j6xHurJCB1Vd8fUlJFA
	u5qr+oQHSumKimVsW+NYlRgp7rgDe0/jTf9XTp1QVapKoqKxRuAC5xHKQSGrj2Yj8gwrue8+hML
	fkI0X34XH4KZroN5SnoojlJ1+cRWnZNOA9s0WQ/I6dK9egXLWeQCWpg6FRPJKFUnXEjot51v0Nb
	TItSI+7TAUxUYMjMrjix//qPqWJSnHaFbYIgYy1trkur1yQ=
X-Google-Smtp-Source: AGHT+IEDa3VybHXfwsrTFFT3bY4x1A8ZCtEOnGaZzwd6DClyncMSzEuA5GLNynZinLTyiXxtSfXjkw==
X-Received: by 2002:a17:903:986:b0:220:ff3f:6cba with SMTP id d9443c01a7336-22fc8e995b4mr279935145ad.38.1747134429985;
        Tue, 13 May 2025 04:07:09 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22fc7742d13sm78953585ad.90.2025.05.13.04.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 04:07:09 -0700 (PDT)
Date: Tue, 13 May 2025 19:07:40 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 1/3] packed-backend: fsck should warn when "packed-refs"
 file is empty
Message-ID: <aCMn_Ktrg4GY8jHe@ArchLinux>
References: <aCMnrwkoJ2WyqGZT@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCMnrwkoJ2WyqGZT@ArchLinux>

During fsck, an empty "packed-refs" gives an error; this is unwarranted.
The runtime code paths would accept an empty "packed-refs" file, such as
"create_snapshot" would simply return the "snapshot" without checking
the content of "packed-refs".

And we should also skip checking the content of "packed-refs" when it is
empty during fsck. However, we should think about whether we need to
report something to the users in this case.

After 694b7a1999 (repack_without_ref(): write peeled refs in the
rewritten file, 2013-04-22), we would always write a header into the
"packed-refs" file where we would never create empty file since then.
Because we only create empty "packed-refs" in the very early versions,
we may tighten this rule in the future. In order to notify the users
about this, we should at least report an warning to the users.

But we need to consider the fsck message type carefully, it is not
appropriate that we use "FSCK_ERROR". This is because we would
definitely break the compatibility. Let's create a "FSCK_INFO" message
id EMPTY_PACKED_REFS_FILE" to indicate that "packed-refs" is empty.

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

