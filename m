Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBE78529F
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 20:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706818175; cv=none; b=Qvzq+1Mts2GjFqBC7GIPK/J7n4ZPcot+hHFYzXKzTfMJdtOEBceGa0GfxGIWbM1IiwDwMbEmNEAShtEjC6RO5oOR1OA2RKDLzyR2HwtskSNANN2toK7y5bge2nuOktWIWDQkEd0guS+rlgykCs8DRcO505+CsNNGxYixC3TxNQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706818175; c=relaxed/simple;
	bh=aD8UOsSx5z+MFHd1rQ/T3KIPr6EfkX55s8e5H/tkALM=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=NtqOGkVD507TpIztZi2YQDmmUIv7Dk5U/xTB3NuBTvm6aXF4GZ3hP7U6Mu6wLKGGfygo21xSyg4KOoNX0zM/OFTIFHEOL+4KzM+rORtrRsnAX4rgvgW/gLo1GRh85FFU8q004P3Uu1TUeg832nFUmUAeahMH7BUNgtsL+8sedpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=lgNXK+uj; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="lgNXK+uj"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1706818170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d/3xc7SsCYyRLA3DZT2Ctnk2leqk/wvByKRR8mzeeQg=;
	b=lgNXK+ujDy2+2ew+BFAZglljSSodLwqb16kFu9uCzGeW44HbX81CPLEGtq62/x/Y3C0CuU
	j/IeqAA7aCHcHZrNq3zbXnQf751EihmK2bCodbWRkQK5ovhVSsXl9KThKxhwNVMhRX50e/
	2XRM2F8KC67CYIYYlnmiGCMNpxkd38vWdPp6poy5x0tRBrxxSfeoj70gKEdnCV0AGoTgpX
	Hpy7YJJnBiA0iqEl3oxT2G3KelEHc3gWZc/B3Z10zduGW6tzJNlFo0V5T4V/JWb9Xe7dF0
	2AxifdCLquZuP3ybdt0N1cm8CZpfDX4mPAilau/Rwk96lrdxcvNtdfGuhJBnHw==
Date: Thu, 01 Feb 2024 21:09:30 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: rsbecker@nexbridge.com
Cc: 'Hans Meiser' <brille1@hotmail.com>, 'Konstantin Ryabitsev'
 <konstantin@linuxfoundation.org>, git@vger.kernel.org
Subject: Re: Migrate away from vger to GitHub or (on-premise) GitLab?
In-Reply-To: <060d01da5549$6e93e250$4bbba6f0$@nexbridge.com>
References: <AS2P195MB21350F44B079009C05A1EAF1E2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
 <AS2P195MB2135D91EE464FF30EE84E77EE2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
 <20240201-primitive-aardwark-of-contentment-aaabb9@lemur>
 <DB9P195MB21301E5E271567256303443CE2432@DB9P195MB2130.EURP195.PROD.OUTLOOK.COM>
 <c3b6de0c2ccf71f0dfa5aff06fa63d8f@manjaro.org>
 <DB9P195MB21303B5546A764A18FE78C97E2432@DB9P195MB2130.EURP195.PROD.OUTLOOK.COM>
 <691395bc13ea6c3013adcb98cfcbd102@manjaro.org>
 <060d01da5549$6e93e250$4bbba6f0$@nexbridge.com>
Message-ID: <7a9048296c585d499d3b2547b05d1341@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-02-01 21:01, rsbecker@nexbridge.com wrote:
> On Thursday, February 1, 2024 2:00 PM, Dragan Simic wrote:
>> On 2024-02-01 19:36, Hans Meiser wrote:
>>>> Quite frankly, I think you've missed some important points from the
>>>> Konstantin's message.  To sum it up a bit, not having continuous
>>>> support is simply unacceptable for any kind of a long-term project.
>>> 
>>> As I wrote, once installed on-premise, no-one will shut down an
>>> on-premise git server except for yourself. It can run for eternity.
>>> You just need someone to administer it properly and publish the
>>> website.
>> 
>> A git server?  I was under impression that you proposed running an own 
>> instance of
>> GitLab or something similar.
> 
> Git is unique, as a project, given that everything (! Not everything
> but a whole lot) is managed using git, including the enterprise git
> server platforms.
> 
> A huge advantage of using a git server is being able to mirror the
> repository. If we went with a GitLab host, we could potentially mirror
> over to GitHub. The drawback is that the pull request history (and
> related discussions) id not (currently) preserved. I think this is a
> situation no matter what, even if we go GitLab/GitLab or
> GitHub/GitHub. The value of the discussion threads is the most
> important part of what needs to be preserved. I have high confidence
> that the team could move to either Pull Request/Merge Request
> structure reasonably easily, but if we had to move again in future
> (count on it), there must be a way to preserve the community assets of
> the discussions that went into making decisions. Without that, I am
> concerned that a migration to a GitLab (or any other) instance would
> increase velocity but put long term decisions at risk.

Good point, I agree that the value of the discussions on the mailing
list is extremely high.  We should also keep in mind that the risk of
a vendor lock-in is even higher when it comes to the discussions.

Frankly, the resilience of email as a service and the openness of its
format can hardly be beaten.

>>> In the end, it's all just about git. You may create your own git
>>> webserver (https://git-scm.com/book/en/v2/Git-on-the-Server-GitWeb),
>>> or just use an existing one, like the GitLab server:
>>> https://about.gitlab.com/install/
>>> 
>>> In these servers, everything is configurable. Moreover, many plug-ins
>>> exist for plumbing extensions to these providers. It's possible to
>>> establish your own workflow, rights management and automatic 
>>> handling.
>>> You just need someone who is an expert with the tool of your choice.
>>> 
>>> Many other great repositories already are using one of those
>>> providers; Meta, Google, Microsoft for example share their code there
>>> – just to name a few. I wouldn't consider these users as being known
>>> for being exceptional risk-takers.
