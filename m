Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795552343;
	b=s+tyk3U4y44F5qY2PdKUKciNeoMymkP0+GrmpADe5Ipei3WmsErf3AX2yD8kQkPK7Pnz
	 XfwPpMKWGfJTytba8vmddgxL/xmy2w/RavmaL46rQ28S/496cVHqBHU70yoL5wH9EKAEu
	 rxn7FzLsAZozgiEOMwJN3W7D2ziwtX1Rd+mlgAn7aJlHsWQXusYi4R++DO+texE6sXNTz
	 P/WBUKyhkSc1/U3OFyWm7a0wHuNVIHAJ3q55TUIZskl7g7r3aOxAltQhe6H2Q7OQyAuzH
	 mVBpJUxYMbf8k0vaou+pXlz2sdE9i1gWdwYxO6UjCsntTNRCCDkxylkikZfhSCNBijg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795552343;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=W0i+2SmMSWcXrZ/R3YIfAzUwO2qxmCTqxEBQmS2f+gs=;
	b=0OSIWDOngYBkWIvLsRomOwpRiOoqiQ8I0/hiGCN1HqCOAv7MUsV4/uxtHfZmf0nZHHKT
	 Jyl5TGDLNhvIJUv8uD0yRJ0NvldHriRf9zQIbNB6sax7/7L5PgikMoPNImnJqo+FP/dU/
	 RNXHoFgpLMX5m0kDuJ9a5Go34ZlWKLvBvZNqHswaKOoNj2IdXB4JLwq1wa74NfhvUnO1q
	 0dhyP7j+Jr5lv0UJ/vZ7+LeCCR5W18zKxwSfAfFQ2w6TZVbgbdQU7Q7BuNpOlluVtzblP
	 0DY8C7seLK/lgmkc+jmHpiLLNfB9r3kD3an7gPvOcW4RxlpCfk1XQCGtVe3ZF5301Hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=CXs1R9VM;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=DTAnpZ1I;
	arc=none smtp.remote-ip=103.168.172.157
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDDE606A31E
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 20:32:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BDDE606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=CXs1R9VM;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=DTAnpZ1I
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1DE9F1400314
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 15:32:22 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Tue, 24 Nov 2026 15:32:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1795552342;
	 x=1795638742; bh=W0i+2SmMSWcXrZ/R3YIfAzUwO2qxmCTqxEBQmS2f+gs=; b=
	CXs1R9VM3QcrjVmIusL/7un8tx10453cbH8TIoRu0Vkf0vUZxjY8H36WXBOap0p8
	GCUvS6TUbLkAkMCk+gnOwjWUFotG+C50NoOVRKleKcHcddc4PuvyFdhKNY+A3E63
	xBbReDx0EAioGoUb/ZR8i5hipwRgMG9axtr91fF07XeEA+8r/rVmQmchqgBNBCOC
	xI9Voj9XZsHsnmDmnY8H2nAB2L/ECfiExDFU/Sjk+IRZyJhV8E+sACmKya59CCc9
	H5B75LN8e1uHmOpjU3ivpvzqygjWkaxIweiiYzQ2wKBtJhPQZEGfwu9Y7VL2eCwl
	bRkIgxV73ARxQeTPBUrJbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795552342; x=
	1795638742; bh=W0i+2SmMSWcXrZ/R3YIfAzUwO2qxmCTqxEBQmS2f+gs=; b=D
	TAnpZ1Ie3yalhaPIFK/CnMvrbhMuOTToi+CauWTuu2EYcoyPnmoCX0NKhr4LcgLG
	ltNYfnQyTTPCjUuFBSn958nIFKOXjG7eXIVGJrTMpVjIoDjRMYQt4qrzNuRU8VEC
	4XfCpSxuMdnavgHrRzYdhT+487mBsqlUzhL85E6xdnHfcamWrBXDmH2DCq5jTEbx
	9cWoEiPxb3CaOrtjtFr1RTTzIxdHAhwD1TE6lqy4IaVGTTmS4nmSw5s/Drhqt7am
	clfnQM9puLgG2DF9BW5SFYQHMfmEGV4m3GZ+LF7vOthIOEfKcnB0XqBdN/5HvXpY
	pmrLZGjY3uDVLYfrZGlVw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795552342; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:CT0Dc/Ia9xiLyR187GG7+O/ta/CCIFi9gTKeoVrL9zfW5hB
	bMXY0vWJSfsQXBguCuClaNYKq8RdJ3WgCfmB627seQlTGC5SnA5noCrSBcwWbQMI
	MrHEUhM8tm1Tr9eeUWM4Mg914l4IrVtWjRe5GGILS224KQs9btLv8C5tO3UQExud
	b7Zm+rm9bWVGHvB4gheux8qzC0M6KOajG5cXWb/djBpdKgZsm7LHkvRque9ijnxl
	7zXpOEkwIdFZ1/6Ci4fjAEZU0ruWv/26OJxcP33h3myTW01ra5zGVsxa7WSJ/xcK
	eOgsklHSv+OFfLb8wj+J3OSxiLA/uJFzvnGE//w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:twuV+Y8PaSyuL4DT6i1MNpBZfTqj2j0v2XXKxoelZPk=:e2GpcMBS02dW3xDTuWBP5U7I3SccEanYg/T55tH53+g=;
