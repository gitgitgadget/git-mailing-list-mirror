Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73667481FAF
	for <git@vger.kernel.org>; Mon, 18 May 2026 15:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779119706; cv=none; b=E8oIp/D3lv/D0jgHGKbO40ieiuJDh2tHpq8CZIaYXH+nzpXNFNvycHbT/eg1fQc6chatkTVB/KMvlzGEOsSLTgY1A7GTBR9l124WmA2QY2IDkbXmKIT9DTUkL53C8OjrepWDypmDySkoJDYkdR8Lgio/AFT2Z8wZ8ymG/Dncq1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779119706; c=relaxed/simple;
	bh=7m8iqDlOwUHs2P6jciI4Vvex8ryYns5csHnfpeQVjMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j40i2tefwDEpmOfaXPRxxM/rbxIjoQ59r6/eMj6a+MoNdDWVqSZoNoQnmxCwITTPsxwdv1CA+VkVYtoafH0JiioYzzz+nYMAHPK0NMOusWXLGC/cyTSWlqoCzweY2zywFp6OnWh/0N66QvkdeZBR+DfgNsEZwhM1MjK2ftab2iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=CiuCcBq/; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="CiuCcBq/"
Date: Mon, 18 May 2026 17:54:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1779119686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=50OIvPrPTQSj5iqYJ8gp8Auq9oi2j0quYgCCPhRK8oU=;
	b=CiuCcBq/GcOAv1V0gNr2lfyzxm7O4tnrLTkXlJx62jY3frPW0noqNJ0xmRaWWi4U0SZRby
	Qp0JUHvCm1X/fkM/YKtq1c862rK00n2g9aFO1cZEm1YR742C1IdNXQ6r6Vw3yKb/BJApj5
	Wlka208FU94XjjOaKr1QALwJ0W4kbl+kSrN2Eq7is/9xqdWmxQehk7sl6YN52MM+EkxUFl
	amPiQ84dlhS0KZ7BKa+5NcuaUmWaeRUuWpaW9fLf1jVV299xQ/eSqpybv/+2OP+g2xEUpB
	fxqsKWlOp5cJ6ppZER2+OGaI+HOkvRTzVynV1w2Y+7ZvRsoxwnuJ/yt5ckPheQ==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Mirko Faina <mroik@delayed.space>
Subject: Re: What's cooking in git.git (May 2026, #04)
Message-ID: <ags1rtQnlO6KB1-Q@exploit>
References: <xmqqv7clbizy.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqv7clbizy.fsf@gitster.g>
X-Spamd-Bar: --

On Mon, May 18, 2026 at 10:32:01AM +0900, Junio C Hamano wrote:
> * mf/revision-max-count-oldest (2026-05-15) 1 commit
>  - revision.c: implement --max-count-oldest
> 
>  "git rev-list" (and "git log" family of commands) learned a new "--max-count-oldest"
>  that picks oldest N commits in the range instead of the usual newest.
> 
>  Will merge to 'next'?
>  source: <463cc8e2764edb7de3d379f615f5cfbd0919bfa3.1778887662.git.mroik@delayed.space>

Sorry, I realized it's still a bit buggy when coupled with --boundary.
There will be a v8.
