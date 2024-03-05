Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7247E129A99
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 20:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709670670; cv=none; b=J0LD1URU0tY/q0WXOpvDe+EhfrMWIQkFMmzoilEIxPyodEJY1D3bANA3j2IPKRkUrrZDbxbpeInNBhTug+A7R2BklQYXmcsRPmfDIdogmeAsZskWc3uNG6Plepli5ztKDmEGU4HcPV/wSRr9dVocl7ZmLaOwUC+Ie5TRSXLQt+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709670670; c=relaxed/simple;
	bh=Yx2YipxWX7fBtKj+buRu38MfIXhKfyLrF2/hCMIgVa4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TvdAeFZ/3Nkstg80BwTJneggQf/7Mpv4MuvAF7M8CvQfbasAxliz2Rc/k4OhINzSwRIKEVuNRwthRt4QBBYOt84WUjpkWl55Ny6xD4WmCpWqLNxhKRXwyAwkjQEOmUilA+WkUWz64/rMDBMsvCtT7Jlh8oI79fGyt2lKwmBxtjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=ZGgAn98T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ropEc/Bq; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="ZGgAn98T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ropEc/Bq"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 9D75311400C8;
	Tue,  5 Mar 2024 15:31:07 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 05 Mar 2024 15:31:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1709670667; x=1709757067; bh=82xlosMH+pVTC04ksJ0OIv+RlFeWutP/
	lEcRRauy9Cw=; b=ZGgAn98TGth7r/ji68je0BIEk0AJM46TFB5U3azbXGYlzP5N
	lDxmji0nx/1A8qpXuEp3cLtuTZ/2T/KTRiRolU3PTYoSv7qxvJPtjxSaUC73BjOF
	BMvUzoVdMxpRgn6niln1lpq8BCOBj25GiHHRwFnTOdqpdO/OLS+RKetX2sL1sOm5
	H+FwFPZeIPieBeH0Mjxc7SdnjpLm3x3+4pSaWU4FH+R62C3WpnWxoJCrhNLrLlKV
	bw/sYB3oJCaEmB/uDk9fpN8Ewsb49YzOxcuXGoKyOgWkSlpTXKzpqYLEUKqBWnuq
	l2wjPjTxNX6DA4Ftc1t5Pmoj2TgVIXUUR5Qd0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1709670667; x=
	1709757067; bh=82xlosMH+pVTC04ksJ0OIv+RlFeWutP/lEcRRauy9Cw=; b=r
	opEc/BqHZ4tOOIP1qru4s/AE/PsnRyAVRPrWptuZpAIpwPgBDaatoCKykEDG2G+y
	l6LISFnz8Dh+nvk5E7I5RIV8kREq8NUZlI0/V6tHmOXJUWwvhkWWugE0l0WBUBX6
	a4D48wVyAcLQ22bT2mE5YgIQxest5lFdZGJABaJ2qMHjp8PjDYGhGIXK4/Wz6qcQ
	6Z2moMkiphlXD6PPkJYFakhNU20fb6EiF+ZKa3B8G47eiIiQhIPiy4hyf0R3tUsD
	cSAcjyDSOclSPZnauY/40v4NrW/TjnQw82wOjq5v40k4kjZpIKSdmnBHoC4FIhHo
	OH1gQNXlqUeU11uhGUZjw==
X-ME-Sender: <xms:C4HnZdG5hocV4cpjm1jaXLV2jfC2VbqGRvHvjI-Y71jgwuE7piqaf5Y>
    <xme:C4HnZSUA8ZHwpMPkYCT7J0Xd8BGS0EpAUVELf4YhWQRqhg1EcZ05uuWK9Ikvk6JEs
    kv9Om-W2vS-qoe_ww>
