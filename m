Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B781922D9
	for <git@vger.kernel.org>; Sat, 19 Oct 2024 20:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729368022; cv=none; b=HcbJbySE1UYy7F0qWArJzuClae2FETbK0/NU+qFtjvoW5fWf5GOyVmUf6tGFVPpOCi7BkM6yBnkyNMd5pPP6PpoUwwwNfs4CmO0reCMb/fbsbOSbsflVIiuxGmWYxx1wVDZcYpCdxrOm8NDCAakD8jnpE/OVtbf+hnlIHbjj9/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729368022; c=relaxed/simple;
	bh=Vc70rSkACb+z9LN3VBa9wiuQtXp+uCaKgpKZHMWS284=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VJ2yRNBUwVP0M6/fq3hd+TC3YdrVlCJPwcXk5bDqhkQpPsU831H/WNV0ag6mmwfmLRY+rXZSfjVXDdkinMxIb8c7hrw8UEnkxzSL44Nu6iik3yt1tY8l//pVkNFKngHAm9YI4gXylfY2jeDS9+vVC0Snnk9E8GqS5vb/+Go7YL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=JeLaeVzd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mov3t9Ti; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="JeLaeVzd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mov3t9Ti"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 619FD2540078;
	Sat, 19 Oct 2024 16:00:19 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Sat, 19 Oct 2024 16:00:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1729368019;
	 x=1729454419; bh=Bhrv7252ZG4qY1DnpP0qMysTLtZ7/itaY1GIjmU7wzQ=; b=
	JeLaeVzdg15NNpCGJk+Ih1qMZae0z/CuEo50cku6Uctm1+Wtjhsn8nrTncMowdwt
	OrV5k5caVQb15LWSljZxUjNc6TzCgVdF9IYWmwW3jhKeRovsrr7vNwoA4mKnzTx9
	0Kylv8KcXmqODzEz8x1QGc0oUPD1Vx9Mq57JCwqrEpdjVyWCtHeU/Tjjk2bjNEFp
	HudOYbxaQc4e3HJsmUYdWU5oqUEvcyGD9tzuFYoaJqIw8A/QWZ0hVSfk0pawosbf
	o+CMekJFWvPOTsac1dJJ+ggJrv6dfKOEBpWLbPMpU6qvnuJt7IMwQnKOhgFn5+UA
	Z6i5l+AtYsjlkmOWS+m2QQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1729368019; x=
	1729454419; bh=Bhrv7252ZG4qY1DnpP0qMysTLtZ7/itaY1GIjmU7wzQ=; b=m
	ov3t9Ti9jJFIYW6WkuG0SlEBWLJo48quCeSfClfgVGQ9NdObmpIKbGqlEv932UlO
	E6awySw0mjgpbNLeJ8g55cUQoAvMXRx4Ou4229y/eXhu/jkHkylGH391MuGH2Y/4
	BnbUBlnVH27XIZCnbKVz9IOqEdU4a4jq5vSq/Ovw2khUbUfjDPoeXEpM4VNPSIaw
	jtzqxr3mdXvPtQa1dNBWCzmUEDg6CtpnfpDTam0Z7aIcHylfuwm3o7EkRQ4jE2UF
	tgLFurJ8G7IIhD07s4saDiH4w+SFsj5plfNqqou1i55YuvjpkG+bkXyXoZ0Kqqbb
	e1u4B3bV8krnZ+r/UVDJw==
X-ME-Sender: <xms:0w8UZ9_5wCjutZiOWEU0EE4vVPVVP483Dy7lcA1kj9yiMEFFLDPu02c>
    <xme:0w8UZxvaMr5zbQmcFtgNq0vUMRwdp9AI8CPCjOMxF8RAECxDlKonTjfJiWhKdK13t
    jaN7SAMPw8-6rc5gg>
