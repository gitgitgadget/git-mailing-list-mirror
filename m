Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F72217704
	for <git@vger.kernel.org>; Sat, 18 Jul 2026 19:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784401242; cv=none; b=uNHF+i6CGNK3py6z5ZokvQ6htCqOU9hM3Bdb60CzJEU/7jafpf2Qhwz2GmyDmL1k3PSoLSHYgEgenw6GWOZJHA51rMntyKaDNuJ62jkVT/ZcUcyjluBOubm0RfNiQLZ6JCINNcGPYRAZ7lpWDUScTZ+sHMyEuskZzZfyg3WFdX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784401242; c=relaxed/simple;
	bh=lPKZ9vmQuhGsEIXwnbStCwV5NAJggEzAUnDcRrZAG1Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=GQb1ho1fyPRmOB9nMl6/4kHzLnAnko0p6rBFSJGF8eeUNRwtkqxFmsC4J2GUYpGQqMFjl5PRqLo5TG9OM4htLO03ms39X8F0Z8nhEwlzR0ig9NYBmTJDHXSxqnxCm4j1QIvyZPRRrCTGLz5pzzERSj2aoJ28hdhPZ2M6Up5dp54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dBKk9zfJ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dBKk9zfJ"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49556f97a9dso1044475e9.1
        for <git@vger.kernel.org>; Sat, 18 Jul 2026 12:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784401239; x=1785006039; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QQLK+t6tEPsefVMN+6IwFcXrtdnsCrexDij1qxySa4U=;
        b=dBKk9zfJNtf7sPU85ZnCZtNpZ16U7v+wq5oU4R2obp5ZIz8hFBz6HWCYlH2Ysl5WCO
         nUN4HGA8Pkl1JljPbtb9llpapGEqUBa+i4Ss3sIoClxJonrW7yvN/x1ft+QI+w+cj//j
         im8aWAsCUrXaARtPYlhS0F2ryzsnTBwlAE4+mKFRJKe4l1eSbPICkPi4qNNHb37vBPXf
         MRppm1GeB7LuUBijq1NCbIq7bbeIi7BcRaaLqnG7b3M7qQ6XQZbUdfmyAWwM1Lulnmkk
         IDPowsZYwQ+LhKyuI6Cn8e1xnNR/qqC5uuZAVkv+NepO5BQ+J7qvE06acaRAlLz2xQu2
         52gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784401239; x=1785006039;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QQLK+t6tEPsefVMN+6IwFcXrtdnsCrexDij1qxySa4U=;
        b=YezxUSiweZOHmD1f3zgkKzAk5eY+46tXq4UI1TPrhOThhR/ojf8dZwK1x73FYNVVvL
         d2NZATiKI65NL45AIKHwq7splzafntJ4MaY0ELDHi1wcYg56QC+NU+FU6VOTl4yZpE0f
         mx6hIJZ44htxFdUwVQnHf6Xi54wBzi96vLqvvS4QQePlhTUI5Zzd/Mhwef0dfPKx5sC9
         WwDebMwk/FcbJiQ4yER7iyiHuXSzw79V3L+fsBI+jhTKv/uf67yA+T6+9p48yYMpXghW
         lneyvhlDdCNfIsCKuxHSTpwXpSs8ymlmb8poMfQ4Y6wUHMasSrrCT/Klr19OG/ne9GrP
         Ndqg==
X-Gm-Message-State: AOJu0Yz4opWnmLWFcxsVzqIz+Q0J/YGmTxoiVm0aZLKO1JdoAc5Ij5Yv
	4LR2RPVXeZ6MMOQZ/twukeF0AOBI+pPFAheW7v47zSxgMPATYhClJV23
X-Gm-Gg: AfdE7ckWNXERsXfKmKRVq6RhNg1vbc95qXrBt8Zp96cReYLJdPrU5ZrK5L04AcnZUlk
	AL/ka/V+qJ1xatJnn8FljjxlmPFqmB/OlSVl5VZpqteBwWNo1BJhQsx0qrw7lzsTAl898T1fPJI
	kNM9g2n3NgTBIre9zTDLVwgNoE2IjqsbqSHAcEwaREnHICd0hWcSQwuuTNKVeFilF99vKC6oV0w
	rpoLuRMC9wkVG5PRkkqM83e57b107u64QIsPxmUPq0aSXYl0yFuP77LUnn3WYD3zUuABfdeHg8P
	zVtV8F2W1JlhV4pValW3LPLoAbXbTEMvB8eqWU+QmLuWGyMSHLz7LiC9Q3cOiTgglHQan9SLKGV
	trxiihylyI4JvnuabOgAomTZmKOCxfZbqZ0kFlgl6zsbyI5urE+gZbsVn9NWnL14oPhCLyco3fZ
	gCvx/OxaS5EgRf/0FCfNU5gLCzD6EWTTrbEgP3TfrvKRVi5Dji7U3fPa2MaLYtbLbYO85u2O65k
	j7dWEPeuuSFyRHaRkn6V6vNo4StsGsICg+GvdlGp+A9mGEKAkEB7oacfw62Xp91qyFjtpkSQAIu
	Tv34JC1fBk/i3j3frIyCM7ryGn8=
X-Received: by 2002:a05:600c:19cd:b0:493:f764:1f69 with SMTP id 5b1f17b1804b1-4954a3d0889mr94855935e9.8.1784401238388;
        Sat, 18 Jul 2026 12:00:38 -0700 (PDT)
