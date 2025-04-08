Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EE5263F24
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 07:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744097762; cv=none; b=VIK6CeUR5a19YIa66vIULrEzJFEpdQTxnEg9gLaFTRu2KMm+awrVtftP+GUe4NA0gUzqnWZgK9lRIF+0qwrlKvoKTY4BcwzGTe1L6A677r6Vzx7rI9cAsweoNxvtjeQBce0gFUH1J8xUZD5Vw0t+80mF5sSSsdgFmBLIVh0wSa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744097762; c=relaxed/simple;
	bh=Pv9vJ2JnVpTPzpPqRfEB1gf+me+pdaHK4LjmE7Au1oE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fpRiEgavmuNxcGfHBGix/M4vpNOv6l2RAVLuyiGbSBJsV1N9q+so6QTZ6T4lQ83zhbTSx2zeVpcjfirtVzGVCru6p/FQ5CbsIyoFr2IOF3DB0teweyZe6WFOG57ZCoRj2tD9zKmL/xubzjFFVQiEMmwqyycxozUzOeYv+cbKiXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VQBhFOFy; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQBhFOFy"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4769bbc21b0so47080501cf.2
        for <git@vger.kernel.org>; Tue, 08 Apr 2025 00:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744097759; x=1744702559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FeC/sauCoaPjxvW5Ojos82rtkPn3ZqUTz4smG4k1wdM=;
        b=VQBhFOFydJ5qc6Ta9JMjZCUDMQgwatEmHBCvHVxV+tqXuawwQJpn0BHt7+1GjXL1YS
         xeMPLPlEufpAZQcZQah2hpysWruU2qQsCyq9bdIdlBVJD2hq2t0mx/l4PsDBZsjqbxJp
         rRWIMWzjTOfTu42o2/zxyKo77ADB8UdBAEPzNFMAnmoN4EHRWkT+rzoTI5yqELCmswcN
         +q5Fpx6CIdwyaATptctdxG9Cx1fIRRb+3ERLkQPDtx/zL023roET1m88xEabtDv6zEis
         uUgBTO6hLOZmRgtHu9Zs5QeJ+q878tKWldl9jR2jTwM/gVZRWQbr4cGsem4+F4M9gGqF
         tsjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744097759; x=1744702559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FeC/sauCoaPjxvW5Ojos82rtkPn3ZqUTz4smG4k1wdM=;
        b=kjd/UuMoxyEWIT2AjlBS8ogFHd1Kzw34iWDPDIioF5utlDy/45NNxlSXDSZ29D4t/E
         7Y775GhIFnKA65clXG9wGQ4S3/IUIOiuB/m8SlDO20Gmk8IQMd3GXXedc2N3hTT8h9Ok
         clqXaJHvEgKOBJs6Ndg7jN8tmWEzPYSEPgsXH3fmg0Zq/PHGc/Jv5tLknZsk8iUaLSFr
         0WerTTutmAiI9AQnVKTqZF1FH60bfQ5AhbHKz5Vtxz9NHNCqfR9A273NJr1y49Q1qPE+
         v231yJD3MgBlsykp4pXcxDo/fg+1zb/av9iJQBzRdqm4x7zHWKqjyqbOTsRtcaAj3zPN
         H4bQ==
X-Forwarded-Encrypted: i=1; AJvYcCUys7Ej8fPGSbURnQOCZDwtF94CJCrN4m5Lj5/pLs5t8M0tWHURy6Qjo0H/MtKz5DBuyw4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDsU1BXLyNrPfFGJq6HuE+rFqFI5pMBXJeaAdYN9F5hz3MSSZM
	vxF6hF6IzPhx+Qsl+fzHDvXTKjwxPPC5vOuGoWtZUEDwnhTKhM/nm2lP91MFDBTcqdX6nHKGmMm
	sQny2byK3IsBC/INbK/pI65+qFA==
