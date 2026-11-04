Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793816887;
	b=I8Vp5PUZlK1ew3zUUi1wtoVmwR/ZBtwnrd/xbAXwDhmiEJ5rppeTQebmxeQCkUcNIlgW
	 Hh3ChSPZKxNn2u6EnIzEfVPdAZc43uU+Fk5hL7uCIBfunVIPH0JKU3V3LZKCT4LzGb0Ku
	 KY9NvSIpvfB0I/iO13fvmyTaZLHKHnUZdBwoGD3FSCOA6mbyelRLG3EzRJyIeb6Ymv7zx
	 cpspirWfOakC3p+F6kVyRbmpaKCElaoX5T+k+YuuFK5h1hv3UqRgzsVS9K1JIzioieT9p
	 9MNZymErq/46tnKYiia0cWUrnPunVDut1yDKUE9Bz3su5R3ieSpUgnQJ/s3hbvn5rfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793816887;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
	 From:To:X-Mailer:References:In-Reply-To;
	bh=CJV5CRWYtpeS+0igPrweO+tsB4keYysWAqLhR868Lkg=;
	b=RPSNI089/OhCbQMjnu1StHuajlFs9qfcwS57cCdCl5fiRuoBnzkF/v1kctYZbTbH1xiS
	 niieu4wbP89iBPYaTPjQwtyvdnu4uxbNh996iWzQ12aMBAxRtRdm2cSJr+wSdksiAzEul
	 ceuqO63HdqnoruOB8JoDiDtFs7MGiOBnW7C3oHex5kb2eAbAsdpXnRjpQkuj9b/xDoOGm
	 sEmMF2uvuz70aEio9juZQcaAMQt3XsWzcqffb5cefWSutKz+rvq724HibdgQwBWpDkRMt
	 VfMrfxV6+Kk8+bjOxuccFNEwkF0ON30wWIBCCoa5Kz092HgXTDrKIgHZ4HxkjEcRwQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B3+75E6W;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169B3606A339
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 18:28:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 169B3606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B3+75E6W
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3b09a83d12aso522464a91.2
        for <git@vger.kernel.org>; Wed, 04 Nov 2026 10:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793816886; x=1794421686; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CJV5CRWYtpeS+0igPrweO+tsB4keYysWAqLhR868Lkg=;
        b=B3+75E6W8FuQUn5c5ELPzq/8ryZPA+dpJEzueRY/zLWwR7CHgDdYPgPRIvzWE2gNqm
         WjFkHs0N7SWaoMspcv/fc8TFl+rrbimTKXM788UmvoDMWXF1v0JpFCk6y2ItIWDYD3xU
         P6Id03LYfk3kEyhptZRbdcFMlQV43YH+xeMvACypjt2HfWnjWNF6UsZvg+wp61Z/va41
         CM0MFgAsY58hEJpA9hGSQEWKoTufeoVmpJpPo4PY8nYHG/Au550oqLhJIlfzEszsT/dj
         Wq5NnTyXHar/1+eIex7O7ZXtpUFRIbv5/J/sNC3SY3STTfqpd/cPO0DJFn9q3yw9Bo73
         djuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793816886; x=1794421686;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CJV5CRWYtpeS+0igPrweO+tsB4keYysWAqLhR868Lkg=;
        b=nwuTzIs/Gn7AdPl1fKphgdSPwWtlQDnbNijbINs0Tk3Mo19R0W01gW5p1wWE+v83Tw
         MigKc5mfiIkmy7hzYFOBMO1I9n57Of0aLxA9uSyGUj2XYI+l1HFxm+foo/kCDSjo8xxB
         g0n2H28gmyP519GzCVwdn2E9+BDkkAxSGS3yyNYOQuuiwBcc538R0JD9d9uE6Y84Wkpf
         t8h9J4KC7yfEypczcxc9P1ZNboK3JKftixatT9CEazPVX2ZLrbeMLc1L1L3VW8KjY30E
         0jtH7lPSlcMUDKa5HU48bnq4ApkK5LhtkYbwPYXcVn5W8zKWSu0/6Ftypc1sR3x1pP3L
         YhOw==
X-Gm-Message-State: APuU4Z9udq6C5OqdACNvul2n29Nl3u6JqEpCFkj7vvr7VB4D3bBR2hZK
	Huv6ABAlbRy9ciwxUqlm/OlatyxYq5DClpCI3JDIF4KOMtWO3JiMKkoV
X-Gm-Gg: AYBFou1OR63VMJwRhhk4yD1LLaTlq5j6nEm/sE6t0Qnnvx8tqrpZb7o+hX+sdxcyXwu
	kKqexb3RRmG3Xiqu9dK9gAhY8jRRhdonXNhxNccsrIvuvUMY+A6FKHFvfK0AAkSMm3w7Y0jltEk
	zVdL0F7zL8n0VaMsv3J3aDe6RFvD+NZvCCDNKkZ3lQof5iTiwC4VqzNIC+YcaqCgwGuzvSZHCUR
	K+tRyTi6xLqYvveaX365ZjT/m2ahhX0ZWo0K6FK+Zuz6P7HHQFzEDMZEdSzOXUjXdEohJX0l02c
	gBkpcVI7HcxIRsOkhYJ5gPoG6Z5V0sKkvylVYir6lu6MhoYPTu+R54zI/+gp1JOQWIRp5i6Fqol
	u4FcTGPUOPNzQzqeS6bNyDmuLqReAQdtlJMItz1GBpxFbIuipjD5tt3D1vC24FyUxn8dCeC+CUn
	WzpzlvjWVYGLr0Z04soURgkBHEVARsaf4ZG51G3YWI9rKM2YyoEVcDVbtTtOVKadLIB5NG8k51t
	2ldYQXABWZiM+w5msHvF1uKEUpVVX+6T3izqywzcZo1R7QTH8OJZV+0ZFpOu60CSf1Tspob8dhq
	2FX6k3BecZvx5OrZW9be4PdCid5C+gb0qAkHGGR6s1ozgnV7iVAJMfI=
