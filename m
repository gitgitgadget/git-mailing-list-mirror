Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE9B3FA5FE
	for <git@vger.kernel.org>; Thu, 30 Jul 2026 09:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785403448; cv=none; b=EZs75pVG5Ygm0oTSxX4vGEYwMLyQ67XaCwU/a7LPa5HvsKpYeN4+IcHPw7v62H3wKcGDTkGg1S7UcUzKK/fwnwJS9r3pAcZ9kDNz6XCysgG+sygA6l1lM8LlAP8Py6FSELaGYH6AZIEP7yaJni4YXhsaffN0lT9csGWkLc13FKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785403448; c=relaxed/simple;
	bh=Ufpf/qQYhwH2iMh7XHRcNB1KCPMIy/y1+2ZZsb51syU=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=C8PYyIOyc1AtYinm4gYtG0upHcNbWmPtnngMCgfLlP63zKtFVVXvEP3t+W+FR3NFzLlrthX/l2iIAWWDoTnqeuefvOsAi91dGUnS86ecP65tHTnaoXSe/ogC5zQgqYipRS9HTw/s3tZ9Wdp3BPSiY8pqcP84KxCaKh2MkutvYHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=c1Dgg/s0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b7C4dKzI; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="c1Dgg/s0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b7C4dKzI"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E4B3B7A018E;
	Thu, 30 Jul 2026 05:24:03 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Thu, 30 Jul 2026 05:24:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785403443;
	 x=1785489843; bh=RD93QJrFcIFtzwl2Qy6N9HWvhO8abhiGZ/KBb5dS5Z4=; b=
	c1Dgg/s0IR3w5GYOfmlgdicbGpe+Jy/cIWDkal7O6kx/QJ/6ZWDqPOUoiX44MO+m
	zdJzyo29cZJBQ7gKDYxpPHkTFUQwRDJ5uFaUU3gIq4RpeaKfKPXVZLVpT5+1CYeU
	0meTYhdXCD9VOexgWsKB2SKLjM2/RgmGyGuIZFdjkMwEIcchhFrd6hZA+xjeemH9
	OhLNqEMzCkdZ0a4+9dTvUlkNlLydZfdKaWeHw5eFfJ7Tlnxzad8bePsP0vRJQkdF
	c2qDQ3DENloBeUbf2BSUuj1FRaHnHRBAq09HN3bSDIzUXyQA7295/UKvPl/sWPSi
	X6SQsw6h62bkl4zxJILM6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1785403443; x=1785489843; bh=R
	D93QJrFcIFtzwl2Qy6N9HWvhO8abhiGZ/KBb5dS5Z4=; b=b7C4dKzIUqDEPhOAU
	IszaODaUI2vXE2bGkFgFOxsqKPSQCwoHCYeAfGWego+Tm88JV9FcJHUop+4CsdPJ
	PyTfeezWHiLsxUqu0NknLHQbuvRuM/5M75tUFllx2e9KcI1tIem1S8yGvLGcLsry
	i2PG+7B8lGdAIdezJrv+I+l4LjKsp5Ddo0uV6A0KqRiglenKl9W3FQ6+5zURWPMZ
	dr4COqjwh8GQq+wIdlrMNIyaRRHMDkff1RXTQnBCDtsegA/6JXVYz9ZYg40dfpq1
	UPrSoed+rEaDF0b6EsnFSXlrLsGSv08fl7cXL+3ziQ3bEKvMod5plPLM1qqzkcNU
	VpAWw==
X-ME-Sender: <xms:MxhragvgavCAtrAMnVV2d8MR7RSD5hTGXmitnkLM6MWmqICWLgsfnlw>
    <xme:MxhraoQaflIh_B3GWO3sVpdYazB3CAgRa0fnYeqghx9BPWfCeVS7mpbIqcK6DzwdF
    sjP1An3A9U3a69qXt5Wa0rB7W4ainAmLIoQoiW1hKOv3C5sCVWqXQ>