X-Gm-Gg: ASbGncvQNUlvogWx8R6/DV+72CDvADWmJHblpcuZ3tRKM2hMzHNzJKNlZmPFm58Z6c6
	dge/rH3f9lqqjRPVDdqzKBelwOK9F4YJoIoPbKxUwVhB9rHzf0/IsoY2iGD+UW48qZLD8wwowVv
	Xxy27bFrpNDmRmmOHKbv9uSLeN0g==
X-Google-Smtp-Source: AGHT+IH4vx9LFZcVDA0XpcXEKdPrLo1EHTYMJwPbzXDuy2HxgFcddp1f47We1QHIqGnh00r/DDcV5o6DS4HNo9W/I6I=
X-Received: by 2002:ac8:5ad6:0:b0:476:9b40:c2cf with SMTP id
 d75a77b69052e-479311140ffmr212554601cf.50.1744097759252; Tue, 08 Apr 2025
 00:35:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqo6x7nb2a.fsf@gitster.g> <20250407212834.53183-1-anthonywang03@icloud.com>
 <xmqqtt6zjyma.fsf@gitster.g>
In-Reply-To: <xmqqtt6zjyma.fsf@gitster.g>
From: Anthony Wang <anthonywang513@gmail.com>
Date: Tue, 8 Apr 2025 09:35:48 +0200
X-Gm-Features: ATxdqUHUMhJ8sDSQa8acCQXp76nj9d7i2owwXQ2uqraDJdlW8uEemUy4C0wnyFc
Message-ID: <CAOSofofS311fMqnDpyFpUVC8vYcTcNy0EwKfvxfzEXWBGWvRkQ@mail.gmail.com>
Subject: Re: [GSoC] [PATCH v2 1/3] t9811: avoid using pipes to expose exit codes
To: Junio C Hamano <gitster@pobox.com>
Cc: anthonywang03@icloud.com, christian.couder@gmail.com, git@vger.kernel.org, 
	karthik.188@gmail.com, ps@pks.im, shejialuo@gmail.com, 
	shyamthakkar001@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 2:17=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Anthony Wang <anthonywang513@gmail.com> writes:
>
> >> If so, instead of grepping around, we should be testing that in a
> >> more direct way, perhaps with something like
> >>
> >>         git show-ref --verify refs/tags/TAG_F1_1 &&
> >>         git show-ref --verify refs/tags/TAG_F1_2 &&
> >>         test_must_fail  git show-ref --verify refs/tags/TAG_F1_ONLY &&
> >>
> >> no?
> >>
> >
> > Possibly, but I believe adding the test_must_fail check would be modify=
ing
> > the original intent of the test, as it would pass even with the existen=
ce of
> > TAG_F1_ONLY. However, if we are only performing actions to cause TAG_F1=
_1
> > and TAG_F1_2 to exist, then it would be an issue if TAG_F1_ONLY existed=
.
>
> I view it a bit differently.
>
> Use of "grep" over the output of "git tag" is simply a sloppy
> programming.  If the test wanted to verify "TAG_F1_1 exists", it
> shouldn't have grepped for TAG_F1_1, because another tag T_TAG_F1_1
> would produce a false positive hit if the earlier test gets updated.
>
> Similarly, not verifying what should not exist is being sloppy.
> People who come up with a new feature (in this case, "git p4 sync"
> involving tags) tend to test positive effects to show how their
> shiny new toy does things, and forgets to test lack of effects to
> ensure that their shiny new toy does *not* do what they should not
> do.
>

I see, I agree that the test is written just to check that the feature
does the intended thing, and not properly written as a tests. I will
make the changes and submit a new version.

> If the original test were written solidly and use of pipe hiding
> exit code were the only problem it had, I would agree that making
> minimum change should be preferrable, but the original test seems to
> be so sloppy in this case.
>

To this point, I have a question about when to modify code when making
patches. My understanding is that we should try to only modify the code
neccesary to fix the bug, and not modify other parts of the code.
However, because in this case the test itself does not correctly test
for the intended behavior, we should modify because we are already
touching this piece of code. Is this correct? Would it then be desired
to check the rest of the tests in this file for further oversights and
correct them as well, or would that be overstepping boundaries? Sorry
for the questions, I just want to understand the best practices as well
as I can.

Thanks,
Anthony
