Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E90219F4
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 19:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="nLzYyoRY"
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8AE98
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 12:04:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1698087889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ohAiZ55h/hctLpsXda2UkmvqKjaQ0vhDvfnwWjQxjDY=;
	b=nLzYyoRY16eoWlSV2u+ggzZMAJvLhljn17PdLAncz0PUXS0XysEozXn8wftJwtY25PoHdq
	dlI3xtqf5cHdNetr+WFlRTOwLRfq+xjS6O9Jvru9/1olIF/4sscbHgtPzRic796kfAf1Ud
	5u/KbYhvme58ojp5C8SSVwa3f88srkKgsySEqdoPOImooS8j/Q5yYUVAGBd0syxYskFbB6
	wyiVAi8Q/7PoGE0/AZna0NYM5cP2XLZzYx+7NERGljNVyuZ0U5QmmlG3I9+1Bf4ckoVsla
	0u1p6EQsCh3qtm2ulXtDnXlVAr8Qy9d1QrBKJPHVIukjZgg/FbtifulHDr7Gew==
Date: Mon, 23 Oct 2023 21:04:49 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jacob Stopak <jacob@initialcommit.io>, Oswald Buddenhagen
 <oswald.buddenhagen@gmx.de>, git@vger.kernel.org
Subject: Re: [RFC PATCH 0/5] Introduce -t, --table for status/add commands
In-Reply-To: <xmqqfs21noxx.fsf@gitster.g>
References: <20231020183947.463882-1-jacob@initialcommit.io>
 <fd26df85661d554ced9d8e0445f75952@manjaro.org>
 <ZTL1wJIIK/5YWQK5.jacob@initialcommit.io>
 <d3bbe53c3b910f891c80465ea0c3f53f@manjaro.org>
 <ZTS4jfsU6oS6LW0u.jacob@initialcommit.io>
 <5fac8607a3c270e06fd610551d7403c7@manjaro.org> <ZTT5uI5Hm1+n0Agx@ugly>
 <58a6a25a7b2eb82c21d9b87143033cef@manjaro.org> <ZTZQZhtTxvGT/s81@ugly>
 <bc55e29274da0d8059a8cd4383aa1b22@manjaro.org>
 <ZTatzlzCkPOW3Rn7.jacob@initialcommit.io> <xmqqfs21noxx.fsf@gitster.g>
Message-ID: <18c7b1bea07d5f3878f4466b8e133da1@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2023-10-23 21:01, Junio C Hamano wrote:
> Jacob Stopak <jacob@initialcommit.io> writes:
> 
>> Git-Sim is a visual dry-run tool for Git that creates images 
>> simulating
>> what the corresponding Git command will do, without actually making 
>> any
>> change to the underlying repo state. Another important aspect is that
>> command syntax mimics Git's exactly - so to simulate any Git command, 
>> like:
> 
> Ah, OK, now I see where your "--table" is coming from ;-).
> "git-sim" was exactly what I thought about when I saw it, and I did
> not know that "--table" came from the same set of brain cells.
> 
> One thing that nobody seems to have raised that disturbs me is that
> even though there may be educational value in having such a
> "feature", having to carry the extra code to implement in Git incurs
> extra cost.  I was reasonably happy when I saw that "git-sim" was
> done as a totally separate entity exactly for this reason.

That's exactly why I already wrote that the original author of the table 
patches, if those would become accepted, should commit in advance to 
maintaining that as the new git feature.
