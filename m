Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A9119C54E
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 05:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772774320; cv=none; b=naVt/sYAWxocHmZxMrWzrtRW51Tid894gaB5KuWJ8l06CtrYIZGxgDfKP0ycxiNnJDXx+Ppa3Fh0EMsAjpO4Gi0XAPyUziwLEKWSwm3h2qsBfmN6/FraVuQhQfzpshQ0VnywuAYqRhmxneB0cInwvjiLH2iGo2BMfUvqoi+grt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772774320; c=relaxed/simple;
	bh=Ys9CG4tOcRod4kIWA/Rs0UeZCvOvH1RTjd5iYNUQL4w=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:Subject:
	 Content-Type; b=pOlGNkmGucyqxDWUy5+Bc8/gQ9NtxJvmu87rlOHAM7cpj6xoz5gV+KegrmsBsf40kgRKOelB1e/WF8F05K+iB26XT878T5H0MDw8u4FFzg5/Qel35PDTR39ajw50L9P3o/yVFwz1Ty11Z/lPyC9arhIfbQGr9ZFx+KgiD/HqVnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wolfgangfaust.com; spf=pass smtp.mailfrom=wolfgangfaust.com; dkim=pass (2048-bit key) header.d=wolfgangfaust.com header.i=@wolfgangfaust.com header.b=BBlCsqoW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SdXxXP4n; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wolfgangfaust.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfgangfaust.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wolfgangfaust.com header.i=@wolfgangfaust.com header.b="BBlCsqoW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SdXxXP4n"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E93A114001F6;
	Fri,  6 Mar 2026 00:18:36 -0500 (EST)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-01.internal (MEProxy); Fri, 06 Mar 2026 00:18:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	wolfgangfaust.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1772774316; x=1772860716; bh=0wRMlz9qMIupqn/nJMlmV
	uCNbQFpWJ1+dIeBWh+041I=; b=BBlCsqoWqNQg5Z+4gxx5UifK4boIt5jchHJfl
	ifcpfOTu90b3HQV090PdrYzhaG5BrsKD9pMgjYsAHZ6KNjKM5ps0ZBmCjbndj3BB
	NOB0l97VrFLfBklXIYdt2ByXrEXZTXb8qqppQr51zl0FI4B+dytqK3lmrZqs+6rN
	QpfaITSCEmW9lnT9NyB699T9KjEMcQVf509IP0kZ7euSN52twS1Xx0OpsMlwDGTZ
	I1PxnTpHUSJ0eJxqiuUa91deia4JdlcvYYR7S7tcIrKKwAti3Bq4swjDoBwiUfKc
	PPIo6jvWLbwr9Cjiy4ge/o5pcZENa7cRDGOS2iIy0ncWKa2sA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1772774316; x=1772860716; bh=0
	wRMlz9qMIupqn/nJMlmVuCNbQFpWJ1+dIeBWh+041I=; b=SdXxXP4nNw9lYxy5J
	STn31sKqRzQC87X0/UROJokOk78+pcCT6Ys7xKXJHxzJOjrdn3KtlbcrAPqpoCPs
	AJZewUo2xDx9mQ4axGCuZVjXFsI7XEYfZDzthcAjBV5H0ofsw6XprnlxhFrsvBhI
	E+YZXezr/AOGL78N5zXwK/HdPsYCgHINS3a4UCTFk8FkrReFLOcykrlNEVu2iGwr
	IU3S2vBNzVBeCCHJwK2A5rC7xg6YUaolrYajUF+8ttI/uPK/NXa6r1VL7BXX2bZG
	KEZdSJ8Em3GlAD37dyxCtPileJK98we0FI14CFBr81FnlBsHCfp19A5vzRCQQ6pn
	7L+PQ==
