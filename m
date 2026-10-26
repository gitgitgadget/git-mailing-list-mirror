Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793034906;
	b=Ew6btcO8j8j9bJcRw4UcPyJ668cHsuH3WBeKu2D00fNa6awlfqwcFK+MevNEBH74ZAiI
	 BNbHu40BDIHBxkvG7WJCiDTujfAAven0vOFrJVtmmiTxkBhUgXVu26UwoclpX6Eeb3eV5
	 2T+RgBRgZnSlTAlPuXFNS1Z6wvpnMDSsiIe/VhgRwed8nWVgFMzUuOPK+U+yX+skUBPsy
	 s4rrxolcSBRdycSMmPqScJeLdVhRR7eAqACdyN7q/293AnvDQFaK6MaY6qsy0EX/i/Nl/
	 BPPVq5SiitMkLbgOYS69aqhpdgL8aWgyrpklOG63Ow2Mh+GoX1nz85K1sDBxGeppycw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793034906;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=aliQ1Qk0wHdnWa168tDwC4UUw2LpJsWvqG5U5RK/aeg=;
	b=3P0GBc55GxfN+KgIVMzbnLbemboi4RUzyHgEqmc8UznByeUXWLwfQ9r4WubfdJVe+IRD
	 /jsVqFJdQQS0TQn3pN10d2xVEqMogg0ZDldu0o8YgjEx8ZW2NbJHaZUUVw5ucWWLn78Uk
	 r0OF/tVb4lJiSj8DKWqwI+ovqAugElJwNwcnTE83vM+sE8r73IQyMFrtJpDnr+gXxDS6z
	 oR5XOKhjEjSEGDqBpmj6YRic6YoIBR8GtY6OkyMw/Uur+vZzcxrju93nPvFZDhatWLaUe
	 FEc4N7VsE4UKe8BqDRFYNPmAvcmiFoALMjlHdKy75MJzjmtk1Jqs107H+DXzJos2Kgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b="o8hY8r2/";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=DK9K1tsw;
	arc=none smtp.remote-ip=202.12.124.153
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E6A606A323
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 17:15:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3E6A606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=o8hY8r2/;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=DK9K1tsw
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 53CFB7A03F3
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 13:15:05 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 26 Oct 2026 13:15:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793034905; x=1793121305; bh=aliQ1Qk0wH
	dnWa168tDwC4UUw2LpJsWvqG5U5RK/aeg=; b=o8hY8r2/0YIWIRWLrtwwm06ygk
	1XYr+bq37SrC84Xea9S6sHCyUFynt4YDBm/Zzo5PtfLlTEyyGmX8xV2fS5he7PEe
	e8nE6S/0/yAiPi9AFtqz9nCG8VTKguOq7uodZni4VgIgbnbFhb41Ea+egu/r8arU
	HZXsbp8UBDTg3ywee4yeBSX/jN2cg8lpHJNwgOnB+/aOk+e49n9chXTOxAKSG+B0
	zlewmSyppySCg6QhCxH6/Lv/OTpRwOlqlwmGUukIYquQdAvP2ZrXzTM+7mpFfskp
	PFTVJaVnaadHXR+a/ib/8bqRIZfPz9PhdT9+XBhQCAAr/QYLzAUzbuV9Fj3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793034905; x=1793121305; bh=aliQ1Qk0wHdnWa168tDwC4UUw2LpJsWvqG5
	U5RK/aeg=; b=DK9K1tswv/FY6iHRnNbBbdDNO63Ih1KsMKdTbMBZ9LQtHcZ2V3p
	mxf6XLbxiubrwWAVdqzEzwaEUT3ogIneVDOpgXbWBGpTRO9weY2KBe1yaeaMF5Xf
	85vE54na3UvniX/FQkVGD2+tBHA7Xw24k3c3KZRXpIJWqa7iGBEDOfzvSWATTMCb
	Q4A9LkxAlyq/ElqF2GucbRBHne7v3qCI/1UxmZiVyi5ISCseEeIF5HS2X/7qR0iU
	qACOsVVxTqg+Wtfj6UuthW69iZ7TWJ731XwAU+CCON1wEH1q1S6pv+oc03Yjm6qt
	6V2uwCh4DDInVsNtWIt1V+cNeEj1yID/3Dw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793034905; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:FcuH2DDqR+CVB6r56GKKrKkLy1K2TIdFb8WkJSVMvpKdJIG
	C/L0rJVUVM6v5+gVS6Re1aMwhY5fdo7mxiy41MQScbPhcqft77B+jrCQFl6BfRNV
	71Oc9LBr2D4ZzL9Zeu4QFA3U6nEvpE2aZF2gXpCVGSdSpBHvPVvPuK//CHQJbd+3
	IVHsngPsqx6LlkS9EJVV1sy+2McRurJMjCSJG7dpvSjg4H9hOix7OWpyG9HrL8Mb
	AWOefGihbhcYbgn3UeRjNKQdUuvS+NatpEKjWTt3HRM461i4pDD01EvKVNn+f1gN
	2xSI7v4mybZV0Fm14ZBCbfgzkMxC8x/2uYNrKvg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:aOjq0rtE+cVvJWEYpgVTBkP7LOf6spygJD0ugjVwCBs=:i/zJzgAVvt1fu/7ebNksLL0eQfZ8npAkeNs3zxH5F+o=;
