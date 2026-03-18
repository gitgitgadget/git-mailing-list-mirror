Received: from www130.your-server.de (www130.your-server.de [88.198.195.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF3D263C8C
	for <git@vger.kernel.org>; Wed, 18 Mar 2026 17:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.198.195.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773855223; cv=none; b=ILmqTIWmSdRH0TrgqJ2H2j2Nw3Ce7u21nLp42pkkGO7mRyXN/xGz5YuXUJxCqzAgx9xBik12ODPJ5ApZRoTsnO4KFnUgqp4CVBWlDoeZRk6qXyan2L1z8pERc7D6ueekLHgpT+Z0Y/NNNBXnqzdtLxo46Pri1j3Mb6X6mmvEyus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773855223; c=relaxed/simple;
	bh=S5OM+mwq02BSnzN84xwr8WHZK+fNer5UDtgWRBNJjFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lVXKE5y4LUFsPsDqDSlZdXqUV0PvN3/oVVCDacUXAPl/VzxJ3cYjE2Pn/3YuvOHr2TgPVHkpA1DiUWDxuvyzdu01Xd+uh77JlZCalq/9JSlPWnD+pf0YJefBWHRDeDtz5lAxNZd2WzgCWO2jvBUi4fW3zvbY0Smx1HIYrE2UXOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=virtuell-zuhause.de; spf=pass smtp.mailfrom=virtuell-zuhause.de; dkim=pass (2048-bit key) header.d=virtuell-zuhause.de header.i=@virtuell-zuhause.de header.b=ZBiZcbDa; arc=none smtp.client-ip=88.198.195.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=virtuell-zuhause.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuell-zuhause.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuell-zuhause.de header.i=@virtuell-zuhause.de header.b="ZBiZcbDa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuell-zuhause.de; s=default2504; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Gxj2MOjvRvKkQfeBjJE808hNwcjg/yo4zJ4oOiC7d5E=; b=ZBiZcbDauZ1LFhuitWmpN4Y7fI
	pLmG2GcM19mudTRNcZj1jT+Z4GRJwjRcSAQHqbirx1fAE/n7+sBR+ua5Fg7INVVTpOumaB9LQhlbo
	ZnCfnhZGDJQJ9HSdGL+htkuJ2u3ZLNM0DIztGfBn7SgHtuiJ7FaHpu3iAi1EaYtD8wFVqNum3krxP
	qNH3HzDPV8XC60ESN/xAW31BsT19A7w8mtcXGs1le0N+c1tKajLuNRwHHk1DVKny6+xKVlZEgHilL
	6aMwpDf0rvmo2EiVJP1dd/27WxUIk7yPjO54Km7bg4Fpt72tSPbIRMovQYNzaMOAsFCvrFLGwy6S4
	Eu865Wiw==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www130.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <thomas.braun@virtuell-zuhause.de>)
	id 1w2ulv-0005Gk-1f;
	Wed, 18 Mar 2026 18:33:31 +0100
Received: from localhost ([127.0.0.1])
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <thomas.braun@virtuell-zuhause.de>)
	id 1w2ulv-000Gvd-29;
	Wed, 18 Mar 2026 18:33:31 +0100
Message-ID: <9cb575c2-a08a-429d-a7d2-cdceda8389bf@virtuell-zuhause.de>
Date: Wed, 18 Mar 2026 18:33:23 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: describe with --git-dir and --dirty outside of the repo always
 says dirty
To: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Cc: GIT Mailing-list <git@vger.kernel.org>
References: <99f2ba7e-cc5f-4ef5-9b09-85896563346f@virtuell-zuhause.de>
 <xmqq8qbv4gnq.fsf@gitster.g> <abe9uDp16zOcdzZs@pks.im>
From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
In-Reply-To: <abe9uDp16zOcdzZs@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27944/Wed Mar 18 07:24:13 2026)

Am 16.03.2026 um 09:22 schrieb Patrick Steinhardt:
> On Fri, Mar 13, 2026 at 01:29:29PM -0700, Junio C Hamano wrote:
>> Thomas Braun <thomas.braun@virtuell-zuhause.de> writes:
>>
>>> When I do
>>>
>>> git describe --dirty
>>>
>>> in clean repo of git.git I get
>>>
>>> v2.53.0-522-g67006b9db8
>>>
>>> but when I do it from outside of the repo
>>>
>>> cd ..
>>> git --git-dir=git/.git describe --dirty
>> "--git-dir" tells git "I am at the root of the working tree, but the
>> git directory that you usually find at ".git" (or a parent directory
>> of where we are) is not where you expect but somewhere else, so I am
>> telling you where it is with this argument.
>>
>> So if you are not at the root of the working tree for that working
>> tree, "git --git-dir=git/.git diff" would report that you have a ton
>> of changes to working tree files, and "describe" would report that
>> your working tree is dirty.
>>
>> In other words, working as intended.
>>
>> You can tell where the working tree is (instead of telling the
>> command that you are at the root of the working tree, when you are
>> not), with the "--work-tree" option.
>>
>> $ git --git-dir=git/.git --work-tree=git describe --dirty
> You can do that, but what you're probably looking for is `-C`:
>
>      $ git -C /path/to/git describe --dirty
>
> As Junio pointed out, "--git-dir" has a different effect, and you
> typically don't have to use it unless you're doing weird stuff.

Thanks both Junio and Patrick. The documentation is not lacking and 
fully explains
that -C is the way to go. I should have checked first.

My lameish excuse for originally using --git-dir is that -C which was 
added in
44e1e4d67d (git: run in a directory given with -C option, 2013-09-09) 
was too
new back then I added the code originally in 2014.

Thomas

