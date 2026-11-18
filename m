Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795034127;
	b=IBhf1py52YrR9rHbJOH3yTKbOm8IPU1ypgPX1dfL8d0wfQqqIGawVvtO4SPX9yOcb6I8
	 6xHuRxmH/nN6ID21NequyEVLzzA/b37f5WyPX9gIzfkkSm7j/Mw/RtFeDD57KBaQe9cLh
	 xIXRBBG0d4vfrvVLE+aljQbOY4YYXEcQXxS86hCKOuYk0UVL/IbFozGJJcZChn5+8zTpO
	 /D2VmI+MSHcDnHAT++zTJsKbBmIN43q+VmJlLP0Z5ChOLlMyOVFE05z/ytwB387FGK6/s
	 G7SpSjJcjeESMwPkgmlVRwWXQksewZD6LvN6/eBQlpKraoR0y7D39R7lBCW1kzXns4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795034127;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=Zx4AcB/QXpAC2vFGhngTTXWqNb2jhpZozckUtIEi3Go=;
	b=dr8RoJyzScVpDhSqG8X0IjNbMwp+moZJwznH1faonAgEe6kMBFERUnrod+tYATB1KVUQ
	 MwCWyjKyu8f3G5AoJnHwxgeNl1t+5xSKAwcHghWoIrcBRjPOMmj4qdNJX4m30W7v4ipog
	 Hn5xhBauAislJRNqTaWxBXtGhvxTBpQgxEQvJ30yhQtO5Reg5o+zPjv0R+H0GSsss3Tzm
	 MTg9d5xbAT/Fh1wltDS+BS5yQYgFRtL/QB+7uRbEqfJ2iIxC8yXIpfbD5TAHvPMOx5H2+
	 Gy+ZBBsvkIoSetZwBXr3rwDhDdmbjg03cC+RKRqrAwanhu0O2IML3iJ1j73qni/YG6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.com;
	spf=pass smtp.mailfrom=fastmail.com;
	dkim=pass header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm3 header.b=igPoZW8a;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=tC5uBrQG;
	arc=none smtp.remote-ip=202.12.124.148
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE2F60A260A
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 20:35:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CE2F60A260A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm3 header.b=igPoZW8a;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=tC5uBrQG
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 8CB141D0025A
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 15:35:25 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 18 Nov 2026 15:35:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1795034125; x=
	1795120525; bh=Zx4AcB/QXpAC2vFGhngTTXWqNb2jhpZozckUtIEi3Go=; b=i
	gPoZW8apqz5wo2y93EmO2i6nAlCie1AJDIqKD4MycubjW7z3JJTOXSSzfIaWK1Tm
	6IWcWcLVTWpoVc2l4mTkMHMgRlPwpninFwwdN849vERYMabuFIws2e8OF2TniK6v
	M67LMD9FXTqrECzKmrCAijRgJxVEkq0eCSCV0P9OBjI1lG8x0biEthRI30+tI3Mp
	O5+gWG9i90BRqmSxiV6LmgZl6tu+m9szJkR7qGMQwr4tbG++7s+pxte9BDHy489V
	hdXyKNXIeieB7/paopUr2obTmOeh8uKdrzdycEZaL5ke9G47w4uYJ3sTxHr/sZsg
	8mmO8iVNq18YBONah8sVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1795034125; x=1795120525; bh=Z
	x4AcB/QXpAC2vFGhngTTXWqNb2jhpZozckUtIEi3Go=; b=tC5uBrQGY2OCqza4O
	cEXUqEw7bDszF2q67AJ2oIlNRC208qBG+SqUpc4JDxRJdwin5qKjRsaHsZD97KPj
	l6vNfUKdhH7OopEF5hKuvKST4VzQBODVjUicWMs4rIqTMmDU3igDE0NfIMaVXBlN
	OiQfOqZoMf1ydiqpLsXJ49DZjHsDqRksbQbPcKdRtNKYu4+LwnZGP5mtZItiE7Ps
	cJ11/nv3E/QufZBmufN5EA+snZUlhzJAo/YPYn08RQcYFuCxCNNSqPkmVgMExu7K
	7bhK9nfoGtH65suHypKcmiicIO81gJ3CLrvaG5OtSjDsfXJBGHP+JqoLagl/E214
	VBNvQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795034125; d=fastmail.com;
	mf=PG1hcmtjaHVjYXJyb2xsQGZhc3RtYWlsLmNvbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:ULp/L88FynPp4O0oulbE24hQTi9Aec9fsnXzvaluIHxCSK7
	vyCFWbaCJkp0hBUI8qT+0iFXqHdX9EUcQHCcUn3Nr0A5zu11MJ+BPRdwPd60tfNO
	1aL0UHmk7P4SCm/8pbv021uiMX3viQvzwkSYyx2wZBYocSqFn1SWRm/vLaTdy+Eh
	HAB++JCEhFbgwYEsI8jOJI2Rpib98wdxTx3PD+9Odv/dtNlj/mHaErZeUaYgCcfd
	kOK0IQ+0YJtK2SQAYJOW/PGlmjclphLfMh6EMTB6NGxg8hI86FEjYYIY0HO66XoZ
	AKPeblqD/3zJ9v5TSsHaHzxSDBpZboevPX8XZYw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:5U6ZshYLgHyILgUhl0BDarGF+y9Fqd49k3qnez8QJgY=:dMmasoJfx+rdCfqydJMUJQaMRaQwPdX+Y5aWK4v7CKM=;
