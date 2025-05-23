Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31092BCF48
	for <git@vger.kernel.org>; Fri, 23 May 2025 19:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748028732; cv=none; b=W5TnQWvTxRZrHNeDpDn03oQKKZlLrjP3vX2M6aapG+UbaMFL1XwQ2W0YTyOPJONTq1TBqdXyUgMGE6Fk540JT0JtJiIq/XfnUGVQeorT4qn3Qpzl6e0vXoXft/QZ8LTg/FcsIlN1n9iGgEYhAcyhTD9Pn+tupMn42cZsIf6nXbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748028732; c=relaxed/simple;
	bh=s5iwhYlBljzBBUwVrGeq9itGwzJHCIcpRjAn1Np6VZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j7HZDEghOUxuAUIbHTyM2JH8L5m1ue0/KSNwE1eWTjSti8U3Axixi3ha8Zw1qq0TZmbw5nQtB7iohpokQnKds+HHUgFxbFQNE4/rYaiehes/dGtMcbBHfHM2fLFjOKHzs6T/N9iJv33yA6MMzESpbgYRO0q4esBfh62UEEZE5O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=xDeRhg11; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H+CtzryG; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="xDeRhg11";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H+CtzryG"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 12E611380410;
	Fri, 23 May 2025 15:32:10 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 23 May 2025 15:32:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1748028730;
	 x=1748115130; bh=1o+gPx2u9QBc6dBO5wlSYwm8A1W7R0BKz4v/p073rzA=; b=
	xDeRhg11ahhirYrRt4clgpYgaDzd+/J5wRtQ24zEL/XhLjlerAqB0HBsmNA6Rg5k
	0AjTBmJFs7WwONYoawsiOHXmaagPrk18rA9/WvQIkjtyTbsJuM9ZEaDO4Nkcx/Oy
	asvokjiNk342uhXMRK1uol/zjJSQkgdkUtL5m6v3h1bVVqI2d2j/ZWf253CCLT6G
	JjpTIB2f4ebgtqGKXyl63o+1vT+FTXrKhtlPBJ+1ruAD44GcdBpwZ32Ov6D39a1N
	zpnjil663pASoJf2si4dVAlVy3sO5Gt/WJgyDgYU7WHnFYE7ra5TJc6PCr4xPe+O
	02ok5IcESM1jCCEtaszgJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1748028730; x=
	1748115130; bh=1o+gPx2u9QBc6dBO5wlSYwm8A1W7R0BKz4v/p073rzA=; b=H
	+CtzryG9c1uwsHYtDdNX8LqrxzCQ5wJyZPAm8uZ4CQhr4Zr+8o9HJOPEn+J7Sv0x
	qAtT44o4UPc6w2I79EcU8zTNgzS6bas+19LmjgSVbDeYorlmNMwXI7rC7hQOS6xY
	8cn6nLGQGOYcJidSVTgWIVpCCc+ZHxb/IIQVZjo1UI6KHPf9fitT93OwrBhF5ywJ
	EJmNBbnHszGhSOje4rVJvaBIsfs21se30sDhx01zgOM5rUC5kjTuCkfbHtE8mjrG
	/2iZ0HIysfM0Pn7kC/ov6/ndw7Bu14si5zTTihiXONajvaiE7VjFRy8jislzUgZB
	EWet9Lbh+QhCd4SO14nkQ==
X-ME-Sender: <xms:Oc0waABbn6tA1imj2zajki37oM-ZgagxKDGfp_Ms4oS-CCa78QI4TwU>
    <xme:Oc0waCjbkWr11xHCbM8AHNa8N4X_G3cwFeiYdz4WESRTdg88ZI3vngp_10eRiTxwM
    Pq6JgV4lwNgL5ORww>
