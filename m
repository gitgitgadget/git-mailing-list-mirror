Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6AD3F23B5
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 13:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782912424; cv=none; b=t0n00JSjm35NCd7gMQ1Mz369ozaq6/avedqiPc5yr28hl9/ElQ9yFwQR7rOrpCPCJkBQFd4nFTQsk/GWx7GtI9t45s583qK41tpPfQnpkdqxxgmowzhJb36ZGDP/hyqUl90TeCt2JPyRHQ+aoqenl5V2taMX0nPNYzNuucTxQKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782912424; c=relaxed/simple;
	bh=DdgYRNEKZqGRDzAYWQ+ToPBfDN/Ve4L6/kle+GXG5sI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=hHHBOG0aUlGD8lBNFUustUlc23eN8fF6YG0PmOZxm/6nGOI4d7Y637QKNiajp6Yljb0WE752trLrURz3sJ+V2gYyz6rpsBgmnepwdEimFC6ZmLexVD5ZWrocIOIY8lFc+L8eRMhJWnxVtzLAQ6WdCuIZYEaHC6PFtOnraVfHuxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YEI9HrO1; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YEI9HrO1"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-697564cb69eso1587403a12.0
        for <git@vger.kernel.org>; Wed, 01 Jul 2026 06:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782912421; x=1783517221; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sisMTYqAdZz5JY8u66ujiudX54OTIJ6OoBeWvgcZaR4=;
        b=YEI9HrO1bKqwehxisx9GujSQ8OGA8FF2s5u+NU/PjmX6BHV8UMkCv8nA6qhpkNUq3g
         3EhxtZ/FgvgdhQIVVMLIzj9p3Dv7x5kB8E9Q2soPXBGgY2dhammmKA1lydxJNhHLaRkc
         6bLE6fYKMfMMOHN5q5TKkNF2FL7NMY5HJBFLu4epSXBfvKcjVTJwF5+IreneklOfy8ZM
         RVO2kD4sEQuOEpTLyD5RctH3SHbcYPC+moBd/UKGGNLMrpHcqrix2DPrIqWuVx8yzP2v
         RpUCs1oY2i9WLfecXMlSq/rhfsdUttAgYTrTMg9hHPakYtUdREy7tPEsVrsk/+7//j1I
         EtyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782912421; x=1783517221;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sisMTYqAdZz5JY8u66ujiudX54OTIJ6OoBeWvgcZaR4=;
        b=Xpo2VbZckkQkvU0WWzE+wpHDuB6s/wBNGMjkC2y4rz8J2K97Pv+E62/1B4E9kblIfi
         te8vE9R6dkrZHHEIXm0MuB++xpeWdploFSVNN0PnyDJQNc9D0ScaMFEX5rZKF5rAi/HF
         dtbthRNv9SJblIXs4L4NmgFOl0p36bX83Xy+B/jt4WVZ6gVPSza2FKtkVgEtDhtRH1Lh
         n1/u/Jzmp0R6qdiK0vB6N3ZgbRwaozewd19wpuw7LZ2KHuThWSMnGwLLTfw4/mlefaHy
         UPoOut9mGn7st8jNjvBdQhtZ6+4evI+pHL26tUdkAu+seNw0Nioh7PY++9czuUsjrnWN
         v+8A==
X-Gm-Message-State: AOJu0Yw/b/nAeCmVTe13+RiYP5q2pEmVmiGwq2PqNlVy32319H5MaybB
	BC5Z/zNco7tZsewCefRHbG5wA1PJqeEkt8YSrExGYPFrGc9UAP0RI2k6
X-Gm-Gg: AfdE7cnXIN0al1euTxBWNxC6cHVlxWgyl1QD2OrxlzEceYpYdEBYCTlcVbO8Kn/JU3+
	CynxPvg9HsRWqblk709JqQhg6B3ZbIkcpMqcG/F2gauY7kLjwl7rm94uDjHZjJWjudP+axFj4BL
	tfE3DIxSgjHN1m+5Fr/Hh4j0AzfvjsLGxOWSJJqiafic6FGftiNQUDtCrGWYHcs34xVcPoFwuVR
	jgzV0SNVYjDdJ/RMc7FnY0XoWaI28PMfZxZ5s1pekkP0qxtRKxKAB4z1XLRdhkE04ROAm7JkLp1
	t2dPKNPMu5KA9WYJoYBqm4bpNBI2G2WenOZoZi0ypggDDm6nZio5AuWZKrkRS3qn3oTdnTvnfPP
	kydG6vUEEL3wlYv3TbKjylMqBaUQ49YbkVDVDCZ93OgNprXDnFlBfCfA2gZPD5LR+CslL1HiOgq
	SlY0bID+fgjksaiIOBXtRod359cxlWSzKoi6CeVDHAVmT5gkiMX56cVsEjLAGRGSfeYLg=