X-ME-Proxy-Cause: dmFkZTFJchRWYF/ix1D7OwOpeOvVne+D4vUG0oB7bdVGzQMF/YgYJOe5xLEZ7/wokkbnIv
    oirymhKhYEWml0r0k0B3w5TO8xNLXlQ8bBTZgh/dV8MWpwD8GMhdOtFOd+ADXiDDO4rgMp
    c0t1mVPZ+puBNWpseRWXW9p5TR5iU/t0F3nX2CizlxZ4w0q9vbiodmv5Jtx1xKpPDbck9W
    w705EjseTqi952AyX3QSW1C5ZMOnG3BHKbJrTtrZeMrd6Iiokhy89ECR8ut5SOAfkjeAn6
    ox+K1yxrR9MadEICbYCHcLOaz/hFuEWfTN+Hd7MgciT5Hi7iYg/ahobeXmQI+NtJQVZqE4
    cODwPdP/EtrgoKVWQpbag1R5OX6VjTr87Wp3W5453ko5plpPK0wE78MYHyyCZkurR0xdvN
    d9S4XtSSIxxaXccpTmC3Da0bNWAuJIZ+vNqm5cEOjh8L89ruLuz9eWieVgRthD0xesAmGV
    a98AKXXd6aKG2W4ryG1I/h/c3o9EHfbQ8D3xFUojGmluQAEf6O84f1McHcPwuSuFd6uQ1p
    Kjf1976lOhYmzI7n2FuPNQ3EWRL2Eu42NS+P8ktUaKYVx+zGFU7md2al4yzomCEfl0RsAv
    Xk8rM7R+7TrbXLUTo7R9PSBH2P+QZXkw/q+DD3YDRdrTAibfvbW7wD8AnPBw
X-ME-Proxy: <xmx:MxhravZfKYGfrJeoGsQImNSEUCstBLS2N4mQz8BSzdhO5nd7xmvaPQ>
    <xmx:MxhrasUodx2dwyhN0eBgVOMVElaFouI1jhw2RcdjZc-nlJCWdo5F0Q>
    <xmx:MxhrapjXv-_MvhUwJD0yUckJj6JzcN49UEoq-rNq6RTRGCtYKtflBQ>
    <xmx:MxhraiVHGZ7tUmTRwJwBw5Mx_kHZYbjEeNYnWJ833m7l4W2CiCmTVw>
    <xmx:MxhraqBHrzFA4c9RZpKwrR_fVYwR9cV6-goKf_XbqZwIY1mbcWXQm0zC>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9F4723020081; Thu, 30 Jul 2026 05:24:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 30 Jul 2026 11:23:33 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
Message-Id: <2d1d5f4c-2f5a-4bf2-af82-fa215db96ff2@app.fastmail.com>
In-Reply-To: <xmqqzez9obr0.fsf@gitster.g>
References: <xmqqzez9obr0.fsf@gitster.g>
Subject: kh/doc-trailers
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026, at 21:07, Junio C Hamano wrote:
> * kh/doc-trailers (2026-06-10) 10 commits
>  - doc: interpret-trailers: document comment line treatment
>  - doc: interpret-trailers: commit to =E2=80=9Ctrailer block=E2=80=9D =
term
>  - doc: interpret-trailers: join new-trailers again
>  - doc: interpret-trailers: add key format example
>  - doc: interpret-trailers: explain key format
>  - doc: interpret-trailers: explain the format after the intro
>  - doc: interpret-trailers: not just for commit messages
>  - doc: interpret-trailers: use =E2=80=9Cmetadata=E2=80=9D in Name as =
well
>  - doc: interpret-trailers: replace =E2=80=9Clines=E2=80=9D with =E2=80=
=9Cmetadata=E2=80=9D
>  - doc: interpret-trailers: stop fixating on RFC 822
>
>  Documentation for 'git interpret-trailers' has been updated to explain
>  the format of trailer keys (alphanumeric characters and hyphens),
>  replace outdated terminology, define key terms upfront, and document
>  how comment lines in the input are treated.
>
>  Will discard.
>  cf. <xmqq1pedthkv.fsf@gitster.g>
>  source: <V3_CV_doc_int-tr_key_format.8a3@msgid.xyz>

I=E2=80=99ve posted the next version now.

<V4_CV_doc_int-tr_key_format.ae2@msgid.xyz>
