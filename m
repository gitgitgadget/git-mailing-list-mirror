Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.61.206.94
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795074225;
	b=zqW4AlBaPdCLLPNfpB7C1ee/5/8IJ8NQd/gv7yCQ351Gno3CcSfeGXSxeejE2t3Qqmcd
	 WfE4H9YNhaa4q1Wys16VEU+tuFq5HDsANBDiKKePdQppacdLELvnWEMGRRI7+EB0W4+WL
	 x5bj3GhqsSEvacBSH4yjTCWNeivjG92xh5cWLvHvIXgDwq8iXG+75nfiuZHC88oqWeK6G
	 T42wb1DcaAD7TIbecC3OdVZyZO5mJFOtVqQA2jHG+9AfhtgLdP7jsu9BcoSR16UFcKIoo
	 zMVdA4sCzQ08bjyZxcEm2z8mgScY3wzl/XnoozrJu0Ao5JpkDbiLyWr/+2c4Uzc+Apw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795074225;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:
	 References:User-Agent:Date:Message-ID:MIME-Version:Content-Type;
	bh=1V2qDZEVlYkNc/gA88z6YcwCZ9VmHiXl+hmhj5r2A6A=;
	b=CfOB1h77mFiamFcY163mhz/FbXKnIwAWLr94z8f0Ud8unxVi2Gzm576nYixM5K2fxPIt
	 xinmn3dnJ0VlkK3xUVsJ50ATjFk5ONuqMm/W/ewTgBfqjJO+ZrFXXoGWU0hB/kt8xTf9E
	 EJ11eceoUhKp4ZXnuE0gSEAgPaN+zKJZ5fmUM/SoH1xNOzeQZiD8fs1v5H7hmR72rMai8
	 H/ZZRCPCNIOiV247zdYYqv/BGVU9PGQ7YTDRNLba7nTH1lMdM8UMsDnjcDfk5kjJZ1UpS
	 dyQRaJ6cenTTs6CKfrZ7NTSzzaDe+5RFVyoZm+VO+zQEFzeoLzazcUEj7wvTwnnCqOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gouders.net;
	spf=pass smtp.mailfrom=gouders.net;
	dkim=pass header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=KzRcZeQF;
	arc=none smtp.remote-ip=202.61.206.94
Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B78D606A324
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 07:43:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B78D606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=KzRcZeQF
Received: from localhost (ip-109-41-49-52.web.vodafone.de [109.41.49.52])
	(authenticated bits=0)
	by mx10.gouders.net (8.18.2/8.17.1.9) with ESMTPSA id 6AJ7hb5l1968466
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Thu, 19 Nov 2026 08:43:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gouders.net; s=gnet;
	t=1795074218; bh=1V2qDZEVlYkNc/gA88z6YcwCZ9VmHiXl+hmhj5r2A6A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=KzRcZeQFrfE/zl/pgMniFfF2cEKSqtE6waGRbB19A4AP+DQS1+3Ky1rBkndlZhT6I
	 Jc0GivWI8Lsn0ftIstgWrnjOe4Bre096L4G3ybEKh10/xy3O1757oAOGPqeVh3MU+P
	 X6Tm7/x9Nmv6EIX7ptvZ6xGECXmyAwDhJ0ad4taU=
From: Dirk Gouders <dirk@gouders.net>
To: Andy Koppe <andy.koppe@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/4] utf8: add display_mode_esc_sequence_len_counted()
In-Reply-To: <CAHWeT-aWx1VwUjM+hZ--jjSAbcMenz5Mw11y9ouFavGndUMrSA@mail.gmail.com>
References: <20261118-master-v2-0-3f2aaec15d31@gouders.net>
	<20261118-master-v2-1-3f2aaec15d31@gouders.net>
	<CAHWeT-aWx1VwUjM+hZ--jjSAbcMenz5Mw11y9ouFavGndUMrSA@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Thu, 19 Nov 2026 08:43:37 +0100
Message-ID: <ghse0x9sgm.fsf@gouders.net>
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
>
> Therefore I think that if the original implementation isn't going to be
> kept, it would be better not to provide the wrapper, and thereby make
> callers think about what they want to pass as the length.
>
> Uses on strbufs can of course compute it with `sb.buf + sb.len - s`,
> but they don't actually need this safety net, because strbufs are
> guaranteed to be NUL-terminated and the function stops at NULs.
> And the length calculation itself adds a source of errors.

There is only one user in pretty.c that uses the wrapper.
I can change it to use the _counted version and we could then drop the
wrapper.  Junio's v1 already included such a change and I could steal it
from there.

Would that be OK?

Dirk
