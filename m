Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A85F381B8
	for <git@vger.kernel.org>; Thu, 19 Sep 2024 20:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726779302; cv=none; b=cy5UCOJ8ShB5RhQcPulD/agN5IvvUSwcz8GA51W/v/AkL/C1xf/3v4n8eetwTyIamrDhzARrbEkoQvYmQdq9ckQiaAok1E9JKxDhJpSwzLehsoSk5OPfa0CWDvfW74gqQlbtMgcvq6mTrtqj9dHO5YE36Qp3KnbxnO7SC2nacAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726779302; c=relaxed/simple;
	bh=4IFQYgtNhkl6fDCcx4vQt9H+O/GiwUVEPN/pla7GTUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Seouie9egWhJn1HVy2sKN0yJme8eub3y+5Lx8tZLxw3EYl30thbIakRD4jKIIr5Kt0hRESFnMTIDWaw4z4qWKHu+jHLmDMQy8V817aA9L5te5uPwWvw7ar2c0j8E0gEzX4ARl/dIj7X/Ti8Sq0esKmp1L/jdoTnvHnPtAZf1m54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6c359669e62so1282096d6.2
        for <git@vger.kernel.org>; Thu, 19 Sep 2024 13:55:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726779299; x=1727384099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jBr7vSpLcTygiZlBKXJsHuvkv8optexyDAHxq5bsc8s=;
        b=LZOuHPp/WyDW9peeZ430Zjy8JrJwuK42aPmCIdr4KYWLDKlwo/XknYbwr4h4IePz76
         H3LMZM/Tem8rLDz6OsXHdJDY8KVQ7Y83AdHnqsVxCiOL6sAkRom2fq31bd06pyMXes0D
         oZNJQbWKZwEe4rgtDEVlfdMKPsz8fQ0e8i5OKiJPvGusHlGUFkPSiirPcH73Sk6xnwNv
         cZbqoR7U8VXM+l9BkHge7Jl1webNPemtJt+2FCk1NalGXENJdpcp7ahf8+GfR+y+oXwh
         cpqYcw9cZUioeRZP9UscVpw5D46tgf9ecJ0D3qxewZR1WXq4U0Rto4InxcdRrw9upoEB
         YpsA==
X-Forwarded-Encrypted: i=1; AJvYcCV0XIzvan9+Pds7yxTiJnidTmRBxu0DYMxMib9TEhS+ngSe6LjqtZv+Bj5WUI7un4VOaL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXYouNZENdjNxJKgvM4kuaSc3yzOjK278k3h2A3uXJvHJ4h1C8
	o+zl3rqt5664+LRIZ97giqhj5OYopZ2KacaQVuqnC0HK3epwlbmT5X5UZdjjMfzWqy9iH8gnucK
	mYbcLuaV4rJB83Zz9fk2KnZvOqHs=
X-Google-Smtp-Source: AGHT+IGTJ6v85MFdVOoz433fR2k4NEqlHzC9tGeb64jko2bafaRyPeH0H1beuOPt/5qGdyTZQV1lNaSdYZDn2DOrEzE=
X-Received: by 2002:a05:6214:481:b0:6c3:662f:8e09 with SMTP id
 6a1803df08f44-6c7bc83b3c2mr4155516d6.9.1726779299389; Thu, 19 Sep 2024
 13:54:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1794.git.1726770880.gitgitgadget@gmail.com>
 <ab9213d5-fb1b-482e-854b-4f5d4e82821a@app.fastmail.com> <xmqq34lv74us.fsf@gitster.g>
In-Reply-To: <xmqq34lv74us.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 19 Sep 2024 16:54:48 -0400
Message-ID: <CAPig+cTnB-aHLX8BhYk8sYgRF6S5XgsVmmJAji1oRRac+MLbtQ@mail.gmail.com>
Subject: Re: [PATCH 00/20] Fix typos
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Josh Soref <gitgitgadget@gmail.com>, 
	git@vger.kernel.org, Andrew Kreimer <algonell@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 19, 2024 at 4:42=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:
> > Maybe all of the commits could be combined into one commit with the
> > message =E2=80=9Ctreewide: fix typos=E2=80=9D.  But that wasn=E2=80=99t=
 asked for last time.[1]
> > So I dunno.
>
> It depends.  When done carefully to make sure that nothing textually
> conflicts with any topics in flight, a single "treewide" patch is
> slightly nicer.  If nothing conflicts with nothing else, either
> format is fine.  If something have nasty conflicts (e.g., a refactor
> moved the comment with typos far from the original location or even
> to a different file), individual patch form is easier to discard the
> ones that need to wait.
>
> I do not know which case this 20-patch collection falls into.

For what it's worth, I found the submission easier to review as
separate patches because it allowed me to review a small batch, do
something else for a bit, review another batch, do something else,
etc., without losing my place since I deleted the ones I had already
reviewed, so I knew that those remaining in my Inbox were still
pending review.
