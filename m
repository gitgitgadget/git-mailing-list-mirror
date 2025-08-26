Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A4011713
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 15:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756220693; cv=none; b=qSKMnkiR7erbixtLJRqbzlXslAnw7QEt1R+ZYk9II5yYqiaTDRIKvTrYBr6dEiQ0bVzEB+iP/b4LbZCT0UVvY3Gjt0nkuLZLiCGraCjZCji7euY7ETTfnUku0WISMHz9CknE3KD5lP4gw9tbM3BESl4GtPNstFxfJwKvvihthkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756220693; c=relaxed/simple;
	bh=Me4R4qOl7Cm0i0lrUVTRZ//IDRF61TSurg7pjY4XJpA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z5gysZAxqEf8l0qWg0nGR8xKDdNhLYwYZIQNgtdHfCrxK4ZZ2Ubj0LQ9m+h8uDDfUBPZQ6BvQqeaq04P/RV0uGteQDs1GOYPG2XPNmE+N4rmzgPVHhJfP8VI1Iu06aheUEQhcbfo+YDiL3yhg3kcoFMVKtUY3KGcaPAg1FIxJuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UGOjh1GT; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UGOjh1GT"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3ea779929b0so20957865ab.1
        for <git@vger.kernel.org>; Tue, 26 Aug 2025 08:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756220691; x=1756825491; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t9uvRRubBsT5fYYEACOZKdurYEH55gwfAkBUqeQPH7s=;
        b=UGOjh1GTd60y1Uh9VUzJ0QzupVWqVWnvSCRXeBEVXolWEaZBKZg+rw3mvbcK4tAy8x
         F6SEXW4Pu1cuSg2BbnfLm4StGMlsNP1Ju6vAuKCi9X79Gg2YC72xVIhNvEb9Chg1/Y/n
         0K+4pMtQAhR5+uTAWmjiV7Cr5a7huYwcaqcIsO4vSw8I6L4XPMBNbLQYMJeJWlnFJaUm
         6tGHGVnlECOOFuJiOUqf7bdNNZYqMnUw4SpoqU5QQBLP+g2h3Tti/sNY462fjidm0poW
         6ortb1UaJ5c9OUYHpdQFZTjc9OemXix0LjehwEjILQgvVqUfipteJapiQI1/eu8pYhIC
         wjSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756220691; x=1756825491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t9uvRRubBsT5fYYEACOZKdurYEH55gwfAkBUqeQPH7s=;
        b=PYeH8aw0LONKlHPvKPI2sPsqFTgqf/5I9wmbPuvHrXiMF+dfJhpurRRzZkcFk0gBkL
         3bWWtIX6FK/0Oq/JgGU70GkB+UgwyyMBsAxZFGlABatwUCvuJZkMSaecRh7xMNeD/6Yi
         UlYjEjuFImPymmmOW32tC/qp5C6+8fvJkMy6F4gwt/ZRWj53WSxBYHZZvA+8Rpsx87n7
         HztVfg85ktZn23fvRSq/WehwCW8z/ehnhgPsxw++sSyOJ4ptN04lcp1skMjAstuMFBbY
         YabgfqSc5f7j6lF68rrXqF8ILtr5tWlVWr9gGxyEye/Rh8+hQUeP4E947mPl0U0Vodki
         FxhA==
X-Gm-Message-State: AOJu0Yz5rXiD5WLbxqPoN4WmLXqt16UCcRj6Af/+ZGR10wyCu+kYvTGK
	X5edMaCv8WZyqwoe0BVfKe7f63RGoXlr4jeptCkjQHmzADmogHHG7RR9g4jIE9sKj+R8jgfuRXz
	Vs2zWGrftLEyq1aUTRPNmQKcgeFgHWPM=
X-Gm-Gg: ASbGncvy4SsPBdSnE8RvWM0T5nsdnixtTv5UEGXSyOVQjAsq21x1qfU1vzMYg2JTEjr
	ETQDcfW1nvPzmmpD1m4bqvdDmDuMle2sXidxghymeNNiw7WefFEOAN5w4jttiGnC+PxUm5T0ENX
	k4aT/ls6TXb42sLqOlyXIMKmNyKr7U1bf2CIsT16WXCD9dBhnmQbXoVtP+KwPECYojtkp7ngbX3
	74ruBh3vzJscIJOUvOV3weUnRIWbvzWZ23Hz+CLHC0cXdvI028=
X-Google-Smtp-Source: AGHT+IEQBHqWmwAAsgJ/DGYxmFI4gPtsB3zLP4UIuMx/IHg2Ns76PoLp3my/B7H9gFTHEdpA2mLNibrqSodNXd5FSRg=
X-Received: by 2002:a05:6e02:1b06:b0:3ef:4b5e:66c2 with SMTP id
 e9e14a558f8ab-3ef4b5e6939mr15942455ab.16.1756220690585; Tue, 26 Aug 2025
 08:04:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqsehivqxi.fsf@gitster.g>
In-Reply-To: <xmqqsehivqxi.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 26 Aug 2025 08:04:39 -0700
X-Gm-Features: Ac12FXzkCuQXnhYgTPwsMthSnNxfAu75mYIUMxWDy_VrTq9NHZlXJWfd1iIo-nI
Message-ID: <CABPp-BFuKUH0NKR_9Qb7Q8Cb++o2EVzqYK8WyvQ_PG5_JFyZ0w@mail.gmail.com>
Subject: Re: What's cooking in git.git (Aug 2025, #10; Fri, 22)
To: Junio C Hamano <gitster@pobox.com>, Derrick Stolee <stolee@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 5:10=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> * ds/sparse-checkout-clean (2025-07-16) 9 commits
>  - sparse-checkout: make 'clean' clear more files
>  - t: expand tests around sparse merges and clean
>  - sparse-index: point users to new 'clean' action
>  - sparse-checkout: add --verbose option to 'clean'
>  - dir: add generic "walk all files" helper
>  - sparse-checkout: match some 'clean' behavior
>  - sparse-checkout: add basics of 'clean' command
>  - sparse-checkout: remove use of the_repository
>  - Merge branch 'ac/deglobal-sparse-variables' into ds/sparse-checkout-cl=
ean
>  (this branch uses ac/deglobal-sparse-variables.)
>
>  "git sparse-checkout" subcommand learned a new "clean" action to
>  prune otherwise unused working-tree files that are outside the
>  areas of interest.
>
>  Needs to wait for the base topic to solidify.
>  source: <pull.1941.v2.git.1752716054.gitgitgadget@gmail.com>

Maybe also mark as expecting a reroll?  (cf.
CABPp-BFzMLGJwz4QqYtvw3zRYgmC=3DMb8T8GCOsrLZqT2z+8H7A@mail.gmail.com and
CABPp-BHLcy-A4yLR8gP1Sjt_EKQ4K08kPyb7G6yifdZj+0MJNg@mail.gmail.com)
