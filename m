Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D141F80BE
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 19:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729019107; cv=none; b=dXBlPxkiRbg4KVfLBg4Iv3uTgouzyzapGmFVaips/yMj9pDvgNBeHFByAFegm0/pgondBBXbX+Q4rTD9x6A16fJZGryYHg7hXHZfru3h6WXCORlIav+FIUq2ai7BsCZQ0mvn1eGZGKAm2NCxYiQMuhuWTIfLl6v4H8mXhBJao3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729019107; c=relaxed/simple;
	bh=z8HdXqGUY5mXcPSq8Zu6DewopHPuqxNZFZP26CAMcgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AkBJI4UDSc9MxK8CKtcaTRd6glat2DdW1v7CPDz55IXG/oR5/iGmAn3EZG3Ie4oxX5Q0RWxOovN/Zw/d8ygOqCdqJyIxV/pu58b9qpp+/RNzlb789DtjMCVexMpAJyg9xKif5oOrmUNV09sB/3dlCpIB9bpLVs4de8qHWB2W8Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=JrdfRQBN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n5GKAorw; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="JrdfRQBN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n5GKAorw"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id DEE791380208;
	Tue, 15 Oct 2024 15:05:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 15 Oct 2024 15:05:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1729019104;
	 x=1729105504; bh=wRxXC2uikfYIstg5i3zgwyPvm+NpX25UmAeVRp9V8Lg=; b=
	JrdfRQBNgtxbvfNyLyIRBrykL6bP9E68knxlH2ILmZBGDQASzs+rncK0DAELVasM
	682ZCnqUrxiqXYwhvMgmqrLt1v1LgpWQc82aYm+7fuEU7lj58kqiBL5Cayj0U+TH
	4Pbu7519ZezR8+0q46faKpm/KRoWS3gq7XgkSPux7W3v534jc7NVJsZGcSiKYqqG
	HY1TPNZgzkCEvGlk+YNb8nfpH6XKO0/yhHGzH45486V4nv+dZhO4cgkZ7VQmYWTe
	iTDTZRq86N2osWtxG2S86Wb3BJrvxMvwK/cjwZayLyWm7hisDpGw2HNLOCyB46Ci
	3O9UHgYDotkyu8v3mOLsOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1729019104; x=
	1729105504; bh=wRxXC2uikfYIstg5i3zgwyPvm+NpX25UmAeVRp9V8Lg=; b=n
	5GKAorw5M9KKrZqZ0GwsR6ak2VNgZs9/Mmlt46uKZ17MdNhSlHwLaP07hJfJpmbh
	/B3H2wONek+h/BeV/13BtXZi41Br8Hyl+i4dLShWZcm58/VoLvuRWvaUaQiJtTSF
	TDwyBcVCCc+FLgeAc//qs2QTVsJM789eUtkt4EXkSYoy9aR7zNurMH9YbRZdm2Sw
	6nttXjrfQD63/W59ecnGDD5MSjSLlo/qr/TS6zdyB+nkvBAHPtX3q9WROkf57u05
	wI7jXuWttFUPsIIPlShq4FoqsbVjkkrn39e2msmm51hggl20J/McCFm6NGENhYDL
	QlWJcW4nB8o0XUzB3g6hg==
X-ME-Sender: <xms:4LwOZ05XO9OjR88KY_Kt38MpwzIUgASkHNJyu7NhzlMNN3AlXJpVdnY>
    <xme:4LwOZ15ckqjR-Zhk-94aQbycJlrskNGvcwrHUG8oJTK4zQm3xJCSUDX9ym1yXP7An
    zzMzVCHlqP-i2ldIQ>
X-ME-Received: <xmr:4LwOZzcgVue06avuce3eKIWh1dU7TVkK3q760B2mNyYKVE2Xgwz_i3ahl8jhcH2GEwsYKhMEieS3USXmQPFDMM2ZjiECNNq2SiTUIZZavg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegjedgudeffecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpehkrhhishhtohhffhgvrhhh
    rghughhssggrkhhksehfrghsthhmrghilhdrtghomhenucggtffrrghtthgvrhhnpefhgf
    eglefhjeekgfetleetjefhteeiheegfedtudduffegjefhkeetudeggffhkeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffh
    gvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohep
    iedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdp
    rhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepsggvnhgt
    vgesfhgvrhguihhnrghnugihrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekke
    esghhmrghilhdrtghomh
X-ME-Proxy: <xmx:4LwOZ5KNNIqtfei8PBhhopAMMcnLT5jW4ApCWn7NUecF3T_SoNbwNA>
    <xmx:4LwOZ4I3bWqhesQ78vm8jV4WsnE7zSEY3duga6GCoR6jP-P6Yqfk-g>
    <xmx:4LwOZ6wKHtkrtrHlInni_5KT_UB44O-u7sn2kslMSq_hPW9tpKdQ8Q>
    <xmx:4LwOZ8KkjuDDw6gPCqL8NWq4jZuqCIG0NnYi2a_Jaa3uCgFsdcTM4g>
    <xmx:4LwOZw8shZM1x3C0TTlNRb6K8v90YujZPKsAKs91sfZpy3SqukteNcB2>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Oct 2024 15:05:02 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	phillip.wood@dunelm.org.uk,
	gitster@pobox.com,
	bence@ferdinandy.com,
	karthik.188@gmail.com
Subject: [PATCH 1/6] =?UTF-8?q?doc:=20update-ref:=20drop=20=E2=80=9Cflag?= =?UTF-8?q?=E2=80=9D?=
Date: Tue, 15 Oct 2024 21:03:10 +0200
Message-ID: <ad9ee00a2a971522968f95dd413deae24839ef71.1729017728.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.46.1.641.g54e7913fcb6
In-Reply-To: <cover.1729017728.git.code@khaugsbakk.name>
References: <CAOLa=ZQJy1ZkQqBoWwJJvL0f+NCP=3SAfyeSNuztgApzNH1mGg@mail.gmail.com> <cover.1729017728.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Commit-Hash: ad9ee00a2a971522968f95dd413deae24839ef71
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

The other paragraphs on options say `With <option>,`.  Let’s be uniform.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/git-update-ref.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
index afcf33cf608..fe5967234e9 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -55,7 +55,7 @@ for reading but not for writing (so we'll never write through a
 ref symlink to some other tree, if you have copied a whole
 archive by creating a symlink tree).
 
-With `-d` flag, it deletes the named <ref> after verifying it
+With `-d`, it deletes the named <ref> after verifying it
 still contains <old-oid>.
 
 With `--stdin`, update-ref reads instructions from standard input and
-- 
2.46.1.641.g54e7913fcb6

