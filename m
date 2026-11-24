Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795533814;
	b=QfW1mzQ5BQXZroVfPhB4BjY6TbVdLpKuIxE8emc+0Qa0NSRs/LIo4w4w/frGhUI05+x7
	 Y39UqONNDASfhG8HGUgWYAqLJJ4//5zK2EF/UKxyJz9vaWiIYU6zeSX76es7KInwjdjKs
	 p/5Ey3RcfkjUIkOLVEiBPRHuILTgIqoAGvSfelhSLlqjSxmGZed7Qcf1I8yT2rP6yIZq/
	 jEZc02zkdKua9pkZ98mGvAVzWJlWI1ACInkcumVLhABKBIELspu3UsmOQEzboMYQ1dTfl
	 DY6c6Oj20Y7hETC8EQSRw+Uf4PFs2X9EQ9VYfPi50ZZ/KPU+nPgVqcyOR/Qr0RKdoKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795533814;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=sehlHJBsB6dpAgu/Jj6/nQ0yrI5rS1Kh6Hl3DUuRHro=;
	b=SYFrc7p+YorMeOOoHIAMYuOqkCMaml6qoRpQjY4s+fervWodIyGdtxoxe232B5Bc4OWb
	 pViE8CtpGrgxsVyPn/hEEzgC2lVn4mULWNkSPS+i6T/wqBQsGIEhq1Jpg56RW2qMjZ7k3
	 cUqxsZkBxUMQmwv9ds2rPS8E0X7M63S4Mt2yCuczdEdrjp7wTwhJYQ+jS4pVsGcz+4gbC
	 APcvJxyqdoJB+5DVcDrwUjSa/cVDRAUm3XJh4XH+cU5TSN8fxj+zs2qfdA46dpkcbP694
	 v/fvqJKHYZZQ5UXEnFKUss8VEeCo+aUqTW6djtQh39Bt98G5gn8s3M30AUuZeF1eEGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=hOcyvucP;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=3Z2TAY1x;
	arc=none smtp.remote-ip=103.168.172.148
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEE4606A31E
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 15:23:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DEE4606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=hOcyvucP;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=3Z2TAY1x
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id B109DEC00D8
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 10:23:32 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 24 Nov 2026 10:23:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1795533812;
	 x=1795620212; bh=sehlHJBsB6dpAgu/Jj6/nQ0yrI5rS1Kh6Hl3DUuRHro=; b=
	hOcyvucPPg1NXUrRac76vfUzqALiFv4VilfaQBLSAv3h83/aZGjcQlmJucgpW568
	bHXO0R++oSds7ed5dWy3YUEzxAfAtl47e1yKAJMKBkD5Q8x4zeUa1J7SVaxb9ELL
	5+TKVAV8kPxfM+ujvcASBmUsiOsYBHjinhMfTMUECO82ujcIW4Spdpj2OmfS3TmN
	eHTzrvGcHnrjGiGK1xieEcWF15ai5xzn6vVh/NlrBDRFf9jJvB6re3s+9ANoAzhp
	wSl79afIytTyTFHrXyGU3RfeOiYMjQqldBPrEpRVP5j8+txApI0Zj8UNrnMTJGdX
	HhjeAZcQIF7ZccxXSro7/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795533812; x=
	1795620212; bh=sehlHJBsB6dpAgu/Jj6/nQ0yrI5rS1Kh6Hl3DUuRHro=; b=3
	Z2TAY1xvUWPOfephFe1au1oy/q4eqgJSIufbmYKe04lCrAfgcA+rlRgfO1cUSLzL
	A1rog4SP1O/vhhoFzPSh1bGQ3/4+45BgvuxI4SYnOtUXbhnMqlz6BLSGTjnlRofG
	cxngFHUq0lPrpxNURw5/5T5A6ExU5hSMHbxZKmdPbI5CjH+WjwovrwAU314EFySl
	0UcWmZx4yiYrI+52jf7jPpNiOQcTtLw78gKfD4KaNLiP/IZBqXwB1xDjcbDXoXJB
	x6+NtuWNNbxQhx6CPao+Sdzx0DprZnRQ/WYwEWP5pVhFRqdS9wyYpCVbrzsbxef2
	D0Ri9ghV4IqT5ShAYGrog==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795533812; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:elBKeq/js0VtGWdOfrzzxk4PFxtGIOC0tKozx/VSkwNZU1p
	hChLaLrtn8iwFy/3C1Y/0R1lgmQXt5F8bpBzFwDrgQtx6kZfKimraKyyl62MD9dO
	1dWWswolrlxWDo9PJsaZ2q+4hMnmAqvr1FkNier4SQyzFYY3FZjXgKNkN55DtUNu
	bpOlxiJ3tc9/Wqxhqb38enlUcrNFy7yss/3PCLWFuENaF2I8Fe882eiPKWLOVy0I
	Dpubku0c+oVpcKf7skTAk6gnn4LhUBNnLY5m6k/wQHkYHmCeH9lzpTei2NdiYYS7
	yifpxFmoZOmqnMJuy/FJ3FBhQMcc0ZWm66SI0BQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:7PRDRT61mL5kWvEfSeo7WY4utOdks/TRt/HY65nv7U0=:1QHPcRLgV74KyQSw+tzAyey8Wy2Gsk38gtz/AgG+KCE=;
