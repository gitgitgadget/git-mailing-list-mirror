Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89972D8768
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 05:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772774387; cv=none; b=GNMoP7Ymx0h4YGt/is6XhJtMyhBfNqCWA+aoaRa6bE5Xhsa4nlFCnNd/cNiNI0GOLJVd+oFw7K96zUE6I8CMYozOy/NflG22WKdHmklF5Fszs5zIyJ/vy/Fw8zdNZPPvOBm/m4jsc+y0YCh5bskogl4dFc/WmLjaijm1nTB3m7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772774387; c=relaxed/simple;
	bh=Cyzrxk68+SFXuNFAUFlvuR8JxzL6PlZrbMpK0VO6pIU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=gqUNUTENx7ffWnYvzT3sJd7pUrBwS6tQUZTt+KOYFuSG3ue1/40QPtcaGqkz555bDZykldJSzWgL7XGi0f76a9s6YfPS1OXDdXiABGGC7+RqE1lWyq2HNZAEF3MUaG8VMKTpCz0gSuhf6JdrZ1jfRP+0iEDs11CRfQSxStP+Bgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wolfgangfaust.com; spf=pass smtp.mailfrom=wolfgangfaust.com; dkim=pass (2048-bit key) header.d=wolfgangfaust.com header.i=@wolfgangfaust.com header.b=TJ/RkUr/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oL0llZE+; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wolfgangfaust.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfgangfaust.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wolfgangfaust.com header.i=@wolfgangfaust.com header.b="TJ/RkUr/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oL0llZE+"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 12719EC09F9;
	Fri,  6 Mar 2026 00:19:45 -0500 (EST)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-01.internal (MEProxy); Fri, 06 Mar 2026 00:19:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	wolfgangfaust.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1772774385; x=1772860785; bh=ckIjavxHu7
	7lcYRtT4vh+MZvF0HkkoTGrK/67rr61Bs=; b=TJ/RkUr/xmh5l1cnMTopvXt6cD
	4bE6BCpv8rWZTXO2vyk620VplO7GR8g3uu/4D2DsAQCNV+cod4jx8K6s13QIaSAY
	k3KKp5eINS7+NX8XRb3c9b5vgaXOjnaua4K/Iljxr4uMOsj4c0eWSkLWFgonbZSy
	fzdXsMNOzb/7fnGTeTfJREZvmkTFd3d7TcDTv1mQbVIT6H7azVWmoRGSyMAee0lP
	HqE62OLxU4LbxnILHi7ul8KkzGgzxow/SvgxlHV+6vNU5oygr5gjnq4U5mBGhFYJ
	X8ZzwKVwOvp6kN5+WTr/GhTpmOm7qhbtln4509J/Rpse2xEj32O4iA70HV3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772774385; x=
	1772860785; bh=ckIjavxHu77lcYRtT4vh+MZvF0HkkoTGrK/67rr61Bs=; b=o
	L0llZE+/tiTWLWk1ZlQyx7nlbvm77xWk1tYqWQ15b+aDjm6vYF3r+c7nUMRWLiFT
	xUMkpD8PGZXuGQoylBT3ZLv162dlBFvplKd7QyPMS9n2l9RngysAnF1t4G575wZF
	5DT+R8F1EDCJq6jIvTcFSROEyJ56YZ7idZ6oGa5pkMDR2lDBWXqHpOrsDlMxVX4+
	YprpRBcebBYcZ+UG6CAqQY1+fLr9fw7wndJ6RfeMQy3Ph3ntiNjbyG25d2LTw/Xj
	2yZVU+bsCSXbecAGdtXj9jVcBeM9kl67He5m6NtsKlyj6IayvwK/2gRw7N2eBY7I
	Qhgsm9yS0S5UYYuFr9IcA==
X-ME-Sender: <xms:8GOqaVck-rFymqgkSZzRR8F-D1pLrFkeu_qAO_4eqNxtHzt7S_X2nw>
    <xme:8GOqaeB26lHNu_jcCanxc7AtBWBZzjLAY1SVjon1kQRBYj6YWgHKPn-nJwnSmNGiU
    kCTltC1KSVt1BuuCheei9IsvT0IEy-x3brRLOUsrHjJNZz3wv23dQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieekgeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvvefkjghfufgtgfesthejre
    dtredttdenucfhrhhomhepfdghohhlfhhgrghnghcuhfgruhhsthdfuceotghonhhtrhhi
    sgdqghhithesfiholhhfghgrnhhgfhgruhhsthdrtghomheqnecuggftrfgrthhtvghrnh
    epleejkedujeeuffetgeevkefgfeegvedtffejhefghfegieettedttdfgtdefvdefnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghonhhtrh
    hisgdqghhithesfiholhhfghgrnhhgfhgruhhsthdrtghomhdpnhgspghrtghpthhtohep
    vddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:8GOqaUJPgjei-WzXEFxe0j56lPPhu9tWnfrjYrMgCJ9OgiKN60LB5w>
    <xmx:8GOqaSFUYypjLhSGOcphB-9Bx1Oqq7xC4Qn57VtmQ4mWK5Vwb7Z06Q>
    <xmx:8GOqacT1EmCgmHBhZDhM06cQ9BQEcLmfdA4z5DDMYCiG9V-HT13JxA>
    <xmx:8GOqaeGnKBdNH2BuK1I0xIEuxb8c2EiQFsivugVk8I6xXj-Jbi4IZw>
    <xmx:8WOqae8yx22C3QY29KiumkSq6XNjK_8eLPynuGl_6srbHkJXs_2AuGo0>
Feedback-ID: ifd814412:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D3C332CE0072; Fri,  6 Mar 2026 00:19:44 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 05 Mar 2026 21:19:22 -0800
From: "Wolfgang Faust" <contrib-git@wolfgangfaust.com>
To: git@vger.kernel.org
Cc: "Johannes Sixt" <j6t@kdbg.org>
Message-Id: <3d03bf2a-d2e2-4dc7-8ec5-057fd87c5986@app.fastmail.com>
In-Reply-To: <cover.1772573786.git.contrib-git@wolfgangfaust.com>
References: <cover.1772573786.git.contrib-git@wolfgangfaust.com>
Subject: [PATCH 1/4] git-gui: run auto maintenance on commit
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This implements the same behavior as seen in builtin/commit.c:
run auto maintenance between rerere and the post-commit hook.

Signed-off-by: Wolfgang Faust <contrib-git@wolfgangfaust.com>
---
This always detaches rather than honoring autoDetach (unlike
run_auto_maintenance()) because I can't think of a circumstance where
you'd want the GUI to block.

 git-gui/lib/commit.tcl | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/git-gui/lib/commit.tcl b/git-gui/lib/commit.tcl
index 89eb8c7b73..4b07cb3bbb 100644
--- a/git-gui/lib/commit.tcl
+++ b/git-gui/lib/commit.tcl
@@ -477,6 +477,12 @@ A rescan will be automatically started now.
 		catch {git rerere}
 	}
 
+	# -- Run auto maintenance (e.g. garbage collection)
+	#
+	if {[is_config_true maintenance.auto]} {
+		catch {exec git maintenance run --auto --quiet --detach}
+	}
+
 	# -- Run the post-commit hook.
 	#
 	set fd_ph [githook_read post-commit]
-- 
2.52.0

