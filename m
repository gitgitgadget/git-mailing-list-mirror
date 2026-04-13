Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6017C3B2FC9
	for <git@vger.kernel.org>; Mon, 13 Apr 2026 10:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776075694; cv=none; b=kRc1LyFa4xKavu/vHWe2oKN+O73jkOtPv8GdqfhVUG9s7ciyyG9v220qAo1msADmqySlGSL8gsv/VKxt8Vub6Ej1UJpMO7iU9DStySVcHdvZxpjpExhT4J/U5X97By1ObA51g41sMIYZIZ7CrdLwuA+ELaiT+yrWiQZhKEcuVYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776075694; c=relaxed/simple;
	bh=n3U4Oah7uRfTlQFyk6xtJ27Y9exBhEVpqtLCySiIcf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MW2M9Ve4UmR2M4WICbKIIlj3jUoC82ulvcSVLAjyqJ0T3Vp/8SecofUe6ssJQF35xZz4i51/Q5qZVIUtuPC8STT+7vHjNtBGHYOvrOAuHHoX0IjTxlitg0AYNWOLZ9nC6z9CzT0ibeBibJZCC/grB84tNNq5ZpMHzT2jSxRiDnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=NlUM2Lzw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AEkj62XT; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="NlUM2Lzw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AEkj62XT"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 6BFF8EC00BD;
	Mon, 13 Apr 2026 06:21:29 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 13 Apr 2026 06:21:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776075689;
	 x=1776162089; bh=dr6z4jL6zQtWjQ3AmK2H871InMUIqOciO/yij+eKKaY=; b=
	NlUM2LzwzLtxoYFGO3ooTKpeFNrIxKyoQSVclOqBJum93d0BsVBEPJiu5BrjDh2o
	U4SriJ31ySGSIKnSkTeKbXL1xc2nIvFXSJOUc3UY9eNkEgV5+l0XtKpeMkEtnpOv
	/5ClroAmBN/vUDMa36PkGh463GwMVBIoQS7ipzGlIo6uWHiA70z1my8Fi/4qc8Yc
	TgcDrib2q72GdpPPJhlIjt1waREiRdQQQba7LER8D1lVndX/DcNRqBmigVJn1KJV
	uNdEOYTk6hM+dJ1GRh4tYyjARvKMIkR55QkxwmlXKwzMJQ3aGR2gsOXJaYhCkMbk
	wiSOscpMsveoaA2N9r8BBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776075689; x=
	1776162089; bh=dr6z4jL6zQtWjQ3AmK2H871InMUIqOciO/yij+eKKaY=; b=A
	Ekj62XTdy1KAHa9pOL4+scdTJQeX3Mr0qPTVpslFwAwxM/wrTaPanCtQjRpRJGyG
	vSdFzyXt4FBy4Tu4wvCFUU36C5jjmhjxkiDHuIveneQ58ANhERjShQLxDfd/IZFL
	s/2/ICEdekTl0FPhpcKKKI5OCXAsuX1gSjqlWMvNoD9F1DdmTwtC+ZXER4bvApvt
	KI6srG+h6CDAN5hmIJru14/JVhJCuLkJjdrV1Sn7Az8F2SU0ZmpCanNABUP2LaS+
	KZAnDypWoDpmT6g8i4b475L5Rqs2Pjl/fwcR0An+dxSWhMWd9/8WIn3Xrzb1V6r7
	zndFGO02aIynoRuHb27cg==
X-ME-Sender: <xms:qcPcabsaQnsFqA-f4P4CVG7DUInFpvNnfAdLVItVKcEQyFiTrvWfQPE>
    <xme:qcPcaTVKusji2P4l0dk-2kXISaJ5LXvFUhKb1XrygSWUJJy13RZtRrZT6YeU6t0it
    NXOdW4x1ACFaNpVYw7hJrdC85_a-FPMl9JET9kGz1C1bcJ1Fg8Qfac>
X-ME-Received: <xmr:qcPcaXHJ69doJnFngJWWjDfEvVNkdzKj0FPmS8u6nqC5sCRqg-UxeHO-Pxr5RI5vc38N2kopZZGvTBHW8MukzzSdBXpFqyBis9iiDqEOt9BnoF0xeF2Y8oY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefjeelkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfghrlh
    cuvffnffculddvfedmnecujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdej
    necuhfhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomhenucggtffrrghtthgvrhhnpedulefgueeiueetkeelieefgedufeehteekhfej
    ffekvdeuhedtvefhkeeikefhgfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthho
    fhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtth
    hopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmh
    gvpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepjhgrtghkmhgrnhgssehgohhoghhlvgdrtghomhdprhgtphhtthhope
    hlihhnuhhssehutghlrgdrvgguuh
