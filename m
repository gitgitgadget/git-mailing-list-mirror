Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C402D9499
	for <git@vger.kernel.org>; Mon, 20 Oct 2025 20:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760992043; cv=none; b=ijuA1//UaOgE3gEJMWmb82VSmne+TQG77jPSGeTuyE64/PmQKPn7EfkXiUxVj8t2DfMmOlmJ6yjAVnogVR42jo+v1yO2wqHHT3yerFIybadv2vDZ0iVaovxDisdFTNtD504rdO28KnsMZcFk/7ZW5AyZ4flwV0hRZzQo1TJ94eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760992043; c=relaxed/simple;
	bh=SYeZN+aZfmTk9AicgsuYHGLSNEUMiGE7x4wnRO8TJao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RhgxU6zhDUhHIiSp6GaSWsVLrzHVgqpwxdozS+ZzB245nEj/IbuvwFWgj6luChJ8OZPbR1kp9Odo08zQHei7Chy5OCseOGTdzNkOTfo5qUquwi3JKVmSux+bbMQV66X7dK+fj6lqw70YIPU5u2RwcIeK1NzMQgZN8/Cq0tKafEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dLRbeNsH; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLRbeNsH"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-63bf76fc9faso8784033a12.2
        for <git@vger.kernel.org>; Mon, 20 Oct 2025 13:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760992040; x=1761596840; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SYeZN+aZfmTk9AicgsuYHGLSNEUMiGE7x4wnRO8TJao=;
        b=dLRbeNsHHWYz0SAPz5XAy4Ir7CIIO2npUMuFDbOtOtdHbTvpIlg3LoNW27t3eYG/tf
         vrfAAlhfQ0yCHKV7bo11supKxfWSwjgypkAn0UPfRF1a2McUjePJmWYnJWYCb0jlQBFS
         KYqTua+/mFsM4TWqSzVi1wy1cjJ6Tgn3RfKIcKB6K5WHc9r/Zi5xTfkMGmqJHlHeBFn+
         5kQzeZJMyIrKY1slQQ5mJb2l7OcHCmIuDdLP5S0TV4yLlmIQA6fny2jxiahlDG9dL4Eu
         xZHvLXSUTHT6znutkesxtj1XjLNvC0anvPoPh18zk6IGraFhG3GiAOzKkqey5C2IRy/V
         MHUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760992040; x=1761596840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SYeZN+aZfmTk9AicgsuYHGLSNEUMiGE7x4wnRO8TJao=;
        b=GHo0ot/nWyTnroJugzlpfFiA1+jmU3vBLdwF0VX/+HOHILreVSnwfGLiS8RjGURGoB
         fuC1uNv/r6vPRu5lpoZwcL12PXONtJLjHJOxi/cDYwKwSHHy/kb0nl+JXBhLPo248GUx
         1Bst4o5BjNNWDFqzhMNu3XQJ+CHB4k9mv2TvwzIamx6YWRt9l3Z6e/tbZNbKLz8/80hD
         lwMe5q/2RdypixBD8o4eyB7fww7+mtXm86kFDxJo7IWLbOze3QgUEVNJA1HVNngMw09z
         4GlzZH0z3yiHZlJKqUebtSs/ZuAFp9fSe4FqxgZCCXTjVNNy2RPB5ImLUBXrN3bgQPfi
         kMig==
X-Forwarded-Encrypted: i=1; AJvYcCWDSCcXjmpMq7QSCQ3THSaovAvmjASj/maevaeFdcvgBe8/Iu2mRfzZHHZiUESsWk4amuU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbXjyvX5/gqaOAm9XMQ/HO6VowZ6jzFO2o2Hk/0RbaV8NmQaLq
	/s0c67/T33GW5u/SoqM39ONSP3eeKTubPeK4GNsRP1aC75geWZbxa9dZ9IVBkLi4DVxGRzTOvjf
	/Ux8y3bKPMvEi0eBPTTgqeXDdz7V/w2Y=
X-Gm-Gg: ASbGnct2h+Mchu0RnA4MQ5i0ClAR/PhtvqpR/qQ7Rf28i44pbA4ZR2e33vLSCap9asO
	t1uW7FI8o1jGd32SGtV4LiFaUg/jwuwN92cm+nuMBmj6hS78YUpuAYc+PEhb6p27r7G1Cye5Khr
	Me0F6LWqtjSotEZ32tFagwd/MfcjNmX0cqP2qV8uRintfXLCaCS15Fms8I6s+jSG9kpGurbPT6V
	C1OfkAwnxaZHC7PQ4TOY16QReChDqXkWuxBuMIvZWc9onJM00O2cSA74W9NpCKv35qJrypwv4Q2
	2DW/ZBCXzfguKWZUvFv5FzGaZdt+aQ==
X-Google-Smtp-Source: AGHT+IFoAQvXwYCdrzsBJ7OXM3Exi7zOzWkn8ElMcIEcrtYe4UgkGRvIY3hfgRCqKus5VkgkF8Oy9pBq9Ioab8+6QEw=
X-Received: by 2002:a05:6402:1442:b0:637:e57d:c21 with SMTP id
 4fb4d7f45d1cf-63c1f62ab3amr13984237a12.3.1760992040031; Mon, 20 Oct 2025
 13:27:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6a83c7d1-7cd4-432e-a0ab-7b18ce3af08d@kdbg.org>
 <A563E028-19E7-48A0-B538-82ACE821DB67@gmail.com> <5d780103-285b-4e6c-9b26-2a87609837cf@kdbg.org>
In-Reply-To: <5d780103-285b-4e6c-9b26-2a87609837cf@kdbg.org>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 20 Oct 2025 16:27:08 -0400
X-Gm-Features: AS18NWB7h362jebkVmWIBJ3pfcRyAcgzZ9lZal3uLsAoO8baZjFnG7ssBOBfBEU
Message-ID: <CALnO6CBwn-NP-ZdoaeOD37_VM8N4D-KKopm3nnf4a9b+9OiizA@mail.gmail.com>
Subject: Re: [PATCH] t7500: fix tests with absolute path following
 ":(optional)" on Windows
To: Johannes Sixt <j6t@kdbg.org>
Cc: Junio C Hamano <gitster@pobox.com>, Noah Pendleton <noah.pendleton@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, Phillip Wood <phillip.wood123@gmail.com>, Thranur Andul <thranur@gmail.com>, 
	Michael Grosser <grosser.michael@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 1:32=E2=80=AFPM Johannes Sixt <j6t@kdbg.org> wrote:
>
> Am 20.10.25 um 15:43 schrieb Ben Knoble:
> > Going forward I will probably stick with using pwd, given the
> > difference in platform behavior.
> $(pwd) is usually safe, but not always. If we have to look at every
> instance anyway, we can use $PWD for efficiency if it does not matter,
> and $(pwd) only when it is necessary.
>
> > Is there a doc or test lint for that? If not, might be useful.
>
> If this were documented somewhere, would you have found it and obeyed
> the recommendations?

Likely yes, but I'll admit to being the exception rather than the rule
(I like to read). A lint is more valuable in that it can at least be
run rather than searched for.

--=20
D. Ben Knoble
