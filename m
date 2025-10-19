Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC312E0B47
	for <git@vger.kernel.org>; Sun, 19 Oct 2025 14:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760884303; cv=none; b=ZOdgN0eJL08DMrgGQNEAYX8DX4QncH9mf/5aWHqUW0SwWhhDHyk7JzpZcot8viNxg0rcknUQAW8Cg9oUmyQEU64222nGcAxFi/4SvY4v04mSe0mzxUmCbS1SLfBerkE+mwRnXhY1HWMC8dHG3iAk3HazxDPS4NwQ2QSCQEcui3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760884303; c=relaxed/simple;
	bh=YZ0fLJU3RH3CXbQU0Ch1NDi4LzCA7XCIytIRfODlRUo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=XvABIUGm4My/EAa37Mi37WFO9o0zBfiVtkJ57w/YIk82Xg7/mY8bJwNq2rgXlOyaM28V4Y53NcUW3S8mNqMMrRxnNK2kX99D74FxltxbHDgPUXEVMgbbuWWzbF84yhmQlSVK+GOuvxLrJQ866vIl0qCB6a2alU9U4krscCQNHNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z1wJpLYL; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1wJpLYL"
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-781010ff051so2648799b3a.0
        for <git@vger.kernel.org>; Sun, 19 Oct 2025 07:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760884301; x=1761489101; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eDl12rlfUNFwc2tMYh3rZzIheoNO4r9Ga0t8I4M0Eyw=;
        b=Z1wJpLYLnbd+a6DrwUNgG3ow7L+INiwGTpUB9+z6pT+6nniAFcUmlRbFGMQ+XPYSvH
         WIEi5b3H+O28dgfRg8+sBmF4wehLPGJoKJka0qyXmexU/BgWmRSSMrr8pJZu/i0FutV6
         e6pUODzkEl1rmTXfiWDUKVYkZIt6EXWSK4sYIf3cQmj49Z3Kd6TgWGXDqQE5DXYTxRz8
         vpFPRgiafoF1PQ5qz0zBGLvX4WILKRIZmyMZSSMNwVsmLJpAb39ytIHT9dE7/M491Bk0
         dIf+MLrkY+Les1c7WZVN7t69L8vEQT3LcLIEZmzWDsAj6iUuOfJj9aYs+nXtZ7+s88FP
         3uEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760884301; x=1761489101;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eDl12rlfUNFwc2tMYh3rZzIheoNO4r9Ga0t8I4M0Eyw=;
        b=KPX40TghlNBMdlFMPmt/vsWz/OfoRd/5PLdTIqXwPkHOBBYXyxlzWxjDWsN9uowC9N
         35x/Kcvrie/U9ZaYWVvBaGaT4PeBTzSoNik9ql4qqkdoYUlk8cp0heZnVaQLrJrQS0kZ
         1Yuq8IzFtcvdxHSh/6R3LGcqXEvP6dHn+RYuzs2IBXOJeLvs6s0cwl4a9Sa6sdEHFHbW
         1tPaOUO150xNf88EFGYAm93sZrUOEE61mGySY7Vr6mzfOpdF693B7nfFDTCAu6cGWEOG
         1hEtRjpuEJOai+vfMDemVNjk8lJFbJ7iN3qCvtpYFySy9mBCN1ZKSJwGvDIorIHam56v
         +Ccw==
X-Forwarded-Encrypted: i=1; AJvYcCUkMsIDtCg4ijvVt6JvAyHCSepacgFWgL7WYQtix/Y/QUBNirxyX5rnEYs0lidIgye/W00=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdcuaYpAWjUnugltZA156kAq2Sl8RHVz7CDeqPilAXsrS5sgAY
	sQzDRXe57Pyd0eXQneAL/bKfqDdqLtjAirh/SNtSBwU1VE57Y9weOJGH/99tx3/alABYzA==
X-Gm-Gg: ASbGncssLen2zald2eluf8otSCT5PnrlEI8jEl9bgFGFNbIuT0WFFUNlcQ89KyFZKVT
	OJGBSeAxFBM/Tio2T1mMJdXMOAiHnxkTmSRWgJ5wnhnamSOqw4s3RiYM7J0xR+57YQzGu1ypM35
	Ly5voNs4/f7t+48DSSLd5aP3TIBEDfeZzhkEPSe+HkwHd+FUsxJTxX+63+6WXLmxYewZ/oXSqNs
	RvhPFDGbGwyRE+obzlzci6v8VIOJe4fw8mlvsjzKX8vw8e9U7j9jD8eX/WjiGkuHjZqDeVpRWhQ
	u8Becoj3o3kQjvW5ymapqO3L3CeIC0+tEb6JppyjYJrEqGoRyweYJYqAYVUWMxJI8E3YX+iArVq
	CsRn2nslU/pibmbMCI4GEkU+SCTuWXpiiyPl7EEIyHrdFFM4CgOc1EQHJWsoO7OORaLK5xGR9Wc
	Y6UN2ijauHOW0vx5uX66qsv40/IobHlFY2u+/4Oq1wo07rAV0=
X-Google-Smtp-Source: AGHT+IG+kd5fjIHISw9cywg3WrxOMCW64JmuXF0MkKgULu79N15JnGcwCpZf0+xKS//GgN25MdvXMA==
X-Received: by 2002:a05:6a00:189a:b0:781:15b0:beb4 with SMTP id d2e1a72fcca58-7a220b10752mr10286503b3a.21.1760884300840;
        Sun, 19 Oct 2025 07:31:40 -0700 (PDT)
Received: from smtpclient.apple (n058152119060.netvigator.com. [58.152.119.60])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a23010f7c7sm5609805b3a.54.2025.10.19.07.31.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Oct 2025 07:31:40 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH] diff: stop output garbled message in dry run mode
From: Lidong Yan <yldhome2d2@gmail.com>
In-Reply-To: <xmqqa51ow6xu.fsf@gitster.g>
Date: Sun, 19 Oct 2025 22:31:27 +0800
Cc: Jeff King <peff@peff.net>,
 Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <DEF57576-E0E5-4F09-B7E7-CE1B8753F088@gmail.com>
References: <pull.2071.git.git.1760671049113.gitgitgadget@gmail.com>
 <xmqqh5vx1p0q.fsf@gitster.g> <6C994C9C-0034-46D0-8112-FF88773B5CF5@gmail.com>
 <20251018094722.GC1060824@coredump.intra.peff.net>
 <xmqqa51ow6xu.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3826.700.81)

Junio C Hamano <gitster@pobox.com> writes:
>=20
> Yup, that matches my expectation more closely, which is
>=20
> * We'll do the "send to /dev/null as we used to do before the
>   dry-run thing" on the 'maint' front, which will be merged up to
>   'master' and above.
>=20
> * We'll queue "here are fixes to the recently introduced dry-run
>   code" (without the /dev/null thing mixed in), and cook that in
>   the usual 'seen' down to 'next' down to 'master' route.
>=20
> In a distant future, we may consider removing the /dev/null thing
> once the dry-run code path proves to be stable and robust.
>=20
> Thanks.

I am not sure what should I do. Should I make a new patch which
only contains =E2=80=9Cfixes to the recently introduced dry-run code=E2=80=
=9D without
Peff=E2=80=99s code in it? Or Junio would do that for me?

Thanks,
Lidong=
