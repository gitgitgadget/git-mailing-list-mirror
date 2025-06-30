Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A00221DB5
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 19:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751310654; cv=none; b=cuD7iz2w1SgIRUwvbe6fqDCCGwkZH6txXemNVzSHolcQmPez++h91DT4D10nKZP1idoR0hC2JgRC/dTVukBi8m0d+u9UDybSuXHAuRdX+g7fkOlZukX1t4t4Du4XGk0EcqGm0gZuLxKTnGthYzQVH7Yw1fObs+hBbEY/57DQEiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751310654; c=relaxed/simple;
	bh=QKIajmlT7p+Hj7kKvO0ZNr+kdlAejp7pNYqhxG/zchg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bFqN2hwpDlhdsgd7iD0ZjUh+PJ8AzyehqfPIIo+egka7qEmjxLCJwu0P6d0+GsfaXwbPB0Dr7JhoQ03+7JSKKqfk2m3ZPHuKkadIAx05pAgyASMM9U8fL/rPJGNQ2DR+dz8q4t5bvlcSEgFwShua7qdYXGDKRQ2xUs2CIdJwng4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=ir1DAjLl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E5rD3I+R; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="ir1DAjLl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E5rD3I+R"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2FE6414002F5;
	Mon, 30 Jun 2025 15:10:51 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 30 Jun 2025 15:10:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1751310651;
	 x=1751397051; bh=Mjq3KlGfItRlqheJVHM29ZHScgsON+0a5Uf+Bs0RdUI=; b=
	ir1DAjLlNbYZfH+SpFaRnRxn8wTYJSIGoUwckDtd7qXOoKEm7OiUUaOPaqoQCUwM
	HM9TS65X6gjXGsHUzCFmFF7xoDwDh3xIXeJZvG/hYkYGCKFEAUwKi+nLHmH3tlPy
	aBoMCmDF1ht+ltJVCSVcO3mhNG0E/SpJ4KKs6plzR7EIXrjV9IyS9DKp+AhZwi1i
	wJmFu8hPNhEL8ULKBFPVIbn0HuIamqNUpsuRw1isk2uqrbdD8cbU4Ug1Y6eIZ9mo
	c2XRPMZWcdfEedfWmilipnutp6pRof5CEoB6F2Gu4Oqh620fI+JhQw8bQ5jICYVI
	K2lsOVwIqsW1lZdsK+Wd8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751310651; x=
	1751397051; bh=Mjq3KlGfItRlqheJVHM29ZHScgsON+0a5Uf+Bs0RdUI=; b=E
	5rD3I+RS3E9SA9nP753lXgN2CxDgH15k0Cf6GvCvMT+0klF7PyfljnVkfCzejhtj
	19qvxQZ100MZUw8ZL2LGqTsCGXvfDKpysYk/VrA3j/spEE2s67F2LLtdAmoDQ5DV
	gUwjwZUCPyWtzoLaFGHg++jyLPVmHrDYxZucRM/FSo8OnUTAqRWSI9XVF5ROmbDK
	+GYsKsJus+Pu4O66OQDQmwSJTNI4ArjjCOA/HFvrKvo+lyKPO8jzBIVd1J76PjqZ
	wVrzyOQYEVmHaOWE4pkYwWEMkLSBh1h6P1KnijT7AfcN0HJPBlZg4SypEHGCEdLK
	Wr1Mac+ATitLs4Qs/OfkA==
X-ME-Sender: <xms:O-FiaOCvReS57ai_osPrMfLjTZryrpZNlTMjuwNAPxgTnSp_YFTLqNU>
    <xme:O-FiaIg-JXi-OjWopJ55yEVJiYpweaC-95JsiDX5_BRozCZzBpRRZwXpOleOZzWuI
    xiBIllbsVQEYNF4TQ>
X-ME-Received: <xmr:O-FiaBkoyipJVWdj6VaR2QJQ3kbG4IxpbEnplb74kEmcf3zyS3iQTVLUxpPJmRyKahkLSUR91JseEkXXERIX7r_dE6R6CJ8uIyimheA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvdehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthho
    fhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvg
    hrnhepudelgfeuieeuteekleeifeegudefheetkefhjeffkedvueehtdevhfekieekhffg
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhk
    sehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehpshesph
    hkshdrihhmpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhr
X-ME-Proxy: <xmx:O-FiaMz0CMLuFkymXn_3p3gRUTNLC6UO6hySFECoS2lgciuHX0x3RA>
    <xmx:O-FiaDRHE3o8pJPN0krB9MnN2TKedrMe_ap-226jd1X4I7BAR1bdzg>
    <xmx:O-FiaHalBIk8l-xHeF4GH2epQp5BrmpOs2EIP33IyiHws9GQH2KseQ>
    <xmx:O-FiaMQICNOgOASCIUoz2lbSHx5nCHJbFBa9OiF11vvX4F9GsVydVw>
    <xmx:O-FiaDztrwheglRbMsRxGYBtQCWwb4gWGj1x_I2ncEdeLHWbAljhuT46>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Jun 2025 15:10:49 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Patrick Steinhardt <ps@pks.im>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Subject: [PATCH 1/5] doc: config: document --[no-]show-names
Date: Mon, 30 Jun 2025 21:10:23 +0200
Message-ID: <7d66a5403b31248995e605ed9330c0dfb2b80321.1751310455.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.50.0-KH
In-Reply-To: <cover.1751310455.git.code@khaugsbakk.name>
References: <cover.1751310455.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

These options were introduced in 4e513890008 (builtin/config:
introduce "get" subcommand, 2024-05-06) but not documented here.
Use the description from the source code.

Document this option and the negated form according to the current
convention.[1]

`--show-names` is also the default when `--get-regexp` is given.  But
don’t mention it here since all the deprecated modes are quarantined in
the “Deprecated Modes” section.

[1]: https://lore.kernel.org/git/xmqqcyct1mtq.fsf@gitster.g/

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    >The default is `--no-show-names` unless `--url` is given and there are
    > no subsections in _<name>_.
    
    See: d4770964d50 (config: "git config --get-urlmatch" parses
    section.<url>.key, 2013-07-31)

 Documentation/git-config.adoc | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/git-config.adoc b/Documentation/git-config.adoc
index 936e0c5130f..e05bf813d46 100644
--- a/Documentation/git-config.adoc
+++ b/Documentation/git-config.adoc
@@ -259,6 +259,12 @@ Valid `<type>`'s include:
 	Output only the names of config variables for `list` or
 	`get`.
 
+`--show-names`::
+`--no-show-names`::
+	With `get`, show config keys in addition to their values. The
+	default is `--no-show-names` unless `--url` is given and there
+	are no subsections in _<name>_.
+
 --show-origin::
 	Augment the output of all queried config options with the
 	origin type (file, standard input, blob, command line) and
-- 
2.50.0.138.gf67de2ec4e7

