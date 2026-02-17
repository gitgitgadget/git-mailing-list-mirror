Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D137191F98
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 13:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771333829; cv=pass; b=tAKL5zsZm6WGgkRNI8Ym1woI18qORQHSV+UvSojnkLp1e9zmCnxZKw9Z5LpI2I4zp/Q1tFlddK5evR5xDz7LtIkY1mxsc9eFleAE22xzA23ZfGafZ1KIDvClXOaA5YPaH0Y5aW72i4vO63Z6Ta15nqJ2GFEp5PdrOY40ZgqVxjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771333829; c=relaxed/simple;
	bh=M9x1rHO7UsFQ8gwSqJKpftXtRjOFA++kSN6NzADsKh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TfvS2W6DHDXWeERYlmqh1R7YY0K+svbUaXF7gQ1Bz+k+ZUuoQ3gtEfpwgCGDisxr2kXHDnpvIEGVBPnOS4BCuBY8nxRSL9nU55fDWBdPLTLvqoUJs6PU4g0GUPaeylD+WnS2n6Ax86YrFRRk4C50djT6d4LD3io05yGkzbutNCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cU8qVpVn; arc=pass smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cU8qVpVn"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-35640ad94d3so2813569a91.1
        for <git@vger.kernel.org>; Tue, 17 Feb 2026 05:10:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771333825; cv=none;
        d=google.com; s=arc-20240605;
        b=MPnSZkCjiJ6tlk5FEDIBAsBh7mAePmTpYWRRilIWY/pq/kKn1iiV11GOtqVKNrsbgu
         x4UlxqvMgJ5XI/35CaQkr+cqTSzjja086YMT1r7pIkBj1gaIclG+V80bs7eiXCcAbYjX
         017R/An5kfVHd4SfEgz8b5d3j/DMtTq/RCeD9VcAO5RHXYmYt+sfpVKi8R4AWKQK2Av7
         Q/CeGElEviIn1epkkXBcuZboY7nXQJAxpfkL//krz9hN0I3R7dEAJG/9EKlbhRFMxMKG
         mHAAED+a3j4ZWIytG0Nvzeyl7vhctkPfXhKJSrAYnwGViESspe9IZ4cOIKwg5Bfb8JcU
         7mJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gOjq5lBkz3aClCZ5FXZoFkpq0D+ewwNW3wf3k0qY9Uk=;
        fh=pWyRf2q6Cj4atnzp9ItHQ8NvbjJ9ZTCr/V/a4vCmUKw=;
        b=NpPEUkHVvcKcNRmeP119ewdnKnPNVmZmWowVNpZUIFsFDQ8kv4EdLhX6SyDtXEi9LZ
         QRJ9ozu0uCrawyd85/VKLVjro8NNd98tkz35IEZedJczBWiFnwW8wO0RCcr/cRGJhr03
         9PS+Ke/PqwxT/APcJ8VEoX9nQbDN7hErkM2fYp/FkidsXSodnpe32DDCW5JmWBu5iknl
         46xMa8rmarXLfaaa1ocDLn/NoCDNOgTJ4cL0tyizsTmmov/HYvov6zPwZCQsZ2j8s+C9
         3KbNE4o7chCQQ3N22qcfyRgjsRyq/EELE1lg4LaWGZRmFlQXOJEJqRxiA8k+j66rdfY6
         MySQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771333825; x=1771938625; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gOjq5lBkz3aClCZ5FXZoFkpq0D+ewwNW3wf3k0qY9Uk=;
        b=cU8qVpVn2N+YzFY+5n90MCBZut3UksBMxre8wm9be9f54uV37Fu7L2svzUIslC/U3f
         MedAhkqAAuWYvEXx/ulvgB8l72rmt6/n+nnHoCVhDvjVD1/wZcWqYyg2nvaX7MNsPL6Q
         iQNqVrOkFVaJP6Yru7McBUgWubgZ1bBPjoPIKhlTB8lRFLfNPtaiuyraQkNvN2WPpIuj
         +/VXMHyYJhuPJqDr9wN9tR3nZRQ4ytXSIOZPZGyz4dmtgYGHK2TN1DMz1j1+hcVevKCp
         sMdeOLUlGnuYFvvB5a4yUgTzrHl0RtkVYk/2yPSN6fSR7jw8coXMcGNuIjMsutumZuTU
         dZtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771333825; x=1771938625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gOjq5lBkz3aClCZ5FXZoFkpq0D+ewwNW3wf3k0qY9Uk=;
        b=omp6I2FDLZAN2Pp7kwoaOX2vJ3XNNAS0bZ4uVxlRcFemso7WySc8zoPX43w6e6h8wQ
         wsousRp6yt+6vyXmdmSeFIwCK0FCBqrnD8ezp+hJULqyvvBvJVTFo2FcJk0cJReZKUs9
         kzv9RvpVLiiOGGHnI9nQcy1DmqLSrC1VvVK//6UDqzDt88TwizeM15M/hZ3mjTc9d0uo
         cFGhwno1RfB8pVCBMCIg8rJHC0Sg7xy9X1d2OG2trm2a06qNp89hBa65EkxcLWOpqvn4
         xEeTAFRH3/9r9vq5Zx4ihwmcrNO6Cr8e15m52CLy/3tluNFuHP62pptuiqUVcxXaA25B
         d9Qg==
