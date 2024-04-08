Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E251422AC
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 16:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712593769; cv=none; b=J9UcWEdZBUrtXQzU3DFUE82MpiPY4+JijD8Ar30IfgjKJHlFlSgecXUGXRDvH7ghwVZLkmG1qREchdLZDeFtJm0ef1X5SWmVh0Sml/p9kv8vIXde8b/sd3Xqunvc5jRx9RDvvs3L6nGQJd7st+LCR47nR6Hc+OJCAGCC4sGOAgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712593769; c=relaxed/simple;
	bh=jGcAAdaVhy4ktu4dn3YdlF3jtAuhorWZTLT60SIufDo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CSVVRiT7azA01s6HSjhLm3n1/1UsRN0amK4ccAvBHBNt2Zj0Z0CPQbY8Gw0pkIBgBCkYCO+U0DWXLdgUGiFB+sXn8CItZGy//sScDPpXbkR70WWA9XQCU+yTp7WRcf3JpizaDxlyBhAcwMxLRU/Ut0A+7oEC0485nbDeYzVEheg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-78d543db3a4so155702585a.0
        for <git@vger.kernel.org>; Mon, 08 Apr 2024 09:29:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712593766; x=1713198566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4C5670uKm1ZC+ZnZy+XOS+G6soqF7EHwRahqDUWbfg8=;
        b=m9U8g24tq8EU3HlY4qjAnrq2v95id3qUYZiADG7w9aDTUShy/eyL6fht4SyTbv1egW
         m6hHtVFncYvL6hY+Dy/DvdJlzWo9ypOBflB2lNxi8a/mJrRV8ML09OIKvSdoVdZk6oR1
         9jjOcITVWFKQdPFIbyfeGomg7SnfQKwaAxA7/ss8Xunrvu2kqzcRnZ1ckZiBP+iPDFms
         xycuSM5C6SZjYeKsTmGaPicfBaoTxpvXeDqKiVgF90gNLM3xQiNVFyYLJcucd0x0DYuf
         ne8jc6o3sj/SmL4UohSqzlpYc8SxGc7qkDt5MMRH1xazFm66BbxQmw5i/jpjjqbYQ5EB
         r0ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVP4JDot9W+dp5nicUDfLp9vVw7DYJtTjUMHwjN6Zf+Fjsu8WXZ0ONIEE4WpGy+qIKTJcnBt2N8Y/T3cRbZzxqK7KOb
X-Gm-Message-State: AOJu0Yym50vqejU1fAXLaee7hdSLhgpVL4hnlYKUzgYhL8jZDxDfA+8Y
	fRZxUkMvY4Nmcka04S8xJwuPA1VG7ttFbl7e/fTa8CYXc7DK6bK55EdpdW2uTt+FNFzc4Fqf6lJ
	8+wMwFSezO49QQUQeEkV1yMcAHLXBtehG
X-Google-Smtp-Source: AGHT+IGG02DqL7qJBmEKjqtpI4bOUdRpCUld8WXTSbCAzu3B+vPgfWdKxsBdLdLFGTU6EpAlTXwjQAfLdSs6LOa/lh4=
X-Received: by 2002:ad4:596c:0:b0:69b:1342:f3a3 with SMTP id
 eq12-20020ad4596c000000b0069b1342f3a3mr5156061qvb.25.1712593766304; Mon, 08
 Apr 2024 09:29:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712235356.git.ps@pks.im> <cover.1712555682.git.ps@pks.im>
 <160b026e69547739a526fb6276a895904a4d33a8.1712555682.git.ps@pks.im>
 <CAPig+cT3kvvHL+wLTFj58e5BnB7yBA=HD3C4vWC4zQhys3GCHA@mail.gmail.com>
 <xmqqpluzet2z.fsf@gitster.g> <CAPig+cQd7yfVVr+yZDxYY_oe8wC5OGt-SKtCnhCzZqJ0avP-Jg@mail.gmail.com>
In-Reply-To: <CAPig+cQd7yfVVr+yZDxYY_oe8wC5OGt-SKtCnhCzZqJ0avP-Jg@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 8 Apr 2024 12:29:14 -0400
Message-ID: <CAPig+cRERJGij+1486x3w97y6k=KHTSzp+FepbyUi080R6m1aw@mail.gmail.com>
Subject: Re: [PATCH v2 12/12] t0612: add tests to exercise Git/JGit reftable compatibility
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>, 
	Josh Steadmon <steadmon@google.com>, Luca Milanesio <luca.milanesio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 12:19=E2=80=AFPM Eric Sunshine <sunshine@sunshineco.=
com> wrote:
> On Mon, Apr 8, 2024 at 12:07=E2=80=AFPM Junio C Hamano <gitster@pobox.com=
> wrote:
> > Eric Sunshine <sunshine@sunshineco.com> writes:
> > > I was going to suggest that you could accomplish this more easily
> > > directly in shell (without employing `awk`):
> > >
> > >     {
> > >         echo start &&
> > >         printf "create refs/heads/branch-%d HEAD\n" $(test_seq 0 9999=
) &&
> > >         echo commit
> > >     } >input &&
> > >
> > > but then I realized that that could potentially run afoul of
> > > command-line length limit on some platform due to the 0-9999 sequence=
.
> >
> > As xargs is supposed to know the system limit, perhaps
> >
> >         test_seq 0 9999 | xargs printf "...%d...\n"
> >
> > should work?
>
> Hmm, yes, that should work nicely.
>
> Whether or not such a change is worthwhile is a different matter.
> Although it is perhaps simpler and easier to read, Windows folk might
> not appreciate it since it spawns at least three processes (and
> perhaps more depending upon how test_seq is implemented), whereas the
> `awk` approach spawns a single process.

And, to be clear, I have no objection to this patch's use of `awk`. It
is "good enough" as is; I was not asking Patrick to make the change,
but rather made the comment in case the idea hadn't occurred to him.
