Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.61.206.94
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794987829;
	b=BoeLiF3Ho/Kx1PTql4BNeq45OTGIXEJ3TPJc/wVv508wTCfgkV8gBr3DhpLaQIGjPssF
	 yp4DY+PHjyHZ4C+qbfr4yAXOHEpbhZSwZXOoNJK0L508/QyH2hlmaXX6uR+PfU+1uV5SZ
	 sWW5rgUxI+ixp1AGF/PelQRaN8PefYHWug0Y5OtUvmYgCPaO+5qm0wIeXnBmLMFq3F92a
	 42L9cY74V+EBpRSY7Mcf7fRw9u3Qby3iqU+ZIEf27gIDiJ2vMdKjjQjiQkRoA9PnC/+Ja
	 P0ASGn9mPU4emA99U76msYDGwZuTcMMyOVdpaGuFXtrkur/LqT6B5+mmlf55oAva0mQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794987829;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:
	 References:User-Agent:Date:Message-ID:MIME-Version:Content-Type;
	bh=hVOXB1shPextvyxfHqQU/oXpZM1qIg3RmCulQz/Rbdc=;
	b=ogHl8Fudf/xSt6ZRpE2GJw9dxZWkUSmlBmyKONFCsNlrBtotqoFkVCUu2LqpnrdIt57Q
	 lA3SJcgG0O8o4JOuS1uwkcWF1Lo4ysTBQX0IyU7hQ0sml04qf2jzS3Q3VVrPFvU66Tfte
	 9HKXcjyI2lJomWyFELl7PbtkwPCqv8/2z2JNqmtdgv8Er4qmwcr6SeRMY3Qg9QvFVEgTu
	 aCpOHB7XcKyvrx9aHjgDXqxCVr0K8QjaFyrYZBrVTzTrTb04Ig6Nr1BHoQfRUVXlQcdN6
	 ONtZizllqgZ6VoKXorsvlOL2N80JIeqQwa4rgp+Nm2Q1zGma7LnBiW5+qhf0Xngbiow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gouders.net;
	spf=pass smtp.mailfrom=gouders.net;
	dkim=pass header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=hCOacWjU;
	arc=none smtp.remote-ip=202.61.206.94
Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8A7606A32C
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 07:43:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D8A7606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=hCOacWjU
Received: from localhost ([193.175.198.193])
	(authenticated bits=0)
	by mx10.gouders.net (8.18.2/8.17.1.9) with ESMTPSA id 6AI7hhjl1881332
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 18 Nov 2026 08:43:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gouders.net; s=gnet;
	t=1794987823; bh=hVOXB1shPextvyxfHqQU/oXpZM1qIg3RmCulQz/Rbdc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=hCOacWjUDomkJZVHxzKrMt44u9OM4v2ZHM/rAgICspxZfSJvI3AK31pXs562gYTOH
	 LADU0EQGMVMyNAwhXOZa/zgqQlUvUXQsF5Ku/Y7+Wz50UVCahaL7GO8bLXe4wgA08F
	 nkoVGcdUN3+QcWdwzC209ml/RlGsUbElia60aiuI=
From: Dirk Gouders <dirk@gouders.net>
To: Andy Koppe <andy.koppe@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] utf8: add display_mode_esc_sequence_len_counted()
In-Reply-To: <CAHWeT-ZcOqm9PXzM5W18+ktJ4gBdPNyx+g_2ZCaW25ufKH4g5A@mail.gmail.com>
References: <xmqqmrr7fllq.fsf@gitster.g> <xmqqqzgjcjes.fsf@gitster.g>
	<CAHWeT-Zt=1MjD=fbOiAiQtb28Q4DAR_wF12iymXmeXzGyyLgbQ@mail.gmail.com>
	<xmqq33szavmy.fsf@gitster.g>
	<CAHWeT-ZcOqm9PXzM5W18+ktJ4gBdPNyx+g_2ZCaW25ufKH4g5A@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Wed, 18 Nov 2026 08:43:38 +0100
Message-ID: <ghwlqak2j9.fsf@gouders.net>
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

On Wed, Nov 18 2026, Andy Koppe wrote:

> Junio C Hamano wrote:
>>
>> Andy Koppe <andy.koppe@gmail.com> writes:
>>
>> > Junio C Hamano wrote:
>> >
>> >> -       while (isdigit(*p) || *p == ';')
>> >> +       while (p < end && (isdigit(*p) || *p == ';'))
>> >
>> > While you're there, could you add colons (':') to that?
>>
>> Do we generate such a sequence that uses subseparators?
>>
>> IIRC, this code is not counting the display width of end-user
>> supplied string.  Rather, it gets string we paint in a buffer and
>> then counts how much display column it occupies.
>
> You're right that Git itself doesn't generate them (although future
> enhancements might change that).
>
> However, display_mode_esc_sequence_len() already operates on expanded
> custom formats and message text, e.g. in rewrap_message_tail() via
> strbuf_wrap(). And on stdin in git-column. They could all contain SGR
> sequences with colons, whose width currently isn't ignored as
> intended. (And my proposed make_line_colors_self_contained() wouldn't
> reset or replay them.)
>
> The check could be changed to `*p >= '0' && *p<=';'` to cheaply include colons.

I would suggest to not mix these changes simply for bisection purposes.

And as far as I know, we would need an FSM to identify valid sequences
if we are going to allow colons.

Regards,

Dirk
