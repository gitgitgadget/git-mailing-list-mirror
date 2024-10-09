Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38471DF275
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 15:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728488521; cv=none; b=C1SbyIOl3C6sskNn3dS0b5mR+S8+F8DWmTuWZtt0gtiLnRWclvmP/kDwnbX6Cqbizb0hx84lIyKN/j8yEiVJ9rveV8qBdGCFmGXVrlg4/a0inI6culK3wpPpx98LZVyFTBuJpQIm1K3c/ev+aOUE22eHO3a8DkNovFYqdZb1tY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728488521; c=relaxed/simple;
	bh=IhIIdtlHEe3JVwGr0FsIA+fRNJJkxsbNKc1gDtT9WUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t7IsaSOGtA4Rj48KfiDfXMLbNYapqr6ZsuQzjpU/P+N32SJOaXYB4f3t0wd7ObiBSjS8YZ0d6aCMzBr5YNsbQOXbnMoZnYPmOP7BIywxK8UlwkImAq6YDWxA+v/oXta+8oQMCgdKBTbeiXYHgOnZOAIksJhgvtFvZyJar/3ewM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YcrxFhu7; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YcrxFhu7"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-431137d12a5so5603895e9.1
        for <git@vger.kernel.org>; Wed, 09 Oct 2024 08:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728488518; x=1729093318; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XGFrKAsFPKEcBRVmpKYNCrrlYHf77Qj+e1NLPOh0wRE=;
        b=YcrxFhu7d8ocU/Fy5Mb/DmkdX6bBuD7MwnVpjS4NeurJUDf2Yh+GNLR+YsOwG1/o7R
         PopNyXQcIMLs9tRcJl+b0+9qltgmIA9vn3/OFK7qUrImFqY2+5voVvV0ovSs9mpecyKy
         pvC9qqyeLDjz5KRRbRxs0HEysKkc3lvyKPwXvBe+ZuZm6Pffq9uXySjJ63GdXc2dp0vD
         rGnHNe0031nODZHUVbaAOXpP3HdYsIZ0JJNreFsTK9Dghpa3HIj0QhJ7FJiv9oUOKqCs
         3uLpBhRhr6/Gk/WN4bHacZHfDfyJaFbe0MfmjOAL+lpTUe2uhF8lU679GkwuAPe9fbvD
         Dxrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728488518; x=1729093318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XGFrKAsFPKEcBRVmpKYNCrrlYHf77Qj+e1NLPOh0wRE=;
        b=LqrdVXwg/iAmg28dp8Cu9//yXBWzpuy2YCsF+5N7zF2I8sIZaJdFzjsax+iICi63Pg
         c67hSmPf/9pF+tDM892Sg72kBHKT2MKMyivpQG1Dg5sPNUlVmh+byWaBU0KdRv6eSYbN
         yeQvZ9IAVU4XghNm6RlWywGEXTrgxEbR2Z+yKfFQ4FIF3ID/j9VflpxNElchs2WtEYYw
         YhDjvDVRMbiPST+TXBw+TAPBfDrsOxGiNV+INumm/EK65zok2u4lzmGWZLUZ5TKmHhdw
         6J3XoUPE8YM1EgX+1zO9N9xOlQs9Osk8glwWQA7Fp9SO2oT+7C8pdrlRHxFzawdO5kV5
         4gkA==
X-Forwarded-Encrypted: i=1; AJvYcCWm5PsbqtQJCZLKXQ55fwFYCoTCSqweXHcusq/MSlz5vr63GTbRzV0SaU+0HmsaX3UO3jY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo4zvjv8FuJZQdb5GEizJ/30mGFu9NGKeaiMLfTqsQL5cgMMDm
	GOaBLTJ446GBtIYwmfn12FZXUJkiUCs42ElntJwtOGIaSYsJBRB0dsQMAXP42ztGOWqsIWm5m+k
	h6G+OliEItS/KzdpgOYLD2N2zvSU0RoaPA1Ch4A==
