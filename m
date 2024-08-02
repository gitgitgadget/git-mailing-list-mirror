Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B10578C88
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 21:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722635663; cv=none; b=Jvra34qkJX9HPIYtFH0edBy4QSCBdHWWS8KO2W3FVk21wXTyDFY4xSZBEpcjYkgY7r0YrVJ65dK0GYxWRj8xdu156C+1M8PIV8QLtSOEYw9HgXwUgQpolGa326UIbv8RDZYX+tZSI7/Sw7d71WkBscJKWF0JXYbAFSp0UhNllZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722635663; c=relaxed/simple;
	bh=IVzPPA6DatLP4MQytJlatgkcu3wMOtaONLjhg5J7Fhw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dJCG9FNpV6q5jSZspQjc+oWnaaF/0Y5zwr8YBOeUnptm7d1MJik+WebQ5vtmOXdXOja4EfO11TPQBA8D9EI0ElAVmf9iJCs309S2lWqcgZNQ1fQUqbOQ1/8LO02YzeO7RSuzRm2Zio9mIYDlu6Lr9eWgvsEzYQFphYck2z70e+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6bb96ef0e96so10650346d6.2
        for <git@vger.kernel.org>; Fri, 02 Aug 2024 14:54:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722635660; x=1723240460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0pSQJdHakwoGiTjRRXppFPfM/Ta7vkKGQ2GKrtagZHM=;
        b=bklrTcNMpZDX0tCOF5DBpTnc0siE7HGJ7HJdiWcZjra8LpdryR/f2dlzLiIL6we2Yo
         dRmmHW2KEHiExz18YJ9JE7UC2yfY6rQEEQSsPDYkXjxxaX/U3k8lM9jEdbPqOakFbq+o
         1pnIfYd0AuHbjIKG/+cfmF+lDjnhdZXIjs4B9Y42EWlIqxKnk9PF+5Ns+Y4jrz+IWpyT
         UoQOzBIzh0kQQi91ogsQfV2fGkrVdAQtKTXDdJewvKTcmpe/7S8a/b77ysEedwbY7KpI
         UFQs64m7SA3Nkj/aErIKXz1/NuSe2rMIDlIz/omA7vBkFsBmCorFK6F6hFXIPjekT33K
         VJFw==
X-Forwarded-Encrypted: i=1; AJvYcCWjc35LcEwpAtutVN/OcbskhVjIdS9ILt842yXhRic9W2eF5WcSA5cjimwys2M/yjeJbeTe3BuuH3F7KkJ5Wr5a/CoG
X-Gm-Message-State: AOJu0Ywhovg19w9EovKKA4fu85ayrlPdBaqJ7cP15d23lYHhEUBuIEwz
	AXcqBsRPgTSY8ez9hEBfYJIXa93CnmB542c3T0arUeLV15VZ3D8tdZqFJsZtSI5mFRgn1/9hU5I
	keNaoBFPjN1eQhu1Ydc9Ga4tb6Yk=
X-Google-Smtp-Source: AGHT+IFO18g+VyZ6H+wu9u4Qg6+dgGlKULW8Pp17GMoA8XcpE33BwWh38UARhxGfb2SA320liBhZgB5cTNqOqMTClpk=
X-Received: by 2002:a05:6214:43c2:b0:6b5:525f:3cb5 with SMTP id
 6a1803df08f44-6bb98372788mr63884466d6.19.1722635660138; Fri, 02 Aug 2024
 14:54:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1756.git.git.1722571853.gitgitgadget@gmail.com>
 <pull.1756.v2.git.git.1722632287.gitgitgadget@gmail.com> <0ed09e9abb85e73a80d044c1ddaed303517752ac.1722632287.git.gitgitgadget@gmail.com>
 <xmqqv80ia9wf.fsf@gitster.g>
In-Reply-To: <xmqqv80ia9wf.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 2 Aug 2024 17:54:08 -0400
Message-ID: <CAPig+cTmzk7AN2x8-WCK_T5-_G7Wd-akB2++_4HFEbT67Rnc8A@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] strbuf: set errno to 0 after strbuf_getcwd
To: Junio C Hamano <gitster@pobox.com>
Cc: Kyle Lippincott via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>, Kyle Lippincott <spectral@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 5:32=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
> > [...]
> > Set `errno =3D 0;` prior to exiting from `strbuf_getcwd` successfully.
> > This matches the behavior in functions like `run_transaction_hook`
> > (refs.c:2176) and `read_ref_internal` (refs/files-backend.c:564).
>
> I am still uneasy to see this unconditional clearing, which looks
> more like spreading the bad practice from two places you identified
> than following good behaviour modelled after these two places.
>
> But I'll let it pass.
>
> As long as our programmers understand that across strbuf_getcwd(),
> errno will *not* be preserved, even if the function returns success,
> it would be OK.  As the usual convention around errno is that a
> successful call would leave errno intact, not clear it to 0, it
> would make it a bit harder to learn our API for newcomers, though.

For what it's worth, I share your misgivings about this change and
consider the suggestion[*] to make it save/restore `errno` upon
success more sensible. It would also be a welcome change to see the
function documentation in strbuf.h updated to mention that it follows
the usual convention of leaving `errno` untouched upon success and
clobbered upon error.

[*]: https://lore.kernel.org/git/xmqqv80jeza5.fsf@gitster.g/
