Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC56156F45
	for <git@vger.kernel.org>; Sat, 13 Jun 2026 03:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781319714; cv=none; b=Zf2K+ye+4eq9Gtbg4+pKYfEVCsfrL1o7GcN+/Ctzgk6wWusdn1NqmeWcLoDCCBmeryoMGJ5P3yv1RoXkd08X27RzQk5cemaJWjtLfr/0L1U967EynvbJE2c/o0sPERtrqvgu/f8AZsFj02AU9smN+2sFIg8hO5yPvEEKt61GjXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781319714; c=relaxed/simple;
	bh=GewawWoaAyJilpxh5G/y5IhpXKNksgwr4rz5b2wjiAw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ABLQLrWuFwHxpr0+M29my6OWMrf9jU8pwspXG5Ck3NHhD6B8tBVfmf9Ee8skQEN+G7MRogmiWiyGI2V0/V3ocGoCQy8uYiRFx0YmSL9FFEXBmeB1bsiwWdDRug1CzU9YwWwMEiULSGCiTu4EeLZMRHjdp3TnDpl96vOp6UEhIDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SODFftGJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ap7CggNF; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SODFftGJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ap7CggNF"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 746A37A009F;
	Fri, 12 Jun 2026 23:01:51 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 12 Jun 2026 23:01:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781319711; x=1781406111; bh=pqVLryWEp3
	ILunfds4pLh0XT2shbeoQIdFeh5a0szRc=; b=SODFftGJtIhWlp0BRuQV6mAOAt
	Q0CbwfjWKVFYeZjsiZsSKYasg6Ac1oeCtES8aIKus5dYz9H7/5CdRoItPSTRS2Jc
	ag+7FwjuAQ1oarX1hcbmLZo4M0yCJno3/w2gEoqCkA0FvAhruVG5XO0Tr4T5lUgL
	6W7zvnWgOam9b33gpPT1eYpF5IdXworhd7hT/VS2mwHJwfn2nx0oNjv0i6ayz0/v
	lCJ7hFMDid/OOhi7vAbxJsEYZvO+FFKTA6AZTucBtHS229THlUb+5vmgzsC/qAfy
	bgkzUQKBaYAZOsVyQfZAk24Y/uFh4V6AyCYT7cSGsxoQo8sIiywI1C6Cwa3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781319711; x=1781406111; bh=pqVLryWEp3ILunfds4pLh0XT2shbeoQIdFe
	h5a0szRc=; b=Ap7CggNFcODW3ZreYud6D5+nFi+P6G6OjEZ2fRKRal2wJdXGxuW
	WGPGuqx7kIsbCB/6V+Kp9AyW/+IRE2wIeJQ8FNmSqA5wBD0i64ipFIaHS82SxsFO
	e8ZBkOmQ2QAogakldfSSLD3cTRhzhvW1Btm/O7VGghmsy91JgU2PUy3NLCgPfQBP
	KuaPhVA8VixLiIMLSWETDoINblkD5Ps54KQa9duc90n/i1LvEbSOoeQgchba4834
	MoWJZYRTaaONdbMmxxDj/0reWYB0zdvM24lGcG14dbBbIHGUaxwx93IaildC+RdV
	MNP6zPqlV5HC6VA/OXcctOFXUqEy+gLYf/w==
X-ME-Sender: <xms:Hsgsav0DjUaaj3bX8b33tZBqv9uA_n0uSB5_NDjypp24SxdSk-LncQ>
    <xme:HsgsasWGVDHk45ws2nPn2V48l4oE1oMhuMna7ZBUJFigRY-QdDcrXq-PAMnib9xra
    bR81jz0G9pxuJGgkeWEPPbVHYkQw9OzBaN2ZGADHEsDpILd9UFx0Q>