X-ME-Sender: <xms:DQz-asCCFTUALd8_cY5U1dhXmhBTq3bNG3sSyQfjio3pLJMUYjVqfw>
    <xme:DQz-aqC-s5lTmDl530Gbm9yI6171cx7mB7yW0GIEYgHqWEJ-YaCJABDQCcnFTZXYK
    5JaUyQYlKlfe0DewHpggExmUf5FxoDMD4bNlmJ7VNNogu4F08HTc0jE>
X-ME-Received: <xmr:DQz-amAU7e970r9-XXilOD6zytWmZj3VKIUmzsgbHQiQW9N_yhHFnpPd63tBEXVCARFK0RNGxyGlfQUy2b6evAiSBH8BSLtBdT4GmhV0xAo8>
X-ME-Proxy-Cause: dmFkZTEL0j8CULVbTAKkZtrMu9a+DJW9XlgeSj6yRjyKoTR4MOf9pkatWPughQ9HGlSkeo
    D3ZZ24sVJr0ymVCpo1vynQAJw8e4tlduZszMiVUvy4adnIIt+QK2fiBJJabAz/ZeX1gD+y
    8vQ3jUbmzzbIxJH3C9aUt0VWlPvhAxb9W5LqAR6En64byMnMd6P+JOeDUJtHjRMdb0Jt7D
    7c34R53o35LozFNCqdsPmcl5Ao+4b9MLG8Q6RRTHS9Y8y4VCJ+m24k5MuKjgOHMeEDF7rA
    ElmHnK+Gn/FHxInbWgg5laVxZQBmFufzr8HHS04XHicr2UgSDHhyvMBPEqZnApLSOtp1QL
    r4v1TtlREE65sYQolbrOJ9C9dTVAvjFsyNC9L3DmuhuMEEb54p9f3DrcORdHer1x3xK+I7
    QuAYtO54c0hbanoTT2HouzqXOAYT3rDhl6moAbKXXuqUB5HrOE2jrnsmCJ1UDhE73kDZSr
    30JOoS+OQeQYpJwSXxLbzwRzRhA/i31Six4yc8k01gpZkCCZ7unH9XS0GJ17/DfQKsjyfz
    AEYn0T0j47FLSTm8E2YgWJqw7lG5+ShCrvhcp+ApjNWLhCCI9h+qm1TCovrX4kRVwh1nJM
    Nxz887bCW2QMM4sS/hpbsQhnqexQVN6upUw9pGDjT11HsE2gyAUkHsEuy+6Q
X-ME-Proxy: <xmx:DQz-atqp1WX09i01dlXoYU7m0iX-BS2x8CHlptti_tl5AjZr6Q22jQ>
    <xmx:DQz-aomHh_dLCs7gTJMxXqNKQJJuMHzz5gCWnUc--QrfwJLx4YNM0A>
    <xmx:DQz-alwT_z4s65e3oREldWiaZ8_zjsGFEhom_smwtAtYbCu4u9IY2A>
    <xmx:DQz-ao8nQZZjmMjBC0H-ELtoUm7jHVLQ-ThTRbq53svBv1qec9J5fg>
    <xmx:DQz-atD_DpN8Tm1Ts9NYc5zdp3j-eqPbprFYcUFiPlA-_maP_ubA5raa>
Feedback-ID: id2564aa6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 15:35:24 -0500 (EST)
From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
To: gitster@pobox.com,
	git@vger.kernel.org
Cc: jltobler@gmail.com,
	ps@pks.im,
	"Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Subject: [PATCH v8 0/1] repo: add revision filtering options to "repo structure"
Date: Wed, 18 Nov 2026 15:35:18 -0500
Message-ID: <20261118203519.2379494-1-markchucarroll@fastmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015144559.3652143-3-markchucarroll@fastmail.com>
References: <20261015144559.3652143-3-markchucarroll@fastmail.com>
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

"git repo structure" provides a collection of useful information
about the information stored in a repo. In particular, it's
valuable for diagnosing performance issues caused by large objects
stored in a repo.

The current implementation of "git repo stucture" provides summary
information about everything in the repository - all of the
branches, remotes, tags, stashes, and notes. But sometimes
to properly diagnose a problem, it's useful to be able to get
information about the specific part of the repo that's exhibiting
a problem.

Add the option to specify a set of revs. If revs are included,
then the set of objects processed will be limited based on the
rev specification; otherwise, all objects will be processed.

Differences from v7:
- Add SHA1 prerequisite for new tests.


Mark C. Chu-Carroll (1):
  repo: add filtering options to "repo structure"

 Documentation/git-repo.adoc |  31 +++++-
 builtin/repo.c              |  32 ++++--
 t/t1901-repo-structure.sh   | 197 ++++++++++++++++++++++++++++++++++++
 3 files changed, 247 insertions(+), 13 deletions(-)

-- 
2.53.0

