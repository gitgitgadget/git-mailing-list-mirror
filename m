Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532AE21500E
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 19:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728414426; cv=none; b=IXluOauP3TpAlnNCpmW9LirKl9sdtm1hpa5v6O70SNLdptCwWILgDlgCJPSvizIOy0H5lzvRX1MeTixqIn1RcPRVCtWatphp6q6ER6/+ZHEAFGq+GSnjElUZfOdKNw00qymUuUCOb6BTe/WiqV5ZsnuPG+olz5x62d55TmvFkjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728414426; c=relaxed/simple;
	bh=cj+bh4l6FfWUEdgvRJHBumZbZal+7wuQgVZJc1kNJJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kpins0lYhj3dJgvd0wu3yabyDOShoY47eO8oHVwUMYVB+aqRzaAMpqABqwdjvnKGF8zBTUX1jJ9Eji4M9k7BwxQgF8RW7p0TuUxjW+MYRFunBeAvPb4Mucbgm+RpX8hKh3O8+4KG7CatGe/TNrNbuE2D8o96RNV8fBMBXWlq6No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=B0bGV4I5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gslOfFt7; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="B0bGV4I5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gslOfFt7"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 6D66013803A1;
	Tue,  8 Oct 2024 15:07:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 08 Oct 2024 15:07:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1728414423; x=
	1728500823; bh=g2IBxDjNBq3+PDkfD2d66ftgtG7/JiYrmujlOBEmQ20=; b=B
	0bGV4I51/c2TeGmxDwDT/Ye35NnjWjFE6d4dXfto04X0YIK/NAaMConWlcCSA++O
	1j11vBu2FRzxVlPF5GGUWzhBowVsqv0N1kAFloVWCu3Wk7yDUMg63O1nm74y6Mxp
	3ct5Gwl2pazvUzTItri9TaPZ6rirt7ffZT2QLNRxhDd920iw/8ASbrGVUtTgJ3VM
	8sg2WmaqZweNmrLLsP8bq0H2jk9HxmglB5MyN9P3MIKe0JPLaZx/1pT1HCtsVvg5
	Wsd/fZ2xHgg3/0zQBPfwU0grnTaI8cBHCyONsqM7M8xqV9MD5hR/vE2fgzZIIQjD
	N93Jd9B7UsAqLoD6uvvnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728414423; x=
	1728500823; bh=g2IBxDjNBq3+PDkfD2d66ftgtG7/JiYrmujlOBEmQ20=; b=g
	slOfFt7erKgXW6n0rE3XND1oKDBilcPoSGLsejypGVTQxlUqbTiBMNiNDJSg9jrQ
	BbwywXPSWuNygB8x/nf/CbNVA7PJS66+KxCi01uepk199pwrLV5D7UmwtmAAqPE/
	uk5UP5wILWMIjZUPG2tzV2VUcObjc/sSwagzcau8Y/ReeIpXNKQ7BmQiNcwK7LgL
	mE+pxXjIyw+1E5S0cx4g2nBzkR0N4K3eRMoVl/jT+d8AKUEg0K8P9MWLsPeEf20s
	hvoQJonsSXasz1fJJODbqbC334HT+kuU3V/3CK5oA/S1Fd/N7UWxYzjASxQzhWd2
	uFh3kXzhYc8Mu8fRO81mw==
X-ME-Sender: <xms:14IFZ_kQ1LDloeYLhZsamPidYvzxLpSaylPwwISzhgpeKXX_PVsSy74>
    <xme:14IFZy0MDa2YhGej9HS1iZVtinDJuaHgza5QAagJbH447TEeKABHbu5patCJJFgCr
    KYqZj1iOAVrhkGFtg>
X-ME-Received: <xmr:14IFZ1r1Wp51_lLeOwe-tHi7ZzFBLEvWesfgiFgOoLPxMnd0o338v0NN0Zas1RpMTj8fYHGk0DzBLpJO3tVn5ichYNweaBSbvd6Zen4doV_vzqn9O1aEGPhesQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefuddgudefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpefmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhcuoegtohguvgeskh
    hhrghughhssggrkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepteduieehgedutdfg
    udevkefhveduieeiteejhfffteeitdegjeeihedthfejgfetnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghk
    khdrnhgrmhgvpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghouggv
    sehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepshhunhhshhhinhgvsehsuh
    hnshhhihhnvggtohdrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtgho
    mh
X-ME-Proxy: <xmx:14IFZ3m_BKVv346uYNtCWRbBiirWrwnVUKWA-LSC_uz5q7QtDPSSFg>
    <xmx:14IFZ90A3DTEDVC3mUJqpEijGO7_3jWgeD5VpbXKnJ9XCkHw1gligw>
    <xmx:14IFZ2uIFR0UobJD7EYkkTLxjViB-NWgtpXWif3uC4kX1mku-maDqw>
    <xmx:14IFZxXJ_LnrkHChJSl5IMljUWDe6V6sQBFMlx9LMpB4a2K0T2A5NA>
    <xmx:14IFZ4SFdGqjGMB3TetlCoamIA-zOtBTvNOUzkm7i-NIgjyWASZjIq81>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Oct 2024 15:07:01 -0400 (EDT)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Eric Sunshine <sunshine@sunshineco.com>,
	newren@gmail.com
Subject: [PATCH v2 2/2] doc: merge-tree: use || directly
Date: Tue,  8 Oct 2024 21:06:06 +0200
Message-ID: <13e0f3bed5dd894ee692c672b301697e0a909e04.1728413450.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.46.1.641.g54e7913fcb6
In-Reply-To: <cover.1728413450.git.code@khaugsbakk.name>
References: <cover.1728298931.git.code@khaugsbakk.name> <cover.1728413450.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Commit-Hash: 13e0f3bed5dd894ee692c672b301697e0a909e04
X-Previous-Commits: 4057d6386125e51fd934f92abd11c62a9d24a832
Content-Transfer-Encoding: 8bit

Use `||` directly since that is more straightforward than checking the
last exit status.

Also use `echo` and `exit` since `die` is not defined.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/git-merge-tree.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
index d1157f1398a..41dfb16476d 100644
--- a/Documentation/git-merge-tree.txt
+++ b/Documentation/git-merge-tree.txt
@@ -211,8 +211,10 @@ linkgit:git-commit-tree[1], linkgit:git-write-tree[1],
 linkgit:git-update-ref[1], and linkgit:git-mktag[1].  Thus, it can be
 used as a part of a series of steps such as:
 
-       NEWTREE=$(git merge-tree --write-tree $BRANCH1 $BRANCH2)
-       test $? -eq 0 || die "There were conflicts..."
+       NEWTREE=$(git merge-tree --write-tree $BRANCH1 $BRANCH2) || {
+           echo "There were conflicts..." 1>&2
+           exit 1
+       }
        NEWCOMMIT=$(git commit-tree $NEWTREE -F $FILE_WITH_COMMIT_MESSAGE \
            -p $BRANCH1 -p $BRANCH2)
        git update-ref $BRANCH1 $NEWCOMMIT
-- 
2.46.1.641.g54e7913fcb6

