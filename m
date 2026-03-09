Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [185.244.194.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CE833F8BC
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 21:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.244.194.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773090524; cv=none; b=gUbOm5rAaNdn/GdZFz96bdwYfHaj7OaoKhF4uQc3yN3/gmhYiFtoQZnvgt8uZgjGfVyGK7Eja0vcTzIQknFj4aaiOHdlpI1CembGv/aFg90xYMe9N4rg3sf2GaFBtMqk7mpF/NApLJP9vqr2Rp+2OMC8fDYOObTY1Qd51lQPSqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773090524; c=relaxed/simple;
	bh=6beAHrkO22CBqbpuhQAUNHKiGLhXIFW19J2P1hGXq5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=ADY0vI70Owm1/kN2A+vrEXBOSNVnPfvUzP8luJoGmB01rg1TVoqxBzR/DdVT9LKe1+F5bRYVnJ6p6hm2HY3HN5eyCUdasOcxu3cFzWxg5/MmA6AD2uUC0NOGaAcsasCaUNMc7aLg+KVzefM2316OwkbDgqftcd3K8ElvzIDDNM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rd10.de; spf=pass smtp.mailfrom=rd10.de; dkim=pass (2048-bit key) header.d=rd10.de header.i=@rd10.de header.b=A8EKZ+uU; arc=none smtp.client-ip=185.244.194.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rd10.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rd10.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rd10.de header.i=@rd10.de header.b="A8EKZ+uU"
Received: from relay01-mors.netcup.net (localhost [127.0.0.1])
	by relay01-mors.netcup.net (Postfix) with ESMTPS id 4fV8kT0BhFz965y;
	Mon,  9 Mar 2026 22:08:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rd10.de; s=key2;
	t=1773090513; bh=6beAHrkO22CBqbpuhQAUNHKiGLhXIFW19J2P1hGXq5c=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To:From;
	b=A8EKZ+uUZiq+rAyYyvhqCCfIuF2/N/icZFos4q3d9nGF3Zh8TpZfD8AE5lzV4zPb6
	 ir97NT67I6hVfz0VF95UibHp9Uvphjau0xDZLor7g4CVsDMBs5QFAbLUAH4WdgqZH4
	 MfPOeqbbtwOE8c8y8nvERjtL9R1vt9rVO5pLnFA0BulsuMzSDN0W3I4YZwKwznOD4o
	 zUUO/dgNSMrW/YZd4uq1r+wa8oR1CWFG8ShAqMK8jvdULSp3Uq8vU532AsV4ULQLJu
	 +kICD55Efy/JpR6MiiB40B7Z5dVgM/dTXd406Jl5H7ArIroXkRT1XSqifZywXlUM+V
	 NVVNlqznWDNzg==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by relay01-mors.netcup.net (Postfix) with ESMTPS id 4fV8kS6cFNz7wmJ;
	Mon,  9 Mar 2026 22:08:32 +0100 (CET)
Received: from mx2eb1.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4fV8kS3zDhz8sZw;
	Mon,  9 Mar 2026 22:08:32 +0100 (CET)
Received: from [IPV6:2a02:3102:8e00:2a0:aca7:3084:e561:51e9] (dynamic-2a02-3102-8e00-02a0-aca7-3084-e561-51e9.310.pool.telefonica.de [IPv6:2a02:3102:8e00:2a0:aca7:3084:e561:51e9])
	by mx2eb1.netcup.net (Postfix) with ESMTPSA id E771B10020E;
	Mon,  9 Mar 2026 22:08:31 +0100 (CET)
Authentication-Results: mx2eb1;
        spf=pass (sender IP is 2a02:3102:8e00:2a0:aca7:3084:e561:51e9) smtp.mailfrom=rdiez-2006@rd10.de smtp.helo=[IPV6:2a02:3102:8e00:2a0:aca7:3084:e561:51e9]
Received-SPF: pass (mx2eb1: connection is authenticated)
Message-ID: <3ed2d803-5df9-44f4-9427-958d28aa1c46@rd10.de>
Date: Mon, 9 Mar 2026 22:08:31 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: git-fetch takes forever on a slow network link. Can parallel mode
 help?
To: "brian m. carlson" <sandals@crustytoothpaste.net>
References: <5c7c975e-2541-47e1-b789-fee1fdb77d2a@rd10.de>
 <aas--JZ-CCWN-o7O@fruit.crustytoothpaste.net>
 <1d6a8eec-20b3-4d6e-83f1-d18b7a3c0145@rd10.de>
 <aazUlMBj_IK41Ss2@fruit.crustytoothpaste.net>
 <0ebf757b-eab5-424a-a58b-e654b1a2942e@rd10.de>
 <aa39obsSbk9R1mqu@fruit.crustytoothpaste.net>
From: "R. Diez" <rdiez-2006@rd10.de>
Content-Language: en-GB
Cc: git@vger.kernel.org
In-Reply-To: <aa39obsSbk9R1mqu@fruit.crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <177309051213.2045051.9228806234835421797@mx2eb1.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: E771B10020E
X-NC-CID: J4uMBDgf91MHDepDc2g1A5K1C4GU38Gqlblga0G9


First of all, thanks for the information about upload-pack etc.

> [...]
> the fact is that the file system is much lower latency and much> faster than the network connection over which data is being sent, so
> that's the case that Git optimizes for.

I wouldn't say that reading sequentially is "optimising". It is just the limitation of a simple implementation. Like I said, with modern SSDs, issuing requests in parallel will be faster even on a local filesystem. That would be a real optimisation then.

Some elderly Unix tools like GNU Make realised long time ago that parallel operation is the way to go. Git itself has realised too, so that it can now work in parallel in certain cases (multiple remote repositories, multiple submodules). So old Unix tools don't count as an excuse!

I think we should clearly point out this deficiency. Git must not be perfect, but I would rather know the limitations upfront. At the very least, that would help me make decisions faster, like investing in some sort of a Git server instead of trying to optimise the SMB/CIFS mount.

And who knows, maybe someone will see this post in the future and decide to implement parallel file operations (async I/O) inside upload-pack and the like.


> rsync would also perform poorly in your case because it's again
> optimized for sending less data over the network than it receives from
> the file system.  Similarly with tar over a network pipe.

rsync would probably look at the file dates and sizes and not transfer everything. There are even some parallel rsync variants designed to overcome high network latencies.

But I don't think rsync is worth the effort for me. I'll just wait a while longer every now and then.


There is one more thing I am curious about. Git does not document how it uses SSH (or at least I couldn't find it in the standard end-user documentation). Git cannot launch a process on the target host over SSH, unless Git is already installed on the remote system. After all, the local system may have a different architecture (like AMD vs ARM), so you cannot copy a binary across. And I haven't seen the requirement that Git must be installed on the remote host when connecting over SSH. In that case, I would have probably seen somewhere a version compatibility table between client and server.

So Git must be accessing files over SSH using the standard SSH file transfer operations. I am guessing that the same latency problem will apply here too, because uploads and downloads over SSH will also be sequential. Is my reasoning correct?

Or does Git attempt to find out whether there is a Git on the other side? What happens if there isn't then?


> [...]
> A `git fetch origin` with that configuration will fetch every branch and
> every tag that points into one of those branches.

OK, thanks. It turns out my repository has no branches at all, so that wouldn't help me anyway.

Best regards,
   rdiez

