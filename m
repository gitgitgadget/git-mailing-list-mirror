Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.61.206.94
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795339189;
	b=3GYfBRBEYatmIGfAisi5GDDggdHhUmlsBzX+G85J7+OykHVI4Ups6ozStPi15v+U5CBO
	 Dwh1uZwQHVdMvAvP6/NM/+sq5996F05mlC/WQIsAl/mqLoVCjvCgxQeya3BhrR1pAnmfQ
	 BtrWIq0aBptcWYq/4/5d/+yZijTLsB2Pyubi+oK7eMzHGBvHYG9AWvKQ4m1uiT6ahCdaf
	 RsC9mJcguToNrXLsyYBaA8Wy9nRsr4k7yx4sZeXhh0sWa2L7/ASHbHUF8FVAkSWOk1rwF
	 PbPcnj7pzfdikLMrkktTWcFw/xqt+cPrxhNcuin714ERBML+kCh6P8jttWLQ95Kjbpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795339189;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:
	 References:User-Agent:Date:Message-ID:MIME-Version:Content-Type;
	bh=sG43kIip7T2QEG68nqDoDB95wE7xo/LG/E+NjZ47A8k=;
	b=aYLEfgjl4wJkq9gKPL3eW9rwD8JpgzzFn5tSk5QfQXQ8MrXCvHKAaZYAry+Avocp8HGv
	 c9fTp2qIittYOUYLiqxsGx3QQdLpo+YBq4Fl3PX+Po8tyh0cw5Hg5n4L+piBTIBbgRs3g
	 zRkewhicVXvjJDV483SKXFnWrdLT5miqTX4jdcQmsno9uAolpP0RLOHXMjvURdedCdIer
	 pTt2h86BxK8fFr30SYT8FkxMcmqlLOo4EuayuTjINAT9CAtt/vA2L2YhT9A9R2GIB+sHY
	 MGUMpHvBZuQmS3KlAJCgS8uHq1AQ1iyqs7kRMiJVlPU+M60QpHUsi/mq6P/MY4I9/2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gouders.net;
	spf=pass smtp.mailfrom=gouders.net;
	dkim=pass header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b="aYuf/vLl";
	arc=none smtp.remote-ip=202.61.206.94
Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8737A606A33B
	for <git@vger.kernel.org>; Sun, 22 Nov 2026 09:19:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8737A606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=aYuf/vLl
Received: from localhost (ip-109-41-49-183.web.vodafone.de [109.41.49.183])
	(authenticated bits=0)
	by mx10.gouders.net (8.18.2/8.17.1.9) with ESMTPSA id 6AM9JYQY2216543
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sun, 22 Nov 2026 10:19:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gouders.net; s=gnet;
	t=1795339175; bh=sG43kIip7T2QEG68nqDoDB95wE7xo/LG/E+NjZ47A8k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=aYuf/vLlFGwwMLXvpRTL4sazMqimlKl2jT1BlQm9TeBhCSDUprBoM/lEWVSwXIZ1Y
	 cX9OEu8oy40ngjDAweWEgqweJa2X9yf2yiQTPd7DvL08aKBMk5AT46pQQK4ijq00uh
	 qR6VtH8ayIpeDxf040GphGcsZPSmsyN4CYDRxz/Y=
From: Dirk Gouders <dirk@gouders.net>
To: Andy Koppe <andy.koppe@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 0/5] utf8: bounds-related fixes and a doc fix
In-Reply-To: <CAHWeT-YEEXzx2Asczmd9tPY6gGO2FbY9KBpnGH1kJe2BgwxKBg@mail.gmail.com>
References: <20261116-master-v1-0-dc2a50ce0aa0@gouders.net>
	<20261120-master-v4-0-5ff523db7285@gouders.net>
	<CAHWeT-YEEXzx2Asczmd9tPY6gGO2FbY9KBpnGH1kJe2BgwxKBg@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Sun, 22 Nov 2026 10:19:33 +0100
Message-ID: <ghtsl9mdei.fsf@gouders.net>
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

On Sun, Nov 22 2026, Andy Koppe wrote:

> Dirk Gouders wrote:
>>
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
>
> This no longer describes the series, which I think has become a bit
> unfocused. I'd concentrate on these:
>
> - The comment fix.
> - The optional end pointer for display_mode_esc_sequence_len(), and
>   changing the callers accordingly.
> - The end guard after the display_mode_esc_sequence_len() call and the
>   bounded utf8_width() call in utf8_strnwidth().
>
> display_mode_esc_sequence_len_all() isn't needed for the fixes, and
> I'm not sure it's worth adding.

Yes, I also think that is only noise and I already dropped it.

> As the series stands, patch 4/5 doesn't build, because `skip` is
> undeclared.

Thank you for testing.  I noticed a mistake I was doing when resolving
merge conflicts (and of course not test-compiling even after "trivial"
changes).  That should be fixed, now.

Dirk
