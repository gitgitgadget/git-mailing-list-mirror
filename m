Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.18.0.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792607227;
	b=1tM2rn2IB3SjNEUW/P7yCOwXWl7kMRIWOs0nfeiPb2LnVAPQC6jVjRONCQ2HOSWGqerR
	 oSeri0fUrcZag9WDPQ1Dx8DWUL461dLqf7Xdxxk2wpu5GJpMMCMpGxYRDno07Ce/9kmFo
	 8ni+BEt8eOY6ZkUj0cwl02gASeJlhtKQXGhaeCMNOP3FHeeBReWpqFZHXrPZWeWp5RgLH
	 szXQ6dwFqfA+e9F9iibQ1CVxs9tVmqbrF2aWv1duBcCgshNPZtOyQDw9dU4lWQQGplynr
	 4+bf4D048u545zgeIIY9oJgUF0oV8+XYv3t+VPp4y786ylCD/pr9UFqhJh6Vlg7Ajhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792607227;
	h=DMARC-Filter:Received:Received:Received:X-Virus-Scanned:Received:
	 X-Auth-Info:Received:Received:From:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:User-Agent:MIME-Version:Content-Type;
	bh=+HkYr/cgGXGzoNmKf0DmzUuWRxgFqOgelkBzY5N7v0w=;
	b=fvwWh2r9DvUXWQuwc8kB1kwarGMb/E7IjYiwIX/7Z9Nnf1rH/MBMv9Z9JpDPzg9V3lLm
	 sN7YiLroK23H+ZAZ8eVYXx7zU1+V+EMn92ftMrHj5iIp7+TueAX169RHfQLlsR+TarVya
	 Q1RhCAnDM3cbKJv9TN2n8oGT5GWcWR9HgEStFwx5sObgl2UAMPug/aVGJZxdpH0/T9CPb
	 qmmnrzbqrvpXrWh2p3h9eK8XesHwhlFUYdjNrSzyULDo6be/K5flJMbnC5sPUUPuutOhU
	 kaSAUQpi7/I30ttQj/WNSwLhO8M6K2oS/n2Mzp1un4zFf5Baj+pk8TjSAmp9K9MNLsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=nefkom.net;
	arc=none smtp.remote-ip=212.18.0.10
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C057606A31E;
	Wed, 21 Oct 2026 18:27:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C057606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nefkom.net
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by mail-out.m-online.net (Postfix) with ESMTP id 4j8yRh5p3sz1sRLm;
	Wed, 21 Oct 2026 20:26:56 +0200 (CEST)
Received: from frontend03.mail.m-online.net (unknown [192.168.6.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4j8yRh1wJCz1sRLH;
	Wed, 21 Oct 2026 20:26:55 +0200 (CEST)
Received: from localhost (dynscan3.mnet-online.de [192.168.6.87])
	by mail.m-online.net (Postfix) with ESMTP id 4j8yRg3TwGz1qqlS;
	Wed, 21 Oct 2026 20:26:55 +0200 (CEST)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.6.182])
 by localhost (dynscan3.mail.m-online.net [192.168.6.87]) (amavis, port 10024)
 with ESMTP id xEmEUtMrz4yc; Wed, 21 Oct 2026 20:26:54 +0200 (CEST)
X-Auth-Info: LvKQvwmdtEqJPBXopcUO+1VfxBl6bDavIJBckhb/qRuFNevkKKJj8Zl4PatOrF10
Received: from igel.home (aftr-62-216-202-159.dynamic.mnet-online.de [62.216.202.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Wed, 21 Oct 2026 20:26:54 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 3204D2C0974; Wed, 21 Oct 2026 20:26:53 +0200 (CEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: "Theodore Tso" <tytso@mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,  Steven Rostedt
 <rostedt@goodmis.org>,  git@vger.kernel.org,  LKML
 <linux-kernel@vger.kernel.org>,  Jonas Rebmann <kernel@schlaraffenlan.de>,
  Ricardo =?utf-8?Q?B=2E_Marli=C3=A8re_=28SUSE=29?= <ricardo@marliere.net>
Subject: Re: FYI, git output messages are being used by other tooling
In-Reply-To: <ate61iEAj4HDIvzY@mit.edu>
References: <20261020141011.0015d172@gandalf.local.home>
	<xmqq8q3sw75e.fsf@gitster.g> <ate61iEAj4HDIvzY@mit.edu>
Date: Wed, 21 Oct 2026 20:26:53 +0200
Message-ID: <87a4o6yknm.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

On Okt 20 2026, Theodore Tso wrote:

> A structured output that contained the result of the "git bisect
> good|bad", and the first bad commit if it has been found, would be
> certainly be a more reliable way for automated git bisection harneses
> to rely upon.  It'd be great if that was something that was in git
> 3.0.

gut rev-parse --bisect shows the bad and the good revisions.

git rev-list $(git rev-parse --bisect) | wc -l gives the number of revs
left to bisect.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
