Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3F41E201E
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 20:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729543699; cv=none; b=A8F6c9QgBTVHrV6OlyhaCnxXU1Ro9OM1AbGZ0wb4tOZxdcHFhu+eEa3YN2zqNCxUezy9/tTMVTaumDeGWA8ur4k4llduo91tpwYGZG6a0xSR9226PS5PdpV2QzBOD66bKSww6CIg7IMHAlwAZTbE6KhSpMB/8NP9nay5A1NonY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729543699; c=relaxed/simple;
	bh=l53XHY8ZLYBiYkJ2EMCs7r0TzULgKT/LpQf8xebPQVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TFssKg2gIo2O1LEXRwTd322FY5bnWXE1AGKKhL+sveb7B6//YFFoOTUGg+NrHvuIzJsAkFvHh1xjjXc9DSPKyXWeR5N50ANOz4ZGIwMX91pS0VFZ51RzuIzGIWG16S0Y3YHxLW7HIGmtQBygYCY0V6458rCFyhECLEPwsrjWP1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=QmKb9Ncb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Pa8Yoz5h; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="QmKb9Ncb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Pa8Yoz5h"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 370671380462;
	Mon, 21 Oct 2024 16:48:17 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 21 Oct 2024 16:48:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1729543697; x=
	1729630097; bh=QcxGRNP6B7dsX9oev89eC/C6hlDoXeyIADE61IYEK+Y=; b=Q
	mKb9NcbGoU1aC1lOfXUEEHqFFQDTujHanORez2XTRfKE/4u/rDRg8vCxkuqxF4VS
	BmROqv363gOKwU5nObaKArH+WIW0pcpQUterSXqlUK++nbqWMW1lafmR6dy99mNO
	TXSjl5BYFvtwoDqRo/30KJGenhnmDIZgQXs4ILImKOjnIbNuhYqOaPH8uHzhzdhT
	MnW0V3bWY+ZWY5Dk7V9/vMqg6Aw9WkZnYIBKEbX4I6AUcuesbU2zkhXijplf7JEr
	NiV9A3/zxGj7so8OW8GI18viQ/CF+kyJGnMaFi3ZI968Mt6lIypMpuoWfovgFvGq
	ImV4+s+b8DkxAfe1SV1cA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729543697; x=
	1729630097; bh=QcxGRNP6B7dsX9oev89eC/C6hlDoXeyIADE61IYEK+Y=; b=P
	a8Yoz5hs7+2YEBmfuAJS5MhJJDygPp9mSZggHy1wrP9xAcph1N16135CEs92RKNT
	2PifkFzA52pxWf9w9QcoOmtZ1xpbiQdy8UCdMA4FXGyuMC6cTJC66EmAOhtvKKm/
	t5fOd/nMXHHM9ARuWlAnOUwSNmhK1Zc3soczx7oD1W7+m2OXAkfqH97dFvqQOgMQ
	rQqy3haszETgu6AbnwrbXSQ7NSsHzI061un5h/9WeUby8D+4RgYqgqor6i7PaUXB
	cWKHCBtiqVH8lrxcOIpx7D9S0TRYueesdbCJiqmfQnmDYXdWt93rpkhy2UQvZvnp
	q9O/jr0DwcocArlMWDL3Q==
X-ME-Sender: <xms:Eb4WZ1LdGitNLtB4dxcQ0Z3Y79otLNLRu-lT69KxTnO5gd1zGpgvFJg>
    <xme:Eb4WZxIE1ug4cjvSmQFLPIaaRk3mES1tpB5JEL9mSKvNZDO_WHFFgbxtm7-taF10B
    zYCljcSs0_0r9MQ9A>
X-ME-Received: <xmr:Eb4WZ9s_wL5B43QR4KA0adScCWPZpbmXjJDt5N6ROvWZstDyCo3uUxisPDaOk_yUtPHKzW84rrlIYBy4VRcXjMvJ93cPpUX7izb0Oq2Ej3KW3yKYSCJDRXeKug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledgudehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvghrnhepfeehte
    ekfedtieffvdejteeutefhuefgtefgtdevhefhveffuefftdehiedtfedunecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvg
    hrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeek
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhr
    tghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopegsvghntggv
    sehfvghrughinhgrnhguhidrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeekse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgt
    phhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhm
X-ME-Proxy: <xmx:Eb4WZ2ZeAf6KFsLSGvM1S7SINSCy_vg9wYKt7Yri_SbyjanTRHvsdg>
    <xmx:Eb4WZ8aZsBdELcEQW65K1dCWrcXB513i8xyJyTCQJRqdOqxJUZtRcw>
    <xmx:Eb4WZ6D5x7cOlk05u-q_vvYVr9yFZTGy1deaJmqKflexZQAdcLTDhg>
    <xmx:Eb4WZ6aaiDx68FdFXam-cfDb6xRodPZIArRTElvYcwCIP9UFBCpDOw>
    <xmx:Eb4WZyPVOjZQG0DBxroffUbQHJdirT9VUz-FjTYSXanBHdJbfYtQ6X5f>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Oct 2024 16:48:14 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	phillip.wood@dunelm.org.uk,
	gitster@pobox.com,
	bence@ferdinandy.com,
	karthik.188@gmail.com,
	me@ttaylorr.com,
	sunshine@sunshineco.com
Subject: [PATCH v3 6/6] Documentation: mutually link update-ref and symbolic-ref
Date: Mon, 21 Oct 2024 22:47:29 +0200
Message-ID: <aa1ee4a8ee08f623b2b85f68a141f188364243f4.1729543007.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.46.1.641.g54e7913fcb6
In-Reply-To: <cover.1729543007.git.code@khaugsbakk.name>
References: <cover.1729367469.git.code@khaugsbakk.name> <cover.1729543007.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Commit-Hash: aa1ee4a8ee08f623b2b85f68a141f188364243f4
X-Previous-Commits: 9e775a65eb3ff49ded231aeeeddd59ccdce3c8a8 fd3c7585a0f84b26debcc216b86dc09acb219799
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

These two commands are similar enough to acknowledge each other on their
documentation pages.

See the previous commit where we discussed that option-less update-ref
does not support updating symbolic refs but symbolic-ref does.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/git-symbolic-ref.txt | 4 ++++
 Documentation/git-update-ref.txt   | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/Documentation/git-symbolic-ref.txt b/Documentation/git-symbolic-ref.txt
index 761b154bcbb..33ca381fde0 100644
--- a/Documentation/git-symbolic-ref.txt
+++ b/Documentation/git-symbolic-ref.txt
@@ -73,6 +73,10 @@ default.
 symbolic ref were printed correctly, with status 1 if the requested
 name is not a symbolic ref, or 128 if another error occurs.
 
+SEE ALSO
+--------
+linkgit:git-update-ref[1]
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
index 2e85f7ce3ee..8a4281cde9f 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -190,6 +190,10 @@ otherwise it will just try to read them and update them as a regular
 file (i.e. it will allow the filesystem to follow them, but will
 overwrite such a symlink to somewhere else with a regular filename).
 
+SEE ALSO
+--------
+linkgit:git-symbolic-ref[1]
+
 GIT
 ---
 Part of the linkgit:git[1] suite
-- 
2.46.1.641.g54e7913fcb6

