Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AF71D1F76
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 11:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728299475; cv=none; b=ZUm8oO/rnV9zyxOcekI4MEDPmUfiHDXC6q6sVVdE8hWqJbzhOcP/Cv9scj/AycnSs/LMQOOAt7sf62VVYi281D047SZQyQeeoclY8NemCHjGZw8d2+stkPip6L4RfdIY8niix8r2vS2OC1ZKjZlOK4At7TgBsHhcLtbHZdMxzhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728299475; c=relaxed/simple;
	bh=n14JmJKHTVeywntAH9fOzY/mzIzFF1DUgtDq29mOFOU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pTHJwNaGKo8RC4ZNP47rwd3whDxJhfxiQK0U70CY9x0dR8vhjE+8y6zheKvIWYN3z5wngy0YEa/GDQoPrdOheePdE2Z1OXNxH3MJcPJvF2Tug3nQrAD83m1pwEEbTJ2zjYC0UfBf48kwDeB4nz1XDVTYK/L8ZNWj0ctMY7SZ9oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=FvcVXSwE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ObJbO/j+; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="FvcVXSwE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ObJbO/j+"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8F4A8114026F;
	Mon,  7 Oct 2024 07:11:12 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 07 Oct 2024 07:11:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1728299472; x=1728385872; bh=bbmllCanmS
	C9Vq5SBAkAqy22YEOFEdykjP8gw7PsjBk=; b=FvcVXSwE4rQVINDmEJ28q7hI15
	sTORJd4yfhOoKQaxzlBkH0ekxQwGBxEImkQWTqHmmhySTmuvIj2xA7SVeuoh4jxA
	/d0EILaHTF8C1Sh/XKGRXa40o/ToUwxvkDYgOXBmFQYEbC1g5U5aE/zD+o8u1weO
	ugfvULryeB49lZp+jt/ws3zF7EwOF/8XmIWQ5S4LKqV5c240QomBw2mt7UYyQAca
	9SWESK9t/WC9urtHrDwKhL4BNRe/qdzql0mjgPzA6aMCP1oVtEZ1ImD2WonuBG9w
	y58wdPptimghvdwrMAJBqmbQUTGdKCR6iEFkIaffAF1L5S4YpeG3t0Otq/Uw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728299472; x=1728385872; bh=bbmllCanmSC9Vq5SBAkAqy22YEOF
	EdykjP8gw7PsjBk=; b=ObJbO/j+SDcXAmCaueu11AU+yEhM1bwrpfJ9ruhzfwPl
	50e3HT4YDZPhW+f7EihTChXpTuLLyLQzQI9W4nfCdaQg17p4R0SLmxMNb8LjaEsj
	9Kwo+fCgKTfytit2oGfIY5HAn4pN7G26jFHDbqxmL1RrIG1IsXZs0Muptkc1bMzc
	UrhbNjp9onl8R41CLxszfnOGuPb2gRYeAGtMQi0RDRYUe1Gc8+4MmrA2VZvkDMnJ
	dnbMfUJyGr1Z1X2mtYcjetpewr5i/9KVq7cCBLhnYoaqNLSMmyNaU5ej0j5xB4hP
	ggZ/81KWCLRVaOZMPrLhUEY4MNXUXmBlscbU2/B73A==
X-ME-Sender: <xms:0MEDZ-OphLW2AlCHkoWGiPJl2b5kc1m08-ys8tq8d36Oj46hFycXtZQ>
    <xme:0MEDZ89jWDlCjwLsbQOS0FcSDWJONMYT0ER1BHLH32PoYWDUp_E-1dTQjIvGj_J-O
    21G_GFoX-EuxAhVVA>
X-ME-Received: <xmr:0MEDZ1TRglApYPzRcng9W5xTXm8vjYoiF7fQzP_0dOBsL6jS3LxD-lWdJkgYB4dC1qoJXjYDib5x4AMBPPDT1SYog9FaGcE8ctnEfS7c5w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvledgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    ffkffoggfgsedtkeertdertddtnecuhfhrohhmpefmrhhishhtohhffhgvrhcujfgruhhg
    shgsrghkkhcuoegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgeqnecuggftrfgrth
    htvghrnhepfeeufffhkefhiedutdduudeigedvvefgfedugeevlefhieekieejgeegueef
    ueejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptg
    houggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgr
    ihhlrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:0MEDZ-sEGOZdpLuN803ll81b6yg5q03Ad-NEfesDtQOwjst0ZcRMaw>
    <xmx:0MEDZ2f-jBsJ26GYjPUu45PIZqU-Irht5T99hJNbLb2f4QRWhdlypQ>
    <xmx:0MEDZy14c8EbwYcOKlhkG1Vw8PzT259vFWu1wAaTLbmFZ0-ZhSwDiw>
    <xmx:0MEDZ68qPF7uoBm3TXbWqW4_K4N4HjUo9l7K99CeCuenx5W2BdmLhA>
    <xmx:0MEDZ27Wr94W0qhtj1oep5-v-9FFD8xg0Z-yraNQB6QqVSZzq0zcz8kU>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Oct 2024 07:11:11 -0400 (EDT)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	newren@gmail.com
Subject: [PATCH 0/3] doc: merge-tree: improve the script example
Date: Mon,  7 Oct 2024 13:10:26 +0200
Message-ID: <cover.1728298931.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.46.1.641.g54e7913fcb6
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Commit-Hash: 4057d6386125e51fd934f92abd11c62a9d24a832
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>


Kristoffer Haugsbakk (3):
  doc: merge-tree: provide a commit message
  doc: merge-tree: use lower-case variables
  doc: merge-tree: use || directly

 Documentation/git-merge-tree.txt | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

--
2.46.1.641.g54e7913fcb6
