Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14F47D098
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 18:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754418843; cv=none; b=UhJ21dyOT/074sTjATfZGXjMALidkvITXPcI+VHPtA2LmQerBJI5EM6SASDkCOu7YiJVwTXRMMUyrH1TtWtVd0VfB3/0VoxYUUthTXfaRSwYw3/VX8DPRKDk6oyMAQmq/tYrknMamyMR5n5xLsg8aplII2RuVgs19T+TzQz3ufQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754418843; c=relaxed/simple;
	bh=z+G+rVoJij7MA8pdMfk454DcLvLB8o6kfXmd+xvSs9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jvhb54DYdhGOuAUNgYSjUN4jcQvpfxuoStfTSUcLU3IOh44vKc+1kv1PGKrRRzhpCOlL1N7dRMbX4snRIopLPnb37WazSfWEPJgClfQRN6UAicvIKca1Ayseg8hpw7nJ1XvcNnC/VnJpBF2LRNbolw9cI6myb+GDVI+hCIVKheE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R4DcwOEa; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4DcwOEa"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-741aced73f5so1565403a34.2
        for <git@vger.kernel.org>; Tue, 05 Aug 2025 11:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754418841; x=1755023641; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eZUOJO8V88pwJrr19gv6L0w1uTu2UJA5adLr5tiuX+c=;
        b=R4DcwOEaVnC+vCFfd+D7xOqae0j7hwzanW/d0+K8su+986RpzHy9MoZr3niBuhHvNH
         HMWdChtE/vqjzQKwA8eKrOq79QsutZhDS/E9QlN2KIoJaNy/e1TiE0WSCGh/n2AUovs5
         ZdgPoH+wkla97v1uAxbsyAVKVOYFXTBhq0nxv1VY8QW2no8bk/uxH3XetrBoxBXepfpr
         yIQ1GgT4wXC6JIeFEtDYBX4ihe1Da4OkN1Ga+/WzrFC/pPSGZX7O++X4iKCtfRQo07TZ
         rs+FplV/ScTAdlU4kTFVWL0tzlz5tQY35CAFOf+mC36Hf7TdgEcvTFf8M1X/mDfTkMc8
         FHLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754418841; x=1755023641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eZUOJO8V88pwJrr19gv6L0w1uTu2UJA5adLr5tiuX+c=;
        b=u7Xet3KBMNK/WMoD/pTk5WKPjTeqW8KBIoe4b9lQLRFugT1qQ6SA6mK38qTt18Uxr+
         3V+RmC/9YgWgXNol0wptWYqO81WG8YGxlut/U+GWztJJPfCXu6uklrIjIBMQJy9AOSKY
         9O3pVDIHv2AdcUqCiF8BSl1L2RJV5UOZXkkBU63kkbgB9CpH2yimlxKTSIVIDxc/SoXr
         XCv3eAps6L3EmzFEPtuqGkUrdJC+4pwE9NUDy7oLWNX+KMFgVVExQ8eF00Xf0TCiAnkG
         EnaFPiqrxgsfg0vc0mnJXOOW9P3R/Aw+iz2gWl1sAGuSQ3AN/rfGktd+2o7g5U7auKaa
         sK+w==
X-Forwarded-Encrypted: i=1; AJvYcCW++6AdOgJTvBF4Ru72SGmCgkePaZ57fq2jnpMdABLSWVNCkthTL725W0WrPUz5Iapplx8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB9npwiUi7gOxJXzzHzOtUmWfGEGK+idgEVPx2x0oVZNmwVni0
	1XwIPL8pOYZKQDZa829RBhXacMTvNHump+FJ2IwLHrRiQ0PHrJR+Rhx4S9C714pFtv5YC7i0yTq
	e8fC2AVWf23CE6bVEGJppA2WFf5lQQCBrQg==
X-Gm-Gg: ASbGnctd8upnjynDoTmLtntFF7mj+CBq3Z8TAzf6FsulbDaTxGzoOPvdftDbWjY7JPI
	kE8FwQ2h1Ym4mDzZKxb/VAd3MbHbcMM46id7Wdw2T9huqpXd02EBKXZ0HyrfO6ZFSY8ll5564g4
	gfeyPem3pCzzp5bIvlwGKI06XVeWHQDwg0msWUCmBCKN/HsS3k7LMly7+kehVtjO5hwoS6e8pAt
	7KTOLc4VTzf8BaWOvsnzr7zsbaASOUHkRF4Yj2K0/6Gf83RaG4=
