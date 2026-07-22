Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDB23A6EF0
	for <git@vger.kernel.org>; Wed, 22 Jul 2026 15:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784734910; cv=pass; b=QzaeMC5aPN9yiWdEfpLdciTCIwYNI/63IrvM2hdltg9B29f2rd5Kswd6SPM+AKbqlAPCtYXaq2iUHedkm/0K2EdkWIhwqYRQWCQ3unXR5vRn55zfkuDNmmeni35Wou6jSPx2/9I72TmWdEdJOvKhpxoBE0j6WW5RBO+pSgIi4h4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784734910; c=relaxed/simple;
	bh=Ic8MACaZ5bMMlYbmy34P9hy1QmlQ5BpgsqyZxn37EQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F9JD5ucHh09CWvwjcS8TCWCfpzsY45fCZHnqe858Limp7+jJx5ocOUjnyTRgupmoZrCkqzPheroFOofFSJ2d0WR6Cmrpe8FsIi8Tqjf5fm5p1zRT7xuQuVJVL8WAJBBhii1ECwSODTMt7Vhdvx/SRINpeeG6qpFsoOslrkjG8EQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bKm2XKHA; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKm2XKHA"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-69c5f6f7a40so13828679a12.0
        for <git@vger.kernel.org>; Wed, 22 Jul 2026 08:41:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784734906; cv=none;
        d=google.com; s=arc-20260327;
        b=XQz0o+YVh6Veo4FIIeuanN8YEotDLUYqZTj9wvIkz2SEwcwUMbY5zgTDEiRaPCPHpW
         ZYztlq5f0U0rn3Q5e6rVU9us4I0hcyNo8mXLrr/EMFQyTutSbRBUnFVfC03FBWyce+T+
         wlGhkfXCVt7d4lCR0ADuiyRBW77UaD4YHtm8qXkH6hBGIfLWDdxR21Ejiby2UxdErwKw
         90xUtfbQbwk+9yG2IELg6wXVOWsyG5LYd/577OEKYZn1xqPJrQCL7ZpnieRJ73j+yoPz
         p6TStB1teqcG+3h6r9EM5FvXM1Gp+vKeJvanTJrarYqcki9OO+PAkWPI63Ow7NqTfWqB
         cwKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=agiHuthhtWqLFgW9aE1oMtsjwqATWEQ0KHKmHJxjYKU=;
        fh=pMy4AuGry5d90enpk5h0SzjWMIOTJf4lVnauHgGuKsM=;
        b=eamupA02QmdqPbu5d0SFDXdth4Z+FrGlCVfW/feC6+n9F2xVIL3dtjn5Ju9SIQV+/g
         SU0VofKGqO7jkGsfbgPyeepWA2A4x5KdHZcHjrnaWDPonM8QXHIIxFhxWGMjyy4ndcTn
         wk0jrpkTiReM9SRGeEdE/KYQE9kYcS9D1lsEbILVWSeoQT3Dw5nZK0s9UOfRzeSuuWQb
         Aq+9LSuKIm47kQ7D5qU/Ej+o8XrchgBAy8OYzuSgkBaweRKCQvHDADJjmz211wAA1Jjj
         BMOeQ3bnzKrxsCFK1/T7v2vqetPLb1ByrUz63aHswAE4eHL3OxUveetOxHxPCalBsRVz
         DAWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784734906; x=1785339706; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=agiHuthhtWqLFgW9aE1oMtsjwqATWEQ0KHKmHJxjYKU=;
        b=bKm2XKHAynBONWNED4ehE9t8Xt+mgYUcEf6YWF+I03YzDGRMOGZVwTdGBZrm716ii0
         TuflCLaHwEp8YBAUQ9jckKEvhWxM5QGuJdctF+VmyUDdx9BInnXiARHgsdY/mT/gaw/G
         VbkaSEkygSo/ft7thbY43sx+eZWX1yOud3GiBR8EntZG394QoPotpD2unrTvE6A6q7eI
         bzKuyscMh5S01CZfaWO8ZUcc7XftqwGAC38yI3gYpIAmMnA06yzOzgem+o+vWmSgx5+S
         rCPNXNnfk00lMjhpNWL9nuPICwhLXr5qOqTJGt1nOXAmJWXPcM8uKojNYZmsdPF0V7/g
         kIsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784734906; x=1785339706;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=agiHuthhtWqLFgW9aE1oMtsjwqATWEQ0KHKmHJxjYKU=;
        b=GrdxSLhuvB4qUdnN9q+jJ/xEdRAYvERCnlvOwQdjDxAA7dv/C2YqH8ZF3Gads73Ky1
         +jKnxuQ+/1AUDz+Wh7sq/rfpaNHKdpWy7dTi7sL/IWuN+mSFAbMehk0LypifF2n+wcfj
         pY4onH/S2/FHxQ6jcnYMzKH/2x8ElbU/yyAdqCWMZA92JklNVbG2ZxYs9aMl1KiTtumB
         bGMs1BfOTVnnmjEQf8md9uBE1D5e9NBocyX9UWHE0oX08V6rsiSmoVUQ9pvepKMf1XCs
         sGkYmfNLdYfsHqMP2IwXIbZ2IrSsftLwDuuTenpR+in4tbt9cU7r/Ejq+dNsYY7XgccV
         MRuA==