X-Google-Smtp-Source: AGHT+IGvfnBVameEO3LqMl3K/JlFp40YMiUf+hyUuU59I0SyCHD0mu10A13yd5MkT0yPLVYzwDaj4F+73H5a4VIJ1ZA=
X-Received: by 2002:a05:600c:4ec9:b0:430:5887:c238 with SMTP id
 5b1f17b1804b1-430ccf2879cmr23817675e9.11.1728488517814; Wed, 09 Oct 2024
 08:41:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1811.git.1728328755490.gitgitgadget@gmail.com>
 <xmqq34l75pr7.fsf@gitster.g> <CADYq+fYZSGBTnO+dM+MtHj=oUMqDWt+6wu-wEzwfWQJkSomkWA@mail.gmail.com>
 <xmqqo73u1n0k.fsf@gitster.g> <CADYq+fb9ux6K+m-8y0owopt_zKJmXXYLh6Rswot3r7UNX30LAQ@mail.gmail.com>
 <ZwYux_Nb9GwqPuuk@pks.im>
In-Reply-To: <ZwYux_Nb9GwqPuuk@pks.im>
From: Samuel Abraham <abrahamadekunle50@gmail.com>
Date: Wed, 9 Oct 2024 16:41:47 +0100
Message-ID: <CADYq+faN2zFS712tPcfjBE5OjmPVei6Q+ZvcAHU94nag59ZpEA@mail.gmail.com>
Subject: Re: [PATCH] t7300-clean.sh: use test_path_* helper functions
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, 
	Samuel Adekunle Abraham via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, phillip.wood@dunelm.org.uk, 
	christian.couder@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 8:20=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
>
> On Wed, Oct 09, 2024 at 04:35:04AM +0100, Samuel Abraham wrote:
> > On Tue, Oct 8, 2024 at 7:13=E2=80=AFPM Junio C Hamano <gitster@pobox.co=
m> wrote:
> > >
> > > Samuel Abraham <abrahamadekunle50@gmail.com> writes:
> > >
> > > > ...
> > > >  This was the reason for replacing "test ! -[df]" with
> > > > "test_path_is_missing" where I think is appropriate.
> > >
> > > Telling that concisely in the proposed log message will help those
> > > who are reviewing the patch and those who are reading "git log -p"
> > > later, and that is what I would want to see after a review exchange
> > > like this.
> > >
> > > Thanks.
> > Hi, Junio
> > I want to express my gratitude to you and every member for your time,
> >  guidance and patience and to my Outreachy mentors Patrick and Phillip.
> > It has been a great learning experience.  I can see the patch has been
> > integrated into seen.
> > I look forward to working on #leftoverbits projects to enhance my under=
standing
> > of the git codebase. Thank you very much once again.
>
> Note that a patch that has been merged into "seen" does not yet say that
> it will be part of the next release. "seen" is only an integration
> branch for topics which are currently in-flight on the mailing list and
> in the process of being reviewed. The intent is that we can catch any
> incompatibilities between two different in-flight patch series early.
>
> So declaring victory is a bit too early :) A better indicator is that
> the patch has been merged to "next". This is described in
> Documentation/MyFirstContribution.txt, section "After Review Approval",
> and more in-depth in Documentation/howto/maintain-git.txt.
>
> I think that your v2 isn't quite there yet. As Junio mentions, he'd like
> to see an updated commit message that includes your explanations why you
> have done certain conversions the way you did. The fact that some parts
> of the patch required discussion to arrive at a common understanding is
> a good telling factor that a summarized form of the discussion should
> likely be part of the commit message such that future readers of the
> patch will get the same context.
>
> Patrick

Hello Patrick,
Thank you very much for the clarification. Yes I was almost
celebrating already :).
I will write a detailed commit message and send an updated patch.
Thanks.
