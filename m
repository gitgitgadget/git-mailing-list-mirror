Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6773BE146
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 10:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773915336; cv=none; b=APM23VdoNxkl59w6ifeI3rH+yfQviI8EPNxYlwZbWWT6uxF7pA9Oa+dPcni5/BZE0FOURriC1w9yc6ytK0KIU4dZ7Pm4XqOXZISXWnVe1fcK8Gi4pRBw9geLCqyBgzrhlYSFABbmx2Jz8nOKwICrC3f8n9QSyISvqD4i7CNcUrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773915336; c=relaxed/simple;
	bh=ALdVFaxfMHXW6Q27AaocyH2iar1jKfFgI11QhFyhx4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IXvxn7zWjX8N9+IMdAqI6TWeJpWBJkj/6WZ4ndb2+mJBWWjjdfXQEIh8VcnjdDedyC2froXPXF0uorP7ccA3PFF7vGnjaPzDIXXGI38VuJomPej2zg9CQbWlgNURx+a7Ge9HSbOT2QYkFJdxtWiZYG7F5B6WoSzCJXuxI0qxXtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ikgK+DNE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yq14bl2M; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ikgK+DNE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yq14bl2M"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 43B40EC01E8;
	Thu, 19 Mar 2026 06:15:33 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 19 Mar 2026 06:15:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1773915333; x=1774001733; bh=7/ris6UciJ
	5cgnjT1stU12peNw2XqfQpnSkLORYsLQ0=; b=ikgK+DNE/QjtKYCJ9qhsrbYnwi
	+DOiXIZ9ooGywE5E8vJvuKw+R0fZ0iSL9d+2Orhldtn99BCqMEU2nflFPp+pKNtR
	pV3VHKyACKV2YM6+V2AxoQUbjBQL7BmbZmSMcydnDOd0bJr9V0mfcXQZNLgbsEW3
	yq5Koh80qvhrVxxsJNlj/pZIKL8fnEtUNIig7uag6vglyYAgyl2rzA2vxXSEsgm9
	g0SZp1mU22RsdICNvD0LK9C8hPtjRM0pH17HsFK3nsdzq90cAgIPS/5AFVSuGK8F
	TI4UvQE0gigcl13UF+Ack/x+gS4czTmZzioet9We3fTsyS+fgrNQnX/kH5dQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773915333; x=1774001733; bh=7/ris6UciJ5cgnjT1stU12peNw2XqfQpnSk
	LORYsLQ0=; b=yq14bl2MsWnh4bnQgK7dfEVsr7o9+SrIf/BTIaU4ID6EXL+I6DN
	QPQAHiaHE/HtgSyBImAffbM97K1dQUdmJWyX0pbxu2f0edZrRFdajNClJaa91LWr
	rj7tqasYrR6MEx6G3SvV0sGybnsAD4EVHbjiLEanMm7LDl8BUVwJ0tOKorOEDawf
	L7/ra1zHFv3rf8i+M6OoB8Ol4EhQZRU9STlXXMeqtesRbD3h8EXUNW2fEI/U/pvn
	Whh8TZAfr8EN5MVKw5+PWMFD0Mul9NQwOm60godGh5z0luBVwBJdOfy11p5fcLk9
	XQUPf/bgAxqa2ehd7HaJsdbZMNtoSSCPZCg==
X-ME-Sender: <xms:xcy7ac0awnyTmrOByYMi6Ko1b4ub1-SITVjDzDpRRxM2mpzX9ZvfKg>
    <xme:xcy7aeFX5GCE04d2SCaYGfMsgEDbcPYuYgST5vMlJtBuO6hLOAW1yW1MwQmpEKh8g
    Ar5x589jhM_UXbGU_MAP41pJOLsPr80LzBjsl1AyE3qk3PE4h9V>
X-ME-Received: <xmr:xcy7aZ6eg_f3oS-BXDjT9WQBYwtgApZqkUHh2GV_PnR5PfRK0cCcFtXhHMr7VjCz8qZhB-4ta0EE5uqMdSK2EFOww9JUhg2DLT6c4Z-8dWjx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdeijeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:xcy7aUuLVLoT1h54OGieom4hQXHNP8xNvy8DqDcE-HvbHGIltTnueQ>
    <xmx:xcy7aa7miWsbO--eZUI9flZwGejwNvAJZmFWAGDX5wuBayqj_dOElQ>
    <xmx:xcy7afXZ9YkRmsfPLVUMgb-WxhTYVnlbddFanLZ7fYHrbZKPI1slng>
    <xmx:xcy7ac_-RovcElUPA7_I44iLW9Lf2e8u9z1UyqUcphhPN1jjDdNLWA>
    <xmx:xcy7aVb2BUJv1lRNn-aLd1nCeZ38pKZim1JyRVP_miBGINtWnr1q0XiX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Mar 2026 06:15:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 34514d8e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 19 Mar 2026 10:15:30 +0000 (UTC)
Date: Thu, 19 Mar 2026 11:15:28 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 4/5] backfill: work with prefix pathspecs
Message-ID: <abvMwBr_03_Z0nMX@pks.im>
References: <pull.2070.git.1773707361.gitgitgadget@gmail.com>
 <977f62faa550ecc4ef7774b4ecf53a9a520fc62a.1773707361.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <977f62faa550ecc4ef7774b4ecf53a9a520fc62a.1773707361.git.gitgitgadget@gmail.com>

On Tue, Mar 17, 2026 at 12:29:20AM +0000, Derrick Stolee via GitGitGadget wrote:
> diff --git a/path-walk.c b/path-walk.c
> index 364e4cfa19..e1ad4b0208 100644
> --- a/path-walk.c
> +++ b/path-walk.c
> @@ -206,6 +206,49 @@ static int add_tree_entries(struct path_walk_context *ctx,
>  				 match != MATCHED)
>  				continue;
>  		}
> +		if (ctx->revs->prune_data.nr) {
> +			struct pathspec *pd = &ctx->revs->prune_data;
> +			bool found = false;
> +
> +			for (int i = 0; i < pd->nr; i++) {
> +				struct pathspec_item *item = &pd->items[i];
> +
> +				/*
> +				 * Is this path a parent directory of
> +				 * the pathspec item?
> +				 */
> +				if (path.len < (size_t)item->len &&
> +				    !strncmp(path.buf, item->match, path.len) &&
> +				    item->match[path.len - 1] == '/') {
> +					found = true;
> +					break;
> +				}
> +
> +				/*
> +				 * Or, is the pathspec an exact match?
> +				 */
> +				if (path.len == (size_t)item->len &&
> +				    !strcmp(path.buf, item->match)) {
> +					found = true;
> +					break;
> +				}
> +
> +				/*
> +				 * Or, is the pathspec a directory prefix
> +				 * match?
> +				 */
> +				if (path.len > (size_t)item->len &&
> +				    !strncmp(path.buf, item->match, item->len) &&
> +				    path.buf[item->len] == '/') {
> +					found = true;
> +					break;
> +				}

Ah, one more thing: we could expose `dir_prefix()` from "path.c" and
reuse it here.

Patrick
