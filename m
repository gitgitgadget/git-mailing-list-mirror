Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BE13242B8
	for <git@vger.kernel.org>; Sun, 10 May 2026 22:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778452898; cv=none; b=C4ZruH1uX69ifKY/JCYTsLjVU+NtqzaP5qy1bVGReV6VmV6itAYz3sBfA8dIVtlaYPyjmho34BofrNarKaFj3QSF18nh/NY3N2cP5pzcG19K0eT6xITaN2A/wAsPeVxjfnd1zbzuFyVSX1Yq2RI1OQIsHVDDnH4JpQkIIhf0ew8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778452898; c=relaxed/simple;
	bh=N1ZEVubePYtfArLcSrG1IPuWzBjG2z1qAslNb4RNRuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eBy/PFJhtBXRdOJ9W5qBXzjVyOeSE3mk5XtnjxgaSiIKGzz8ffMRoOyE9wWgRhbrh8zaBU5xaxpMYTppUpt6xlw6DJvISubZrygzHjJHjZUt4KN14tvUgQqVba7zQLSWu3HGT+VqfSFmsq6WeiWkaMsoAvy26siBepJHZ02f4EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abhinavg.net; spf=pass smtp.mailfrom=abhinavg.net; dkim=pass (2048-bit key) header.d=abhinavg.net header.i=@abhinavg.net header.b=d8A+xlgu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XSFCmOph; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abhinavg.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=abhinavg.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=abhinavg.net header.i=@abhinavg.net header.b="d8A+xlgu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XSFCmOph"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 413D91400032;
	Sun, 10 May 2026 18:41:35 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Sun, 10 May 2026 18:41:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=abhinavg.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1778452895; x=
	1778539295; bh=fWc4wQEv1c4ODibi3v6d7hXiX3WoKMhvQ30HnKQZ950=; b=d
	8A+xlgu6eEM9Lfo0Ic9e2XgmOlGZwyo+k1z0twv8m6dWV/GRRTiqCR1f0AtMr13v
	iffiGNa5Jqv2KG3nP8VA1rNdsMmxc+3y4NxH7J+0wLohjb2ApsYujFdnphJSu/Sq
	iP0YPi33Fz3O1oJxcOJqSrnnkmnI9r4cGp7flKBL6eHOp18DJWh5x/UXCM5ffGU9
	w1tH0nKxIonpuWi5vmXp0Cv5xyvY3kPxr1/ZIMSL2ZJhr/DkC3fpbBnVDi9+q97k
	3ygypm+JSuBIsaRsqMx0+6GrPZOLEdV/9jkOT9JjlGRM8pVlBUxDmu7EoNbvXu68
	6lgPV3Id22EaCJoQXmcPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1778452895; x=1778539295; bh=f
	Wc4wQEv1c4ODibi3v6d7hXiX3WoKMhvQ30HnKQZ950=; b=XSFCmOphC9Q/FWfLT
	0h4pRRZpYUDiFeKatDcMFtFLWy6OBeld0CHpcJLQMhUnePDY6N8WAZK10BFS9FG/
	3ikSciHSzZarNJi22bTDixPDKhz3S3iPDDXjv/5tHuPoBbAgpykJhnNo/gYPkXTg
	DJPSW896i71XRZBzQ/Se/45GKGjg3X74pv7Cq/MnN2ZfrE4BsakADdxwXiKQ9VJU
	anRcRfGZBIsLZoK7J9kCDipG8tv31zzsvxgSVchiz6KzeBR7yQqK358wWl6V5Pu4
	cAZgEY9YSg4CpgW5FMG5RfanECjjMFa/XSdSwNIR+CVfuEzgaZBUB4G/TulFoAZm
	PMIiQ==
X-ME-Sender: <xms:ngkBatN73Ewd1gr6b_owKRwHK_8qmp00npDE96dUEGC-SZ1PYUX3bQ>
    <xme:ngkBahd1RXcNXFEwlsHXPG9R9ZOy3ggBEwHwHhQbvqynpDAMTH1QlL_kqnzzpJwrs
    NW8R5i2LjIHaoMhzdhvybhLgwO6WEbcW2R0wUkp1hXV-VSLanq6Wk4>
X-ME-Received: <xmr:ngkBasVBD0gBh6OYlqwa1K3STUa9g8J5cqhjS5tpJE0FSAoeUnlfF5VlvXj6fekhAUO6ser73ckkpgccNDMO6yQeNUDSpfdfbSgv1tX3Oxv3YHp8-Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudejfeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmhgrihhlsegr
    sghhihhnrghvghdrnhgvthenucggtffrrghtthgvrhhnpeevgfdukeduhfeluefgvdegvd
    fgveevvdehfeeujeeutdevteeitdelueegffevieenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehmrghilhesrggshhhinhgrvhhgrdhnvghtpd
    hnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihooh
    guseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomhdprhgtphhtthhopehmrghilhesrggshhhinhgrvhhgrdhnvghtpdhrtghpth
    htohepshhtohhlvggvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:ngkBaphYLt8qRPyfr3IHQ6WigJiCvudCcVHK4Hezmx6_Tb0zW16Y9w>
    <xmx:ngkBar-QrXxfdHavyFD02ldI50dQ0jFXuTmsN5pJLEfKxUjIFRikKA>
    <xmx:ngkBarZ8dw85T4Rjuq-20GFipYDSiXHENBxIRmluDOaWduP8LPtmVg>
    <xmx:ngkBai34dgSBGrvuJ3wJj8JgSNanb4LpXcNDoxvRg68_O8IdOnDoHw>
    <xmx:nwkBajyprxFnnAhC6NPdkbMuKyHwo4XUYeNc9kzioFUeV6DZ9uELmOEK>
Feedback-ID: i43f949e9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 10 May 2026 18:41:34 -0400 (EDT)
From: mail@abhinavg.net
To: git@vger.kernel.org,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	gitster@pobox.com
Cc: Abhinav Gupta <mail@abhinavg.net>,
	Derrick Stolee <stolee@gmail.com>
Subject: [PATCH v3 0/1] rebase: ignore non-branch update-refs
Date: Sun, 10 May 2026 15:41:10 -0700
Message-ID: <20260510224111.64467-1-mail@abhinavg.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260508015817.86177-1-mail@abhinavg.net>
References: <20260508015817.86177-1-mail@abhinavg.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Abhinav Gupta <mail@abhinavg.net>

Updated per suggestion to merge the conditionals.

Phillip wrote:
> On 10/05/2026 02:11, Junio C Hamano wrote:
> > Your long topic branch may have local unannotated tags that point
> > into the middle of it, marking strategic points in the topic.
> >
> > With this change, the command no longer moves them when it rebases
> > the entire topic.  Isn't it a regression?
>
> sequencer.c:todo_list_add_update_ref_commands() calls
> load_branch_decorations() so it does not update tags and the patch is
> correct.

That's right, the documented contract is that only branches are updated.
Without '%d' triggering a load_ref_decorations,
load_branch_decorations would be called and only branch refs
would be added to the rebase todo list.

Phillip wrote:
> Looking at make_script_with_merges() it also calls
> load_branch_decorations() so we should probably add something like the
> diff below.

Thinking out loud:
Instead of caller-side filtering, another option might be
to replace load_branch_decorations with a branch-specialized iterator
that relies on load_ref_decorations and silently skips non-branch decorations.
That's a more invasive change, though.

Thanks!

Abhinav Gupta (1):
  rebase: ignore non-branch update-refs

 sequencer.c                   |  8 +++++++-
 t/t3404-rebase-interactive.sh | 18 ++++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)


base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
-- 
2.54.0

