Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF593AF665
	for <git@vger.kernel.org>; Fri, 17 Apr 2026 10:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776423068; cv=none; b=oCpnKMY8wOzHlWBguF2lObDFM+JLl7wJ2hBNzJqfU2uBptjSMf1ppz6Ef2v6J6jJ3ap4cicaYcTe+rRCRr3uo93e6SDzyQGwYrBENM8d0/4eedFXyuRd90Y6xDADSlE3SFVrfApqsDB/w+vh2yiayWB0JnPO+Qg3z9dCxUf3HqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776423068; c=relaxed/simple;
	bh=QwaFflupcgZGtUiTur+0TZkVNF0tju6K2qOV2/CElLg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fBPHJxqUSzTaTKWsBuXJjs6tjSf591Y6tOQ6MW/8ygQu21BsCkmgRRO8tntlfguunwgjn8fmXZvKDg0jC/dP+XdSO96r/qPH6G2reVJzKUtziqJ7E9PtwWv0WZd1cayrmznSd/ad+zh1ZidpG0OoGtUeNQcuBXuqbGsZy7ldMdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ECmq97c8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jmPIwu8d; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ECmq97c8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jmPIwu8d"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id EBB74EC0143;
	Fri, 17 Apr 2026 06:51:05 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 17 Apr 2026 06:51:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776423065;
	 x=1776509465; bh=JH42nt/3fO7vfbU6MbHQgipsNo7cRzzerK9UINFMLgo=; b=
	ECmq97c8v/lPf0snA1NmO733Ogiaeb4I8O6YdR8BZEJtjRfAieFQiwFR/mRUEWCs
	2SD2B2tuYdk96apG1j+PZSIw+322If6By+A7P3z2OsYZOn2dw/L0tJffBlTumbQz
	AEJ7NImIsJcL7vuZBMXEufySp7g5TxGJ7yzdS3qktlCV0T/WaVof7/D0LhtApUpc
	9zuqlrvnG7IqHPZqKNq5c4ntZFCV1nxIeVVHMOvoCR0IzDF7uHwv8b1AP9DOTbV3
	TA3ziGUKYp8NLJgxRBDQ0/LGTd5QdnjUN/+v6RibIAPV0mz22Lxj+yq3mWO1J/Yx
	u9Qobh5ftoYv5vNyp9Fc6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776423065; x=
	1776509465; bh=JH42nt/3fO7vfbU6MbHQgipsNo7cRzzerK9UINFMLgo=; b=j
	mPIwu8dE3b4Rbve7FN3KXuWyFqOFsePKni32P3+pcRkCZB9qkKtzXMwXG2YybEjP
	y9OJ3hjzZPjTUoqEGaBKfPoeP3qeA8leXceeGoTKMFb7Ikeu22kUsagAU25Njy75
	nkpkuI6hO3DxRwgPefKyX4Wb49KaKpRwoJ25xgn102uXtNfBZvfHRA25+0tGJ/Ev
	mm4JDBqItA6IQTEyCjNxybiM8CDCYn0gLtZaVQh4t6ugsiY19uREkneXELUaNwFm
	ECsXv+qqtl51YuNO/uDhRqwaiziMyWuMWSGvSHxsKAWW7skQktObAar1V/tA2bSl
	PG5TP74YbOyHZmbKJH8wA==
X-ME-Sender: <xms:mRDiadvgyuaAts9IF1lswjX9pWsB2nUDpuq7aT-9bNHQQm8cpAnnzQ>
    <xme:mRDiadc_eSHiGZO_5RQMvtvlfzNU0IbIvpMEfPCwK5skHC-7icULSR3MEFlzfrlLm
    Aod_Ha_HPzhxp-SDuPesXhKmHPryWnuaGQm4K-8EtVYBx1VA9_tcw>
X-ME-Received: <xmr:mRDiaVxmGeqxhdeTche0SGnnV_fpeAthzktqVynG7a_yVCZhOzSQmBXjD-rTxtX2Lj1bRKTBSi-yTah9GM5uWd1KK9cxwRf69PsFtiAug05Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegleeilecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepshiivgguvghrrdguvghvsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehpvghffhesphgv
    fhhfrdhnvght
X-ME-Proxy: <xmx:mRDiaTFLt3zioP2UWCVocl51tIBbe9gA4R6iW8tatN7v1699uEidCg>
    <xmx:mRDiaZw_BkTn8M67whO4e8CL4MUte3AO89DK1FjP07Trsmzg3AzpQg>
    <xmx:mRDiaUuLNc7onc2xAokpCQgjvbe_Bl6kOpzx6_JcaUZyZ7XM-M1MsA>
    <xmx:mRDiaW3EAOOIu93U7oZSIVrvfwPKvJsgPC4xOxeOuJIvqYeqeNHQ4g>
    <xmx:mRDiaRvo1yaY7zBXr7g0yZxVTMVt82TsRFGgdlzeyl3d_xqMko3R34SE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Apr 2026 06:51:04 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9c865493 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 17 Apr 2026 10:51:04 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 17 Apr 2026 12:50:49 +0200
Subject: [PATCH v4 03/12] t: prepare `stop_git_daemon ()` for `set -e`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260417-b4-pks-tests-with-set-e-v4-3-44d43efdafb1@pks.im>
References: <20260417-b4-pks-tests-with-set-e-v4-0-44d43efdafb1@pks.im>
In-Reply-To: <20260417-b4-pks-tests-with-set-e-v4-0-44d43efdafb1@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
X-Mailer: b4 0.15.1

We have a couple of calls to `stop_git_daemon ()` outside of specific
test cases that will kill a backgrounded git-daemon(1) process and
expect the process with a specific error code. While these function
calls do end up killing git-daemon(1), the error handling we have in
those contexts is basically ineffective. So while we expect the process
to exit with a specific error code, we will just continue with any error
in case it doesn't.

This will change once we enable `set -e` in a subsequent commit. There's
two issues though that will make this _always_ fail:

  - Our call to `wait` is expected to fail, but because it's not part of
    a condition it will cause us to bail out immediately with `set -e`.

  - We try to kill git-daemon(1) a second time via the pidfile. We can
    generally expect that this is the same PID though as we had in the
    "GIT_DAEMON_PID" environment variable, and thus it's more likely
    than not that we have already killed it, and the call to kill will
    fail.

Prepare for this change by handling the failure of `wait` with `||` and
by silencing failures of the second call to `kill`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/lib-git-daemon.sh | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/t/lib-git-daemon.sh b/t/lib-git-daemon.sh
index e62569222b..d172aa51f0 100644
--- a/t/lib-git-daemon.sh
+++ b/t/lib-git-daemon.sh
@@ -85,14 +85,16 @@ stop_git_daemon() {
 
 	# kill git-daemon child of git
 	say >&3 "Stopping git daemon ..."
+
 	kill "$GIT_DAEMON_PID"
-	wait "$GIT_DAEMON_PID" >&3 2>&4
-	ret=$?
+	ret=0; wait "$GIT_DAEMON_PID" >&3 2>&4 || ret=$?
+
 	if ! test_match_signal 15 $ret
 	then
 		error "git daemon exited with status: $ret"
 	fi
-	kill "$(cat "$GIT_DAEMON_PIDFILE")" 2>/dev/null
+
+	kill "$(cat "$GIT_DAEMON_PIDFILE")" 2>/dev/null || :
 	GIT_DAEMON_PID=
 	rm -f git_daemon_output "$GIT_DAEMON_PIDFILE"
 }

-- 
2.54.0.rc2.529.gd9106f7525.dirty

