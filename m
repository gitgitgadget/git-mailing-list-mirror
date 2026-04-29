Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2553A3FCB13
	for <git@vger.kernel.org>; Wed, 29 Apr 2026 13:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777468573; cv=pass; b=Krvu3JsSm/9Gt6U0rvpFXH60qjMl/gB5ZOGMwJOgE2u7oik4mZ8EB/+U8dupQ4OyWJOBVx4l5dAPNcOPRIpIrTl9wQHknKzPNBowxwH5tFa/kK1RVU8HyjYNWFNYprFN70TzoT+QPIzrVwuOcHb5dLtAtJ08ZkOw80Wv78AMXDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777468573; c=relaxed/simple;
	bh=9EOlxdnSQ1rl3cnXAi7Q3Vkps5/9ihxG1hXqlNtCMvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VQV3v/XibYLjy9mT8SAF++GV7OhGAexzpCJF3eVhi7T21Fn9nmZ+naTTx8zplOA8M5vL64yHM45LrPuyto/CbVv2DcCdpCiOFf/obEivqFP8dBXMZcrHLj+7nqnoWta+rdKg6ctpr7tWA7X8dlWKwhjg44Wh90Ssu+ptsY96Oac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NJW9lNGW; arc=pass smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJW9lNGW"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82f68b3aaf7so4764056b3a.0
        for <git@vger.kernel.org>; Wed, 29 Apr 2026 06:16:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777468571; cv=none;
        d=google.com; s=arc-20240605;
        b=ArBdwWIzZlAht0CYuEWFBKrt0r9LJBhvNWyIDt7uUGaNxMMw26zEPRtOY58mbtNvIV
         3wQiYqEbbxMfL83CoYg+XFRU4bazmkrI3ADP2FddmdvyWOfTl0DctV0ODdTS5SUj01C5
         owmOhEDnt6zewlYZbMQSP6Tx5QumsEKBF6mNBLnTQQp+JRJy5uJoAYu/JjSvZCu0L2nF
         Rwcxx0Y85pYVgA+oCArZatL60gaGUgRTC07e7F1mUg2nSF3oSM8FmTjZC51QuDaJq9mE
         8NDU770gPC+rRUJo0piPWksLT7gStKu7lWvPFOxtlJnuOtvFgnE0OtbFQy597pmtkazQ
         Am1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nxRkjRZhA/zuV/Bdvn9jNtDwKyYxr06YO4qkDkBXx50=;
        fh=enyPv1IQS3g4+XHp2R5Lw+gSoxZHn/V0qlv9lMHAKm8=;
        b=KSMZ6bRUTUdM8b3gRRKkO4DIhBQHoidNTFdvZ+u1S96F+vqxAo8FBX6Z6sksy0zvNl
         UtUCIZv4WlobY/GJ2/YSrST8uP/ETZqF+ILmprG9O7sVJvVD5VuznAQQbw79SBkB5mXa
         wB3rCxH16FnzzvQj0qzEYG5UlePQtsR3MjhVAKsna9ZYaCOmIgEpqWei4Gl8EE/mbmZ5
         uivw4ia4BGsT7nPcnqUkfBWEhYO6rPqPLoujh/l+o75JeKTux5/SpvFXFQmqF49XPObY
         kWd3hHdMw9AOrpsE1idgHAIQ4bTBNBq2bjUffVVq+r6jD3Fn3ufenLOyRBnp1ekyuKkb
         kU4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777468571; x=1778073371; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nxRkjRZhA/zuV/Bdvn9jNtDwKyYxr06YO4qkDkBXx50=;
        b=NJW9lNGW6E6njjWURVnWv2D0CR6Y6TziFuw4nz8al1HDDN8cjYvCk/Vt3v/Laf/nT7
         gZvwYY4Vllq3g6ehVrB3vYJXaymbuzXnfDCP/VOwMrVvwjNjIygXWuEkhizVnsXyzMqj
         d9WIVu43+KIXTZ/TO3l0v8V9iloZYMpgkik7G5z2RHpoPSwY7aKyVCaD7L7hNoxpzUKj
         ysZuT1jb23YDLzfnq/YxEQ7sVFdO1t4wcPh4QvzRU+bwHfxjYQgxsKNfHOTEmR3TAf92
         m/fsrnQZoZczBiqp16s62TscvYwT5/D4JjvyBj3WwGCW3IApwhCq+PidNiI5p8IVE9e2
         0jRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777468571; x=1778073371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nxRkjRZhA/zuV/Bdvn9jNtDwKyYxr06YO4qkDkBXx50=;
        b=Jifhsngd9z5wgZNPuehZNGfugs5BoLDsCMlDSxAxJWvyBeCKQjOF4liqldDRcbqJzo
         qFZbuRjiRKwKJ1MKvURfl20z2rtBzSSbW/h1DuTsgDXfoVtkHA5l26TL3SfpKZI9Smxa
         wsBaKtFydgksuxzrRFXyMs/rMIESgzRnEFPGAMnVyjnvqbP7gYRDqYYSmORVKmQq7qGz
         8J3chEAWPhlsm0LNBkl1c3dcx9OYQ4kZl9lVMGi3S07tHdocOSRBijmV1Pyk21T6g6sz
         0sU4FZZuA1nqqC03n7bmm6JNS7kn/WYDF09HPRM2WTNUz0uTUrb3TAt+3I00cVNpxyRc
         6ryQ==
