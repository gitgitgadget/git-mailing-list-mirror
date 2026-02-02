Received: from mxout1-he-de.apache.org (mxout1-he-de.apache.org [95.216.194.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1E9BA21
	for <git@vger.kernel.org>; Mon,  2 Feb 2026 03:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.216.194.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770003025; cv=none; b=X7sNetb1Kv/pkFJMfgb2jjk48oSWMuJJtapphfERpGVVabo4Dvh1hKbl3Y/Va961QQCVzSJJt0mgyq+Sb/rN/0VuAJ/dY/i6E2x2yP5IKrDwSra9vut9MdlLkSZbnyazak4jIZJQBW14zQsX/uFhti6ZF7h813GHg+ah3uQeyYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770003025; c=relaxed/simple;
	bh=W0HnzOmyksJS+DnqamYX4ONYu8RAGCy5VOOWvL+fTaU=;
	h=To:Cc:References:From:Subject:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=F5pI8WcsH0K7cGdYsEznAq7246Y1SJ+rCqZj9CWKgPVrHx/2aRqZHx/ybZkT+hdHOqVvD0NihpjIVLehPTw57aK6IG0A0gmUp59EvkyVUB0XLZ/z2HbdWCTEJOEAbRlmyiF/+mmCBexMyP52B0IHXK2876yxdLUPnnyWmy6nBeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=apache.org; spf=pass smtp.mailfrom=apache.org; dkim=pass (2048-bit key) header.d=apache.org header.i=@apache.org header.b=DU/HrvyI; arc=none smtp.client-ip=95.216.194.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=apache.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apache.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=apache.org header.i=@apache.org header.b="DU/HrvyI"
Received: from mail.apache.org (mailgw-he-de.apache.org [IPv6:2a01:4f8:c2c:d4aa::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mxout1-he-de.apache.org (ASF Mail Server at mxout1-he-de.apache.org) with ESMTPS id CF48660034
	for <git@vger.kernel.org>; Mon,  2 Feb 2026 03:23:04 +0000 (UTC)
Received: (qmail 129521 invoked by uid 116); 2 Feb 2026 03:23:04 -0000
Received: from mailrelay1-he-de.apache.org (HELO mailrelay1-he-de.apache.org) (116.203.21.61)
 by apache.org (qpsmtpd/0.94) with ESMTP; Mon, 02 Feb 2026 03:23:04 +0000
Authentication-Results: apache.org; auth=none
Received: from [IPv6:2001:569:bef2:d200:63e1:9891:d2d4:fc0] (unknown [IPv6:2001:569:bef2:d200:63e1:9891:d2d4:fc0])
	by mailrelay1-he-de.apache.org (ASF Mail Server at mailrelay1-he-de.apache.org) with ESMTPSA id 8A86741967;
	Mon,  2 Feb 2026 03:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apache.org; s=mail;
	t=1770002584; bh=jY872yQ1c7EkIJ0Zb96Pmu6B6YqT8wCueS8HZY3nhto=;
	h=To:Cc:References:From:Subject:Date:In-Reply-To:From;
	b=DU/HrvyIeasF3LN7QoVzNBOrpE/Di2vZTzDqd7l0OottYGnd/Lr3M5JYY7mDlzwBa
	 xpQCVQRJ3L/xJmiwqaa59wWC3Ug1lLTHz31Tn2meHCkFOsyTu0qzhaJfa1pBwykDOI
	 B1du/C35Z2wRWU/7XmtO0xDbnA8uO1UeiltsFIwg9y/wo/d5+8425pID8/4j92qg9v
	 zbM22y/YgFsq0pvmOYmvWnToVw5Wq5cUUsULb31UAjDENPyodsr6nRkyuZdmYg3+7m
	 oYv1+eHBdb4QkKGzD83pU6h6ucSHYfRw40lp65nZItU+VRAST0Jr3UYVlkveJWm4pO
	 xmzSXCyAj5ZQQ==
To: Adrian Ratiu <adrian.ratiu@collabora.com>, git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Emily Shaffer <emilyshaffer@google.com>,
 Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
 Josh Steadmon <steadmon@google.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20260128213927.3026875-1-adrian.ratiu@collabora.com>
 <20260128213927.3026875-7-adrian.ratiu@collabora.com>
From: Chris Darroch <chrisd@apache.org>
Openpgp: preference=signencrypt
Subject: Re: [PATCH v8 06/12] hook: allow separate std[out|err] streams
Message-ID: <9a4d95c1-61d9-5192-2a41-d8b953088452@apache.org>
Date: Sun, 1 Feb 2026 19:17:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 SeaMonkey/2.53.7.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260128213927.3026875-7-adrian.ratiu@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Adrian Ratiu wrote:

> The hook API assumes that all hooks merge stdout to stderr.
> 
> This assumption is proven wrong by pre-push: some of its users
> actually expect separate stdout and stderr streams and merging
> them will cause a regression.
> 
> Therefore this adds a mechanism to allow pre-push to separate
> the streams, which will be used in the next commit.
> 
> The mechanism is generic via struct run_hooks_opt just in case
> there are any more surprise exceptions like this.
> 
> Reported-by: Chris Darroch <chrisd@apache.org>
> Suggested-by: brian m. carlson <sandals@crustytoothpaste.net>
> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> ---
>  hook.c |  2 +-
>  hook.h | 10 ++++++++++
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/hook.c b/hook.c
> index 5ddd7678d1..fde1f88ce8 100644
> --- a/hook.c
> +++ b/hook.c
> @@ -81,7 +81,7 @@ static int pick_next_hook(struct child_process *cp,
>  		cp->in = -1;
>  	}
>  
> -	cp->stdout_to_stderr = 1;
> +	cp->stdout_to_stderr = hook_cb->options->stdout_to_stderr;
>  	cp->trace2_hook_name = hook_cb->hook_name;
>  	cp->dir = hook_cb->options->dir;
>  
> diff --git a/hook.h b/hook.h
> index 2169d4a6bd..2c8a23a569 100644
> --- a/hook.h
> +++ b/hook.h
> @@ -34,6 +34,15 @@ struct run_hooks_opt
>  	 */
>  	int *invoked_hook;
>  
> +	/**
> +	 * Send the hook's stdout to stderr.
> +	 *
> +	 * This is the default behavior for all hooks except pre-push,
> +	 * which has separate stdout and stderr streams for backwards
> +	 * compatibility reasons.
> +	 */
> +	unsigned int stdout_to_stderr:1;
> +
>  	/**
>  	 * Path to file which should be piped to stdin for each hook.
>  	 */
> @@ -80,6 +89,7 @@ struct run_hooks_opt
>  #define RUN_HOOKS_OPT_INIT { \
>  	.env = STRVEC_INIT, \
>  	.args = STRVEC_INIT, \
> +	.stdout_to_stderr = 1, \
>  }
>  
>  struct hook_cb_data {
> 

   Thank you for all your work on this series!  FWIW, I can confirm
that the Git LFS shell test suite continues to pass with your full v8
patch series applied.

Chris.

-- 
GPG Key ID: 088335A9
GPG Key Fingerprint: 86CD 3297 7493 75BC F820  6715 F54F E648 0883 35A9