X-ME-Sender: <xms:rGOqac3oK_JZHt38uNE7nodei5YS2-WRmKimsjm6GdsglMr8cD8SaQ>
    <xme:rGOqaR4hZc79ldbSgbSINz4dCbqatJWD2qaNowoxSRlfOc4Bs1WnN6Xhhl9aQvO8l
    LRsFZJ8tOhszJ4uDQoXvIXu8GN_cTjTwOC5yia2ANvICDb2dD8ULA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieekgeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvvefkjgfutgfgsehtjeertd
    ertddtnecuhfhrohhmpedfhgholhhfghgrnhhgucfhrghushhtfdcuoegtohhnthhrihgs
    qdhgihhtseifohhlfhhgrghnghhfrghushhtrdgtohhmqeenucggtffrrghtthgvrhhnpe
    evfeekudduleetheefkeeiieejfeeljedtleellefgieeijeevvdejleehjeekheenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheptghonhhtrhhisgdqghhithesfiholhhfghgrnhhgfhgr
    uhhsthdrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepsghirhhgvghrrdhsphesghhmrghilhdrtghomhdprhgtphhtthhopehjieht
    sehkuggsghdrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepmhgrrhgtnhgrrhgtseigihhplhhinhhkrdgtohhmpdhrtghpthht
    ohepmhgvseihrggurghvphhrrghthihushhhrdgtohhm
X-ME-Proxy: <xmx:rGOqaeao5AR9hKElE13g3vhv1PDeOW8mdN2tt1c5B5q32ryDOT5IHA>
    <xmx:rGOqaS64wzIXKssSA9Ic4TnLnuZb7j9o9IVge_yxyWrTth9P5STibQ>
    <xmx:rGOqaZB8TFjzvol05ElSk8zdOhb7Cpnc0WqO0frbNcgqb7US9t3Xqg>
    <xmx:rGOqaQfDNgmBJhIYdJXA6wAhkCf_ECRrahdGgHFq8WEIfTTVK-dlQw>
    <xmx:rGOqad5fkqlMSHyykscffSNKgoeQf2YXV3mJUMsk0YEszCEey0HuQziR>
Feedback-ID: ifd814412:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5BBE52CE0072; Fri,  6 Mar 2026 00:18:36 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 05 Mar 2026 21:15:56 -0800
From: "Wolfgang Faust" <contrib-git@wolfgangfaust.com>
To: git@vger.kernel.org
Cc: "Johannes Sixt" <j6t@kdbg.org>,
 "Birger Skogeng Pedersen" <birger.sp@gmail.com>,
 "Pratyush Yadav" <me@yadavpratyush.com>,
 "Marc Branchaud" <marcnarc@xiplink.com>
Message-Id: <091e68fa-428d-48b0-bf7d-42b01660d6eb@app.fastmail.com>
In-Reply-To: <493aa11d-21db-e759-6be3-2c6b8f287a0b@kdbg.org>
Subject: [PATCH 0/4] run auto maintenance in git-gui
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Resurrecting the 2019 conversation "git-gui: disable the "loose objects
popup" dialog?":
<https://lore.kernel.org/git/CAGr--=K15nUcnsJWOP87uMMjeQmTgAeO_6hnr12k2zuNQjNyBw@mail.gmail.com/t/#u>

The consensus there seems to be that git's auto maintenance is now
good enough and if git-gui implemented the same behavior as `git commit`
then the "repository currently has approximately %i loose objects"
dialog would no longer be necessary. This patch series implements that.

Wolfgang Faust (4):
  git-gui: run auto maintenance on commit
  git-gui: remove hint_gc dialog
  git-gui: remove "Compress Database" feature
  scalar: remove obsolete gui.GCWarning setting

 Documentation/config/gui.adoc |  5 -----
 Documentation/scalar.adoc     |  6 ------
 git-gui/git-gui.sh            |  6 ------
 git-gui/lib/commit.tcl        |  6 ++++++
 git-gui/lib/database.tcl      | 40 -----------------------------------
 git-gui/po/bg.po              | 22 -------------------
 git-gui/po/de.po              | 27 -----------------------
 git-gui/po/el.po              | 27 -----------------------
 git-gui/po/fr.po              | 28 ------------------------
 git-gui/po/hu.po              | 27 -----------------------
 git-gui/po/it.po              | 26 -----------------------
 git-gui/po/ja.po              | 26 -----------------------
 git-gui/po/nb.po              | 27 -----------------------
 git-gui/po/pt_br.po           | 27 -----------------------
 git-gui/po/pt_pt.po           | 27 -----------------------
 git-gui/po/ru.po              | 20 ------------------
 git-gui/po/sv.po              | 27 -----------------------
 git-gui/po/vi.po              | 27 -----------------------
 git-gui/po/zh_cn.po           | 26 -----------------------
 scalar.c                      |  1 -
 t/t9210-scalar.sh             | 20 +++++++++---------
 21 files changed, 16 insertions(+), 432 deletions(-)


base-commit: 7b2bccb0d58d4f24705bf985de1f4612e4cf06e5
-- 
2.52.0

