Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DABC8248C
	for <git@vger.kernel.org>; Sat, 17 May 2025 19:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747509930; cv=none; b=ILRhlPGpz+uRj901lO/gJoSGGa4CyOz3+k2CvyKB7IX6dN86YYtbo/vMkRxOooQrms4ODPcpTT25SylVT+Dr6KPs6aD8vZue/0i+FRl336+TKSlJoeEargyei5hPrXRlqQ5xd3bOMjGgRfHeg9UeCKHVFoLj4HTAc9VJlHRKLcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747509930; c=relaxed/simple;
	bh=WnzYygwWV+uDcGrkr2I+uiAI5Y7NtYDOCv7L6zTGt2w=;
	h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iLpF9I+p1LP9HOG+AZtRVnSesgecmV44y3q2xt3LG+/4D3I6rY719RihQJoj1zXm+3K4k+oYFbdP/h2aPzIflUAWNF20OFj2Z8AQxq9QNFx7gYXR1Bm5mb6ZPQgdj2Dq43sJFZ+VBbUwghnggowOAf6vsSRYnU1L22B3xaH15i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unrealasia.net; spf=pass smtp.mailfrom=unrealasia.net; dkim=pass (2048-bit key) header.d=unrealasia-net.20230601.gappssmtp.com header.i=@unrealasia-net.20230601.gappssmtp.com header.b=W2fyYSid; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unrealasia.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unrealasia.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unrealasia-net.20230601.gappssmtp.com header.i=@unrealasia-net.20230601.gappssmtp.com header.b="W2fyYSid"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22e16234307so31613705ad.0
        for <git@vger.kernel.org>; Sat, 17 May 2025 12:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unrealasia-net.20230601.gappssmtp.com; s=20230601; t=1747509927; x=1748114727; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vaGxD5GLDicG34g7TtSBam9UbABnH6oF1Sd5uD4lfV0=;
        b=W2fyYSid1rQXSdCXeqBnC74ntE+8Tiv+Ns78vaoDNFs3cLj1Mdtkky6kwxgMtYtp7B
         h9uLOXpk1QoqA1SZjfA8b6KGVbLc87V2h1ApZktoUw1h9ZoCjYL5mIIqF2WGq8jcFVKc
         raClFnoh2/iejDlhUf/e43xZfPcuzknxp2i0lwPhxi5C2BQQVKQNXmr9yTY2wiNkjC8M
         9dVTTfRn+fxn/eCyLCQ25iNKDbcp0h8DBimbOEsugka+k8UsKm4MmWYInXykOUNP0sQt
         Dg4uC9zhl8UXLq2nYpfS15LjkTMt0piQSYUmxYd9emw8LLhtC6ogRTnLstDIwG2DiWg1
         A9wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747509927; x=1748114727;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vaGxD5GLDicG34g7TtSBam9UbABnH6oF1Sd5uD4lfV0=;
        b=X1NwtgJRxKRQENvzLt7TV78ajyYeO8U5j9GiyN1t9QHeS9cbAWNSgmkuzrOy9IfuUh
         mzMC8PLU0Z7+h7Y0OVXtgDZrH6W4Hhx/AOZzKFqoiRsCKF1cyR9j/UsALpBn4ChEJYqQ
         T/kVA8B1J/yqzBNjGnm2Sw3V1WMjjPdj/yG7gyyOVx6g3DwneGdfIwEQi1lGPfqE91SN
         kSDi6ePQUHN/sXKraquwLuD8+DuoZKGBYNN18b1FzPK2fHTMzIxtPVslzzlTLF/9k8Sb
         ztrLUD0uA3IYVyL8Jrbuou+QrmdDc/t1RUy4DAtGUu8sV7TNWnfc6hukzx6n+AcZrhk6
         7Z+A==
X-Gm-Message-State: AOJu0YwDxvr2RW8bX2nqzoR4TgaXuFRQOcR5ojZhsetFwVUFWpBv921b
	TDmhuYXJiioir5unqC+Nt7CzLunTdMx37NUsQyXKPaxRZVE8T5rB5vaVxEDXNw7lDbSLnjoZGTE
	jGcYq
