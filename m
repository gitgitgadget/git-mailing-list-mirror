Received: from tiger.tulip.relay.mailchannels.net (tiger.tulip.relay.mailchannels.net [23.83.218.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A471B1B983F
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 05:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.248
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775538139; cv=pass; b=LA5rIt/EVUc6EHivSYnEj4Evyl6o/BOKFJBrHvE+pgJDvUR8poyccR8a3+Yw7axGwZ7u0eEr28GioFcMg3xEAdNdv7/0mlZHi6MC8qeln3CoeLECDrJu71T8/K6Fa1md2uGZzVXYQ0lFlxKn0YVULqLO07MPqB2or3yrpAGfTww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775538139; c=relaxed/simple;
	bh=1Ik0HafV2PTABcuzQTHtSwOPxhKlWenmquWfh1bETr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k5UyylfWZlyO2OUQUaliHRWEK/dfsqgw3PlHJpqFVxUNCsrPfuTuB2xyEDcQ+yMjog1ZWXxuvKJtBfIMnE6ljH/4dVNfSBxyw5RLXxtod9avUyGNfC6e9hrda5H/eNbdsWevoeG86MXXH143sgfs3u+bO9aXELko0sDi7kyCHBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com; spf=pass smtp.mailfrom=cryptonector.com; dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b=tNXfHDXX; arc=pass smtp.client-ip=23.83.218.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b="tNXfHDXX"
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 5F46E7E12A2;
	Tue, 07 Apr 2026 05:02:11 +0000 (UTC)
Received: from pdx1-sub0-mail-a220.dreamhost.com (100-96-100-42.trex-nlb.outbound.svc.cluster.local [100.96.100.42])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 733017E1973;
	Tue, 07 Apr 2026 05:02:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1775538130;
	b=fWcMR0Z041VzslwSf+APTtpqKbqu6p0YBeAaS5H8xIeKFeTQ1fNGjB3aUhrtiCMuAGESj8
	lYfqYC1duCe3wlW9qPEZ8RO6KOmtrZb2RMrwgfY0jWUQoLxAr8PKun2JxLMtPxy4Z/5evc
	dtgXVkO00lYXJrjZrC9GXFKAeNA/meFi9DNbk39xrZyqYSHWGSh1zkUatHBmVDMiL3ESdi
	HIM0x0A9C8ZpLATYgqtJ8DevOnVeXUgSPZy14hXXrNlwAhPZ5fcqaa+ZODiRNFC/xYrnLr
	T7YeUDItpE9uMCghv6wrikRupQlDMLDgugWH+hGD1i1ea6a+fJ3FkHifBHLurQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1775538130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=9GPGtUS99u11N5uGzU86C+pphB5u/wEZ2ON2dTij5cM=;
	b=W39zl9dANiIm/ZVF+xeebSLfzwgmngPFzosQ60MZrXSQSPqA2WJ12DLq0fEHP1ZCf2B6En
	deJdqZtp2FPYhkPmJzM2DMza1U2eljisc4mojD4UIWgtVRvceYa1tDshLT8nrK1bFB3JdT
	L4vOsmSANUUNrtTY6ngos8Vbr8SoBTspZ0ciCOC4W7iYaQj7F0XhYSRE4UDfPGmWqExlwD
	tKHmEi/DPP++Axh9a612TlrF7R4Gss7ggp65iZ/1oO1lv3emYLW9UZxN4UAV7T+ibjoK2E
	hRoz6tqIA/XvSFWbT3bNUh0ZAuEcxlFQryTqQf5Ah9qhNQPEzRtiJ5hd0ifKzQ==
ARC-Authentication-Results: i=1;
	rspamd-bd48b9d95-666pb;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=nico@cryptonector.com
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|nico@cryptonector.com
X-MailChannels-Auth-Id: dreamhost
X-Towering-Spot: 20a7a4585554c5ae_1775538130783_75348546
X-MC-Loop-Signature: 1775538130783:3458871282
X-MC-Ingress-Time: 1775538130783
Received: from pdx1-sub0-mail-a220.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.100.42 (trex/7.1.5);
	Tue, 07 Apr 2026 05:02:10 +0000
Received: from ubby (unknown [75.81.95.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nico@cryptonector.com)
	by pdx1-sub0-mail-a220.dreamhost.com (Postfix) with ESMTPSA id 4fqYw109Srz2K;
	Mon,  6 Apr 2026 22:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cryptonector.com;
	s=dreamhost; t=1775538130;
	bh=9GPGtUS99u11N5uGzU86C+pphB5u/wEZ2ON2dTij5cM=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=tNXfHDXX2bstysi3SyD+9hjJtZmV6oJLmzh44YfGzS1jijyBFXsF5KcuIr9e+t+1g
	 YTJ/aEKLEGEs+LaR6NX8Hc6MnT7HnhnQd1vFIi9/hWWvfJvMzDjSertgF7q89BgiZu
	 Ln+zVeU8SV0CR/Vu3CwMtRHIsG/4BiT3wskurGwcstgpI1yndslGp6Qc6/hVd/BFL/
	 aMkwJIzqVbYvyNGffWUTAzv1HK6Q1xGOfjAHvX0oOVt2LbS9UbzE52WyOkoYRrOkAf
	 tPe9Pwv4BBUvdXxelUM8cjf5oQo+2INiR3zhL7MVhPachKB3sA19NIKe/hOMkUv9DA
	 7vIMAGxmt9rjg==
Date: Tue, 7 Apr 2026 00:02:06 -0500
From: Nico Williams <nico@cryptonector.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Matt Stark <msta@google.com>, git@vger.kernel.org, ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Martin von Zweigbergk <martinvonz@google.com>, remo@buenzli.dev,
	Edwin Kempin <ekempin@google.com>, schacon@gmail.com,
	philipmetzger@bluewin.ch, konstantin@linuxfoundation.org,
	newren@gmail.com, tytso@mit.edu, rikingcoding@gmail.com
Subject: Re: [PATCH] headers: Preserve 'change-id' header in rebase /
 cherry-pick.
Message-ID: <adSPznztKWo63Tjr@ubby>
References: <CAH7WC73-4p0RrqKNSh2G-xfpfO7QHZiXHbU_UFRkM3Q=bMWTDw@mail.gmail.com>
 <xmqqqzor76nh.fsf@gitster.g>
 <adSO6zPwtFOWBcOw@ubby>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adSO6zPwtFOWBcOw@ubby>

On Mon, Apr 06, 2026 at 11:58:19PM -0500, Nico Williams wrote:
> Maybe that's the trick: local configuration for determining the
> copy-or-drop semantic for different operations, and maybe hooks for
> altering when copying.  [...]

I should add that I would want an original-change-id header that could
be used (again, optionally) to relate commits that get cherry-picked or
rebased but end up having different change-ids.
