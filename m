Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E794359703
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 21:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773697779; cv=none; b=XF1X9Ts9a8ccCj/XyNQe1Lnhy6yo5t+6CNe4CHKEVT5hr+He8DuYPQyQfDZOkw1/+h8W2f1utCaAxVp6nY5RlV6+fItnnvOV4cGoUQ5tjHfTLILu7syBo5eNbehi7FgwfUfe1xSd7tooHuAv1ooaVIwjObDXQUSO5JuFQCkN0Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773697779; c=relaxed/simple;
	bh=lsaeD/ioCCeeSr+m9d8N/0nRPYvu+Sgwik69tjtNtpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nMF0oBK/v2N8fFNAGOAAsrAU8hrVRxkQ4sJ17y6VLIpWYXqz88BvSyI60Hvx4Tt00fiex5mIH0MmlZ3eLQFx/XsBmWLedpeAjn/G71gz/W0FCPlswTRz3Zd0brN75YsnlC9bMz0eKvBBbgCGYhiTrXjfwEjSf5wFxR4um+7eo6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=MkEjerRO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yGqWJuXi; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="MkEjerRO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yGqWJuXi"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3EAF87A0318;
	Mon, 16 Mar 2026 17:49:37 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 16 Mar 2026 17:49:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773697777;
	 x=1773784177; bh=dg7O+5O0NApB5D3VI4bqSaqAO56BgHyAAXsy6qtXzuU=; b=
	MkEjerROtktpzNqari0hzPQBXSgJ6morRtvc6r8IK9kHp45nfF5iIQ6Y09fgHHHx
	KD+S2IIOXJ+lRLPgSPBX7TJL763EyNYFfUBOHz8OBUnL5kedTXJG5uu2lmxyZOpO
	REHzGGPgAdkdwCsH+N/Z8K/YQKiK/LkhtNp9lSN2KJEWnY2+JF1eNVWtgvo3noPf
	4ICHiixMz6IG42B0dR2NHS+OR98jLOzkhQeTCVV2KVuGlJSm/K0auODaNLL6zQQH
	h8UHQcnjOCoDu2R9rnury2jnS2dJKWjmZQZOuQqNPVNrFq2XUCd/4jd+TMnMAfxn
	FNkRjL3EJMdXoGz7Tx5w6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773697777; x=
	1773784177; bh=dg7O+5O0NApB5D3VI4bqSaqAO56BgHyAAXsy6qtXzuU=; b=y
	GqWJuXiUpXz4vZeDk5NCcCHpLrTX5ylV9YwoUcJtUO+1Z//5ABtkXTzSXv7MnaaI
	BFY8Y9yBkSqrOi6XWvJkKhyS14Wi5dE65OtHiGAeienpXRv3RxH23/LSWmfIsaO7
	gWXnHucsyMhbpyDh4FFCuLfPMOeDnBbvWwoHW1m3KipCQ+la8YbbjDbTaUHcjaa0
	q9EfjAJF/qy/FeAld/JnSTV4d1GFRTh7kV1tuTsYlo2znG813+PQY+/1glvBPw33
	6i2QTEXlOeFuyHr595TfvCq6Zy3QUE1X4Ezkq5co43v3t01JI/AoTI+TGR06fGRw
	QMfcgGNTjQS0JTL1B+vUA==
X-ME-Sender: <xms:8Hq4aRhb1TMNWzpd_TexY6F3QPSJaVJnsz32h3SmWycrplAu5ErisXo>
    <xme:8Hq4addQoT1_-zOUQ0yRBV7qdzapFJwcA6FyXZ4qzGVC5B4g9K-DZcCX8cA8FtGSv
    b2gpYdIfSO7oTnIwa4XKS0TlzYpO7W-N0qB2HmdqeqYN-gs5GxVnA>
