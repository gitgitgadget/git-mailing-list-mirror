Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0014214AD17
	for <git@vger.kernel.org>; Sun,  6 Oct 2024 18:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728240456; cv=none; b=iPwm4q8LAdgD3DFliY9HGKZbehKhplIllxd9hkSWLJfWV0HNRwgOahhsaEIBxo6Ai+60mk6cJ2tomFmxi3hAyQi2gs+N/VoEER5OqoSdnsKdRNF1m6DcfHlr6YHyk7sD5QEnEdkCndm58XQhvNGVybMrW5oENN0lh66YN4K0X2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728240456; c=relaxed/simple;
	bh=ipYpqjlQIgb8y8GmeLaI6Ku95nVldh3QA0kzkkg2Qjg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WSniEAK88ZjSz1FipA7lvv+n+N0pM66+bt6NrpSbLfw0DRCAJ2SzgQZKr9YPjI3dscfbm+Us2p/OFB7FXy4lWj3oYe6POHYdpS7s0iJz0Cn0wphevIF/ySGOwYuDYh/MQTRGD8bD7xRfmDKiCt46BefeYm9hJC6rTo7jX0cQaIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=HQJQZM+J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ti9sKnPg; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="HQJQZM+J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ti9sKnPg"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id C34CB1140090;
	Sun,  6 Oct 2024 14:47:32 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Sun, 06 Oct 2024 14:47:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1728240452; x=1728326852; bh=vTFtuf6ZiS
	KCcND/qPsxn8E83FAXdIDd6QnU5HgMh1s=; b=HQJQZM+JiRqs75eHpVHKHUMR77
	51SSmY5m4gfs3H3z8KD/QmP5Npsrew28ftw6H50sSEVp+yEfGg45EmpzaSaNzuNr
	diio05KE81Qw6w2XqowFlK71irua2lCaiYsbvtpvfpU1uBjU80DcFf9ESP5aVbHn
	UJB6WkgRP32W0+stZlZ/WGY96SGqDWCQ8VrpzdqW1a43x3zkY5cna1KdFpXEU1aw
	PYIUcyZ+OzejwbmnxWkbxCOTA9Uyonmdo4hk7aFdJL2wdLu26R8XTE4kI8y6XLdZ
	+xaoxQKYNC00bskCHoyECUl6UEuzglaRcR2arVetdDX8lFiAKmRRvSi6uahQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728240452; x=1728326852; bh=vTFtuf6ZiSKCcND/qPsxn8E83FAX
	dIDd6QnU5HgMh1s=; b=Ti9sKnPghKwjPMTJ3hUrAFfpeTxCbwtYphUNLfygl26z
	q3oCJ/rOSKu9RxFM6wWcZJ9c25CdJ3AOMHHKX0hCbGKEzavgnzYlBvFPOFWORLPT
	P/dnocncZ6GzNQHxNergvt/fswJC1/RT+Y9nkr9WP9PCl+szR55JLygOP3v/B332
	mlQEcJ0eN+u2cPWR6erJaiQUPzOD0FQxxdIvdCHGK7Hnz+fC1DqQEOdZrqfGB10i
	mutVb8ohc21EWfo9Ner+UG8+mLxBzxGBEia0qZUiy9XhTUnVB1eptXli1G5VgfsK
	MPHxUU591mDBTA6IS6aBt5YnX7/yN1imEFJ9LWeKKQ==
X-ME-Sender: <xms:RNsCZ5mE9iXCtlSzytlKfNB1Va2aeKH_hHdLh4Hz2mPTQ9XX2pUdzy8>
    <xme:RNsCZ00HGtgx0OCRsrQAJNbCx9643htwF0JknO7w6PldFlhpSSkIEN8t2Olpu7h6R
    YQrwKFbyd2GO5RsjQ>
X-ME-Received: <xmr:RNsCZ_qhAN4aIAjXJ5hkp708uyHXJGg6tmbHFh5RmEGeFnOeFRauL3mjjB8-JMd3S2D-4jxHfLT4Lqii5SZQfKp8GBRnnggciSvT32eeZwEiUR7h0hKd97lljw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvjedgudeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fufffkofgggfestdekredtredttdenucfhrhhomhepmfhrihhsthhofhhfvghrucfjrghu
    ghhssggrkhhkuceotghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrg
    htthgvrhhnpeefueffhfekhfeiuddtudduieegvdevgfefudegveelhfeikeeijeeggeeu
    feeujeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdpnhgspghrtghpthhtohepfedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhm
    rghilhdrtghomhdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:RNsCZ5n_JnszMob0kONeB8Yob6u9pa1JsIPGRR9TiYssrgW_NUS4NA>
    <xmx:RNsCZ30OjgRN82jgKa0deWmrWWWZAM2tOB7ZqDYVjD-C2b5dk2p43g>
    <xmx:RNsCZ4sVo9NTbBK0Hm0Gjkci8BUx3UjmmHb-bDiBeTWYQ5KAVTaPyw>
    <xmx:RNsCZ7WfjHr8qJZwQLW9TlCHIAuT6Fi7xLV0Els0QyoBViNLiMEvFw>
    <xmx:RNsCZ4yBJuqsYLqdpFWYoQYOtz-qBv413o4gqCs_QBwxg0XtfagdlLaf>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 6 Oct 2024 14:47:31 -0400 (EDT)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [BUG?] format-patch: --cover-letter doesn't use --from
Date: Sun,  6 Oct 2024 20:46:10 +0200
Message-ID: <95cb9cf15a4f3b17cee5f14fa0bcba9d40a0ebb8.1728239131.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.46.1.641.g54e7913fcb6
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Commit-Hash: 95cb9cf15a4f3b17cee5f14fa0bcba9d40a0ebb8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

Steps to reproduce is in the test below.

I wanted to send patches with my own domain as the author but using my email
provider as the sender.

What did you expect to happen? (Expected behavior)

That the `--from` ident was used for the cover letter and the patches.

What happened instead? (Actual behavior)

The cover letter used my committer ident.  It correctly used the `--from` ident
for the patches.

What's different between what you expected and what actually happened?

-

Anything else you want to add:

See the test.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.46.2
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
libcurl: 7.81.0
zlib: 1.2.11
uname: Linux 6.8.0-45-generic #45~22.04.1-Ubuntu SMP PREEMPT_DYNAMIC Wed Sep 11 15:25:05 UTC 2 x86_64
compiler info: gnuc: 11.4
libc info: glibc: 2.35
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
post-applypatch
post-checkout
post-commit
post-merge
post-rewrite
pre-auto-gc
reference-transaction
sendemail-validate

-- >8 --
Subject: t4014: exercise --from with --cover-letter
From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 t/t4014-format-patch.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 1c46e963e43..41a3fffcd2f 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -2548,4 +2548,14 @@ test_expect_success 'format-patch --default-prefix overrides format.noprefix' '
 	grep "^--- a/blorp" actual
 '
 
+test_expect_success '--cover-letter respects --from' '
+	git format-patch -1 --stdout --cover-letter \
+		--from="Me <me@example.com>" |
+		grep "^From: " | head -1 >actual &&
+	cat <<-\EOF >expect &&
+	From: Me <me@example.com>
+	EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
2.46.1.641.g54e7913fcb6

