Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D7648094D
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 13:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780492061; cv=pass; b=Vx2y+8aSDybrxsI9Yo7HVFR7RUJiP7SX39w8pyZV3/uAxt4w07CsVM83SZfpn6B1Xi54/CyC8xVR5lqKfBNTyMmbFP2Ct4xiHwPLkWUVYK4STQMjiVQWvADa5YkFKQICURxdvBMWXwxPf7b9q+tn24fr3g3sn+l1GbP0ufxU8PU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780492061; c=relaxed/simple;
	bh=y1zcayi5/r30HdIOWO+AT2KXbvjeG+b40CKTCMyV/Yg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uNc1itWzMDbzkl/FC43rvonh7WLUWaN/mPPVbdvxfuPmpQQvLPqYIt2cZdho14o3tXlY1JfLBUQJ7KYtNq3y/qjuxEjY2P1l7JHfxlZMpc1vKEZi1V+s/9hqa9ac+XEtWuURztAfaCXVzP25V7dLdaAQSm1wlMTt7ZsK4Y5lQcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=b3hbHgcQ; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="b3hbHgcQ"
ARC-Seal: i=1; a=rsa-sha256; t=1780492042; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ecKFGlmgvX6r4ftUB+D722DnUPZQQa/OP4R6KsUoHdHQEKUcuObfWHbM762o6K1r5iBnqgC029mQuiQlUVRCBMnhF9EYhrDYY242aL2JoGKKY6Z7Y7FGoFbGCp/tHS0vk4utociiTBRvYwl1FkqDdlbHGMdjQeTaG4x+i4jVHdc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1780492042; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=W+XixBxV3clB7sGtgw6rrm0AsXyzXZUqELftek0EOS4=; 
	b=ntBMemCXBP7xWa+uyAYibQUOqLi8wfDvc8o9FW6jhgdxNlv7O8FnQWMl5fZtUGpZGlGUJaEXZh5bw/FyUmHvt3E1vEkocxWXJ5II1ulk8apfhDtk1TeRwU17PfbrsrSxWPTEHCG1z+pfwcl9P4zVR/ZkD0HsADiENZa4I1ee8BM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780492042;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=W+XixBxV3clB7sGtgw6rrm0AsXyzXZUqELftek0EOS4=;
	b=b3hbHgcQ0T5RXBtSJm3L+h0yTM/e1HasMqrl+sEff66XJ5h4zI6Aw/HLViuh8yyx
	efalhYG+3+t9T45OKR+md6ozGQmzrkCWvM1vS3V+3+waBof23c+YC4duYk8R9zYqxI5
	R5aYGmRxekVehr4dPi4Cimhg9fxAJ4KV66L1zf54=
Received: by mx.zohomail.com with SMTPS id 1780492039412575.2582618941453;
	Wed, 3 Jun 2026 06:07:19 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Jeff King <peff@peff.net>, Wesley Schwengle <wesleys@opperschaap.net>
Cc: git@vger.kernel.org
Subject: Re: git hook question
In-Reply-To: <20260529210049.GC2628906@coredump.intra.peff.net>
References: <cc9fda14-d8e8-4982-9a3d-9aa816c0b90c@opperschaap.net>
 <20260529052141.GA1099450@coredump.intra.peff.net>
 <c5527d8c-9147-4355-a07d-153d3977108e@opperschaap.net>
 <20260529192350.GB1711766@coredump.intra.peff.net>
 <4d938e1e-fdd3-42d6-a879-4d394ee8c00d@opperschaap.net>
 <20260529210049.GC2628906@coredump.intra.peff.net>
