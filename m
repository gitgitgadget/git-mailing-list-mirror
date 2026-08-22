Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E826E49365C
	for <git@vger.kernel.org>; Sat, 22 Aug 2026 17:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787421553; cv=none; b=GgZU05f18hpXMr5bfwic8JxXOq+hxkfQo4+yKg+dNvvgOBtLx2tPGeG+7tdC/XJxhVPnyi0oDQ49GZvDp95qrVc8v4Xv8czdsDQz36W97TwODdgatIM6cZ79H+zb5QTRHruwAh1I0EuW+B9KT4JBIN1HouejKx/d8sOHcwJ0o9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787421553; c=relaxed/simple;
	bh=BEI9ONZ3E4PDX0t5iiOOVd5eI0CBGp3EVbX0bfzyLUw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IjNf/0ScecarzyrA/uR1Mg3U4AGp5B+rUqr1lwLDoMWzRyOuY76xw/r4EW8B95ZojfU8Zv53p7HQaR7bcylOcDCuW914EVeUX+h92IZwS35MwIuK40Cts6vCVpShLBL7ZkXIwlTDya+Us+O2rG/cQMtj53QfdOpzBY6JZm3wPtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Xjjkk9hn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TVV+8Qmf; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Xjjkk9hn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TVV+8Qmf"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 37DE91D000A6;
	Sat, 22 Aug 2026 13:59:11 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Sat, 22 Aug 2026 13:59:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787421551; x=1787507951; bh=UmGZlYRVMJ
	hPv93lZB09Ad68RKCAEf9pXuAQTvlrbCM=; b=Xjjkk9hnP0rog3k1YKVuhOkx+m
	bi++TkQE1KXy2v5iMKAXTOxXimH9PgMw5sxC/YSlGHomWJBe7Z4DWDDrnUgvo6UG
	agXZqlFJAp+ANIPANoZsEMZdLxZXp3PnRpVSJCEvnAvsYsuUEVJSVn+8NYqK++kw
	KyIjTjeq1PoUsSwCvxhDUIH3pE4jC4e5bVHQDnwQ8sItrO5x5lJNVa8aK+mVwXiJ
	NUYtlLv+3gGaHPdITugEsL6roOU50c74JsgEkGCuxLNM+92LAOWYFc2p465p5KaE
	DRCwm85j1wDVIJpeKgUkkDF5ex4fLk8gzxwFPf53eH84iwd10nH79cXJ0jiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787421551; x=1787507951; bh=UmGZlYRVMJhPv93lZB09Ad68RKCAEf9pXuA
	QTvlrbCM=; b=TVV+8QmfFFVu7UtE5yP51ZXpySL/TFPbUV1yBkfdEQdKfJOnBrm
	TCaT75rFh9qM2nWA3NtJMvjfCF0uYMrzUvWrk1pQA3vMZ/54eITDJ8tFWk8gCDAO
	HNvccTQdODUqDX4uBX6sVv2DTgmgR9jSO8l5u9c7bJHO7oCWHDk0VppV9c5dFkJQ
	UXwud8/WruaPpatIWJUAiPaWcNpfIyZO1g312JGDOjxlJcDo/9CGHGE/3lXX0wvU
	6a6iMBGmixwpmoT4QzoCKcaOub0uMjRfhODTGKC3DfVFsfyHF+7wGMf90QXTfL9+
	BISiizT6H7/C5IhXmYplxuiit2ygwh177NA==
X-ME-Sender: <xms:buOJailXx0hZQFl4sqyxeKQpTsMLce9r5ormGCxVf78v_vDaSG02Bg>
    <xme:buOJagvZJxhZqz3ZZYBTIQVG3unUTNFAtrYstFMfsvl6sNTVA6GBMIUT7RX0LN4_s
    BSHjI5XcLSPrduM1Zh6TBsU9Y0UkX9ay4qhp7i51RqgezEgrU7V>
