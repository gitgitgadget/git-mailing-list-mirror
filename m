Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562C33A4513
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 20:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782766535; cv=none; b=hB6oRezSWp3mCEgEs2cwuP9i4n2pOeaAdKIcDNOsIGxFhKIL12fxMofeD8fH5uu3jnBdOO6ntmg4uiiA4SypcoloV9VV3s9Ai4D4m70U5VDqUQ5APVOK+yizGzl8nVlj7l73XTMdKR4iPdE1VJPoKOjN87YNVkkDBpvu/UWwrjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782766535; c=relaxed/simple;
	bh=zhQ4sW+XVE/liFBsz3Tsnec7RJJXHOI60J0nYx1K5IQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q4zt9Kdg1Tc/E0kz7h8KL3B28iRL0AufoHDBvi8Tl6kgw7L3ieScISbtbHkNk2XC3+1Y5x/J6efIhJadPr/yoEOu+aNZFugd/9bsAp4lk/mAXHXkADFQjI5rWKB0tInEYcY1umcQmHaTaGTlgiFJHtcXjSyWmfiAua2rXEjOJfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cP692sBj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NraAULU1; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cP692sBj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NraAULU1"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 7A1A31D000E1;
	Mon, 29 Jun 2026 16:55:33 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 29 Jun 2026 16:55:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782766533; x=1782852933; bh=g0ayjqIVp8
	5iOGgVQO3lBiSSsDfv3diBh1fOEDtJ6r8=; b=cP692sBjsx4VD1Jyve61jvRqtj
	DIaIYddn3GCW3RPm+2cGVoaZJ1E9ULsOfZ2A6V4a970Ht7KnSLWXkoli5v884QsZ
	Aw52GaZkZ7IIRpuxCk5XzF0Me5njRrC/PL9NLrW9KArdtJHxhOBuMYHLb9d/ebnR
	9KGtynGdULarm3QivE5b/TVhW8dqrn1lwKIe29gHaXCU48QSa9/i6Tih4fdiHW1+
	Kh97wwitg76zY2jNTUaQ83bDIt6+VNgFr8l3J7qt0+mu1gDBTlMu0/i03r+LHkgO
	BU8ENkZWVQfYMJrSKKH/1TUuS4aX0MnnQajLQVkKJNeOhl5rPvMbERh/Z7Aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782766533; x=1782852933; bh=g0ayjqIVp85iOGgVQO3lBiSSsDfv3diBh1f
	OEDtJ6r8=; b=NraAULU1fVjDkMajGMrNJDRuF6pCDVnH5//h2ACOUCU58YXszt1
	dbLhZ/AFB8aTJIWZDqHjb+JyMQKofMeCdpUMhUjBIlwohZJu27sy3F9QWW/0w19m
	fl/K3YRjs91ty7O04MdWfE8kS5pPCkH/p2aaNj5AQl6lbOVFRgQnQQQ1U6qOEdmT
	V7Fo8ouGFaI/T/yabt3GYDRq+BboNc8sHCa3NwgmWTbaJohlacFderf2O6BqTbck
	ux0gV1p7Nn519IyMtrgDeoKh/WKErWKwt+DVDR3BBprBARzl79YKaVvhqyZBNLuT
	qSZjOKqmN8UoHFtEF3r1VWYLzkzBkCXnkKg==
X-ME-Sender: <xms:xdtCakVuuNeEh3e-y0QaukhpXz8eN1cBliYkGh0AMvyjms4rrspMIQ>
    <xme:xdtCaq31AgkF1bAu9roBS1lGMLPKox5rTrJP5G6pydulV3KDUaJZHqOts20pkxRTS
    cV_zVcjDKdq02f_FK2abmNWbXocmk20semqDMXSfHARnSHQfhBtQw>
