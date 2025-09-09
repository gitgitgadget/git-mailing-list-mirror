Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B6F2E2851
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 17:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757440013; cv=pass; b=Vk+3VWvUf5mgVEr56nmWM1lw2rJJ3xGJSTur+ByUP4DPIQpSV2ro7gz5nVVbIU9Gdxb+/5y/E8FxVCmUeLhR0lmxYU/JYvSqBZdn4GHbr6fcfRSMkdJxUzsmQTgDlSFSLYF3j+vc+XeZTHHqcTxv/wIZ5xC4VNO9V+JrEbDNuIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757440013; c=relaxed/simple;
	bh=M3qbaAEoJld0QSN41Dq2NH+se9QOqMBN1dY0rtwffNw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZnK7drroCDO52siwnBcTsD0oopJ6II5kAcwDF4HPUeNbjZ6DNG85BkQnSWwj3ad7FjOgmNVrw3Yb8O/nFsmAcX7QSbavkJtisAEE3A6sOiWIUtCJIeAaoZ4H1izmuPCTC4BK8YDUIGjl6r3s1KVZpNTXHn0rmPMFmw69qw2aG8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=fehluDbT; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="fehluDbT"
ARC-Seal: i=1; a=rsa-sha256; t=1757439993; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hs2w7lc2xETm+fl4gjqotqNxSJe/7IV/cpj0Z1g+ZKN+3yYFgtjF6o8pT8xVweuTBt8TGuYEbH5+S1kDxxdKHXgmQ5J+4us7Pnr+JusWVicHB+O6LIm3q266zTknO4Drnng0CKJrUWhS+zGBJFG8fa3WzTC409AFSINn0aFvcxY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757439993; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=8aIxA88DvuhiRwQsjbjJMaM8PHeZhhOVctTHqP5QzJM=; 
	b=i6kulNo47JIBu7YgD73U4dt5xela/TfWQdPMZ4HL6g17wn2qgXXIAP4tdKL/bebrQY2PEdfpM/e1QZdRSQsNZOfc163GHSmCn3fLvCS5kPSTEWHV96r+zpY2j8fhul68xMzXyoJc2L4kY2YmDUFmqSEowPyomALQzFxb+V5acBY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757439992;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=8aIxA88DvuhiRwQsjbjJMaM8PHeZhhOVctTHqP5QzJM=;
	b=fehluDbTWWvxVIQawsgAbE0uRDAbb9YGHc73DkiVTl7RBMpYmQci3IHc5qJPTzJw
	/9wca/j9A4i/CqwYTo4rz8nMOfEs+SAuIQIhf8JKOTfJpuWtIAYYwPuTbGDm//DYQqN
	nT1TAvrZUlewHefEtYm19GmoeFTFNv4ePyYu2qvE=
Received: by mx.zohomail.com with SMTPS id 175743999012792.16361260266422;
	Tue, 9 Sep 2025 10:46:30 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, Rodrigo
 Damazio Bovendorp <rdamazio@google.com>, Jeff King <peff@peff.net>, Junio
 C Hamano <gitster@pobox.com>, Aaron Schrab <aaron@schrab.com>, Jonathan
 Nieder <jrnieder@gmail.com>, Josh Steadmon <steadmon@google.com>, Ben
 Knoble <ben.knoble@gmail.com>, Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH v2 03/10] submodule: add gitdir path config override
In-Reply-To: <aL_Z8DusXdyIr4Ru@pks.im>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20250908140117.262205-1-adrian.ratiu@collabora.com>
 <20250908140117.262205-4-adrian.ratiu@collabora.com>
 <aL_Z8DusXdyIr4Ru@pks.im>
Date: Tue, 09 Sep 2025 20:46:25 +0300
Message-ID: <87bjnj7c3y.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-ZohoMailClient: External

On Tue, 09 Sep 2025, Patrick Steinhardt <ps@pks.im> wrote:
> On Mon, Sep 08, 2025 at 05:01:10PM +0300, Adrian Ratiu wrote: 
>> This adds an ability to override gitdir paths via config files 
>> (not .gitmodules), such that any encoding scheme can be changed 
>> and JGit & co don't need to exactly match the default encoding. 
>> A new test and a helper are added. The helper will be used by 
>> further tests exercising gitdir paths & encodings. 
> 
> Aha, so you already do what I'm lamenting about in the preceding 
> commit. 

Not quite. I tried to explain in my previous reply that this only 
looks similar and perhaps I should have worded the commit message 
differently (I promised Phillip I'll reword it), however it's 
intended just to allow simple overrides, without being a unified 
way for all implementations to work with gitdirs. :)

> It still raises the question around how to handle this whole 
> migration now, as alternative implementations don't yet know 
> about this specific config key. Doing all of this in a single 
> patch series will most likely result in breakage. 
> 
> In theory, we should probably first introduce the configuration, 
> then wait a couple releases for alternative implementations to 
> catch up, and then switch over. But we still cannot be sure that 
> implementations know to handle this key alright.

Exactly, they won't. :)
 
> 
> A heavy-handed solution to this would be to introduce a 
> repository extension. This would ensure that any well-behaved 
> Git client will refuse to open the repository if it doesn't know 
> about that specific extension. With the remaining ones we can be 
> sure that they know to handle the "submodule.*.gitdir" 
> configuration.
> 
> As mentioned, extensions are rather heavy-handed. Furthermore, 
> this whole infra is only really needed under very specific 
> circumstances. So maybe it could be a viable approach to make 
> this extension opt-in: 
> 
>   - We provide a new configuration 
>   "init.useSubmoduleGitdirExtension" 
>     that tells git-init(1) and git-clone(1) to use the new 
>     extension for newly initialized repositories. 
> 
>   - We detect the situation where a submodule cannot be cloned 
>   due to a 
>     path conflict. If detected, we print a user-facing hint that 
>     tells them to enable the extension. 

This is actually a very good idea, to detect path conflicts and 
print a nice message to instruct the user to enable the extension, 
instead of the default "error: git dir is inside git dir" or 
somesuch confusing msg.

I'll work on it for patch v3 and add some tests.

> 
> Once the user enabled the extension we'll know to use new, 
> encoded submodule paths from thereon and thus re-initializing 
> the conflicting submodule should work now. 
> 
> With all of this I wonder whether we even need a new 
> ".git/submodules" directory. Couldn't we just continue to create 
> submodules in the old path and for example create a random 
> suffix as required? 

Now that we decided to put this logic behind an extension, we 
might get away with having a unified directory, yes. It's 
something I'll explore for v3. I would really like to avoid having 
both "modules" and "submodules" alongside eachother.

> 
> In any case, please stop me if I'm going overboard with my 
> backwards compatibility concerns :) 

You have good ideas and your feedback is much appreciated. Kudos and
thanks!