X-ME-Sender: <xms:mIrfah15GcknIaNZhxSUwObXF5GCAJ-S6a-yzrHz_zsD9P4wJ8S_Qw>
    <xme:mIrfarzg1UZafyycupY_0ibpJM6SZO_B-djvnzyl4ZVcyxodIQfx4a6iSw2RmfLuD
    tnMAcA23pRXmAsHLT0q8IJ9i96O-k2PesiH7JNBYKIPGSvYyrS0ng>
X-ME-Received: <xmr:mIrfarvyDM9hBfsHPITmcV5pic4RYkqY_o3yQQWkULomahhGbeY_TvtYunJAi90HvJbagwSrd2V6Yz8hUS6RkxPaoX4THVkAyMtK>
X-ME-Proxy-Cause: dmFkZTG3vYRmS7a9th1HABFnbT2l7GkzqX64A12xY6SGouDiUlEjSuCIv5exV7AAnsTZQk
    nZw6Vs2niDxEoCo0gnjHpJNRihB+6whF55i5n+M4GvsOq2+HddfQbYl/MzDNl/0VYorlV3
    wgRjCLm4/LYsBR10v8cUFM4PbcP+LHmHjhMv4xAjMSDkAz8RJxkoXNf/BqQp4bx8Aid1aG
    qVJy8OdKuaB732MxBUbOx870K23HaLjQL/vKdfjwOqmnkPNpXfjyFdtZ5/HYFcArJLKoDP
    8pSKYQrzlQQlAaniSo1y3XDQQpz4LlbIqiuSHV2OrAaLQmB1O2nC1ZthXvph1qRnh8qEhl
    LfOyAtJkiU7+V4Vpbm3wCFr8rZ8upw37xCtSBcUyD0Usbs1ODqG7vn+GDO9Vm3mVkuqg8K
    +e4KdZhoeJi0Zf0mjzMIpGT8GX7yIo99p0iODbkyfpuLr/Rbx3Y5v4X8VFexTLqpsUafQi
    2Q87vFTB/ANjp3OJWs/DqdqpN9HaynSgWvpEzsG1wxMbM0X7c6Ep6UVv+c8Qt6oQWTl/hp
    QXYGREI7YvmQkjTGMo0Pr/Jr1UfICUwt4QkK0YXVV4zeHXyzMBbuBmzztBBD+G5N/id0K9
    jDaq4unetbAjmjlRia6lzItLusWQGoPjbtjH9Abe3GZP0i8ivJkHtPkdqhvA
X-ME-Proxy: <xmx:mIrfalzL6Jw8Tizr_DgSegEaBU-qwARP3iYu-CbU7em65De8Nf9UuQ>
    <xmx:mIrfamANGZ1A2Uc0l8UjyWvnALIiypitA8P-V77KgSEYyr7HMN3fTw>
    <xmx:mIrfarcQX4mGjAv3yscihsz0fTEFXHhqxC1w2640AG54lhX6fQzPJg>
    <xmx:mIrfaon-Og8gZb5TkBEjirRnyNzzqQDrwx71BjRGKsZG2jGsOeNKaw>
    <xmx:mYrfah42SEjZJLMlHVVSvBLixI7UumRSh801rQEdJmqX6vrfI2b8juuA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 13:15:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Tuomas Ahola <taahol@utu.fi>,  Kristoffer
 Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v3 0/2] [doc] Remove gittutorial-2
In-Reply-To: <pull.2241.v3.git.1793022742.gitgitgadget@gmail.com> (Julia Evans
	via GitGitGadget's message of "Mon, 26 Oct 2026 13:52:20 +0000")
References: <pull.2241.git.1790627122.gitgitgadget@gmail.com>
	<pull.2241.v3.git.1793022742.gitgitgadget@gmail.com>
Date: Mon, 26 Oct 2026 10:15:01 -0700
Message-ID: <xmqqa4o0s7sa.fsf@gitster.g>
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

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Changes in v3:
>
>  * Remove gittutorial-2 from command-list.txt

Good.

Thanks
