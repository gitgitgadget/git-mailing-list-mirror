Received: from hu-is-mx-01.gaijin.team (hu-is-mx-01.gaijin.team [213.163.39.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017CD1898E5
	for <git@vger.kernel.org>; Fri, 30 Aug 2024 12:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.163.39.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725021669; cv=none; b=SBqUHbZ1TCYMqmxokz8NLNgX0TqcmX4uJliLM5WekCdLQ2KKzJe1tOKhFnrLfVsUqZL4QxTV5jwli0+cj5tXP+F303tAQ+JvH6c09tWuLduymQKOiS7FL/vulRqANebDLzpienJcWSpK9xLdME2QinRnG8rm/DE3QfmLahnuHxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725021669; c=relaxed/simple;
	bh=EBqdjpsHtdr+zNWIm8Btq97epdoBYBoJ8wAqqrW5o2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nQSe4IG2Bn2voLu4a7fzRqicoGb2z7PfBauiqImOUBiI69PttbwTvd/8WM3PDlEp+IF6SOQTmYWhBR1ukYzYRkX7uvrZ2hbVTgFvfUrePnR/5bz2S/V+yH7qhFF7SYO8EAQet9UWteG4hpPv096w0Cp0f9JEufTU5mfCmL8jBe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaijin.team; spf=pass smtp.mailfrom=gaijin.team; dkim=pass (1024-bit key) header.d=gaijin.team header.i=@gaijin.team header.b=Foej2JSL; arc=none smtp.client-ip=213.163.39.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaijin.team
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaijin.team
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaijin.team header.i=@gaijin.team header.b="Foej2JSL"
Message-ID: <ffad4f8d-1fd9-4f2b-97c1-937576271a04@gaijin.team>
DKIM-Filter: OpenDKIM Filter v2.11.0 hu-is-mx-01.gaijin.team DC17E41F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaijin.team; s=mail;
	t=1725021666; bh=yphxtRbSt2Dp8qeYmhXoCahgwt5+6yfbu2xrr/aPp4k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Foej2JSLlMpy1w2tLh3ir6zGmjkFM+q6Wxyqfb/88cxEZNg8eMwn8lLI5m7nqdqR8
	 7dGs7Sh2fW73TeNhQ7aDGJTgXq8zVkaUrLQYH60nQajrSN1LOPkPwNjWdxF+FW1XVT
	 9rY9iGDRS5EVzjrgmz6vbH4GH9DwtMdOFgqnGgMo=
Date: Fri, 30 Aug 2024 15:41:05 +0300
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Committing crimes with NTFS-3G
To: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org
References: <7d1dad03-703c-47ae-a039-c15aa765fd0b@gaijin.team>
 <b282c83c-2fa2-4e8e-b8bf-d42f28c17439@kdbg.org>
Content-Language: en-US
From: Roman Sandu <r.sandu@gaijin.team>
In-Reply-To: <b282c83c-2fa2-4e8e-b8bf-d42f28c17439@kdbg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

 > I suggest that you don't switch OS on a whim and take the 8 seconds
 > delay once when you have to.

I am aware that git will refresh the index every time I switch OSes. 
That is NOT the problem I am having. The index is being fully refreshed 
on *every single* `git status` after I switch to Ubuntu, not just the 
first one!

On 8/30/24 07:58, Johannes Sixt wrote:
> Am 29.08.24 um 22:43 schrieb Roman Sandu:
>> To diagnose the problem, I ran git status with GIT_TRACE_PERFORMANCE
>> enabled, and what I see is that the "refresh index" region is taking up
>> 99% of the time.
> 
> Of course. The stat information that Git on Linux caches in the index is
> vastly different from that that Git for Windows caches. So every time
> you switch OS, all files appear modified to Git.
> 
> I suggest that you don't switch OS on a whim and take the 8 seconds
> delay once when you have to.
> 
> -- Hannes
> 

