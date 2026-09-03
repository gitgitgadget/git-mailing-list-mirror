Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31725448CE8
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 13:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788442978; cv=none; b=clCpwDwvK/jn+835sQMe+4sCE1pX2hlDUm1usF8E9EpHn2O/wnvilZplTXDtY9fCkuL7GVPH1wcE6+DoJkXZ34Jx8IhM7G3iPTV93NO8irqcbEC3HzgkP1rDo/DtUp9cwC9EJcz8pcL/ZlUP7kr7o6ijm1X2SreBov7Iyp/Cuyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788442978; c=relaxed/simple;
	bh=SzrLvEIWdaBm/m3bVV2UyMGyrWnlAhB01GQGD4hEqcA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Yu9UUQ3d4Uih+Les9EwF5ilH11r2Yjbch1mN12CmCoRV8zQ/gQLnQhGvHA2uSXwwFO7Bg+wugSxGX1s9XPozaEUTo1AmijVJK+QmHiOs1/qSJHhyhOnVAr2ogDBZGHpk0wNE6zY90GiZQipSx5Yl12O9S+1717jLxQAnLLecJAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=s2iOJuLT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gg7c/6ih; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="s2iOJuLT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gg7c/6ih"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0B66D7A00B4;
	Thu,  3 Sep 2026 09:42:35 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 03 Sep 2026 09:42:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788442954; x=1788529354; bh=+65v+V6BV4
	EYVF1nNPStoqZP04svWQesKdO5FTxoT2k=; b=s2iOJuLTZove2uEH3zX56BT3In
	jq6CaGxO+vasIB9bGSCQssA/JfbXP3o7kYCQAoHfj13T5s4KCX8dNLuaJkwe8zif
	6BXMBgH50YSfME8nqkO1gBmKxZFmYg8HLqXyZxwZoIjwyW2rFYeE6OyJnc3opBrm
	j5KxX/6sMa5w3Ceuf8B4s3ibdqqoyj2K4YJrepSBlwDh7/KCLW2opSPVRO9YISDY
	e7ZqCknbe7Vq0XFY7I4TNyXpXyJ2NGWA4IclBDjd2xI6kb6571LsuWbk+wSjzJlH
	kaTlYcIICnuA535/OmMLFG9f133QGmmWMZvDwdF9ax6YtYJ1g23jz95RVdNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788442954; x=1788529354; bh=+65v+V6BV4EYVF1nNPStoqZP04svWQesKdO
	5FTxoT2k=; b=gg7c/6ihbYYZrn016JL4S/0U0qWfsavw3aikJrwCVK69mKwjdQ4
	XJC5ry/2/90ub4T4hHWhf6ZCdw1ezeWhu1ArB5+Oj5Rz6dqifWFLTFl+gvFiHe10
	0iVVRlQNwYl1MUn1PtW6/ahoHsbnWQNALeZ6Xzdea2o/aUk5dE8ceYs6BqMGvIpj
	U8yEJfKvzeMarF5EEzvOiIiqaqckHY5/Gi+36XiAEDdLqMnDXJIzsp1smwUBUyOl
	8naA6JpPYxbuJI145IDLWrcaOMCL2IhuHedoet6b7vMUvxF694g6mSB77EBE8mU4
	BVhGFSssfs5Ip12zExFX54tccrIuky4GbUQ==
X-ME-Sender: <xms:SnmZaixpNKyN2SB5LvBuBe-W3DGuXlSeAlwE44yZ98aMP2zaAIKXbw>
    <xme:SnmZalQQjeg0UMpw9JZMFEYkS0zX5FwRSZue2fPWD_tUmLL55AZKeLTKAu0Y2GFz9
    5T_yMYd8tpjzsiGv92uGlZ8eCrAQmzQi_b3rKBhm1WXW4hzd9uAXg>
X-ME-Received: <xmr:SnmZapV5FRSd8cY4y9cSlxOvOK6S_OdCINkmg4tYZEDqaJSWyzkvcuWx4R2YB9OegUkMaK4K1UKx0e531zqtmWps8-6AJW46qg>
X-ME-Proxy-Cause: dmFkZTFhRQtgPPm2tPLL3HMrF3NkbOps0BvbPfPRm7TwFx6I5cUmGx49MV3IQIzchwW312
    RvY3gWTQ0ZF8AC//99HXwLMvQClfa3vgrEoSFD+JJqNi3yaoOwAfYTUG66dPfUB6UjB/as
    8NbDdx23ezpeItnAO8MC38KkyBlMNOkG9W859cM326xSu8H9TAmDCTvxtQYvg9WR7hWlvv
    RoZ6VKRFjwMIQuh+PiNrmlg5NOGAjbkKjvNuLiJrKVxjDG1NJuML8JpVBybVZ3qTos7hwr
    BpUUJmIHM13fqS9KMCZzT85NtKMgfS12JX8Cl3KGhMe13KpgbnHhuhiLOHGF5UvWEYfAHW
    eCTzjYih1O2ipdGTf8KqW0wu6q/rbGeMOG5sol2RlEZ8BvzVGafLmxmcY5L230IAeuC0Su
    PJjkqgeiDIs0VPVx/JeSmap7cTAaG+1fwcgDAr3jXPXDuRv5/wCnCbpYhPc8wEt7afJrrU
    NYekezpApIAqFTwdRDE7qZdsjtCVct/PyCZJy/OHq2s7QHCvtNbFCmYvOnRfb9bkhRznof
    I8/Su1GC6+sEFuZ3PSfmP2d19M3blLPSfZOs9XNwiew8q/QozKkfYPRSKJ4GCO5XBtRToa
    eTFfCcfCBvIenf6XTc+HmMbtAZMkU9wAkAbjX2Eg31prkA/pnauNBDQKHq/A
X-ME-Proxy: <xmx:SnmZanaw3PzP5hxJ5EewcOp_C5PAyd9pmBcwORjwHZDJAT55Hhe9Nw>
    <xmx:SnmZav1bip5RO7HN9bdIVNSgQF2Lp4Q8aYzz8hI6rSVVpdaEpcZyNQ>
    <xmx:SnmZapjGYFFpJavjKY3Y0fnk_0u_sgvq5J78djci-R1hLs7CcFK6ww>
    <xmx:SnmZajYyrAQSPaGVRGSuF3sdCt7VFG59YwLZOyuMJPpb1arNZIElIA>
    <xmx:SnmZaqctrZDYFI2NQVF-tn1pmVUyToQMF_MclnMWf8-jdZM3Z5S4bSJY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Sep 2026 09:42:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: Wolfgang Faust <contrib-git@wolfgangfaust.com>,  git@vger.kernel.org
Subject: Re: [PATCH] imap-send: add --draft to set IMAP \Draft flag
In-Reply-To: <MAUPR01MB1154649CE9D154B98459B09CEB8B62@MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM>
	(Aditya Garg's message of "Thu, 3 Sep 2026 11:12:50 +0530")
References: <761c3f1b-e280-48b1-a2ad-770b68be3434@slotpi01m90>
	<MAUPR01MB1154649CE9D154B98459B09CEB8B62@MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM>
Date: Thu, 03 Sep 2026 06:42:33 -0700
Message-ID: <xmqqfqzqfo3a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Garg <gargaditya08@live.com> writes:

> I'm not sure if its acceptable to use newer versions of curl.
>
> This patch was rejected because of this reason: https://lore.kernel.org/git/7108764f437a25079c95a25c227eb79f9f4aee6a.1753273554.git.gargaditya08@live.com/

A huge difference is that the patch in the thread you pointed at did
not come any way to build with older versions.  The patch in this
thread is different, isn't it?
