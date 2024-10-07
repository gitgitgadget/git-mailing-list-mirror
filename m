Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519221DE4FC
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 20:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728332183; cv=none; b=bIZxdJmQorOSo3jQDWa8gIP6TPLtnaRcENvt13MJ53gndyctI7/+716+N2hfpFk6qdHMH744sSZMxa8GoTe++c8SoDjbtoA7OBkCzkKjVDS90J7nrp7YilLcvYxKoc1zOdyjtOBv8EhqanDpYIHOh8gbOLFsIxMQjrmREnT+rFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728332183; c=relaxed/simple;
	bh=nsvgZapsOklNVueRLgafg4/9lgEEeZNX2XMDgS2xM8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bZX/hg4MXYhGb/zBcVlft0NEV6KYTQeXmgpMFC/jQ7nLDBOOJU3jlt4UfyGJARXihC7E3v8TclQdlWcrAbo9NtbWcoH4/AWLyhYSResFnlR+W5i639DRfTAhHqY1Pi4su8POlhUOQFRbf13/uyhDu8GDMkMxA7+BJLRAmcdA6mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=Uq4X7NKa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DHeFJKng; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="Uq4X7NKa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DHeFJKng"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 7775E138038D;
	Mon,  7 Oct 2024 16:16:21 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 07 Oct 2024 16:16:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1728332181; x=
	1728418581; bh=rr3c47RPkSr13LxuZRWabIG18+TCdDbJxmQ9KOPOl/U=; b=U
	q4X7NKa6YruEKkXCIFjnMdNv710Yf6enrSSZnbEk+5Mf95d5wXRl4HXdvWyMujo5
	BCDeZQRCKR+oNbNbjlDWvKEHM3cI8nay52JV9dB+zV4SbOvfwdht4usFg0fo7Lok
	fhBGJb8nmYlHr9HlE8so/8PsN5TOzuvKsphc9Cj6dFR59P+HLtt0qclecmd03Hmu
	sPR9b8rk6Utc1V/UI2NaIvQJ59QBj+PR4Wu4Ir0hoJJPl7e9wOESoqZtRx2RLxUH
	zOyuurWzCy5EyalKHiY2+TBn1MocMjUVHXPIt2RasZbSpjtHo+WxXqbIPvldRZ0U
	x4XI2YVANB6mBBkbSh6iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728332181; x=
	1728418581; bh=rr3c47RPkSr13LxuZRWabIG18+TCdDbJxmQ9KOPOl/U=; b=D
	HeFJKnghJJ8Yf8RqgANxOcy1ZhiFkfQP+jlobzltJhmeCTfuLLd+gqTkzukdL5Ub
	2rLiD+QELdGADP6kIg7MMXVt+vzTFG1WSHKrGbOrHimLbnMNUXZJ42hDooL7ycRz
	fAA18WUySfMdAFMYB8TtM4/jWcPJTFSOIYROkLxYqTEpIsYjSiov6umbxz1WyRrC
	hhUw5apVyZBg3uMMYAu9Fnn1O+BJoPQvxfwafbPdFsiBICEff0k8s0nMOC+FMDMv
	idu4PgMgm85IaeoR+zD12tYFFSk7yZg1Zh0EzITmyJ8zYSX3bUMm4poT9gTOjaV5
	0Sxjdrw3uEDom0CT04n/g==
X-ME-Sender: <xms:lUEEZy5Lh1EKIFIA6NJyIMqniU2NnkX9usSmKAZCVsXESNooPXvufAE>
    <xme:lUEEZ75yhL78EmW5wDuOJm1fzqXPJUVzyIKMHSQw5PUchTkIGhX7DUkBxVVKZFY7y
    IEcd0nBhvJVywYsQQ>
X-ME-Received: <xmr:lUEEZxfnA6DF-cwVJdU8gBVdIlRRRfdQR852amKs8nUXPnsYXCnjXGpHOfmnuca9Md4Uy4-8kfFsGAFfCtuTgaEE3Bego7RrdUizelIQ5uITB91ESTaGx8JNHg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvledgudeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhrihhsthhofhhfvghrucfj
    rghughhssggrkhhkuceotghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtf
    frrghtthgvrhhnpeetudeiheeguddtgfduveekhfevudeiieetjefhffetiedtgeejieeh
    tdfhjefgteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdpnhgspghrtghpthhtohepfedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgt
    phhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:lUEEZ_J6X-MGrtqLhKTBMQGCZx06YoyehtmLso5FZCePvVAeDDLwgg>
    <xmx:lUEEZ2KJeAfUXiLGwOHW_lZX9BriWkdrEdV-QZMJMhBp8y00r7DFyw>
    <xmx:lUEEZwwn_5y2FHOOHS03wywhKYaJmtVAHRLQBmmkCkuoUShOGcVP_A>
    <xmx:lUEEZ6L5Ze94ExoRpDk42n4UWi50gDNQet5M5BZmNQOTCazpulbp4g>
    <xmx:lUEEZy3iiLQtwgAndMAE4lE2e8vxHNIwVW4AUdTbmst22u4JmiYQYhBl>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Oct 2024 16:16:20 -0400 (EDT)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	peff@peff.net
Subject: [PATCH 3/3] t1402: exercise disallowed branch names
Date: Mon,  7 Oct 2024 22:15:19 +0200
Message-ID: <8262b81141bbd36cd7a17e6abe5eb6bb688290f3.1728331771.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.46.1.641.g54e7913fcb6
In-Reply-To: <cover.1728331771.git.code@khaugsbakk.name>
References: <cover.1728331771.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Commit-Hash: 8262b81141bbd36cd7a17e6abe5eb6bb688290f3
Content-Transfer-Encoding: 8bit

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 t/t1402-check-ref-format.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/t/t1402-check-ref-format.sh b/t/t1402-check-ref-format.sh
index 5ed9d7318e0..06ef54c6091 100755
--- a/t/t1402-check-ref-format.sh
+++ b/t/t1402-check-ref-format.sh
@@ -68,6 +68,10 @@ valid_ref 'heads/foo*/bar' --refspec-pattern
 valid_ref 'heads/f*o/bar' --refspec-pattern
 invalid_ref 'heads/f*o*/bar' --refspec-pattern
 invalid_ref 'heads/foo*/bar*' --refspec-pattern
+invalid_ref 'HEAD' --branch
+invalid_ref '@' --branch
+invalid_ref '-' --branch
+invalid_ref '-something' --branch
 
 ref='foo'
 invalid_ref "$ref"
-- 
2.46.1.641.g54e7913fcb6