X-ME-Received: <xmr:0w8UZ7B33x2ouvKCIwJByFRPwc5xDaUU52K4Egh0PKq5xvqAho7TU_-JOgiuf744thOU4oxfrgnokahnFbKo-r2RKDuI9jppVJ0aK0crLyPP0MDcFdyF-aCBMQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehhedgudegiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpehkrhhishhtohhffhgvrhhh
    rghughhssggrkhhksehfrghsthhmrghilhdrtghomhenucggtffrrghtthgvrhhnpefhgf
    eglefhjeekgfetleetjefhteeiheegfedtudduffegjefhkeetudeggffhkeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffh
    gvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohep
    kedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdp
    rhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepsggvnhgt
    vgesfhgvrhguihhnrghnugihrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekke
    esghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhr
    tghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomh
X-ME-Proxy: <xmx:0w8UZxeC0bgcWRBTMCicsbG2pu1TuRfq5NE5Hqq6oK7KHCT7IeIptQ>
    <xmx:0w8UZyPSjAflKrTzHHMXB68Ly1hWoQbyDSSX4MwVhI4l4pSy9adCXg>
    <xmx:0w8UZzmH607pedZLUd1ulyNHTev0hWUMTE3BETR7ticV1kCz5_HjmQ>
    <xmx:0w8UZ8ta777z9Kd6O6ES80wePVf5xkHqsDyRRpeap0Vj5-2IefrUNQ>
    <xmx:0w8UZzisG8jD_2-OknkRWc_hgB8f6JIFURX1bgrPfIAKY9M7CO2htlMx>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 19 Oct 2024 16:00:17 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	phillip.wood@dunelm.org.uk,
	gitster@pobox.com,
	bence@ferdinandy.com,
	karthik.188@gmail.com,
	me@ttaylorr.com,
	sunshine@sunshineco.com
Subject: [PATCH v2 2/6] Documentation/git-update-ref.txt: remove safety paragraphs
Date: Sat, 19 Oct 2024 21:59:19 +0200
Message-ID: <71d1e6364a21767a8d80c96a30282e6557fec426.1729367469.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.46.1.641.g54e7913fcb6
In-Reply-To: <cover.1729367469.git.code@khaugsbakk.name>
References: <cover.1729017728.git.code@khaugsbakk.name> <cover.1729367469.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Commit-Hash: 71d1e6364a21767a8d80c96a30282e6557fec426
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Remove paragraphs which explain that using this command is safer than
echoing the branch name into `HEAD`.

These paragraphs have been part of the documentation since the
documentation was created in 129056370ab (Add missing documentation.,
2005-10-04), back when the command synopsis was a lot simpler:

    `git-update-ref` <ref> <newvalue> [<oldvalue>]

These paragraphs don’t interrupt the flow of the document on that
revision since it is at the end.  Now though it is placed after the
description of `--no-deref` and before `-d` and `--stdin`.  Covering all
the options is more generally interesting than a safety note about a
naïve `HEAD` management.

Such a safety warning is also much less relevant now, considering that
everyone who isn’t intentionally poking at the internal implementation
is using porcelain commands to manage `HEAD`.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/git-update-ref.txt | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
index fe5967234e9..ec268b1426d 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -40,21 +40,6 @@ somewhere else with a regular filename).
 If --no-deref is given, <ref> itself is overwritten, rather than
 the result of following the symbolic pointers.
 
-In general, using
-
-	git update-ref HEAD "$head"
-
-should be a _lot_ safer than doing
-
-	echo "$head" > "$GIT_DIR/HEAD"
-
-both from a symlink following standpoint *and* an error checking
-standpoint.  The "refs/" rule for symlinks means that symlinks
-that point to "outside" the tree are safe: they'll be followed
-for reading but not for writing (so we'll never write through a
-ref symlink to some other tree, if you have copied a whole
-archive by creating a symlink tree).
-
 With `-d`, it deletes the named <ref> after verifying it
 still contains <old-oid>.
 
-- 
2.46.1.641.g54e7913fcb6