X-Gm-Message-State: AOJu0YwBiyvWSjtkHUP/tOgsRG1/NEtEXH5XH7aFyec/frHFS4ZTCTU2
	dRbsBxEhalHKMv43ND5XxddTbpRrJ9F/Xo8dMzmDmsnYuL3dX/D0gQ2aDzuNXsJ9YdpKXGG7Vdr
	K81mbg6FYSyXLAjmWQuq/YPqQB1izjoQ=
X-Gm-Gg: AeBDieuVAGFsVWh2/YgHVq5ZKifhLzYDt4aL6m1U/x8l7Vf8JRHTWBhuuv0pSv49j2l
	t1SeMzi+FFHOhFgwXNN16dtmFInorliMRp/iaivN8TOa/+0M+UA1fixKEVpaQO04baByTClLmFC
	1SxquyGQpZI7fu/jQgrHRUSnroZ9i0hM6ik8KcbCcq7DEy08K5CFL8QHy9kZ805FeEpS614LaZH
	axp9IFrJ0DG/NdXmT4r4Kfk+jIZARddh7XkrF3YndkIZq1VJGJbOQD0egj/dag4jrmaB2vDQc+H
	i655xSUU6fR9CsNZoBj/wW1w8hYxyqsGm4CffpbdMyoEqruh9KZqlp6i8wnLK7ilsB8wAaGJdea
	/Eg1w1c4qWgwHHFNsD/8qQ+RfqGjC5n4E2zCX
X-Received: by 2002:a05:6a00:6c83:b0:82c:ae0e:dea with SMTP id
 d2e1a72fcca58-834ddb9f511mr7496056b3a.32.1777468571385; Wed, 29 Apr 2026
 06:16:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANOh7gEEw+6146NN3JV8EYxQarj0KkyA7r3RZ6v-DxeqQZLrCA@mail.gmail.com>
In-Reply-To: <CANOh7gEEw+6146NN3JV8EYxQarj0KkyA7r3RZ6v-DxeqQZLrCA@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Wed, 29 Apr 2026 09:16:00 -0400
X-Gm-Features: AVHnY4LWtjaMEtUNg_RuFRTN91OrBi2pIvOXYrMqpc-72U--Nr6YETSdpCQfUDw
Message-ID: <CALnO6CBzd0coeyJ9B+EkGWsSNEVTdVLvcVmEraGNxnUm5wXy=g@mail.gmail.com>
Subject: Re: [Bug] fetch --deepen truncates history in v2.54.0
To: Owen Stephens <owen@owenstephens.co.uk>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2026 at 7:27=E2=80=AFAM Owen Stephens <owen@owenstephens.co=
.uk> wrote:
>
> > What did you do before the bug happened? (Steps to reproduce your issue=
)
>
> Repeatedy called `git fetch --deepen 2` inside a shallow repo that was a
> file:// clone of another repo. Once all commits had been fetched, a subse=
quent
> `fetch --deepen` appears to "reset" the repo back to being shallow with a=
 depth
> of 2. A reproduction script is included below. This issue appears to have=
 been
> introduced in v2.54.0.
>
> > What did you expect to happen? (Expected behavior)
>
> I expected `git fetch --deepen` in a non-shallow repo with no upstream co=
mmits
> to be a no-op.

Here's the relevant part of git-fetch(1):

       --depth=3D<depth>
           Limit fetching to the specified number of commits from the tip o=
f
           each remote branch history. If fetching to a shallow repository
           created by git clone with --depth=3D<depth> option (see git-clon=
e(1)),
           deepen or shorten the history to the specified number of commits=
.
           Tags for the deepened commits are not fetched.

       --deepen=3D<depth>
           Similar to --depth, except it specifies the number of commits fr=
om
           the current shallow boundary instead of from the tip of each rem=
ote
           branch history.

I can see how one might read this as implying that when fetching in a
non-shallow repository, there's no effect, but I don't think the text
explicitly says that. In fact, the first sentence under "--depth"
(which is of course relevant for "--deepen") is unconditional.

So I'm not sure it should be a no-op.

That said, it is possible the behavior changed between 2.53 and 2.54?
I haven't tried to reproduce or bisect yet.

Best,
D. Ben Knoble
