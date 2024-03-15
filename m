Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E377F9
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 00:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710461080; cv=none; b=RedcWwV5KOU0LgRKZTfeg/qjkxxIkH+X3bTTqiIUthiarfzYyl6kxu1mzSNStWm3mYS/C26bbXkeUHMkwJem5nymioJud8HrkgLp3BPwwXqEmoa4HBQq129Y7k8uce0AesBin9de5Vu5v6anL/COsZeO55OAeJ5I7VahNsModR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710461080; c=relaxed/simple;
	bh=b5HZjYmJDSN6sA4ZOuNfwWF3KXgEkDPz8fHfO1I23SA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fh/Z3LamT5Vi7FmWFj/x9eKYyM9AtBfF6H3pVS60eQym02rkvmI8yfecoypffTSSVcP9fbQz2oISXICdfMBksR4Uaree1g1GntDVp75s61eFXpJo2OT2vboJbb2rSI8OmISHDT5ORgEfUu31ioMs96QcgmQhuPe20j/zo+RlTGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DPKNLu/O; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DPKNLu/O"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a450615d1c4so255228866b.0
        for <git@vger.kernel.org>; Thu, 14 Mar 2024 17:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710461077; x=1711065877; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6KWZ7vRL84WFIqb9ukwSfHMaT3y6R86w7kBkRWrHxr4=;
        b=DPKNLu/OBXm+XCe/UnvPlVe9KDonqA2dCGHQbefMEcmtkpBXuI0pL1dXxbJiGzOq6d
         NcAw3fxufjAtpQVSJFaMkLpEEJmr1FfRJYufAF4XDsGBcDVa6vsv2PCV1BPyixz0Sl8k
         44L5nKOGGmcVhsL+zdegsGNIdniFkNZ93cHnOSeaaVju2ZWdNmDXnQILyeD9OpURvHAb
         mKNyppYz3+h+nB7clRszYw7O+lImK8hsQERXJK14P/BSOOPqo1T+208M4f65c1viLFw4
         EjEXhc0trflBRK43mQ0WNINo5lZizajTawMIlrqzhgyyIQ5bG9AYGrQ5MMZkHA6RVfX8
         4ghw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710461077; x=1711065877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6KWZ7vRL84WFIqb9ukwSfHMaT3y6R86w7kBkRWrHxr4=;
        b=QbJS1sfoH+G6IunRyhiN9vVl5+4OJMQD+vE8KYzLGrtp9p02LRoV9+SZ08PzmgJppj
         8iAhgpHziepC8vyDcs9ajfIWDzUFM7uz2RDn42tJcrIlAseLiBws8IwmmCeRPLm+zNUv
         h2jS8YTXKEEMayNfNCWIdd3YN9x9vmttk1/nyG1Pu9P8Fnr7cLYl/8qBG+pBaQZqz83A
         15L4pfHEX69GDssdCy0cz5fMkHbGNgc8dQOepwjUa0fImtc8d2ZLeyIEFOP0qKtGphTZ
         kzqtaKXWslMBwqBtdcxQla7L2VSP1r7Ll5ajN3PC0umTSQyUbuxHMegX5hFOEN+CJapc
         a8qQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvXXEyTsUXY5qavEw4UkG5J1iCZRJdXyKoXf/SlIFQOFJeJ5Vk7BoRfZ7buf1WPJgHINdrKxRamIamVPYj0MrrweD6
X-Gm-Message-State: AOJu0YzCAI+KWK51LTz8flgB4FvnpzC/e70iDnr/kYobM55aPGvTOWO3
	W+jkvgYdx+eBSI26rlNhqHCd4LCBf2f5oxA0zUPVCoXkYq81WiNF9tAJrYII/hP+/U9rvrK2oaN
	gWgglKg3n/BuBLUlHhjNA8E0kjbg=
X-Google-Smtp-Source: AGHT+IGMXFNwVmJCy70MaeEm7S0e72+Qv1ZkY/XBIDwbNjIhnti5VHZ6kyA0aNuCwRMTKTDeWfqnGaec9lLZm0T0jNY=
X-Received: by 2002:a17:906:1501:b0:a45:d7fb:8423 with SMTP id
 b1-20020a170906150100b00a45d7fb8423mr6592583ejd.9.1710461077189; Thu, 14 Mar
 2024 17:04:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <SA1PR14MB4691B63C740F95D7D8A495628D2B2@SA1PR14MB4691.namprd14.prod.outlook.com>
 <xmqqa5n168nh.fsf@gitster.g> <ZfOAdVy9_UfTj3zE@tapette.crustytoothpaste.net> <xmqqv85otmsb.fsf@gitster.g>
In-Reply-To: <xmqqv85otmsb.fsf@gitster.g>
From: Chris Torek <chris.torek@gmail.com>
Date: Thu, 14 Mar 2024 17:04:25 -0700
Message-ID: <CAPx1Gvez4Ema9Yi-7Ei8OOkq9t8AXmBYN=yy948k_C+ZBKdXmw@mail.gmail.com>
Subject: Re: [PATCH 0/2] Optionally support push options on up-to-date branches
To: Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Christopher Lindee <christopher.lindee@webpros.com>, 
	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 4:37=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> In any case, I am OK with the feature.  I just was wondering if the
> end-user experience may become simpler and easier if we did not have
> to have a command line option.

Would it make sense for the *server* to request the option?

That is, you run:

    git push server-remote ref

and if the server at server-remote "wants" to know about "no-op
pushes" because it will do something for this case, it says so.
If the server says nothing, the client doesn't bother with the no-op
pushes.

(This could be either per-ref or global, too.)

Chris
