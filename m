Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6622347BAF
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 20:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786565919; cv=none; b=d9665d0KdZuWjX8INHzCNQRHni/HmRKFufkCeF+n+2yCRBdwc9DydEytKQ9+BbCxNgfGzxM8RnJpdb9JFkjw8JeJ1/DJnVW9/jmHlQ/mzvsxPw1hWtgtmss9FAjwiJPVNokSKwJbea2a6X/WPVSddUKyRwgoDTV2y2dZUS5V0tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786565919; c=relaxed/simple;
	bh=tp2Y+mt2bK6507NqXuwEJHPbqSNEZcz85TKrl8Hdo1U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=byyQNpDUWSKM8p29xLz0I4v36aenekzQPSTzPm/xhuqpVjlRjZ6tEcSEsFUwApMdVWdN7LL+/cdAgoLxzEejCKttUSypZuo8tfU0jHIqwJyXhD55OHNqyoPXapH76A4DE/2B5sFCw/7YO9UAuauRoERKZanYmLXDNSt3davRK+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Sdq8Wk/1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cfHdAe0n; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Sdq8Wk/1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cfHdAe0n"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 113027A017F;
	Wed, 12 Aug 2026 16:18:37 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 12 Aug 2026 16:18:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786565916; x=1786652316; bh=tp2Y+mt2bK
	6507NqXuwEJHPbqSNEZcz85TKrl8Hdo1U=; b=Sdq8Wk/1Efm74k3DeHXaJ89Y32
	94yhnANYaOP113yAOVtyCfsXjdzinVyav3W/VmXWBMC8CDhXAUg/GMtgSidu1z4c
	EvnHFVh8zgHB7L7Tk9jbzBRfR3j3d3NliCPiQWBZWdXMAamPnFhJxHSuf+sExcWu
	1uk9i5/vJaHWviD3Dn9cxIUfZWspQK+hvdYJjC8EfVz98RfaMWt31H+fznFLgIic
	HdhYE+IxI9N70NyiZQ74fFDuYnw2XXgOL7YyokFKNo7GTtL067XBv9Lzy/EnN5vF
	mpOX97sIZeRoWs/qrPy0hbsZKU3jFF/XWKY/7bZ5AljSc0y3ibD+wbJ0LzRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786565916; x=1786652316; bh=tp2Y+mt2bK6507NqXuwEJHPbqSNEZcz85TK
	rl8Hdo1U=; b=cfHdAe0n9LKlomPm8O0tPN6XFpgMyhE01UIg5AYAYn8eOqMu/TY
	F1EeAbevMO6/jTGgmtpBp2BizthL1WJuiTiEcS5zTu+MstLw1y2lrAGL+PIO8vkX
	VaGPGH208twsgtPDqtM7fOdwOosaIHSRoGziMcwBcndQnnUMqkw6idsUQ3D/TfBg
	ZCElN3CT9tXB8SmtRu9IJNe3TncNmC1GR7ddECTTZMA5UIEW7LZGSxoK3z7OSpOQ
	jxdAd2PamA58Bj8/P7ohUPexspy25zkaleRBhZ6jaYeRBd+7uSuAtQ4mrOukifga
	Q7rK2XhYbBVmYS8XnmkA9sOvB4qu0rb/V9g==
X-ME-Sender: <xms:HNV8asUhlJnuI45oZxx30LYftmtab8i5i2_zYCrZVv3ZqvOdb1hoLg>
    <xme:HNV8aoBW1yM0P1V6yuvD31jaeuZIN_vHyVUdP55cDQFM67RJtcynrCyKqmhKeZWn-
    vK-YPFoXul2v8d23sK01YF2F7SgSi0zbf9Oeh9LgYBif8HyElW-wnE>
X-ME-Received: <xmr:HNV8atzc5Kyso0EEHjQUfnXm-y1K-7OghiDA6xIh0cyWXiXF5-IUBzu-GlgBGf6U-nlOUUQu-UgwnYG6LqCYG2KPMc00W0LVLw>
X-ME-Proxy-Cause: dmFkZTEVYybkaHROUkitGnwAyZRO6qTQUcUjRCEelVhjrGYr+0UolnC55ocRHt2UNUYt6b
    UExEdx7ykpK4Y3L9Q2WfWPD9+tZNYA/Q2JFKuh67bK0IBUxDnoKBJQeoDfQzOyp2t6Kwfx
    zEveiHCGDSJL4CN6HXG005EWM3dd6ScWZPDVZBuysBIEs3zTqfMBnHEP3uQmZcwQtmZUSP
    zRaBRY9o1RLoCjHc9AMXNzaqzP8RY+69TKUJ1/4eQ66hEGaelnzKU5mqVAdQtT9CB4vDYd
    aAh1A1R2YoO9HwnRxogyEn/aY7x5QWoIwfzgTPy0e8sdom4TQ1v9mIhhQQdeuXoQPL6vAf
    Tetz+SQX8rq+Mi1eLZfE8LtaqZc2th6QWff31iy/H5BmmWqSksenLHWxcVpepEMwX624UT
    YUSTNELJtccgv03/XSuWPPD1BaSg8EERiTlVj2CbhrtoDe5Iy5NcMOWDHipHUE0zPeFAfK
    t10ndtIVEqWfOcNgJW589u0RgfCkIJjWHA3Y7fpAvQaCM/xJkVUUSNcNeC1dyNlAXCk6fE
    hdgrKRx2Pf6/dB7oKtjyTS+1VuJIXTL7qeI5I9GsINfAgM6MhC4HTO18hYKCkB7RKnqrKC
    7Iuz1J87ZtCPOuylFehk22bPQuFQRw3F7+Xb4D0GB6/KXr3X77BqzxvbvGcQ
X-ME-Proxy: <xmx:HNV8alA1eoeFSeoIuO8-4uvP4BTIUrTbwZ_oGNCfBzdy0gnoH879Kw>
    <xmx:HNV8aqYOEGsK9hJuh1CnvxUzDkBrrgdy-qSPO9ghmHNFgtCxCBrPNw>
    <xmx:HNV8atjhmIL4PigjQn5EppZj83FJrXwEllagu0-XQPMkM4Tw0-S7nA>
    <xmx:HNV8as5C8-aX4caU3mglrSI5WwZSCGvRGlyGkSUqrYXbkScc7jO6XQ>
    <xmx:HNV8asAgogWpWSjtgecsWkmOulCvgjHEGd8SiEWskypDBe-dVVQ9J3r6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 16:18:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 3/3] completion: 'git checkout' completes untracked
 paths as a last resort
In-Reply-To: <CABPp-BFv4uf0F1PxVYRuQDbJQWw-YFDNbr1QRUVZxadsexbu5A@mail.gmail.com>
	(Elijah Newren's message of "Wed, 12 Aug 2026 12:57:10 -0700")
References: <xmqq7blx5oor.fsf@gitster.g>
	<20260812164846.2236221-1-gitster@pobox.com>
	<20260812164846.2236221-4-gitster@pobox.com>
	<CABPp-BFv4uf0F1PxVYRuQDbJQWw-YFDNbr1QRUVZxadsexbu5A@mail.gmail.com>
Date: Wed, 12 Aug 2026 13:18:35 -0700
Message-ID: <xmqq7blvw0ro.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Elijah Newren <newren@gmail.com> writes:

> It's probably not a big deal either way, but might be nice to include
> "--directory" here for consistency with your diff series, and because
> it'll be a bit more performant.

Thanks, will do.

