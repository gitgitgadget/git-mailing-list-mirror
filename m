Received: from smtp-2.orcon.net.nz (smtp-2.orcon.net.nz [60.234.4.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8104B244687
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 07:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.234.4.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790321315; cv=none; b=EJN0nTDfJRhqIJVzSXRJFh+YBdV410Es9a3DHEk9vKYOO5b2KfzICYO1ZigC9GQCRWf7hsZaqtGNxXlO4/YYpCo879LwTEE+Yol021HjDBKeDE1Gq2oqDAFzl2FYDrlqqCCD45ZOQmg0/bLx1eYOuf66tw/67sfA0PAp9y1ciqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790321315; c=relaxed/simple;
	bh=a0jMUVInr540HYNnCAgKroYq+5Mp8bpujWuNGK7RKM0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=lWIr2h4zXqtKOh10htE9/J235mk2S5x1e+9RM3wIEZl+RVQ+5PdOs6Y8qsS/mf7tMRZkT2iDrNjZK1wOZ4QVRo+GO1R+BZiuyrNzjTNANQbLdjs5lRpH0t9Yh3C9Y5ydPY259fuURkPx/M7nxU6YGOpE+XHg536ugg1eM+OfWkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=orcon.net.nz; spf=pass smtp.mailfrom=orcon.net.nz; dkim=pass (2048-bit key) header.d=orcon.net.nz header.i=@orcon.net.nz header.b=IWxRToC2; arc=none smtp.client-ip=60.234.4.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=orcon.net.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orcon.net.nz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=orcon.net.nz header.i=@orcon.net.nz header.b="IWxRToC2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=orcon.net.nz; s=s1; h=Content-Transfer-Encoding:Content-Type:Message-ID:
	References:In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=15bziYqKE5eeMokxZ6CGgmUufUg7hkQUBPwAhJaxrKg=; b=IWxRToC2DlQ4EZY+SG4lG8UZSv
	8wwx1iJ7KMcNxOw55DO3w0fOapgZ2109IiE0k+8L10YrRsvrvN3WGNl7um3vos6OG0nRxBQbkiIl8
	aO8Dvoybp89ME4g9AQMSurUsr71TJlGh9JovywXrVxA7KnpHsihWIW3WRVOAT8qkYSzRXzAC0f4bR
	UnNx4sPt0kc/K9JOzu9JvRwPFrHe1OQTsQJq/YanlHTqUZHvi/xCgtIo6/N7IjMSh8pXQ1zL0NwNO
	OGKIkR/z3xhRYdElMG0+eAoL8rFc7VAg7cYwT4j604xBjg7CkAT5G/AsnhifPNnhkGEc/guSQmPHV
	frXH1AQA==;
Received: from [10.253.37.70] (port=33192 helo=webmail.orcon.net.nz)
	by smtp-2.orcon.net.nz with esmtpa (Exim 4.90_1)
	(envelope-from <psainty@orcon.net.nz>)
	id 1xA05r-0006Gl-Hw; Fri, 25 Sep 2026 19:11:39 +1200
Received: from wlgwil-nat-office.catalyst.net.nz ([202.78.240.7])
 via [10.253.37.253]
 by webmail.orcon.net.nz
 with HTTP (HTTP/1.1 POST); Fri, 25 Sep 2026 19:11:39 +1200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 25 Sep 2026 19:11:39 +1200
From: Phil Sainty <psainty@orcon.net.nz>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: GIT_WORK_TREE is not exported for post-checkout-hook
In-Reply-To: <xmqqqzisvpsq.fsf@gitster.g>
References: <17f331aef833b34fbddbefd66c330465@orcon.net.nz>
 <xmqqqzisvpsq.fsf@gitster.g>
User-Agent: Orcon Webmail
Message-ID: <a22c36b869d545cf3197f031a339c6b0@orcon.net.nz>
X-Sender: psainty@orcon.net.nz
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-GeoIP: --
X-Spam_score: -2.9
X-Spam_score_int: -28
X-Spam_bar: --

Hi Junio,

On 2026-09-17 09:39, Junio C Hamano wrote:
> The attached patch would export GIT_WORK_TREE when
> worktree exists and GIT_DIR would also be exported,

Thanks for looking at this.  I've just tested your patch
and it seems to me that discovery.worktree may not be
(or at least may not /always/ be) the right value.  With
the patch I see the following in my script's environment:

      GIT_DIR=/path/to/repo/.git/worktrees/name
      GIT_WORK_TREE='.'

Moreover, I see the '.' value regardless of which sub-
directory of the worktree I was in at the time.

"git rev-parse --show-toplevel" still returns the CWD
(which may now be because it's the path for the explicit
'.' value?)

I can see a few places in setup.c where that value is
being set:

     ./setup.c:510:		setenv(GIT_WORK_TREE_ENVIRONMENT, ".", 1);
     ./setup.c:1213:		repo_discovery_set_worktree(discovery, ".");
     ./setup.c:1269:	repo_discovery_set_worktree(discovery, ".");