X-Google-Smtp-Source: AGHT+IEx8kaRXiXOcBCzacXpC49TxJqzyTDd8W15CgddZ0xzU6o4R2oFQHvKuoYc9aApe+qpZudlVIv3DxU8ECVhgf4=
X-Received: by 2002:a05:6830:2a06:b0:73e:a0fd:ac58 with SMTP id
 46e09a7af769-74308d389e0mr180224a34.11.1754418840581; Tue, 05 Aug 2025
 11:34:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1943.git.1753197791.gitgitgadget@gmail.com>
 <3b3b258cec5f0080beb64501f7510f7acbc3a91b.1753197791.git.gitgitgadget@gmail.com>
 <aIx7Qp_epPOpk8OF@pks.im> <CABPp-BF36TtAaqbV01m82Cj_7Mr23P1DEuSTR7oM9odLbD9q5g@mail.gmail.com>
 <aJGK4tSCkWgBK32Q@pks.im>
In-Reply-To: <aJGK4tSCkWgBK32Q@pks.im>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 5 Aug 2025 11:33:49 -0700
X-Gm-Features: Ac12FXwmn8LYQ-EGByjp_G83_q4K-J9jkts7kB2Fed3b8v270_j8ppDEYCjDujk
Message-ID: <CABPp-BECD8RwYx=ci1_kpu_vkctMZL-QqA+Da-sYfoCEhGKRQw@mail.gmail.com>
Subject: Re: [PATCH 4/6] t6423: fix missed staging of file in testcases 12i,12j,12k
To: Patrick Steinhardt <ps@pks.im>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 4, 2025 at 9:39=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrote=
:
>
> On Mon, Aug 04, 2025 at 12:23:49PM -0700, Elijah Newren wrote:
> > On Fri, Aug 1, 2025 at 1:31=E2=80=AFAM Patrick Steinhardt <ps@pks.im> w=
rote:
> > > On Tue, Jul 22, 2025 at 03:23:09PM +0000, Elijah Newren via GitGitGad=
get wrote:
> > > > diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-re=
name-directories.sh
> > > > index 69de7a3b84af..c2032eb6cfa1 100755
> > > > --- a/t/t6423-merge-rename-directories.sh
> > > > +++ b/t/t6423-merge-rename-directories.sh
> > > > @@ -5114,7 +5117,7 @@ test_expect_failure '12n: Directory rename tr=
ansitively makes rename back to sel
> > > >               grep "CONFLICT (file location).*should perhaps be mov=
ed" out &&
> > > >
> > > >               # Should have 1 entry for hello, and 1 for world
> > > > -             test_stdout_line_count =3D 2 git ls-files -s &&
> > > > +             test_stdout_line_count =3D 3 git ls-files -s &&
> > > >               test_stdout_line_count =3D 1 git ls-files -s hello &&
> > > >               test_stdout_line_count =3D 2 git ls-files -s world
> > > >       )
> > >
> > > Should we also explicitly check `git ls-files -s baz`?
> >
> > Why?  There was no baz in this testcase -- not only did it not appear
> > in the final commit, it didn't appear in either branch being merged
> > nor anywhere in the entire history of the repository.  Testcases
> > 12{i,j,k} all had such a file, but testcase 12n does not.
>
> Mostly because the line count was adjusted, so it seems clear to me that
> "baz" at least plays a role here. Otherwise there's a mismatch between
> the number of lines we see and the state of files we verify.

Oh, oops, the _previous_ patch should have had the change from 2 to 3,
when it also introduced the expectation for 1 copy of hello and 2
copies of world (and marked the test as expecting to fail).  The
comment on the line above should also be fixed.

(However, this still has nothing to do with "baz"; there's no such
file at the toplevel or under any subdirectory -- in any commit in the
repository this testcase is running on -- so it's clear that "baz"
cannot play any kind of role here.  But thanks for flagging this
change -- it definitely got squashed into the wrong patch.)
