Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656B61F3B87
	for <git@vger.kernel.org>; Fri, 23 May 2025 21:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748035492; cv=none; b=s3Yz2VrcVidpWKRVH66bMWwT1DkdGejpri077QdNAf7o8b5zV6bnAD8KBpC9iy4H3aO/H7j9LI4Mi/Jj069kiexhsBPvqPsl+bN/+801S9zmdJLAw8/IHZMdvwuY45XO2Njj3qpxgSmDoIc+iEBG92uX3jdpTP/QvNxN46bYfkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748035492; c=relaxed/simple;
	bh=o5NkzcllJyzajIgfAxxnFdFMoRhFJUFkJ9TBnK89ysI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XowR5sj+dvLRut72WVxO1SP/kpwliLok+m69MqfHXmHlsNeYMfzmiyLs0x0MrYVVN25zrs5cJjCh+zExqOpHY3CzcDI98YK0wSCuAw7+BTroftg3jAaK3SwgvfA+caDYj4mXylrPFnEUpxdnBmguXYoyyecmm2PnnGXGL1BxA5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6fa9c907cacso499206d6.1
        for <git@vger.kernel.org>; Fri, 23 May 2025 14:24:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748035489; x=1748640289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xZpO4QBndLtKldyiWk9vOIbPxaBDkAs/Q7naHsRKJMg=;
        b=OgFtzgWndIYXeZPKL876EFG8A5FbZHyZzzSgM3ZNXzDoAhu2OwpS8xFkxqC4do1W0K
         oyuxyEGaBgG3lR4/O2tzAMjbpdxwVxVjed+Xp1YgdwyogjmnFseFPlxeCPR79N21SQg2
         ZoQjhXLznNt5Qz6qtVAJBqa93VAijARis7Bp0CeJQzbABVu3NN5jVvI7YI8qMUDvHuTU
         XQEkzo0i7/nnyK+tBpChLTK99xRHTTRh2kXf/nsmE+NJw5fTlwpIYQdIVcmenpa9pssW
         2w6gPPp444M6M6uttIB5X8KOfdmTjOKIFN+lp0Pvw6gsfXvY1VNXZcogfaFPCIXxChnD
         PueA==
X-Forwarded-Encrypted: i=1; AJvYcCWG1Lq28SvyUFZwPMf9IqrLSWqHZrhenFuO+p+M901osm4UUmrC1Kb+tms+dGUOI0kDQ/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIjPS4snAsOWCJwUY9NVt+YViTK4cv0lVNjcvWtFV2IwIhyS1+
	8jvkXqybRJ8NHAeICMi7R7v/6AqXn2KM3sMcmbM/GHUWatPPC/+QwvIbVHfKlXuS/WtheXHuXyq
	K+yZYdfu6CxxeqrcsQ3Hxxet1wonNdwo=
X-Gm-Gg: ASbGncvj1+TEE6jWDGmHdX99wIMUvSPbmNrB0wODf/B6xUPaH8sSl5akXozRG59mRrc
	UrAYvDz98JQTrfhd7dVhh6NzwTWZbkmayq4g1lXhyQNrhQLTcrLGDIyp3gjVWP22rBW5ZIkHwjx
	Mb77Oecx0ezRWs2wap9ePLAMCd7I4SK2k=
X-Google-Smtp-Source: AGHT+IH8v9hc8VmNG0bBFv0gCnLg8WohvMBmMD1kqCvcN6qsOvu7t0qc4/2julLGkS9VX1GQRxY7U363uZDDCnrq2KQ=
X-Received: by 2002:a05:6214:4115:b0:6f8:b104:4186 with SMTP id
 6a1803df08f44-6fa9d0318b7mr6091326d6.2.1748035489258; Fri, 23 May 2025
 14:24:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250523193722.68344-1-mark@chromium.org> <CAPig+cRpS=t-wNLxdV_WoKF0Wzy-S1oLUEyS18S9r-4OBQ87VQ@mail.gmail.com>
 <xmqqsekvvz1t.fsf@gitster.g>
In-Reply-To: <xmqqsekvvz1t.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 23 May 2025 17:24:38 -0400
X-Gm-Features: AX0GCFsfyfnQb9IuARRMbkicSKn6C7oV_YjkMvelHtpHXIuvLUorbhX8Cy15x-0
Message-ID: <CAPig+cQLG+zveZg73E=TiC5uShhhRXKmK5Z_M8zN3fpGNEN1ng@mail.gmail.com>
Subject: Re: [PATCH] t7900: use pwd -P in macOS maintenance test
To: Junio C Hamano <gitster@pobox.com>
Cc: Mark Mentovai <mark@chromium.org>, Git Development <git@vger.kernel.org>, 
	Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2025 at 4:42=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> >> -       pfx=3D$(cd "$HOME" && pwd) &&
> >> +       pfx=3D$(cd "$HOME" && pwd -P) &&
> >
> > However, have you tested this on Windows? I ask because, despite the
> > test's name, this and most of the tests in this script, are actually
> > run on all platforms, and because `pwd` is overridden by a shell
> > function for MinGW on Windows:
> >
> >     # t/test-lib.sh
> >     ...
> >     # git sees Windows-style pwd
> >     pwd () {
> >         builtin pwd -W
> >     }
>
> Because pwd emulation we use on Windows ignores -P the updated
> caller, pfx with this change would not change the existing
> behaviour.

True. I overlooked that[*].

[*]: This is the second time in two days I made a stupid mistake when
replying to a patch. I should probably stop trying to read/review
patches while my mind is more focused on whatever task I'm actually
working on despite having a few moments available while waiting for a
compilation or other lengthy operation to finish.

> How would one test this situation on Windows, I wonder?  Create a
> directory that is pointed at by a symbolic link, and use it as the
> test directory (either have the checkout there, or use --root to
> have the trash directory there)?

Perhaps(?). The Windows experts on the list are probably better suited
to answer.

> > [*]: In the long run, a better fix would probably be for the tests to
> > sanitize the output of the Git command, replacing (via `sed`) the
> > actual emitted path with some placeholder, such as "%HOME%" or
> > something, and then have the tests look for (`grep` or whatnot)
> > needles using that literal placeholder rather than trying to perfectly
> > match the path emitted by Git. This approach makes sense since these
> > tests are about overall functionality of git-maintenance, not about
> > the specific path in which the person happens to be running the tests.
>
> Another approach may be to do a form of chdir that forces the shell
> to figure out where it really is upfront at the beginning of a test
> script, perhaps inside test-lib.sh which happend before anything
> meaningful happens in the test (i.e. "cd -P ." or something).

Hmm, I'm not sure how that would help this particular case which wants
to know the path of $HOME:

    pfx=3D$(cd "$HOME" && pwd -P) &&
