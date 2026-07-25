Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571BD4908A9
	for <git@vger.kernel.org>; Sat, 25 Jul 2026 17:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784998964; cv=none; b=S2WwvJTz7QJkg8QKfRc/3ocgWqlssD19LFJ/mtHYm09RN6Bh6y7hKoUURXMCVwoLyU1MClhK5iJ208ENC8zdAreHh5kUcFFjkhW/ifVcoVe/RrtNrZiAEvyGcT1/46qZczIC5V4iWI8QCNR8JB99HIp/uRN1UUhGH7HeNeGUFSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784998964; c=relaxed/simple;
	bh=Svh5bBgdc9r1Ub2awZubHYk5JUGxvzRVqjEHo1X7NBA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rEzQxbRu0I8lWbXAu9ydZ9rBLjd2UY/IJmRHmqpcxuny4hhQ2Hf83lDnl1OPv/EZygHXmid8ixwSLPfXZB7tvSCG6Pd8aKC23Tq9uU800uwViulpMVceZanf7p06wHURtiarBYoTIHx04OMGwz1AVzOicFnquFlUo53t/WFSwCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=E5UahYvz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JdbFBfN1; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="E5UahYvz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JdbFBfN1"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 87E60140006D;
	Sat, 25 Jul 2026 13:02:42 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Sat, 25 Jul 2026 13:02:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784998962; x=1785085362; bh=zxs6I09mzw
	AAa2jvzuWpc5/YHo4B4Tzolzn0Xgp1AyM=; b=E5UahYvzKHZYLMDRoq8fzB72t3
	hyj9xYAVheeumBgfBHxdaqBdCj13of/xGJy1AZA79dXd6e7zmKmIHA5J3KtYWhmg
	3hC1/PBBfb8VT5VJRnf9CFOwOTi2kYaqyjVICKPwgOtgh9TeFI6VzcVeJU8htjiR
	WLAbn3YUEga+xxKbUWrWPxZ/BHL2MCyVzDKFIQDXXMc5rKVZ2dl3rWWysl+h1Ygz
	xragXWiwHpE2xVsunkOw87qI4/yjUXbF/6YHsN+IzRLzlEz8ctBC+PCn8FtbzS/m
	7skQYKHD779zu++lBIuoBLY1rpzH1Q+HoHXrNoWoRtOMlHMWzoLK6bva2W1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784998962; x=1785085362; bh=zxs6I09mzwAAa2jvzuWpc5/YHo4B4Tzolzn
	0Xgp1AyM=; b=JdbFBfN1CSpk+ZQc7bLHS2zW2k5W0Snv6lapF1dmINKYjCWmA99
	Dz4ONJfROPEpvyVmvz2feqy0StXF9+O0nKwkOASWn+k9J5GSdnf5SXaCqqDCQE1q
	oNTHJBGJdLXmUtNXh8VC03QlPpdG1X/lcYi8kfbBxTlvfB3VG9UnsrHUM/3+dtFQ
	AYxgp86nUEkiIhoY6aR25p0fSUceq7Gl9YLu5hcqCT7OhNgfKGrxgux3F5C5cWoF
	acShNMopDG2s0vQkah2m6C+6Ynjsf+DM8nsik+nrz60D6c8mH+aWqaACHCIkCp35
	PLmyut/usJUeca57WLnRQ8ozirbCXV9ob4w==
X-ME-Sender: <xms:MuxkapG7eXkvpnraOMiWKS1vH9KIjMelAF26GhngMrKt1fcMi6opsw>
    <xme:MuxkalMJMto21h7t5Mf2SeaShCoGUTXHevW1E-ScYOmn8zQkN-vZzl4pMD-XbuX9N
    XUSMpVUo-EhEUR2i2GVVh4Bh9d0g6TqAfs6BHYhjvVGpnFDI1YUUMw>
