Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFB236082
	for <git@vger.kernel.org>; Fri,  5 Jan 2024 19:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="rrYT6WVG"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1704482074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yCbNbaaNXt/Xe2F9tx4Nh9kpBF3HXKONjSh3ukDwoZM=;
	b=rrYT6WVGUOkKQu7me/V1ifuymTfeCfQ4dyJa3XbunJ7C6DRGCQDHjCrEuuH13BqGWDp3HQ
	LiJjBd0hzFtFjsOJbVUiE/xpCxS6GtSyCdeBOz4e6keNBcmtR8IJsY6qKiNYMX5V8M6YFs
	1aW+V7lyhqnYqtcsI3fvu2jYuk1lZcNR0qYEMKHMrOX4wxFePM5WFax0mzifG/Ls/f6LP8
	XxqG4QwE0hKcoz9PmwyHtbUoRGcBVf6DWBjwgiygZXBCykNRKqE04mbxp7JCbAzkCRGkD4
	ro66PUCZeUUb//1GuO1ADqeqNuT+DKpJSXkSk/orCatV3dz4EnnT1iK1PzCbIA==
Date: Fri, 05 Jan 2024 20:14:34 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jacob Stopak <jacob@initialcommit.io>, Oswald Buddenhagen
 <oswald.buddenhagen@gmx.de>, git@vger.kernel.org
Subject: Re: [RFC PATCH 0/5] Introduce -t, --table for status/add commands
In-Reply-To: <8d45763bb4fa4c7d1e1f69dfaf93e647@manjaro.org>
References: <ZTS4jfsU6oS6LW0u.jacob@initialcommit.io>
 <5fac8607a3c270e06fd610551d7403c7@manjaro.org> <ZTT5uI5Hm1+n0Agx@ugly>
 <58a6a25a7b2eb82c21d9b87143033cef@manjaro.org> <ZTZQZhtTxvGT/s81@ugly>
 <bc55e29274da0d8059a8cd4383aa1b22@manjaro.org>
 <ZTatzlzCkPOW3Rn7.jacob@initialcommit.io> <ZTa4iqe0lqn/Yg5L@ugly>
 <ZTbJiIkIyXwWK8JP.jacob@initialcommit.io> <ZTbVY7Nf+DTYqHky@ugly>
 <ZTb/HeILRHnZjaz6.jacob@initialcommit.io>
 <62164acf4a787042dbb6e5abe212559b@manjaro.org> <xmqqil6w6al3.fsf@gitster.g>
 <8d45763bb4fa4c7d1e1f69dfaf93e647@manjaro.org>
Message-ID: <778c4540924ad076269ac72097cf3789@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2023-10-24 04:21, Dragan Simic wrote:
> On 2023-10-24 04:03, Junio C Hamano wrote:
>> I think the "use more verbose report format to help relatively
>> inexperienced folks, in exchange for spending more screen real
>> estate" is a good direction to think about this thing.
>> 
>> I am not personally interested in adding such support all that much
>> myself, but one piece of advice I can offer those who are interested
>> is not to be too deeply attached to the word "table".
>> 
>> ... snip ...
>> 
>> So be very careful when choosing what to call this new thing, and
>> avoid naming it after the implementation details (e.g., in what
>> particular shape the data gets presented) that may turn out not to
>> be the most important part of the concept.
> 
> Totally agreed, "table" simply sneaked in and remained here as the
> term.  Perhaps "<command>.verbose = extra" or something similar would
> be a good choice.

Just a brief update...  Some of the associated patches are already ready 
to go, and some more are still pending to be implemented.  It took me a 
while, which I apologize for, and now I've also unfortunately contracted 
some really bad flu.  I'll be back to the patches as soon as the flu 
decides to go away.

>> [Footnote]
>> 
>>  * FWIW, "git status -s" is a tabular presentation.  Maybe we can
>>    add a more verbose form of "-s" and be done with it for the
>>    command?
> 
> That's also an option.
