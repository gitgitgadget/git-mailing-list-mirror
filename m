Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.61.206.94
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795385843;
	b=mieT/aoCP+Hga4AXELd5iEtNMrnFQ1jpo0pQ0sIzlCZprLscvajqJtDsEZal8AuRrH+m
	 ePbmDVBxRRW5vH4gHOWCl0u+a7yfIf6kxEIwj1K/N/8v7uLHYhfWmUZFx/TASN2NfYKmO
	 WRUT1XIIwUnsqWr6SDhpQLn7CruOi+sxKCYjFaqvdYXuHyTaeCHEq7pW+uKY8VXnJq2ON
	 I2SGshOJpUdVqk5PWjQwbJazTqGH4EAF9nhw+KJymsjAZckJPkW7Gzg0VPqrO+FCkJJJ7
	 nLABA9kzUm5X8qLdYyMgtydFqTeui7cQyOYYo0Jwa1FhvSxf8SSt2iXSxGIVZbAXwGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795385843;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:
	 References:User-Agent:Date:Message-ID:MIME-Version:Content-Type;
	bh=FgMN8iFHp/Llgzz4FyUlAF/40kPCsdASfgjJ9uf+VV0=;
	b=QuRnoOar1U17s4czHv7mVbOCMIRMt19umvvlz/RxmPvSkUy5hJjbrZEE3/0SREknY13s
	 Qek7zyQHbpvNDZ8+/p+rDM2TBbpvlpJQF0jUMgmojmq9YY3yAcnzgyYorcFzKiP9A6vaw
	 hZIEvcfMrli/2NOCxCxeUVwYmTwaZUYfvtCP2npPAfzPP/IbxkJEqSq13t3lBfstCPHxZ
	 OdkAJ31CkqqhtVE7Ksk0Cf3eX2VKbGrG5KXjEcxMr0u6JnnQ3BVi4wao5cCBwozhUv4qy
	 4FTjZxIaeI1AnJsWG0Ybly6EkX1aLVA+WLyLu2yAgSXVOPp4hnpMtT5bQ/TUv0VImrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gouders.net;
	spf=pass smtp.mailfrom=gouders.net;
	dkim=pass header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=pAfXYljK;
	arc=none smtp.remote-ip=202.61.206.94
Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989D0606A31A
	for <git@vger.kernel.org>; Sun, 22 Nov 2026 22:17:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 989D0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=pAfXYljK
Received: from localhost (ip-109-41-49-183.web.vodafone.de [109.41.49.183])
	(authenticated bits=0)
	by mx10.gouders.net (8.18.2/8.17.1.9) with ESMTPSA id 6AMMH4e12257134
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sun, 22 Nov 2026 23:17:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gouders.net; s=gnet;
	t=1795385827; bh=FgMN8iFHp/Llgzz4FyUlAF/40kPCsdASfgjJ9uf+VV0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=pAfXYljKl6FHi/8gR459Tdm1xrk/HW/CZs7EXUZehChbOWL4YlvRW0CFUXT40wRB7
	 CxmExT3ETil777M21N3vQda0kMg923ksVs9fCavjg98VU64zJVEiEIArkJTUdLTH6G
	 WB0xqG4ffOK/FzXfP1xFD8SvZ7fNS41Quf+iXlXU=
From: Dirk Gouders <dirk@gouders.net>
To: git@vger.kernel.org
Cc: Eric DeCosta <edecosta@mathworks.com>,
        Marziyeh Esipreh
 <marziyeh.esipreh@gmail.com>,
        Paul Tarjan <github@paulisageek.com>,
        Junio
 C Hamano <gitster@pobox.com>
Subject: Re: [BUG] T7527 fails with 2/70 tests
In-Reply-To: <ghwlq4lgth.fsf@gouders.net>
References: <gh1p8cmwxf.fsf@gouders.net> <ghwlq4lgth.fsf@gouders.net>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Sun, 22 Nov 2026 23:17:03 +0100
Message-ID: <ghse0sldeo.fsf@gouders.net>
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

On Sun, Nov 22 2026, Dirk Gouders wrote:

> On Sun, Nov 22 2026, Dirk Gouders wrote:
>
>> Hello,
>>
>> I noticed T7527 (on origin/master) is failing with 2 tests
>> and before I start digging I want to ask if this is a known problem.
>>
>> What I already saw is a core.* in a temp directory which (among others)
>> causes the test_cmp to fail...
>
> To be more specific: the core file says, "git fsmonitor--daemon run
> --detach -" is failing with "BUG("double remove of watch for '%s'",
> w->dir);" at
> compat/fsmonitor/fsm-listen-linux.c:144compat/fsmonitor/fsm-listen-linux.c:144

I started digging anyway: a bisect lead me to the first bad commit:

ce48de8b2c (fsmonitor: implement filesystem change listener for Linux, 2026-04-15)

Adding the involved persons to Cc.

Dirk