Date: Wed, 03 Jun 2026 16:07:15 +0300
Message-ID: <874ijjojr0.fsf@gentoo.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Fri, 29 May 2026, Jeff King <peff@peff.net> wrote:
> [re-adding list cc; let's let everyone benefit from the discussion]
>
> On Fri, May 29, 2026 at 04:14:33PM -0400, Wesley Schwengle wrote:
>
>> > I don't think the hooks themselves should need to be aware. If somebody
>> > is calling "git hook run pre-push" without providing arguments, they are
>> > breaking the contract to the hooks. You can get away with it if you know
>> > your particular hooks do not care about those arguments, but in the
>> > general case, what should a pre-push hook that _does_ care about the
>> > remote name do when it doesn't get any arguments? It's an error.
>> 
>> Are they? The manual says this:
>> 
>> git hook run has been designed to make it easy for tools which wrap Git to
>> configure and execute hooks using the Git hook infrastructure.  It is
>> possible to provide arguments and stdin via the command line, as well as
>> specifying parallel or series execution if the user has provided multiple
>> hooks.
>> 
>>      Assuming your wrapper wants to support a hook named
>> "mywrapper-start-tests", you can have your users specify their hooks like
>> so:
>> 
>>          [hook "setup-test-dashboard"]
>>            event = mywrapper-start-tests
>>            command = ~/mywrapper/setup-dashboard.py --tap
>> 
>>      Then, in your mywrapper tool, you can invoke any users' configured
>> hooks by running:
>> 
>>          git hook run --allow-unknown-hook-name mywrapper-start-tests \
>>            # providing something to stdin
>>            --stdin some-tempfile-123 \
>>            # execute multiple hooks in parallel
>>            --jobs 3 \
>>            # plus some arguments of your own...
>>            -- \
>>            --testname bar \
>>            baz
>> 
>> There is nothing about the contract of the hook, in fact, the way it is
>> written there isn't really a contract.
>
> This is a made-up hook, so it is up to the person defining
> mywrapper-start-tests to define that contract. And in this example,
> implicitly it takes whatever is in some-tempfile-123 on stdin, and
> --testname as an argument. What those mean would need to be communicated
> between the script invoking "git hook" and whoever is configuring hooks.
>
> I agree that is not made very clear in the documentation, though.
>
>> > So whether you are getting input as arguments or over stdin, it's
>> > probably something the hook needs to deal with (or at least think
>> > about).
>> 
>> Right. I see where this is going. That means I think the examples in the
>> manual are incorrect, no, that's harsh, it could be stated more clearly in
>> git-hook(1).
>> 
>> Examples like this:
>> 
>> > [hook "linter"]
>> >   event = pre-commit
>> >   command = ~/bin/linter --cpp20
>> 
>> seem to indicate: Any script can be run as a hook, the fact it needs to
>> respect the native hook structure isn't mentioned. This is mentioned:
>
> That example is OK-ish, in the sense that pre-commit does not take any
> arguments or receive anything on stdin. So you really can invoke
> whatever program you like (though it needs to understand how to use Git
> commands to look at what is staged in the index). So the details of
> "~/bin/linter" are doing a lot of the heavy lifting here, which is left
> unsaid.
>
> But the later example that adds "event = pre-push" is actively
> misleading. How does the ~/bin/linter script even know in which context
> it's being run? In the real world you are more likely to invoke a script
> that is aware it is a Git hook and can react accordingly.
>
> So I suspect there is a lot of room for expanding the documentation and
> explaining some of these gotchas. +cc Adrian, who wrote these docs, for
> visibility.

Yes, there is a lot of room for improvements everywhere, especially in
the documentation.

Patches are very much welcome to expand on or correct hook-related
issues. :) 

BTW the git hook command is also just a very basic tool for testing, it
needs much attention and more additions. It is obviously not
feature-complete or bug-free.

Some historical context for the curious:

This area of work was blocked for almost a decade because people tried to
find a perfect/complete solution in one go, with complex patch series
reaching even 36-38 review iterations for a single series which went
nowhere, was regressing, was hard to review, you get the idea. 

So I tried to enable a simplified incremental development approach,
reusing existing APIs & mechanisms, to allow more people to contribute
smaller patches which are also easier to review, test and so on.

P.S:
This also reminds me, I don't think it's documented anywhere that the
proc-receive hook is not using hook.[ch], so it cannot be specified via
configs yet like pre-receive and other similar server hooks.

I actually have a collegue at Collabora working on converting
proc-receive so we can remove some deprecated APIs and also clean up
some external hook_exists() calls which are now redundant because they
are handled by the unified hook.c implementation.
