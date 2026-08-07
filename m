Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDB613B58C
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 03:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786071642; cv=pass; b=Iq3o1qgFn3aBFYZlJMYI1WIpeHqvyfTm/xo9Q9905Anv3y29Ja5EG3eJnUOzS4C0kkRdRUQRdQIq3snaYoVCvnlXaHd5cvzaBNicF4yCGsz3+Xf5I1ssrCj1b8kmTlgh2GKhYYYJ8Fg+BwkmvqjIl6EGVklzAFvZLqC/k0pOIS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786071642; c=relaxed/simple;
	bh=iTRjtKBSYkKpyD5+tiR8FvGUShcZiyoPJZVugvm8NPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OFzmpVpKFpsqJL16vaVUNAtvUqx/8fFdQuI7F7mmrm2RIqTSjsaxYJtJetOVvE/a6eMez0zq4TrnRV1HHH5wCcdSe9jNbsdGZphNiQH6dWbc3jMONkS6y3T732vN568HY/78db2q4pJ7eXw+AzmSHjNFmsa6OktGdDqK98tDRbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f1BPo2fC; arc=pass smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1BPo2fC"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-495b98b4f6aso1055525b6e.2
        for <git@vger.kernel.org>; Thu, 06 Aug 2026 20:00:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786071640; cv=none;
        d=google.com; s=arc-20260327;
        b=NqU0aJb3Xjib/3VwOlwIXX9A7+UwB+1xWd7eiIUaHzfuk+rFRcGvY7TndofSZ6RvG+
         tmo7Jk0svmT94RYX1uMybmaAEABrBOH4IBoqDCA0i+DGeVq8IXbqsxXRLzFQLJkbI2lA
         lfaKNlELQk11jQEv1B2FIPAi+PZtEVx5v+Z/Mzi9+kk/RTk8w4CQGOeVyMzC4cYhpo50
         0lzOkKviB1l0viS5l/QuSKK4KMGHjh0RLb6mvh7KLW1V9S63cWQ24rSwReeBN0p+Lpqf
         ZvJ7yAWmL+nPsvJIGUAbooZ6SWcFP1N/kUplLysRrrbHJCx6C9rW6Tmou03qjbMq84W7
         i3RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iTRjtKBSYkKpyD5+tiR8FvGUShcZiyoPJZVugvm8NPk=;
        fh=PdGuLsJN9JVZy5BHY9bPXqzeWCeYFKwbJ2iGslXTO1Q=;
        b=V8CRAAz9kxpA1tNkrFrPIxi8D7mRQ3orbSNJe5ujI0Kiuo/iBkmBpAxwKPKAsffv65
         CntQSGVw2OXRlktUoHq14RkAsu+TvBnhZwyaF/t8fFP5JEtWkCrhFjYQVN4Ww1ZSQVl/
         UumwX+77d2d9HXzlxAUcscMuEeZ+HzgxVlhLlXwYLq3KYqHLPkeB3n7rzJr5c0yGvgnF
         c378qi/ezPF28wOUebSrhfAppHakt9KXnY7HGoy0p6/0h8lxwTgrvSfaouu9vOdimyr2
         g0nvSYOKKw4h9vGW8jqHb/HY/WalVewVpujvstfgrBHPmRDDWG8UD3NVx7YBOhSRbOuV
         qnFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786071640; x=1786676440; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iTRjtKBSYkKpyD5+tiR8FvGUShcZiyoPJZVugvm8NPk=;
        b=f1BPo2fCb/qBTvdD4WVyFUoLYVm6eG/KE8GKsyTtwV4r9xww+D/r6iWbuwXiziWtnk
         SE5KCLIJMfG10sbLVL0OXNoR+N/k9AufOmv/UJv+X/ZuY7f3rb6pC+xkEIDFWIj6RGm6
         Kwnd5MvjtlwS8INaLdMuZN/DKzADEWrw2looL7B6g+IAJX2qboD4QcOet5I/HWSDMqYT
         yPLdzcG2vc1EP/ti9Ll7mVkgtkay8GldSoKdUzDmrm1Gj2SWTKs6O0xoBwhynGS1xAnv
         aizJGLUOojeclOlGKCSTrq2d577GpR0KUhIxv1hsfAvsQsKn2Q0dvcjVZrbQXYxOmIOK
         A1/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786071640; x=1786676440;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iTRjtKBSYkKpyD5+tiR8FvGUShcZiyoPJZVugvm8NPk=;
        b=sjZn7roeNzLqzCGP7uG20IpHw2auWy+trSGmJ6D6HWY6qYENZnhDS1M+GBLVgvWzMp
         YI0EVrq16gEz7+lF4Qvjmu7HTQtQMO4ghdUFsg6BWzzBXWcVIlcKq7J9L6XAhrFKI3vU
         Xq3rXShOXepB6cYd0umIc0oA0R1mBeh14BLEciKJCnn24awHZVyAFHriBcgWlb5UntLg
         O9/Gc7fBdNqloJJ2w5dtugG1aG9b1YZviESzdtAhn23B3E7sZPVhKzw14PRpi7dTZsyp
         mhNllWfkR3fMctCOrUxM1YGNS7enO0lGxWkGzAp3iU1AqgRgc6n9w19YNjwuvMK2MeNC
         CO0Q==
