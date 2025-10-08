Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D38723F422
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 03:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759895512; cv=none; b=jOXasPPcmbcKdyyJxewSMFueNbwjSdvuH4oPDARCnLsuHiKPMYsVx0o9eN/iKYylJygQIhd39/DN/DVgZTBX+1DfL1kOCvfY97nO6uVRQCOmy4CQrouMyG5L6dXyrAT/Y7J7NiGGYBKrhhwKR68mPD+SrYwC5uQkl9mN84p1l2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759895512; c=relaxed/simple;
	bh=I3IrQ9GzGsM2NP1xis3mXY/I6T2H54Oq70iOR1MhFSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j4LZnsUzGHjl96dNHq3D1ww1WMsWHtjVS9Y7wEoXx6RHaKUsZhGVCdYtlHlkZP4lh4F71OVzpY2LsfG3NigIYK/AWM+JgF3BOn6Ptcu+IzQU4KboQv2PRug6QJ0iEavpEAlIipvsFF8V2C1WZjlm3/LzItIM9ALU/czAVX8RCaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nk7zjioI; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nk7zjioI"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-42d8a0f09f6so28585755ab.3
        for <git@vger.kernel.org>; Tue, 07 Oct 2025 20:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759895510; x=1760500310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0RVJoc1Z/EbZvH3VfXK/reKFydjCn78AK2VdHHnHumM=;
        b=nk7zjioItfJCq5d/UOk5GdWsHPzioaw49+Ap6Y40WeSa16DUBxwh/gkGo1xKHnN25b
         xOcEfSWDyFDWH6t0mJttHvDJQoysfCwdczQ86nHOFYjhucXA+Tq4+4hOcVGk1TXmDazw
         XORI+AjtMC+QfiC6Duj4KM0InQPdFLGgZsTw36TJYBrhv05Mu/tO2OpPUBYdp6QVP8tE
         83hcAe22Q0h6WgW/HVl+/7SUDPU4mw3hOU3rcj96ev59PuPdO07qyG0BLkhDnPEMZrJT
         EPB1HnVWwEfO8+Wk7khsdfmBmVwZtBtXx8ZesTZViXg6ukntaLHCO7a9gMGxbOR32t5N
         7zXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759895510; x=1760500310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0RVJoc1Z/EbZvH3VfXK/reKFydjCn78AK2VdHHnHumM=;
        b=oP8anyxgnFISJKawa7VcbS2JKlWMj0OFaqbofRRWy7n8CGs+tnR0swf38e6ko1W1sQ
         kYMlUXEuPVWNhDxDVxzQwanoVOILls95Pv4HgNIe7X7TFbxds+4ZeJRUHQUFVZM0KUWv
         8EmgqUqqOvl4Wo5FdRtosNm4NtE2BMFjcMJb87aq7D14b9oZiBINTomrS32FCfN3k5qs
         kSfK+hO1zdRAr93Af/icAZa7gCTDcyukvia4cSrY51k5F5E/Zb468BFQR11ELa/lXPXu
         Venr0beerg7LJhwFYiPM2gsSCRD63uF7VgNqxVjoRoEYZKLgMneJhb469Fo19z0H9sDZ
         K1+Q==
X-Gm-Message-State: AOJu0Yx6M+OzuVEB7qBMlsqrRd4TsV15HUWpqWtpQSPktilhZN9ux9uD
	F1SynZ8LPr/bOqqgCDKAnV66QevpZUwhxeu4iC/BaAnVwHK1Cs/aMMunb7kCTEHNl8ht95F/cjN
	jDpbobRVURYBBbXK6v/dian4peUop52g=
X-Gm-Gg: ASbGncs0ae+V1c2HNhzdSscXGYXJsGXdhihgXzrS2dwjgLuJ56/YR9ByH8dy0wbzTPq
	l6N/Xq7XM7xXqiHH7FBf5oGCyHpN4a0CdYxse/tJ9iVQFW9dT1LDw5JHw/nuZnARx8dvPJ1R7oe
	YJkQFLMg1FLLT4RNtCxwV9ubeCyzOwjVvXjvnJGKpZX7Mjxo9Db3bOuyAIxdWPe68Yhc8jNhf4Q
	C654KR4u7Ir+0rX2Wj6sAn3Q8YdSqWmlrmtH4+umWTqGW8XJ4P8UmGohs/DhsaS
