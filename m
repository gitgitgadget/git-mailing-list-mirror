Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793291718;
	b=Jad4BWyJAP5RmvGA7JZxSeEVPDNr7NSTNvWVTqgDiGm9V6KuhV93zMCzJ4T6iO5HECrh
	 CQw2VCLzAuPVToAISCw1kD7JxMm9KdO+cOkSpO4qI9FyLdf9+kNIHMWsaS4+KPDKzC1H5
	 DJS13RySBU8IhKI3uiKnr3nT7BeqILzZwj0s7bMGTN4zOgLP/jYMWPF9NSHIUQti08GWt
	 UMtADfXdrKkxRt5Ehh1KhPVlFX05qdaFb8XTShLJwD4p6LAVatWb80zQE1vfmYm7iuvIn
	 +5X1Rlotz6gbnae5L5k+AJyf0xOhCnRSN9w4kMrsmcJZdOXHPFpnygnkbjwWxhq13og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793291718;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=ub08KBUOLMc24x/Kpr6LOXyhssutvyHtjUzmn+crstM=;
	b=1UZUV+IWn6zREwq/s0GoCTmUPSDdapzIMOxuPT6DdhNdLmwFculTzzNjLmFL8o6youIv
	 8bXTN6+Rfp4r6hIDhYEpq+jkL78cBZp0oI8rqpdZr+w1bULk8oe6wjTEdiH0Bzr3gft6N
	 LwQR4b6+0z/lMs/qudaL2PeF84tocQvHlJ+cH2m6gd0MCUtBTkwvslttpl6R35kmYehYX
	 zaLMAhKXU+EcWds9YoEDuobWgTdjuXqmZMYq+39Vvi+aWyYhR8j2MznC1adLt/8Ui6EoP
	 TW7+QA4DNbs8UlVKpKkC6qHPM+VPtP9/WxDWk7vfFaQOeyIVEcAwLQd3PPFKgbV2bog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=cN45voU9;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=scEXj+g1;
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AA3606A31A
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 16:35:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27AA3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=cN45voU9;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=scEXj+g1
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 8A7A41D000EC
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 12:35:17 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 29 Oct 2026 12:35:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793291717; x=1793378117; bh=ub08KBUOLM
	c24x/Kpr6LOXyhssutvyHtjUzmn+crstM=; b=cN45voU9rx8x1JIZlFBcbmPjWr
	RxOjpPOGhU/Q7ksVZU8ec0ZB4YuH12na8JMpyXZz9r+SSL0GvyM0tEH1yi8h+P2i
	+YMktwHB72ylG1chKBTjIhfmbVMg0e8DHvpl9sfRyL+e7k1zZwfadJIdLrIEf9MX
	V/o9H/2wKpk1GLThQBRD6XdR4i+qVEoiQJM8obNv0B928GhQMW+BF6csWL83dB5K
	I0RXwgm9uODH0RjzHSYAHg7fq/Y/k91FwTv8VU0oGRtKRqm8a3twu53Va3NmBymR
	4cU+JSQ3EtUG6uLzAG1KQHkApk0FCGX5SgTJvZs9gDdGzR3yK6Zmxp1N73dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793291717; x=1793378117; bh=ub08KBUOLMc24x/Kpr6LOXyhssutvyHtjUz
	mn+crstM=; b=scEXj+g1Bg69BB1GCrqx5JqQYBxX9bEPUkTmXjCQywUSkGPXvya
	e9/5adRvAyOeKlsNkO6D4qG/ECG9Oygyiol/jmljlhNvh/hPzQzbRMStDOcDuyYw
	OTNHpdwutXsY1I8oZG3Frv3S+Zxp3UrsqK5whfKlsZRI2HXxDxi6mMW4hht4OHi6
	qX87p2qlw10ZSwJi/DqySC+JhM/iQxioP9C2Bh2tfdotLvx8LkP6Mqvzg9kgwlYn
	Zw6vNmtY0+R+usqNMSSzZdhS+Hpw1XAPk2vNkWAQpUWVpkX9UYTKJkSuV6857CYN
	cpL779YHRzcwxT/HYuXndc7I15KE9NclfuQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793291717; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:gJBVB0cre3xlFjVNqyvhHcckFbn58pqxJ49/gyIOtvy2t5E
	SV3jIqautX6KdobrzFJVh+++ER0EQo7Q/G5T2BNhFLe7ecOVMddg+CESGgOemH5F
	fDZiJZtlHirgVa+e8JOHudVext0/j9nBwrBdlVQ4wQPKErfbrGD3W8OHL1t5WlK9
	lep6TCG3L4k/d1my1GJ7VhhVx2sZ0EcKvkVeVbjrik4zQKrCk42tYu2vCnS4Z+V5
	/J6ZAZ2fqpOcKbYMbU0s4Gm1gNu+4y06IYUFWx2O64ePcRanypMuuCKUTjaTOsHT
	+JvoP6Vke/Og4jc9519+h1NI9IMOnAMrLwbN0yQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:KThammkIU2LYhPJosoSSJ1n7dOAt28JFYZRyfu4w2P8=:k5P3lqv8D6VY2aZKl1KIc+ClnNwMUl0C/SHwprX0C28=;
