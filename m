Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D39920459A
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 14:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767968806; cv=none; b=Wxp+VEqHGAjs/C4MfQOQUfkrZFJ1ml5G6gz6J1Jtvz7Uj6q+I9tPBPLkXzS0LPlz2tQkeVin+RwN1OlBfAoQ+sM68DfT31x1i9Lx8AxXbZx82QHVcWb1AGONM+ILLeb4fQBhnvmfqTZrdKy2EoEwtBcsZN7z1ELthC8u+aeQv1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767968806; c=relaxed/simple;
	bh=yQ/BbPB4YK7ey/NN9BGzuKZcJgJChmw83051pME3GEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XzOlP2p3JEJZwLhbRIzbt0YDoWPyDwLM6iTkAzXI6dsvg3PBGD2y5t0TfMJq0hLeOms14a+riMrXKJ9jsN6YFM+HIblgZEn0gstb4Nv7gAh/S0nWHVTYA8yz6mmPa6tx06jF3GFUMB/ZArAjeph6j1P/3+YS3x2AnFebKG/V2vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=tn8h5KwQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KuWDiOcw; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="tn8h5KwQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KuWDiOcw"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id E0A9D1D00087;
	Fri,  9 Jan 2026 09:26:43 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 09 Jan 2026 09:26:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767968803;
	 x=1768055203; bh=OJTNvxL0HofRu+ELneewz2L7B5FdNvaqVzWbbjFuTeA=; b=
	tn8h5KwQdEGScU0Z81ftWbe5UX3thqbBMr5rLEAEtkOrHRa6XEnOxquPQKGYbewp
	DUI2t+cUb3ztKk7CuVwloglYbIYn2+7UdpNhQ5xRPjh23WrQArYwATpLen8KWk3f
	7gqiFaoWpA7IQEi9PLrM+Cw12Esb+DsVI7uqUuVNRSuCeUH9dbn8RXYDn0wKULkl
	EGsQNH0o9+/EeAVTwuDLVW4VpMpV7rm9Ou9JIlWjuhAtNpfq81kS3+WM8LVXteRz
	40wOfcYo88gLbgp0Qlg5Nj/0MSNB6X7UzrG6izuhtaUB7WBcmc1kq6X/jpAXWKdz
	2XBDUsw4YJwRfI26HKetdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767968803; x=
	1768055203; bh=OJTNvxL0HofRu+ELneewz2L7B5FdNvaqVzWbbjFuTeA=; b=K
	uWDiOcwzNQ00LcD0BFCu3fY3jPu0vturJ6YtOXzdywXnK8Y+tpDj6g9TggD4uOLm
	bTUbwxTVVTpwjbiyZu7PWnU6A5dAZIDG9DslG4w4bBtxsPyUDXj2duo+ni/ormDp
	rJTc21DU242A6llzYB0Oo7MRHm18W4djgyFAOSZrzEVH06NNF9pgxlFsM4eDF21t
	Pdfk3JmgHvMzJXW72qv/eMWixKQTlX9Sr1YaVryjBSndk+V5bJePQuA3WOCI1nUl
	3ccmY+c4R9FJsG2vJ1GgSduwDh4G31QR1cXjBSil1RARAGUNsOXGp1+U+q41F/B2
	0JUFNLdZsoeltUz3fQ2JA==
X-ME-Sender: <xms:IxBhaXNtjco8FRsG2kzCi-BsIHg5BZZCe-s7kVU6-6Gi-ZNO6jh_hyQ>
    <xme:IxBhacj5elxQf6yZ9nSxeeoO9ap-bnSdqE7WAtq-DBcXc0vqflLLIoYUt8ZHLyQRz
    iL_rfAqhyKGIjMwN0BnhyOnwwVWDB0LuMsOUQhxr92hQzjJQua_jXA>
