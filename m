Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6176E46AF2B
	for <git@vger.kernel.org>; Tue, 19 May 2026 09:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779184352; cv=none; b=JCm6Q7ETN4NmUVoazJcFxXd1Oa7LXpQdvwfID1Eqk06IrwE+fOzwq2eZCAC5AakL+HGUpjnbIA2Fmmc734p1xOXQZDu1PF7iKcFahT9X/YxWYD7CH81kGZbetpUGSJvUbWOgyrTe9fB6fRZz8IlawF9V0t1w9xPsFZyL4MhKBbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779184352; c=relaxed/simple;
	bh=dddV6MnPc86un1+xHi24S80L9IYZXImNUXRxn3ijHaE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p7WfYa4bV8H7fHAkFnlrYENLQwUysZgT1pTMCfxZaSgrb+U/79PVcdyGuxhi6E0H/kLU4ZJkS4rg9ZUSyeuJG1i6uBw3e26b9+Lyo0XNGCKmBs0tJ2/HDxpL3nIjbEixAZ8RqCtB9d+kTCVG8UQZU7jBarg2xIbc8lsDj+uMXEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JoPsgKjQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D/pcyEzJ; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JoPsgKjQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D/pcyEzJ"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 7951F1D000AE;
	Tue, 19 May 2026 05:52:26 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 19 May 2026 05:52:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779184346;
	 x=1779270746; bh=s6jmm3fUNArNhXujKPVRQEMgoRoBTXSIxJ9fRBvi0YM=; b=
	JoPsgKjQ2Fy7E8lQJ9o9xafYp0dPf6Bq6QClyj8UnDGE6bPvDNCUDq2+Ce66O9Gi
	ufIRn8VtG9n0l1+EhADlbNuciF2VeU7pzpdd8jeOPUZsS3HNPCS54uvqjCuFz/Zd
	pqO5+l7CpwhGosMWt6Toni8z3AQwP40fm8jHpwSbLo/Jcz3wmN27EOcu/wFvA/tb
	1WlEFp6U/0OWg7WID73W5ZET8CKDBgjWpzQTqyUrhqr3kioo5RZol8rBsdV3mqpA
	9V6nYSOw9shczJPp1za3OW9OKclVmKub/sQOdtUfWojjYjrMBXUfvuAOjba06edz
	A/dWeKSos7K5NDUq/J8wHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779184346; x=
	1779270746; bh=s6jmm3fUNArNhXujKPVRQEMgoRoBTXSIxJ9fRBvi0YM=; b=D
	/pcyEzJ/ni/6ViX6MGnAKvOr5rovsB8GHNXz3DISQVimZpXIJ9UiCyARYpmIxi97
	qdTEZ8kSaxxMNxSlkiC3bkmHk6+1JB8i6WlYkGudTVQXdcwqBJi6g1L9FX4Dend2
	cmgiYa4z87zfebhjXUdM87AEAYwMBCMOKA3mxymltN64Z8WgED1hy/TOwhM45qC6
	Pnn+Anpholmp8d9jpFZogDqVVrbTt3oRcY3bTEr01g/Ju9uCD4McRt9zyowwcoTA
	uX5XtywLZXQXLDkCbR7lPp+EVdt2t/mJStrp02K6PIb1qtc4C+wGvAQmVFUyigAr
	RJ6fE5WIVW8pG12irKEUA==
X-ME-Sender: <xms:2jIMaln7ccE4Sm5B7GKuXjK11Uj64BJLHprpK2b84HomK7l_5kGZkw>
    <xme:2jIManvhksTYMyeiC49_AFo5vgBYexV2ikvPwNSP-c8pBJ88uwhbrUVG7chTzBGjk
    eBEM9PmEaFI1MvtpSNRyQVkn-W-M_nlLIZDUJecdxjWncQOyVsylQ>
