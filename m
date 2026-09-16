Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FED4B829D
	for <git@vger.kernel.org>; Wed, 16 Sep 2026 16:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577050; cv=none; b=MmDjDtHS3gsZH6pTdKfzYk+7TzIaBhM02TTyV0L46NUt1MD905Oqjfg+zxUWp8SAMQHcjjXwWi8YlaMNuMPUSxf/va51wk7PRgQZcczxBGlWcjq4wfUgTUBOzfbUFtxeT89g6AYGWvsQcnR2hIzi9EGPFKr6oZbND3854AoWQKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577050; c=relaxed/simple;
	bh=avQCZj8CLbAdtyL7n6QUFIZ5d+FL9zDyNjpZX6Mbs6E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=je7HtmwjFsrns0jEOrZzkqE+SlqykFnTc9mBem5YKp/5lXEeFfCbNMHbZeOTOV+iGqWtB2LtdbI5kHGewAG7hUnn7Y7zAPpQoNLRtQ9T3nMxo4IBM5PUakScS76Yn2l5/WU3GwA6dN4rMNs+OOWW8sbC6sbkBfIiO+S/EsOwn8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=qsVGw2MI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OQUp4IpF; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="qsVGw2MI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OQUp4IpF"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 6F6E3EC04C3;
	Wed, 16 Sep 2026 12:43:51 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 16 Sep 2026 12:43:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1789577031; x=1789663431; bh=QSE4zma7Fw
	DAn5n+z+XUpMSPY8zbR05Wjx3vUSa+zJA=; b=qsVGw2MIyWi1lD8QMveopPi2XN
	Dt3AqB4murU2IiFyzE/Ye/ksbvVUIvn1+HYDMmZSksnwj1UHhLNlDGywO1REiqSZ
	1RjQvMkLyokoLnGiH1b8jU34Bdl+C5DbzN1iofbk1MUudMPoqLcB/Ni5QyK9m0os
	Q56Njtc2qT+I+cLOQ3Br8de4RXcpAXVBqWyZJa46t9ohBeK2XG0iI5u9BODxYpkB
	VIprAHDNFEbd9VUxyMOapxjgR5mqev++XNUzfYWD26h4BcE24ZbyZmLAegj8MtC2
	Lff3oK7AleZEo8HEREBzFxBaPnhF1OIyTqIQC06d6XOOBv/Zj2rS0Qi4fhLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789577031; x=1789663431; bh=QSE4zma7FwDAn5n+z+XUpMSPY8zbR05Wjx3
	vUSa+zJA=; b=OQUp4IpFl96WBOhTRpSG9M2eUajqj87Bup+ohoB8AThmhXU+ilO
	StQ34VssSOJyxIsM1h8e/WhPwoMLBrIJovNc75hGjw+uZy3dVuUJ9FdkII1o+tQp
	30V5UCp9Z0wpDd23+cLA2CMGWW+wT3/GcnkPysVA3zTrZwN4XkQ/nEPQi31LqWSh
	b2Jf80nMrXSZxbHxInrX/+frLmJZJFjPKO+AAPMYOBHJ/JjOzNFQPrQfXT74uE6O
	/LH5/deV9aT/Xmsf4UnevFbwKNnR8BeQrfCbsmZV1d/W8rncrCeMMMaE1ERFNa6O
	geKW/bXxG2bTb+avASn9ekyI5jDeg3BldBg==
X-ME-Sender: <xms:R8eqahhTwqUcUNjMqV-6lQaqGZCfr0wEY9heqMrs07EFmr0duk2dXA>
    <xme:R8eqatfoVkZSlbv1bOcJFhZSbxBf8pQK7IidU4RffBr1sBLxtFA_ALOo25ywDzZCY
    Tdc6GfZWXsyrn-RsVUSmbcetT3SbdAEmSz4xqxBcfwaK1FFquEe>
