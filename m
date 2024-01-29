Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E5076C62
	for <git@vger.kernel.org>; Mon, 29 Jan 2024 17:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706551123; cv=none; b=Qdiov0WJGkQ3HiQa9NzuhAVf6sdnNORZh/0/LPqmWc8BqZIOmheS6Spuw6KwTaOnsjxfk5NiQ9mBm827E6seZ+RWmQz6S8HGsIQrHEHg5LGrt0bwqqPkEcmJQ1Yj19TvB025oUh+oXaJ5x7sNwhsDltjlG/WooCI/PnSEuwWgxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706551123; c=relaxed/simple;
	bh=mkCS18Hr5hurTG8GQvIPULRfAfgOgu1RXDfNLqkRBiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nxHY/CgfQ2i0/JisxVBq8QxHMLncb8zwpdozlPw56+8rvvahviqbAiAXc1/ebI2EHN1Ltx3dJmdZqOmblLnNShbWXMH2Au6ws+RjaF4UJqip9f/m9tazkrdF4Ysbt9jJhqKk9HxNhKfcBAH+UZinw9/VlzGLA0L7gU7yAyLOffU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=dBIzqyqU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cKkyrCXg; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="dBIzqyqU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cKkyrCXg"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 3BD9213800A7;
	Mon, 29 Jan 2024 12:58:40 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 29 Jan 2024 12:58:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1706551120; x=1706637520; bh=MJWEO8Z/bSTaLIP0eacfG93EhJMd/gvL
	v/ttVanBXEc=; b=dBIzqyqU4EJsuBiGy7mLJLFEwgowox4jWLNXLKJ/IeDos/O4
	gGevHH6kdhMzEezRSfsHjZhE6ZJbVezwQlMceiCtsIGYQHCHQajCbXw929ThInAy
	ImOev/1GpoZLfvNPGUqlhUUmgBFka+wNagljx+m4VzT6T3nZRbOQPCKfvE4QzQip
	GPGv+CxeAxdR9FdjyiCMuqh0ZOwY20PihqSTQPRNpPJEZlvxt64tJyPhmzvBGsum
	Uz8glkVXNKDNtph/+Ux03xtyJwIOftQ+KQGnjlWFEZuE40Ak25hvCKGWI0gN78VV
	8CG0nNKwhADc0sM2aaLGvIdb6vT0B6nK79qhQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1706551120; x=
	1706637520; bh=MJWEO8Z/bSTaLIP0eacfG93EhJMd/gvLv/ttVanBXEc=; b=c
	KkyrCXgWX83eEuOtQU88ag/bm54aKZNWD3jd1YuKlmXrKrVOgIK3Sl1/IwCKKlEU
	mTC39PEuw4i2c403pXml8v8GPdh+XpkwKH1XJ1/PJTAKC658UKWGbN2ddyyE8uSQ
	dxcj31muiSANxIJAm6BuyDJA2+yA/l+kmGWQ1p/Q5K8Gn4ZPogrd8tSdKjDS6lhn
	wDpliGFlROXC+7XCVb0lBsGj4shYQmFidLRHGBc9U4Fe7Zn1vLmtz59QR7YxAOOK
	LX+FfuCYDVxfu5fvxmWf8kmtSewa9dDWicu3IF+ZcZFQi6YqpLpZxINgUK3pXQUV
	PR7T5jgs/QuwiluFpKgFw==
X-ME-Sender: <xms:UOe3ZYf_9EZIjLPLSmF1dAt1oRsL_94V6MLwreXIgAhnf7bmKJFbKBg>
    <xme:UOe3ZaMyTj7sHdaKl8E0B90MI3XPTLUS5WvfQxm8IHpIgtDPgeNMQLulcO6-yGmNb
    XvV7wm41vbc1-kV3g>
X-ME-Received: <xmr:UOe3ZZhZbshmX-V7C-KZaEKiWxG_AX3arP6VvHp09v6XnHSokgeHppFKQnhtd1c2DAtWH4Mk7y-PtlkGT1n3PfvVP6XVMjniei5unJ1EEymxvQi1V3RGO1ZQRw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtgedgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfgggtgfesth
    ekredtredtjeenucfhrhhomhepmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkuceo
    tghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeeuie
    euffeuffethffhfeellefhueehteettdehveegjeethefgveffuefggfelhfenucffohhm
    rghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:UOe3Zd8hfih_NN7Y7uNtPbq8PlVyFXe2Ee4bqPmEjiC3Um7zN_fyxw>
    <xmx:UOe3ZUuK-mc6E49VIS8iqgrQqbzyXqa7iiSo3xFLulTOPoF4NbdneA>
    <xmx:UOe3ZUHg9mV56bOonYBN1-sY1nOfSFN5zvxZ9JzOleb0J_WrEdznbA>
    <xmx:UOe3ZWIVLbc1DOF5FYaLZzBK_2mn-yX7k_iKVZU5SmaUnAmKbKyywQ>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jan 2024 12:58:38 -0500 (EST)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: gitster@pobox.com
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	git@vger.kernel.org,
	ps@pks.im
Subject: [PATCH v2 0/1] config: add back code comment
Date: Mon, 29 Jan 2024 18:57:50 +0100
Message-ID: <cover.1706550761.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <48d66e94ece3b763acbe933561d82157c02a5f58.1706466321.git.code@khaugsbakk.name>
References: <48d66e94ece3b763acbe933561d82157c02a5f58.1706466321.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is a follow-up to the kh/maintenance-use-xdg-when-it-should
[series] which was merged in 12ee4ed506 (Merge branch
'kh/maintenance-use-xdg-when-it-sho.., 2024-01-26).

I dropped a code comment while iterating on a refactor. It still makes
as much sense in this context as before the refactor (it’s a _refactor_
in the sense of “don’t change code behavior”).

The code comment was moved to `config.c` in patch v1 3/4.[1] But review
feedback said that this comment didn’t fit in this new place and that we
shouldn’t `die()` in `git_global_config`. So in v2 3/4[2] I removed the
comment in `git_global_config`. But I forgot to put the comment back to
its original place, where it still makes as much sense as before my
series.

See the cover letter on the first version for the diff when I squash
this patch into c15129b699 (config: factor out global config file
retrieval, 2024-01-18).

Sorry about the churn.

Cc: ps@pks.im

§ Changes in v2

Add an ack trailer.

This is the (tentative) final version. I read (interpreted)
`SubmittingPatches` as saying that the final version should be sent,
even though it’s just to add an additional trailer. I’m open for
feedback on the submission process of course.

I’ve added it after my signoff since it seems preferred to maintain the
chronology (although in this case either choice seems equally
clear). Also it seemed more common in the recent Git log.

🔗 series: https://lore.kernel.org/git/cover.1697660181.git.code@khaugsbakk.name/
🔗 1: https://lore.kernel.org/git/147c767443c35b3b4a5516bf40557f41bb201078.1697660181.git.code@khaugsbakk.name/
🔗 2: https://lore.kernel.org/git/32e5ec7d866ff8fd26554b325812c6e19cb65126.1705267839.git.code@khaugsbakk.name/

Kristoffer Haugsbakk (1):
  config: add back code comment

 builtin/config.c | 6 ++++++
 1 file changed, 6 insertions(+)

Range-diff against v1:
1:  48d66e94ec ! 1:  24f536d575 config: add back code comment
    @@ Commit message
         which explains `$HOME not set`.
     
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
    +    Acked-by: Patrick Steinhardt <ps@pks.im>
     
      ## builtin/config.c ##
     @@ builtin/config.c: int cmd_config(int argc, const char **argv, const char *prefix)
-- 
2.43.0