X-ME-Sender: <xms:VfQFa1uCmfBdhb_6n1QfcIJLTFM0-zea9Rkay6yLLZltMhhdqwYDBw>
    <xme:VfQFawtHLHHh-LG0YbjE2rrWRklc9ZcB57EedWdZv6eJuF3kgJ9ZkRcaphAEFEyD9
    qsSHBfhYmeMlWzIgozfGDYQAOvv-T73FM27BlVRvbiRaCeShtkt4c0>
X-ME-Received: <xmr:VfQFa7D9FevBQiBCCcT73uJ3ghxz7WMJO3PHcHha6zNI8Nh_nvFI0zat4qmaYlqhKn8i20CHfgBBmG1wN0e2ndECjoJtARUHEbskQNk>
X-ME-Proxy-Cause: dmFkZTGaUHpXqniCMhjvG7gNn52ePSGrlATgROM0k6glXGcEAuybaub5/qvVWPagWBTFA9
    9U4TZOEgDmKHyXx8EwLtMV7pFYynDyYy+Gzzk71sO0uI+rCMLqcG3FRMFFqQ/KwcOBGRID
    DzjnlicZH43uH+N6N6buMwmNRwJCwvQOiujv8eY0f/ZDRtqMv3nGpSZKgwYmr6OWX0oRF6
    EakRCgYn493sRAua7eZ/f7/cV8lP3YF5wcV41ghJGVBcYYjmkuQptHPVF+sryeJvprrD4o
    9uT0g0vmVRpBR3rapLJF+r+j+XBGXQrV1Mj8No5OoW0WDgY95rt9AsoGqNgJ6s5NpIKloc
    x/o3KitHsr+eS4nd7wgjauoKlMNQZGGA07lO05yJmK9cAUwer2c7e8N7OP1LZGyRU/M93e
    P0sBje09xRXP5wdr7Lyol38nrRInJ3u/ssfR5E1z2RRrW8jN1dINEpw0Gp6f+RTMJxwAra
    8G/v3LqGY1vF62DY/cTdx9cFOYw4mlQn8qpUDttG7M7JKwBNPdLA5QMh9vsordCJs1Oxob
    bK3JxAyv/uEHfnCcJs9ynHWeEPpK9X1JeVopM4NqSNtDMwTklk0/6QbxYLr0k70ij9d7Od
    TkafyG2rDG8QNRtKCODLwJYvG4JQtDFLJAJJ0O/vsl6JAQt5zgTmyRRefqGg
X-ME-Proxy: <xmx:VfQFayOSOOdFmX-Zmj5KncO2M8JHvq_w9Jwqd1c21m7g2GtJTWR7Uw>
    <xmx:VfQFa0x_WqCOr2CkkqQNzIQqVQu5tB63DhpQe_bfylvJCZ8t462sgA>
    <xmx:VfQFayXbQync55S8C-MZgXZiKGLl4noHT1YGOsfmxUR39n0_c-wpug>
    <xmx:VfQFa2PovRiOomaVi5kCOeR0vc2PjFDroW73nkgaOxJ9Kdz5r9bGlA>
    <xmx:VvQFa6gPfRKcXAidSnLQmEx2As8G2kTQdAnB811LphWR1A2s8T3CRGyv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 15:32:21 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Okhuomon Ajayi <okhuomonajayi54@gmail.com>,  git@vger.kernel.org,
  usmanakinyemi202@gmail.com,  siddharthasthana31@gmail.com,
  kaartic.sivaraam@gmail.com
Subject: Re: [Outreachy PATCH v4 0/2] checkout: make unique_tracking_name()
 use the given repository
In-Reply-To: <CAP8UFD2LLCCNT8YMZ0FKatY=dFsUdoX-waYGbN_TnaU86WFs4w@mail.gmail.com>
	(Christian Couder's message of "Tue, 24 Nov 2026 10:05:57 +0100")
References: <20261023211533.73433-1-okhuomonajayi54@gmail.com>
	<20261104090534.21838-1-okhuomonajayi54@gmail.com>
	<CAP8UFD2LLCCNT8YMZ0FKatY=dFsUdoX-waYGbN_TnaU86WFs4w@mail.gmail.com>
Date: Tue, 24 Nov 2026 12:32:20 -0800
Message-ID: <xmqq8q2iotrf.fsf@gitster.g>
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

> On Wed, Nov 4, 2026 at 10:05 AM Okhuomon Ajayi
> <okhuomonajayi54@gmail.com> wrote:
>>
>> Changes since v3:
>> - In patch 1, unwrap the lines in repo_for_each_remote() that are
>>   now short enough after the switch from the_repository to repo, as
>>   Christian suggested. Patch 2 is unchanged.
>
> This v4 looks good to me too.
>
> Thanks!

Thanks for writing and reviewing.
