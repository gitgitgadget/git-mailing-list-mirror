Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC5F17A300
	for <git@vger.kernel.org>; Sat,  9 May 2026 15:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778339613; cv=pass; b=a5ieEU5OBvMrXHOVCSc9pID1Bklxf+ifCCZ/2k0273e1RJabmfO1roK4PcScaLCPhJjo8+ozaymyJ5H9VztfS6YXMCKoDwdzw/E/6RqyvAlPCtzEjf+syBtqJx53fVLqtIaBz5H0HH20an8kow2YXMajnsVLHpG+NVtXAfxoWOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778339613; c=relaxed/simple;
	bh=aMhv2wTtMmr3Lqk7FmkU/SVuTkRkGbQ7vjZfBflSFas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qlDzXxDyePDiANau6P47Sw+OBx6doFSzMQPY5Gaw5Ll2ha4I0LXIfiepTvzy+/k9h8gqdnd4PMK8iIVgaJ4t5FSLsz+f8GrEkD9TmM3Gjq504x3DhQTCsHeFayQsige8ytLRaV4h16m0YW4of/2ePzAU3tvEJ4Zu0DzzBWYh/cU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nhExtsNa; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhExtsNa"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-bba0dde4f43so442194966b.3
        for <git@vger.kernel.org>; Sat, 09 May 2026 08:13:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778339610; cv=none;
        d=google.com; s=arc-20240605;
        b=WUL4N/mkmAxEKp8JQ5U9/EP5cWQAoCPWwJd3vUFRjTT8wW1x1XuyrHRXAelQ1gOcy+
         7QT330Q71flGnq/RciyXR+mcN1FRqYbdD8OrJCcbGdsXG7r95Nj+3IEgt1V979i6pXzy
         EGz+WyifPRfnkS+jdx/LiMmhQNWAUjOszlpqDozIxF6kvTc6LKJT0bGKSUvlrCPzOeIe
         me8GOC6nlueEwOXhqGHvqvz3o+PmavK8ErZY6dFZt2H6KN5mDOAFeiOcgIgxd6bt/P7z
         CvDNlLjJqAqA+OTF3FP+mik9NELFv1RGoLUCa0Q6DjgcOEZm0LI3n4q5v5fRG8CL9rBQ
         8dow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bgcM8h8ZVytz3mUkdxQkBqfbzbmBi1/jJCCSfgB+UsA=;
        fh=WNtm0f3kt99EmSIaRPqNuyoKG6NRdmY9XDHaLIXJ+lQ=;
        b=hExI859AHICaV2nw3nPNa60lyo0zflxVic5LIkoLO6MIm9jViStNF2kaDdh2+IUrEK
         JDgA3tUqd9iQyn40MzxxTeFUvEjX10e+QmABhqJVkswQJM+wHYptkTMikymotPlCfetk
         PZc3o2HrVhFFK6YkLBDx+u93FJ8eABqSGBovl2tUZSk1AQOwO3lpaFOlAPUcbXd835Wd
         CuGev9W592CatZ26T0cPlHEHpsW2/WW3LmuPtkso27uffbx4pe8IaiNIfZDdLzej7v47
         jIwKEjxGq4JZo38YmQ1eHXlTJ5/aoxATmkbloNj42+XZ5HhfKvMFXRRKv1IXZRLysZER
         hOcA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778339610; x=1778944410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bgcM8h8ZVytz3mUkdxQkBqfbzbmBi1/jJCCSfgB+UsA=;
        b=nhExtsNa7NQrD2BHN0RTMjAPq8q0PoV+P5UGemdTVSfd61J5Jbk/8jFVmDzI8w/Om2
         FNPtx2+cgInvsaDj9JJJF7WnbcaAKtx3AYmal4R0nPQCeGOV3IdfqIYNVSSMXwmK/owD
         NT266AMsA94KYfPdApNg7B3oWk+sTXYZNGDeBm+dVufpCSKDViCeg2BtDuB0CvfJPO2Q
         kGvJFSEMs/pXFoHgHsX9dtZL2HqhtxXGURyyaMfwZHO96KdIIBFtrUtFNmWN8Jl4d26m
         tJ+zaIbggsTE3EQoSnmPZan5YQj2Kr7j+pTjDTgz8tS7Prq/PKbI2G5y906UAIE6ZN6V
         AEQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778339610; x=1778944410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bgcM8h8ZVytz3mUkdxQkBqfbzbmBi1/jJCCSfgB+UsA=;
        b=ZwNZq7i4fnMfZn7oqc/EUk7tLCswWqzi0xRSvyG3i4sJOLRMgyPjH65hCwJ1GZhOja
         +2ErZmHgSBRxlM4rrvpehoQAbPY8ORGLcjdkeA628OxDBokjm5VOHASFmIaqV4y328fm
         gaMSmJjGxjPyq85SiNeQuaybnX6QubhKLV8OQk6OyfL0rAfmY5AbbyhQRibMNn8jOrRs
         i4UozVKCYnTo3mzLel4Ta1STrB/OjgNzkmdjO9gDJ/M8W66OatH3lV24fm4WwuBqnzDl
         /t2vaPS+k8XlRg0gSBF2I5zdHfSpQAkzHzTsLpO4mHeIHU9YtCHs0pc+fJKxEYGT3xNG
         4hzA==
