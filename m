Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55E833CF5
	for <git@vger.kernel.org>; Sat,  6 Apr 2024 17:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712424910; cv=none; b=GBvD7VXNviHai8cOUwYL+d0yhBbouXY7XtAa5XsbqvbOKRPB0lanYItXxn5a3j+7fhvrk8KCaFT/a+NbzNrgL3RV8HJ26NmcLYED9cLQe9vnqmzGMsR2MI7zceEg2qr9QxTSqonay8gDMayGV6yWXw/vTajub8A6EsxBVlP/IKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712424910; c=relaxed/simple;
	bh=Gk7zj+pbV+/Riqyj9gdMsdisPgBxFZhI9rino/fANU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p8ZY8VWragUdS3/7tnBqAW96Ob+6tsiBl4C+XN8+CREyeFyIhIhDCZFw5RdFdWcfg5to5HMDLjBLTQ/YuqvXcVtLjUCNEoMwDsHF9YthKDC/xhhg6vG7GHvA1Q/Qe59Ss5cvVtqQbp71PRA2nSL5L5IKI/m9tT1fd7d0V48LPMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-69935d567a0so18407396d6.1
        for <git@vger.kernel.org>; Sat, 06 Apr 2024 10:35:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712424907; x=1713029707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tzidn0xMsVI3EcKrBdlqtSjrC7n0U8gBZRt7gIX7IrU=;
        b=a7+C03JoYo0RQDSfDdovErO3ydE/LKNh0DZxZSjHVdD4ml+8LuDIRRPMlohbTIHcb7
         mj5Cpy1HPCQ1CkeP1jDBpUrlkovXCVfbgAEZJpvzLXlv3E0Ze7Zfp0ltBA+Vez5iAzcM
         +glI/ZoLYFjWmi7SxuQmiXI2/LAoZ/Qf5VYdi2LHDuAhIbBYbXtu531FXXQhQ5xrlvOJ
         YRauhdOvt7GVh6AlfxSiUg+hgKMhmVUSR3T4OZqPdh3SDG15/qnqJzKRJLIRBExP3778
         ZSYKNNbjcQwQrJVJb2nPkUunF6wfKpmiaChbnrrrmR3lLpIiLv07kSt6q6JpqHNaKdS2
         f10g==
X-Forwarded-Encrypted: i=1; AJvYcCUp5JzbYMxTRAveueqOT6mmSQWVtt791ZU3DLuYPW67WNkZIqrZcpiiufUFAouy0RX4eQ9f6qhQ5CN7i8xxXkKnTvkO
X-Gm-Message-State: AOJu0Ywa0yGDRDyU4lzUIH8lnE3KHbWGjSBFC8egwdbXt5hkUCKFLjSg
	qzcREXhfJwNHqPwIQyPNIdMss+rEooFA1uEP/V1axYTZxMyLEs5rks4xj+nC2YagJMldivRqWb5
	MsdoJhaqeuyH00z3eLXCPMHAx4S4deB+X
X-Google-Smtp-Source: AGHT+IHA/o94AVkOMXTDd71PDFWWkNW5YXxLXbvvdCcnjNdBMGf+7CxiKBeXL7YSWWI+CYGMAHaXMImKUxdjwb6ztRc=
X-Received: by 2002:ad4:4491:0:b0:699:4b0b:421a with SMTP id
 m17-20020ad44491000000b006994b0b421amr2253648qvt.35.1712424907603; Sat, 06
 Apr 2024 10:35:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240406000902.3082301-1-gitster@pobox.com> <20240406000902.3082301-2-gitster@pobox.com>
 <CAPig+cRjqe-rgYf5UZr9KXmfSw98ZoYjPo5PKhwzRaC-svwshA@mail.gmail.com> <87bk6mc0nj.fsf@linux-m68k.org>
In-Reply-To: <87bk6mc0nj.fsf@linux-m68k.org>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sat, 6 Apr 2024 13:34:55 -0400
Message-ID: <CAPig+cQurykHFWvPY7jRKSPARMDyUhJJHH8fL6zffE6ke8b1mA@mail.gmail.com>
Subject: Re: [PATCH 1/6] CodingGuidelines: describe "export VAR=VAL" rule
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 6, 2024 at 5:15=E2=80=AFAM Andreas Schwab <schwab@linux-m68k.or=
g> wrote:
> On Apr 06 2024, Eric Sunshine wrote:
> > On Fri, Apr 5, 2024 at 8:09=E2=80=AFPM Junio C Hamano <gitster@pobox.co=
m> wrote:
> >> https://lore.kernel.org/git/201307081121.22769.tboegi@web.de/
> >> resulted in 9968ffff (test-lint: detect 'export FOO=3Dbar',
> >> 2013-07-08) to add a rule to t/check-non-portable-shell.pl script to
> >> reject
> >>
> >>         export VAR=3DVAL
> >>
> >> and suggest us to instead write it as "export VAR" followed by
> >> "VAR=3DVAL".  This however was not spelled out in the CodingGuidelines
> >> document.
> >
> > I suspect you meant:
> >
> >    ... and suggest us to instead write it as "VAR=3DVAL" followed by
> >    "export VAR".
>
> There is no difference between them.  The export command only marks the
> variable for export, independent of the current or future value of the
> variable.  The exported value is always the last assigned one.

Yes, I know, but it is customary in this code-base to write it as:

    VAR=3DVAL &&
    export VAR

not the other way around, so it makes sense for CodingGuidelines to
illustrate it in a fashion consistent with its use in the project.
