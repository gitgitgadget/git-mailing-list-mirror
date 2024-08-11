Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310811757E
	for <git@vger.kernel.org>; Sun, 11 Aug 2024 23:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723419225; cv=none; b=sWJqjJpBSzjVo6+GIAVbyh7kCBPCZYF1QmhgKE+L2d2CDc+CjVejJoCzl44MwHDNrEzTtOcEqHSQUwU4JKNRzib3E3Fcjtf0+k0nlVA18Y1GCNBLuR/ZCdg6oqIqhrRhtp+irrh/htZ0s/PchPGz3BEO2pdOyFTCHwn1y55Zkh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723419225; c=relaxed/simple;
	bh=TIDayK4ZqPQn3cFZSifhIdt4MA4JWlT6vIGw6kptkno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a64/MkO5XHNfCobt8LQuUwtos72VPUyu5peJ7ivUCrHgYy7UM0twnStx8cvgTzQwGLzA1iUHrf3rzJIY/QBfaUIAHZ/9IVtU5tljHg/NeyRGqTrAosUmCuKNpmg9bkXshKp6DBJFXFm5q8Uoqx3NwtgBB4dkJsvocwK1aKJPs5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6b79c969329so21313296d6.0
        for <git@vger.kernel.org>; Sun, 11 Aug 2024 16:33:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723419222; x=1724024022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1YYWM3ltPFAtDXQLLwqdzkY83AQWq5NdwiAkzxGyh5s=;
        b=vMc+4zV9dVEkNWX+unwm49SNuPWPTmzWa3eQF/a/NppQ/pxTquUR6bfsmAK716/UUW
         oFpR3XP064643riHoAzDqYsyNBirphpE6aVHaFIvOlOMhN741xEaqvKlLuGOc7xgLNCQ
         sr+bbMqFUTRkf+jmpoTtjZS/LQ3JrOlPMqLVZe347kKFWVS0PJf6K2hgVp7DeZAqNzE8
         LtJCinmr95voRZKzbX3T9rvyRe6S+JmQtaoDACY3SuSL6rmIJ11EJRj1vd17gHS8jxY1
         /2zCMYm1E5pk9j5mEtUNqiK6pUfoHuzr1JbvYuKYrKUeY26p9gn4b3/fOW+PVkdQByEf
         vLbg==
X-Forwarded-Encrypted: i=1; AJvYcCWCrlRPOUjfp5bzSXw03RbtGBz9pTpbCkUxdvzsPfoKsWLnxgfjijFWJBnEqZdxJEJIzu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzlIg5WYERNkrnkXipvflNmh6AP2zCnPmwEN+7i+KtimFS470g
	GZmyWiRnOIGgXi971hec2xjaHqZVNdzwf5HUUnnYazo6NDOadeVQiIy2LLhQETme5vpr4h0QhO2
	1DTgD01UcxI6qsZSggiEBy8Nv8vY=
X-Google-Smtp-Source: AGHT+IEwFDR5KqHnawuUqa3PO3Z4KMzIHsvCujLAkJyMq/+X/6fGEDFq8y1eeYEZ5QWtLj92k85q9OYX8FjYLQ8JEIw=
X-Received: by 2002:a05:6214:3990:b0:6b7:b197:c825 with SMTP id
 6a1803df08f44-6bd78d3be11mr93452226d6.14.1723419222028; Sun, 11 Aug 2024
 16:33:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1723054623.git.steadmon@google.com> <cover.1723242556.git.steadmon@google.com>
 <Zrdn6QcnfmZhyEqJ@zx2c4.com> <6398d60387a6607398e4b8731363572e@manjaro.org>
 <CAPig+cSotr8CNZLy4xnm4qyJsuQsxjzsYMVU5sf3eeoEiE8aXg@mail.gmail.com> <ee460e193b567b73e789ee77579f41c4@manjaro.org>
In-Reply-To: <ee460e193b567b73e789ee77579f41c4@manjaro.org>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 11 Aug 2024 19:33:30 -0400
Message-ID: <CAPig+cQnLkXdfokGBFdkkrZ3_nWrYGj3XyMRJ+0h5zrC5Kw0bw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Introduce cgit-rs, a Rust wrapper around libgit.a
To: Dragan Simic <dsimic@manjaro.org>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, Josh Steadmon <steadmon@google.com>, git@vger.kernel.org, 
	calvinwan@google.com, spectral@google.com, emilyshaffer@google.com, 
	emrass@google.com, rsbecker@nexbridge.com, gitster@pobox.com, mh@glandium.org, 
	sandals@crustytoothpaste.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 11, 2024 at 7:23=E2=80=AFPM Dragan Simic <dsimic@manjaro.org> w=
rote:
> On 2024-08-12 01:03, Eric Sunshine wrote:
> > Josh addressed this point in the v2 cover letter by saying:
> >
> >     Known NEEDSWORK:
> >     ...
> >     * Bikeshed on the name
>
> But didn't Junio already say that the v2 of this series will be merged
> as-is? [1]  That's what actually made me surprised and confused.
>
> [1] https://lore.kernel.org/git/xmqqfrrd9slb.fsf@gitster.g/

That only means that Junio placed the topic in his "seen" branch,
however, no promises about ultimate acceptance are attached to topics
in that branch. Quoting from Junio's "What's Cooking" emails (such as
[*]):

    Commits prefixed with '-' are only in 'seen', and aren't
    considered "accepted" at all and may be annotated with an URL to a
    message that raises issues but they are no means exhaustive.  A
    topic without enough support may be discarded after a long period
    of no activity (of course they can be resubmit when new interests
    arise).

[*]: https://lore.kernel.org/git/xmqqo762frkz.fsf@gitster.g/
