Received: from gosford.compton.nu (gosford.compton.nu [217.169.17.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B67128383
	for <git@vger.kernel.org>; Fri, 24 May 2024 08:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.17.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716539509; cv=none; b=XbmBFwRYzKcy4slwDxvbkEdtcCEL2QoNqvwNRDrVYFpX7O7FjcpEPzuGB03V2sfxQxxg7wVjU73oV5e+T4cj/l9vL1vNUz1EMVF1hhyGsgxRMSdKIdC2ZOlBHlWV6qp5MyBajZ8FQ5B38oVsnTfnSMGIIhChmoBwQQ9DIKrB3PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716539509; c=relaxed/simple;
	bh=JeoBUizKT1j6bXhvaLH8/eT60Zt8K9zgZvyZAPqYeMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cwtkjxCMMPjkuKfxgQXgfDmZ43XSKunFhq+WYT2w62HxmYfRB1gyF2xJy5aznJtfFS2FnwO0dTdRDAg6hwqGheFtSP5ClsSUlEmxgglT5mHzAM9EQ/z9Uv5/rQd8dl4eeWWuffKC9+YRIQSw9caFTrw7qRCn5oGTJQeqZra5kh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=compton.nu; spf=pass smtp.mailfrom=compton.nu; dkim=pass (2048-bit key) header.d=compton.nu header.i=tom@compton.nu header.b=OmxOdEQW; arc=none smtp.client-ip=217.169.17.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=compton.nu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=compton.nu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=compton.nu header.i=tom@compton.nu header.b="OmxOdEQW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=compton.nu;
	s=20200130; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XGsOPqXAkHTupF9AwGHtUXJ9MvsL4u2gkkWi4XmNLFk=; i=tom@compton.nu;
	t=1716539505; x=1717749105; b=OmxOdEQWRoYCpIOu729OUhVMMxErNK6mcQMMIiuHnMB3yzz
	jryRURAi9f/AZs2wNNB7oMW9Gs8q8GVsiRp2MHT6IkKzQc+iCQfQVSBZMX/ElYRNtWsq9LzfDOgDM
	qpT/2IoKZBDCrMY3eY4UYFLj/Z0XFIQpzYR7kTvo5flPOS2BL3X9UmYGEKXbLXIShjxoLsQddgXHO
	81hPWC7sXbMLsLR3AcOYmqnlHo9fordXtugs6w/mrKipPN8x6k++ivY4xcEp15YK3c2e4ngOx5oe9
	NiyMANDmlN688tRPmMXkjegy2SntJjcZ5Y+K5s31xxbcPN76YUXyHFsssXJqL3MQ==;
Authentication-Results: gosford.compton.nu;
	iprev=pass (bericote.compton.nu) smtp.remote-ip=2001:8b0:bd:1:1881:14ff:fe46:3cc7
Received: from bericote.compton.nu ([2001:8b0:bd:1:1881:14ff:fe46:3cc7]:47138)
	by gosford.compton.nu with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <tom@compton.nu>)
	id 1sAQKo-000000094Ox-2GaL;
	Fri, 24 May 2024 09:31:34 +0100
Received: from bericote.compton.nu ([2001:8b0:bd:1:1881:14ff:fe46:3cc7]:47496)
	by bericote.compton.nu with esmtps  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.97.1)
	(envelope-from <tom@compton.nu>)
	id 1sAQKo-0000000A3pq-1kUo;
	Fri, 24 May 2024 09:31:30 +0100
Message-ID: <1d39d59e-0d8e-40a0-83d1-6ead6c428bec@compton.nu>
Date: Fri, 24 May 2024 09:31:30 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] promisor-remote: add promisor.quiet configuration option
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, chriscool@tuxfamily.org, jonathantanmy@google.com
References: <20240523131926.1959245-1-tom@compton.nu>
 <xmqqsey8qia7.fsf@gitster.g>
Content-Language: en-GB
From: Tom Hughes <tom@compton.nu>
In-Reply-To: <xmqqsey8qia7.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/05/2024 23:23, Junio C Hamano wrote:

> It is an interesting observation.  I thought "git blame" was quite
> bad at streaming (i.e., until it learned the origin of each and
> every line, it never produced any output the user asked for), which
> actually would make it a non issue that the output the user wanted
> gets mixed with the progress messages and other garbage.  Unless the
> user understands that "git blame" is not spending time itself, but
> is waiting for necessary blobs to be fetched from the promisor, and
> is expected to wait unusally longer than the fully local case,
> having to stare at a blank/unchanging screen would make it uneasy
> for the end-user and that is why we have progress eye-candy.

Blame actually has it's own progress message that counts the
number of lines analysed which gets interrupted by the progress
messages from the promisor.

Something like "git log -S" behaves a bit differently - it doesn't
have progress and because it's using a pager by default that causes
the promisor progress to be suppressed because stderr is no longer
a terminal but you do still get lots of background gc notifications.

> I am OK for promisor.quiet being optional, but I am torn when I
> imagine what comes next.  On one hand, I myself probably would find
> it neat to make these lazy fetches happen completely silently as if
> nothing strange is happening from the point of view of end-users
> (except for some operations may be unusually slow compared to fully
> local repository).  On the other hand, I suspect people will be
> tempted to push it to be on by default at which time it may hurt
> unsuspecting (new) users who may have been helped by progress bars.

I do agree that it's hard to know what the right thing to do is here
or even to know the full scope of the effect.

I'll update the patch to address the specific review comments.

Tom

-- 
Tom Hughes (tom@compton.nu)
http://compton.nu/