X-ME-Received: <xmr:HsgsapOj_PxFaVNJOfemY3slS-7Het4xITV7XCvfWwBuqD5LcDPb27s-yZzZVRJp875I85phARqW1UDk-qd-xu9SYop5S6HeRYd->
X-ME-Proxy-Cause: dmFkZTGmxvJBDKlSaoenpZmSOgg10xcaY2OnDAatWHEgnfjnbZXZZeECXz+tgLJTZX8rak
    L1jjgUe0n98eKGXacAP+G7G+5SE0036Vj2JSMr0w7F0FeeTHzRcF+sazG81XmqcW1OGn0K
    BEbTr9ixehzV050WSZiwcYtoPkUjHjJO71Slp5M7rNTk7Mqf14Nw1gkoMZJCFrZ5OkC6QW
    O/dAs9OMnFvsF/SVgs0n9LTVuqglGGKNvM80YICxA0lTfMVwut5f+puKaGFsrlIRbun9nX
    4V/9oD51/8GTcyezzffC4x2kv0XxZGr3P/TBx5WujTsOfLijz+3yPTYzzJaG/pyPxIJUV9
    LthosXBYFXSx3QZGPsj66+/3VgyowKJuN1yxN/875fwupo873pWHMXnNJY34guz9jrjRRD
    I53436zKsAxx3ajp1uY9gbZ3m/WpUdEvOu9XnYYr9BpFVCarsJ3/Xot1xSWVrWZ/cEpL9E
    /jeDfE74/1qJL4+E8kwkv/1432WbvRjMHnYR+K2WNntWplxJihhZCWIBF2h+gTFI+65417
    ouXutSOW0RRJDDc0LnN83uiP55JgJgBeByp2KXTh5LjmYl8PfSdfkQGQXxFvTuVROiMfcG
    Urj51uY0I4zycxCEWypfz0lP1pENwuD8DQEgkKLYrF+OZKmn+nj1qRFDDQYg
X-ME-Proxy: <xmx:Hsgsan2K8O4fUvbqFNdQzySf8cPO2OuwVYkw7GAnGdC2P7kAbonoDA>
    <xmx:HsgsalRg3rnTiy78WNyOu0f8EdwxzH0FoBoJuL3TX6_lLymXajT9-w>
    <xmx:Hsgsaqnm21DP8i2WmRnf4JupX7I0hxZhfITmDZ0RxNTq9EyZSJDrew>
    <xmx:HsgsamNF-viRYq-6s3YbsGQdQenzFaQwPuCUU32qttmIzWMdbqPeYA>
    <xmx:H8gsaiRvbSYhsaj-pmqE1DD4V1c8kUR5d35XPI432EQIanllPi3XmrwJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Jun 2026 23:01:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org,  ayu.chandekar@gmail.com,
  chandrapratap3519@gmail.com,  christian.couder@gmail.com,
  jltobler@gmail.com,  karthik.188@gmail.com,  peff@peff.net,
  phillip.wood@dunelm.org.uk,  siddharthasthana31@gmail.com
Subject: Re: [PATCH v4 0/2] graph: indent visual roots in graph
In-Reply-To: <20260612-ps-pre-commit-indent-v4-0-e8492037ebae@gmail.com>
	(Pablo Sabater's message of "Fri, 12 Jun 2026 15:48:29 +0200")
References: <20260427102838.44867-1-pabloosabaterr@gmail.com>
	<20260612-ps-pre-commit-indent-v4-0-e8492037ebae@gmail.com>
Date: Fri, 12 Jun 2026 20:01:48 -0700
Message-ID: <xmqqwlw3f8ir.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pablo Sabater <pabloosabaterr@gmail.com> writes:

> When rendering a graph, if the history contains multiple "visual roots",
> actual roots or commits that look like roots (i.e. have their parents
> filtered out) can end up being vertically adjacent to unrelated commits,
> falsely appearing to be related.
> ...
> [1]: https://lore.kernel.org/git/xmqqwnwajbuj.fsf@gitster.c.googlers.com/
>
> V3 DIFF:
>
>  - Completly changes the approach to indent the visual roots instead of the
>    commits after the visual roots.
>
> Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
> ---
> Pablo Sabater (2):
>       lib-log-graph: move check_graph function
>       graph: indent visual root in graph

The new tests added here does not seem to play well with
linux-TEST-vars CI job when merged to 'seen' or 'jch' with other
topics in flight.

  https://github.com/git/git/actions/runs/27445164550/job/81128391150#step:10:1779
  https://github.com/git/git/actions/runs/27445164037/job/81128386244#step:10:1778

I suspect that these tests are failing the same way even standalone.

  https://github.com/git/git/actions/runs/27447146727/job/81134594264#step:9:2136