X-Forwarded-Encrypted: i=1; AFNElJ+8QcVVvW2IEOTVA1yfLUPSqPblxkPYYEdL5fP+cYPbwar8mQSHR8nKFxSJaNkoT/Tpgh8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNZ3EkwCeMWTPN/exMKylhHpsWVVzW7YhQxwjp/b/BQuAd+0qs
	nzWDGN8yvb/9uCAZZbnuwvegVdkv1X3r78tcbx3KPF6AneD4sKFmFD3V+eGYE6GwGt1XKFkAw7M
	W9ZlQC7X+586f8FlMrkdye8M4uRpZtoB86g==
X-Gm-Gg: Acq92OESJp3ECqDWIqtqwzTh6xkEAG2TZFZsysL9a1tv+onOpCnBSwmVa3jCO0P91dq
	UQ2heM42wLq+KnICjnJWDbqSLg6T3sIw7XubLq+2xcu/maPBfptPhPfILhezjW4etwQmyZ35WIw
	pD/dlPid4wnnvHnF0TVFr6rSQ7HpUN7SlnmZtoQBZKxDkD3zKPC4iYmH8vFVcAVTqtUZFF6QF9i
	RxKoYfETSkgUA1b2WES0bm7kXyn7pmFP23dKmVYkbUDd7XigPuLWxUZJlfeINxqW7I+eGT6O/fE
	M5OMwoWvqO93Bdw4
X-Received: by 2002:a17:906:6185:b0:bcb:b796:fb18 with SMTP id
 a640c23a62f3a-bcbb796fbf7mr200799066b.41.1778339609751; Sat, 09 May 2026
 08:13:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKcFC3arsYExb5dCMQspo4V9UFDadFaj8Q4PUsMWZJw_eYrMzA@mail.gmail.com>
 <20260508180341.GB737125@coredump.intra.peff.net>
In-Reply-To: <20260508180341.GB737125@coredump.intra.peff.net>
From: Mikael Magnusson <mikachu@gmail.com>
Date: Sat, 9 May 2026 17:13:17 +0200
X-Gm-Features: AVHnY4JoWzbf2yRcEfjdSxC12n8bvlKNthPaJjixk12mD2EfXu8CYI-aJVTVWBA
Message-ID: <CAHYJk3R-TyYv1MizKmHhhADrQd+VnQjxSikpcaPLB=VfHrAwpg@mail.gmail.com>
Subject: Re: unexpected auto-maintenance, was Re: git hogs the CPU, RAM and
 storage despite its config
To: Jeff King <peff@peff.net>
Cc: jean-christophe manciot <actionmystique@gmail.com>, git@vger.kernel.org, 
	Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 8, 2026 at 8:06=E2=80=AFPM Jeff King <peff@peff.net> wrote:
>
> On Mon, May 04, 2026 at 05:27:21PM +0200, jean-christophe manciot wrote:
>
> > [gc]
> >     auto =3D 0
>
> This is enough to disable auto-gc. But these days we also (instead?) run
> git-maintenance, which is controlled by maintenance.auto. So you
> probably are getting a bunch of background git-maintenance runs kicked
> off.
>
> > [pack]
> >     threads =3D 1
> >     windowMemory =3D 1g
> >
> > I expected git to use maximum one thread for packing and I'm surprised
> > it even tried to perform packing as gc.auto was disabled.
>
> This should work to tell pack-objects to use only one thread, but that
> is one thread per invocation. And we were probably kicking off a ton of
> processes due to the background maintenance (and worse, they were all
> doing the same work redundantly and maybe even stepping on each others
> toes).
>
> +cc Stolee for wisdom on all things git-maintenance.
>
> Should maintenance.auto fall back to gc.auto for compatibility and
> avoiding unwanted surprises when people upgrade?
>
> Also, should background maintenance be locking to avoid multiple runs?
> It does not seem to do so, and if I run:
>
>   git init
>   for i in $(seq 10000); do
>     echo $i >>file
>     git add file
>     git commit -m "commit $i"
>   done
>
> I get several concurrent pack-objects processes. After a few thousand
> commits I got bored and hit ^C, and the resulting repo was corrupt!
> Which is not too surprising, as multiple simultaneous repacks are known
> to be unsafe, but means we should probably avoid them.

This sounds pretty horrific, this maintenance thing is enabled by
default and there's nothing but pure chance that stops it from
corrupting the repo if I happen to run git repack manually at the same
time? It's hard to believe something this disruptive is even enabled
by default, I don't expect jobs to kick off at random hours using up
resources when I'm not working on git. (I'm assuming I'm several
months late to protest this being enabled by default, but still). I
would strongly suggest anything like this is *never* enabled by
default, it is extremely surprising to find out about. Hopefully I
misunderstood the part about this being enabled by default, and you
still need to say "git maintenance register", right? (although the
manpage erroneously(?) claims this will only enable tasks that are
safe, which you seem to have disproven?). The documentation is
extremely confusing to read, it says that registering a repo for
maintenance will *disable* maintenance.auto in the current repo? It
almost seems like you guys made two entirely separate things, named
them both the same thing, and expected anyone to understand what's
going on. git maintenance will schedule tasks to run in the background
with cron, and if you don't do this, the config variable named
"maintenance.auto" will control if things are repacked actively while
doing things in the foreground? Holy moly. I'm leaving my confusion in
place even though I figured it out because that is something else.

--=20
Mikael Magnusson