X-ME-Received: <xmr:8Hq4aeedAll9AHCtoX8AjJBnCXQwBknmg_wrC0S4T4K5TqjOgqMXmEV20slQDO2fiomvf4URi_9X8uPmJyYNXgIoWUg3uVQ_GU55BR0z5vPJ5xa7hf8xual-UQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleelhedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
    hlucfvnfffucdlvdefmdenucfjughrpefhvfevufffkffojghfgggtgfesthekredtredt
    jeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrih
    hlrdgtohhmnecuggftrfgrthhtvghrnhepudelgfeuieeuteekleeifeegudefheetkefh
    jeffkedvueehtdevhfekieekhffgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishht
    ohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpth
    htohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrg
    hmvgdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrh
X-ME-Proxy: <xmx:8Xq4af9IuQti1Lf1TjqgEX6P4oaZQ80YAIgyGhD1wWDyShah1x4sOQ>
    <xmx:8Xq4aSmq7kwZVL-C-ElMdHLoRg475qApYyhJrQep9zB_kfpfuJ9Q0w>
    <xmx:8Xq4aZ_K3KSvXi93tCC0hyhP8RJ1s692HJfQ9diuP2X2u_mbXSm-Nw>
    <xmx:8Xq4aYkpdKq4DSauQEAR9rAKmT-vwTA6EWqYhpu5MRiwzCE4lx4w5w>
    <xmx:8Xq4aYEui2u51hP5u2cLai2PCvmP_F205glQ2xDBSCZ7mS97fxW9viDg>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Mar 2026 17:49:36 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Subject: [PATCH v2 2/4] doc: interpret-trailers: normalize and fill out options
Date: Mon, 16 Mar 2026 22:48:25 +0100
Message-ID: <V2_doc_interpret-tr_options.50c@msgid.xyz>
X-Mailer: git-send-email 2.53.0.32.gf6228eaf9cc
In-Reply-To: <V2_CV_doc_interpret-tr_synopsis.50a@msgid.xyz>
References: <CV_doc_interpret-tr_synopsis.48a@msgid.xyz> <V2_CV_doc_interpret-tr_synopsis.50a@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Some negated options are missing according to
`git interpret-trailers -h`.

Also normalize to the “stuck form” (see gitcli(7)) like what was done
in 806337c7 (doc: notes: use stuck form throughout, 2025-05-27).[1]

Also normalize the order of the regular and negated options according to
the current convention.[2]

Also note that `--no-trailer` will reset the list.

† 1: See also https://lore.kernel.org/git/6f7d027e-088a-4d66-92af-b8d1c32d730c@app.fastmail.com/
† 2: https://lore.kernel.org/git/xmqqcyct1mtq.fsf@gitster.g/

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/git-interpret-trailers.adoc | 66 +++++++++++++++--------
 1 file changed, 43 insertions(+), 23 deletions(-)

diff --git a/Documentation/git-interpret-trailers.adoc b/Documentation/git-interpret-trailers.adoc
index ea47f2f7ae5..77b4f63b05c 100644
--- a/Documentation/git-interpret-trailers.adoc
+++ b/Documentation/git-interpret-trailers.adoc
@@ -113,64 +113,80 @@ rules for RFC 822 headers. For example they do not follow the encoding rule.
 OPTIONS
 -------
 `--in-place`::
-	Edit the files in place.
+`--no-in-place`::
+	Edit the files in place. The default is `--no-in-place`.
 
 `--trim-empty`::
+`--no-trim-empty`::
 	If the _<value>_ part of any trailer contains only whitespace,
 	the whole trailer will be removed from the output.
 	This applies to existing trailers as well as new trailers.
++
+The default is `--no-trim-empty`.
 
-`--trailer <key>[(=|:)<value>]`::
+`--trailer=<key>[(=|:)<value>]`::
+`--no-trailer`::
 	Specify a (_<key>_, _<value>_) pair that should be applied as a
-	trailer to the inputs. See the description of this
-	command.
+	trailer to the inputs. See the description of this command. Can
+	be given multiple times.
++
+Use `--no-trailer` to reset the list.
 