X-ME-Sender: <xms:9KsFa-bn1c7SaRpHTOCz_qwNteMcHamCDFcEFmVpENEnEGfDCLAahQ>
    <xme:9KsFa-88uGaogYlK2HUaR7IwDaNsjHCCTY5EuDoQR2p7Te9X1Bms_EuiUJ9EepWgW
    kbryPAuXJLGAid7q0mXryk13Jv7UUyFCSpS7tERAr2WcTcoETjgkg>
X-ME-Received: <xmr:9KsFa_YZNEDoihVwslhM28VQnLykEC_pVjGmwhP06fEAKxslW-8UKmG9dpXq4zdgABt_qxMH2zORlXHEIGC4698tLbkUS2-W_08ajeU>
X-ME-Proxy-Cause: dmFkZTFdhus91qZuSo4nJAx9Hx94DVQy4+ZK6OH4AGiIGm2llrQnoDRRo/nnNF1gGKh58K
    bp1dit7A+YPR0kfKKqJIgLzKJ6iMgHdI6kP/ab4JtMCBnyePumWuOanMS1AcXmLfY4d4+2
    oZDz+ftNX5bQcdErzzf14c4kA1PUhRUB3zAbQa1wJqfOBhxIhBvs3hwknvA+wKTH5jt5pV
    5lg8+MItCDPVmbw0Gp3i/jUNCNcZbJwRS2N6Pa2OtyEyewKhAb/uba2Sh/kF4tuO4kCu9D
    xPP16DyejyEec7PO192gCIuWC2ppAx0/l8Qm4yumsaYU77cIBLUnflbCKtRBW7pPcVk9f+
    XC/pynH8zlgqdrFmXjhucukBlZof+FdlTGXs3b3t7rfpZpLDlddPdkvSC5VozKsdtGw4hN
    w2s+FaFbteh//RFIrt2IK56JtPElZZtKk16LMkGItcC4oczzskoOzAzrGiRZRuJThQ3k20
    oejNwHci6Cby2nbAhVS/8JuYrDBiV8MsxVTVtZk99GjbWvxQRt1gGFlvbSXuLvHPZftVjc
    f2ceiSiWFo4yVXvViTQ6ZesMxiYKtkZEJxwCamrz0puBwd/vmBVWs7vR5IjAHtXS3zGMRW
    cuWQi6hEyj9tuQeDdRv+kKSSSVLw5v3Yzqt/ljpcPydftfjOmoKCGxrvQk5A
X-ME-Proxy: <xmx:9KsFayPm_q-5nntwiJXdLYYJM8C1Q45XAPMBTqb-NJWxZIvYRFl52w>
    <xmx:9KsFa7DO3MYIF8-O7g_G7LWS5s2IS4eD9d8dTBjLuelDRTC85RAQZQ>
    <xmx:9KsFa5J80Ku6cZjm8HebhJGwirHTlQKOxyDJHiPKAGkE47BNsZlqdQ>
    <xmx:9KsFa0MxsXgsozR-6RSakrBg7arbnN3Dv7pEaZf5_fP-APDxzqus9Q>
    <xmx:9KsFa3qGOWAJCuUsgcHiwxD323ru0x-WB4D1LxCFr94273IuJo8aOPxe>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 10:23:32 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Okhuomon Ajayi <okhuomonajayi54@gmail.com>,  git@vger.kernel.org,
  usmanakinyemi202@gmail.com,  siddharthasthana31@gmail.com,
  kaartic.sivaraam@gmail.com
Subject: Re: [Outreachy PATCH v2] negotiator/default: stop using the_repository
In-Reply-To: <CAP8UFD31EuSF10wkSAqZxswKVvTG_m-VesbHSXZT_Df-FrqV5w@mail.gmail.com>
	(Christian Couder's message of "Tue, 24 Nov 2026 09:41:41 +0100")
References: <20261027153429.14131-1-okhuomonajayi54@gmail.com>
	<20261103155038.87456-1-okhuomonajayi54@gmail.com>
	<CAP8UFD31EuSF10wkSAqZxswKVvTG_m-VesbHSXZT_Df-FrqV5w@mail.gmail.com>
Date: Tue, 24 Nov 2026 07:23:30 -0800
Message-ID: <xmqq8q2iw8wd.fsf@gitster.g>
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Christian Couder <christian.couder@gmail.com> writes:

> On Tue, Nov 3, 2026 at 4:50 PM Okhuomon Ajayi <okhuomonajayi54@gmail.com> wrote:
>>
>> The default negotiator uses the_repository to parse commits,
>> clear marks, and walk refs. fetch_negotiator_init() already
>> has the repository but does not pass it down.
>>
>> Give default_negotiator_init() a repository parameter, store
>> it on the negotiation state, and use it for those calls.
>> clear_marks() receives the repository through its callback
>> data. Drop USE_THE_REPOSITORY_VARIABLE.
>>
>> Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
>> ---
>> Changes since v1:
>> - Put the repository first in default_negotiator_init(), as
>>   Christian suggested.
>> - Pass ns to mark_common() in have_sent().
>
> Sorry for the delay in the review.
>
> This version 2 looks good to me.

Thanks for writing and reviewing.  Will mark the topic as ready for
'next', then.
