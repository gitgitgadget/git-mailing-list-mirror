Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D22510FD
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 19:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767642903; cv=none; b=HTOISw+BVhMqtzqud+hdX52KefXJep9ZT0QPEu7JH6EPE4BmNRJVRctdaM8xNZmM9+2pv9vBz7echj6QD8QreJuh0LalX+jP7dqazFphBvD9NM8+B/SsufikcbOeIXirYzogW3Bgqu+0HrfYBMUx5GhdPC0HIbCbNJqsQ0wrpv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767642903; c=relaxed/simple;
	bh=d9gcNTMIuHktezFGO0sNmuCFIDiDzHjlfeoge/8DI78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=biW0isPLIpXxJuLpTltgysmxCu+w6o15eOYoPLjU7dle+2j1EHqrkbVwaqJK1I2LJZ7U5BBMX3WBLokPucXYBDbli1OsYrN5ljs4hsYyvj0k30dDhs1C43MN2UZtgti1GqqK1ESAQCAnDggJwNhq8xvk6F+1dSU9opgaC174zl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=MTi+X7kz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KyAwUoMX; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="MTi+X7kz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KyAwUoMX"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id B27281D00087;
	Mon,  5 Jan 2026 14:55:00 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 05 Jan 2026 14:55:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1767642900; x=
	1767729300; bh=TLaLaKzQAR2UDfQUxV8KaMa9srJCgpSmVMfbRBRji90=; b=M
	Ti+X7kznHluOJI4HtGnvyfqMchvapTvllJ2SF7pZuUFsgQPXDK4gwhIgpzV0iAIs
	2xbyNh+eJqLHfIk3cg/duEerTOOWiI2jFXXVM2ynaRGOSwDDtrqbNnl4pabsr9W0
	OTG6ZSBAIUjTxea3rBB0+SD1Ly8eHwoWyDXto+JuaPbGiKuDpkC9ixmv44oEY/uM
	uvfn7kJP3Vm/DvK/cwyi3fdWv/m1BYofl7QZ0/rI23oa+sBuAj3sIC14QR4ote88
	sfN1lRPPs02oXf2SnhLlbz18ukK5djTIS6AUosNjtDJSZvF6UYgJEYXcF+Zff6At
	B5KR1chyrqfKlRSZQzh0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1767642900; x=1767729300; bh=T
	LaLaKzQAR2UDfQUxV8KaMa9srJCgpSmVMfbRBRji90=; b=KyAwUoMXovGm9dI0Y
	O7TUMj4H7HzjXuk/xyEUWWqgzc4MkQVMK9dq3GF4ojikxLoewA3tEk8eGyYH4zvV
	xdACGkcoU0Egq7+f8CjnVgn1YL1Ue04eVhPCNMzJWAVbaFO2bHni54n7EVNX2Dce
	0dz59b3KkquUYTqyFMbEeLxG77xZaxwCfjbuzX52dTPBLzzUQSndLuSDfvvFTTD6
	Ld69/TMvIYcElun9CaWmVLZBdjtAXSNVitGLbrqPdRjtGAehbwDuiB+kTHXVGe/e
	zirG5dq3f1sYMYhDqIqjndwk2TcEulgXSUzP3d3AYFsyYBJcyeDELS96n5wDMwyt
	Ti69A==
X-ME-Sender: <xms:FBdcaWmotNOKg2a8eLnv6kRTxUbkJwYhnP3mjk1pk7_tQ1hdpU8m0uA>
    <xme:FBdcaXJ686UrKSYvLcFjW5q0ogaaFGnzh4mr9v9qNLrgQHMqPwrygLwPsSQpsZ1iu
    t9lBn1xJ86fAGz49OY0fAiuzRcALuB19yyoVIHbIqgZ0LMqhucM-A>
X-ME-Received: <xmr:FBdcab5dO4yzHQ4nKnQub8V9CuWeEsuT-S30ilbvUda12905EXpqgDBJrKRcG6R_6Lt8FtXu40qLdzTerb1jKxvY6AyqwdwViHQd5CCzFPZw0tkA1T58-R0IIw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdelkedulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfghrlh
    cuvffnffculddvfedmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttden
    ucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrd
    gtohhmnecuggftrfgrthhtvghrnhepvdfgteeiffefjefgiefgudekjeeluedttdegieel
    geeileegvdekteejheejkeefnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhf
    fhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtoh
    epiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
    dprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdp
    rhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehsihguug
    hhrghrthhhrghsthhhrghnrgefudesghhmrghilhdrtghomhdprhgtphhtthhopehphhhi
    lhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukh
X-ME-Proxy: <xmx:FBdcab2818mE0FcWVD_GcPEqNHfQplDVCrfF-zP40OctLzv6hxcdDA>
    <xmx:FBdcaRehsbboD1zM-mAgPE-jkUjXdgqkGr7qYOpehWFzrTx25Gbe6g>
    <xmx:FBdcaRdFXtKz6j2juyeZuTqt_3a2_8DA9Ei1he5rF3xOZZ-hMSYIAg>
    <xmx:FBdcaczwrdLOicH6mj8WxnGwj1O726z_H_-r0-pwP-k-MUAHrfyVOg>
    <xmx:FBdcaTs8fmsY70qGKTO7tn6I_HNFnwEYO9EAKf7whC4Jjc6hXJgrbsco>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Jan 2026 14:54:59 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	christian.couder@gmail.com,
	newren@gmail.com,
	Siddharth Asthana <siddharthasthana31@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v3 4/6] replay: improve code comment and die message
Date: Mon,  5 Jan 2026 20:53:20 +0100
Message-ID: <V3_comment~fserror_suggestions.1a8@msgid.xyz>
X-Mailer: git-send-email 2.52.0.383.gb1c58d6b301
In-Reply-To: <V3_CV_replay_die_descr.1a4@msgid.xyz>
References: <V2_CV_replay_die_descr.17b@msgid.xyz> <V3_CV_replay_die_descr.1a4@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Suggested-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v3: [new]
    
    https://lore.kernel.org/git/CABPp-BH1b3rHi96qXLQwQRX6g7POmqYLKyAc=_1UsWmfiWsGFg@mail.gmail.com/

 builtin/replay.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/replay.c b/builtin/replay.c
index dfb98eb3a9c..3dde20acfef 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -351,11 +351,11 @@ int cmd_replay(int argc,
 
 	set_up_replay_mode(repo, &revs.cmdline,
 			   onto_name, &advance_name,
 			   &onto, &update_refs);
 
-	/* FIXME: Should handle replaying down to root commit */
+	/* FIXME: Should allow replaying commits with the first as a root commit */
 
 	if (prepare_revision_walk(&revs) < 0) {
 		ret = error(_("error preparing revisions"));
 		goto cleanup;
 	}
@@ -369,11 +369,11 @@ int cmd_replay(int argc,
 		const struct name_decoration *decoration;
 		khint_t pos;
 		int hr;
 
 		if (!commit->parents)
-			die(_("replaying down to root commit is not supported yet!"));
+			die(_("replaying down from root commit is not supported yet!"));
 		if (commit->parents->next)
 			die(_("replaying merge commits is not supported yet!"));
 
 		last_commit = pick_regular_commit(repo, commit, replayed_commits,
 						  onto, &merge_opt, &result);
-- 
2.52.0.383.gb1c58d6b301