X-ME-Received: <xmr:buOJao_eLVk-9_EGurYg6_x4s9mJ42zShN83LZvZtZ3jRaq5cjL0L_jeaR2e2BPI8JQkqHTK_5tEt_CQyHkrdwNuHRKAsH7CGg>
X-ME-Proxy-Cause: dmFkZTFQkDAENXUejBWhTZNFOXPyNoKDNbxkTgSHnKsQKawC4PS5FKWaHKFwmPwFgRbbC6
    bylPDieIAkPMDIbb/MTJMT5Xp1LqoKXTdvuTKUy661j3hvz7k8yeFM4ljEicbj2EO3HsRA
    dfLCG9iiBGqG6aNhlWBEFr9jSZGtvowUsKdtAFq6HO4xvx7k+1eNsFHlDZT5itBXqXpdRw
    im16/+YgVaudLihAcDArTLOvo9fC3GNACVrHqml70Y4x6Q7xKU1jvqpYjzxK4gaKfDlnfZ
    EWLqgFIDOpWCSjF3LBWWFkGfxr3KwY9jGMdfvxnK8WdKJSSmJV32dMKQZk5+s74vwfeZZ7
    rWT7JdMUN6t4YYudi4nRGBqMj+3nPpiNriiaV9FHlQdnyHVC4aCqqD4DqVBgYNccuCYRdU
    fIs/n+NHz+1q7Dc3SAyRruPD9jHrce4+4cez+VRaYBZqbxceZ/BFQgBfiWJEG+ldlMg/Qd
    1coR9C7sHZokRJKdxEiHCbDLjVGH/tXVT6ccrTdx+KaEDTBMSYwajBso2ZgQWsmjszx35n
    TSqDAvwzOqxElUUEpe3nDljf9P68FKbrv09teXbmFraosMM6afa31Q0mntmq5x7ukNpDe0
    oUOyAbD2qPzndYEpxXhoWkZEIp1s+R+daM600cdS61f1y21vkfY9+TtAXH/A
X-ME-Proxy: <xmx:buOJaiNn8eEXat58f5HuS5fayjGJ96bajiFLPWNeR_vReqFuH2bbXA>
    <xmx:buOJauEYzLm0qCWPQYtD5SEKcThusrOu1Sy0z4SRLy_jFD0bMFlHyg>
    <xmx:buOJaoQXqYuWYzFRRvVYUJ_yzCTjHXG0k4R9QPUk309SeF99Dcl07g>
    <xmx:buOJajvjCN5EFL7Ja5rcl4S8oO8LmzJhbCP6D8eGqLbHKWydeROdYg>
    <xmx:b-OJal-p-1WD7S9kGy163JP2fAqlkz90pt29uJayqgcFwrByTEEMEzFi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 22 Aug 2026 13:59:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Alexey Samsonov via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Alexey Samsonov <vonosmas@gmail.com>
Subject: Re: [PATCH 0/3] treewide: migrate from legacy utime.h to utimensat
In-Reply-To: <aonIVn-ZQoMKWCAd@fruit.crustytoothpaste.net> (brian m. carlson's
	message of "Sat, 22 Aug 2026 16:03:35 +0000")
References: <pull.2209.git.1787322203.gitgitgadget@gmail.com>
	<aonIVn-ZQoMKWCAd@fruit.crustytoothpaste.net>
Date: Sat, 22 Aug 2026 10:59:09 -0700
Message-ID: <xmqqzeyeujde.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2026-08-21 at 14:23:20, Alexey Samsonov via GitGitGadget wrote:
>> This change is generated by Gemini Flash from Antigravity, but all the code
>> has been manually verified by me, and, where applicable, adjusted to match
>> the existing behavior as closely as possible.
>
> Unfortunately, I don't think that's allowed.  From SubmittingPatches[0]:
>
>     The Developer's Certificate of Origin requires contributors to certify
>     that they know the origin of their contributions to the project and
>     that they have the right to submit it under the project's license.
>     It's not yet clear that this can be legally satisfied when submitting
>     significant amount of content that has been generated by AI tools.
>
> I therefore haven't read this series to avoid being influenced by code
> we're not allowed to include.
>
> [0] https://git-scm.com/docs/SubmittingPatches#ai

Your stance, as I understand it, is that Alexey's DCO is not valid
because, acting as a copy editor of Antigravity/Gemini's work,
Alexey cannot possibly know where the code was copied from.  And we
cannot accept work that is not covered by a valid DCO.

I think that is a much more prudent attitude than being cavalier
about legal issues.  I used to think, "Hey, the person claims in the
DCO that the code is appropriately licensed, so if it turns out to
be a false claim later, that is his or her problem, not ours."

But that is not how things work.

If work submitted under a DCO later turns out to be based on
something we cannot legally use, the submitter may of course be in
trouble, but we would also need to bear the cost of ripping it out;
the later we discover the problem, the more substantial the effort
necessary to deal with the fallout will be.

Stepping back a bit, though, is the situation really all that
different between a relatively new author who discloses their use of
AI and another author similarly unknown to us who claims it is all
their own work?  Either way, if the code turns out to be unusable,
we would still be on the hook for participating in the infringement
and would bear the cost of ripping it out.

What worries me a bit is that there may not be much difference
between "you said that you relayed AI output, so we won't talk to
you" and "we do not know you well enough to trust you, so we won't
talk to you".