X-ME-Received: <xmr:R8eqaudV5FSx-QdJkevxU38SGXwXSLR5W_Y-aahbH4BTJA6Fp1jFXztGzPN1qK_tOYxqCA79gbxvFf84FMafL_JDPnPbmgZelDPV>
X-ME-Proxy-Cause: dmFkZTFpK+xN4jsSmwP4v8CQQbodhkcDxybKCu1qRgLNAkyWVTzFfs5j6eKnESymfrjEOa
    EnXA7e5CuCnlEueaHbf4BouqQVZxeWbO0cElmXurmAemCe/EVI9owuXIe4spmNAx5lYagg
    x3BGnwwH8RL4aFPMVxf5jjw4vyPctmEgeq6C9cFav1QK61BUHUogTNu7fR7tD3s7P7YTGd
    umh202v/qDMvMEot1He1tn2Hm3KFZ+LAyaFnzQXOkeHXORmrw2u6rmRgJQCMfv276XVTfl
    ZgqyQHvLFSGgL7H+AEw3V+H/6UexcFUpTqQUIjdifzOgaKT+hFZa+39Gos62ItcDBO2idE
    UPxV0HHvPSHMMFKPw6GBSKNb43c8KUl9OnIgdFwSByLuQNm6Dd630eB9zLVXbCyGEy+Sep
    JtxT5NhN8lGZZsqqW/xMw4T2ts09B9ajTVH9abRPScUpwZJrDSpPETvYNhnet8Vs3vz4+t
    uWubcUsQy+Ytz2F/NGc+M0NqKKroXgztG5rIFJWCJhx88IvZ1tnOMBHbeXOLpObGI79jRp
    RBSjebG8o0FihH9exj9t2EFbpSlfCCVzN5ExxA/L/5XcRraRjptlGyzjeMj1wLLTXv+frY
    y/MR7HDncPJn6F06po8Gl1i5jS8NcI8FWj80WBV63SWBfEsEUIEefsL2fxOw
X-ME-Proxy: <xmx:R8eqav-gJLZGP_nL6mrkWk3ScqW5SAHmrytImjclp5vgYX0Zru-wpA>
    <xmx:R8eqaikis23TGfEMsbF_VrhwCe2V_itNvZ8snAKd6oL-3RcKyoZPmw>
    <xmx:R8eqap_iU7zJxZys0qWQ5EaJPeSOXNINfIaY7nbemdw71NHapxz6EA>
    <xmx:R8eqaolhucfgaPXTPPL_G5Z08rISsadHLBIiKa-6SaabtnfLM7ybYw>
    <xmx:R8eqatdluBUaIilakGBSW7NRFRGkA1v2S7f-kdIcwDlAFyml3C-G1VfX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Sep 2026 12:43:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Royce Gerard Remer <royceremer@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] [PATCH] Fix upload_pack_v2 response ordering for
 shallow fetch when server has uploadpack.allowRefInWant=true
In-Reply-To: <CAH5QBqzG2BQMotUmwrzUc-m6oXE9C1LZPtRyeFQsCBbcMNppbQ@mail.gmail.com>
	(Royce Gerard Remer's message of "Tue, 15 Sep 2026 14:03:33 -0700")
References: <20260915193009.222678-1-royceremer@gmail.com>
	<xmqqa4piz3pn.fsf@gitster.g> <xmqq1pauz2ru.fsf@gitster.g>
	<CAH5QBqzG2BQMotUmwrzUc-m6oXE9C1LZPtRyeFQsCBbcMNppbQ@mail.gmail.com>
Date: Wed, 16 Sep 2026 09:43:49 -0700
Message-ID: <xmqq1patxi2i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Royce Gerard Remer <royceremer@gmail.com> writes:

> Apologies, clearly struggling with using git send-email for the first
> time (and thank you for the reply). Here's the missing context from my
> cover:
>
> On my fleet of git severs (running Gitea, although it just shells out
> to the git cli and uses this client verbatim), I enabled this in the
> upload-pack config:
> uploadpack.allowRefInWant=true
>
> Clients performing fetches and clones all worked as normal unless they
> attempted a clone with the --depth parameter, where the client would
> get this error:
> fatal: expected 'packfile', received 'shallow-info'
>
> Looking at Documentation/gitprotocol-v2.adoc, it seems like when this
> feature was added, the ordering was just incorrect server-side. You
> wouldn't notice unless:
> 1) the server enabled the config above (I suspect it's not a heavily
> used feature in the wild)
> 2) the client performed a fetch operation with --depth
>
> That's what the new test cases in t/t5703-upload-pack-ref-in-want.sh
> are, those were written to prove the failure before the fix. I've been
> running this in my dev fleet of servers for a day now, trying various
> combinations of clone, with/without --depth, and fetches with
> --unshallow-since . This is purely server-side to honor the existing
> documented contract when these two features are in use together.
>
>> If a new version of "git upload-pack" suddenly swapped the order of
> them, would it break existing "git fetch" and "git clone"?
>
> I think this is a question about backwards-compatibility? This
> combination of features appears to have never worked, so clients which
> were receiving failures would no longer. If servers were previously
> configured to advertise allowRefInWant, clients could not have shallow
> cloned. If they did not have this feature configured, shallow clones
> would work the same way (the ordering of packets is unchanged).

Yes, all of the above are good material to be distilled into an
excellent commit log message.  The way how the problematic packet
sequence is produced, how the server and the client would behave and
cause reliable breakage on the client, how recent the features
involved in the bug are, and that apparently the combination are
rarely used, which would all explain why this breakage hasn't been
reported and diagnosed so far.


