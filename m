Received: from silly.haxx.se (silly.haxx.se [159.253.31.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F25730FC22
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 16:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.253.31.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766076574; cv=none; b=FhvCc3yOHJs1WKatwA/dUcUCRkTLzvkzi5TPRieNos96qFbOcg1w2DV16Qtwj47QH8TzoiNe29nyFJASAwi+AwxSbVnn9DC4sh6YzWYurv+lbkimjrlgQjBLhyb1XDzRs794PB2cUMZpdQqGfjljpoNsfNr2gcP7HLc6WYQtRNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766076574; c=relaxed/simple;
	bh=P8FchSRQJaUXQhwLh9iM5iZkH+cpV8BTn4SmFPMmIvc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=bcZ9G8/l3VmfIfK5moK/XBRjTIZhA9KOfWcz6zsy+6NLwk7qzhED4XALWQGTIcYbYCny4Kj5OOpx3p8dTgF1gd3JdqwaWvrWRPfh45dE0QtSGG7rj2whaveXlw8epc1NG1t4I2yJOwJLlT0rYm0mtPzDpkIyy9HPWhWip4RAIEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haxx.se; spf=pass smtp.mailfrom=haxx.se; dkim=pass (2048-bit key) header.d=haxx.se header.i=@haxx.se header.b=tsnkWZYa; arc=none smtp.client-ip=159.253.31.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haxx.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=haxx.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=haxx.se header.i=@haxx.se header.b="tsnkWZYa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=haxx.se; s=silly;
	t=1766076567; bh=P8FchSRQJaUXQhwLh9iM5iZkH+cpV8BTn4SmFPMmIvc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=tsnkWZYauTATJ5trqkjAMqvOXQUwhEAkkgDpfgB5c933rU5L4MArRBgXESJ1z8asc
	 OiPu7C3Lt3bsFon+LGQK33fsWVvqsz6ejO9jt8cw/HFVEhWzBw5O7FnII70qqEwobf
	 8dpURiEinH/eCABoQofMzp2D+CG024qDQGOlCnCtxyvvMbd+tRu5bakyCMD4IuZbxV
	 m9xvqnfiRiVuCt7CLsXmXDUu3D/ZvPs3PHtINYvgECZbHigqo9kBXz6XQkJ1vqlZnh
	 NebZidDw5/N+S6tSk+JDNU54jpg89pbXsDFU7Z37cABvnItqClI5oQ2bgQoZv8oLfm
	 lpI5HeS9X/2/Q==
Received: by silly.haxx.se (Postfix, from userid 1001)
	id EA1E662B06; Thu, 18 Dec 2025 17:49:27 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by silly.haxx.se (Postfix) with ESMTP id E9366846D6;
	Thu, 18 Dec 2025 17:49:27 +0100 (CET)
Date: Thu, 18 Dec 2025 17:49:27 +0100 (CET)
From: Daniel Stenberg <daniel@haxx.se>
To: Jeff King <peff@peff.net>
cc: git@vger.kernel.org, Matthew John Cheetham <mjcheetham@outlook.com>
Subject: Re: [PATCH 0/3] test-suite fixes for upcoming curl 8.18.0
In-Reply-To: <613s97no-7021-pp15-79s4-302o39p7n5r8@unkk.fr>
Message-ID: <sn7p46s1-4o20-q05n-173r-s6716s8145q6@unkk.fr>
References: <20251218121120.GA3252258@coredump.intra.peff.net> <613s97no-7021-pp15-79s4-302o39p7n5r8@unkk.fr>
X-fromdanielhimself: yes
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 18 Dec 2025, Daniel Stenberg wrote:

>>  [3/3]: t5563: relax whitespace assumptions for unfolded headers

> I did not fully consider the impact this might have on users such as you. 
> Allow me to rework that a little bit further and get the former white-space 
> behavior back. Thanks!

I just merged a fix [1] into curl that should restore the unfolding behavior 
to match previous releases. It would be awesome if you could verify.

[1] = https://github.com/curl/curl/commit/9941e7c95bf26f00fd87888a

-- 

  / daniel.haxx.se
