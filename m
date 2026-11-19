Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.61.206.94
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795127586;
	b=j0HsaVEWViA8EvVT72RRcqc35APdpNxqh6Sqp7EE8eubfuL6XIyEN5jLY9D0fIjnR/pP
	 EbJNzlnMjwuWQfxou/xhlbzLiW2Psf81GWqDr/gJtlAmtkq46a8EcWHdtNpAsZcz+iMOk
	 B4nTvBHuxuj0ls5wyqEYmNcwlphuMlVZGBSVfTnyBqhX91YL+DRe47gRUvzyXgN4cEigQ
	 m+s2hwsvcl1g/5gkXuoOfOOqJRzxv6fP4CdZHz+CYzZ7B0ZR19NQKSn5WV1Cnv2nPgFVK
	 jenip2/4qr4X2kssVO1lCc8Vthz7yUeKolLkCLQVLrsLVvXNZS5rhGfuE6hJffY6GTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795127586;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:
	 References:User-Agent:Date:Message-ID:MIME-Version:Content-Type;
	bh=zu2B2MHnNgcEuMJTSja57Ja5fTkUAOiCTHN1m8XuptU=;
	b=Ezeavpyw2uPh5FfowTNpiRUe026M9aE1s4XbYvsmCPDkZEKuCJLFf6L+JfVp/U2OaMpz
	 LYs2XGKzfV4nkSQvJ5RmyfbL0EDXrBPZYq/7fmGNospCrws5C/Zz0smvNBA4CuEjv+y5O
	 StWwGPYXFacjr9FcSCtORCrDyeSYvrYjHAQXxvbnvydFi/KiaIwtCvIAS3hhwRxHOgvsP
	 WHpQVUj2FZD6A7FOh/Jk0WefSo4Q0YwHfaAVSogVZhyvQOrQBRsp7WcLXxVhesz8ChIui
	 dcvFtTZYrZWqjAbOXTcKs8LIqFB2iSKcGjJX+bDkUX93pyQlcahk0AQcO3wJ1wKLJPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gouders.net;
	spf=pass smtp.mailfrom=gouders.net;
	dkim=pass header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=FFsiGY57;
	arc=none smtp.remote-ip=202.61.206.94
Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724CE606A33D
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 22:33:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 724CE606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=FFsiGY57
Received: from localhost (ip-109-41-51-202.web.vodafone.de [109.41.51.202])
	(authenticated bits=0)
	by mx10.gouders.net (8.18.2/8.17.1.9) with ESMTPSA id 6AJMWx8l2024289
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Thu, 19 Nov 2026 23:32:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gouders.net; s=gnet;
	t=1795127579; bh=zu2B2MHnNgcEuMJTSja57Ja5fTkUAOiCTHN1m8XuptU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=FFsiGY57H2aK8lN6AveoCtk3G9G0+Q5zvLZfu7lXUbhCESLlBAC1ynKSPWZP/v48b
	 6V26xye7m1nAV5XKDMR1TwEVI4V/JPPe+VhgQ82iCf9iCq3CXgvC7P5SJJrIP/G4V3
	 EdeFV12RQqFQCI83rWEP6b8aMbh1XL/DAmXEnTl4=
From: Dirk Gouders <dirk@gouders.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Andy Koppe <andy.koppe@gmail.com>
Subject: Re: [PATCH v2 1/4] utf8: add display_mode_esc_sequence_len_counted()
In-Reply-To: <CAHWeT-aWx1VwUjM+hZ--jjSAbcMenz5Mw11y9ouFavGndUMrSA@mail.gmail.com>
References: <20261118-master-v2-0-3f2aaec15d31@gouders.net>
	<20261118-master-v2-1-3f2aaec15d31@gouders.net>
	<CAHWeT-aWx1VwUjM+hZ--jjSAbcMenz5Mw11y9ouFavGndUMrSA@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Thu, 19 Nov 2026 23:32:58 +0100
Message-ID: <ghbj7k1mg5.fsf@gouders.net>
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

On Thu, Nov 19 2026, Andy Koppe wrote:

> Dirk Gouders wrote:
>> +/* Same as above, but for a NUL-terminated string "s". */
>> +size_t display_mode_esc_sequence_len(const char *s)
>> +{
>> +       return display_mode_esc_sequence_len_counted(s, strlen(s));
>> +}
>
> This is a performance regression compared to the original function.
> Calls that previously returned immediately because *s != '\033', or
> after a few bytes of scanning, now scan the entire string with strlen.
> It turns scanning a whole string for SGRs with repeated calls to the
> function from linear to quadratic.

How about creating a v3 for display_mode_esc_sequence_len() similar to
utf8_width() to accept an optional remainder argument?

If NULL is given, display_mode_esc_sequence_len() assumes a
null-terminated string, otherwise the length is given in *remainder.
The function can then update the remainder and return the length.

Just an idea.

Dirk

> Therefore I think that if the original implementation isn't going to be
> kept, it would be better not to provide the wrapper, and thereby make
> callers think about what they want to pass as the length.
>
> Uses on strbufs can of course compute it with `sb.buf + sb.len - s`,
> but they don't actually need this safety net, because strbufs are
> guaranteed to be NUL-terminated and the function stops at NULs.
> And the length calculation itself adds a source of errors.