X-Received: by 2002:a17:90a:d24d:b0:3b0:968f:fdef with SMTP id 98e67ed59e1d1-3b0968fffb5mr2268245a91.49.1793816886402;
        Wed, 04 Nov 2026 10:28:06 -0800 (PST)
Received: from localhost ([73.222.46.22])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b3265a52sm96117a91.10.2026.11.04.10.28.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 10:28:05 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Nov 2026 10:28:03 -0800
Message-Id: <DMMN0K2447KN.36D8GZ1EWAVP0@gmail.com>
Cc: <git@vger.kernel.org>, "Junio C Hamano" <gitster@pobox.com>, "Jeff King"
 <peff@peff.net>, "M Hickford" <mirth.hickford@gmail.com>, "Johannes
 Schindelin" <Johannes.Schindelin@gmx.de>, "Jeff Hostetler"
 <jeffhostetler@github.com>
Subject: Re: [PATCH 2/2] credential-cache--daemon: do not take over a
 running daemon's socket
From: "Farid Zakaria" <farid.m.zakaria@gmail.com>
To: "Patrick Steinhardt" <ps@pks.im>, "Farid Zakaria"
 <farid.m.zakaria@gmail.com>
X-Mailer: aerc 0.22.0
References: <20261101-fz-credential-cache-race-v1-0-28f0bac51e11@gmail.com>
 <20261101-fz-credential-cache-race-v1-2-28f0bac51e11@gmail.com>
 <aumUyl6MQa43OFBs@pks.im>
In-Reply-To: <aumUyl6MQa43OFBs@pks.im>

On Tue Nov 3, 2026 at 12:01 AM PST, Patrick Steinhardt wrote:
> On Sun, Nov 01, 2026 at 03:29:26PM -0800, Farid Zakaria wrote:
>> When no daemon is running, two "git credential-cache store" run at the
>> same time each try to start one. unix_stream_listen() removes whatever
>> is at the socket path before it binds, so the second daemon takes over
>> the socket of the first. The first daemon keeps running, but no client
>> can reach it:
>>=20
>>  - the credential its client stored is lost;
>>=20
>>  - "git credential-cache exit" does not stop it, and it keeps the
>>    password in memory until it times out;
>>=20
>>  - when it does exit, it removes the socket of the daemon that is
>>    still running, losing that daemon's credentials too.
>>=20
>> The fix is to create the socket with unix_ss_create(), which the
>> simple-ipc server already uses.
>
> We usually write commit messages as if instructing the code to change.
> So: "Fix that by using `unix_ss_create()` instead...".
>

When I sent V2 I will fix this.

>> diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cac=
he--daemon.c
>> index 0dfa11e2ec..de6720c276 100644
>> --- a/builtin/credential-cache--daemon.c
>> +++ b/builtin/credential-cache--daemon.c
>> @@ -231,12 +232,26 @@ static int serve_cache_loop(int fd)
>>  static void serve_cache(const char *socket_path, int debug)
>>  {
>>  	struct unix_stream_listen_opts opts =3D UNIX_STREAM_LISTEN_OPTS_INIT;
>> -	int fd;
>> +	struct unix_ss_socket *server_socket;
>> +	struct tempfile *socket_file;
>> +	int ret;
>> =20
>> -	fd =3D unix_stream_listen(socket_path, &opts);
>> -	if (fd < 0)
>> +	/*
>> +	 * Two clients may each start a daemon at the same time. Bind only
>> +	 * if no other daemon is listening yet; otherwise leave the socket
>> +	 * to that one, and our client will talk to it.
>> +	 */
>
> This explains what you do without giving much context why you do it, so
> this comment is somewhat useless. Most importantly...
>
>> +	ret =3D unix_ss_create(socket_path, &opts, -1, &server_socket);
>> +	if (ret =3D=3D -2) {
>> +		printf("ok\n");
>> +		return;
>
> ... you mention that you write "ok" in your commit message, but you
> don't explain why that's the right thing to do. So why should the daemon
> pretend that everything was alright in the case where it fails to start?
>

The client in builtin/credential-cache.c:spawn_daemon() reads the
daemon's stdout and dies with "cache daemon did not start" unless it
gets "ok"

"ok" is part of the protocol between the client and the daemon. The
client expects to see "ok" and then it connects to the socket.

I can put this reasoning as a comment in the code.=20
Following Peff's suggestion, I'll also exit(0) there
to make clear that this process is done.

>> +	}
>> +	if (ret < 0)
>>  		die_errno("unable to bind to '%s'", socket_path);
>> =20
>> +	/* Remove the socket at exit only now that it is ours. */
>> +	socket_file =3D register_tempfile(socket_path);
>
> This comment doesn't really add much value, if you ask me.
>
> Patrick