Received: from localhost ([47.58.6.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e51986sm16383205f8f.11.2026.07.18.12.00.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Jul 2026 12:00:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 18 Jul 2026 21:00:34 +0200
Message-Id: <DK1XG2LQP0PS.33L27O783LXE4@gmail.com>
Cc: <git@vger.kernel.org>, <chandrapratap3519@gmail.com>,
 <chriscool@tuxfamily.org>, <eric.peijian@gmail.com>, <gitster@pobox.com>,
 <jltobler@gmail.com>, <karthik.188@gmail.com>, <peff@peff.net>,
 <toon@iotcl.com>
Subject: Re: [PATCH GSoC v19 05/13] fetch-pack: move
 write_fetch_command_and_capabilities() to connect.c
From: "Pablo Sabater" <pabloosabaterr@gmail.com>
To: =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, "Pablo Sabater"
 <pabloosabaterr@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260715-ps-eric-work-rebase-v18-0-34d7adb051bb@gmail.com>
 <20260717-ps-eric-work-rebase-v19-0-d4faee35764b@gmail.com>
 <20260717-ps-eric-work-rebase-v19-5-d4faee35764b@gmail.com>
 <alvHUX68McwlEau2@szeder.dev>
In-Reply-To: <alvHUX68McwlEau2@szeder.dev>

On Sat Jul 18, 2026 at 8:34 PM CEST, SZEDER G=C3=A1bor wrote:
> On Fri, Jul 17, 2026 at 05:05:15PM +0200, Pablo Sabater wrote:
>> In a subsequent commit write_fetch_command_and_capabilities() will be
>> refactored to a more general-purpose function, making it more accessible
>> to additional commands in the future.
>>
>> Move write_fetch_command_and_capabilities() to 'connect.c', where
>> there are similar purpose functions.
>>
>> Because string_list is only used as a pointer, use a forward
>> declaration [1].
>>
>> [1]: https://lore.kernel.org/git/Z0RIqUAoEob8lGfM@pks.im/
>>
>> Helped-by: Jonathan Tan <jonathantanmy@google.com>
>> Helped-by: Christian Couder <chriscool@tuxfamily.org>
>> Signed-off-by: Calvin Wan <calvinwan@google.com>
>> Signed-off-by: Eric Ju <eric.peijian@gmail.com>
>> Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
>> ---
>>  connect.c    | 34 ++++++++++++++++++++++++++++++++++
>>  connect.h    |  4 ++++
>>  fetch-pack.c | 34 ----------------------------------
>>  3 files changed, 38 insertions(+), 34 deletions(-)
>>
>> diff --git a/connect.c b/connect.c
>> index 47e39d2a73..31e5ab958b 100644
>> --- a/connect.c
>> +++ b/connect.c
>> @@ -700,6 +700,40 @@ int server_supports(const char *feature)
>>  	return !!server_feature_value(feature, NULL);
>>  }
>>
>> +void write_fetch_command_and_capabilities(struct strbuf *req_buf,
>> +					  const struct string_list *server_options)
>> +{
>> +	const char *hash_name;
>> +	int advertise_sid =3D 0;
>> +
>> +	repo_config_get_bool(the_repository, "transfer.advertisesid", &adverti=
se_sid);
>> +
>> +	ensure_server_supports_v2("fetch");
>> +	packet_buf_write(req_buf, "command=3Dfetch");
>> +	if (server_supports_v2("agent"))
>> +		packet_buf_write(req_buf, "agent=3D%s", git_user_agent_sanitized());
>> +	if (advertise_sid && server_supports_v2("session-id"))
>> +		packet_buf_write(req_buf, "session-id=3D%s", trace2_session_id());
>> +	if (server_options && server_options->nr) {
>> +		ensure_server_supports_v2("server-option");
>> +		for (size_t i =3D 0; i < server_options->nr; i++)
>> +			packet_buf_write(req_buf, "server-option=3D%s",
>> +					 server_options->items[i].string);
>> +	}
>> +
>> +	if (server_feature_v2("object-format", &hash_name)) {
>> +		int hash_algo =3D hash_algo_by_name(hash_name);
>> +		if (hash_algo_by_ptr(the_hash_algo) !=3D hash_algo)
>
> hash_algo_by_ptr() returns an unsigned integer, and comparing that to
> a signed integer results in:
>
>   connect.c: In function =E2=80=98write_fetch_command_and_capabilities=E2=
=80=99:
>   connect.c:726:53: error: comparison of integer expressions of different=
 signedness: =E2=80=98uint32_t=E2=80=99 {aka =E2=80=98unsigned int=E2=80=99=
} and =E2=80=98int=E2=80=99 [-Werror=3Dsign-compare]
>     726 |                 if (hash_algo_by_ptr(the_hash_algo) !=3D hash_a=
lgo)
>         |                                                     ^~
>   cc1: all warnings being treated as errors
>   make: *** [Makefile:2924: connect.o] Error 1
>
> This was not an issue while the function lived in "fetch-pack.c",
> because that file uses #define DISABLE_SIGN_COMPARE_WARNINGS, but
> "connect.c" doesn't.
>
> I think as a preparatory step the type of the 'hash_algo' variable
> should be changed to unsigned int while the function is still in
> "fetch-pack.c" to avoid this; you'll convert it in the next
> patch anyway.

Thanks for noticing it.

Yes, then the prep patch needs to be done in fetch-pack.c before moving
it to connect.c.

I had it after because 2 hunks of that patch fixes calls for connect.c
so this way there were all for connect.c instead of mixing.

[snip]

Thanks,
Pablo
