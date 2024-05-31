Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948186139
	for <git@vger.kernel.org>; Fri, 31 May 2024 00:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717116601; cv=none; b=aftKiGP81MMfSf/RcuEO4KWar0yxyXkZ134KkMjnw4JSvJib9wtvvAbZcrUSjuL42QUrhGxYOUMVP9NRgFgk6i5FANL+nykGVNGqVm6UjQqS9kTymSSqZ/GiX5rP/+nMset4/Wa6oNrL9G/TXk8aw7/W0J19CNdSBznAXvyeKw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717116601; c=relaxed/simple;
	bh=dPgNMKz7kd0qRxQNMNwtjQCMIQl/JJJB9tE3w6gtZy4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=CzsKCztv0lBW8tbbmeCPE9STQu0+MmOIlhSgNSD4uHb5F9K4gg7bTIU0+OBQS6J4hx1F0ygWq3U6plSOUSbDc0zssga4Craoly9nAyNJ+Gobajo/SWEACXdaaXe0hoCkq5t33KBgKvckb1evJXEmYHec4T1O5lVYlX3fnvS0zvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=Fm7TGRKD; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="Fm7TGRKD"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1717116596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KWRmloj2iNmtdOou5LPtIjwqsP/BO+ZVdG63q42kFvc=;
	b=Fm7TGRKDmjTQfLAa7VEoduOHSiSIojtZI5ta1itY3u9bKA4SO7ThvAvLJoMpvR5wHUj5dp
	f4+q4Cm+lZddVyxd3Hzobt6T2W5AByEUQ6kFJoKZZjZUhMIev8KIjmn5EOdjujx4pjt505
	b+BvxEsfHXu5GUPsUT9fu66ttelXr1WA4X5bAmkF6rUJMxZEUcxAz0Y1ACsQrkBZGiqx4N
	1kk+A4/eirVKYMW0CkIZ1np6396+/i++/SmgLwjWt3BeGJAGKOu3hb8LE1niZvY7xbdiNc
	RJES0mBuPu+b4jeU5kt09a6mRUnxaCUESpZSyUzrg2GrWpsTwp7Mt7B98sRINg==
Date: Fri, 31 May 2024 02:49:55 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, rjusto@gmail.com, sunshine@sunshineco.com
Subject: Re: [PATCH v2] doc: imply that interactive.singleKey is disabled by
 default
In-Reply-To: <673887a14c4f74deb4ef7771a331689b@manjaro.org>
References: <7da73f15a018d858519eefa373001ccb3eaf32e2.1716412958.git.dsimic@manjaro.org>
 <xmqqy1811qkx.fsf@gitster.g> <673887a14c4f74deb4ef7771a331689b@manjaro.org>
Message-ID: <35f5633ebf263ec743d673770eb86487@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-05-22 23:34, Dragan Simic wrote:
> On 2024-05-22 23:31, Junio C Hamano wrote:
>> Dragan Simic <dsimic@manjaro.org> writes:
>> 
>>> 1:  3141fe9f7328 ! 1:  7da73f15a018 doc: note that 
>>> interactive.singleKey is disabled by default
>>>     @@ Metadata
>>>      Author: Dragan Simic <dsimic@manjaro.org>
>>> 
>>>       ## Commit message ##
>>>     -    doc: note that interactive.singleKey is disabled by default
>>>     +    doc: imply that interactive.singleKey is disabled by default
>>> 
>>>          Make it clear that the interactive.singleKey configuration 
>>> option is disabled
>> 
>> Heh, "note that" would probably be better, as we are going to say
>> "Make it clear" anyway, no?  That is stronger than just to imply.
>> 
>> Keeping the original version of the log message probably was
>> sufficient.
> 
> Yeah, but I felt like it needed some adjustments, because the patch
> itself was actually changed.  I hope I won't have to send the v3
> because of that? :)
> 
>>> +	When set to true, allow the user to provide one-letter input
>>> +	with a single key (i.e., without hitting the Enter key) in
>>> +	interactive commands.  This is currently used by the `--patch`
>>> +	mode of linkgit:git-add[1], linkgit:git-checkout[1],
>>>  	linkgit:git-restore[1], linkgit:git-commit[1],
>>>  	linkgit:git-reset[1], and linkgit:git-stash[1].
>>> 
>> 
>> The resulting text reads well.
>> Nicely done.
> 
> Thanks.

Just checking, is there something left to be addressed for this patch,
before it can be considered to be pulled into the next branch?
