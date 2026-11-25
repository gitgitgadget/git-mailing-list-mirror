Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.61.206.94
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795600607;
	b=bp8aVkmvQzblypaCFXrm2mKX55OoqkhE321MITNSPXlybp6V31h4FUzKfPl/6wAUoESB
	 23uLI0HDnXu86Uygv6ZpNAlDMGgslZ653szlCQu91zHtmC0cwwXOMnSkCKr5Kzdddi0sl
	 Vrcih2nYcKZcgujnsKHdPyK9/fWX4fL4WRdqvwrfOVhF4U0osT1RvC4+CiFm4PNVQHqPb
	 RsOrBgfltvrRF+B7hb23e5o5nFg4nRirvIOTpxW30zXpxvTHD8wKYkFp6u7sloUDKUXl3
	 dIy0luL/SC38BsXe/tmBuj7SjCebjdH95I/jjAJbMbSt45xabcC+SVSsMQjjI/3ryww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795600607;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:
	 References:User-Agent:Date:Message-ID:MIME-Version:Content-Type;
	bh=j2D1du2BYVggkMdVOD8MY9XcRJqzHgm99w0SgPdi3cs=;
	b=fE9HJawZpDG5GsuUMJDnLSlK7H244razhdE2c/qmz3VvuPVugx68/UKL0OK/jZ5pWKLl
	 QtvtwzSuTryaxemV1E27vQ+tZXWEdBckqubMGh1bluqOZxHNcKrG/TKVpTBQQFkzeshwp
	 Kp7F0PK75saJNO5WB7m/AmizLFw5DnqdNiz1o1UlK+2HRYGqoovr5/Sw9gsdf/nL5ryAZ
	 m9IfhwIlJF/oIsfuBjc7ArhF2FNc1A2xSuRd9fcKRiMW1F0ezFvYNfS7joV/OVuTDdXMG
	 qoL62X3xvc0hsybXDRCp1b0d0UQ5zh5fOWOn8nchXPvAlEbFKu4NQ3N3tbzB0l/VNrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gouders.net;
	spf=pass smtp.mailfrom=gouders.net;
	dkim=pass header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=XKbk+u8o;
	arc=none smtp.remote-ip=202.61.206.94
Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B56606A680
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 09:56:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6B56606A680
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=XKbk+u8o
Received: from localhost ([193.175.198.193])
	(authenticated bits=0)
	by mx10.gouders.net (8.18.2/8.17.1.9) with ESMTPSA id 6AP9uVZM2454659
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 25 Nov 2026 10:56:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gouders.net; s=gnet;
	t=1795600592; bh=j2D1du2BYVggkMdVOD8MY9XcRJqzHgm99w0SgPdi3cs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=XKbk+u8onU2Zx1IPnfTtqtFhOzd2JfDHgRmcSSvplkTQ6ON/FRZoPLWncfenTxc+c
	 0MN/Ct3MvGUzZOAL+DqOoGM5EtlCauersdhn820arYf67AAZIZGjzylPeSIYU5A5VJ
	 SCm/hAkkKDCf5qeoRndZDbhqXYKozrBJmr+hg410=
From: Dirk Gouders <dirk@gouders.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,
        "Junio C Hamano <gitster@pobox.com>, Andy Koppe"
 <andy.koppe@gmail.com>
Subject: Re: [PATCH v5 0/4] utf8: bounds-related fixes and a doc fix
In-Reply-To: <xmqq5wxn8nrh.fsf@gitster.g>
References: <20261116-master-v1-0-dc2a50ce0aa0@gouders.net>
	<20261122-master-v5-0-313bd1bb3c45@gouders.net>
	<xmqq5wxn8nrh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Wed, 25 Nov 2026 10:56:26 +0100
Message-ID: <ghse0putdh.fsf@gouders.net>
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

On Mon, Nov 23 2026, Junio C Hamano wrote:

> Dirk Gouders <dirk@gouders.net> writes:
>
>> A patch here on the list made me look at
>> display_mode_esc_sequence_len() in utf8.c and I found two details in
>> the file that are perhaps worth a fix:
>>
>> 1) utf8_strnwidth() disregards the given len argument when fed
>>    with proper string and len.
>>
>> 2) The comment for utf8_strnwidth() is incorrect: it states the
>>    function returns strlen() for cases when it actually returns its
>>    len argument.
>>
>> Signed-off-by: Dirk Gouders <dirk@gouders.net>
>
> I had pointed out a few issues, but other than them the series looks in
> a very good shape.  I can see we are getting closer to the finish line.
>
> Thanks for working on this.

Thanks for your detailled review.  I guess I understood all comments and
will send a v6, soon.

Dirk
