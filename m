Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1003596B
	for <git@vger.kernel.org>; Thu, 12 Jun 2025 17:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749747903; cv=none; b=F9GAGl9ifiOqXGkAYOhZx5gZYvY1ib4BLV9TFNAQI/zlqgNL/x1Ug5H4Eq4EOp3Y/vJY2ieNLvhsggVIWTSRRfM008nX45of+Qa6/liHRB6oG/GAR5LD+yrsm1AxNPNujLUmrDpYl/eADYfuBfi6t4pndlL+2OicPl9abx6tMpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749747903; c=relaxed/simple;
	bh=LgEJjyRr02UkW3XWCGHldp9Fs61MfeR0wxIN8Epzfdo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g8DEJQrOp9JgzGwRcm9V7nkR8AhcX3Z/NmFi4FJsllKCWmdDSfKF6vNx5/fI/cVTLSgMjjCZqPUIiydfhNgiQTPCB6UvYoMajJtXw8nktmX6Vu0LdwvYJ0YmsdZXbXFjqN3CTb8og6iNdDmgEFrAkESnt/oZily5izMWjO9q2Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=wg4z0E2u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dBFMBv/H; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="wg4z0E2u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dBFMBv/H"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 18D321140225;
	Thu, 12 Jun 2025 13:05:00 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Thu, 12 Jun 2025 13:05:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1749747900; x=1749834300; bh=lg4qG3gxU/MK/iMdV9liKeJeR5JgaQio
	5S6+mEdZcBQ=; b=wg4z0E2u4yRxIXNEmK6tAMaqcPZxg6GoilsmZvGmYaeINh57
	dZ4mTAYhdP22t9BEZVDNn2QhJhr9QhyUi1g8F5uOInKtSw14UFUGXZ/zXHi6M4q+
	nooAgg11koVU/AvFY9V6AUQthAru+uK2VmL8cdevgdRBrxWN8CTqB0LLK22lTw3z
	HTZtQKOIEbmI/vPhNSnULdY8d1EY2RuCQ9nhZd4Xf/h/r6BH2UmC11cttXUyTVbl
	XLVejYUkhjoSor+COSBxpaT59cla5w9RhputxssWIwH+d/C8DhrjzkxX/BswmYVh
	vcoNrRRsaqGeYYCKhbMA6xfCFWuL4tCnUsRuKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749747900; x=
	1749834300; bh=lg4qG3gxU/MK/iMdV9liKeJeR5JgaQio5S6+mEdZcBQ=; b=d
	BFMBv/H8qJWOetX4ekCrKfSUlMCpFE6EE/H4FMZqChtyEwb9gaMdFdW25Y8E9ENQ
	O9TmB1cd2mQyUCdDyW4SFxHRJvpL3cnLHIsHI4uLVRIohWb+fBgRd3bDgsMU5QUq
	kPpQ3DsT89WTyCFy7sU3ZdT2Azs2GNgTcCnp3rbYeqViL8PEEhp6h6NPn0ZTlJut
	ggR7yoet3SpxSt3wskXSobCrVdq+ZtoIEieDNq7KT4JzGQ3PxZFXzaw9/JZRilBC
	0qng0kag0MajMXhrnrJeXMQL7xoq+rWc6abD9DDUujwY32zPV69HcdyKj3r9waFI
	4F/ZqXDE+vln6rzKMPZMw==
X-ME-Sender: <xms:uwhLaEN2VRPfrXnAt14Rc8LQwdrwnM4DDiy-QFF36CMNTSr9mmd9Wg>
    <xme:uwhLaK-oXWvEy810QQSjzZbRYpBJcpq2uYiDVQTph4ByAC04jO8K-uCdRhORzvVSo
    rYfUNPADjIa1eMaRw>