X-Received: by 2002:a17:907:fd86:b0:c11:fe9d:2544 with SMTP id a640c23a62f3a-c12ae4a690bmr42079866b.22.1782912421048;
        Wed, 01 Jul 2026 06:27:01 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:201a:26ab:8d41:fb43? ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1288f4c19esm272419566b.51.2026.07.01.06.27.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 06:27:00 -0700 (PDT)
Message-ID: <cbbb08fc-fd4d-45ef-927b-05ac44602ff1@gmail.com>
Date: Wed, 1 Jul 2026 14:26:59 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH RFC v2 2/2] Move libgit.a sources into separate "lib/"
 directory
To: Patrick Steinhardt <ps@pks.im>, =?UTF-8?Q?SZEDER_G=C3=A1bor?=
 <szeder.dev@gmail.com>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>,
 Junio C Hamano <gitster@pobox.com>, Elijah Newren <newren@gmail.com>,
 Derrick Stolee <stolee@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20260622-pks-libgit-in-subdir-v2-0-cb946c51ee7b@pks.im>
 <20260622-pks-libgit-in-subdir-v2-2-cb946c51ee7b@pks.im>
 <aj9wcFEb6oCRnfn2@szeder.dev> <akS51xJSP4tkP_pS@pks.im>
Content-Language: en-US
In-Reply-To: <akS51xJSP4tkP_pS@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Patrick

On 01/07/2026 07:55, Patrick Steinhardt wrote:
> On Sat, Jun 27, 2026 at 08:40:48AM +0200, SZEDER Gábor wrote:
>> On Mon, Jun 22, 2026 at 12:38:22PM +0200, Patrick Steinhardt wrote:
>>> The Git project is not exactly the easiest project to get started in:
>>> it's written in C and POSIX shell, with bits of Perl, Rust and other
>>> languages sprinkled into it. On top of that, the project has grown
>>> somewhat organically over time, making the codebase hard to navigate.
>>>
>>> These are problems that we're aware of, and there have been and still
>>> are efforts to clean up some of the technical debt that is natural to
>>> exist an a project that is more than 20 years old. Furthermore, we
>>> provide resources to newcomers that help them out like our coding
>>> guidelines, code of conduct or "MyFirstContribution.adoc".
>>>
>>> But there is a rather practical problem: finding your way around in our
>>> project's tree is not easy. Doing a directory listing in the top-level
>>> directory will present you with more than 550 files, which makes it
>>> extremely hard for a newcomer to figure out what files they are even
>>> supposed to look at. This makes the onboarding experience somewhat
>>> harder than it really needs to be. This isn't only a problem for
>>> newcomers though, as I myself struggle to find the files I am looking
>>> for because of the sheer number of files.
>>>
>>> Besides the problem of discoverability it also creates a problem of
>>> structure. It is not obvious at all which files are part of "libgit.a"
>>> and which files are only linked into our final executables. So while we
>>> have this split in our build systems, that split is not evident at all
>>> in our tree.
>>>
>>> Introduce a new "lib/" directory and move all of our sources for
>>> "libgit.a" into it to fix these issues. It makes the split we have
>>> evident and reduces the number of files in our top-level tree from 550
>>> files to ~80 files.
>>>
>>> This is still a lot of files, but it's significantly easier to navigate
>>> already. Furthermore, we can further iterate after this step and think
>>> about introducing a better structure for remaining files, as well.
>>
>> Please also discuss the drawbacks of this proposal, and try to argue
>> convincingly that the benefits outweigh the drawbacks.
> 
> This is overall a subjective change, so there is no "right" or "wrong".
> The reason why I think the pain is ultimately worth it is that it's a
> one-time cost for a permanent improvement in discoverability. And that
> improvement is especially helpful for newcomers, who already have a hard
> time navigating the code base.

As I said last time this came up, I don't really buy the discoverability 
argument because there are just as many files to trawl through to find 
what you're looking through and now there is an extra directory to 
check. I think the solution to that is to recommend folks use "git grep" 
or ctags etc. not moving code to a new directory.

I do however think putting all the library code in a subdirectory makes 
it easier to say things like "please try to avoid new uses of 
'the_repository' and prefer 'error()' over 'die()' in library code" 
because all the library code is in the same directory. I think that is a 
much stronger selling point.

>> I, for one, see myself being rather annoyed by regular 'git log
>> lib/foo.c' stopping at the rename barrier, and by the limitations of
>> '--follow'.
> 
> Right. As mentioned in a parallel subthread, I think this is a
> deficiency in Git itself which we are in the best position to fix. If it
> is proving to be painful, then it might even help to subject ourselves
> to the same pain that other projects that do larger renames experience.
> So it might motivate us to improve this area.

Another cost is remembering things have moved - the other day I spent 
too long wondering why "git show origin/seen:wt-status.c" wasn't working 
until I ran "git log origin/seen" and realized it had move to 
lib/wt-status.c.

Thanks

Phillip

> In any case, I'll amend these thoughts to the commit message, thanks!
> 
> Patrick

