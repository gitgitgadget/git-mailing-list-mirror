Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71AF1E2834
	for <git@vger.kernel.org>; Tue, 25 Nov 2025 00:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764032260; cv=none; b=nVIgf5LscgGG8np+cn96w9jpt4aALI7xS3XxVoLwGKpNhTHvIKEQZWkJ5UzdlpPbstDAhjHTGUHGmiymXfjV5tjNSPCmDPa3U4FqlBegG1kHHwN4iE1UEtg/Rlm5mPLA6fXMEWGFPXQU7VCr6ydD2diQanKcjD7OMc/L5cYQHFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764032260; c=relaxed/simple;
	bh=OI7P+usOUE1fgBDeZzOBXjCLiwaGa4KCq7BjZZSUrvs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nHpqM21vcaN7By/nxkC9FjrJ0Xq/6KNg/fExcJHsM7diHft28AkpEkAcLmXKirzi1TpL0mRhn1AJ3wtqlq9A/6r2qEU83ymgHuX/OlQWH8GAJBGujhgyorNUfaM17yMCZ3ZpnV09wABXw5BlEZ1PhWCzSvfrhJjmxkFun9q3ClI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WNihszL3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gfUBabkM; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WNihszL3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gfUBabkM"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D5FB41400230;
	Mon, 24 Nov 2025 19:57:36 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 24 Nov 2025 19:57:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1764032256; x=1764118656; bh=JlNBe34LK8
	9ULY/Xz9rglfgesEOzfqb+Csz6v6NTStk=; b=WNihszL3hobW4xJuNMPUSrMRNo
	8GU4LSTq5cugEoaiKqLb87EuLvhbUDN5aRJhdIXeb1dX0LKm0l4I1Aj6XIc9Hx+h
	s2XwwRMWVAgmf3SzhOVB8zXn6ARm3WspoMuHh4VrmpX7VBm93nrECimSnGmR3W9l
	zBEUHQouq+VDbAgNH+yxIhLziwtPH2FPbq0FI5wMffOIR/1YnPZfcZnR9iEkxzdF
	gIh39FhCHC/lqOCYWQhcQAm77tPTv51sNPP63kAwY3vVunOUNd85WpKxMwgcT2XL
	jW/MFjkSqNhk4hwMgNXOPww+RwmxRwYSHa1Mx4g0rV3dAOsowba4UCnfXKlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1764032256; x=1764118656; bh=JlNBe34LK89ULY/Xz9rglfgesEOzfqb+Csz
	6v6NTStk=; b=gfUBabkMfJmT+xDRe5wC6nr/VjONstpnxpnpUUu4gwZI8n3U4B8
	8BWVPnsd47uSTFJdytzErhVYmyz7L5wBRtvEW3HLQSNqSqAwNOCKxqrfu8LDAebs
	69jbkfQVBD2i0w7x/JX9Rt/Fn3sSO+nvNVZV+cQxgUHkMCqcG3wDvnlDleRCUFNd
	CmSkHLNOcYc6Gw1axdZ9/2G5rxVsa64sSWzGFiytE8jp2UAwoCs1ULr/JqFchVd/
	mD25JDthX5q3lY8url12Da9kg1JDNDhf4xHbPQ9TfjDzJqO0+FHDvG7CF0gqQwJD
	TBd1Z/cjbYjjWw7H6kLhgMK0lL90JZwf0Sg==
X-ME-Sender: <xms:AP8kaRWncOjRdhGKhO-gv4aTbQswbq3hcW8CgdE-36unts--icZzAQ>
    <xme:AP8kaYnCns40m_NiMPuiJ-XHMlF6V2v7YkSimxFbORHOzaXL_e6N7T7-5c5iDoN4K
    ru46mnH322NWlM_6Uv-KU0-nzwVd_qtRpHKOjk4ek-B4JRSRS6i>