X-ME-Received: <xmr:Oc0waDmYQBsQrHsR70SPCt6gzd0iT79zh20y-CeDvQ-3Up2YGhFHqD1t2B1_QaClmY-718GtG614T4LyOYZqLeloC5feKw4bYEQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdeljedtucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgj
    fhggtgfgsehtkeertdertdejnecuhfhrohhmpehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomhenucggtffrrghtthgvrhhnpedulefgueeiueet
    keelieefgedufeehteekhfejffekvdeuhedtvefhkeeikefhgfenucffohhmrghinhepkh
    gvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrd
    gtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghouggvsehkhh
    gruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdp
    rhgtphhtthhopeguhihrohhnvghtvghnghesghhmrghilhdrtghomhdprhgtphhtthhope
    gsvghnrdhknhhosghlvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:Oc0waGxys6o9pn20cUIhASmLsQ6qzb68uVAKlJrDP_6QekOaJa2_yQ>
    <xmx:Oc0waFSECEdn72lkhIz1DffDFzzGjJvjQnkPPsEGfTvcKUS3mp_qDA>
    <xmx:Oc0waBZs2js8xziPSnAlGjfvceawQf6QS3LHPGgo-abmrQt3R-S83A>
    <xmx:Oc0waORaAeSmIsZ61tj5I07AtOsjP_1IRi91L0Xs9bhmQETQNNAZXA>
    <xmx:Os0waGuB_nhdo2M5PKsYb8DIrvTqn5Rilty4eXrb0QseRx8d_vgochXS>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 May 2025 15:32:08 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Jeff King <peff@peff.net>,
	Teng Long <dyroneteng@gmail.com>,
	"D . Ben Knoble" <ben.knoble@gmail.com>
Subject: [PATCH v2 6/9] doc: notes: clearly state that --stripspace is the default
Date: Fri, 23 May 2025 21:29:52 +0200
Message-ID: <be89c3349d24e47a38f04538d3d1e3730dfc37a9.1748028010.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.49.0.780.g892193c3f50
In-Reply-To: <cover.1748028010.git.code@khaugsbakk.name>
References: <cover.1747763769.git.code@khaugsbakk.name> <cover.1748028010.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Clearly state when which of the regular and negated form of the
option take effect.[1]

[1]: https://lore.kernel.org/git/xmqqcyct1mtq.fsf@gitster.g/

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2:
    • New
    • The `--` are to prevent the new paragraph from becoming a continuation
      of the last bullet point
    • Junio pointed out that I didn’t go over the part about checking
      which variant (regular or negation) are the default.  See the link:
    
      https://lore.kernel.org/git/xmqqcyct1mtq.fsf@gitster.g/
    
      I decided to do this on this series.
    
      Link: https://lore.kernel.org/git/xmqqfrgzhzbp.fsf@gitster.g/
    • The last part of the paragraph is based on the commit message of
      c4e2aa7d45f (notes.c: introduce "--[no-]stripspace" option,
      2023-05-27).
    
      See the review on the patch:
    
         https://lore.kernel.org/git/xmqq4jp326oj.fsf@gitster.g/
    
      There was concern about the order of options:
    
          >     ... One more thing need to note is "the order of
          >     the options matter", [...]
    
          This sounds more like a design/implementation mistake that we may
          want to fix.
    
      This new part is supposed to address that.

 Documentation/git-notes.adoc | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/git-notes.adoc b/Documentation/git-notes.adoc
index 383e8bca685..bad83116329 100644
--- a/Documentation/git-notes.adoc
+++ b/Documentation/git-notes.adoc
@@ -179,10 +179,18 @@ OPTIONS
 	Clean up whitespace. Specifically (see
 	linkgit:git-stripspace[1]):
 +
+--
 - remove trailing whitespace from all lines
 - collapse multiple consecutive empty lines into one empty line
 - remove empty lines from the beginning and end of the input
 - add a missing `\n` to the last line if necessary.
+--
++
+`--stripspace` is the default except for
+`-C`/`--reuse-message`. However, keep in mind that this depends on the
+order of similar options. For example, for `-C <object> -m<message>`,
+`--stripspace` will be used because the default for `-m` overrides the
+previous `-C`.
 
 `--ref <ref>`::
 	Manipulate the notes tree in _<ref>_.  This overrides
-- 
2.49.0.780.g892193c3f50

