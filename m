Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB4912B72
	for <git@vger.kernel.org>; Fri,  1 Mar 2024 18:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709316376; cv=none; b=Q2PHgDNnKd+ARARtIMYc9NR3E/5Wb3kc2ogAc/y7JXdHr22mqsAQXhRrhu3UI3DkPlb1AMUbmTIkNsO5nz4SFiVSjvb3Yv1BAWXqkZ7256mRwgPEQUI2NZq5ErEaicjOLxxU2lsL9twO83ghQETZv6zJZumx6gPue0YNST2wFQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709316376; c=relaxed/simple;
	bh=DG8+N0xc6NGBDGrJr4YodQpC1+FPngV5y9r9xIu3x4U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b08VmM7WQMmF5fuDkjRZYvIzjYQPQ5FlE01+/ef6yO2rDXnwk38NcOeVTJKYJkGXWGnzBalCIHv9+ooJpKbHtz10ZaylQrBYjp8a7RBolh1GJ+qyf2e8InxoefUHnpMPAa7rNNmZYAnWF3x4X14GfsK6+0eT8QIv0UdIEQU6Lgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=PZsnNY5/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KNJgL/Th; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="PZsnNY5/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KNJgL/Th"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 23F1F138010A;
	Fri,  1 Mar 2024 13:06:12 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 01 Mar 2024 13:06:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:message-id:mime-version
	:reply-to:subject:subject:to:to; s=fm3; t=1709316372; x=
	1709402772; bh=2voU5o1daW4Xx0qoxw2z+lFD2vYc+MCaiSq//wb+U64=; b=P
	ZsnNY5/itGCU3cVqeFNYwEnGBlUmAT4vUBqPIdto/NSX4sZKruevj6yRSxO9Bm7p
	Fmlg712DUcaTrIlPuHQuy93mkM8oqy6E1dgrHSRAhCevkeS2l83qT/q0IrkIxZ1e
	3GpT2k9eDySIayLQVYmfvzXMgOOr3jYxftb/ttsxrr+dJKPuMyT2oQVGeuVMlg+T
	GNWfMAd2O39QEYo19dGN9ChQWbU2qdpr5Sj1iIOFrmMXh0oGKZ8Fxtfoxig0ola1
	SZymNJIsS/fnnX4C9uReUGGnaEpM5JvtQDX/Uc7CrG4wA0tSDJ/GNz6GAsKb8jNN
	6PMNHlJGYJ+zf9dmHUeQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1709316372; x=1709402772; bh=2voU5o1daW4Xx
	0qoxw2z+lFD2vYc+MCaiSq//wb+U64=; b=KNJgL/ThWyfKS6TrrDXv6m/UjqWJI
	j3vR3ROy2eGRHwIftCX4eTkvXGvre3qmdG49w2jqtvmW4g99ufup54qKuSnpupz1
	EsOcm+bvnsTk3SmKE+JmW6zCxkHwuhvZgNGgQXhrFNAxXONU03raKppmRTqGrj1U
	cHEcm/j+xFbzb2z8vhWhHeZDnfPLI9WXPA4dR8TUxcu3NQiOnbcGmfbFy278jSdB
	27mNn47kBChUyoZ7RL/+IxkfMNoriMhkD5TifLytW7Rj9kdzRcoJ5UEDoXK7KX3D
	g2crHYHldWj9u/bxfGb9w64jC09aOheviVUjr+E8m2l3yLpHF9STWqSAQ==
X-ME-Sender: <xms:ExniZaJKMLaKCWJhJdugT_zDeVFGlVULvWX74BwQnaU0bVUHoxKHFdU>
    <xme:ExniZSJv64bn5DzeiSsptc93rClcSe41C-wYvYF1OubZL5MpT1LiHBIPXbLPXPnpt
    Qblum0dgUKtvCSNqA>
X-ME-Received: <xmr:ExniZas1z94TMs8N7r65D5WovyOfa6r9_Z8sEsJnLm_Tu7Ty7Sz416zkfP96tmGvr-AJ5Xf2wSV83BzDevEyIOusodgdy1MlX6S6bLRrWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrhedugddutdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpefmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhcuoegtohguvgeskhhhrghughhssggrkhhkrdhnrg
    hmvgeqnecuggftrfgrthhtvghrnhepgfdvhefgffekgfeiheeivdetffelkefhheeitdej
    hfelhffhkeevudfhleekvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:FBniZfbn-BDj8Fha947Kz3LXJA5hHg-f1PbCak-jGe9bosAQnCETmw>
    <xmx:FBniZRaMbUHlKCaSM1Qyac0UDGXnVE2jmRU_wdLP_byCIygwsKProw>
    <xmx:FBniZbAFrwA7S0OxWFa8EQwNr_Fqjl60WgdtU8Plx_xWFQnTbrsFRQ>
    <xmx:FBniZVFxMNMJV93jx4g5lVOK4lk5NKvjaHFo9lElDm9R6y-sztEakg>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Mar 2024 13:06:10 -0500 (EST)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] =?UTF-8?q?gitcli:=20drop=20mention=20of=20=E2=80=9Cnon-da?= =?UTF-8?q?shed=20form=E2=80=9D?=
Date: Fri,  1 Mar 2024 19:05:53 +0100
Message-ID: <5b34bc4e22816f7f19bd26c15a08fe4c749b72f8.1709316230.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.44.0.106.g650c15c891b
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Commit-Hash: 5b34bc4e22816f7f19bd26c15a08fe4c749b72f8
Content-Transfer-Encoding: 8bit

Git builtins used to be called like e.g. `git-commit`, not `git
commit` (*dashed form* and *non-dashed form*, respectively). The dashed
form was deprecated in version 1.5.4 (2006). Now only a few commands
have an alternative dashed form when `SKIP_DASHED_BUILT_INS` is
active.[1]

The mention here is from 2f7ee089dff (parse-options: Add a gitcli(5) man
page., 2007-12-13), back when the deprecation was relatively
recent. These days though it seems like an irrelevant point to make to
budding CLI scripters—you don’t have to warn against a style that
probably doesn’t even work on their git(1) installation.

† 1: 179227d6e21 (Optionally skip linking/copying the built-ins,
    2020-09-21)

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    Now:
    
    ```
    $ git grep --files-with-matches 'dashed form'
    Documentation/RelNotes/1.5.4.txt
    Documentation/RelNotes/2.16.0.txt
    Makefile
    t/README
    ```
    
    For 179227d6e21 (Optionally skip linking/copying the built-ins,
    2020-09-21):
    
    (sorry for the resend; I sent to my test address first)
    
    Cc: Johannes Schindelin <johannes.schindelin@gmx.de>

 Documentation/gitcli.txt | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
index e5fac943227..7c709324ba9 100644
--- a/Documentation/gitcli.txt
+++ b/Documentation/gitcli.txt
@@ -81,9 +81,6 @@ you will.
 Here are the rules regarding the "flags" that you should follow when you are
 scripting Git:
 
- * It's preferred to use the non-dashed form of Git commands, which means that
-   you should prefer `git foo` to `git-foo`.
-
  * Splitting short options to separate words (prefer `git foo -a -b`
    to `git foo -ab`, the latter may not even work).
 
-- 
2.44.0.106.g650c15c891b

