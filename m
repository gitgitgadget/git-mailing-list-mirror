Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [46.38.247.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EA5423A68
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 20:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.38.247.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772828406; cv=none; b=Ort7afHJ5jftcbg1+xBsfq0FAagOmmThhUGuARJHRr0iPf7IsO2fHGzj9OXwNIoulrAW0ogdX/LvKc52DL9ZEIBLSSdsECwlPuWn6VTcOxoxGNhJmJBNaIGfsrqtJE1v2oNRKil4PY3WkgOxOYBta8QIHKAgJDPaVpvYZ4vQxCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772828406; c=relaxed/simple;
	bh=hQde50MpUIsGPP9yl+WhkpsgLTUTj5+rucwmFbd0EIg=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=PtmVWstLqHHFJThbnDi+InZT2xKLrMQSU6CRpRU9iiqg25eX8sHqaLad3D6hzAaXKrkwOTHQIV7f/uGR5MbyE8oU8cpcsVVf1Ob98DMql7C4nCKuDMxkqKwJ9WuxJNSCmu/ToiKQHzvknHnd5y3mRyznXmQnMedACDNuWIC2JCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rd10.de; spf=pass smtp.mailfrom=rd10.de; dkim=pass (2048-bit key) header.d=rd10.de header.i=@rd10.de header.b=HUvxxIa1; arc=none smtp.client-ip=46.38.247.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rd10.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rd10.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rd10.de header.i=@rd10.de header.b="HUvxxIa1"
Received: from mors-relay-8404.netcup.net (localhost [127.0.0.1])
	by mors-relay-8404.netcup.net (Postfix) with ESMTPS id 4fSHfw2GvVz87WW
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 21:14:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rd10.de; s=key2;
	t=1772828040; bh=hQde50MpUIsGPP9yl+WhkpsgLTUTj5+rucwmFbd0EIg=;
	h=Date:To:From:Subject:From;
	b=HUvxxIa1oXzICT3b7eYBb/R3qEoSWYtyZ8S/9Newhz6UIPIPwCslbRleNKUPw23lb
	 uZeSBGznBb3AK6oRcWWtNhcMCfWriyL1P36ydUSPQPuAH3HmXaaUkWyf4Y1n4fFrsC
	 YHnEtoZZ4X0SWmciH1JscYanOxFTyoMxPRrbWb0IyIh5hUvVMLqwjAlMdD4p14QPwP
	 w6Fb8lwUwTxyGYgaalSsxPDyrONgBDBO4W3souzwXruI2Cn8ZQibc8wobecfgqGt10
	 VAiImWot8r5iFk/ev6m0DTOyTyUToYdlA9k9mW+ravrn9IpHzyzeZHd3V/wxkdlimS
	 Vs7fvujKdfBrA==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8404.netcup.net (Postfix) with ESMTPS id 4fSHfw1bG7z4xJM
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 21:14:00 +0100 (CET)
Received: from mx2eb1.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4fSHfv6v5Qz8sbF
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 21:13:59 +0100 (CET)
Received: from [IPV6:2a02:3102:8e00:2a0:cfe0:41f5:8011:938c] (dynamic-2a02-3102-8e00-02a0-cfe0-41f5-8011-938c.310.pool.telefonica.de [IPv6:2a02:3102:8e00:2a0:cfe0:41f5:8011:938c])
	by mx2eb1.netcup.net (Postfix) with ESMTPSA id 4AB25100809
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 21:13:59 +0100 (CET)
Authentication-Results: mx2eb1;
        spf=pass (sender IP is 2a02:3102:8e00:2a0:cfe0:41f5:8011:938c) smtp.mailfrom=rdiez-2006@rd10.de smtp.helo=[IPV6:2a02:3102:8e00:2a0:cfe0:41f5:8011:938c]
Received-SPF: pass (mx2eb1: connection is authenticated)
Message-ID: <5c7c975e-2541-47e1-b789-fee1fdb77d2a@rd10.de>
Date: Fri, 6 Mar 2026 21:13:58 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: git@vger.kernel.org
From: "R. Diez" <rdiez-2006@rd10.de>
Content-Language: en-GB
Subject: git-fetch takes forever on a slow network link. Can parallel mode
 help?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <177282803948.1519843.7694705620482563965@mx2eb1.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: 4AB25100809
X-NC-CID: 3Lz5N2I5mdmjinvF+8Kg+aWPXwBhmRQw9Uf0hRUE

Hi all:

I have an SMB/CIFS connection to a file server over a slow link of about 1 Mbps download, and a faster upload of about 10 Mbps.

My smallish Git repository has its single origin on that file server. Unfortunately, I cannot set up any sort of Git server on the remote host.

git fetch takes a long time. If the repository is up to date, it takes about 25 seconds to realise that there is nothing to do.

If there are changes to download, it can take half an hour, even if the new commit history is rather small.

The network link is slow, but not that slow. I wonder what may be causing the long delays.

The first question is: how come it takes so long to determine that nothing has changed? Does git-fetch need to download a biggish file every time?

Perhaps latency is more of an issue than bandwidth. I saw that git-fetch can work in parallel with --jobs=n . Doing parallel requests may help against round trip latency.

However, the git-fetch documentation does not clearly state whether the parallel mode only helps if you have multiple remotes and/or multiple submodules. In my case, I just have a single repository with a single origin and no submodules.

Adding --jobs=10 does not help in the 25-second case with no new commits to download.

Does anybody have any ideas about how to improve performance in this scenario?

Thanks in advance,
   rdiez
