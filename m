Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48C720EA57
	for <git@vger.kernel.org>; Thu,  7 Nov 2024 12:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730980838; cv=none; b=kcKYN97WDZJvSMPVymp/XvJwM12zLSqw8VwBDEcbK8pVJNXmSrab6Tpx+DMpSdixib8ZudIMqf98TCZC80kxF0GjFUdLcgSlIeTK7jbfLQI+47wZ7JMi5tgsBmAHyqLdRgy3CSQ7uKWCGTamONu1AvFzt9dGeD4PIedd/5ePHDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730980838; c=relaxed/simple;
	bh=KzG+Cy74dV0yfG8ccmctCO/ehmhTpGZhtdnDC2vq4oQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fAaE3zrlcw9oXf2r1P+QnR/pVgm23JLcXgQAJ6xEr9Q74hscm202xpF+d2+klzORn3MDGSQKq5xEMEE6tcsEDysh0pY92sk10wybJuxXMJ1AfLeRIPqgrUXEZ84X+PfjiluLePPobI8zJCw9LlG6G9uvQbODRcDJiIBPr16q9w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=PWug2jiT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jo6N4ZGE; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="PWug2jiT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jo6N4ZGE"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AA7A12540112;
	Thu,  7 Nov 2024 07:00:35 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 07 Nov 2024 07:00:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1730980835;
	 x=1731067235; bh=+xEenxsIPpz29lxLbdBNbR96cIo/BfUwL/XzGM8/jw0=; b=
	PWug2jiTOp6WZBVcPBibcnEaN4UI+Uwgq4U8qO/RF8ZORGQ5anE9JZFb9SIC433q
	qxWGSoechmNjqhRR0vRS1qllMF9p2DomHij86jw8XSczRxLUDsrIUNDxPz3u+V0/
	/YivIOTm862aiwzrcQUEdk/dNNDeLZle6x67KVV/mYf3psyvfv3nqKKnBTVEijcv
	f6OraN8TD819jiRfiew0CTXfAA0xpP6sQZYuOH6K1LHFLvhbVAlUtzthScf8/J1P
	78X9SZ7B3FhTnzk0ZDBSwULboDeF9NSBhH49dtzhGXrzR2a5Q8A2jAViBviWoKC1
	Dv9I0X7SFqCaZNr0Bwi6kw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730980835; x=
	1731067235; bh=+xEenxsIPpz29lxLbdBNbR96cIo/BfUwL/XzGM8/jw0=; b=J
	o6N4ZGEUBaZKT94bw5GjQi04AFtmYBxixmjEzW0jpXsocHj8iQ33PJZjJeqTMUK6
	zsbYhfwIBrIFDDsRYSEgSesJYfSYxTpgpx8EXU+xad7lFWEop3swLD6oYCve++JV
	R85FG1q9ppJKzurAoLUrkex+unEarsbIxdK/48xnZRlGHOUpqnHUxg3Zup55tGDl
	sBoyMfi2Oa+UXCuDmi+OI0ChdUNYy9ZOK3CI7sl187IN2MlcsczpzlRzi3VQ7thL
	e7bmA0nCXZXiAnVn3T5HodQyj/WJjP3Usn/Q60QEDBZAfL90TQsh8QJGi41Ey5BA
	iaxqoWPfHvCX/nvixZayg==
X-ME-Sender: <xms:46ssZwxUPUg9ExIk04vEO5mrZdR-3GY3M6AwJGyiogDpmUBk4fPBcfY>
    <xme:46ssZ0StpQbr5eSznaLnnpK6-vCL2iZDj1i-_s-W25SlBoBEUhcCtHjV0xCZ28Cki
    _luggacBoGBxVYntA>
X-ME-Received: <xmr:46ssZyU2RljMLsBF9iLgS4FcOgNEKMk1_Nt-8KfzpSUWBM5aQmV7PzIJ64BKlp7ioL9u_DhBm3NAdurB32SGj8xeqvZXXI6tKLrYgu0B7yumOb2k_qdfT1tXSg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdeggdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefuff
    fkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhenucggtffrrghtthgvrhhnpedulefgue
    eiueetkeelieefgedufeehteekhfejffekvdeuhedtvefhkeeikefhgfenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgr
    ihhlrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghouggv
    sehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtoheprghvrghrrggssehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:46ssZ-i3ie-BxgtSYvIMMDnsozrm1jNob3uQmCuAVhp3GQO13OHJmQ>
    <xmx:46ssZyCCAa_i8P2j6ss14ajOABUXH4StL88J0WgN7IP29QTj9P3aow>
    <xmx:46ssZ_LD8xT4_qctEy8iTfflsrUgVUqS888XsRH4FX44suhFQ1ai2Q>
    <xmx:46ssZ5Bri99GgHg7gbVNS5Y4vvaJ2OT-p9XFWGVfBfHypKY5w1i_EA>
    <xmx:46ssZ54kILPzA_duxxtw3mcKKQ0oKFXMe20b3nEi9Els_4lqqeuF2EbL>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Nov 2024 07:00:34 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	avarab@gmail.com,
	me@ttaylorr.com,
	gitster@pobox.com
Subject: [PATCH v3 2/4] Documentation/git-bundle.txt: remove old `--all` example
Date: Thu,  7 Nov 2024 12:57:34 +0100
Message-ID: <f0dbe356ca6de395475df348ebf81c848b3e59d5.1730979849.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.46.1.641.g54e7913fcb6
In-Reply-To: <cover.1730979849.git.code@khaugsbakk.name>
References: <cover.1730234365.git.code@khaugsbakk.name> <cover.1730979849.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Commit-Hash: f0dbe356ca6de395475df348ebf81c848b3e59d5
X-Previous-Commits: e9be866f33daab2d4038f8b3f1140fe41e5f49c5 f7d9aa89c953ca7d15b5047487b4347ef62e77a9
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

We don’t need this part now that we have a fleshed-out `--all` example.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v3:
    • Moved over from previous patch
    
      Removing this mention was first suggested in the following link.
    
      Link: https://lore.kernel.org/git/ZxbIWEGS1UB3UIg+@nand.local/

 Documentation/git-bundle.txt | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index f39cafee927..724534a330f 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -202,8 +202,6 @@ It is okay to err on the side of caution, causing the bundle file
 to contain objects already in the destination, as these are ignored
 when unpacking at the destination.
 
-If you want to match `git clone --mirror`, which would include your
-refs such as `refs/remotes/*`, use `--all`.
 If you want to provide the same set of refs that a clone directly
 from the source repository would get, use `--branches --tags` for
 the `<git-rev-list-args>`.
-- 
2.46.1.641.g54e7913fcb6