X-Gm-Gg: ASbGncs8Gsv2qFKoIK6Eb8zskCVUb9B/QyFJ3U+LmWK3fLC1tKJm+T+4a/G7t5k8ifq
	IaYoVyCE9NOTqsr2PmnJPksWV5CoieLA+B5coA2+W9BiGxavXnokjtbraQnC+NgfJux3271PvS5
	9RloJMwOk/kgU3qhhPuKwIsImHk7FMvzYsHmhwdPguLcp/LVA727N1FFKKxvZw8TAmlCSwaYK76
	35W1Av3V4fKaUUNkclZyM9z/hfWYQZ/RXFxf3C9jUIPbsDXQL0W214gwLDxwh05lYUVFjEwjSPn
	oQrEf5gUXmsxzdB6Yx3bN0RS61iTT7ni+ZbtRe3ML+lmjYPjuxYSC//a+YmhAbkEz48=
X-Google-Smtp-Source: AGHT+IGJAJ+eRJ6g3ihC4imgVUxV9Ppwt1Vf+UQrsBs2Kf5+WFx/XgsmYvOLmROdrrsiu3OqOZM+eA==
X-Received: by 2002:a17:902:d2cf:b0:221:89e6:ccb6 with SMTP id d9443c01a7336-231d4ea09cfmr109437315ad.25.1747509927429;
        Sat, 17 May 2025 12:25:27 -0700 (PDT)
Received: from muhammads-ThinkPad ([2402:1980:824a:b6f7:7ddd:bcc9:e7f9:46b1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4ac9603sm33714005ad.30.2025.05.17.12.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 May 2025 12:25:27 -0700 (PDT)
Date: Sun, 18 May 2025 03:25:16 +0800
From: Muhammad Nuzaihan <zaihan@unrealasia.net>
Subject: Re: PATCH v2 [1/1]: MPTCP support for Git on Linux
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, "phillip.wood" <phillip.wood@dunelm.org.uk>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Message-Id: <4A7FWS.KARM6LOQBQ5S3@unrealasia.net>
In-Reply-To: <xmqq5xhzqdmz.fsf@gitster.g>
References: <6O0FWS.8JJP67DO2U1M1@unrealasia.net>
	<Muhammad Nuzaihan's
 message of "Sun, 18 May 2025 01:02:30 +0800">
X-Mailer: geary/40.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed

Hi Junio,

MPTCP has been in development for 15 years and only reached maturity
in v1 of the protocol.

Only recently in 2020 that this protocol (v1) was officially merged
into the Linux kernel mainline but before that Linux MPTCP was developed
out-of-tree.

Apple had been using MPTCP in production for the
past 12 years for their iOS[1] for Apple's cloud services.

It's no longer an experimental technology it's in the IETF standards 
track[2]
and no longer in experimental track.

I know it's cumbersome to implement MPTCP for every application out 
there,
the same with IPv6 which already had been around for more than 20 years 
and still
not that widely adopted, especially for enterprises.

But i think we have to start somewhere. I myself had been working on 
IPv6
since 2003 and i think the late Jun Ichiro Hagino probably did the 
right thing
even though people around him might think otherwise.

Anyway, back to git. I think it will benefit the server side more with
aggregation but i started to work on this after realising how bad my 
hotel's wifi
and i have a WWAN module and thought of aggregating my bandwidth.

Since Go is enabled MPTCP by default in 1.24, it makes sense
for me to add more MPTCP support, at least on the Linux side of things. 
Go
is really popular not just web services but also load balancers (which 
can
also be TCP load balancers).

I cannot vouch Linux kernel's MPTCP implementation as someone had 
mentioned
about the CVE because of backpressure but that CVE was in 2022, 3 years 
ago.

Go 1.24 with MPTCP by default is only released this year, so time will 
tell. :-)

I think eventually just like IPv6, people will have knowledge on how it
works.

[1]http://blog.multipath-tcp.org/blog/html/2018/12/15/apple_and_multipath_tcp.html
[2]https://datatracker.ietf.org/doc/html/rfc8684

Regards,
Zaihan

On Sat, May 17 2025 at 11:46:12 AM -0700, Junio C Hamano 
<gitster@pobox.com> wrote:
> Muhammad Nuzaihan <zaihan@unrealasia.net> writes:
> 
>>  Hi,
>> 
>>  This patch is about Multi-Path TCP.
> 
> Perhaps reading and following Documentation/SubmittingPatches and
> possibly MyFirstContribution is in order.
> 
> How widely is MPTCP adopted?  I somehow feel that it is a losing
> proposition to _require_ that each and every _application_ to be
> updated to support it, but say if we take a random set of widely
> used application, how much of them have specific knowledge of how
> to work with MPTCP these days?
> 
> 
> 