X-Forwarded-Encrypted: i=1; AJvYcCXR4ncmki+oO1BekTRP0ltjz27u8l/dSLNkdYqytCj4CabliMVGBuakVCz6XNHTmigJRZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5raODn9EucR6ic9wI/VRW/FoF/+A0dvVoNn3qRICiSrur7qbh
	kOX4xf+gow9IxEocF0rKdHZ4PT98YVjW2wCEobse9bL6InBZVMBb07WWZFjV+nXoN+uepSnm6kD
	SkqpdOfDmYowiWhT+Af6/+GYDTAT/Ofo=
X-Gm-Gg: AZuq6aIoeKXPK8it/goVnBItZju5icT7QeDDCW5sNsH829cNHfRGhzqT8zSroUaHblI
	fd4USRRUYEMKB/0snQcuw55K0EH7QGmZW9/X4DuwD9R6cFCQFk1o+C6m2B0Aywt0s5bGkQitSS9
	9j2Vy6sfLg/2R05pS0Jh+cMYMMi0VwBgAI2FoDI5GWQL1MFQNVJKQSxC1Q4wUUy74Umov7rgLA8
	JPklji+q0GzaI2m3PWzo/dlzEwN/3cD0hA/IVGpKMgiMWrpFekcVBBXR3KgJqr+aH1dRfjlFIz8
	eUw8qxmudqtI0kkHIyQXf6MPgbKYBfFdiWO1tXrSLsD2A/x98ZUZCGdkmutleTK/wz27JE/4TUZ
	ZpVd8pM2gPeHssKH6BMxbMfl6RQ==
X-Received: by 2002:a17:90b:1fcf:b0:356:41c2:897d with SMTP id
 98e67ed59e1d1-356aaa7623amr13293073a91.8.1771333825475; Tue, 17 Feb 2026
 05:10:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2046.git.1770746461307.gitgitgadget@gmail.com>
 <pull.2046.v2.git.1770775169908.gitgitgadget@gmail.com> <xmqqms1fwasx.fsf@gitster.g>
 <CAOTNsDz0ZtdsM8Z2NW0WBMGs8xyWz5ROS6pf8DKQAx26LU4xRA@mail.gmail.com>
 <CALnO6CARu8HSYh9=z6FAF=84q1qA4Oan7_DLMbcK+1rth8B7cA@mail.gmail.com> <CAOTNsDwMeszCC6wunkkx_vhKYx9OvRWXB4VxedypOTQJ6Qs2sA@mail.gmail.com>
In-Reply-To: <CAOTNsDwMeszCC6wunkkx_vhKYx9OvRWXB4VxedypOTQJ6Qs2sA@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 17 Feb 2026 08:10:14 -0500
X-Gm-Features: AaiRm52THBLhkhiCQ3PMfSVVY4FOodneI4uSvYUdtJ81fLD3sfQ2aCBLU3ypHcc
Message-ID: <CALnO6CCYorpEzmZwLrb7O-ucKLTOCLp6zXxZr0Qv73tOBqKKig@mail.gmail.com>
Subject: Re: [PATCH v2] osxkeychain: define build targets in the top-level Makefile.
To: Koji Nakamaru <koji.nakamaru@gree.net>
Cc: Junio C Hamano <gitster@pobox.com>, 
	Koji Nakamaru via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 16, 2026 at 8:09=E2=80=AFPM Koji Nakamaru <koji.nakamaru@gree.n=
et> wrote:
>
> On Tue, Feb 17, 2026 at 8:45=E2=80=AFAM D. Ben Knoble <ben.knoble@gmail.c=
om> wrote:
> > ...
> >
> > Homebrew picked this patch on top of 2.53.0, and on a recent build on
> > older macOS I needed to
> >
> >     mkdir contrib/credential/osxkeychain/.depend
> >
> > in order to make their build work, since otherwise:
> >
> >     error: error opening
> > 'contrib/credential/osxkeychain/.depend/git-credential-osxkeychain.o.d'=
:
> > No such file or directory
> >     1 error generated.
> >     make[1]: ***
> > [contrib/credential/osxkeychain/git-credential-osxkeychain.o] Error 1
>
> I tried to reproduce this using the current Homebrew formula for git [1]
> on macOS 15.7.4 and 14.8.4 (both relatively newer) with the following
> steps:
>
>   brew tap --force homebrew/core
>   cd "$(brew --repository homebrew/core)"
>   git checkout -B main origin/main
>   git pull
>   HOMEBREW_NO_INSTALL_FROM_API=3D1 brew reinstall --build-from-source git
>
> In my environment, the build finished successfully. The patch doesn't
> seem to trigger any issues during a local "make" either. How exactly are
> you performing your build?
>
> [1] https://github.com/Homebrew/homebrew-core/blob/9ec3da0dcd3ccd1cd4d892=
a71377b251770212d7/Formula/g/git.rb

macOS 12.7.6 ;) hence tier 3 Homebrew support + all packages build
from source. So just

    brew upgrade git

built 2.53.0 + patches from source. "brew --version" says I have
"Homebrew 5.0.14-59-g45db1ce"; it doesn't print a homebrew-core line,
so I'm not sure off-hand if that includes the core tap version or not
anymore.

I ended up having to use `brew upgrade --debug git`, fix the build
error ("mkdir =E2=80=A6") and manually perform a few steps when it arose, e=
tc.

--=20
D. Ben Knoble
