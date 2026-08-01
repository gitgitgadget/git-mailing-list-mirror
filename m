Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E7619DF62
	for <git@vger.kernel.org>; Sat,  1 Aug 2026 17:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785607091; cv=none; b=TzhU82fbleMPGfwZneaO6uuPIMd1HEVZ4Tf5gXHVFtax2NJUO8jj41pRT6x9MfmVkbkh3c1NIbN+MahquPEVH/G3yZBEccYUDnv5o5igW4Im7GkBIXnRwi/IFQMz8cDZE92M+YAsUiLJwgTEDfsRnwC0K29t4gEo6Biz+ARKYOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785607091; c=relaxed/simple;
	bh=MolC8qGVmG11ZtFZyTZv1XIE0Lg9UCT+wCiUgPMCfuE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IbCwtArbGkLUAWd11jyc66I7wlVvh1O4zlFX9cx+BMC1y1D5qcRt5wkvPnPXskq11r/IHZpZAxpua+fRw2sSdL+kg1mT56IfprhpaYNb2fjLx1AMhS+JcL11PtQ6ad5BlyTR99eO6dmmYnNXN3GBGWZzaAumK8TOzPnqItw5/p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Z5x4/F/r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Yb0uN4n6; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Z5x4/F/r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Yb0uN4n6"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5C6E814001A4;
	Sat,  1 Aug 2026 13:58:08 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Sat, 01 Aug 2026 13:58:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785607088; x=1785693488; bh=Iw4A7RvHht
	rTYDElNxM/9Byfwgl+ZVea5pp083NgiQ0=; b=Z5x4/F/rGf85vq07lKT6YlFqFQ
	Prhm4KoOzljxLQDtdU4atikSawFIkeaONkvk7/HuXxcoWO/ZER8c6LLVjB0eqbJo
	eNHc4eCJKqOtEj717S1OckaTm8cn/P3XqPBw5OrhxMJPRXzGAYfy4dnlUBefvHoU
	0Zwa8S6T5pCphpnzexY8Nit0X777nrFTwUNVrSxlc2rw/ZZqy2nMnqDn9Sg4gy0K
	CSKOAY0QpDA+rzJGqd5HOCJYE7I/I9TpylyqVhfEZSFksnqW6RuVzLLzQBkhgx1j
	VXSErNMCAlghyhrzRuJYIBmVC+V5T4dhbCiavdEFbOkwz0JG3Ia0YrNVe/dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785607088; x=1785693488; bh=Iw4A7RvHhtrTYDElNxM/9Byfwgl+ZVea5pp
	083NgiQ0=; b=Yb0uN4n6ucBMK8elOeAACh2PQ2oqHZRXxgt3GlPUmsnmTLbpc4v
	S9cqQW4X1nvwmRwLbgdlF4HjGB4D2B46VNTMQ1Lfw+zFNzLFOIr95PhbPiOKMY1Y
	I5mEpre/Ql+77FjBHweCfxoJRt1ixXRAH1mG4pTVriG5oARB+TAeiSOTqlghtUO2
	uNToAPm3KynoVHDpzJCTPU1VeVISUWfo8bfXg95FCtiGoyV0ISruVrZtJwOE6Ez0
	yYHUx9swqpg2hEqhavQP3HQap73LxzkifIHCjiJAXSwUnmruVM1qAy/yzK7pACFb
	e46XOXRezJ/XdptHNC1MW4IR4f6DboTweww==
X-ME-Sender: <xms:sDNuanw4gmM3gfV04oSusVTGD28btFwIbNImVrIVRTFURYOGwEpTLQ>
    <xme:sDNuamtsU6nhi5wQnj_5wSvb1wmlc8ftOuke5ybmlaPn8Hx0pZEcJJ1JErX0qI3X_
    c8ZTHZ4UK318NMxIwSO9Fd0UWwp8sBSl_SdkWjP11dNBJCpuXR6lnw>
X-ME-Received: <xmr:sDNuautTD_1DD3gt8oRsxSyl6z_mPTloQ24aLqvBF7tGGPuXHr5dJaDKuMavjPsKxz45ndmWK8UID4D1KbgotSUufBRC8axabQ>
X-ME-Proxy-Cause: dmFkZTFDCDmYhrpNAJ0nkFPkynI1XTZJ0i5cJZOSx4CjI5t3+WyUyOvg3Df8JKiGWPsPg6
    UVBSh/YEiLXi8jmJVSaDwC3BpY40fJZwBRS86vjTdt5/zdm7CEDZIbVYfL5moI4QQsNsWb
    gxKk6qKwxHIPJxZzt8no4JYzPo0NRY5lPLOL5YyIBUB5a+QsZNp7AQ2O7Uj6diUmVn2ETR
    pVN3KVWtaKYKUL5L97F+IK/+ps2I05tXfLZx0F4xkH4vSkDYztxM5jUCC9G1K8/JnGlm4p
    Wm5/lMFn18m90/YvHob/MQDvM0VkVdnjgdqqaSHjzqshn9emqErIwMnQpuhJEmhsy53vUq
    Pir2f4jok8PKJWyFhsvc7aUo8tXUc+xU9AAc+N1LICY9ZFWY4KreNGc4nWQuC0PuZqTfQG
    ZrGuTLyDbxPYYtTeWEw57hA3ZI56Mc14B3uX8XlCJFnhKQ+Yn8EkKCCV8ysberLfN/Is/g
    kciByJMj6F5lGx1GCwzk8zVzVkGIeEghGvCul4Lm9DnoKqfLaxYygyz18rtypkvIS3SwoS
    fhpbLrahKaE5u1MMzfNIZMW3A09ALpKmXgmzLhAs5z9dBHWJleL0eTxRHMSAvpri4PuFtL
    GSxXiDOGNVfEWjjUSDcurp/20CMzBDEowuKZ9+Ds9fxOkeBn92UT/fMJbWFA
X-ME-Proxy: <xmx:sDNuarNgWpRl0fq9q2Kn-_rcjdn9QZsKOMYdS9sfwNKTguOAKq08zg>
    <xmx:sDNuas15wSb5WRCI3272CO0sb1pzBuaR8lzjqyco8YAWcNSqS5g9eQ>
    <xmx:sDNuanOLXG1iSwULndRB7XvqY3lcJjLmURFi9XwaKg6cU8kFf5RAjA>
    <xmx:sDNuas27h2uDJr6pCzbPgm9zGivUu3-9CTtye3apXfEkCRrdV18-6Q>
    <xmx:sDNuapdwU0zglmQlH5xUwvI_j2cZ4QHOXTwT_aEFeYOJBwFk5ajmonGx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 1 Aug 2026 13:58:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 0/4] git add --resolved
In-Reply-To: <20260801141414.GD2041176@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 1 Aug 2026 10:14:14 -0400")
References: <20260728215219.753678-1-gitster@pobox.com>
	<20260731125605.3638938-1-gitster@pobox.com>
	<20260801141414.GD2041176@coredump.intra.peff.net>
Date: Sat, 01 Aug 2026 10:58:06 -0700
Message-ID: <xmqqv79t9101.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> That doesn't seem too bad to me. I was mostly worried about (1), but
> after digging into it, I think I've convinced myself that it's a
> non-issue.

Yeah, our merges that began with "read-tree -m -u" have never merged
into a path with local modification in it, so I have blindly
assuming that (1) is a given.  I think "ort" did not change it, but
quite honestly I do not know where the more recent invention that
renames paths that existed only on one side to follow adjacent paths
that were renamed from the same directory guarantees property (1),
so in these new code paths my assumption truly is a blind faith X-<.