X-ME-Proxy: <xmx:qcPcaV11Lf7SwNt5dUsu9dtyQRQX9sNM2NQ1R0ptmxpsXu9QE-A9MA>
    <xmx:qcPcaZNDnh2qCia-GLTiPM8k6W0qsexsORf1rmdWK64AORawXUrebw>
    <xmx:qcPcaU4xmZbTp47TdeYEu3l-lUQ8w32JsblwtbYCQdKX-7meStl34Q>
    <xmx:qcPcaT1apy9BB94VJH5dmkc0LeZYbw5DV9xU8HtTh_KbklE_cCv8BQ>
    <xmx:qcPcaUk-Obo9fXDhOAVnBpIVj0Ur45j7gTAZugj_KD6veK7pnJwalzi7>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Apr 2026 06:21:27 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	christian.couder@gmail.com,
	jackmanb@google.com,
	Linus Arver <linus@ucla.edu>
Subject: [PATCH v2 0/9] doc: interpret-trailers: explain key format
Date: Mon, 13 Apr 2026 12:20:59 +0200
Message-ID: <V2_CV_doc_int-tr_key_format.613@msgid.xyz>
X-Mailer: git-send-email 2.53.0.32.gf6228eaf9cc
In-Reply-To: <CV_doc_int-tr_key_format.533@msgid.xyz>
References: <CV_doc_int-tr_key_format.533@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Topic name (applied): kh/doc-trailers

Topic summary: Explain the format of trailer keys (alphanum and
hyphens). This is important to keep in mind so that metadata is not
lost to simple syntax errors. Also replace some terms and define the
important ones upfront.

To that end, an overview of the changes:

• Patches 1–3: remove RFC 822 mentions, “metadata” term
• Patch 4: This command is not just for commit messages
• Patches 5–7: Explain the format in the simplest case, explain
  the “key” format, and add a new example
• Patch 8: Also use the “trailer block” term introduced to the doc in
  patch 5 later in the doc
• Patch 9: document line comment behavior

§ Changes in v2

Here one thing lead to another, mostly because changing one part of
the doc necessitated knock-on changes. An exception though is
the last patch which could be added later/separately.

As for the changes requested after the review on v1:

• Add missing mention of the default separator (:)
• Remove confusing “paint by numbers” reference
• Remove “The hyphens serve as interword separators”. This is a normative
  statement.

  An advisory statement would have been fine. But I see now that I didn’t
  weave that in to this version.
• There was an unclear part:

      we emphasize these two first standalone word mentions.

  Which shouldn’t be a problem now that the context/patch has been
  rewritten.

§ Cc

Linus Arver as the author of the example that this change touches.

This was more relevant on v1.

§ Link to v1

https://lore.kernel.org/git/CV_doc_int-tr_key_format.533@msgid.xyz/#t

[1/9] doc: interpret-trailers: stop fixating on RFC 822
[2/9] doc: interpret-trailers: replace “lines” with “metadata”
[3/9] doc: interpret-trailers: use “metadata” in Name as well
[4/9] doc: interpret-trailers: not just for commit messages
[5/9] doc: interpret-trailers: explain the format after the intro
[6/9] doc: interpret-trailers: explain key format
[7/9] doc: interpret-trailers: add key format example
[8/9] doc: interpret-trailers: commit to “trailer block” term
[9/9] doc: intepret-trailers: document comment line treatment

 Documentation/git-interpret-trailers.adoc | 68 +++++++++++++++++------
 1 file changed, 50 insertions(+), 18 deletions(-)

Interdiff against v1:
diff --git a/Documentation/git-interpret-trailers.adoc b/Documentation/git-interpret-trailers.adoc
index 92d9c95f9d2..b42f957d666 100644
--- a/Documentation/git-interpret-trailers.adoc
+++ b/Documentation/git-interpret-trailers.adoc
@@ -3,7 +3,7 @@ git-interpret-trailers(1)
 
 NAME
 ----
-git-interpret-trailers - Add or parse structured information in commit messages
+git-interpret-trailers - Add or parse metadata in commit messages
 
 SYNOPSIS
 --------
@@ -14,9 +14,15 @@ git interpret-trailers [--in-place] [--trim-empty]
 
 DESCRIPTION
 -----------