X-ME-Received: <xmr:C4HnZfKlOtmx9j3bzJ80fWHJE7um7swMh8IcOtItj-AitNhp66GJtA5rZ2hRoS8fwCvQYMRKB_HFMoR104U-y_Edfy85GUMfP-3bxgRBAg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheelgddufeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfgggtgfesth
    ekredtredtjeenucfhrhhomhepmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkuceo
    tghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeevgf
    elveeikeegjeeikeeuvefhleeiuddvleegfeekjedtkeevtdetgfffveettdenucevlhhu
    shhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrg
    hughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:C4HnZTGAC0tkP4Dc6Sj7Eu6jythIvWZfYHBjgrdcc0UIfgjZeCS5gw>
    <xmx:C4HnZTVfgTAR75DqGGPV6QtnNTJpN0Soih3x4mrgBL5LC_bQ2eM8vA>
    <xmx:C4HnZePDYR6nhsqEJZpIX4WpyN9135y-N1qho83xBKyubtiQAUTT0w>
    <xmx:C4HnZQg-QwXJCsqjsS47LIqtHLEyghJ1u-npOzCeD-01k__9Z-vGRg>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Mar 2024 15:31:06 -0500 (EST)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH v4 3/5] advice: use backticks for verbatim
Date: Tue,  5 Mar 2024 21:29:41 +0100
Message-ID: <df9b872afd16257acc935180dc27b105e17d6e16.1709670287.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.44.0.64.g52b67adbeb2
In-Reply-To: <cover.1709670287.git.code@khaugsbakk.name>
References: <cover.1709590037.git.code@khaugsbakk.name> <cover.1709670287.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Commit-Hash: df9b872afd16257acc935180dc27b105e17d6e16
X-Previous-Commits: 30d662a04c75b80166db9ef94f95e8a841994fb5
Content-Transfer-Encoding: 8bit

Use backticks for inline-verbatim rather than single quotes. Also quote
the unquoted ref globs.

Also replace “the add command” with “`git add`”.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v4:
    • Also quote ref globs

 Documentation/config/advice.txt | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
index 72cd9f9e9d9..c8d6c625f2a 100644
--- a/Documentation/config/advice.txt
+++ b/Documentation/config/advice.txt
@@ -2,14 +2,14 @@ advice.*::
 	These variables control various optional help messages designed to
 	aid new users.  When left unconfigured, Git will give the message
 	alongside instructions on how to squelch it.  You can tell Git
-	that you do not need the help message by setting these to 'false':
+	that you do not need the help message by setting these to `false`:
 +
 --
 	addEmbeddedRepo::
 		Shown when the user accidentally adds one
 		git repo inside of another.
 	addEmptyPathspec::
-		Shown when the user runs the add command without providing
+		Shown when the user runs `git add` without providing
 		the pathspec parameter.
 	addIgnoredFile::
 		Shown when the user attempts to add an ignored file to
@@ -75,7 +75,7 @@ advice.*::
 		non-fast-forward update to the current branch.
 	pushNonFFMatching::
 		Shown when the user ran linkgit:git-push[1] and pushed
-		'matching refs' explicitly (i.e. used ':', or
+		'matching refs' explicitly (i.e. used `:`, or
 		specified a refspec that isn't the current branch) and
 		it resulted in a non-fast-forward error.
 	pushRefNeedsUpdate::
@@ -87,12 +87,12 @@ advice.*::
 		guess based on the source and destination refs what
 		remote ref namespace the source belongs in, but where
 		we can still suggest that the user push to either
-		refs/heads/* or refs/tags/* based on the type of the
+		`refs/heads/*` or `refs/tags/*` based on the type of the
 		source object.
 	pushUpdateRejected::
-		Set this variable to 'false' if you want to disable
-		'pushNonFFCurrent', 'pushNonFFMatching', 'pushAlreadyExists',
-		'pushFetchFirst', 'pushNeedsForce', and 'pushRefNeedsUpdate'
+		Set this variable to `false` if you want to disable
+		`pushNonFFCurrent`, `pushNonFFMatching`, `pushAlreadyExists`,
+		`pushFetchFirst`, `pushNeedsForce`, and `pushRefNeedsUpdate`
 		simultaneously.
 	resetNoRefresh::
 		Shown when linkgit:git-reset[1] takes more than 2
-- 
2.44.0.64.g52b67adbeb2

