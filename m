Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAB91DFE22
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 22:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753394622; cv=none; b=FdTRBAQFbc/+5qLNMUXnz+hXLu9NuBfEm5RccY3qpMIpBkwJe+UUrgwtunjpObV2ENlKMKDwSlyWJpUoGGlP6n7NaSW9AvXBYUD8DvvZu+JZ5XV4zxSm7wHEMaPMUkmSunT/oPUWBAgPs7sFfGN8oA0N+p9NyiDZhpQ5D0XQQJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753394622; c=relaxed/simple;
	bh=+U4N/IG6WJoD+Czz5hBPJV1iTXg5UjEilDY9vT+xLwY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uQ9N5FqKJKvGrts+fV0Z3kPWDO+f1QxibqZ3oiTzvanN6Tw2cZUQhK7EWYGV5VB+RcrszQi0YiBk8R8LNl+XWRg8Upu3Y6FXWWl3v1A6BWG4R/AIVHjt5oEjHsE2bzQEHkKOMogUeomcbpp4ocnZMaGeyjLmhxz2x3aeHOLIqZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EEvb7re1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YiYlkBZy; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EEvb7re1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YiYlkBZy"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id B9D14EC03EC;
	Thu, 24 Jul 2025 18:03:36 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Thu, 24 Jul 2025 18:03:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1753394616; x=1753481016; bh=3D9OeJaV8R
	6yJqi4lJXYyK7nwx3Cf6dyRkjIvwAjlpA=; b=EEvb7re1rmUkvCwal9BwMU1y5m
	9Xsws95iWNSf725H44Cn5+6kCaSpB4iydfLud8FJedV0rQiYjkyJH7PpAtJdwOeW
	nb1L1ScJCNvJ0zgnJPE5kwQTxBnNPBAA0/dbHfsfVH5lgm4vKW1xZOoqj6eQqLve
	SExpw8AwnclcWIi+VD+TydgB56+DNmlkm80iZwxTSJdFq6/rMvau1m+LJQ2/cxNe
	VQeH5t/QAi/mUt5dQtz/ioGrjMFwf1JJxn3u6TxIMvkhwuK51d3S2DK1WF6hPcPF
	0eugsEie612rc5WGyQN5GumCn3YDl0vrSVE5EGVmyMk33ovHw7uDQAnVw0Xw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753394616; x=1753481016; bh=3D9OeJaV8R6yJqi4lJXYyK7nwx3Cf6dyRkj
	IvwAjlpA=; b=YiYlkBZy1roKHuM5Om0hV3tAW4kG+T69U1r6jsEp+ZpzyiogpXx
	zOFAvEsOTnwXDyPAKK3L7hzzqkJi3eXivgXJ9Oal1cvYHdbd6AGHIZNZ2FyE0Rb/
	ANvaElA4g/BeXAsNU68BvTUsGbjUaAgJysq6MMesFrAHcEXKIv6BI16JCbc21Jx4
	+RVds7W0SKCWXQsDDFEWRvzQ4t7hvfwkaEtQC2JQ7mTGNbjveaJ6280XZhVkouJ0
	GWgpudGRNkHgx56mInfdg9Opbi7Is3VpiLxOR7agtykVmW5KZ+0PbvHP8RgtD9Kk
	h1BtI4jjggHBUccMv1M9abhobuC1m7MknHg==
X-ME-Sender: <xms:t62CaJmJ9soP3NEg3A_vHHaPtn_0BrLGPrLirOpvcgJ1wHqNIiyNPA>
    <xme:t62CaFnbGdgqFiwMvGQrx6J9YyEHfwKLr_YCoPSEQcs8ZI42gFoDuCs9-p5ifj2oJ
    FZWXNBYbBaU93g3xQ>
X-ME-Received: <xmr:t62CaLx5UDG2NVMyURKZsnZRbIXflCrU9ro9Nb6uKl_ZjcANijYiLSvsUezvalTG21_69BnVB1XIhHrzpeU2vFdlAMobJ8W3ywWp1BM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekudektdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeehhfekfeekieevleevkeevkeekleegvddvlefguefhhffggfeiffejvdeivdfg
    geenucffohhmrghinhepshgvqhhuvghntggvrhdrtgifnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtgho
    mhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptg
    grmhdrshhtvghffhgvnhelgeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguse
    guuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhn
    uggvlhhinhesghhmgidruggvpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkh
    drnhgrmhgvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:t62CaKoz-5t5UgDyovm-Lb_NuasQGLwlTLL8o3lxxMZkPUTcQzOYIw>
    <xmx:t62CaK6_5SXsobGClMkgbdF3Z8okUn_VmV6LUWJAqGM4fVjNle3OVw>
    <xmx:t62CaBfNtBAwWp_BbZSqDUgMYuYRwEC22lCkqE21CqGvo1B8PXfgCw>
    <xmx:t62CaP5qIR-1_XeYZRd_yXmh2SIkvh_7caHtj5tW_NbJcGXpwzP-dg>
    <xmx:uK2CaJyhbfDZNXnTW1e65uFZ-s8eaJc_fNfTOBLSV9FS2jkIYTawss9g>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Jul 2025 18:03:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Cameron Steffen <cam.steffen94@gmail.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: Show skipped commit message after rebase conflict?
In-Reply-To: <CAAVFnNkdgXuUk6ziu5FkB=sAHzEOyiynQpQJFox_p_ZL9VGRfg@mail.gmail.com>
	(Cameron Steffen's message of "Thu, 24 Jul 2025 09:43:20 -0500")
References: <CAAVFnNkdgXuUk6ziu5FkB=sAHzEOyiynQpQJFox_p_ZL9VGRfg@mail.gmail.com>
Date: Thu, 24 Jul 2025 15:03:33 -0700
Message-ID: <xmqqwm7xxn4a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Cameron Steffen <cam.steffen94@gmail.com> writes:

> Sometimes I run into a conflict in a rebase and I end up resolving the
> conflict by removing all the changes. Then when I run `git rebase
> --continue`, the current commit is skipped and the rebase continues
> normally. Would it be possible to emit a message showing that the
> commit was skipped in this case? It isn't very obvious to me in my
> workflow that that is what occurred.

I do not know what level of verbosity is needed to grab attention by
the end user, but something like this might be a good starting
point?

Totally untested, and there may be implications (like, control
passes this point in different situations where the messages is not
warranted).

I'll pick a few people from 

    git shortlog --since=2.years --no-merges sequencer.c

based on their contribution to the file (not counting the internal
implementation changes) and Cc them to see if they have ideas.

Thanks.

 sequencer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git c/sequencer.c w/sequencer.c
index 67e4310edc..677d6105dd 100644
--- c/sequencer.c
+++ w/sequencer.c
@@ -5369,6 +5369,8 @@ static int commit_staged_changes(struct repository *r,
 			goto out;
 		}
 
+		warning(_("omitting a step that has become empty"));
+
 		if (!final_fixup) {
 			ret = 0;
 			goto out;

