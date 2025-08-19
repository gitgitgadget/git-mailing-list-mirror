Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC157343D94
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 21:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755638943; cv=none; b=Ps1rpNRJXhhlUJ7JCb5s6DNHzOWFdqpTRYvr5Q81AH1yckE7a0Iv6Alzfa9gFUJbajzz1RPIWhA6MW/xNyuEY1j6QtiUhIbGKqE5BlweBDcZrMDWujfh+EIeSpQEedlt8JxLUzrRZJCDDYoXSFXOXcf3SyIqUzAWJokZmQw9E1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755638943; c=relaxed/simple;
	bh=01vOeCBg3ZPa+YCj9I4psWoApLMscbOSwDREypeByHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KO93FPrURBBaIxJ3n0rAJosu4G+9+UPaFQWSqPiXTZSRkbaRMKDBRpFijd9+vxxhkoGW+pY+yxOVh78jQg2I1jbxQvS0nStPktbOix8O9tuEGZl1dvhMhpJYVIp3jS/TFT7s6k5LYAaEyBvas8nSO6Fu0yumM/3+weM08Gvj5Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SmRLjQQp; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmRLjQQp"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-afcb79db329so795217466b.2
        for <git@vger.kernel.org>; Tue, 19 Aug 2025 14:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755638940; x=1756243740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=01vOeCBg3ZPa+YCj9I4psWoApLMscbOSwDREypeByHk=;
        b=SmRLjQQpmVCsfp4evUAjF99cixP4SOnGyuOl8UjSqQRuGl3FQmhkVA0zwJXVgTYWSD
         zLZW1mzh3XXlIX3kpf6c6t5RJ2mpeoWVJU/I0QIwJNNfKzWOgnZT4FYNdhobbQFypYZ7
         imrxLMYPudmtA4gsDewiRQNgHXtppOTLnt+3wfPiXID5sCVq0kDdus097eLZdvzztMb8
         CdGwxELmHZIQlOSJyNRoFAw1K/un95AtMQYoM1BERZHdr4Q/oyTc+BBB2AlF/eNefyMP
         9st91LhSPp136y9VouQON1/cRGRG7Sx+kZ2zuE+oJPUbR1skyVJoocApHUPsnE+44m9v
         uWDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755638940; x=1756243740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=01vOeCBg3ZPa+YCj9I4psWoApLMscbOSwDREypeByHk=;
        b=jYCUzYijO1hTHKwnFhnxaDWapMi2bdb18rQu88OaSMJE+zth0w5JKiBH1/be2TcD8V
         1+ei1L3Bx2HTYhL6ga7LXDjX82OF07KBUnB2MWcqUmsmVdqV0w/eWoKOC0KP7KHZtH4u
         1bM76iJJrNQZE77LDmCV1D/nX0p9FM0kNW5L8HRBIzEI8T3shLjiDpgKofI6q8HlG+WG
         RsV2uY/TlaHbHNvvp17jtVwotfvajD0au2AV8jVNN+V5EmdMC5M5LXDKKDITW3vZ+v0D
         BcDLgzWWJpVnCNjDr9Q4yGrwtBsPg47swp4jPeM+eGwsV+ZGEPzTcz+ANR/97AlHXctk
         NQPQ==
X-Gm-Message-State: AOJu0YxQU4ND3youdAXTzduseRwNk0hcb0y2D5FpoGY7NpkL0bnzAlvP
	nkwkjUOsEPkXgVjxQBw55WutNB9GWFLdb0y0Telf5x18IpauXgV8936/qAQoRsBnj0UbEDtFTeL
	Mm77s49Fms0t2mHAzvHdR/DKus1ehzDY=
X-Gm-Gg: ASbGnct8ZylqE73qWK9bBkkQhc2ZF7MqNF9wH0m2Fl1mXT95X9Szi0MXhis0d4bhoir
	YhD1rJJyogjOnsw8z2Wx6eQIz1dy3TfVwg2Kv+XXuNmxnra0oaR8d++C2P9Qs3nNsyK88k6DRD4
	RMZmKpC5XkRiHGkNMF6m7LjpjFBnt7ZZTkdh0LHLUDaPKdtOQsL+3YOVrvVXQhsQUXv7rij5RyF
	C2qDwGIZtVmRvQnI9XJhsqloFv3JchErFPS3O4Wrg==
X-Google-Smtp-Source: AGHT+IH1xchg+3zWe8fhX2fzzNkLpqNHmHpLEAxmYfsyZ9jMuPWietW7corr2EpR7kD2iaWpUlnlCQfI8kcJ9cZYIjY=
X-Received: by 2002:a17:906:c381:b0:af9:566c:4cd1 with SMTP id
 a640c23a62f3a-afdf014c324mr28746366b.24.1755638940042; Tue, 19 Aug 2025
 14:29:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
In-Reply-To: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 19 Aug 2025 17:28:48 -0400
X-Gm-Features: Ac12FXztcnqTkUd6Bko6w2P74yoVGvAZJqQ3px291kLmHEsPBHqqjR-WWBtM9Qs
Message-ID: <CALnO6CBDu14P8chvJ=1QfZ2apVg78E5P+d+P+4=8Whpu_EMi_g@mail.gmail.com>
Subject: Re: [PATCH RFC 00/11] Introduce git-history(1) command for easy
 history editing
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 6:57=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> Hi,
>
> over recent months I've been playing around with Jujutsu quite
> frequently. While I still prefer using Git, there's been a couple
> features in it that I really like and that I'd like to have in Git, as
> well.

Excellent! I'm looking forward to reading this series and playing with it.

Unfortunately, patches 8=E2=80=9311 got dropped on their way to me (but I s=
ee
the lore archive has them). Odd. (Not in spam or deleted messages,
either.)
