Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B879851D53E
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 18:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790791411; cv=none; b=OtBztor5s2zF0q31YTwYuEFKN5rliTUsiHtBgesas6iJSVq5Siinv0YKQ8pie7vQeKxWCuT/Gzj/mTBGUqDFUBpgx+Lb1ydsqjEIEDH7+Y7E/5qe5kGPgNQTIixDcPJIedMEixuRAViLJoustyAQIyhKxHKt399p2EiFZVigORE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790791411; c=relaxed/simple;
	bh=W9kfl7kz7AeKYw9k1YNpd92TmLK+tCVR+0hhvZeETFY=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=fK5kD9TdmYat79rLjeGbPTyQ8xQEHmqPRj/UnCpe3JfO67CFaSXvKvYy5w0tk4gauoz4a/T65DbUu9oUUH1+We4oSswGwQM+fYjTy9i5pQPCx6KAMRABU3AvyAY+tuR14CWvSFqX92DThUCq2UJDKJGZUV6kLhfa/8q5tew3Zlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kFam+DZm; arc=none smtp.client-ip=74.125.225.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFam+DZm"
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48affb828f1so1105166f8f.0
        for <git@vger.kernel.org>; Wed, 30 Sep 2026 11:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790791408; x=1791396208; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dunLS1SSyejl9XXwsWqYlV31k+Bh/0XXHT4uaWx8OEo=;
        b=kFam+DZmKClnrlDgbsmlnPq7DnRl3+3r8s2VanEmHpq96E1CCWn4uKvsqd4dTKZLPK
         2/4Kvzi0L4Lx3zuEMvGMM1hyFDsii8TdbIqFAlidum9PmMHaXcsUfp3G2exq7x6SrCdN
         NTO9ZXMzm7Qiw03xTqi6UfAbu+mu7wBuFYjZJH4ZbXqJPPbUxOLseHZ5O3T6j/ukvf0s
         0HG92ZIIjC8cKKZ+rRyjIOOuYLOQOaGIz4GASKlXcoZf73U+w8Wa5zfPNmpDd7n2wZoY
         R/MPW9exZ+qmBwR20KcydDjBE7eaWjmCxrc0CWJAjIkTLDw0+MwqjTnY5TgBbhryS2AP
         JcfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790791408; x=1791396208;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dunLS1SSyejl9XXwsWqYlV31k+Bh/0XXHT4uaWx8OEo=;
        b=Zbdvy9+KOO6IT0x8gwFFHMIynJPn5y6I9R+F5uDqMSY47P3VwFuLBXeL/UvUujVph7
         m9M7q5r68FvzL9I99FKDDoXkCPVILiRL7NGgR2mBw96ftPv/sTBr+k8dQS5SwQOEOX0n
         0jgiVpxmF8a3tGnDnQ8Y/qaH0eGFv7q3bqO1NLdYyORkSRASgl5P3PtaFGVoJJ5OZm0D
         4b8193dm8H8cZH5mYpMhvcr7IS1Y8NLpwa2puZtm12SRMv3ohaHKYH7wIo4Kqh36syI7
         t6yX6f32CXSrLTXGtUL6YeLUcE/1+f2zAM4RbM3yBq84QhOOwGb9EYVA4yyWY18Z2dLl
         L3dw==
X-Gm-Message-State: AFq9FYLG0P3WGUywA32hSOJvIJIoKzw9jPspMF7ktlejDj0O/XHt5g7j
	zCg8x2nPzKQNjWDL6sOv4tTjtZqRxBuFReJkObj960jsq8Xy+LaE5Wue
X-Gm-Gg: AYBFou1OMlYJly/LmMw7THfkQooTre8Hylnx7AXdfUVVemCVI4HYQpGl0+NBY1T+QZ/
	ft8ikKaUE4DaX7Fdc20kxXXFBs19xXjp98qsQSYWcls9G2cqn+qviM+Wtw2qPNqrR7mKBLswpMO
	UAVsO7Ib94gHcr3kO3TKmNbOI41+ptDnI0X/o7dR2s0u1DB3Wr9YI+zw6Ac2VlLJyEFaJOIJDRu
	4ianuBzELESxQD+aVhcAfKkYlfxjqODP8Smeb/pAWrBFCPaEzMaCBSIIQCpG1ulJZYWpaXOB/Oi
	k7QEbNfMNhRjsDLi0QdQK3/xunSFdCAH4zE/57e0Mzh4UHL1UILlAcVKi9DGOH/LdEmSq9lWwMQ
	4OsjKoAoArgiUhKFmZwvnzLiJJVnbyCSvCFba4FBG6GItB03IucWdPp0Yfoi2+KurKUwwIOLwuC
	8wj5Sc2IBd2M6coy5OIWMfgD45/igGCmD52tanYdNStV7gfEZ/Di/H6/SLhnlJcGtzozGBUvWnC
	2WA3p9sDEwUT9HGQY/ce7GpRkejT2twL3kTSec2VQPgnFusBEf6iGjoxpqIlljnUgewTBWiwXzY
	70llSyPYDdfGm1Ipm4xUtAl3qfwWc7PidBpl93+yvsHkG6cZqgnuz4Wjuky7cLehnjUsj/aeXS+
	65ykQC25ThKb+dDZLUWXvwLs=
X-Received: by 2002:a05:6000:25c3:b0:487:c99:8bec with SMTP id ffacd0b85a97d-48b02427d63mr4735579f8f.3.1790791407548;
        Wed, 30 Sep 2026 11:03:27 -0700 (PDT)
Received: from localhost ([2001:818:c665:a700:5109:cb7:aac5:8093])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b0690d45fsm790357f8f.21.2026.09.30.11.03.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2026 11:03:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 30 Sep 2026 19:03:26 +0100
Message-Id: <DLSUKMRZHHGO.HVX98MB8KLSF@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, "Pablo Sabater"
 <pabloosabaterr@gmail.com>
Cc: <git@vger.kernel.org>, "Derrick Stolee" <stolee@gmail.com>
Subject: Re: [PATCH RFC 3/5] fetch-object-info: return a status instead of
 dying
From: "Pablo Sabater" <pabloosabaterr@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260930-backfill-dryrun-v1-0-1128f247ee01@gmail.com>
 <20260930-backfill-dryrun-v1-3-1128f247ee01@gmail.com>
 <xmqqwls2brca.fsf@gitster.g>
In-Reply-To: <xmqqwls2brca.fsf@gitster.g>

On Wed Sep 30, 2026 at 6:07 PM WEST, Junio C Hamano wrote:
> Pablo Sabater <pabloosabaterr@gmail.com> writes:
>
>> A subsequent commit needs fetch_object_info() not to die() when the
>> object-info capability is not enabled on the server, so that it can
>> fall back.
>>
>> Make fetch_object_info() return FETCH_OBJECT_INFO_NOT_ENABLED instead
>> of die()'ing when the server does not advertise the object-info
>> capability, and propagate the status through the transport layer so
>> that callers of transport_fetch_object_info() can act on it. It is now
>> up to them whether to die() or fall back.
>
> It may be just me but unless the client can tell between the server
> not supporting (i.e., they are unable to enable it even if they
> wanted to) and not enabling (i.e., they are capable, but are not
> willing to give it to you), it may make sense to report it as "not
> available".  "not enabled" sounds as if we know that it is the
> latter and not the former.
>
> The code change looks very cleanly done.

Makes sense, I'll rename it to FETCH_OBJECT_INFO_NOT_AVAILABLE.
The git cat-file remote-object-info command path die()'d with this
message:

	die(_("object-info capability is not enabled on the server"));

I'll update the die() message as well.

Thanks.

