Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7685A2BE656
	for <git@vger.kernel.org>; Fri, 21 Aug 2026 12:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787315519; cv=pass; b=V69a6FJ8eRWataPU6z9NXIMgTyKuI7NEDHcvWCrqH5y2Y3K/gVEx/EZgNL3sZXTtztiP9Yxe/g6W8jkPhKwy/Vk1KKvU2+pHlvp3jnZlU6JaeTrEAx4ShRKGpaGssP40O42Td5tJpJJA+gH26YYAjuWvBWXEcDHCVunaqJW/cIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787315519; c=relaxed/simple;
	bh=09Jn8oQptuODKvKWIEieFAG55j5T3G/YMjtGPU6mHY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lIGQLJl7vz2NA8gB9Ms4aDGEOJJWJwCo7Ay6of4DeH7izhZZfI6CkJoV7ivrXSSFIbF7DEcwwHi3fN20mSxQhqp6uDV5kG6X2ee7M7iCIbT9s+aLLkQipOdKFfDLo0yxjkFyuyShcukV31LF2iv1Hyj4kQNV9ROcH4gS6wNUHzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b4juOrTL; arc=pass smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4juOrTL"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-ca7bea5e5b3so773486a12.1
        for <git@vger.kernel.org>; Fri, 21 Aug 2026 05:31:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787315517; cv=none;
        d=google.com; s=arc-20260327;
        b=bEQLsWMQYid5Gy64jKNphgprKn7cEsx8fW0oSW5p9tjLkPuO42VOKXPbFolRMTKc0S
         AIQYz+0HmvYEiHequtr2g6LRqliP4RYG5khkxbiwXFD7qoG9ryvbgZpV2oglG//4Tl7x
         wmCurzkcc9ORrArYlAlJ6kvULog2SFDC2n1TcycFLaLIjC23D9qSbws7+TyfOVypzQWr
         tL9Ike+AQbUFDRBo/XFXEPBGOs0rFxmnm8nzFUjcft+FBm/3349v8o/4Tvlpz8A9rBBC
         2pF0cpEdBO2TjJgwLhFHiRdoqRxhs1US8FIfd6AXQoteg74++HBCdPYz1tCYpv7ePyrR
         MuGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LVCxNAJFOlrRWOsBYp5StvoSKQYiWGWwO/fyvpx/Z0I=;
        fh=OLVinRQDbI5jjUu818Fs8UJnXwAIf1nrhfE6K5bNDCk=;
        b=FXJdHtuIiNRh+c3cJxcEFrNqSFdOYsrjDQHqGKPpHXEM9/2U1SSz1S4/W9WntxgrGE
         tiEwsogMVtJeiWxLO0K2FoOG6g5UTOA7EhFMw3gC7se/GF7sEuJADypiDR6Pr7gsriqS
         o5s9Jsy4ZUaNJvjOSq4rsjMFWEYPnElbfXT7/8d35Er6gygpZYaDTNqeOUMk6fWH2XLP
         6xjBFjzld4clBq/pgHfnlf02h9px6uqS1OAS2AZbYlf++9P3Zbf37vB7jqmt7j1twZFv
         gRu2oIzqCQtlkNLCSWIy47Ebu4mcykvAntRKOiaiP2AIV9QwhkhRh9l9Qo0G8GddDnsi
         F3rg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787315517; x=1787920317; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LVCxNAJFOlrRWOsBYp5StvoSKQYiWGWwO/fyvpx/Z0I=;
        b=b4juOrTL8n+MYAK4J6bZVQg4IGstqaokzkHgVTpQ7gpR8+PutfhRBv2YGtJVQcKrhy
         R9yNjIaE6tu+wZAzZeb4feeJzuk6VXYDXvfnPTX2AvWsT9xlVfVR/Z3MoT75gI4cwSOM
         SSlnirIOQpSIeDmXV0UMlxoBGDw1VemBfpJ426WW+lX/uPonZd/PTHMkV/8xzAMVHkk+
         heWhTe+QcsyLosBv3E45mGyYaQyIMCPsaiNBSNQsZS6PUj7SC5zN5Jkznw7iR/0Cpk0e
         H/9I4Fv+Cbx72MSsi6llcbrNp91U0lA/01cwB+7bydz09fCIOwXQmowSmNca+GqnwcIA
         +ptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787315517; x=1787920317;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LVCxNAJFOlrRWOsBYp5StvoSKQYiWGWwO/fyvpx/Z0I=;
        b=Ytc9mw/4sNbajCRYcmJwK8pvGZsU/WOfE09erPdqpCpLS3LjlOmAd6KrD+Ar7FfsAL
         dG5Pey/j298Q8EsfItxwE+5JpgAivmhU4jEQus4tYL3FN/EPFAjVTatSkU8lQMO1NRdE
         3EZ8QX/oI/EGiCWzdq1DoCt8RNNV7yxZbC3aRAlbCUVk4V3C8x6nZTKh5zTFCqR6N+SS
         jrKqvvgTOGYZhEQ50jKoxIlK+nX1NTmZiT1FTbKM1Q0Xz8dbpln6xjZ2292dku/u2Gz9
         Az0Q8NuSt6eqlVNy67uRuLuUMMRTIgJX6DajXuyjZww/UKH2Rp+iXw4mZRIqpTX5ujOp
         thYw==