X-Gm-Message-State: AOJu0YyKHq9jcrmXwlQ6YOVnkpEVIfI8iNNHWE1k4yFr7xPAUKmCzul9
	9CKJ7oly4lyRcgJmr5x1LsnMBrjCKLzsQOV3HioHTt4lMb+OJtuULdPOLb2/u4cQdOIVNDu2SRO
	7lFNmp8Pva83Qe81ZaMaPjmiex9rnAm4=
X-Gm-Gg: AR+sD12UtUa8FxLXCWQkDkvSTqevYRB5xunMNO3UvDmDyA8co1p+yQmD15CP/rzsT2R
	ek9cDnbKqpChbihMweBK1qjF/Fj+Oxx1Xl8qlAkPKPC3PTcvaZ5eRnqLeZTmkt3JZUS13h7wihr
	sCQjwQb9VfVmSBPQVtxaPFr80iidp5YBFJun1VxFbJSiHXo3VaiY4tRs0Gcf/+v58QzUUbzLR/j
	Vb331dNZYcZb6Nma+sWMUT/osnRFOsmOJwv/GmT7tARkmO/wWL6cjxvRlmICaIKzcu5+c7G72He
	mgjUweUq7QXFv/sl4MvTwcdT+lNn4W7QRbSlp0ydCIIcbVwqmrdb1ExBUMcw6o4JS8trc4CwBsh
	27E0Bx/VORzwXRjv7nQwcK1cEB6Vz0qx2tGMzsQxn5/mBnCKF2QA5dxghQx8sOwAszjGHywM0
X-Received: by 2002:a05:6808:1986:b0:4a3:fb6c:9adf with SMTP id
 5614622812f47-4afae067fe6mr12284419b6e.12.1786071640093; Thu, 06 Aug 2026
 20:00:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
 <pull.2149.v7.git.1786013982.gitgitgadget@gmail.com> <c1f303353caeb5be301ea24f4a042d695459061b.1786013982.git.gitgitgadget@gmail.com>
In-Reply-To: <c1f303353caeb5be301ea24f4a042d695459061b.1786013982.git.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 6 Aug 2026 20:00:28 -0700
X-Gm-Features: AUfX_mzdXmGHW6riyUhcuI0R3oGSkB9LtkD8Sfi01CBHFImZ-1-dzJ4wPlXqojI
Message-ID: <CABPp-BH2gfLOJdHJ3EqaRuCLkG=JNT=f_sO=7PTEgPqnppwYnA@mail.gmail.com>
Subject: Re: [PATCH v7 01/10] Documentation/technical: add paint-down-to-common
 doc
To: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Kristofer Karlsson <krka@spotify.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 4:04=E2=80=AFAM Kristofer Karlsson via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Kristofer Karlsson <krka@spotify.com>
>
> Add a technical document describing the paint_down_to_common()
> algorithm used for merge-base computation, covering the paint
> walk, generation number regions, and termination conditions.

This is a great doc providing an overview of how everything works.

> +With v1 commit-graphs (topological levels, no GDAT chunk),
> +generation numbers saturate at `GENERATION_NUMBER_V1_MAX`.
> +Saturated commits share the same generation value despite
> +different topological depths, which breaks ordering guarantees
> +in the same way as INFINITY. The early exit gates compare
> +against `GENERATION_NUMBER_V1_MAX` for v1 graphs and
> +`GENERATION_NUMBER_INFINITY` for v2 graphs, so that saturated
> +commits are treated as unordered.

Perfect, thanks for addressing this since the previous round.

> +Generation cutoff
> +~~~~~~~~~~~~~~~~~
> +Some callers (notably `remove_redundant()`) supply a `min_generation`
> +threshold equal to the minimum generation of the input commits.
> +These callers only need to determine reachability among the inputs,
> +not find deep merge bases, so the walk can safely terminate when it
> +dequeues a commit below this threshold.

This reads much better; thanks.

The rest looks the same as the last round that I already reviewed and
looks good.
