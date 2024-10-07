Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219742AD05
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 11:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728299498; cv=none; b=hRYnDXvlQl614JJ8hZaeFgRQFGiiN2JFT2DaqIbOKDEK6z92eUDcTmvp5YlF9IHTDMnwf8fRVTe1SibDJLQQDQpeACxfXoUEufnhmecj7RnDJlUthuEhoKEL6OwehLmriJ8Su4Nx78f2H1937586ZfNe3lcIlrZDEbffS45j9Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728299498; c=relaxed/simple;
	bh=zA2c9XbqCUarERE8f2Y57yHFn1sbGkWWMJtf4yZ3vQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ItroZrxq4hnSSMu1dlaIff6HFAorx7HLjtK46dQVcuqaXbIuDF4bguzoa3ACfxSSWBUh1e/AiVR1qcH20BzmYQBennVYMSYEhx8n01pfHgdHEF9kNv7bnQtPGvte/+BRbdyliLP59YObI2N14QMG4D1k92F5R2I918DmJWPW4Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=ckAUZpsb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GsXqjlDW; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="ckAUZpsb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GsXqjlDW"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 34A4713801AF;
	Mon,  7 Oct 2024 07:11:36 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 07 Oct 2024 07:11:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1728299496; x=
	1728385896; bh=GF0Y0+9sGh+GTDrU4gptw3pAD8/190CmkxAAphtZp7k=; b=c
	kAUZpsb2LMX/mg2j0kpoOcUbjgVXfSUGgVXyg5maHgUT46MYdT53G5N/7oBWYLdH
	wfNauquI3m0S5zYi9qyQoX5N8l2yqhh2rdj//aX/kzf6OQs95OASNj82hJ+ORdm0
	kqQ1XVlvRpSs81Ezxex2//2cBQaWkMOiQ8i2SiIzhPz2FRsNWsKrvUaqW8ACSS1R
	DLiPE08KRxhtyhow6gMmMcZq0R67/O6zXafMD0hlipMeGl2DwQnrSE7zSJf6ys3x
	6we/HQ3LmCRMFbGi4Pl6dt/zCjF8lgfHNjHV5fi+YM7b2XeLfj4gwn+nQSXWu5o0
	KuzJ/WVBho9qZPB7/ftVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728299496; x=
	1728385896; bh=GF0Y0+9sGh+GTDrU4gptw3pAD8/190CmkxAAphtZp7k=; b=G
	sXqjlDWtRYREFLEqwT+RH5e4kZEV82hU7pKn++Q0PSGlrU+JNeSLS4lwlkdoLlDx
	dywmeRTgpdHJzH2SxI+5iMMDjxyZC+3DxQicBd/9jpmO+hCt7iW85uYIi+ENDb+h
	jofULBo7iMXuLBMCVXwF2q94YlmpwNYPohpFNgrJLKgWKTm1FmTt4K5mciz9eUDl
	iABWxZUOeWNnJF2L7zlKjKROmJXOt6rHuI5z9JiFxc+vCN5Sfp/RGBpTIAqCgOwF
	Wx8U13iBvUQym/LlyGd8L/Sya/R9BhKCDncoT25rP74VQZ/bZGP6lc4kOr01txNC
	be3LPERelO3ykpBKL3fUA==
X-ME-Sender: <xms:6MEDZ_ddZLUAEzQZg-Z_nw7JATpRwIVxACZsUKYuW31U0_V2QBBqm_Q>
    <xme:6MEDZ1MI0oEiV_XFf_6t38owP82KrRXPMz-ddWXIMeCdwvuxcb7-cKrY-UENWjrRg
    kqz5u2nbt8bElfKKw>
X-ME-Received: <xmr:6MEDZ4h1zJdUbAg37qQplfGwiza5G6ksO9fTDaHfA5VmlXcFQjac_gT-6c5-oSNOKqRRW1hrjArNW6xZksBJExlo7Fxc1Y7v-B7QCAlxjQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvledgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefmrhhishhtohhffhgvrhcujfgr
    uhhgshgsrghkkhcuoegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgeqnecuggftrf
    grthhtvghrnhepteduieehgedutdfgudevkefhveduieeiteejhfffteeitdegjeeihedt
    hfejgfetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhnsggprhgtphhtthhopeegpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshht
    mhgrihhlrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:6MEDZw-n6eG3FqiVWO7ZaibOaTuIjHkNG6jWHykHzuVD9n6D0BztCA>
    <xmx:6MEDZ7tfq1yAcELeZ3ruKx_4I3Vk970bmlf_qwlS_V80A6jN5P3wJA>
    <xmx:6MEDZ_FgRFh7HWbKYZy3yxzXkc2QuwebnkMMZjy-P8A_P_s9-NxLMg>
    <xmx:6MEDZyNe_9JarfoF6q3Eyjj7eCYtCPt0vViPjHHpCXEZVkyjXcMivQ>
    <xmx:6MEDZ1JuY3tDmvUTuFjOKPjK8VAjofW9SiZdXCR3-ykGGE6oO5ETs8Wl>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Oct 2024 07:11:34 -0400 (EDT)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	newren@gmail.com,
	Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH 2/3] doc: merge-tree: use lower-case variables
Date: Mon,  7 Oct 2024 13:10:28 +0200
Message-ID: <97f16cb68e059792ddc7d1897ab6e93d536fe19c.1728298931.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.46.1.641.g54e7913fcb6
In-Reply-To: <cover.1728298931.git.code@khaugsbakk.name>
References: <cover.1728298931.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Commit-Hash: 97f16cb68e059792ddc7d1897ab6e93d536fe19c
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

This is easier to read.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/git-merge-tree.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
index 590cbf5df79..10f8ac7f80a 100644
--- a/Documentation/git-merge-tree.txt
+++ b/Documentation/git-merge-tree.txt
@@ -211,12 +211,12 @@ linkgit:git-commit-tree[1], linkgit:git-write-tree[1],
 linkgit:git-update-ref[1], and linkgit:git-mktag[1].  Thus, it can be
 used as a part of a series of steps such as:
 
-       NEWTREE=$(git merge-tree --write-tree $BRANCH1 $BRANCH2)
+       newtree=$(git merge-tree --write-tree $branch1 $branch2)
        test $? -eq 0 || die "There were conflicts..."
-       NEWCOMMIT=$(git commit-tree $NEWTREE -mMerge -p $BRANCH1 -p $BRANCH2)
-       git update-ref $BRANCH1 $NEWCOMMIT
+       newcommit=$(git commit-tree $newtree -mMerge -p $branch1 -p $branch2)
+       git update-ref $branch1 $newcommit
 
-Note that when the exit status is non-zero, `NEWTREE` in this sequence
+Note that when the exit status is non-zero, `newtree` in this sequence
 will contain a lot more output than just a tree.
 
 For conflicts, the output includes the same information that you'd get
-- 
2.46.1.641.g54e7913fcb6