X-Forwarded-Encrypted: i=1; AHgh+Rqi/eIrroGSxlpuJ/LfB0V2UxvocQUB/qJbh8qO9Qs9aH6WYyTkECyK7WHQQoS9/NApdh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YywnOn2AiwL9vJi5/3FdLcMlqsVSmU25dLeGdpSX8PYpz5x3nc0
	MgzBji3MxK2CrdEVO+Gb/FfXLyLenFepdya/KiYILj/luXNOIRopOhgTq9k27fyM6NBLUd2HDSV
	PO58sVPFjM6A9xlGEZGg9LZdrhQ+O/84=
X-Gm-Gg: AR+sD10aFxJakscDTt5iv8WCBdL2lxchOzLs1dGhSgHlotKjQrTYTnSM95Om644Je4V
	mGmeLd55QhmT+2lJ79YlE+H4q3aOPjtThnPmp8qZePJMSnVEUOrB6a1Jjvm4d83ktNP7drlGz+o
	yjkuRpnb06OK8rvC4HaBxPgNKYKTbb80pc7bWp8sRyMnRysordNx9uoAlTViSkayF1fOu7fjKv/
	2rhzycEeUWasWK1o5ELGIjRg+yWHsdT+A29xeZHtzIb5X6sMvvo76C+Nq3DB110In9lHqEmOCPA
	gyCrr0p8027qWo2EPfo2idFxD4q8YIyel+qwPeBL+UkBeQK4gNJwk74yWEYiPq8tFEShppnLYKZ
	6DiGtMxNTmjAH6SYYPUP+24aNuwGhUhh6hCUTxvNV3bm+6WauQkLWlEULN3hH82xs2Nnymk7FR2
	DX+01davya775UJQot1Ew=
X-Received: by 2002:a05:6a21:4514:b0:3cc:9162:6bfe with SMTP id
 adf61e73a8af0-3cd302e127fmr11748066637.0.1787315517427; Fri, 21 Aug 2026
 05:31:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2155.git.1781710256081.gitgitgadget@gmail.com>
 <pull.2155.v2.git.1787144872870.gitgitgadget@gmail.com> <CALnO6CC35iuyJpKZtkEN7fGuGK7zKd_jbebyZdKSQ1pyfOBRZA@mail.gmail.com>
 <xmqqo6ewtqs8.fsf@gitster.g>
In-Reply-To: <xmqqo6ewtqs8.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Fri, 21 Aug 2026 08:31:46 -0400
X-Gm-Features: AcwNN1UuUWB9n7vRMjCEpkEK187pFsqTNJFR-ePW0z3jeLLwUfZePj2b3BHFH30
Message-ID: <CALnO6CCr+CMhB6Pxo7KHExcJ7PBcEQODEJa_PmfguCr_WYVS+A@mail.gmail.com>
Subject: Re: [PATCH v2] completion: zsh: support completion after "git -C <path>"
To: Junio C Hamano <gitster@pobox.com>
Cc: Lutz Lengemann via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Lutz Lengemann <lutz@lengemann.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 5:39=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "D. Ben Knoble" <ben.knoble@gmail.com> writes:
>
> >>      ++                         ;;
> >>      ++                 -c|--git-dir|--work-tree|--namespace)
> >>      ++                         (( i++ ))
> >>      ++                         ;;
> >>      ++                 -*)
> >>      ++                         ;;
> >
> > Yep, unlike Bash (which requires at least one command in the "list"
> > part between a pattern and the terminator), Zsh accepts empty actions
> > here.
>
> This may be a common misconception.
>
> It is true that a compound_list is not allowed to be empty, but
> POSIX.1 sh grammar [*] explicitly allows ';;' to come after ')'
> without a compound_list in between.
>
> Specifically
>
>         case_item        :     pattern ')' linebreak     DSEMI linebreak
>                          |     pattern ')' compound_list DSEMI linebreak
>                          | '(' pattern ')' linebreak     DSEMI linebreak
>                          | '(' pattern ')' compound_list DSEMI linebreak
>                          ;
>
> where "linebreak" is a run of NEWLINE tokens or empty.  So
>
>         case $foo in
>         bar) ;;
>         esac
>
> is allowed.
>
>
> [Footnote]
>
> * Look for case_clause in
>   https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.ht=
ml
>   and read from there.

Oh, thanks! The Bash manual doesn't admit that case in my reading, but
it clearly does in implementation. Oddly, I seem to recall several
years ago that both Bash and ShellCheck would complain about empty
case arms (I got in the habit of writing ": continue" as a bit of a
comment). Anyway, TIL.

--=20
D. Ben Knoble
