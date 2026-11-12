Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794513546;
	b=ARZQ6hvguTy3e6Y9Lm69OzQHot0LIcOq5LbKkq+XoRB8F7b4TrCy+D+9b/ja/5/q5j61
	 E+4lajTGwgDpBYRkB8xfi3pvL3sjg3EuHreh82HrKJ7N0+N+mJRvV7jFIAG8s/SKcRaOp
	 SsdsMu3G5GY7vEESrf7FmNE7fjcSVzDGgh1R7g88en3TjwNkAUz/jVn4etMNuOJNQuMks
	 YXQOmePoDab/+H7+pNqoS9l11Iw2Pg8447h1exm+2SuWo6QxjT4KpRvGqiolCfoh1BwEc
	 xmlvgRS61DQejYkdlDSY2+LSrXtkPBn7OhbckpFSkvJbbvL414LaB0FgGiYR+JEjs8w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794513546;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=HA/dOEwpX0yF8V/LsoPPifRMwqEc8Ptx8Jy0rtvKNwE=;
	b=sJ1SJj2f3gZvENDb+W50k4XNiJvZu2aKC+yadbXNxodspapb8EY86A0ns4rhHVtKEeT6
	 4oQ35rAqsBQ+pIwf3fUj8frfFtl4hrrfNOjwDmrUr60HVOZNGQnFCVjkBX/9oguyCTrZ1
	 TCuG4uJEstiDsCTCuT7OTa4DvvB1rLPNd3OcmM0bzHcJvixwDwGkrTMnTU5SeptSZ7Wxs
	 mlSv40g5dMOOdh9JC3yHtslhl2ftf0cFeBioX5xaGUyJMOt4uwJOHYNKgmttNvWlGwqqf
	 vddeZROXPHE57vo9DisIiv+TsfA4KlTeKadxylUCIOYL3D6xZkS/g8NLEVsIpsRls2Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=I94HuHvH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.12
Received: from sender5-op-o12.zoho.com (sender5-op-o12.zoho.com [165.173.182.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6EE606A31C
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 19:59:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D6EE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=I94HuHvH
ARC-Seal: i=1; a=rsa-sha256; t=1794513531; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=gkDhRa5RjskpwgCQkxubIcxyfKJLoYZ/MwsWw3sqwNkHszklU/WV2wcxxzi/3t1sPmW3bHgDZbqTrO4BIicCuULRcTIa2UyhugUE1GVohyCDhERxAG67Fi2LzrpbCEQ1c53/gBLCLletbPnCV6UL4y+1Xxo3GWCy6Xdk7QwdUgU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794513531; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=HA/dOEwpX0yF8V/LsoPPifRMwqEc8Ptx8Jy0rtvKNwE=; 
	b=WwDhGBnsSyKzWExZdS6Hz+d8vtOLVMWO3nBJLMmsQN5jQYEpj9fNhE0vMxeiRq41HrJ7RQh1uDIHfc1pPRMYHhT/okV4FU1FtSZZot8PxpJ672YZJLLoe/c9xw3VYz3RJXNpCmlmfMRb6B0y9lo4w6I/SL3DaVdzIzcqjpw92sQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: a=rsa-sha256; b=I94HuHvHM6DOt/JqUBtl2y21RolGBgMv0gI7zlNG+gqyXqVbWlzgpj9+CbT3a5uPEsse1QiKY4whOY3pT6vKx8hh7vTQeAVPeo3072aDqsPZpmSh4pmhNeykLDEQMCRF5FxuY59F3k0Y3ECviZaGGmDYp4aI6Ew6IN46JeFWE+A=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=HA/dOEwpX0yF8V/LsoPPifRMwqEc8Ptx8Jy0rtvKNwE=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794513529487498.4009639779913;
	Thu, 12 Nov 2026 11:58:49 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Emily Shaffer <emilyshaffer@google.com>,
	Josh Steadmon <steadmon@google.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH 0/3] compatObjectFormat: fix a BUG(), wrong id and unknown headers
Date: Thu, 12 Nov 2026 21:57:37 +0200
Message-ID: <20261112195740.2834341-1-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.56.1
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

I've been continuing my three-way Git, Gitoxide and Jujutsu sha1-sha256
interop testing and uncovered three more bugs, this time in Git's
compatObjectFormat.

I'm reasonably confident in the first two patches.

The last patch needs careful review, because there are two conflicting
behaviors: Git copies unknown commit headers when it creates commits,
but rejects them when converting existing ones.

I made both copy them, which removes a check added on purpose in
08a45903cb (object-file-convert: convert commits that embed signed tags,
2023-10-01) and I'm not 100% sure it's the right direction.

More details in the commit messages.

Many thanks,
Adrian

Adrian Ratiu (3):
  setup: reject compatObjectFormat == objectFormat
  rev-parse: die when --output-object-format cannot map an object
  object-file-convert: copy unknown commit headers unchanged

 builtin/rev-parse.c           |  8 +++++---
 object-file-convert.c         | 21 +++++++++++----------
 setup.c                       |  7 +++++++
 t/t1016-compatObjectFormat.sh | 18 ++++++++++++++++++
 t/t1302-repo-version.sh       | 14 ++++++++++++++
 t/t1500-rev-parse.sh          | 18 ++++++++++++++++++
 6 files changed, 73 insertions(+), 13 deletions(-)

-- 
2.56.1

