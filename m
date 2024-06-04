Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4A81E892
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 20:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717531895; cv=none; b=uXWK1X52qvH9IIRmFoVZRSzewr6jl9f/Z4YkR4BHWBG5HlvLGSGtgWMgmjnhYog5XIwy8ln+psP4rqJKxQRegZ3k3qQu+R6zRRg5ZZNFk2YkntJ6+daNZh0oS8Sawobuni02eJ2gh3JBpBxePI9wAEeV2NdNOI7XEoEJ7RlKIKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717531895; c=relaxed/simple;
	bh=8nziASe6NnJG+upLKxrUoDZRy1Djb3iw/M1hl24vWBQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=T5v7knT9vycpnl+nRIafUpxe0kU0/YQqI5dmywTm1VSs3U8qqh5C+P3sMoJgK0RCLqsQiZypyCHtYzNPL6rKDOjxvWrUw2BrQolJd87vkAt5Zx+M3zySLL0yxHbZBdydaNBjnu5+SwTAcOcr1ZqOCHQVNXr41+SMsNkglvJi+OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=fMi9vZKz; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="fMi9vZKz"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1717531890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JG1Uw7UQNHGc17gH5jttGIFhGocOK+lF3C/bYlL17zQ=;
	b=fMi9vZKzdFfIUbGReL9dTZgDRNNJCnvmAAb9ln1thXozID6ThDfCkhg3p4nBe4/ZxVf3/x
	8LJPrz513sjzeMOFhElUXYzC8Qyyjvh/nV5nVEJ72lSvAogOOiFHxFiVYl+inKInh6s8Uv
	HK9LWgqt+Z8qIm01NRp1OuZFIWqbUCRF0qUv+iVJX2z86cYr90cJ/8LIlE6nIT9gx3YWDY
	rU27nypQ7g0qfsn87MOGiauGs5YyMXLPCAEzsMGVSmoyQERasVL2iXMgmOn/DiTZYUpuHn
	8hNkqctmo6BhfjbZcQ1LllZYYhD2pyDVboKJA8OwzYNf4aDzlig8jDz34CxTHQ==
Date: Tue, 04 Jun 2024 22:11:30 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, rjusto@gmail.com, sunshine@sunshineco.com
Subject: Re: [PATCH v2] doc: imply that interactive.singleKey is disabled by
 default
In-Reply-To: <e5eb72eeb2f8e2de9400ed9373b72236@manjaro.org>
References: <7da73f15a018d858519eefa373001ccb3eaf32e2.1716412958.git.dsimic@manjaro.org>
 <xmqqy1811qkx.fsf@gitster.g> <673887a14c4f74deb4ef7771a331689b@manjaro.org>
 <35f5633ebf263ec743d673770eb86487@manjaro.org> <xmqq5xutgajw.fsf@gitster.g>
 <e5eb72eeb2f8e2de9400ed9373b72236@manjaro.org>
Message-ID: <61f46d925e89b6a574d84970089f3c50@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-06-01 00:21, Dragan Simic wrote:
> On 2024-05-31 19:23, Junio C Hamano wrote:
>> Dragan Simic <dsimic@manjaro.org> writes:
>>> Just checking, is there something left to be addressed for this 
>>> patch,
>>> before it can be considered to be pulled into the next branch?
>> 
>> Thanks for pinging, as these small things were on the back burner
>> while preparing for updates to maintenance tracks.
>> 
>> Apparently v2 cannot be pulled into the next branch, and I forgot if
>> I saw v3 already.  In general, unless I explicitly say there is no
>> need to resend (sometimes with conditions), I'd expect an updated
>> iteration sent to the list.
> 
> I see, but I'm not really sure is there need for the v3?  Maybe the
> patch description could be tweaked a bit further, but I wasn't under
> impression that you asked for that to be done?  Am I wrong there?

Any chances, please, to have a look at this?