X-ME-Received: <xmr:uwhLaLRkIhfKr1qjicose4q8_7TlzjPSnE2LmeLwqMjKdjMhEdtLnxq9zyJDgawLNDlHMxa_B6cHozrF5gMzL_sM3fqtSgWIOm-x>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduheeivdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpefhveehledukeeiteehtddtveegvedujedvlefh
    gfduheetjeetfffhieetvdduhfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgv
    rhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegsrhgrugestghomhhsthihlhgvrdgtohhmpdhrtghpthhtoheptgholhhlihhnrdhfuh
    hnkhdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:uwhLaMsE8vJUaRQir56-hrHWGc7nw9q2isoaxwP9bu8mg7GMggE_yg>
    <xmx:uwhLaMcwwpLpTme1DH4XozSw73SstnHFQ23kp1Kql2FfZL-kaGNoSw>
    <xmx:uwhLaA0r3P7Oq5v-S8xf3OWQphyezqg6x2N1hrXLNOeGrb3KDgkQUw>
    <xmx:uwhLaA-UBbtI4U4TMODGOjs51_SRNgYZEfoKy9JqqL4dvg5zYI28KQ>
    <xmx:vAhLaECgH-BE_sTbLA2JHoeiVgGNU-YW3CmLFtGfXiDVbzuq3OY7gvch>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Jun 2025 13:04:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Brad Smith <brad@comstyle.com>, Collin Funk <collin.funk1@gmail.com>
Subject: build: sed portability fixes
Date: Thu, 12 Jun 2025 10:04:58 -0700
Message-ID: <xmqqplf8evr9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Recently generating the version-def.h file and the config-list.h
file have been updated, which broke versions of "sed" that do not
want to be fed a file that ends with an incomplete line, and/or that
do not understand the more recent "-E" option to use extended
regular expression.

Fix them in response to a build-failure reported on Solaris boxes.

cf. https://lore.kernel.org/git/09f954b8-d9c3-418f-ad4b-9cb9b063f4ae@comstyle.com/

Reported-by: Brad Smith <brad@comstyle.com>
Reviewed-by: Collin Funk <collin.funk1@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This time with a proposed log message.  I may fast-track it down
   to 'master' before the release.  I personally am undecided, and I
   do know that I hate the style of this particular sed script and
   am tempted to fix it before committing, but I'll refrain from
   doing so before the release.

 GIT-VERSION-GEN        | 2 +-
 generate-configlist.sh | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 1047b8d11d..ad3aa59045 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -82,7 +82,7 @@ read GIT_MAJOR_VERSION GIT_MINOR_VERSION GIT_MICRO_VERSION GIT_PATCH_LEVEL trail
 $(echo "$GIT_VERSION" 0 0 0 0 | tr '.a-zA-Z-' ' ')
 EOF
 
-REPLACED=$(printf "%s" "$INPUT" | sed -e "s|@GIT_VERSION@|$GIT_VERSION|" \
+REPLACED=$(printf "%s\n" "$INPUT" | sed -e "s|@GIT_VERSION@|$GIT_VERSION|" \
 	-e "s|@GIT_MAJOR_VERSION@|$GIT_MAJOR_VERSION|" \
 	-e "s|@GIT_MINOR_VERSION@|$GIT_MINOR_VERSION|" \
 	-e "s|@GIT_MICRO_VERSION@|$GIT_MICRO_VERSION|" \
diff --git a/generate-configlist.sh b/generate-configlist.sh
index 9d2ad6165d..75c39ade20 100755
--- a/generate-configlist.sh
+++ b/generate-configlist.sh
@@ -13,16 +13,16 @@ print_config_list () {
 	cat <<EOF
 static const char *config_name_list[] = {
 EOF
-	sed -E '
-/^`?[a-zA-Z].*\..*`?::$/ {
+	sed -e '
+	/^`*[a-zA-Z].*\..*`*::$/ {
 	/deprecated/d;
 	s/::$//;
 	s/`//g;
 	s/^.*$/	"&",/;
 	p;};
-d' \
+	d' \
 	    "$SOURCE_DIR"/Documentation/*config.adoc \
-	    "$SOURCE_DIR"/Documentation/config/*.adoc|
+	    "$SOURCE_DIR"/Documentation/config/*.adoc |
 	sort
 	cat <<EOF
 	NULL,
-- 
2.50.0-rc2-215-g56f75d5edf

