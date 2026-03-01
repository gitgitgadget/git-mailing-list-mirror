Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB452302753
	for <git@vger.kernel.org>; Sun,  1 Mar 2026 19:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772392950; cv=none; b=TpqgEzD6vooHy+WJCZK9p6wQirvi2OWV2CKwDmPCCtVtwyuvzjnj+Q+pXXD0BRz/xXYD45CvnIuaFAIE9O5noDfaHK12P8LOquofRkX0M55fqJqXe2chan/IhVMZ+TkiL4niraN9ykf5Ev9pc2wZtSwxwpKFg91wJoEZ4/6LDJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772392950; c=relaxed/simple;
	bh=DOpdPX41SX0GevXsidgAMLrRVZ8HpydVpoWC3XiP94g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ak5cr+EZaFCj26ddZezTql9Qr9o4As6Dg2Yve9BMpXGgkIbCm0pGoVzAaRodBS13SvXQJXxQPMO8/rrMDZ+XQgWw5Q1bzuPpW+q7h+gqEhSwa1TmUNFkLfjmGe+hbLwO9ZPD51EuMWauKAsT19hhJ5qN9TRLXiI7kolcgeHwjKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=oPifxul5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EoW6RkBI; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="oPifxul5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EoW6RkBI"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 856611D000D1;
	Sun,  1 Mar 2026 14:22:27 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Sun, 01 Mar 2026 14:22:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1772392947;
	 x=1772479347; bh=l48OTAVCW/IEnghgK3qPkH3tR2vZxaPsiNWeLgByo8c=; b=
	oPifxul5OvfD6AufkX/jVXZn/ftON4NKjGGSNCfVm6xpAd2fVc4AxK2r/SW+Zzvu
	XASfOXF15Vn8b6tSlypSocLPqfTzyFsiZIBOk7Ilv/GnvsKozrhVfhn7ZEejJ8ev
	7O6k0ejIciryJeEQdQhoWCsPEyOk/zbGNlqjYW12+SpoHsCz/37uEMa2clcQF1oe
	mCSX2+FiBx4cpB8Lnnx9Mw7FrG/K9US8F3CaB+mmxEU+YOf2E3vvKYtZpuicdoR3
	nLnDI9PaEknap+R5y9x1YjmiU4u0c4HBYodNDeDyxYOnrvKhHNNSJ4PgxmPI6ANR
	o6OK2pirzhvcOIXzaGvaRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772392947; x=
	1772479347; bh=l48OTAVCW/IEnghgK3qPkH3tR2vZxaPsiNWeLgByo8c=; b=E
	oW6RkBImzppEydZt11sRnxMLWWLBjWPSvBYGsjit3FsKD6iA1hXqrE7R4a1H5Fdi
	FwiMK/J6aJampcic50EW9Ev0CQa3vGCelPJYLXSj84LSucHANSCJb9BGm3VkMW2O
	1k5jatmNAmxCtxKNZ5TcsyQ9mgJS87T8Lw4pp86QE8LZRHIMYPGr//r+TU1DSl/H
	33PWq6Mku6S7ns4Qivc5VA3ifNuzChqfacrjOiHNtF5O8SrR8dUDLmi8dh3/3lbq
	Gq2+IOMeBoizUVnwFZUY7UNffMvrRmoYNoWTPvN3zvn4ixTIaRcLUs+vpjJe9JUn
	LxAP9n4mlYZBvnbCWAzfg==
X-ME-Sender: <xms:85GkaYEii7WHby4fN6nzKr3014z-xxmuxWEZlsD9ySp5nHq52liup4E>
    <xme:85GkaYN9VhUMvkVZCeJ-Vf9mOepEtjJEh0acJSsDkhKeBS-ln4aUiS3AwNM4deVt1
    OgIfyZoFDoGDhfP_gwMdce0RmYA6Lonb5S6-xPnZ8_mXoJrmn-h3A>
X-ME-Received: <xmr:85Gkaae1bbyJkkc1AEnOZyxlw4hprYhwylyxIWbgYWfsIS4tdF2w7kGlLcLC_jgzJTZ4pEUwUR9h-1vE22-JUYJRg3hTF7RRuLcdc0o4lrlgPmgo0VVdxV4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheehiedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlvdefmdenucfjughrpefhvfevuf
    ffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvghrnhephffgge
    elhfejkefgteelteejhfetieehgeeftdduudffgeejhfektedugefghfeknecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvg
    hrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeeh
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehjnhdrrg
    hvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:85GkaVuMf5lbTMuikBLcafL4-Zbb1_STsB0ZxK5TsLrb4ywUgWP6-Q>
    <xmx:85GkablBYnZdPx8aLAUpjwNMuyURPlR06Rq4MSuDO7Z8NLF9xy0P7w>
    <xmx:85GkaXyLarfr8Itu_wowLrb-r_CU1ZY6Sniz7wq_7f8DVC5ryT2hyw>
    <xmx:85GkadMTOEaHpKxKwrF3_HY0Vp-fhJtFPBxNeKlFLUF2TlrA5Tgf9w>
    <xmx:85GkacBDEo83O_8M1NTZU4nl_8AJ9XbTCdShv7lHEMek4tU72cGmxr7k>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 1 Mar 2026 14:22:25 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	gitster@pobox.com,
	jn.avila@free.fr,
	peff@peff.net