-`--where <placement>`::
+`--where=<placement>`::
 `--no-where`::
 	Specify where all new trailers will be added.  A setting
 	provided with `--where` overrides the `trailer.where` and any
 	applicable `trailer.<key-alias>.where` configuration variables
 	and applies to all `--trailer` options until the next occurrence of
-	`--where` or `--no-where`. Upon encountering `--no-where`, clear the
-	effect of any previous use of `--where`, such that the relevant configuration
-	variables are no longer overridden. Possible placements are `after`,
+	`--where` or `--no-where`. Possible placements are `after`,
 	`before`, `end` or `start`.
++
+Use `--no-where` to clear the effect of any previous use of `--where`,
+such that the relevant configuration variables are no longer overridden.
 
-`--if-exists <action>`::
+`--if-exists=<action>`::
 `--no-if-exists`::
 	Specify what action will be performed when there is already at
 	least one trailer with the same _<key>_ in the input.  A setting
 	provided with `--if-exists` overrides the `trailer.ifExists` and any
 	applicable `trailer.<key-alias>.ifExists` configuration variables
 	and applies to all `--trailer` options until the next occurrence of
-	`--if-exists` or `--no-if-exists`. Upon encountering `--no-if-exists`, clear the
-	effect of any previous use of `--if-exists`, such that the relevant configuration
-	variables are no longer overridden. Possible actions are `addIfDifferent`,
+	`--if-exists` or `--no-if-exists`. Possible actions are `addIfDifferent`,
 	`addIfDifferentNeighbor`, `add`, `replace` and `doNothing`.
++
+Use `--no-if-exists` to clear the effect of any previous use of
+`--if-exists`, such that the relevant configuration variables are no
+longer overridden.
 
-`--if-missing <action>`::
+`--if-missing=<action>`::
 `--no-if-missing`::
 	Specify what action will be performed when there is no other
 	trailer with the same _<key>_ in the input.  A setting
 	provided with `--if-missing` overrides the `trailer.ifMissing` and any
 	applicable `trailer.<key-alias>.ifMissing` configuration variables
 	and applies to all `--trailer` options until the next occurrence of
-	`--if-missing` or `--no-if-missing`. Upon encountering `--no-if-missing`,
-	clear the effect of any previous use of `--if-missing`, such that the relevant
-	configuration variables are no longer overridden. Possible actions are `doNothing`
-	or `add`.
+	`--if-missing` or `--no-if-missing`. Possible actions are
+	`doNothing` or `add`.
++
+Use `--no-if-missing` to clear the effect of any previous use of
+`--if-missing`, such that the relevant configuration variables are no
+longer overridden.
 
 `--only-trailers`::
-	Output only the trailers, not any other parts of the input.
+`--no-only-trailers`::
+	Output only the trailers, not any other parts of the
+	input. The default is `--no-only-trailers`.
 
 `--only-input`::
+`--no-only-input`::
 	Output only trailers that exist in the input; do not add any
 	from the command-line or by applying `trailer.<key-alias>` configuration
-	variables.
+	variables. The default is `--no-only-input`.
 
 `--unfold`::
+`--no-unfold`::
 	If a trailer has a value that runs over multiple lines (aka "folded"),
-	reformat the value into a single line.
+	reformat the value into a single line. The default is `--no-unfold`.
 
 `--parse`::
 	A convenience alias for `--only-trailers --only-input
@@ -178,11 +194,15 @@ OPTIONS
 	input without influencing them with any command line options or
 	configuration variables, while also making the output machine-friendly with
 	`--unfold`.
++
+There is no convenience alias to negate this alias.
 
+`--divider`::
 `--no-divider`::
-	Do not treat `---` as the end of the commit message. Use this
-	when you know your input contains just the commit message itself
-	(and not an email or the output of linkgit:git-format-patch[1]).
+	Treat `---` as the end of the commit message. This is the default.
+	Use `--no-divider` when you know your input contains just the
+	commit message itself (and not an email or the output of
+	linkgit:git-format-patch[1]).
 
 CONFIGURATION VARIABLES
 -----------------------
-- 
2.53.0.32.gf6228eaf9cc

