Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D733C23D7CF
	for <git@vger.kernel.org>; Sun,  1 Mar 2026 06:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772347846; cv=pass; b=NWoehxGLM1fkN+/3oa3qwEkP5DBLHvdTF32z5Wkjx5pNSNdkgGTPwpxu8OXliCw80+qXc0sL1pE0YHH7EynCbY2vKaUAiebyVVuNcctBRnelJZQ2dLmpoVAkJFRbkHFRX8h0mPzJzAbthKxTgNEV97sindAn7iPXM+ocrd9AFTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772347846; c=relaxed/simple;
	bh=bKphyAc5hGx2InlXDA3/UrLz0p1ypLqarDiY9X+NLE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=suiGeUj3zec69I+Yyk4TbNcASAMYHpK+Ugejad1FZFVBYeCC/H5UgR2PX5jRcpuKVWWV4AfxnBebSkgBi5cZ0IAg18eFXm8KUhWakKXDCFIvvu0h0zBTsfSk2JE517D6RFo2GAUDnZPsYoXRlh9pp/7Mtyj+VS7fF6RITHeP2PY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dDMB22yu; arc=pass smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDMB22yu"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-896ff127650so57399336d6.3
        for <git@vger.kernel.org>; Sat, 28 Feb 2026 22:50:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772347844; cv=none;
        d=google.com; s=arc-20240605;
        b=JYU7x+G/jtKUEslxsDfoBgLIXTJUB9ecFvgXNJS/HYFqa4poai0N962goLHhKWFN6r
         y2ckv/ACgSa7Z2YadlrXsLkOPvJwDcsIeGkq9Liidect5FnPuJnwnTyPQID/fWVgoqgL
         JuC6Ge5QGaLFHeBVXskI7pJ9a4euEftAz7E3eq5kdyBsb9lCtc7fvUdk7Cbty6JsHqrh
         BuIy2T+UJkqnH0UwT5HlCwimvyI9yeRjLYtNRe5FobA+o+XFkbGnqxQxC4ZG/VYK/H6k
         fuW4z9I5HSYaeKyeLMw5xErc4+zbwt/1Prmvl0oIgLAcozQyT++mCbGZ560earfnGXzE
         ZW6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bKphyAc5hGx2InlXDA3/UrLz0p1ypLqarDiY9X+NLE0=;
        fh=bVmJrPQ1jIMePCYdRhYiToGimuLeB5IBhI6HIkdodkc=;
        b=IYTVVEY0hS7bSQik+7tsqNgiKKWBm5bRHgmHOTsdKIXT2qkaoQ3qjIxXqwhjlBbDVs
         e/DTC0k3xwTUQIuPGwrWMehTKzHnb5pylTOJwq1yDlI09AbUpXqQfIRzc0oZ+d1xfvrk
         IJ0+EsCPeVtdV/+BAIHij+ysKIMuN49VjdlYAq9cttsKbEfCe/SQhoypVQU7eFG72yXn
         Q1DMy6teEuZ2OFrzdmIXtwnXLbP2skfrXdXhZwkXM9YUJFrQbbJvdKVJ5Nuo6lOtNAz3
         nRhGfkJ0lU6as6/GdHJ5F+H/HVDWRV0HPjAoKDZ/K08FhAg2WrNr4g4qcFkSr93JsTu6
         Rjmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772347844; x=1772952644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bKphyAc5hGx2InlXDA3/UrLz0p1ypLqarDiY9X+NLE0=;
        b=dDMB22yu0XPMypwixbKBrHgCL4ayerqrpmkItpvmerH/hf9Kdahe/oCby6co5w3rb+
         E8m7FCqjKOXhC6bLldtYtqFOHCFOY8hkYtCxeMadxilQc+T1v2pZOeMvJtq6H7xDaG3r
         T+K3E24EucAnUrpAYL43Y3GkeLdK2n3YvsCrVEpgc/9+WDroUuvOixMQ5KURD9ddQlRT
         njvGkfz9Rs2G5kl82hbQC5Vpe6qFemgzD7jaF1drVpixH+lCjVygsZSdlRHB7yIUbAlv
         mQy7T8Fs7IyzJDEqex09P9QB3AJt80d6CcRIl0Hi+Rwfhxb0ocGY1Eh/47j+xQbq6FDv
         PSZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772347844; x=1772952644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bKphyAc5hGx2InlXDA3/UrLz0p1ypLqarDiY9X+NLE0=;
        b=lnEzpQ62NFbCBRccAtmzA2Gw1TWxUwsLOWDBo9WbTrLFMv3fcOHd4AEHKmDjS4th+3
         SJyJkfR12GPQS+YCJNZS9jf3dkqo6tT3lsQwf5vvscaE2zVbcjdaPGnEx/fPM/UA46Z3
         zuJCTQKTM/NIFDycw8wzoIn844WJuevzzgdZ2ilQNVxLWEv+AoUSMSKhIGD5kY/dhJDe
         nVUwZ3A0SbntN+rmtPig1Wlfvro7NL7QiFcK5kvYUuvm8XW5VaCuCDUetatPQ1CiNodo
         3BF0gthbrIlCbsSF6pf9gOJhjIuwFG8yGHWqwSZl4DvEJn8bFwOXG2/5hBuAAH5eU2AI
         wfFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdOOYAk73p8gVAOplXfpp9VQoqBn6j3y+RweybQnwzJG4PRlXZzIkuw2i0YqXw7qVW5iA=@vger.kernel.org