-Add or parse _trailer_ key-value pairs at the end of the otherwise
-free-form part of a commit message. For example, in the following commit
-message
+Add or parse trailers metadata at the end of the otherwise
+free-form part of a commit message, or any other kind of text.
+
+A _trailer_ in its simplest form is a key-value pair with a colon as a
+separator. The _key_ consists of ASCII alphanumeric characters and
+hyphens (`-`). A _trailer block_ consists of one or more trailers. The
+trailer block needs to be preceded by a blank line, where a _blank line_
+is either an empty or a whitespace-only line. For example, in the
+following commit message
 
 ------------------------------------------------
 subject
@@ -27,10 +33,7 @@ Signed-off-by: Alice <alice@example.com>
 Signed-off-by: Bob <bob@example.com>
 ------------------------------------------------
 
-the last two lines starting with `Signed-off-by` are trailers. These two
-trailers have the _key_ `Signed-off-by` and a _value_ (Alice and Bob).
-The key must consist of only ASCII alphanumeric characters and hyphens
-(`-`). The hyphens serve as interword separators.
+the last two lines starting with `Signed-off-by` are trailers.
 
 This command reads commit messages from either the
 _<file>_ arguments or the standard input if no _<file>_ is specified.
@@ -84,19 +87,25 @@ trailer.sign.key "Signed-off-by: "
 in your configuration, you only need to specify `--trailer="sign: foo"`
 on the command line instead of `--trailer="Signed-off-by: foo"`.
 
-By default the new trailer will appear at the end of all the existing
-trailers. If there is no existing trailer, the new trailer will appear
-at the end of the input. A blank line will be added before the new
-trailer if there isn't one already.
+By default the new trailer will appear at the end of the trailer block.
+A trailer block will be created with only that trailer if a trailer
+block does not already exist. Recall that a trailer block needs to be
+preceded by a blank line, so a blank line (specifically an empty line)
+will be inserted before the new trailer block in that case.
 
-Existing trailers are extracted from the input by looking for
-a group of one or more lines that (i) is all trailers, or (ii) contains at
-least one Git-generated or user-configured trailer and consists of at
+Existing trailers are extracted from the input by looking for the
+trailer block. Concretely, that is a group of one or more lines that (i)
+is all trailers, or (ii) contains at least one Git-generated or
+user-configured trailer and consists of at
 least 25% trailers.
-The group must be preceded by one or more empty (or whitespace-only) lines.
-The group must either be at the end of the input or be the last
-non-whitespace lines before a line that starts with `---` (followed by a
-space or the end of the line).
+The trailer block is by definition at the end the the message. The end
+of the message in turn is either (i) at the end of the input, or (ii)
+the last non-whitespace lines before a line that starts with `---`
+(followed by a space or the end of the line).
+
+This command ignores comment lines (see `core.commentString` in
+linkgit:git-config[1]). This is for use with the `prepare-commit-msg`
+and `commit-msg` hooks.
 
 When reading trailers, there can be no whitespace before or inside the
 _<key>_, but any number of regular space and tab characters are allowed
@@ -402,6 +411,29 @@ mv "\$1.new" "\$1"
 $ chmod +x .git/hooks/commit-msg
 ------------
 
+* Here we try to to use three different trailer keys. But it fails
+  because two of them are not recognized as trailer keys.
++
+----
+$ cat msg.txt
+subject
+
+Skapad-på: some-branch
+Hash-in-v6.11: 45c12d3269fe48f22834320c782ffe86c3560f2c
+Reviewed-by: Alice <alice@example.com>
+$ git interpret-trailers --only-trailers <msg.txt
+$
+----
++
+Recall that a trailer key has to consist of only ASCII alphanumeric
+characters and hyphens, and this does not hold for the two first
+supposed trailer keys. And now none are recognized as trailers because
+the candidate trailer block has at least one non-trailer line, even
+though `Reviewed-by` is a valid trailer key. Recall that a trailer block
+has to either (i) be all trailers, or (ii) consist of at least one
+Git-generated or user-configured trailer (and some other conditions).
+And (ii) is not satisfied since we have not configured any trailer keys.
+
 SEE ALSO
 --------
 linkgit:git-commit[1], linkgit:git-format-patch[1], linkgit:git-config[1]

base-commit: 5361983c075154725be47b65cca9a2421789e410
-- 
2.53.0.32.gf6228eaf9cc

