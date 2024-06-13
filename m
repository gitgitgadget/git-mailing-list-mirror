Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605A713541B
	for <git@vger.kernel.org>; Thu, 13 Jun 2024 20:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718311818; cv=none; b=DGYdbbvy2fSoVSfpST9lsiY2QmQT/JAU//8sfPqPIMk1px3VUt+8Xr9ywM1SHzY1hYRdQTwMlqI0K+AKjErvD0u2lJrSi6RHJM5jOtKuo/3HS1SiQgUYbEoBKxH0XjIAPjkOQNSHkeWuxBdLvVbismiimcVUmiucvqoHrdM+i/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718311818; c=relaxed/simple;
	bh=ekiyZW9YjyiYTB4kWIvIbnhgF5705D8R5kmDNQ3bTaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Wuni7aVJMvWlXM2AqCd+pckXtshxHfaK4JIlslos+AlaCf5/AoAjqiQzuO2KQzkfEtf426uT1l0zRX0lks+mG2/ha5TQu/H1e4i5jXVL33+w8XXBgyaTALMBMpOODk5HmO0iWZWS5QhfjBQ6Q24R7Ldtvuvah1i0nFU6NOGLxtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m2DyUZ++; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2DyUZ++"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7eb7bf1357cso59710339f.1
        for <git@vger.kernel.org>; Thu, 13 Jun 2024 13:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718311816; x=1718916616; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YsS+E4/gfX1S7GSS+ck9SWLNfNKvFIWAG+yYCH9WM80=;
        b=m2DyUZ++tvINzyGd9TL0Lp0321WIsPCewZfiNgUycE9MoGu0LCWbBAjRfVM8LGEv43
         WkB0XrbRa4tlWe+UXnW3oxZmjSMS6EBq4XYK/Mj4Fyg360V2SmkjZKt57Lvbh2hybpJv
         6PPqseStz8sh8pj4pkepZhbp80Qjs/T1lcCF1LivgM+WJX1loenF9hOE72Vv5oxgDpjF
         52w2LfWa0zBjj+RO6a2eWmVb96gQf/2qs378o5phLin+1wQBLT2hPPUkrUZGTIH45Vap
         HIZyHT8VO82iEbio64kYmrvqkeEf7L+VPFHZfVqHpv4U58qYZ/xLrIPFqw4rzCIG7qKb
         1TvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718311816; x=1718916616;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YsS+E4/gfX1S7GSS+ck9SWLNfNKvFIWAG+yYCH9WM80=;
        b=sdyinzwMFenjE5WgCzyugkdWTVg0MKVL/R/kMcyFoaPZ4W4ZK3JqGIjr3UCb9cRm/9
         V+7f+k1ixVBWja54IXxNdcPwR9wGUmcDMmlIk5H3JNjbP2WHjQwCrzDRje5o6wePIZUC
         n+EfWVyCui10CvzfMtMhH6Sz9H26jImuhQqDiMdBATDCqDw1+uH+HeWckxS8FqyAve6U
         aCflY3qj0iu+QpUMArHO6a6x0ohC1VFqGFZVILVDsWHkHI98g+o2qSwkVdQATfdOf8sD
         BYbaUh60Bgi1kyJX6+fjjsjALtSiiQJFmkslQLBrVFkBFhqQsRlpapFkhAcySJ/PPJkw
         dKFA==
X-Forwarded-Encrypted: i=1; AJvYcCWDmckaDt9NdSbs6HvMbll+PiW3VlH8vItCWBRUlOd3Z3B9VBAUUvlcho5/PuIKj3YFJDPg814/VOP13t4JB/vvDzdR
X-Gm-Message-State: AOJu0YyKCe1olkZUcEQqvXb2Mze0HZ9OhLurchhg8iTfcbMFWGz0ZlmP
	Dpq+Fg8NPUZUrMuPhmlFrbMNcx3A+1+7RIxEL+lWBBGo8YhaSAjR+UWvgj7ZZ8zackw2+2z5lIF
	AhndqU3/0YzdLEfTCcFkgn/deyDA=
X-Google-Smtp-Source: AGHT+IE+0i7Q1XZF1ynwLEJOOnmbD5pBaiM+cKmd7+Czb4Mq28NTtLmv+QvE81IkPsgEcVrXDK0EkV2a8iPUco4V02E=
X-Received: by 2002:a05:6602:1647:b0:7eb:7bc9:7fc2 with SMTP id
 ca18e2360f4ac-7ebeb63e1a5mr65892639f.20.1718311816358; Thu, 13 Jun 2024
 13:50:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <75F8BD12-7743-4863-B4C5-049FDEC4645E@gearset.com>
 <ZhBZOY1aEFW4YoD8@tapette.crustytoothpaste.net> <CABPp-BEogmpG7pYmC84WhQCy0tP97cV8BZ8epPeo4fzmRjU5Rg@mail.gmail.com>
In-Reply-To: <CABPp-BEogmpG7pYmC84WhQCy0tP97cV8BZ8epPeo4fzmRjU5Rg@mail.gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 13 Jun 2024 13:50:04 -0700
Message-ID: <CABPp-BFrcNLA-714gw+JogtAQLhmcs_sLnkkaBiGERF+riwZLQ@mail.gmail.com>
Subject: Re: Unexpected git merge exit code when killing merge driver during
 ancestor merge
To: "brian m. carlson" <sandals@crustytoothpaste.net>, Matt Cree <matt.cree@gearset.com>, 
	git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 10:03=E2=80=AFPM Elijah Newren <newren@gmail.com> wr=
ote:
>
> On Fri, Apr 5, 2024 at 1:04=E2=80=AFPM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> >
> > On 2024-04-04 at 16:16:05, Matt Cree wrote:
> > > Hello all. I have observed some strange behaviour when exiting a cust=
om merge driver that I was wondering if there=E2=80=99s any reason for =E2=
=80=94 I think it may be a bug but I=E2=80=99ll leave that to you to decide=
.
> > >
[...]
> > This is definitely a bug because we triggered an assertion.  The
> > assertion asserts that that case will never happen, so if it does, we'v=
e
> > made a mistake in our code.
[...]
> > I've CC'd Elijah Newren, who's the author of merge-ort and who wrote th=
e
> > code.  I'm not familiar at all with merge-ort, so I can't speak to what
> > might be going wrong here.
>
> brian: Thanks for tagging me and expounding on the testcase.
> Matt: sorry for taking so long to respond.
>
> This is just a quick note to say I'm aware of the bug and will respond
> (I think there might be a simple fix here), but for various reasons
> it's going to be a couple more weeks.

Again, sorry for the delay.  For those reading through the archives, I
posted a fix to this and a few other issues found while investigating
this problem over here:
https://lore.kernel.org/git/pull.1748.git.1718310307.gitgitgadget@gmail.com=
/