X-ME-Received: <xmr:xdtCaqrku-sKFwZJXl8FQGpwBJvchIwYBYh0rmrOaAWxpaptM59CT_4M9UI35GhGzAF6ANwykGSFf4fNsYao4cRONZSU95bMSHqMV0I>
X-ME-Proxy-Cause: dmFkZTFf0XiMeE6yr2dZ7Q6Pfxan0aGVTKz7/910xtG1y5CLSK536NIVmGOUVsaHB1kdAK
    1I/S3rOviwgNyxOXDcseHTN2fo8HtWviU1hiWv/QYv2gGpZTcKYCWvrYkhGnRQac6Zf8pb
    swmgF7n2Z+jq0aktZ0DJp+86P6IyFLgAvzcsT5GN0jjK+zdlHLr5iNvIpLrHc98S5KTicB
    XiyA1IeHdQ54mHFQEfsjklNh1oYCxUWtfljgZ8ZqCLaExMIP2Em+R4HNF3axrXAKZOZ2AY
    Qs+pCRx/NfDlzbZAYMTtYA/aKDdXEiIXor4SA7v/s3d5CvIXMj9b0Y37zjVl/2zUGegyd2
    HrepiJm5xAM4G3+6nhCR4JlP4F0ggoWhfdiQ8Oy+G7oDTwo6d0ZcARi4VtElWSXRC5Qyhe
    V8elXb8ihrq8Jpni4g//piMY9xG/1bQLRfBVG3MJhVBMjnI05mW0uBrEUyXrBCy14ZvCg7
    HQXiMYn+LOW1aN5Ij74RJcMW35Q0PuRfer0uJmf2m0t251+RxjvQs6yare+nvRKZ6eK/Vj
    mt/G7NT/Iv4AQFVHg7t7btJ9NiTeQbIFbfbZHqGeL/fjXBh2Z2uXWvHS597jgrq4H64OmJ
    otSFDoUXqCGAfkjwmfwoxLg+u8FdaHx8btK5JpuqTvM8bj03vci7XQq9ErIQ
X-ME-Proxy: <xmx:xdtCapWG2PVRyNz0kL6SrNqVBQnKahPLE9u5rGD5nqGfSfAiRp4BNQ>
    <xmx:xdtCatb_K8UBj4vklZlkKgYPHofEHOnSBhhZFMjUe-8O8mP3KisLcQ>
    <xmx:xdtCaueRKzu1piilZZ75MqGA_k8I9pWgQZOekVV_yqCX3Om03r_8Xg>
    <xmx:xdtCav0EcZ19q-asLe1iHKL8e3cEVJQSB6gb9_aKyzHw9Vwv02lYQQ>
    <xmx:xdtCajCQb9E1kz0l1sRDtm5rwnul0XZRANBxnsS0gc2sbqpi5bgdweNk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 16:55:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <cat@malon.dev>
Cc: git@vger.kernel.org,  ps@pks.im,
  Christian Couder <christian.couder@gmail.com>,
  Ayush Chandekar <ayu.chandekar@gmail.com>,
  Olamide Caleb Bello <belkid98@gmail.com>
Subject: Re: [PATCH v4 0/3] environment: migrate 'trust_executable_bit' into
 'repo_config_values'
In-Reply-To: <20260619162105.648495-1-cat@malon.dev> (Tian Yuchen's message of
	"Sat, 20 Jun 2026 00:21:02 +0800")
References: <20260612160527.167203-1-cat@malon.dev>
	<20260619162105.648495-1-cat@malon.dev>
Date: Mon, 29 Jun 2026 13:55:31 -0700
Message-ID: <xmqqcxx9ukvw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tian Yuchen <cat@malon.dev> writes:

> The 'core.filemode' (stored as 'trust_executable_bit') configuration
> act as a core filesystem capability flag.

This unfortunately hasn't heard any responses since June 19th.  Are
there remaining issues with it?  Or do people fundamentally have
objections against this change?  Or things are too busy in general
that there are more patches than there are folks willing to review
them?
