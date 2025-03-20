Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497C93597C
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 16:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742487119; cv=none; b=XW7ILe0j/HqfduQ2z5tPkewHfH8MHOQyV1Fh6MNXseP4Si171hfWyCBvWntlVDdgFW6v649a9o6CjXE/IjoLenKydRk+Eyo+Pmlgar1Jv7/M0N+c8oLRCnxgrCUy0OFZ+4XjmHhSneLLkFixYnD52CTYWyx0hzlT2/zpgWVA+/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742487119; c=relaxed/simple;
	bh=HKE1U7CEtu2EHGx0k4P0X/iOW/nQoFzW5ADdY1n+/bY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KbFyI/Vxi05LoE5s90YvS13ZCwYKDEviBwlOyFCQyMbWz+b259v/7iR5aakPAjNDPlymcCRz1K2UHVKfIZrGEjB+dyMh3YcIpyyrmbAglv5EDO4oIEU2rDLsjFBTU/MUHDJterKq7gQuyVhSiIIlJQjJh0+PX7ZaXQBHCmMzaQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g5LW8x1R; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g5LW8x1R"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-301918a4e1bso1422752a91.1
        for <git@vger.kernel.org>; Thu, 20 Mar 2025 09:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742487117; x=1743091917; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9+2tB0CzMKuTDSOw9qGW4ojL7BnmHgz119y/GM/HMT4=;
        b=g5LW8x1RvPqM8slI8S5PTBhK32PbFXrzvP3Cb5a266iSGf5noZ8LtdQY78muKr+HXs
         k5HJu4wVZxRPNGSDdQptlUtxyobp0As3qLrl+YCTRfru9WLhfCZtYEiVoJr+DpZuJFze
         i8EkDJBcUhxeaKVH34BiSSd1+vFCzj7+a3XElfCDn+uQW8p9HIHZ8ybZ5I1TgmIzNHjO
         003Pe3w7TrdUL8l27NBAWfyvHBbtbUcTxdA80S1w52ckzZnvxo1+mlZmbfJcBP0FjxJr
         t+k8M9ZZT1hiI8p6MdMo9kti0S4eKyOaP6lE3I25w6Oojo4DUbaGL9w0+nHrxyfAoftK
         CTCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742487117; x=1743091917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9+2tB0CzMKuTDSOw9qGW4ojL7BnmHgz119y/GM/HMT4=;
        b=lwsWdRS7qWeyMsGBrQbsgONUeu7GrXWyFhDKWiaZvs8va6yWK2G3bAPDq1F/tAi3ts
         t+2l5+gMBkqUWhRXbAFM+MHdMOLTfAQ5hHo4j6HQbUphfZnuLTyWh/a4E8+DJ3RBUBMH
         1Y2dNij73xHVAtX+ISa+39iQC9MvlhUytZ6DZniSRRVBa8aJeVOC7S6+S98m8ADbiOI8
         XkGImiQqjl/RHlKIBMlFn11uueGS3+JKmIb/nuKQ/W13zorIdNKB9RBc6YdrDeJbjIf3
         7h9AaWsfo2pL9/eoZ/8YKPDmuRWfzgueex3tGp8SgQ7HSZR8Rm9AFfhj8unpm76XIbw0
         HDsw==
X-Gm-Message-State: AOJu0YyMEdJoiySEgyVMoGeusV6livRINTl+sJUb73v5oJQa3ytJibiw
	LleeEXwHhYNcku19Ub7dyWXWJndqYvoXdFIw+dXiubACLNMB2olT9NJL98DkcZr5O5aSP4tqPHX
	XrCrO75fv3oP66dJp6YiX//d+qFUIGQ==
X-Gm-Gg: ASbGncsn/O2DGPxib1nGcfEBr3Tvx0eKNpbRbop2yXlxJ8k20840OGSpkVlM3xnNBiZ
	NjASt5S2GhTQeOk0Ea6pG/AcbnIbBpsVdhOPo2ST3NQIEa77KiYkhJ23jh4i6N5LuXlEqHX7w64
	fAXOgWeP0nGjEG5chA19fbLbOBL8U2
X-Google-Smtp-Source: AGHT+IEMo6zdYEBhcn1mGEKqM7wHWoDx9QBUMdCCnQ1lDo0tO/AnrT8Ub/9n5Qa4wORyQf2/UnnY+gqoc/8KLpBbtIU=
X-Received: by 2002:a17:90b:2f4d:b0:2ff:5a9d:9390 with SMTP id
 98e67ed59e1d1-301d50aea19mr6152899a91.8.1742487117419; Thu, 20 Mar 2025
 09:11:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1742367347.git.martin.agren@gmail.com> <465c91155eb30197b5eac00d294dc6e7ea2dd310.1742367347.git.martin.agren@gmail.com>
 <Z9vdUTQTnctm3965@pks.im>
In-Reply-To: <Z9vdUTQTnctm3965@pks.im>
From: =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date: Thu, 20 Mar 2025 17:11:41 +0100
X-Gm-Features: AQ5f1JpQpTaPHyNgndGy3s9LxCdZwO02HV-x7CzSmQhGxHU3t5dORCryjd5o2fY
Message-ID: <CAN0heSpsGUJojoiFSrhTksBt0ZYoz17ycR=91Rs44S_SWbDjQw@mail.gmail.com>
Subject: Re: [PATCH 6/8] pretty: refactor parsing of line-wrapping "%w" placeholder
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 20 Mar 2025 at 10:18, Patrick Steinhardt <ps@pks.im> wrote:
>
> On Wed, Mar 19, 2025 at 08:23:39AM +0100, Martin =C3=85gren wrote:

> > +     memset(rewrap, 0, sizeof(*rewrap));
>
> The `memset()` feels rather unnecessary as we only use the result at our
> single caller in case we return successfully. And if we do, we know to
> initialize all struct fields.

Thanks, good point. I'll drop it.


Martin
