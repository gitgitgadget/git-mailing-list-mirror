Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69F31DB34C
	for <git@vger.kernel.org>; Tue, 27 May 2025 17:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748366928; cv=none; b=do+IxiSWdzcWgA+DXazfRxvSCSQ00eDUTryip518VnOsQxOBa1rlHKUFiK7TRzudZdtKJOhGtYkezqayW7U/b1+AaYPbw1b7+vUAdgK8xUT4rnvlJjyyrDLkj3sUwDOzVgnG45xYfMuzuhrZmHaJytqhqciDNcHt/ymwj8s73KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748366928; c=relaxed/simple;
	bh=eAKYZCLRB7nL71zitjWvXjWSCRRuVblrSBMxvYq/N7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GRQ/+AXXZ5YjPoVq2VoIsX7nxQzIeGUju7NQ9sY1i63yMzfHUiUt7TKwTxbJxE28uYvK7urNE7UnPRl+wwnCrL1IP5zWECJsSWqR+UnqPBVbJsdAGWmN+NeA0fvP/KsgdsM7C1RNowAsB7wamsObckQtPcs2U8O+bVncdAd6+gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6f8b4158384so5042126d6.1
        for <git@vger.kernel.org>; Tue, 27 May 2025 10:28:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748366925; x=1748971725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EVrLhz5SwcOPPnoij2wXPgXhmy8e+FOFgmvYg2M7Fdo=;
        b=xIeM20WPMPmD0WHALS2XIdcGTQqQdbt2eDqrzBzOmcvDDqESlHum97QBuBWVlB/20c
         FC/Ywj1IKeVTf2ylBwuaxuOKeLvSmJMssDEd0qymTKOU/GrvIWsgRnfQXqzmU13+7eoA
         n1N3AI4MhqSy/ohbjeg2ctLNctqPyqCHF6KTe6fdpytlIOnqiBtNhH+eWUoAdejywJe6
         k9Xj/mYJYh96TylHfel3CPHC+JC7tpLOWzseNlIEq+8ex84wWN/fmxPO5MJctXBDqyHG
         Q9MiVDSNcYdMp8HWGbL2EH4PsJlzK25JXuAsumsshJYCGcVYfEq00M7IaU7Lykt+YD6V
         /LfA==
X-Forwarded-Encrypted: i=1; AJvYcCWsBv9EbTyrwQMhs+Huwr+e8GPlMEl2bNbof3h1dTHDiXxsW4uXoyfJWQLZr8npZP+WIRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxthSrR/AXZ6belXdugexGOZH5+qfiYtzCwu01SsOVlKEbSJKfN
	BjhvAnqcQch1Hkh+XqZ1bYV/cDuWg8qstq6vZZ3qAboz1Hr+c9GNTop7nsJ/lz0iKv0+jrVJ/vO
	OVVpNwITCW5fZ5IGWMIqvNdb3MR9c4QA=
X-Gm-Gg: ASbGnctxVfuZ9cubZE4uXl7zMdRsUDE7htZxNjIgLY3Eq19zmhbwf03vLDrRqBa+swv
	jcapAh3uU9iP9rKrx9m4JLQvQB3SVLYvL7Ej4z+e5s8E36Cp+Ijg2Xhw8EVxs6SYjP+1mcGElOX
	TXSA5a3xSQ3uJxHLRDBx8i6G+yXIQlbf4ViNN+YYO9Mg==
X-Google-Smtp-Source: AGHT+IF/JsZUv3vqJbaPH5cOWGAsE7wg2lphw+ZDy+594sH+pQUTe7IlL+kVp3J2kyu3g6b+padWXu7KQWCogdcZJAE=
X-Received: by 2002:a05:6214:2022:b0:6e8:f645:2639 with SMTP id
 6a1803df08f44-6fa9d30bfabmr82348286d6.5.1748366925597; Tue, 27 May 2025
 10:28:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c59ae2c0c7c8420ec1c5bedb87f28c7f5b573a60.1748122397.git.code@khaugsbakk.name>
 <66e92d69-8372-47cf-a350-95365f72ca1c@gmail.com> <xmqq5xhmvuol.fsf@gitster.g>
In-Reply-To: <xmqq5xhmvuol.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 27 May 2025 13:28:34 -0400
X-Gm-Features: AX0GCFto8_HaLoVaSU1k0HNcjqnD6wu0xPmX0rOjipES2CcGufl_MCuyoCYJJto
Message-ID: <CAPig+cScZ_0g7K-pQrxSseFX+fqjA6KAFf3nSi5cxbbCHhR5zQ@mail.gmail.com>
Subject: Re: [PATCH] notes: remove trailing whitespace from editor template
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, kristofferhaugsbakk@fastmail.com, 
	git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 1:19=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> > Should that be " \$"? What you've got seems to work with dash but I'm
> > not sure if it is POSIX compliant or not.
>
> "2.6 Word Expansions" ends with this sentence:
>
>     If a '$' that is neither within single-quotes nor escaped by a
>     <backslash> is immediately followed by a <space>, <tab>, or a
>     <newline>, or is not followed by any character, the '$' shall be
>     treated as a literal character.
>
> Taken together with "2.2.3 Double-Quotes", I'd read it as blessing a
> lone '$' at the end of double-quoted string as a literal dollar sign.

Thanks for finding and posting this. I had read the POSIX shell
language specification pretty closely when writing the lexer and
parser for chainlint.pl and remembered the above statement, and had
wanted to cite it after reading Phillip's initial reply but didn't
manage to find it again in the limited time I had available for
searching through the documentation.
