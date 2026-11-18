Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795019617;
	b=xtn3a0R79lYtccyuZbguYCybm51EoVxqbwwA4htLcv8naLo/AVKMM4nicBZwgAXoKdKy
	 w06ny9azSicvtjgqui3QJA4u8qGI/PnzidKZzX6yM+6AzYwTho46lgoFad/qEZF2srnI5
	 izzNObwtussDW92792iDnlHFwGpSBBPgVU8j7jYVl7YHTqW+VECsDSJovdyw+s74XIMbZ
	 C0NQ3VuKvNcohWaZSALaaKJQyK5x8FsgHC6Jiw9o/aY9etodUw4PebMDafTk1iXI+fhB+
	 Low72+Y5jsyM9Zs/+CHsDyB1b9jvzT+7Dpvm2zySLfvI5jl4VPuiu8O/jb/Reqd8/Fg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795019617;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uw1ly1D9521vcwEk4pZgnFrEWqHr7hXEIjxrH/rhY1c=;
	b=B19krbXvQEclYS/Q2NEpPSKwFL5bvYljJioXuXjMfYyTDt9T21rqMwyAhTP05xVZbW2m
	 etUwVT4fHi/8yBOiBLGXuC41AsBNufD+zzPC2aVV1/w36zaQsaHm2xn5H/96ZDaneo3FP
	 f+IfHNGfaD9k65RtMwK8tpQGk8KJd7OW7qZMB9qUqNt72faooFaGyoGk2QhEHXOLhdKTB
	 d1fOKBF52UPRYDYQTxIMb4xfpeNLvN5dpKdzUxfQKrTwFVJGSvdgrVV1ukHb6EjFsQLqA
	 9zfvmCs1++NTJL1rymzP+x9VDZOMt3lpjmLxmU5klIs9J44FjJHwuqFXcF0Ac78bH6g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=gmRcASQQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.12
Received: from sender5-op-o12.zoho.com (sender5-op-o12.zoho.com [165.173.182.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E012606A33B
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 16:33:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E012606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=gmRcASQQ
ARC-Seal: i=1; a=rsa-sha256; t=1795019602; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=WZl+hPZNpq7ZbAxIbDmWRSi82x5jD8vpY2avoEN6+KEZPXK70j8H5aTuBNBGs16JoKtz3A9vRsMvGP9DrAC29cocogFERiXn5qsTSI652Y1DXisqL1801gfgFucmAyzXlheEmxCfc7Hn/nJ8xvwR9MQCaOFF2yaruxxKoBOCxb0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795019602; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=uw1ly1D9521vcwEk4pZgnFrEWqHr7hXEIjxrH/rhY1c=; 
	b=nsQ+gUVlF6awh6WezPXSSKCEjTQmguYxCOw01C/nqpBycWINhFuawLUH8rl5yzrU18g72+swnXYqAxX8YINPjevo24HsE6lmO8vMgwAXD7rdVitgtu2x1rnMmiYhxdoYcd0aRWJt70qWe2BOojLx4mCHk4OaBSOdljRoHTZwYvI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: a=rsa-sha256; b=gmRcASQQTn8WcZCvSiLS8bHmvo9modFco9df5iAGorjFKFshMy38Byq+cHd4TGR3TAjCUBDCxIRsFZQX2RlffLMSC+43Ly1m6e+mo13a0Tw3XO4ARkyP/CKRI/ejYZomX+wQsFo49MdZOWc33l7XYiA3sK5ZYCPZ6x7LAMrKtr0=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=uw1ly1D9521vcwEk4pZgnFrEWqHr7hXEIjxrH/rhY1c=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795019601182144.8641961728597;
	Wed, 18 Nov 2026 08:33:21 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Andreas Wendleder <gonsolo@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Patrick Steinhardt <ps@pks.im>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH 0/3] submodule: support linked worktrees in recursive checkout
Date: Wed, 18 Nov 2026 18:32:46 +0200
Message-ID: <20261118163249.1693361-1-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <avuJBGlB3pRU3JU0@pampelmuse>
References: <avuJBGlB3pRU3JU0@pampelmuse>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello all,

This fixes a few submodule bugs reported by Andreas at:
https://lore.kernel.org/git/avuJBGlB3pRU3JU0@pampelmuse/

In short: when a submodule is a linked worktree of its repository
("git worktree add" inside the submodule), a recursive checkout in the
superproject either crashes with a BUG() or leaves the submodule broken.

The patches should be self-explanatory, many thanks to Andreas for
reporting and sharing a reproducer.

Regards,
Adrian

Adrian Ratiu (3):
  submodule: return an error instead of BUG() for an unexpected git dir
  submodule: only suggest submodulePathConfig when it is disabled
  submodule: accept a linked worktree as the submodule's git dir

 submodule.c                                | 72 +++++++++++++++++++---
 t/t2405-worktree-submodule.sh              | 40 ++++++++++++
 t/t7425-submodule-gitdir-path-extension.sh | 14 +++++
 t/t7450-bad-git-dotfiles.sh                | 31 ++++++++++
 4 files changed, 148 insertions(+), 9 deletions(-)


base-commit: e1ec09b23c8e0deb21a0b95ac5996422277395d4
-- 
2.56.1

