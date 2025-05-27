Received: from iguana.tulip.relay.mailchannels.net (iguana.tulip.relay.mailchannels.net [23.83.218.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8838027EC76
	for <git@vger.kernel.org>; Tue, 27 May 2025 16:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.253
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748363903; cv=pass; b=gRpyGzy2o99brjNPAZkrzBAGlNsPup5gnAy7mpci1IxIJyxEFGMWnsHRNz2h9Dt2jDKZf20yZP4orVdOQPOElfL8GAcj914X0fDv+2P/RF6KydafysI4rOBnW7v+2E8FcaBcyoMM89t+iw+6LdCeeaAr3zBrV+M4XuCIdMS3xUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748363903; c=relaxed/simple;
	bh=CXn2n3A7ABE0yluH3LpsJz2rKypCc8be9lrdViG3Y/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gBLJjKz4w1wWvK9MLNcexGF46WJRuZs+ddtZWMMNh9eyiugo/c1fJxxTDdzVpwoUwzuM9mIRY+GJq3LPMf6McvDLCcXCp1V74wwwM2R0BNK/IfVkbBRpKQi1cEgXG0Jjbh+PRTIWlnK4RwCTB8s45PCk4S2bPeDnDxnhw8kh2DA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com; spf=pass smtp.mailfrom=cryptonector.com; dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b=SBqE6nNX; arc=pass smtp.client-ip=23.83.218.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b="SBqE6nNX"
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 58AA28A3A1F;
	Tue, 27 May 2025 16:31:15 +0000 (UTC)
Received: from pdx1-sub0-mail-a280.dreamhost.com (trex-green-3.trex.outbound.svc.cluster.local [100.124.32.183])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id E4C148A3ECA;
	Tue, 27 May 2025 16:31:14 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1748363474; a=rsa-sha256;
	cv=none;
	b=RtAWNPn91SepDl9z8FFI554qPPai99IGlaPirTh02WK6igRflub9Pu8dgJmev/CLdRzpkr
	4CgHr8uyIKdhKTW8ipqMGq3zxJk4uA2ET+1Bs2d5vVsIqh+dRJH0w7x1khv+RRzjVpygqu
	pRwy1CBohDFFmWJOYZXfQQvs3aKiyiGi4c0H6omy3BVwys7OFQ1T00HLR21QeehTmdtisA
	U6KSDccfvcZj6UBSbgpqqWe7YnIKfy1tg+/RzDCKYjIJbDMApg6Xxz75muKL3ZY0M9uclz
	rTe28uvaiRkZM3hKD9Gn+BBs1dRS9q9G/YQ7u1VeTU8CbRid8v9efdniafsAiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1748363474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=HNTkVYdqMmzKRrKXMUMd6PErCi/LXWXPSIekrSKPyOk=;
	b=Nj4Fidm+VDJ9CrvnDtVVxeUhg2SOwax9ukdHjbczB9Hej2DA+kkm95AGxqTKYPt21udnWx
	hBfDST5zLTkw2nVcogzWKwYUXVIRs/EydgCdTOmlNQDvvZgzkh0V18lhZ1muxXTSyFyF3a
	0jh65zB8ebs7dNkTn9c3i/B+HgdvuVhWAQK9+Zsa3o/OO6tPHOKj9Mq2YmC5t9Nq1UK3u/
	9AXdJLtP/THojYricyt7p/1MqPuZh7IZTxKSnFNpIVffjYxf7lcX2uSnNFnIwJeH5v/7dk
	TyYp1Y4cVyh8ghlpeieEtmDAhWJGIOAjvYtTz2lvKSdhmKPb0QyH9tCpIp+muA==
ARC-Authentication-Results: i=1;
	rspamd-766f9cfddb-tm5c8;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=nico@cryptonector.com
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|nico@cryptonector.com
X-MailChannels-Auth-Id: dreamhost
X-Blushing-Print: 63dcffbe7d277800_1748363475181_2628421044
X-MC-Loop-Signature: 1748363475181:871439099
X-MC-Ingress-Time: 1748363475181
Received: from pdx1-sub0-mail-a280.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.124.32.183 (trex/7.0.3);
	Tue, 27 May 2025 16:31:15 +0000
Received: from ubby (syn-075-081-095-064.res.spectrum.com [75.81.95.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nico@cryptonector.com)
	by pdx1-sub0-mail-a280.dreamhost.com (Postfix) with ESMTPSA id 4b6J6V2d2fzJJ;
	Tue, 27 May 2025 09:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cryptonector.com;
	s=dreamhost; t=1748363474;
	bh=HNTkVYdqMmzKRrKXMUMd6PErCi/LXWXPSIekrSKPyOk=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=SBqE6nNXQ8DWiaPivhayOlUjBVDVbIWqjvq/ABSR77hYdM43c/vKAkEo/O6uDzv1F
	 /yDsjjot4bIWylHlV77crEa3nNBFKvg5CTzoOLKWgDDgPpuC7mZ85QEZpfgPp4NyA2
	 US7JkC2z+QhxdGFktunZxRrnpQbJKuVIDzo493Fq49Br0eJXNgfa4ud6NjNo4m0WSq
	 0HapcEcJvBVoGa5hwTgNmkteMqXhv4At9WIw5qTw3jUfnAMx3F7QL/e/eT9WwSavdQ
	 jG2Oi6UbL/H7hxczPCRisw/s5O+2p7ZJExwWSxIBtZyArCpgNhF7ul/3gKkhOro6+K
	 gfnWZ4x2ExXUw==
Date: Tue, 27 May 2025 11:31:12 -0500
From: Nico Williams <nico@cryptonector.com>
To: Jon Forrest <nobozo@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: "git commit -a" Doesn't Add New Files. Why?
Message-ID: <aDXo0Enj4cQzKQkK@ubby>
References: <1014npb$rbl$1@ciao.gmane.io>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1014npb$rbl$1@ciao.gmane.io>

On Tue, May 27, 2025 at 09:03:55AM -0700, Jon Forrest wrote:
> The documentation clearly says that running "git commit -a"
> doesn't add new files to the index. I wonder why that choice
> was made.

I use `git commit -a` all the time in workspaces that are dirty.  It
would be exceedingly annoying if `git commit -a` were to act like `git
add . && git commit`.

> Would the addition of "git commit -A" (note the capital letter)
> that works the same as "git commit -a", except that new files
> are also added be something you'd consider?

[Not being part of the team I can't answer this.  But as a user I
wouldn't mind, and I would almost never use it.]

Nico
-- 
