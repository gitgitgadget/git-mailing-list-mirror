Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFB72FD7CE
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 18:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758651389; cv=none; b=BOrz6kQMr+ZABmHEKK5PMrANmhmz3Wh2UBMyRRc7WYaBpf/nt1Ns6ClHtwH0nvBJJZD0bUJ/Z3xDYSsEG/dFJ1vA435CYmtJ/XuiMDunw2N0RniTfPYRg/U8apFGhYEXQDaiUfCc0/ZP+8pdAnID4hmgFlxfmbakdpTY8sBZp8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758651389; c=relaxed/simple;
	bh=ExS4YdoT8ro47CuhCA7Ft+cNdVmmMV7NaK99TvPfEso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WpBziCsvSnoKMLp0vqTAu3k3yYACiFM5TD2H1jkrMt2XkRFqsxjgVRGhjebVFzCB+ugCqgXW1WhZhOU+cPoSB0ZioVzVE/sE4E6AEX1DZ/BLeEEkVP6zcN6I5ZK0U/sJA9bMur+QgdwQZmt2sZlPBU5qdT1dPvAeo1voNPhsg4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-79be84493aaso1557356d6.3
        for <git@vger.kernel.org>; Tue, 23 Sep 2025 11:16:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758651386; x=1759256186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4d51G7N05NDr37pDMoBWSrrWvrzvwKlWzukIrtAf6WY=;
        b=Gm1a/oG8ajKY4YAYyNIXiEhcYjlnEAE0ADLYRZSL5zG/M1P0l3wsM/ZjglxLRKNu6r
         vwVHgLj9gq9SapB94twxneCc7NWz9Zk7E8G3KVIVMB0FbRxHtp9d7SYVB+snyuGkxOAm
         wHg9oR7RfL/6D79Tf3OdALcmuTF/Ysf9g5+S/XczWdorvBHcPQ83ZGUk2y8sBCONYaDR
         qmQJibKGhhNxiF0V8wgZXDQxeL+6kgEwaYSR3eH8SAybfP7B6zVqfJkctlzyHvvx+fBr
         YK6hv8zac+/bq+QBjp2qfRa+/neY0eAEfcUUEwUz/8wSjG4uCutnbbRhU9SXbJORFqyk
         jBGQ==
X-Gm-Message-State: AOJu0YxysiA91jcn2MgslPg8pOf2p9w1tJQ0IG9K7QY9hwWpfHHlyiT1
	awR5j+wX4BeIEFwZJ0trU1GEzgWPfbBQpHOT8T/vN9J3TDgj8dDzMOt7Iu5tUz4m49blyPUiqLY
	aYmELVOtc7PWhBM+1ped0b4fAt5vZ9tk=
X-Gm-Gg: ASbGnctFyg7cRPnv26ATjDOM1eIVWVky4MGS6TMUvYZKf/tVMDZ7z4uxH1VNBWlEszQ
	vAk3f9ADJlvqr5g29b/uaOqJMc1PulvEs8u7lcKnkIPnN/+lpZaYr5zReX1E39n0S0XaDKDBCqQ
	twRUBO7aw66346oRRtr9PdMNOhhOIV7V1b9HiHdF3hActTFKUAJYr9ty0AkfNy/nZS508OODTfl
	s8f1A==
X-Google-Smtp-Source: AGHT+IFC5p2Du2fC1LFbQlXhrRF5xFf/6aRv36zMq6egvxdWhhz6WIqX1kcDQiCAW7nPrNY7XkuioHbQQkxmiv8a6Qo=
X-Received: by 2002:ad4:5969:0:b0:78f:145b:56d9 with SMTP id
 6a1803df08f44-7e71d7937dfmr25138016d6.8.1758651386247; Tue, 23 Sep 2025
 11:16:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3945bf06-ba04-4ecb-887e-0f3a76e1c2f8@app.fastmail.com>
In-Reply-To: <3945bf06-ba04-4ecb-887e-0f3a76e1c2f8@app.fastmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 23 Sep 2025 14:16:13 -0400
X-Gm-Features: AS18NWAfz6JgqyjrhQrxrTiQFCgGykndfoYuwWqzV82QqMbvA3v3uBBh8AvLRac
Message-ID: <CAPig+cS-qYqpK2GOzSLQtqF_gqan6hftnnOnfMFUKby1nT5n7w@mail.gmail.com>
Subject: Re: format-patch: why are the Range-diff: and Interdiff: headers translated?
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 12:54=E2=80=AFPM Kristoffer Haugsbakk
<kristofferhaugsbakk@fastmail.com> wrote:
> git-format-patch(1) has had translated strings for `Range-diff:` and
> `Interdiff:` since they were introduced.[1][2][3]
>
>     // Example
>     _("Interdiff against v%d: ...
>
> Is that how translated/l10n Git is supposed to to work?  I get
> translating errors and such=E2=80=94that=E2=80=99s for the user.  But a C=
olombian user
> might send out patches to an international email list.  Why should their
> own translated UI (again, if I=E2=80=99m understanding l10n correctly) af=
fect
> the patch output?

Making these translatable was deliberate. As I recall, I had been able
to formulate arguments in favor of both making them translatable and
making them non-translatable, though I no longer remember what those
arguments were. One argument in favor may have been that (a) the
titles "Interdiff" & "Range-diff" are meant for human readers, not for
machine consumption, and (b) there may very well be
non-English-centric projects (open-source or not) using a patch-based
workflow.

I further recall that I was expecting pushback from reviewers and was
surprised when there was none. Hence, those titles remained
translatable in the final version.

As far as I recall, this is only the second time in the intervening
years that someone has questioned why the titles are translatable. If
your reason for posing this question is that you believe the titles
should not be translatable and you wish to submit a patch series to
rectify that, then you won't get pushback from me. Also, in support of
such a proposal, I do recall (though can't find the email) that Junio
once pushed back years ago against someone proposing to make the
diffstat "x file changed, y insertions(+), z deletions(-)" summary
translatable.