X-ME-Received: <xmr:IxBhaS0YRmocRrkAd1Fh7t_7LqpXY2edv_PH9U2HVvEcEBHH3nP6t3SQz7BVWBrDF_ER-yaPjHSsg87nDEEhvUEgVZ6q--89cfSridI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdeltdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
    hlucfvnfffucdlvdefmdenucfjughrpefhvfevufffkffojghfgggtgfesthekredtredt
    jeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrih
    hlrdgtohhmnecuggftrfgrthhtvghrnhepudelgfeuieeuteekleeifeegudefheetkefh
    jeffkedvueehtdevhfekieekhffgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishht
    ohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpth
    htohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrg
    hmvgdprhgtphhtthhopehpuhhshhhkrghrkhhumhgrrhhsihhnghhhudeljedtsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:IxBhaejuTTZcpBhtaX4BsBhjyT4egB4L7bfznam7Oq1WxMB0HFplYw>
    <xmx:IxBhaad2SeDiPHmzBF0TVMitsSEH-VQMWwWcGBa-ZMXOAwUMDzAJEA>
    <xmx:IxBhaZmiwDt-qA75wXMpYreboiKM-eKb97UuRXPvvA5mIwukBq-wlg>
    <xmx:IxBhabuXUzGc6iLO0FdYuHIxnMCMa5iN5mK-GBITQrWG0EuI4HDajA>
    <xmx:IxBhaTdgx7lJMTLh-64SPzDPR9YWjLcUK2ObJl2wB-IBpxDa8Vqj6sb->
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 09:26:42 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Pushkar Singh <pushkarkumarsingh1970@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/6] doc: patch-id: six small improvements
Date: Fri,  9 Jan 2026 15:25:56 +0100
Message-ID: <V2_CV_doc_patch-id_3.1b2@msgid.xyz>
X-Mailer: git-send-email 2.52.0.421.gc32ead4fc78
In-Reply-To: <CV_doc_patch-id_3.1ab@msgid.xyz>
References: <CV_doc_patch-id_3.1ab@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Topic name: kh/doc-patch-id-3

Topic summary: Improvements to git-patch-id(1).  Fix git-diff-tree(1)
mention, Fix '--verbatim' documentation, and four other small
improvements.

This is the third patch series for git-patch-id(1). This one only has
small improvements.

• Patch series 1:
  • Topic: kh/doc-patch-id-markup-fix
  • https://lore.kernel.org/git/v2-e5ad12cc3b3.1759178715.git.code@khaugsbakk.name/
• Patch series 2:
  • Topic: kh/doc-patch-id-1
  • https://lore.kernel.org/git/v2-38645ea253c.1760369708.git.code@khaugsbakk.name/

§ Changtes in v2

Fix markup in commit message.

Kristoffer Haugsbakk (6):
  doc: patch-id: don’t use semicolon between bullet points
  doc: patch-id: capitalize Git version
  patch-id: use “patch ID” throughout
  doc: patch-id: use definite article for the result
  doc: patch-id: spell out the git-diff-tree(1) form
  doc: patch-id: --verbatim locks in --stable

 Documentation/git-patch-id.adoc | 20 ++++++++++----------
 builtin/patch-id.c              |  4 ++--
 2 files changed, 12 insertions(+), 12 deletions(-)

Interdiff against v1:
Range-diff against v1:
1:  b3883b32d26 = 1:  b3883b32d26 doc: patch-id: don’t use semicolon between bullet points
2:  d96ab8edb3f = 2:  d96ab8edb3f doc: patch-id: capitalize Git version
3:  f7f249d79ce = 3:  f7f249d79ce patch-id: use “patch ID” throughout
4:  28c11153e6a = 4:  28c11153e6a doc: patch-id: use definite article for the result
5:  463c6c60ec6 = 5:  463c6c60ec6 doc: patch-id: spell out the git-diff-tree(1) form
6:  03cc19de8da ! 6:  0b5c10f143e doc: patch-id: --verbatim locks in --stable
    @@ Commit message
             isn't a usecase for the combination of --verbatim and --unstable,
             and we don't expose this so as to not add maintainence burden.
     
    -    † 1: imply `--stable`, disallow `--unstable
    +    † 1: imply `--stable`, disallow `--unstable`
     
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
    +
    + ## Notes (series) ##
    +    v2:
    +    Fix “markup” in commit message: `--unstable`.
    +
      ## Documentation/git-patch-id.adoc ##
     @@ Documentation/git-patch-id.adoc: OPTIONS
      

base-commit: 9a2fb147f2c61d0cab52c883e7e26f5b7948e3ed
-- 
2.52.0.421.gc32ead4fc78

