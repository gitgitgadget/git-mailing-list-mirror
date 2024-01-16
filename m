Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B1A3FB39
	for <git@vger.kernel.org>; Tue, 16 Jan 2024 19:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434324; cv=none; b=KxgU6grkd53ZnZ3owa1Y1rhIkSuZgRgZYB0a3xyeYTQcJUXKyptyuBWTIqDNIgez1v0wXfUA2/8xP0DJT1ZP/EqED1E+y1w1CuMKJQjJIKGZe2QnLMYPelqQKRWHHv7+wpfA6AI3SW1D4TAeY+ckdma/QMxIhQ5JPKXOssLLxN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434324; c=relaxed/simple;
	bh=WVxwjbde4apSu5vPc3hteyMsi5ob9SBaN7QaS9Bu+S0=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=I9Pr5YQbMQsht9/dfQ/2uMZ2zkBMIpdQ9SVzjCIZhP/33Oz/nQgUy910aEIP+obOUtBBHxWdeAUWZN5OSUReCABjsHCPshEUVsRapGqK3iTR7ygYTYAx2rjnVGK0RLmmFCJXFcV1uKjIU/iqJxZfmQOi1fVK1pKA2ZQsi+AhnKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g0Juvdd/; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0Juvdd/"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a28a997f3dfso777782166b.0
        for <git@vger.kernel.org>; Tue, 16 Jan 2024 11:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705434321; x=1706039121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iXBSyhRwEW7AyP47ooTrqh1aGHMxLrPF9LKrn9emy9g=;
        b=g0Juvdd/ATOX2s4DurkLLUE3U73m0Vc4NXfNA0KuC/RvbKXPO1K4E0WE8nb3OM511J
         zmL2Wx7QbkG1Aeg/HcuxlRU40Sfczw6C+Fhh/nHD24LxQL34G/tCWUOBveUXmnUalOZV
         28W65nNNtmUuJ+tys/MgiuotYbNr3GIwUEpcaRUBrJNeqy3RkNVBFiX6ZvxgwoOaLtsU
         Vi1bYBhU1/b4KbtcjnaPNthJJEzJWGnPCvuwkIaAlt87Z8jY0pgUxFvwhjUiRgQc5vOe
         4+tpeENJV8DL5niJ8nbpFR525qf8h+qdx5iTLe8EwXqhqy/JMSPDkSToFAiYu1xjhBFK
         A97A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705434321; x=1706039121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iXBSyhRwEW7AyP47ooTrqh1aGHMxLrPF9LKrn9emy9g=;
        b=ULTXb5IXnGP4UqZScJUV1ENa1uciEsW1DtsdJUt4buI8t8DNDT9F85fKFE6O/MjEzJ
         eG5M5GNPyJRNrHvBo40X5FZf7xc4pKMn7ErLEWJgu5BZEKweiMME0CWKtQVI/cWcgCTK
         vSdOkSv5Td5db8wHjey/oQHFr2SZZiW4wQ2/tnV7f4SfCTWUS2ks8ZY3e64asFdC+1xK
         VouaEa2mu6bheVUECoRYWU4C/HgTdL/vDr9onyvVNP+fFuoX9YPK5LJPE76yW3Ppsawx
         yXIfltVluO1rXXBP8sTy/4BHOeJBHS7h7g90Ke9kSOd+Hfb0DgqKwYRydmvDZiHI+FYA
         HQnQ==
X-Gm-Message-State: AOJu0YxkK91uMoLClfHRRJ70i0mLvD/3aJFSxtC1EWQ1xHqZ8OCWUGjA
	HRAFD6DHpBaJmIaBYUs9FT2DPUM84azlIWJm1/U=
X-Google-Smtp-Source: AGHT+IHuc7p44rWTk5WGOjJebSWW7tOmpD9oWSQdrrGeVJEEm4whwRc2gL2YSOo8EyOAY6biSoaSmlaQbMAVQWY3tok=
X-Received: by 2002:a17:907:8022:b0:a28:f8a3:5b61 with SMTP id
 ft34-20020a170907802200b00a28f8a35b61mr3407828ejc.57.1705434321471; Tue, 16
 Jan 2024 11:45:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240105161413.10422-1-ach.lumap@gmail.com> <20240112102743.1440-1-ach.lumap@gmail.com>
 <0d18a95a-543a-41de-8441-c8894d46d380@gmail.com> <xmqqply147bj.fsf@gitster.g> <41cf1944-2456-4115-a934-aff2306a26e5@web.de>
In-Reply-To: <41cf1944-2456-4115-a934-aff2306a26e5@web.de>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 16 Jan 2024 20:45:09 +0100
Message-ID: <CAP8UFD3=Jf3XAK1kZVNi0iR_9iE-rha-SZb2H2z4UeL51YPekA@mail.gmail.com>
Subject: Re: [Outreachy][PATCH v5] Port helper/test-ctype.c to unit-tests/t-ctype.c
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc: Junio C Hamano <gitster@pobox.com>, Phillip Wood <phillip.wood123@gmail.com>, 
	Achu Luma <ach.lumap@gmail.com>, git@vger.kernel.org, chriscool@tuxfamily.org, 
	me@ttaylorr.com, phillip.wood@dunelm.org.uk, steadmon@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 8:27=E2=80=AFPM Ren=C3=A9 Scharfe <l.s.r@web.de> wr=
ote:
>
> Am 16.01.24 um 16:38 schrieb Junio C Hamano:
> > Phillip Wood <phillip.wood123@gmail.com> writes:
> >
> >> Thanks for adding back the test for EOF, this version looks good to me=
.
> >
> > Thanks.  Let's merge it to 'next'.
>
> OK.  I'm still interested in replies to my question in
> https://lore.kernel.org/git/a087f57c-ce72-45c7-8182-f38d0aca9030@web.de/,
> i.e. whether we should have one TEST per class or one per class and
> character -- or in a broader sense: What's the ideal scope of a TEST?
> But I can ask it again in the form of a follow-up patch.

I think one test per character per class would result in too much
detail in the output. Other than that I think it's better to address
your questions to the designers of the unit test framework rather than
to the authors of this patch. And yeah, sending a follow up patch
would perhaps be the best. Thanks.
