Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6E7238D54
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 18:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773252759; cv=none; b=VX5llPA0PTcckcd1El8dXPAqYT5w9rXSKQcb+sqvcJxBdZYl1x32k9FDtvraY5dOfpmbdvYh3Tndu3PcB7INm+GVntB+eNxED3XG5mqs7FD3BKmr9tjboH2whzr4cpwjl6w7dAkqLs99m0OjtEgR2GsIa2Wt3oETnbRv6WoxhLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773252759; c=relaxed/simple;
	bh=bqsDA8YvRzu/dtqvSAcyS7mpuyNAFNAcowLjYLuhuFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=Qm+TryghxBV0QP9Q0DKllpmnSiTokSzcp/bIHH3Wka54xIuEJoYexDzeITYwJMndM9q53rCkZQIRx3/JgOc0kYgPucAWnqGhocp7uAh/HFmcthDfmJzBvNyqVBFzxZchLp9gIpnQN88kLkLnSrCxnBbQmwnDNstN+AV7f+KDFd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rd10.de; spf=pass smtp.mailfrom=rd10.de; dkim=pass (2048-bit key) header.d=rd10.de header.i=@rd10.de header.b=IahljIF5; arc=none smtp.client-ip=188.68.63.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rd10.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rd10.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rd10.de header.i=@rd10.de header.b="IahljIF5"
Received: from mors-relay-8202.netcup.net (localhost [127.0.0.1])
	by mors-relay-8202.netcup.net (Postfix) with ESMTPS id 4fWJZZ72QJz43NY;
	Wed, 11 Mar 2026 19:05:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rd10.de; s=key2;
	t=1773252343; bh=bqsDA8YvRzu/dtqvSAcyS7mpuyNAFNAcowLjYLuhuFQ=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To:From;
	b=IahljIF582++OhWExZknsp7rKk1xtOfgJ0JG38m2AUEdYHW2o9UPBc+xBi2smEYA2
	 Uz4pxNoAt1s8UNhAuhG0sM0MZAZ5QJl6j152J8hL+UPXqL4NGrDFRb12tms6GneUL5
	 CMSNFgjkNHWS3XZfkvKnB4WcrLUJoY8H06Mm/MggY6zg2vaRCmxLsAjb0UiQcA6Aod
	 CjJe7nZdiQPKBtmCBGDKCkcqzEMeKGVKEaQ9ZHpzXEV6RBk2ZoUTNu1Z2Z5bpvh1OC
	 G2BLCgwHeV11Y9OzsuJ3cVWDPUOAZJjjQ/0jIOamXr91cmP1/8oS8aukB3eP4NcCJy
	 jQK16E3J8j89Q==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8202.netcup.net (Postfix) with ESMTPS id 4fWJZZ6JyTz43Lm;
	Wed, 11 Mar 2026 19:05:42 +0100 (CET)
Received: from mx2eb1.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4fWJZZ2kYLz8sbs;
	Wed, 11 Mar 2026 19:05:42 +0100 (CET)
Received: from [IPV6:2a02:3102:8e00:2a0:4b8b:b7d5:c119:d73c] (dynamic-2a02-3102-8e00-02a0-4b8b-b7d5-c119-d73c.310.pool.telefonica.de [IPv6:2a02:3102:8e00:2a0:4b8b:b7d5:c119:d73c])
	by mx2eb1.netcup.net (Postfix) with ESMTPSA id D379B100322;
	Wed, 11 Mar 2026 19:05:41 +0100 (CET)
Authentication-Results: mx2eb1;
        spf=pass (sender IP is 2a02:3102:8e00:2a0:4b8b:b7d5:c119:d73c) smtp.mailfrom=rdiez-2006@rd10.de smtp.helo=[IPV6:2a02:3102:8e00:2a0:4b8b:b7d5:c119:d73c]
Received-SPF: pass (mx2eb1: connection is authenticated)
Message-ID: <d7b6defb-1614-40e6-b46b-a36d71388431@rd10.de>
Date: Wed, 11 Mar 2026 19:05:41 +0100
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
 <3ed2d803-5df9-44f4-9427-958d28aa1c46@rd10.de>
 <abCgUu3ZFSOIZwKu@fruit.crustytoothpaste.net>
From: "R. Diez" <rdiez-2006@rd10.de>
Content-Language: en-GB
Cc: git@vger.kernel.org
In-Reply-To: <abCgUu3ZFSOIZwKu@fruit.crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: 
 <177325234205.1827067.16992704739650233894@mx2eb1.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: D379B100322
X-NC-CID: pwSelp4aTFI0A5BPycIqvfiYIOfeaSyipXBHhtwK


> Git doesn't use standard SSH file transfer operations.
> [...]

OK, thanks for the information.

I have finally done a "git gc" on the server side, and now a "git pull" from the client with no new commits to download takes 4 seconds, a drastic reduction from the 25 seconds it took before.

I turns out I hadn't done a "git gc" on the server for over 2 years, so that many new references weren't packed.

Therefore, I think that having many small files to read versus one packed-refs file makes a huge difference if you have mounted a remote filesystem over a network with a relatively high latency.

My 1 Mbps connection does not actually have such a high latency (around 40 ms measured with ping), but latency seems to have a much greater impact than the low bandwidth, at least with a packed-refs file which only weighs 64 kB.

Best regards,
   rdiez
