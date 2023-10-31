Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDBD360
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 06:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="QrWVdkgs"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344C3B3
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 23:38:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1698734302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BPx/3LewgQDzKnUWyPcsW/ysyhAPZ6winToxdrQDAfE=;
	b=QrWVdkgsrNbDge3X9cFCGqiGYi+iR6LENl+7VTQsneywkm+qlQgR5IQfMORMCw998HmntX
	7R1Gf8rJOOvJ2ha41px36ndIukzrwtdkTRIaBabsyGnZi+GWE4SFOOw9N33RLOIj+w+dzy
	v1CmKRt5nIUd3adVLRuvUMUKaFwKuKD0Np/eFufchMpQK/8khX3yIa6bZ/g/ZNwXYznLD2
	cFHqBaD8nWxfpbeaH35YkwFTRaidZ7SeiyaSC4qKCCdFG7+x+CZQCHlf6PTzsVGzT/GHev
	/vTqaMR4tI1kg2Sgw9KSLOTbGi0s4vrEGEQvja7AFFxlrLftCZqs3z8Fvl35bQ==
Date: Tue, 31 Oct 2023 07:38:21 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Hugo Sales <hugo@hsal.es>, git@vger.kernel.org, Derrick Stolee
 <derrickstolee@github.com>, Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: Re: [PATCH 0/3] Add `-p' option to `git-mv', inspired by `mkdir'
In-Reply-To: <xmqq5y2n49la.fsf@gitster.g>
References: <20231009233458.1371351-1-hugo@hsal.es>
 <xmqq1qe3wbt1.fsf@gitster.g>
 <1384513657.119681.1697027599941@office.mailbox.org>
 <xmqqlebj4dnt.fsf@gitster.g> <ffbb04b363938e4a487906134ce4f3c6@manjaro.org>
 <xmqq5y2n49la.fsf@gitster.g>
Message-ID: <245b1be0fcee3ade2d477fa1378647b8@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2023-10-31 06:58, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
> 
>> A quite similar ambiguity exists in cp(1) in mv(1), which is also
>> resolved by the use of the trailing slash character.  However, I've
>> encountered only one person aware of that disambiguation, and in cp(1)
>> only, but in the "I always include the trailing slash" way, without
>> actually understanding it fully.  Maybe I need to encounter more
>> people, I don't know.
> 
> If the majority of (perhaps new) users you already know find such
> disambiguation method unfamiliar, that already is a good anecdata
> without any need for you to meet more people to tell us that it is
> not a very easy-to-understand thing for them, no?

Quite frankly, I'm divided there.  On the one hand, you're right that 
this disambiguation method is a bit confusing and it's absolutely not 
very well known.  On the other hand, it's already out there in the wild, 
including git, and it's actually quite useful when used properly.

If I had to vote, I'd give my vote to embracing this disambiguation 
method, but only with good documentation and some kind of education 
through an article or two.  I believe that proper education simply isn't 
present, or at least not in a user-friendly manner, which should be 
corrected, regardless of the new "git mv -p" feature being accepted or 
not.