X-Forwarded-Encrypted: i=1; AHgh+RpMspHxBBtGRQ/rofImIDtnJ1OVJ1kor75FFnWYeMn4aJ+P53pZR2CvJlrFL08OwQukUbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOEBJHfLG9gZuKA0lZn9mlay8jdJ+fRb/LEeQrYubcNWlLz5/2
	gTYVit8AVeRS8ciakYWI6n1N+E9MDvrmGdCtdRzixvzNbHqiUbH8pvoFJ7EQM0y6Dy7dKlxDvWa
	Xhgn6+53NIgHUKN/7iG8aT8489vD8Oig=
X-Gm-Gg: AR+sD107YI3LWYhLMaM+ZXJrQen6SJF8+X7elgr02XWtxyAv6OQEPP+i+TSU5tuRAYY
	alFcwu80w7sTAuoosBRsQWCCLqwVnQiiE/f3yOQvTbZZ/hBbmOn6+P2OZ2sLB7uSBajdlUN7ENt
	uwE3iWPFMVYff5GFCJ8Yre6wDVfNUWu564ON9mOalfMO946TZ9Q8hmPOor54JO5R4itUh7TN7za
	5SVQKqxJagbV1MMiTCiElR+nAL80Kz7e5B5l0qb0tNxkRy5a2b+zpfg4Sdowg==
X-Received: by 2002:a05:6402:11cb:b0:697:ee9b:e9bc with SMTP id
 4fb4d7f45d1cf-69e652e2374mr10044922a12.26.1784734906396; Wed, 22 Jul 2026
 08:41:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2285.v19.git.git.1784053493.gitgitgadget@gmail.com>
 <pull.2285.v20.git.git.1784704238.gitgitgadget@gmail.com> <20976edc-fc9d-4d4d-8919-b599d336f9cc@gmail.com>
In-Reply-To: <20976edc-fc9d-4d4d-8919-b599d336f9cc@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Wed, 22 Jul 2026 17:41:06 +0200
X-Gm-Features: AUfX_mwYRADTh0u3mh02479y-Rec31WZDmESuc2jrnimyqk7DJS92MzKOsGG8ig
Message-ID: <CAHwyqnUmq1fMC9qEbX+7P7W=TL1d7HaXMDsj2QoLZ+nQqRKOAw@mail.gmail.com>
Subject: Re: [PATCH v20 0/7] branch: delete-merged
To: phillip.wood@dunelm.org.uk
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 3:39=E2=80=AFPM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> Hi Harald
>
> On 22/07/2026 08:10, Harald Nordgren via GitGitGadget wrote:
> > Delete branches that have already been merged on upstream.
> >
> > Changes in v20:
> >
> >   * Protect branches transitively required by a surviving local upstrea=
m
> >     stack. Traverse upstream chains once and defer delete-set mutation =
until
> >     traversal completes.
> >   * Make stacked-branch handling independent of ref iteration order and
> >     update the documentation accordingly.
> >   * Clarify variable names with regards to branch names (short) to redu=
ce
> >     confusion.
>
> I'm having a hard time reading the range diff due to the renaming of the
> members of "struct stacked_branch_data". Can you explain what has
> changed in the logic to protect branches that are upstreams of unmerged
> branches and why please? In particular why wasn't sufficient to stop
> removing the members of "spared" from "deletable" in
> spare_stacked_base() and remove them after refs_for_each_branch_ref()
> has returned instead.

Hmm. The main idea is to bite the bullet and actually traverse the
graph since it didn't seem possible to finish the job correctly in a
single pass anotherwise which I'm trying to demonstrate with

    test_expect_success '--delete-merged keeps the upstream chain of a
surviving branch' '

It becomes a bit like whack-a-mole when Junio asks me to clarify the
code and now you cannot review it because of that. I'm still not
friends with range-diff even after using it for some time, I agree
that the diff v19...v20 doesn't look very inviting.


Harald