X-Gm-Message-State: AOJu0YykollqwxfPKjo6p6BAzpJKh2Rmokwj+SS7C4+JkhHsC5G3GwDU
	VKbuafXf87YEvHtpCXMnWWkWlIa4d4hcJLxmur+xyu3HQlIn0LGUlqo7Q8ix4JXsjg1aXZzfTid
	91QCzGQdRdEhq12NzAE8Gm+qJW+ME7wY=
X-Gm-Gg: ATEYQzyJ1S1vKHCtFTDa4kOoHbtrSPJJrYc4ix9IGeCPuSKcrm6k6kgQ4fUvXKSx7ep
	ExDJmFcijegzypmpLP5XGSnsSJI7epLsi2DUeQOwA/pqem9ei5XEoQ51fz0a4PGke/p3GmsJaN7
	hbOM51V9DEGfrPqgZDBkrGJwYD84q5Ut9JFldR+QZKxaE0IEByVC4RR3YuU9kJDeDQKp162bn9A
	rXRas9PPG9dO7lc/KmbW5UzTiWkDIjyHrthPZoHY0Y9++7gPmXZmq2LxmKIAdYLnvJdWvI8Nf5Q
	JpAZkOosRmrxLbr9ywQT1RlPjCOw+oC0oIIPypFJMX86QWLOU3XSi951QZ8g1YKkqQBPtZRLFPQ
	WcF9eZjuXqq8B+qdkSbcq5HeMKDQJI2RE7P68
X-Received: by 2002:ac8:7d85:0:b0:501:4a4a:c24a with SMTP id
 d75a77b69052e-507527261a8mr118160811cf.13.1772347843775; Sat, 28 Feb 2026
 22:50:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260228224252.72788-1-lucasseikioshiro@gmail.com>
 <CA+rGoLdTc2caDUsQedpegL+T4MqwwiA62uuDSFSawAT5vcPvWQ@mail.gmail.com> <CAFNBzOdCx=R3r9+m5eDyAykMAbmbcfpX3kPeEPjqXPYT-_89+g@mail.gmail.com>
In-Reply-To: <CAFNBzOdCx=R3r9+m5eDyAykMAbmbcfpX3kPeEPjqXPYT-_89+g@mail.gmail.com>
From: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Date: Sun, 1 Mar 2026 12:20:32 +0530
X-Gm-Features: AaiRm52zH0TDQG1K0fOAph66MpGUAySA09YsmRWRqiTvU0j46A0FHv_Y2UEq1m8
Message-ID: <CA+rGoLcGB-iJX7U16NmONr_EhYLnsn0eNAAdcdExRLQtMv732w@mail.gmail.com>
Subject: Re: [PATCH 0/4] repo: add support for path-related fields
To: Ayush Jha <kumarayushjha123@gmail.com>
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, git@vger.kernel.org, 
	sandals@crustytoothpaste.net, a3205153416@gmail.com, valusoutrik@gmail.com, 
	pushkarkumarsingh1970@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ayush,


On Sun, Mar 1, 2026 at 11:15=E2=80=AFAM Ayush Jha <kumarayushjha123@gmail.c=
om> wrote:
>
> Hi Lucas,
>
> Thanks for sharing this series =E2=80=94 moving the path formatting logic=
 into
> path.c makes a lot of sense and avoids duplication with rev-parse.
>
> Regarding the limitation you mentioned about not being able to mix
> relative and absolute paths within the same invocation, I was
> wondering whether it might be worth considering making the path format
> part of the key itself, rather than controlled by a global flag.
>
> For example, something along the lines of:
> path.toplevel
> path.absolute.toplevel
> path.relative.toplevel
>
> This could allow users to request different formats in a single call
> without introducing global state into the command output.
> That said, I=E2=80=99m not sure whether this would complicate the key
> namespace too much, or whether maintaining parity with rev-parse
> semantics is preferable for consistency.

I think this idea works for individual retrieval
It still won't work when the request is for --all
The main problem of absolute vs relative would arrive from the --all
perspective, no?

If a script specifically needs both formats for a set of paths, the
caller can easily just invoke the command twice:
i.e git repo info --path-format=3Dabsolute <keys...>
git repo info --path-format=3Drelative <keys...>

It would still work for individual path terms

I think adding the absolute or relative terms in key is more of a
"user" friendly one.

What do you think about it?

Regards,
- Jayatheerth
