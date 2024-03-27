Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5DC374C6
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 08:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711529629; cv=none; b=XauK/sqSsvqUhcpUHy2kQ49lqpSNoc/tRI0icA+XEjXPLpvX68QR475hA4qNuc2iY5hSYOeJHYWt6FfGjETiAtykmlQV3HaK5QzvOnzSrZolhl6v5ZB+/GAw4LJ3ETtOEDFSmDJGFN2SjrdFsd8Lm5SkmxWHpgQaNsJWyDln7hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711529629; c=relaxed/simple;
	bh=5pDek/DO89uo5HrtkKTLSngptOPSUWOzThG3pW/o8Uk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P3Q7uEoWszAwP61nPf+ycUA6NvUiYk4A8WuZDXURjkTmKHiIvVRxu93J2vmZvd/78haTWrLHye1pKVu2MOQOMTI5AZmJRRVvvp9Y+PQW4aDK8XbsQ7rgnP6YXwRTIxV94aZr3AfIbOaFCcWdu6vBXCz2H2kesPellfrWy+UMFdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-609fb0450d8so68589537b3.0
        for <git@vger.kernel.org>; Wed, 27 Mar 2024 01:53:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711529626; x=1712134426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xc5fkjwVsjAcvIaiRXZgN+znPWNrvx4uh+A38YSUQgo=;
        b=rPKFvXdNcLG/EhTb/u+C/+BdVm6CPYkn/Tay/EbYshlijn4uoMJGdZzDFQVpsAyh0k
         RnXvuGMnhGWsPU9N3RCkoYznwunX/PDwPAvceU4Qas8UkgvngD6plWmA7EATZges9sm6
         iUybH5GQpB36G0ZId8u7lBoDgvY3R7JOtgX2THTIiVsiI6zsazwWIThgxNzZ2j7UnpxF
         QG5f9yEmUUSIQxHjLOuc2mbQXcvsFtlMffsSZFtJKYuVHBZ3N+ZgGO4x5TP0wVJNOBYR
         wM0P70rWmrfb7Zw7nTc9KfFNG5+My5u/WCVkicfNrrezjACiu173oSoYhzW5Le6DPNEk
         mMHQ==
X-Gm-Message-State: AOJu0Yw9X/KxZ/h5G9ZQQlVJCW4aIJx3Y++qXIRdlQtji7eIP0wYKpV7
	KaKL9d5fa2dd2jJqIaYMZaPnUujf9GUuVt87fui4A+t6khQOHkRVmj56UErR35fTVMypf5N+Q4i
	Ue+AdKqOKJAN3aCH66f49gcUN6Qg=
X-Google-Smtp-Source: AGHT+IHVGS8OQJ6cHJJi+uvhdm0NucKGCJ++fKO1JW7zIhcLoSzya8hH6VjcPiAJ4+mklh7o/91SKrA+9OvYCHD8r2s=
X-Received: by 2002:a25:aa30:0:b0:dcf:3f11:633a with SMTP id
 s45-20020a25aa30000000b00dcf3f11633amr350549ybi.35.1711529626199; Wed, 27 Mar
 2024 01:53:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1709724089.git.ps@pks.im> <cover.1711527811.git.ps@pks.im>
In-Reply-To: <cover.1711527811.git.ps@pks.im>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 27 Mar 2024 04:53:35 -0400
Message-ID: <CAPig+cTX72Jrc2=9jo23rJfnNK4VKdOuKrCeo9YQPfELBHn1YQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/13] builtin/config: introduce subcommands
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>, 
	Taylor Blau <me@ttaylorr.com>, =?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 4:46=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
> this is the third version of my patch series that aims to add
> subcommands to git-config(1) in a backwards-compatible manner.
>
> There's only been a few changes compared to v2 based on Eric's comments:
>
>  7:  8ceced0fc5 !  7:  eee1fae50c builtin/config: introduce "get" subcomm=
and
>     -+  With "get", Return all values for a multi-valued key.
>     ++  With `get`, Return all values for a multi-valued key.

Better. This fixes the typesetting problem but misses the
s/Return/return/ mentioned earlier[1].

[1]: https://lore.kernel.org/git/CAPig+cRwh4HCi=3DQ01tGJ0WOb59iE18HWSCNxGog=
creOz+2w1WA@mail.gmail.com/