X-ME-Received: <xmr:AP8kaSb4lS5gl_7hP_Ha2TdCCs1KkwtmedqKN_8_VyhYp_IOunJmWZRQv8IwbAkXewpB7vJsSWNESr5Zscui0LDhfebwn9IgMTFa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgedtuddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepjhhhtggrrhhltdekudegsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:AP8kaTPa9CJG5-Gg11tSfuB59bN9Z61bthBTk0NcmGFYIlZ2lTucSQ>
    <xmx:AP8kaXbvj-yfWnNn2Vv8y77GpmBDHH8-ha7AJj5Ho7rLE5JLKGEcCA>
    <xmx:AP8kaR1Hy23ojFuHXGYgxeRgNy6hyYbYHBjR8WjlfJymCS_6WZFHzw>
    <xmx:AP8kaddoGJ5_WCxplEn3L-2Btm2ME0pVRbp519YLoTj9CAXQB0THag>
    <xmx:AP8kaaUZE7PQ7k6k-_efyY_tMfbONV6sEfEVvQsTipXqNewvtGLs2WpI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Nov 2025 19:57:36 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Han Jiang <jhcarl0814@gmail.com>,  Git Mailing List <git@vger.kernel.org>
Subject: Re: `git config get --type=path` results in segmentation fault on
 value starting with `:(optional)`
In-Reply-To: <20251125002828.GA2353309@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 24 Nov 2025 19:28:28 -0500")
References: <CANrWfmQUuGKWPc6JCzeCaa9t98ag_Lyk0G_Prtd8YmqP-TiRpg@mail.gmail.com>
	<20251120075019.GA1283645@coredump.intra.peff.net>
	<xmqq1pls8xeu.fsf@gitster.g>
	<20251125002828.GA2353309@coredump.intra.peff.net>
Date: Mon, 24 Nov 2025 16:57:35 -0800
Message-ID: <xmqqa50budxc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> I confess that I did not read the documentation at all, and was only
> going on what I'd expect ":(optional)" to do. So you can take what you
> will from that. ;) It does feel to me like the user-facing behavior is
> driven by ease of implementation, not what users would necessarily want.
> But it probably is not worth revisiting at this point (especially
> because it is kind of a corner case for the distinction to matter at
> all).

Hmph, I tend to disagree; this was not driven by ease of
implementation at all.  Rather, :(optional) cannot be an attribute
of a variable; it is an attribute of individual setting of a variable.

For example, imagine that you want to say "the system wide fallback
is in this file in /etc, but you can override it with a file in your
home directory", and you want to say that only once in the system
wide configuration file so that it applies to all users, without
each end user having to specify that they do want to override it in
their Git configuration file.

You can write this in /etc/gitconfig

    [default]
	editorConfig = /etc/editorConfig
	editorConfig = ':(optional)~/.editorConfig'

and ask what path default.editorConfig file is.  As long as large
enough user population agrees what the name of the file under their
$HOME to control the behaviour, this would work better than telling
them "you can override default.editorCondfig in your per-user
configuration file", as it is one fewer thing to configure.

And this is possible only if we consider that what the system
pretends not to have seen is per :(optional) definition.

> But the way to do that is to avoid saying "--type=path" in the first
> place, and get the full string (including the optional tag). If we had
> some kind of "--type=path --show-missing-paths" option, then we'd need
> to be able to see the missing name (like my struct proposal above). But
> we don't, and nobody is asking for it, so I think we can punt on it for
> now.

;-).

> I did wonder also if format_config() would need to roll back any output
> for something like:
>
>   git -c foo.bar=':(optional)/no-such-file' \
>     config --type=path --get-regexp --show-scope foo.bar
>
> which would show the key name and scope before even looking at the
> value. But because we assemble it all in a strbuf, we can just throw
> away the result.  And it looks like your patches handle that. It doesn't
> look like the tests cover it, though.

Didn't think about that case, but then we seem to be lucky ;-).

> Looks your topic isn't in 'next' yet, so possibly squash this in?
>
> diff --git a/t/t1311-config-optional.sh b/t/t1311-config-optional.sh
> index 766693387f..fbbacfc67b 100755
> --- a/t/t1311-config-optional.sh
> +++ b/t/t1311-config-optional.sh
> @@ -18,7 +18,9 @@ test_expect_success 'var=:(optional)path-exists' '
>  
>  test_expect_success 'missing optional value is ignored' '
>  	test_config a.path ":(optional)no-such-path" &&
> -	test_must_fail git config get --path a.path >actual &&
> +	# Using --show-scope ensures we skip writing not only the value
> +	# but also any meta-information about the ignored key.
> +	test_must_fail git config get --show-scope --path a.path >actual &&
>  	test_line_count = 0 actual
>  '

Nice ;-).
