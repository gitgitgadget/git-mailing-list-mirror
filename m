Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DC1158D8F
	for <git@vger.kernel.org>; Tue, 17 Sep 2024 10:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726567672; cv=none; b=O+OnEpPjUnSyMgZrLKochx2W31zm02ffNyaCQOp5Jmw49WE6r3KeNq0iTcEOCJichvvC2E+hVd6og6m4pf4BPXgfn91iYmqu/pPMEDq8khgf/k5fqZtx/7iKSUcRyZqTuiFhA2decReQ/5ZjEnhCPXf6hNDLwrm9gydBYgDBw0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726567672; c=relaxed/simple;
	bh=5ltTVotXUQMpSOpq25yKdhPVahnKSGv5mA6eNWQTxdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NoEhNLeP9ni5lW8ggbO1U9NpfoKB/Ajd9BmD99Wqb2Kw1jF9X9Tm7kVl/8+3nlnuVaQTqezGaUEz9cfcj0h5DK5tI+UhJuZb6ALkO+cgxOUhLRseCFaplCZJBGwUGp8j67uonLJFV7DArAXoCDiYGSb9lIakgP2BSNtSrpxAXpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=V34aNyYW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WtNDiEOF; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="V34aNyYW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WtNDiEOF"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 2F552138024D;
	Tue, 17 Sep 2024 06:07:50 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 17 Sep 2024 06:07:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726567670; x=1726654070; bh=Ril0IS4QRW
	U15NKKwTggqp/VTykeNHJGv1XBIBo5Buc=; b=V34aNyYWc0CX6e+Kgxf2XUODQ6
	t8G0E8cJHfkik6QyKDhOOkR0NxRTcIBSCk+CpVJg01Y5Vo4IkcEpSgP93LapDfs4
	SI3FG3eyUDmlDaOAKuYzNeus4SGXt952WqdsYiToiUI5dv6Eu1isBnfaPdPurt02
	Lpd+KZf/xhWdA28G18ZpEB39TTcTaluyq/fRDa1+h5JrRUPzhUCt4X1sDQXeB4Ph
	w4+EaqORERqEIlkS5xexsIypYDj8rht5KqQvFqOloSHo8Xkt7rMIwrIy6zU5pUDl
	bFolqxGSqfgtVy4qcrZcsBZfHMcGQXBXLZxGJPl+9ZS7lVOLuOJeQ11xLgTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726567670; x=1726654070; bh=Ril0IS4QRWU15NKKwTggqp/VTyke
	NHJGv1XBIBo5Buc=; b=WtNDiEOFNoOAvIlwjKWr78CNyKK1Wc0JchwD/YojZDDu
	cpg+2fnmAkJKlcO0z/3kxFMnqi+ENHC8OiS6s6zQ6aH49uJmd28lUAWU8AE3VdpK
	on771C+tc/6SrqUfcUgCXVWBSC4TqNJusA6zUQSTlsf5UsoG4kiuxquyQa2AtExW
	MD7tryHigv7h9Qptno124io2iuNVXpbm0T2xLx8Lq34NPHeSS+inWnjzlEPWl6Tb
	mTXWlvjWPzWtjP23iyGhUjgjapep4rSmpYnFcLHzxR2mRVF6m8nCL4N471XLqxm2
	/yAGuXPs21+qvBex0BcafdnHPIqgugRdii9VsJeNsw==
X-ME-Sender: <xms:9VTpZj26E2Wlj_Spl2WscquL-XO6BHEhJHf_SbXqpS9FfD_gMZgyQw>
    <xme:9VTpZiE266DNW_ZQNt_EoyemxXVKIlCkgHo2dHKgOt75kPiO48xzo7SWKq-DlxP3A
    bK2mqhlaMoGBEBv4g>
X-ME-Received: <xmr:9VTpZj4KlFKKXOMHAKFzIELb71TiPcl0hhVzD2Loo8K3KeURlAV__532_sJj1EO-7pTMAPJjahohRAdHmhpe9dgTY-pQoLQXXIdT7vnoxpCD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekjedgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmvgesthht
    rgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:9lTpZo18R6QgRQzbQl_zq2iNixRV926zRwTvLXgceOIPu_aahIK_sQ>
    <xmx:9lTpZmF6loC-rAeX6MsodKfqqS7U1JA7JDiQrYnUNOBf8aR6X6k0Ig>
    <xmx:9lTpZp_dV2KXD_zf0TedeJ_2V7ausZYS7wjWdfYWAhCAX1aNZL99kg>
    <xmx:9lTpZjnIt3OVw65K1wDDDpSkskjIRUOSBx8vRZAmUUzhhgMzqiLB8w>
    <xmx:9lTpZrQSOLWq6sV3MH2MFDxnGokTqsZh_S4O2wBZYN_RJr4Cmi9wCYXG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Sep 2024 06:07:49 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 06577f2e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 17 Sep 2024 10:07:29 +0000 (UTC)