X-Google-Smtp-Source: AGHT+IEyb1eLdI/prXfE5NIQoGJvsJh6no1nlHhMGgRXx0dJvoiLwR6y7f0UwkBDQexROJPkADbeDKIGzcqir70PwfU=
X-Received: by 2002:a05:6e02:1d89:b0:42d:8bda:9896 with SMTP id
 e9e14a558f8ab-42f873fe7a3mr14490685ab.24.1759895509982; Tue, 07 Oct 2025
 20:51:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002221233.541844-1-ramsay@ramsayjones.plus.com> <20251002221233.541844-3-ramsay@ramsayjones.plus.com>
In-Reply-To: <20251002221233.541844-3-ramsay@ramsayjones.plus.com>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 7 Oct 2025 20:51:38 -0700
X-Gm-Features: AS18NWC2lP9aND5eWeSddnFGxtQVENjlng47EPatnOgkUqsTNIODQQT535uC5Uw
Message-ID: <CABPp-BGiziz6-7zyq+Z-f0g+JDPMpGuXanmXNEM=0hV-7jKNsQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] doc: remembering-renames.adoc: fix asciidoc warnings
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: GIT Mailing-list <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>, Derrick Stolee <stolee@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 3:13=E2=80=AFPM Ramsay Jones <ramsay@ramsayjones.plu=
s.com> wrote:
>
> Both asciidoc and ascidoctor issue warnings about 'list item index:
> expected n got n-1' for n=3D1->9 on lines 13, 15, 17, 20, 23, 25, 29,
> 31 and 33. In asciidoc, numbered lists must start at one, whereas this
> file has a list starting at zero. Also, asciidoc and asciidoctor warn
> about 'section title out of sequence: expected level 1, got level 2'
> on line 38. (asciidoc only complains about the first instance of this,
> while asciidoctor complains about them all, on lines 94, 141, 142,
> 184, 185, 257, 288, 289, 290, 397, 424, 485, 486 and 487). These
> warnings stem from the section titles not being correctly nested within
> a document/chapter title.
>
> In order to address the first set of warnings, simply renumber the list
> from one to nine, rather than zero to eight. This also requires altering
> the text which refers to the section numbers, including other section
> titles.
>
> In order to address the second set of warnings, change the section title
> syntax from '=3D=3D=3D title =3D=3D=3D' to '=3D=3D title =3D=3D', effecti=
vely reducing the
> nesting level of the title by one. Also, some of the titles are given
> over multiple lines (they are very long), with an title '=3D=3D=3D' prefi=
x
> on each line. This leads to them being treated as separate sections
> with no body text (as you can see from the line numbers given for the
> asciidoctor warnings, above). So, for these titles, turn them into a
> single (long) line of text.
>
> In addition to the warnings, address some other formatting issues:
>
>   - the ascii branch diagrams didn't format correctly on asciidoctor
>     so include them in a literal block.
>   - several blocks of text were intended to be formatted 'as is' but
>     were not included in a literal block.
>   - in section 8, format the (A)->(D) in the text description as a
>     literal with `` marks, since (C) is rendered as a copyright
>     symbol in html otherwise.
>   - in section 9, a sub-list of two items is not formatted as such.
>     change the '*' introducer to '**' to correct the sub-list format.

Sorry to put you through all this work.  I had no idea the stuff under
Documentation/technical/ was ever meant to be run through
asciidoc/asciidoctor.  The .txt ending didn't hint at anything like
this; I mean, sure lots of other files were put through those, but I
assumed this directory was just stuff for other Git developers...

> -=3D=3D=3D 0. Assumptions =3D=3D=3D
> +=3D=3D 1. Assumptions =3D=3D

It doesn't like '=3D=3D=3D' but is fine with '=3D=3D'?  I'm a bit surprised=
.  If
it was about nesting, wouldn't '=3D=3D' also complain since there is no
'=3D' headers anywhere.
