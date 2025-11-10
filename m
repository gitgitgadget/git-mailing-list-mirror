Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B280B32C31D
	for <git@vger.kernel.org>; Mon, 10 Nov 2025 18:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762799292; cv=pass; b=hiSTSH7F4sXXOqgZcJYyBFvNlgOT/lUo4gYVyPEZPrkVQartDgGO1ksYVv4dCpR6fDegzz08KWaHe6+vXNuBA0r/r7xzjvNYdv6u5zuqEnudTCdtVyyl0OECp5ZZUxB5qVLn9JUeFUCnrweikINyOQpP2G9QoPP0HtV80Rwk3Rw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762799292; c=relaxed/simple;
	bh=4soQVp0CikUwL9rYtDemFlvbaMJdDqnz34BCwCBChcM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OCzmjLtTitBeuTq3YaKYCxX2Qfi8zLTHDKufQg/jMZysKOmOvx+lH98MESrZoO0aT6vsN//tnNFZPR5L5x9M8Ml9EHRwUp+u+DrJYed3dtb4tq2I006P6SztxCE8QXojp3epTgPA27RuWvzXOVf9cDUnUisNBtGVzxRjNiEGyZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=FIOa3o+2; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="FIOa3o+2"
ARC-Seal: i=1; a=rsa-sha256; t=1762799273; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=miPyPtIXB0U3Mh6syfXjL9rK83I5IsLpWquYeEVVjoFuFoqUv22eCS+cmPRvulMVhbj/bzV9v963o4+3rJrZy0Dr/iOvbrRTsnUfOnCqtrOnE+fN5IFQ/Xb2l50LyVTQpIQwSxU+wPtLey6Yjd/0teRpsQP7tHEQV9ujEtfXj5s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1762799273; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=S8/7uNb8wBkdkSycqt6N70yvkcl7h2EE+YbgVHQVwkc=; 
	b=nL9J5+dx0xi1N6kIVlqM5s1ArR3h54+otBZLeZ8WXrG6Pye68/xLRqn827+q/A9ysntjJXjTR9eZC5jI/N3lby13cXXOjOu3JEH9gkTui8/q43ixIdgFIS658gF92ag629lQGoFhrEWhqKwlY//ggPOofig6WScA1Q1s6AU0tS4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1762799273;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=S8/7uNb8wBkdkSycqt6N70yvkcl7h2EE+YbgVHQVwkc=;
	b=FIOa3o+2gnK8+yrd1KtMsw+QL43a184dBpWuHugeWS0+18AgdcqPbFiwdnJOHxvN
	5KEHP8TmQPxyPFwIcRG5pq5MgKLMAsXH3MMGbybtQizzBej+e7xGFtTQm2zWqe+AgF3
	Ou9dqOCeR5mU8L/LggBnKgFYwusOJMxzdxQRVzAw=
Received: by mx.zohomail.com with SMTPS id 1762799271223191.0009466574253;
	Mon, 10 Nov 2025 10:27:51 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Aaron Schrab <aaron@schrab.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, Rodrigo
 Damazio Bovendorp <rdamazio@google.com>, Jeff King <peff@peff.net>, Junio
 C Hamano <gitster@pobox.com>, Jonathan Nieder <jrnieder@gmail.com>,
 Patrick Steinhardt <ps@pks.im>, Josh Steadmon <steadmon@google.com>, Ben
 Knoble <ben.knoble@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v4 4/4] submodule: fix case-folding gitdir filesystem
 colisions
In-Reply-To: <20251110T173154Z.Hhi6cUjqDOat@fnord.qqx.org>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251107150547.3272180-1-adrian.ratiu@collabora.com>
 <20251107150547.3272180-5-adrian.ratiu@collabora.com>
 <20251108T182050Z.vbNv4y2kizC1@fnord.qqx.org>
 <87ecq5ke2m.fsf@gentoo.mail-host-address-is-not-set>
 <20251110T173154Z.Hhi6cUjqDOat@fnord.qqx.org>
Date: Mon, 10 Nov 2025 20:27:45 +0200
Message-ID: <87bjl9kaji.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-ZohoMailClient: External

On Mon, 10 Nov 2025, Aaron Schrab <aaron@schrab.com> wrote:
> At 19:11 +0200 10 Nov 2025, Adrian Ratiu 
> <adrian.ratiu@collabora.com> wrote: 
>>On Sat, 08 Nov 2025, Aaron Schrab <aaron@schrab.com> wrote: 
>>>What happens if `Foo` is added first and doesn't conflict with 
>>>anything,  then later a new submodule is added which would 
>>>naturally  get the name  `foo` which would conflict and doesn't 
>>>have any upper  case characters to  encode to avoid the 
>>>conflict? 
> 
>>Right now, in v4, in this case the user adding the second `foo` 
>>module  will have to manually set the submodule.foo.gitdir 
>>config to avoid the  conflict, because Foo already uses the 
>>coliding path. 
> 
> I think that description minimizes the impact. I'd think that 
> anyone  with a prior clone (on a case-folding file system) would 
> need to take  that action after pulling the change that added 
> the new submodule.

No, because the extension is disabled by default.

> 
> If action were needed only when running `git submodule add`, I 
> think  that would be fine. But requiring that action in all 
> clones seems a bit  much. Some of those clones may even be 
> managed with automation making it  even more of a problem to add 
> that new configuration. 

The extension is opt-in: by default it does nothing. :)

When the extension is enabled, all existing submodules are 
automatically added to submodule.<name>.gitdir config without user 
intervention.

Enabling the extension guarantees that config exists for all 
repositories, unless there is a conflict we cannot solve, like you 
pointed above, which is typically only for very rare corner-cases 
(that's the intention).

> 
> The action may even be required in new clones, unless the 
> submodule  setup process for new clones sorts entries so that 
> ones with capital  letters come later. Since some common 
> collation rules (thinking mainly  of the `C` locale) will put 
> capital letters first I think that's  unlikely to be the case. 

The more I think about this, the more I'm convinced the second 
option (see bleow) is the way to go, which is also more in line 
with Junio's design to try a new path when validation fails and 
repeat.

>>Maybe we could derive a new path automatically (eg foo2 or foo_, 
>>suggestions welcome) and use it if valid. This way, there is no 
>>user  intervention.   Do you have any preference? 
> 
> I certainly don't have a *strong* preference. But, I think 
> `foo2` seems  a bit clearer. Although the implied strategy there 
> for multiple  conflicting names may be too complex for a 
> situation that will likely be  exceedingly rare. 

The resolution algorithm is pretty simple:
1. Create a path candidate.
2. Validate if it works: if not, go back to step 1.

We can do this any number of times for all the edge cases we can 
detect.

If foo2 also has a conflict, we can just try something else.

If all else fails, we can even hash the submodule name ;)