Date: Tue, 17 Sep 2024 12:07:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2 0/6] apply: fix leaking buffer of `struct image`
Message-ID: <cover.1726567217.git.ps@pks.im>
References: <cover.1726470385.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726470385.git.ps@pks.im>

Hi,

this is the second version of my patch series that refactors lifecycle
management of `struct image` in "apply.c" to plug a bunch of memory
leaks.

Changes compared to v1:
 
  - Fix two typos.

  - Correct the statement that we don't loop around
    `image_remove_first_line()`. No idea how I missed that loop.

  - Split up an overly complex line into multiple lines.

Thanks!

Patrick

Patrick Steinhardt (6):
  apply: reorder functions to move image-related things together
  apply: rename functions operating on `struct image`
  apply: introduce macro and function to init images
  apply: refactor code to drop `line_allocated`
  apply: rename members that track line count and allocation length
  apply: refactor `struct image` to use a `struct strbuf`

 apply.c                            | 449 +++++++++++++----------------
 t/t3436-rebase-more-options.sh     |   1 +
 t/t4107-apply-ignore-whitespace.sh |   4 +-
 t/t4124-apply-ws-rule.sh           |   1 +
 t/t4125-apply-ws-fuzz.sh           |   1 +
 t/t4138-apply-ws-expansion.sh      |   1 +
 6 files changed, 206 insertions(+), 251 deletions(-)

Range-diff against v1:
1:  7b6903ecdd = 1:  a713a7aef0 apply: reorder functions to move image-related things together
2:  3f188412f6 = 2:  be8f98881f apply: rename functions operating on `struct image`
3:  1b49e39bcd = 3:  506c787d68 apply: introduce macro and function to init images
4:  0427cb7250 ! 4:  6ac37186f2 apply: refactor code to drop `line_allocated`
    @@ Commit message
         apply: refactor code to drop `line_allocated`
     
         The `struct image` has two members `line` and `line_allocated`. The
    -    former member is the one that should be used throughougt the code,
    +    former member is the one that should be used throughout the code,
         whereas the latter one is used to track whether the lines have been
         allocated or not.
     
         In practice, the array of lines is always allocated. The reason why we
         have `line_allocated` is that `remove_first_line()` will advance the
    -    array pointer to drop the first entry, and thus it point into the array
    +    array pointer to drop the first entry, and thus it points into the array
         instead of to the array header.
     
         Refactor the function to use memmove(3P) instead, which allows us to get
    -    rid of this double bookkeeping. We call this function at most once per
    -    image anyway, so this shouldn't cause any performance regressions.
    +    rid of this double bookkeeping. This is less efficient, but I doubt that
    +    this matters much in practice. If this judgement call is found to be
    +    wrong at a later point in time we can likely refactor the surrounding
    +    loop such that we first calculate the number of leading context lines to
    +    remove and then remove them in a single call to memmove(3P).
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
5:  e35816ed56 = 5:  5497708428 apply: rename members that track line count and allocation length
6:  6cf45daf84 ! 6:  42880dcf04 apply: refactor `struct image` to use a `struct strbuf`
    @@ apply.c: static void image_remove_first_line(struct image *img)
      static void image_remove_last_line(struct image *img)
      {
     -	img->len -= img->line[--img->line_nr].len;
    -+	strbuf_setlen(&img->buf, img->buf.len - img->line[--img->line_nr].len);
    ++	size_t last_line_len = img->line[img->line_nr - 1].len;
    ++	strbuf_setlen(&img->buf, img->buf.len - last_line_len);
    ++	img->line_nr--;
      }
      
      /* fmt must contain _one_ %s and no other substitution */

base-commit: ed155187b429a2a6b6475efe1767053df37ccfe1
-- 
2.46.0.551.gc5ee8f2d1c.dirty

