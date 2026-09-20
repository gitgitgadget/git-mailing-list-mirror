Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E7C38B7DC
	for <git@vger.kernel.org>; Sun, 20 Sep 2026 18:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789928773; cv=none; b=Jph2/6Xf4I8MfIy+s5YdwOdZw9T6U/BvsQa4KXA8L/DkbQVU7G9dFA12KyqWtaQ7CSi6AiwDr80bbQg2Iinz+wIqdpRtftsYPtuc52Jgp/U6S/lw8OcdaopUS4GPDBgzI1SUst+AZN+Z29ZRItOaXx0gxpXe0u0mgAT8P4oQK9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789928773; c=relaxed/simple;
	bh=jmbHR4KFGohnV3I9i2kT6sXltWVuBSWxuZL8E14xmD4=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=NOG/T1+dJZhNafISTXIlQg2xMvLMVXcU9FAzIaOllVlbYhZyrsJAy4YOuE/nyrRYRih1PFyFttzK3BOrWOpEXEm6KmGkfWeWZ8Z7itGK8w5UZz7qlrqno9R9yf5GyE+B6/ZxpkBNotlDS+6B7IdEKsI62UzQaNxTn9Qk/0zxqaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=XwepAaVI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iOVtIKSt; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="XwepAaVI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iOVtIKSt"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 280107A0075;
	Sun, 20 Sep 2026 14:26:08 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Sun, 20 Sep 2026 14:26:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1789928767;
	 x=1790015167; bh=lUDNARJdCZ9wc7mM78Xq9UZTsKL+IkErtwud/JxXVkM=; b=
	XwepAaVID20C5ZeB7p9jfrU1PSr2zb+dhG5sSkS4HnflI9H0l9eopwbin6bvM+OE
	yK87UvjAwecimlI2Y9AwYrYX7bJiKudbU/NLBUQ6HyWs0L/ppx8bOh9hMhYQBRmV
	5RIGEXnDXTOuwgYZMOnGSg9EuhXCYK3lL7YrBt+h/SjrvK1Y7UMCPjkBvYl1346w
	df3+e/rGwrr8Zky/W0pfvshlhUzciCmCtZfUVySIIlsFNGqVOTJS7+U6hBEXfxF5
	56oA/Yn44anft0ES1vT/is/bDlxMSSF8AdcMBrPlFzjd+KOLUkVDdHvp2WMiYmRm
	xDIkxAT+oQWd9RkRjwQbEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1789928767; x=1790015167; bh=l
	UDNARJdCZ9wc7mM78Xq9UZTsKL+IkErtwud/JxXVkM=; b=iOVtIKStBaBhkXXDb
	n94/LFAgrS995KeMc5Q9/1pSdYGRIoshPjKFX8/4/4cDxu8dnhLVMnyh9UWBxt1b
	qE3VNFtABpS9tHgQHZAPt/la529S2TGY5093kMZNs7+iybV5b0X66pFWHnWfbvTM
	sJPdX9etlxGn6kgWVAy2g5X7CicMjuvZwpZI/FY35++bxVbkpE1aM8P3IsSSTI5T
	bW9gfb4LP65d09cHfvt5Yg4B9lJZjhBBbaJGgniEJE0VfCWOIl6jzpmaaPmCH3b/
	jO7UnhzM9UO5Z3+ptuK+xb+UguoE7jE9ZxSJwaPEcojzxyUIceIywVT8QFZszFc0
	koxKQ==
X-ME-Sender: <xms:PSWwamH8SU20UA9FzOBEkGRlEJ76d_T1ZluDqcbXqLCiwZuyK2QOVbg>
    <xme:PSWwaiJvOgT1qELbQqC6SJpxfPkI-T-BLPhyJeG26ibcY3HopJu0i5P0HuR5TASBZ
    g_TUyS046Fp35QnfxAuBnHIYRVxnubELA8GqhOVzHQqD7nXNUY_kbs>
X-ME-Proxy-Cause: dmFkZTGLuPCxFi2yKhD0Ygvix3VG7vhWXOkluDlOW/ZTjXuW7OfBPCPVhTHsIR6LGSYwLn
    RSXmYRCE7exOevGlfHLXTEKSlVhFz+t83MTpu/rgQx0nusgf/aWsb49JXoKcUf8dL2KMR3
    7rstnbrW9U+AkZN8cQJxzWAZj+ZVR2O/dM5hLJhwldrF+6AHNqmMqTGEHLp2Bh5pgXMDet
    rdZ0QfibB/YhZE6HRS652X9xgK7PTjyurRm+gl41HzlUADETI71ZYNg/0O0f+nRtZQSp5x
    2V3TVkFuSnI99JWQwJTS7K5VO251rnPWWZ7OfMt6+RGHZ29A4jpxELnQdT8JApo6JE/FKy
    Glc8ojvPLKU/0zYobafgLzIOEGS/SD+x1nwIAkXdpLSerRPCpf2WZQd4msRYLEGewlVujw
    tbgHGUWhLOhioXk5EkLbCuRARXQGjdlTzX9AlcyYLyzYlHMVbPEIMaTM9s1OPUU/9LZYzz
    Rf9YsdiX4yT61NqKo4Bn9E7wFfHrumXBueCfjHs4u0e5JBC4Kbd2bYGpi7KTAQoRFAF664
    yl0Rzfui274sICPZK9bxDAQqG4b33fiPSpzWAo6wnTLqAyqpWtBIT+7ZFZwYT9Hd9LCD2h
    5vov4LXCPVy6uhhEooEMNZQ1jcXAHXvKq3suMuvv1L0yewqkUjSZpm7m3gTw
X-ME-Proxy: <xmx:PiWwasw9AOtRyfgEXE1yg3Il58SQoa2EAY0PMVW3i5AZB3fIOKOpdg>
    <xmx:PiWwauPgiU5KWVhjWL66N3vFlHMgs4-IQax_cU3MJNjOyK_at881RQ>
    <xmx:PiWwal4wy2Vq6ZRlEvy4qBOApDKxcLxDfRDFjRU6tRvFrCG-CWtXnw>
    <xmx:PiWwanP3N50iD-5A33Vb1bLL2Sc0yU4MwjQQHhMQnFWIV2j0YlSfeA>
    <xmx:PyWwau6tY9JHWFnvEMdJbHMPulrOCytMuBnoFbve3hm6CWUIeuoTMV46>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 4D0FA22C007F; Sun, 20 Sep 2026 14:26:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 20 Sep 2026 20:25:45 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Maciej Ciemborowicz" <maciej.ciemborowicz@gmail.com>, git@vger.kernel.org
Message-Id: <dd6815f4-30ac-4cc6-882e-e8c4eb0936cf@app.fastmail.com>
In-Reply-To: <20260920173333.1606-1-maciej.ciemborowicz@gmail.com>
References: <20260920173333.1606-1-maciej.ciemborowicz@gmail.com>
Subject: Re: [RFC] worktree: add lifecycle hooks
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, Sep 20, 2026, at 19:33, Maciej Ciemborowicz wrote:
> Hello,
>
> I'd like to discuss adding native hooks for worktree lifecycle events.
>
> Git currently invokes `post-checkout` after `git worktree add` when a
> checkout is performed. This makes it possible to detect some worktree
> creation cases indirectly. There does not appear to be a native hook for
> other worktree lifecycle operations such as:
>
>     git worktree add
>     git worktree remove
>     git worktree move
>     git worktree lock
>     git worktree unlock
>     git worktree prune
>[snip]

See https://lore.kernel.org/git/7c8b4673-37ac-45fa-ad8c-a1dc09afe5fe@mtasv.net/
