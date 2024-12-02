Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6CA4C85
	for <git@vger.kernel.org>; Mon,  2 Dec 2024 07:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733123240; cv=none; b=bKs0QXp9lbqarpvrGVzNMjMizsgRRxSvoSotfLxLq97/JxYOJ7aEVrNrz7msUi0CQBBZ1xPypU4y9XiJ83cu+roRY3nYnpe5LsvSL0FRt5vlJ2MDZz36rhu+1JgmOoj2aaUdLZDQQnrkMvz+yYVYM7YKHy65unx0MwlpNWaT1Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733123240; c=relaxed/simple;
	bh=MS8JrSci2CVcZcnV6vR1nyKE/46TNgEFvo/LAA+/LSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YfnJy6R5TYzJL7O09Om6hgNzgg44l0iO1TaePp1m7oV8CiJLtOSO4aan08CsDLROjMBYGaNHpvmO1ymhi92i+selE7CHO52hizF/gvuDprYrC20P9jtWF4IUzL3b3sywqUXddIBJ0GJMKF1WoYdYIs9mslKZO6LWAzuHrJedVIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=2avF/qwv; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2avF/qwv"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id C3B09114013F;
	Mon,  2 Dec 2024 02:07:16 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 02 Dec 2024 02:07:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733123236; x=1733209636; bh=hXfvcEUf2hJTmkAvd0wQv5Y3afX/yvX9tCQ
	Zd2E4vQo=; b=2avF/qwvrIpzEEV1HLnTvdi+Vr9Omb3AmXwxVsSL792nuvU7rp3
	+jI0Jdj/0td0YGTF/xW6/rUrOtoNhVFmEJNF1i3cYJbBVA17BGQwlgcUzEnWoCJF
	gg8zZhERZ+k4SVcSBkLllPcx9R/7SkckRwWiz9qKibADylwu/58YSUQ1R99YzdJr
	UR+ZWK9W61vIjz4bzBUIXrC2HKZe5SepgKV3wVs34soJEI/jQRE5wPFFzEcAhWYg
	Imakt8h/s7HZEMMREMNr7usB8982kWAsHxyKVbGIGbW8TdMeSlgmy70XerBzKgAK
	ZM4s6XMmSBxh6DXH2tCZCZCSLjWDMxPXYJQ==
X-ME-Sender: <xms:pFxNZ1MN8Q7ulX0FzuJKFlGJ4XwIwxK_2ihKiHyc8r25PCN99XptvQ>
    <xme:pFxNZ39aFXmi9Gzb76IuLam_xqiS52csEOB_hlnV8maFJltR0_2Z15GAn4j_H5rKz
    DlS7Gcf4Dz1iWYaKQ>
X-ME-Received: <xmr:pFxNZ0T62UNyPO0A9lBpHczJay9CosXKNkc30xeUVhhmnDND6YBOTIh6Fk-Wwaz8jOm8M6kKsUSpnXxicMPN4hj2Itp2qA0tp-GGRmk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrheekgddutddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    ffkffoggfgsedtkeertdertddtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcu
    oehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeeludduud
    ehjeeljeetffegheffteeuhfevhfduieetffejgeehudejkefhheekieenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpoh
    gsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhith
    esjhhofihilhdruggvpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:pFxNZxsTPK6g0lbF_zAwy7MlG_YLl_WaJTgx7K0owZrwBCmfgMGF_g>
    <xmx:pFxNZ9co5mu93yvjtIuJJpGK0u9YQEtDfPxOKnRrdpIQeWrQ83A5pw>
    <xmx:pFxNZ90py1KHvqWl3NZUH-r7geA9QhpIb7AakcCo5ZgJc2lVawnZsw>
    <xmx:pFxNZ5_ydnj5n8jwdsuetMjqlRaoozIdCy7Oml0rflPSRpwoYTkkKA>
    <xmx:pFxNZ06W8o7k0cL-FmFFAC34fVwPoG2OFCiePeuN_zfeFJN2iPBkpqmp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Dec 2024 02:07:16 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: git@jowil.de,
	Jeff King <peff@peff.net>
Subject: [PATCH 0/4] forbid HEAD as a tagname 
Date: Mon,  2 Dec 2024 16:07:10 +0900
Message-ID: <20241202070714.3028549-1-gitster@pobox.com>
X-Mailer: git-send-email 2.47.1-514-g9b43e7ecc4
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

So, here is a cleaned up version, which ended up to be a 4-patch
series.

 - The first two steps move code around to get rid of the "strbuf_"
   prefix from three misnamed helper functions that are more about
   refs than they are about string manipulation operations.  We now
   have:

   - copy_branchname() that copies a branchname while applying
     interpret_branch_name() like @{-1} for previous branch, @{u}
     for upstream, etc.

   - check_branch_ref() and check_tag_ref() that are allowed to be a
     bit stricter than check_refname_format(), e.g., to reject "HEAD"
     as the name of a branch or a tag.

 - The third step updates a test that assumes HEAD can be usable as
   the name of a tag, but the breakage the test tries to protect is
   not specific to any tagname.

 - The final step then forbids "git tag" from using "HEAD" as the
   name of a tag.

Junio C Hamano (4):
  refs: move ref name helpers around
  refs: drop strbuf_ prefix from helpers
  t5604: do not expect that HEAD is a valid tagname
  tag: "git tag" refuses to use HEAD as a tagname

 branch.c                   |  2 +-
 builtin/branch.c           | 10 ++++----
 builtin/check-ref-format.c |  2 +-
 builtin/checkout.c         |  2 +-
 builtin/merge.c            |  2 +-
 builtin/tag.c              | 13 +----------
 builtin/worktree.c         |  8 +++----
 gitweb/gitweb.perl         |  2 +-
 object-name.c              | 36 -----------------------------
 refs.c                     | 47 ++++++++++++++++++++++++++++++++++++++
 refs.h                     | 29 +++++++++++++++++++++++
 strbuf.h                   | 22 ------------------
 t/t5604-clone-reference.sh |  6 ++---
 t/t7004-tag.sh             |  6 +++++
 14 files changed, 100 insertions(+), 87 deletions(-)

-- 
2.47.1-514-g9b43e7ecc4

