Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD114A0A
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 16:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717433565; cv=none; b=h4jQLdYOxUWTXcneLmEiVLfblLjPFUNKKCceuS0pOQWZlTS5FxOjUePX/02/Hxh8VdHwF8WIgzMnx1fwaBhYHL+G+dB1HrNhkhd6YSeEdAfxa1+dMA92mGQ8zcin41sTWap53ckBukKOjsQ0V2yRXVCgqxu7TGQTO+56RlfmJtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717433565; c=relaxed/simple;
	bh=75oc59cogKhSVrE9ne1SnwVZvrI9gK28Bro+E08LJo4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g5K/JXuAAbCtKTH+bCtBpkGqJ6HKL+/DVCT+tl0bZksWGPoiZ/AvhvTEZosmnAtq25xfpzCq17sZ56Ym7xc3YSpCSDadO2T5imr8Q1JmG84zgkVH+5XmVbCuowD6kRGVT+DkrT+U2H4dP/lp1BNuknN8Tx1xcZ9u0er7ypRlCXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=W7VTylSl; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="W7VTylSl"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id B6119338B0;
	Mon,  3 Jun 2024 12:52:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=75oc59cogKhSVrE9ne1SnwVZvrI9gK28Bro+E0
	8LJo4=; b=W7VTylSlXEzC+AneXctB9JJcNg8eX7njMM4U+OsaM0L3tbpJIc03Tt
	id9NRY/LySLQC0xmsrcKPDw5pifDqV/sArb+NK4idGNHJypYkSe949CdMiL6trKd
	27Jxlou7dcerAYmNInNxVGSvkQLHD9/r6F/Vb9KV76wrhMhSneyl8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id AF545338AF;
	Mon,  3 Jun 2024 12:52:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CA574338AE;
	Mon,  3 Jun 2024 12:52:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Phillip Wood <phillip.wood123@gmail.com>,  Justin Tobler
 <jltobler@gmail.com>,  Dragan Simic <dsimic@manjaro.org>,  Karthik Nayak
 <karthik.188@gmail.com>,  Todd Zullinger <tmz@pobox.com>
Subject: Re: [PATCH v5 4/4] BreakingChanges: document that we do not plan to
 deprecate git-checkout
In-Reply-To: <9ff94b6f320d76e6b7c767e855038f33b69f4155.1717402497.git.ps@pks.im>
	(Patrick Steinhardt's message of "Mon, 3 Jun 2024 11:28:37 +0200")
References: <fc1a9fa03de7330f79dc56b0f2712834cb236b5a.1715070296.git.ps@pks.im>
	<cover.1717402497.git.ps@pks.im>
	<9ff94b6f320d76e6b7c767e855038f33b69f4155.1717402497.git.ps@pks.im>
Date: Mon, 03 Jun 2024 09:52:33 -0700
Message-ID: <xmqqo78i3r5a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 AD1F8270-21C9-11EF-92EC-8F8B087618E4-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> +
> +* git-restore(1) and git-switch(1) have been introduced as a replacement for
> +  git-checkout(1). As git-checkout(1) is quite established, and as the benefit
> +  of switching to git-restore(1) and git-switch(1) is contended, all three
> +  commands will stay.

"As a replacement" is probably a bit different from the truth [*],
but I suspect that the reason why they were introduced no longer has
much relevance.  How about

    The features git-checkout(1) offers are covered by the pair of
    commands git-restore(1) and git-switch(1).  Because the use of
    git-checkout(1) is still widespread, and it is not expected that
    this will change anytime soon.

or something (borrowing from your proposed log message)?

[Footnote]

 * If we were to mention the history behind the introduction, we'd
   end up saying: as an experiment, we introduced the pair of
   commands that do different half of the original command to see if
   they can replace the original.

   The decision to keep the original would lead to implication that
   this was a failed experiment, which makes people (unnecessarily)
   wonder if the failed experiment should be removed.  I am trying
   to avoid such unnecessary implication here.