X-ME-Received: <xmr:MuxkajcdRRGHF7PaKnD_XtfDOzt7ums8EcP6Em5ooeiI3NUs0W4SfFK2rZMMe4xLfSd-HXpJxN4b_qQk3num8Mn3WN8v10coxQ>
X-ME-Proxy-Cause: dmFkZTEmB3USK51KmKh0n+5cp9CKHKVkQUNxrKK8CYZJpsdSwb8/PMItyPc2IEtSGjwcfO
    DjF+kiDxLaQH5tBcK7snlcVSZ74uIGQDKpQLV8IUamnLsOhIAB7Vjnko365t471ZOpRrCW
    Y9pJCwRJNuTCpyoQWoS7dlKze+NOegqp5hXQD7LeD69HBgz0596sz9C8GuB2RutEvmmDvc
    CtC5N1KJVh2wB4gpMuQshGB+EWZXI7HQVowuFuEPZQEWFDMFRu97584yJdhWb5EiNZ+Abd
    kC+190a3W3VR+m7ybSCZeTlCjoMSxOPNAfwjmM/Famow1dEUODPqk1Nl2T9/4zYP5agzGM
    nBNsNP5FFRLOJIVPfbWDVBwrroEhc7ExWaWPCkZRKEfCxPuuJIDCw2rNTwi4X9Spu0Khpw
    7KnYHBjV3k+iD4J5hjCbDqc/ElKcp5bQgsncBLLn4JsQKEOTKa0coD3hDaByoHrzppWWgh
    tJWK0irwoeOrlVdHpfbd3VhIN8CXIiiJkviGYBcMSC9vr9r6a7i8HVxII7DguCUDOfvVS1
    V6v3piCkUXP1cDrq/kRMUPuKBtqHu+omzkYhCLv7Qbip5Qw27CP+dzrCT5TmGv2HpdTHQi
    51EYSplO4Ao2LD1FbWo0/BrLN6y4AwFjrZq5OShVoIZHxdM8MaLpzooNtS6Q
X-ME-Proxy: <xmx:MuxkaqsEApk4SNu8YD_03GI1u-xj3RFNPOuFJW-iA1NkNHoAb_MAoQ>
    <xmx:Muxkaslbx8KgdtIQVXcKurOAs1hKweThRq3n5FkofWf_b4AnCX4dOA>
    <xmx:MuxkakwEofrTMxArpNEJlQwD1yHwFuYfS_bG35ENJtYVdFgO--itDQ>
    <xmx:MuxkamNktJTtZrVl0hB355J89xh9F_hoc3yNeEy_d2dpECOk3WzuTQ>
    <xmx:MuxkaqcEiGrS1dmCOZmgegZY13n7CjtFKpw2SWOAjiG5oLR6EKN0RTCD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 25 Jul 2026 13:02:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <cat@malon.dev>
Cc: git@vger.kernel.org,  ps@pks.im,  newren@gmail.com
Subject: Re: [PATCH v1 0/3] environment: migrate more global variables, pt.2
In-Reply-To: <20260725115428.2214202-1-cat@malon.dev> (Tian Yuchen's message
	of "Sat, 25 Jul 2026 19:54:25 +0800")
References: <20260725115428.2214202-1-cat@malon.dev>
Date: Sat, 25 Jul 2026 10:02:40 -0700
Message-ID: <xmqq5x23ypcf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tian Yuchen <cat@malon.dev> writes:

> Hi all,
>
> This series moves:
>
>  - (1/3) minimum_abbrev and default_abbrev 
>  - (2/3) pack_size_limit_cfg
>  - (3/3) assume_unchanged
>
> into repo_config_values to continue the libification effort. 
>
> Note: in commit 1/3, we need (repo != the_repository) checks in the
> getters, because some subsystems where the readers of _abbrev
> configurations live forbid the use of 'the_repository' and only accept
> 'repo' [1]. We have to explicitly intercept those intances that are
> not 'the_repository'.

Sorry but I am not sure I follow.  If a repository that is not
the_repository is not yet allowed, shouldn't the caller be flagged
for passing a random repository that is not the_repository as not
conforming to the API (yet) with:

        if (repo != the_repository)
                BUG(...);

rather than papering over the issue with an unconditional

        repo = the_repository;

override?

If the API that deals with this 'abbrev' setting needs to call
another API that only superficially takes any 'repo' parameter
without supporting anything other than the_repository, isn't that a
sign that the other API needs to be extended to work with any 'repo'
before the 'abbrev' part of the system can use it, simply because the
former is not ready?  Futzing with the 'abbrev' part of the system in
such a state piles on more unfinished work that will need to be fixed
later without achieving anything, except for the superficial "now
this part too can take a 'repo' parameter, even though it does not
support anything but the_repository", no?

Puzzled...
