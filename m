Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.61.206.94
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795120100;
	b=V0wGNwxlE6wqT5euFO6XpDISAa60PTMogigM2osk0guhGzutkwpC9UIGeV7O3ktrv50C
	 Qh1pyelHqu+FLjGX/bGNuYK0Ean4N+5DEn+gHE8DzmWn0KSRJ8+F3xV8djP0K94P7XoLb
	 D0FBdvKVR568huEl6HxDOnNdmbyR/x3Ah9Kz2MEgV8xDFsl9imPr3kksez/VTirSM6y60
	 X2+edVpbbuKtG5jS8YBMfQIO+8Z9pySgr1wJ6qqN6Wwrk3vgbOBzaAW43rX245RLk9Rxp
	 MeD8IqZEdH1wrsYm77ouc0rFaDUWmOQP+PVEQeJ0HGR+l1qiPgSc53dwJ0zQXW/SCpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795120100;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:
	 References:User-Agent:Date:Message-ID:MIME-Version:Content-Type;
	bh=WcPsQpv9PNdP0KzYiJLUF/Cgkblal5lkENfy1KYWiGA=;
	b=sfSzjA0nqS9sshVDumL3fjjC7Pta9aN5a1TMlBHCIQK6D+j719NPqebJMX3GCJYCFFPH
	 /NnSX9l5BFqIGneer3g7MKZtMVsV5K6UIHDN0MQVEsn4YpFYaz0c0L038I0MOUqTJDrPf
	 PnQ7+MBmWCZtDCOUzGX/++17k9Pc2HWDKyKkvbRtE1ZDmg9sA4xoZyEak+KW3z7viz5My
	 a24c5fkYMHeXgnfdam+yXX9QiKHVx5r3pW0sfqrnnunW7T5ZzOW6KvAuIk7zxj+q4if6n
	 9IVgULwdZjXGBw4qGWXZdOrRR5D9ANuJch20Et4ot8atD3U/8nEdWdcOL8+mdzJowZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gouders.net;
	spf=pass smtp.mailfrom=gouders.net;
	dkim=pass header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=qAIZYlFb;
	arc=none smtp.remote-ip=202.61.206.94
Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD308606A324
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 20:28:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD308606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=qAIZYlFb
Received: from localhost (ip-109-41-51-202.web.vodafone.de [109.41.51.202])
	(authenticated bits=0)
	by mx10.gouders.net (8.18.2/8.17.1.9) with ESMTPSA id 6AJKSCPx2016839
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Thu, 19 Nov 2026 21:28:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gouders.net; s=gnet;
	t=1795120092; bh=WcPsQpv9PNdP0KzYiJLUF/Cgkblal5lkENfy1KYWiGA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=qAIZYlFbOG6JmaDDFMtjOsJ+ya2gZwRq5DiaDeWrPWmxlMaY/UtWEwk7LwhRZCxU0
	 vVRV4Mdqx3N8KZ369t5yTaKZsUjg6p4TawJdG4ZIn1imsp5e8JS4MZNryySBEUlh0t
	 Bq4/ZVhmRhSbPsTmgMXgZfzRks+9c80+Dac2j1AE=
From: Dirk Gouders <dirk@gouders.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 1/4] utf8: add display_mode_esc_sequence_len_counted()
In-Reply-To: <xmqqik1swq20.fsf@gitster.g>
References: <20261118-master-v2-0-3f2aaec15d31@gouders.net>
	<20261118-master-v2-1-3f2aaec15d31@gouders.net>
	<xmqqik1swq20.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Thu, 19 Nov 2026 21:28:11 +0100
Message-ID: <ghv75s1s84.fsf@gouders.net>
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

On Thu, Nov 19 2026, Junio C Hamano wrote:

> Dirk Gouders <dirk@gouders.net> writes:
>
>> diff --git a/t/meson.build b/t/meson.build
>> index 1cf1d95f70..e224df58c8 100644
>> --- a/t/meson.build
>> +++ b/t/meson.build
>> @@ -27,6 +27,7 @@ clar_test_suites = [
>>    'unit-tests/u-trailer.c',
>>    'unit-tests/u-urlmatch-normalization.c',
>>    'unit-tests/u-utf8-width.c',
>> +  'unit-tests/u-utf8-ansi.c',
>>  ]
>
> Should this list be reordered?  "make -C t check-meson" complains.

Ah yes, thank you. The list in meson.txt must be sorted (check-meson
diff's the output of ls(1) and the list in meson.build).

I will fix the sorting order with v3.

Dirk

PS: The purpose of 154ce05cce (Makefile: detect missing Meson tests,
2024-12-13) wasn't to enforce a sorted order and maybe it would help to
put a comment in meson.build.
