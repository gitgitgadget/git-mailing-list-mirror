Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2AD1C6FE9
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 07:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748848664; cv=none; b=b6gmFTilB+/+l9lVZoKh663c3sDrRlKCu4mRNSo+3ORbB8M/RLE4Ldh+Lk6bS5Jp0NU4SCO2vU1LnXhQuBEeHZ1Une5lkrUbQstkwcfmhrMrgmO8JSbmKPd9n0mOakgvnUJ28YMIpXlICZGS+mjpbv0ow/B5VLSS4nBc+Stqjr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748848664; c=relaxed/simple;
	bh=WbhzuhT6QYCQiocgOFAOJS119Yrq5xm3eqtcb8Gkocs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l44ykWJoomhU8ggN41bBnMG6hP06UATdB6AwQAv2aMH+vlI2Rq+sfTzA9V1q9ue+sNmLmqDFsgIUlTDOnGD0UBjtd528iDZ/Tw1ExVgEp0vcCFiZiTfR7kkPOCYNMRSJFzWICY6wrzH2MD3OppIC15a22QhWYqg889Hhe6SOV7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AI/aCyej; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aCY1Mj3g; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AI/aCyej";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aCY1Mj3g"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 26F0B25400DF;
	Mon,  2 Jun 2025 03:17:41 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 02 Jun 2025 03:17:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748848661;
	 x=1748935061; bh=scow+N2yyOnoThMbj6E+OpE6dVCccSWAC6Dilp2L05c=; b=
	AI/aCyejSEpU5uLSHTZ+lYfHD3txCt3FktKbAOQJnTi2N43sHK5xuxrLck+BItSx
	yG7BxCZvdC9XVbz3M0G606IxF+Tn0yrXPb7J3dFlYV+cNr8yNwc9lp+HtadTb+SL
	VQn4q8NVtPJKFumILjgjtQOX6bMAXn3l6qMW599dJDNqNqfmNMffWxD+4GY4FUHA
	Npkoideu9D3S+RtMCr6kZ0WKF0gm3/YjLpVTiar6wYKJVpH7rC0z1I2MTOeJ1wae
	0+uoeFPp2oXRGWLCjwsjOO96hVaUUXN5d1iWjfVwlbqEYbsW/gv2ZZQUM70vNaQT
	pfEvpVUqvoM1rgGZYX7O3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748848661; x=
	1748935061; bh=scow+N2yyOnoThMbj6E+OpE6dVCccSWAC6Dilp2L05c=; b=a
	CY1Mj3gN6O2FdgEvp3LWmmgFs0pKMER78zURLJ8wuVLw+ONigZY7XlVKojsoTmP4
	yrmX8PtTf4ifb6inrM1OOpqpuuN7hHDdEG8zt3vTsRQ/zzVPyoCtbcSwzB4ZzsEN
	n+HXpPoxrW7lWB6dRkeMIm07Wkx6AT+yv3vBBPRPCh9kU4MbOrS8fZHdsocJzMle
	5i729TxleJtikISnU39tV5xYy9z7PZ6cay2mIPSmnOH3RJfJkoYGkx+fIRUXWR7g
	rGoqmBL2HQr4cZ65Gxdpv9XTVEz6k6e2DC1mlCFadksJ3CBoXgpeKMCeaanqJ2IM
	CaNLbWjf1eZpM1nSWITLQ==
X-ME-Sender: <xms:FFA9aDGCPppztRcaBkwVVLP9PE1zgPdkRJPBZcVkqyt_Ar15anqu_w>
    <xme:FFA9aAWRt6DRo5kx6G85G84EOTne4m4VYnpKowEIrqzS7nC7IDuHmGWzI_Y-P_E6j
    kRgPpZzbfzCM2GeQg>
X-ME-Received: <xmr:FFA9aFKVb1jgtXX5xFf_B-2xeHEsD8-MYZVyWg7r_U292f3-3EXtieVsrbvHHA9cumnXaJo3zrKqySnwT5Ie1793s0QIED1DqZdSVBVePG5Vtg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefjedtgeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffk
    fhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeeh
    uedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuih
    iivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrshhrrghfle
    esghhmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdr
    tghomhdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrd
    gtohhmpdhrtghpthhtohepnhgrshgrmhhufhhfihhnsehgohhoghhlvgdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephihroh
    hthhesphgrlhhorghlthhonhgvthifohhrkhhsrdgtohhm
X-ME-Proxy: <xmx:FFA9aBGsJfAAdZ52JV6GUyblIrnEU0yrHucOFcf7bVCoxIc0MRbfWg>
    <xmx:FFA9aJVNkbJIlg5WfnKV-rYnYoagW0MveXLlbwt_rUBWabPx1YO6Xw>
    <xmx:FFA9aMOC1M_IDFVW1RBLmXzbF9krj4LV9TV0y1UnMGVyrecKvrNylQ>
    <xmx:FFA9aI1wWINbLrB-YtmjMoul9Aq8Qdu-hfaXtBnYyMMlPjh9pZtVfw>
    <xmx:FFA9aIrzVEkOdfyyoDkyHHHD4xDGh1O0v3z02wQML-1EKAMljM59gtrH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Jun 2025 03:17:39 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b3c34551 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 2 Jun 2025 07:17:37 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 02 Jun 2025 09:17:35 +0200
Subject: [PATCH v3 09/12] builtin/maintenance: fix locking race when
 packing refs and reflogs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-b4-pks-maintenance-ref-lock-race-v3-9-587d44252dcb@pks.im>
References: <20250602-b4-pks-maintenance-ref-lock-race-v3-0-587d44252dcb@pks.im>
In-Reply-To: <20250602-b4-pks-maintenance-ref-lock-race-v3-0-587d44252dcb@pks.im>
To: git@vger.kernel.org
Cc: Yonatan Roth <yroth@paloaltonetworks.com>, 
 david asraf <dasraf9@gmail.com>, Emily Shaffer <nasamuffin@google.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, 
 Ben Knoble <ben.knoble@gmail.com>
X-Mailer: b4 0.14.2

As explained in the preceding commit, git-gc(1) knows to detach only
after it has already packed references and reflogs. This is done to
avoid racing around their respective lockfiles.

Adapt git-maintenance(1) accordingly and run the "pack-refs" and
"reflog-expire" tasks in the foreground. Note that the "gc" task has the
same issue, but the fix is a bit more involved there and will thus be
done in a subsequent commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 72a695853e5..fdd0dd09be7 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1587,12 +1587,12 @@ static const struct maintenance_task tasks[] = {
 	},
 	[TASK_PACK_REFS] = {
 		.name = "pack-refs",
-		.background = maintenance_task_pack_refs,
+		.foreground = maintenance_task_pack_refs,
 		.auto_condition = pack_refs_condition,
 	},
 	[TASK_REFLOG_EXPIRE] = {
 		.name = "reflog-expire",
-		.background = maintenance_task_reflog_expire,
+		.foreground = maintenance_task_reflog_expire,
 		.auto_condition = reflog_expire_condition,
 	},
 	[TASK_WORKTREE_PRUNE] = {

-- 
2.50.0.rc0.629.g846fc57c9e.dirty