X-ME-Sender: <xms:xXXjaj6yT2uoD_G7mFpc_-AlcO_mRPO5_fkkSw2YpqCpQGgKYbgwHg>
    <xme:xXXjasnZq1fl1XwZDDz-sBF8PyOT75zArnqIWuN3V5fvNXBcqCMcz8K3Hm42PGA3q
    qusILARNE8Y29j4cZLru7ybkpQAFYTiWcNEHzKQC2fy0RllXNnaCiQ>
X-ME-Received: <xmr:xXXjakSr5RX2zchXIHQEhMa26kLivV-3wOWV05sreXDxcd_g6WN8w8Coqs5bkhGPaQWPO5xxip8X3qJ_vw3sJl3X6Ksv0aNb9tUp>
X-ME-Proxy-Cause: dmFkZTFkl/wfQip4ktXRkFxXqXN5ItFCLfPZELqTHmO9obHKlyLuPlplJhmkTAERaA1ywO
    lvAoUQTZlLszVIMMGTZiim6g4gXEWE8qBfewQZnROfDcum5D/SxqXq16hQAtOAAGZKhLLE
    Ub0f3U9V/yETTkMlXYzb5dtPJ6hr0MaB1CiYODZHy8Q6kP901Ee4JmF8MS8QQ6D3jcVM3f
    kOlFibpMu5PnGxI+xSwCme3zQgoWuEusje8wbsjwXlacgJfb5b8N1X3/Le4F2v4ioIiIZN
    mE8dkbKXhjDva5+d8AVs4hdyWTTtpChBDRfLXoP45G9USor0pv8VfUNQRe3TXI+bR9cQpQ
    wcH2jPoTcj0Ha1ML58j1SZSNVKeVvPVkblw9daAJ2c05n/fZ1fpsprwDAtWr3BsTK4tUpW
    EDr++kj5b1wMyuan1T7Ly6RDlAvz38rlJXw59svgMFYsQtzYMla9vhAuJIwgjIzJEA6FIA
    7icYnClrNncXrtlKGKF9g/TRmziKX+W3ZYN2Qf1RD+j0I8gT7l+Zf5n/1Xzozk5Yyx0+s2
    6dOBxNaHRWVcoUWQoqTtNmlbqzhcGOZHozK+/OIy8INjQEli1xTuZtXLrJgvgTz1nNYFJE
    4IbFeazN2ISVCd1/xeS/ZBPyNAKzBZi5jODy3iYv9Islq1LzbLG8LbyvTLDg
X-ME-Proxy: <xmx:xXXjarFzRmncZdTKVcPys3ep0AEAO88gt5ofD-fuqAnwl-UqdG-E7A>
    <xmx:xXXjapEXkqoSRkoNjw-QByg4iHnnh3xJiUTGCzArGOK5Knnd2Wvc6w>
    <xmx:xXXjapRtPOit2c8P00cUeh-1JE45wC8KjtMskf0gWsQ7y0NjqoKZdQ>
    <xmx:xXXjaqIWppZMYn-028Euprdsx4C5AI-fzuY-AKlo5awsgP1DKX1S_w>
    <xmx:xXXjahVl4fG-7J18_0JrxRQ9o7qkYamCGERaURl61mkpejl3QlllXlpp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Oct 2026 12:35:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <ttaylorr@openai.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Ted Nyman
 <tnyman@openai.com>,  Elijah Newren <newren@github.com>
Subject: Re: [PATCH v2 0/8] repack: various corner cases for cruft-less MIDXs
In-Reply-To: <auFD5f8IWEHwaFLD@com-79390> (Taylor Blau's message of "Tue, 27
	Oct 2026 19:37:57 -0500")
References: <cover.1790731662.git.me@ttaylorr.com>
	<cover.1790827875.git.me@ttaylorr.com> <xmqqcxsufz55.fsf@gitster.g>
	<auFD5f8IWEHwaFLD@com-79390>
Date: Thu, 29 Oct 2026 09:35:14 -0700
Message-ID: <xmqqse1o4g8t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <ttaylorr@openai.com> writes:

> On Tue, Oct 27, 2026 at 05:27:02PM -0700, Junio C Hamano wrote:
>> Taylor Blau <ttaylorr@openai.com> writes:
>>
>> > This is a reroll of [1]. Thanks to Stolee, Junio, and Peff for
>> > reviewing.
>> > ...
>> > Thanks in advance for your review!
>>
>> I am trying to eject stale topics out of my tree, and the discussion
>> on this topic is about to pass the 1-month mark.  It seems that
>> comments on half of them are "looks good" and the rest are "just as
>> confusing as the original without improvement".  How viable is this
>> topic?  Are we still improving on it, or has it long passed the
>> point of diminishing returns that nobody is interested in polishing
>> it any longer?
>
> This one should be ready to go as-is!
>
> Thanks,
> Taylor

Hmph, the question was not meant to be answered by the author,
though ;-)
