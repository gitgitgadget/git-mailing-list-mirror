Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C8232ABF9
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 17:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768413417; cv=pass; b=Njzd9tPaH4SGR2mCJ/jmesHNNUVWiEheVEvOe9SxCjXwJMfRZSkLaYwfJ6+FsnSZNqIXmWh1fz98bjA1QG9hUdHwf4VxJGy7RiHFyGlS/RXs0rcelAInMyYNKnLLv/IuU9eB2q5CZkC0oC4eZuXNowAjELZ0yiHClRphqkAMkYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768413417; c=relaxed/simple;
	bh=zYQGzGbV3pYec0/MSkmqvt1Z2F0BJK8gMf6w7M5RKjo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o98Yx+UPiLFdp5iigJm9I0qufxW2RHJvkE328AZra13Y+lvDiCgGAa3W5BNlJiWAXI409YBDtZXjilsoPjcGCYddkBgAmLmNuy63ECsayq7wOKrYd1hwuFr/qOWaoYq7qZNvIu4kiQfpy45Qn9esY63S5I1N8HTauikrf8E02yI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=AVolPZKN; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="AVolPZKN"
ARC-Seal: i=1; a=rsa-sha256; t=1768413391; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=CQ3NbydTPi3h5WCvCg+WFguIIlPv3E/IWkXCEqLIK/JbNK2aTlZ8m62gc1NswRt2FKTPNHlGJtKHhYNgMTJj2iJjttfMujr0yzLhwPBxNXELOf+taz5+EINjffvdtsYTB1VsdNCjlFuwNODlrksyQmPF9x7ry3qLXYEtQB941F4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1768413391; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=uu46ysYbOBAIJ4VzmiMo3Pz97n3BAMwFePkVCQweYLU=; 
	b=E3qhruvlEMXsK9wBSud7X9LF4zMdVQFD4IklC2HlIRN4RauiBkDH6zB+6F/FJCFVoFdrQHXe4psIrN8kD9jUoA9//0qoFAFmOsvbMMkp+dLU1i8OVCpfDdCs+lMgGcKWndzw/5vRrI0FoEcWGer6xCJnztub7cjWJoIG30RCQ7g=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1768413391;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=uu46ysYbOBAIJ4VzmiMo3Pz97n3BAMwFePkVCQweYLU=;
	b=AVolPZKNqXfV+0OLXDbG1x+7ckgyiD52yzdOZBhqC2JaBYNpmHtyeyt+4J0yBWlZ
	xLpamZRjG8FkrH8m8eB+6A+JIK+Iov0L3CwoaR6j3guqlO/rMTj16JIaeT/JVOylpi1
	HJsAvfBCaSrQYm5MCho4ebnHyR07fCyw4UYuqC1I=
Received: by mx.zohomail.com with SMTPS id 1768413388714918.7655381512681;
	Wed, 14 Jan 2026 09:56:28 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick
 Steinhardt <ps@pks.im>, Emily Shaffer <emilyshaffer@google.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Chris Darroch
 <chrisd@apache.org>, "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2] hook: allow hooks to disable stdout_to_stderr
In-Reply-To: <20260114171929.GC885771@coredump.intra.peff.net>
References: <20260113115633.230479-1-adrian.ratiu@collabora.com>
 <20260113234528.1749921-1-adrian.ratiu@collabora.com>
 <20260114031257.GA858646@coredump.intra.peff.net>
 <878qe0zimo.fsf@gentoo.mail-host-address-is-not-set>
 <20260114170849.GB885771@coredump.intra.peff.net>
 <20260114171929.GC885771@coredump.intra.peff.net>
Date: Wed, 14 Jan 2026 19:56:23 +0200
Message-ID: <87tswokri0.fsf@gentoo.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Wed, 14 Jan 2026, Jeff King <peff@peff.net> wrote:
> On Wed, Jan 14, 2026 at 12:08:49PM -0500, Jeff King wrote:
>
>> I looked at what feed_receive_hook_cb() is doing and...it's kind of
>> horrifying. It arbitrarily sends 500 lines, and then yields to the
>> caller to pump stderr (assuming ungroup=0). So:
>> 
>>   1. It is assuming that 500 lines of input won't fill up the pipe
>>      buffer and block. Even if we compute the size of 500 lines we're
>>      sending, we don't know if the caller has cleared anything from the
>>      pipe in the last call. There might be zero bytes available!
>> 
>>   2. After 500 lines we'll go back to the caller, which will then
>>      poll(). But if there's nothing to read on stderr, it will wait for
>>      the 100ms timeout. So if you have, say, 501 lines to send, then
>>      there will be a pointless 100ms pause in the middle.
>> 
>> So here's an example hook setup that will deadlock due to (1):
>
> And just for fun, here's an example that shows problem (2):
>
> -- >8 --
> rm -rf repo
> git init repo
> cd repo
> git commit --allow-empty -m foo
> git init --bare dst.git
>
> cat >dst.git/hooks/pre-receive <<\EOF
> #!/bin/sh
> # We don't even need to do anything interesting here! Git
> # will send us 500 lines, then block waiting for stderr which
> # we'll never send, and then send us another batch of 500.
> cat >/dev/null
> EOF
> chmod +x dst.git/hooks/pre-receive
>
> # Now do a moderate push of 500 branches.
> seq --format='create refs/heads/small-%g HEAD' 500 |
> git update-ref --stdin
> time git push -q dst.git refs/heads/small-*
>
> # And compare with one that sends just one more.
> seq --format='create refs/heads/large-%g HEAD' 501 |
> git update-ref --stdin
> time git push -q dst.git refs/heads/large-*
> -- >8 --
>
> The second push always takes 100ms more! If we run the server side under
> strace by replacing the final line with this:
>
>   git push -q --receive-pack='strace -T git-receive-pack' dst.git refs/heads/large-*
>
> we can see the stall here as we write to the hook:
>
>   write(4, "00000000000000000000000000000000"..., 51393) = 51393 <0.000011>
>   poll([{fd=5, events=POLLIN|POLLHUP}], 1, 100) = 0 (Timeout) <0.100506>
>   write(4, "00000000000000000000000000000000"..., 102) = 102 <0.000057>
>
> That would likewise be solved by using ungroup=1 (in which case we do
> not poll, but just call the feed function immediately again) or by using
> a real poll() loop (which would see immediately that the hook is ready
> for more input, rather than hitting the 100ms timeout).

Thanks for the detailed examples.

For the server-side hooks, I think the way forward is to implement the
poll loop as you suggested so we can buffer stderr and for a single
(non-parallel) hook, we can keep the existing behavior (still need to
test this). I'll do that in a separate patch and drop the batching.

For the client side hooks, I'll send v3 of this series which fixes the
two regressions reported by Chris and Kristoffer.
