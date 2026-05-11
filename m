Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D705F402433
	for <git@vger.kernel.org>; Mon, 11 May 2026 15:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778514390; cv=none; b=eYupjv851isX0WlsJZ/Qnj/FR7s5UWpbKs91BLOAliObSGJz7yLir2mbFliEi6JCvdtg1JrhpbT3oHx/H17p/cb0LYe9ZsHUwqtraX4TRE6Z112FClDbAS1DeE860bOr2HaqHeNWeWvbJXAxj3660aKdyNf3Qo/J/mizeESnokE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778514390; c=relaxed/simple;
	bh=vSdKdgLF/kpwIQThsr/tX0GbbWG25qfbnmgA4Cp+ZZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kme5fs4No3GdsBFzwr75/eUCP9eKOiGOUfgG42pZWdOdEd1pLh7t4SqUiMutf1IZdYMDHxU2sMelMA/rSVPDmlcFnPfpu3loLjYwCt4uxyBlVW18jJjlxrZCc1R+WZzfWiTRseWQFBq53SgpmvNug4Z7/mJa4hnDX0PoN6N62vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=F6wG/vsl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nsVTgO5m; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="F6wG/vsl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nsVTgO5m"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 5FF64EC0017;
	Mon, 11 May 2026 11:46:26 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 11 May 2026 11:46:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1778514386; x=
	1778600786; bh=pY+H8NwtO+t1ql7YvawMFRtzssRl5Duf8w45sdQE8+g=; b=F
	6wG/vslyzNSpVPzMcbkJCRVvDzR1LkruFNA5j/33LX78IBgyk6MSOrQIk4z79gx0
	1NfQrb+/aClecEj51WgJMsVIpxScdfa3ZAz6mx+cyqhUT/6tAzNMeGVM3Ny5zJu0
	/Conz3iYj/ifmpnCeaElAkGrIvzvFN0NTiCkJ4qtNfNFXik4mKsIHQU2G8AsibD/
	bL9KXkeVbCumm9RxNL4TN6Es1umff3NCeiW5sR80EY77Fiy+1UPErPUGnYSHT+Zj
	qVmyLPi19KVQZdBeRRDi5vVLuhgvythtqRAEg9Xu4+/KJctellGu1ck6xceTwjhJ
	LZ7OqxxxThChKhnbpb9PQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1778514386; x=1778600786; bh=p
	Y+H8NwtO+t1ql7YvawMFRtzssRl5Duf8w45sdQE8+g=; b=nsVTgO5m86cfs4o8N
	n8p1GOcrmDBN0XEUmtg/ortehcztzAHy/gRPHFDqQNFZL+hyypBp82gDc5EDcm5l
	3IeKujhKK/KFEPRwRpzQBXPN1e4zyMVYT7tiS0pmb5/HfgNySGtA99AiCVS+Aiip
	yKCgdTWKltjIFCzhyHHN+SQ3yBgPeMZcAZ6F99uKoQkYj8iyzXM8SkkNuL6ZpTMh
	ZpecVnltYIk3ADBUxh6ki/QkbZwtdvO3+gvvZCNfBZrWpSoxZd+KaBT1FQ4/SbOS
	406qiPV3l6JhZ/TXUOQKnoo1y+ygkN4s4/GezUU8RDjNNjO5u6n0KEmvOOgC8ml7
	d2WIw==
X-ME-Sender: <xms:0vkBal4UjiQhG2Uj65yBUOennACW6bmrcDS2er-b8DotOStTMsPzKfw>
    <xme:0vkBat0-oxAkg7Ysjm_yk0F7unu9hixZtDE9qBajjw0SAiQTYHiY_aGNlOuYdLhqE
    aG1FRxjfoBLOL0EK95LN3NfgX3aLQmSxL_4YitUv6nqVuS5_cFEwz0>
X-ME-Received: <xmr:0vkBarfIwGe9o93OBs547n0Zl65PobnphGdooaak2IKWcf3Yz7JG33PS9RBXnxAXWWFi_YbdgTY43m9PGqd2JHSqx_ZRoEpIeIqPUks>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudelfedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
    hlucfvnfffucdlfeehmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomhenucggtffrrghtthgvrhhnpeefheetkeeftdeiffdvjeetueethfeugfetgfdt
    veehhfevffeuffdtheeitdefudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhm
    rghilhdrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopegtohguvges
    khhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpd
    hrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdrtghomh
X-ME-Proxy: <xmx:0vkBajfk6xrdgiSS0tMnlkMjo4HIqrDjIwP2s5SqWtB1lFpWfE-ngg>
    <xmx:0vkBamxxcWVQvzovnPkFZeamM6bY0olpVMMt1AmKbRg-kN-SDY15zA>
    <xmx:0vkBai_Bc-M1KrNn08__MC8lOylw13GZc37lg1hLjZS9FgAGV_0gPw>
    <xmx:0vkBamhP4vjo436FOVmZhGij_bL4pk1nHpcQhNJ-Eu1VYQQUaihgOw>
    <xmx:0vkBavR1RHSpB9LpvR03WyRaD5woslakwaFjnkd_rsLLjV2sNeJR3Hu0>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 May 2026 11:46:24 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	git@vger.kernel.org,
	ben.knoble@gmail.com,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v5 1/5] name-rev: wrap both blocks in braces
Date: Mon, 11 May 2026 17:45:45 +0200
Message-ID: <V5_name-rev_braces.6ca@msgid.xyz>
X-Mailer: git-send-email 2.54.0.13.g9c7419e39f8
In-Reply-To: <V5_CV_format-rev.6c9@msgid.xyz>
References: <V4_CV_format-rev.6aa@msgid.xyz> <V5_CV_format-rev.6c9@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

See `CodingGuidelines`:

    - When there are multiple arms to a conditional and some of them
      require braces, enclose even a single line block in braces for
      consistency. [...]

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2:
    Fix stray formatting of `(p+1)`

 builtin/name-rev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 6188cf98ce0..171e7bd0e98 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -466,9 +466,9 @@ static const char *get_rev_name(const struct object *o, struct strbuf *buf)
 	if (!n)
 		return NULL;
 
-	if (!n->generation)
+	if (!n->generation) {
 		return n->tip_name;
-	else {
+	} else {
 		strbuf_reset(buf);
 		strbuf_addstr(buf, n->tip_name);
 		strbuf_strip_suffix(buf, "^0");
@@ -516,9 +516,9 @@ static void name_rev_line(char *p, struct name_ref_data *data)
 
 	for (p_start = p; *p; p++) {
 #define ishex(x) (isdigit((x)) || ((x) >= 'a' && (x) <= 'f'))
-		if (!ishex(*p))
+		if (!ishex(*p)) {
 			counter = 0;
-		else if (++counter == hexsz &&
+		} else if (++counter == hexsz &&
 			 !ishex(*(p+1))) {
 			struct object_id oid;
 			const char *name = NULL;
-- 
2.54.0.13.g9c7419e39f8