Subject: [PATCH v2] doc: diff-options.adoc: make *.noprefix split translatable
Date: Sun,  1 Mar 2026 20:21:14 +0100
Message-ID: <V2_better_for_translators.43b@msgid.xyz>
X-Mailer: git-send-email 2.53.0.26.g2afa8602a26
In-Reply-To: <better_for_translators.424@msgid.xyz>
References: <better_for_translators.424@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

We cannot split single words like what we did in the previous
commit. That is because the doc translations are processed in
bigger chunks.

Instead write the two paragraphs with the only variations being this
configuration variable.

Reported-by: Jean-Noël Avila <jn.avila@free.fr>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    Notes to the maintainer: based on topic kh/format-patch-noprefix-is-boolean
    to fix the issue reported in <ff86f877-4b75-403d-a5a4-10ab528a9691@free.fr>
    
    v2:
    • fix `endif`
    • Don’t use `TRANSLATORS` callout

 Documentation/diff-options.adoc | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/diff-options.adoc b/Documentation/diff-options.adoc
index 8f632d5fe1a..fcfcdf0286e 100644
--- a/Documentation/diff-options.adoc
+++ b/Documentation/diff-options.adoc
@@ -859,12 +859,18 @@ endif::git-format-patch[]
 	Do not show any source or destination prefix.
 
 `--default-prefix`::
+ifdef::git-format-patch[]
 	Use the default source and destination prefixes ("a/" and "b/").
-	This overrides configuration variables such as
-ifndef::git-format-patch[`diff.noprefix`,]
-ifdef::git-format-patch[`format.noprefix`,]
+	This overrides configuration variables such as `format.noprefix`,
 	`diff.srcPrefix`, `diff.dstPrefix`, and `diff.mnemonicPrefix`
 	(see linkgit:git-config[1]).
+endif::git-format-patch[]
+ifndef::git-format-patch[]
+	Use the default source and destination prefixes ("a/" and "b/").
+	This overrides configuration variables such as `diff.noprefix`,
+	`diff.srcPrefix`, `diff.dstPrefix`, and `diff.mnemonicPrefix`
+	(see linkgit:git-config[1]).
+endif::git-format-patch[]
 
 `--line-prefix=<prefix>`::
 	Prepend an additional _<prefix>_ to every line of output.

Interdiff against v1:
  diff --git a/Documentation/diff-options.adoc b/Documentation/diff-options.adoc
  index e4d02cc93a9..fcfcdf0286e 100644
  --- a/Documentation/diff-options.adoc
  +++ b/Documentation/diff-options.adoc
  @@ -859,7 +859,6 @@ endif::git-format-patch[]
   	Do not show any source or destination prefix.
   
   `--default-prefix`::
  -// TRANSLATORS: format.noprefix / diff.noprefix
   ifdef::git-format-patch[]
   	Use the default source and destination prefixes ("a/" and "b/").
   	This overrides configuration variables such as `format.noprefix`,
  @@ -871,7 +870,7 @@ ifndef::git-format-patch[]
   	This overrides configuration variables such as `diff.noprefix`,
   	`diff.srcPrefix`, `diff.dstPrefix`, and `diff.mnemonicPrefix`
   	(see linkgit:git-config[1]).
  -ifndef::git-format-patch[]
  +endif::git-format-patch[]
   
   `--line-prefix=<prefix>`::
   	Prepend an additional _<prefix>_ to every line of output.

Range-diff against v1:
1:  55e56c90959 ! 1:  07acc52c3bc doc: diff-options.adoc: make *.noprefix split translatable
    @@ Commit message
         Instead write the two paragraphs with the only variations being this
         configuration variable.
     
    -    It’s not easy to spot the difference here. So let’s leave a comment
    -    for translators.
    -
         Reported-by: Jean-Noël Avila <jn.avila@free.fr>
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
    +
    + ## Notes (series) ##
    +    Notes to the maintainer: based on topic kh/format-patch-noprefix-is-boolean
    +    to fix the issue reported in <ff86f877-4b75-403d-a5a4-10ab528a9691@free.fr>
    +
    +    v2:
    +    • fix `endif`
    +    • Don’t use `TRANSLATORS` callout
    +
      ## Documentation/diff-options.adoc ##
     @@ Documentation/diff-options.adoc: endif::git-format-patch[]
      	Do not show any source or destination prefix.
      
      `--default-prefix`::
    -+// TRANSLATORS: format.noprefix / diff.noprefix
     +ifdef::git-format-patch[]
      	Use the default source and destination prefixes ("a/" and "b/").
     -	This overrides configuration variables such as
    @@ Documentation/diff-options.adoc: endif::git-format-patch[]
     +	This overrides configuration variables such as `diff.noprefix`,
     +	`diff.srcPrefix`, `diff.dstPrefix`, and `diff.mnemonicPrefix`
     +	(see linkgit:git-config[1]).
    -+ifndef::git-format-patch[]
    ++endif::git-format-patch[]
      
      `--line-prefix=<prefix>`::
      	Prepend an additional _<prefix>_ to every line of output.

base-commit: b9b583bd007ca814ebd362bdd6441aac02e9414b
-- 
2.53.0.26.g2afa8602a26