X-ME-Received: <xmr:2jIMaj8WldNBuh--MLUxsrMXTHfB9xSFWwhc67D3Qp0RCG8vKk4Hjfht9O3CwRjXQvXHg3erUiEWn503z4EL1pwlFcnVn6n6nlLTP15evf0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugedugeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegtrghtsehmrghlohhnrdguvghvpdhrtghpthhtohepkhgrrhhthh
    hikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:2jIMahM9LLKYulkVBaFJi2e6pdYkDwmUVFZWwgVyh15kxLc90cZPLQ>
    <xmx:2jIMahHQTpiTwZJsXmjkVnwPqb3d2ZgBuUCRMLaljFh2whOi9dFpKg>
    <xmx:2jIMavQ2JjpooFfb0fiyukAqSBUHCdgoY1fnVLbYeH_WT4CudTTlsw>
    <xmx:2jIMauvlza6sYbtVptkO8bhrtKrA3j08-lJENnStwEZDRa-gpjUQzw>
    <xmx:2jIMas-76y_V6HPLySZsAaeskcKBz0kHuJctW4rRadviY8HAdJPOPj-H>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 May 2026 05:52:25 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ef1b2f60 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 19 May 2026 09:52:24 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 19 May 2026 11:52:09 +0200
Subject: [PATCH v3 05/18] setup: stop using `the_repository` in
 `path_inside_repo()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-pks-setup-wo-the-repository-v3-5-a00d8ea8b07f@pks.im>
References: <20260519-pks-setup-wo-the-repository-v3-0-a00d8ea8b07f@pks.im>
In-Reply-To: <20260519-pks-setup-wo-the-repository-v3-0-a00d8ea8b07f@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Elijah Newren <newren@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Tian Yuchen <cat@malon.dev>
X-Mailer: b4 0.15.2

Stop using `the_repository` in `path_inside_repo()` and instead accept
the repository as a parameter. The injection of `the_repository` is thus
bumped one level higher, where callers now pass it in explicitly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/diff.c | 4 ++--
 setup.c        | 4 ++--
 setup.h        | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/diff.c b/builtin/diff.c
index 0b23c41456..7ddebce2ac 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -471,8 +471,8 @@ int cmd_diff(int argc,
 		 * as a colourful "diff" replacement.
 		 */
 		if (nongit || ((argc == i + 2) &&
-			       (!path_inside_repo(prefix, argv[i]) ||
-				!path_inside_repo(prefix, argv[i + 1]))))
+			       (!path_inside_repo(the_repository, prefix, argv[i]) ||
+				!path_inside_repo(the_repository, prefix, argv[i + 1]))))
 			no_index = DIFF_NO_INDEX_IMPLICIT;
 	}
 
diff --git a/setup.c b/setup.c
index adad6ceec0..4ef6216e82 100644
--- a/setup.c
+++ b/setup.c
@@ -160,10 +160,10 @@ char *prefix_path(struct repository *repo, const char *prefix, int len, const ch
 	return r;
 }
 
-int path_inside_repo(const char *prefix, const char *path)
+int path_inside_repo(struct repository *repo, const char *prefix, const char *path)
 {
 	int len = prefix ? strlen(prefix) : 0;
-	char *r = prefix_path_gently(the_repository, prefix, len, NULL, path);
+	char *r = prefix_path_gently(repo, prefix, len, NULL, path);
 	if (r) {
 		free(r);
 		return 1;
diff --git a/setup.h b/setup.h
index 24034572b1..c3247d7fc8 100644
--- a/setup.h
+++ b/setup.h
@@ -146,7 +146,7 @@ void verify_filename(const char *prefix,
 		     const char *name,
 		     int diagnose_misspelt_rev);
 void verify_non_filename(const char *prefix, const char *name);
-int path_inside_repo(const char *prefix, const char *path);
+int path_inside_repo(struct repository *repo, const char *prefix, const char *path);
 
 void sanitize_stdfds(void);
 int daemonize(void);

-- 
2.54.0.771.g3ed373ac14.dirty

