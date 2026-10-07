Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C363E5A38
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 18:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791396828; cv=pass; b=EmzWS8dp/jJ9cT/uCGZJ7sp4JtJ40nd0JcopwxAv2LjWlV/6WEeVbqcLcjbc/t+pDSFIcGpastTfYA9KNXofYMs6Btm1bQKWu44s/vu8JJ2VMRrkPlzp3dMt7tJLBzy939t6jKSRVDJebsTAQKbrIr5bYPKelGAHuPaKwbKaHHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791396828; c=relaxed/simple;
	bh=3oPT2xhuaESshjVSfh1U6rYSMCOriFnFSoPf186JfPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qVTYByFCYSAKqAANiGhd8tf6KT0Jce3zoA9sNjrbshDPek7vG6ZjgHTXXxfBVEl3F/vOlh7rr97u16dGnBmVxNLo4sU10rlAMErZBNMhQ6rkuXjikEmHDHuiysOdKbk5UTeg1u4/K3XMlAW9+qNUpPW5S4f3koeXagkth60IkF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DC7oirQn; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DC7oirQn"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6a642495d81so3481791a12.2
        for <git@vger.kernel.org>; Wed, 07 Oct 2026 11:13:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791396826; cv=none;
        d=google.com; s=arc-20260327;
        b=qADvbdONxCpUGjicpRXlSftP4d7s+xROjaSjs5cCLfU1EPMDhG5YcGxHJ7YsOarMKm
         gdlqa5qOvyN9mQmuqhPHUEr14hXbTjQyD/cNKmD7Txg1TPhI8sA2A2N1n1dzQm+FB0MI
         Z8HE87967MRpSzbKPONNmkE4xb275VxPINgrFnrbtbkBA+bxGbiK9EDdHup3WIAc+TF7
         pARtk1gfcTU0IS+HmGInxYDw8wKsD2Jj72nKqy/2VO4r3lmkClxFl5cNTRMtRohYjqRO
         p8wLAXKZHRcZOeA2XXIP1BG6mLQ4J8hBHdl7oX5uBtfp/MPkC2Nziu5+dwnsMKIL3j63
         XYRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kopGi7rvJ8rNp4TQOTVTqyF5OBJp8Gt5/IpFSXadE1w=;
        fh=Mcd2J8EoP7OizdutGGSyKymaTePAhFkbksIpg1JFuSY=;
        b=aoImn4ty4WHFHyCJSKtAoeE7hbSbBoGk51KMXtAXywBjFABjF1FX/u9yoUTCD9A4rB
         DvoL1v2/wqMwiHvJET7cskp8w1W7NErJySycxqpWL+JRapB7mjrBbimglT5FQLQJj32b
         W+Om/mbwHJOA2ByEahqdQ2+UeIZJunjSsRQP/otyhhEwQ2sLFSDY+4jlIvVgWDMDS9pC
         LPaa3r8CnIOCZOq7MM7JMJhAjMIhTBsWcKLKQDjNB9zktWYebIyhDp6bAXoGZNmF94Pn
         i+zZSszW6i7SDOA2PkhPc6M+olEa3XCkQhCe5ns9Lf3BTz5RJnoeXOAFvwiqpnf5L37m
         iS4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791396826; x=1792001626; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kopGi7rvJ8rNp4TQOTVTqyF5OBJp8Gt5/IpFSXadE1w=;
        b=DC7oirQnmVDxwS+DE+G7e9wzGg0pgXy0rTO771yJwkUP60xxbwOQLMSOGeD5TkGwtr
         hV0CDXHHthEl/zr+i/IMJDF6E/g772wEm7u9czoSdFO8wClTeX9J1S02vDwM39qRlEbz
         rvGdHCWh2RhDOHgSPeLbftfOhZJGhPVF48PCtqH4DoIrFHzgnwgIx8QaLKSYA/cfX7xR
         HqFY2d0iYcxnPFhPswcS2BtyEbidqZoOqmElNIxu7ZRjkQbx2aDQdzhSQ8c+zXtIZEi0
         8hUF8ztrEo93uC5u0gz4ohPzS/aXQn7+4OkfyLJEF9j7dQTTnpyNHKO+fMFdJNRzq613
         UlQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791396826; x=1792001626;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kopGi7rvJ8rNp4TQOTVTqyF5OBJp8Gt5/IpFSXadE1w=;
        b=zNaTUxXq3dqyi00MUYUiN5w3k9mWg1jI/IkGTOJn/W/k7Fvfc8a5D9FjLh1TwCXK4y
         4OchOA0++zTMkNYEYGNEjgg5e9bIuaf3DCIGMSkzBL9PHutH8Mr7ENvWiT7XMn0t3XH6
         XhYc0a8jrIEkNRR5jlPBbNc3WEahaxYHW9sR6De6Uaa88MzYtu6LMKMZEnQpYnHpCHBK
         gw23ieZ5Ehr1lm7PizuXAPqg2A6s2yKjs8bXmni/NJK+sQ2BW0lz9IvAYqdeZv5U3/HF
         8yJElh/Wd84tRgBM5/cvZvaPq29pXfV45+MrrJxwPfhOhsfcYhjj3Ek+lh+/TcaI3zym
         qNNg==
X-Forwarded-Encrypted: i=1; AKwUvBzNvSXh044KuE5W0F7ohkUWKz+ciNTIgwFzBH2izTZaak0djpcf1hfM8g4ggLqUNdV+jPo=@vger.kernel.org
X-Gm-Message-State: AFq9FYI5GAGnJI1RXTr+1Fq89AgS75SwkxKBcXLl+cFJzvURQDQGVqDH
	Ff7Tk3E/OPY5v0W3/zYjHNFTMWw+CcMr0kKer1OUPttnjK1TwmCyGTBn8cNGSDLNXURDWekAFX3
	oqKdOUMrRBjlpW0Koqp9q8k7H9VsOOms=
X-Gm-Gg: AYBFou2rTlViNYFNcJ8O3O704ZTZHBe/RYn1BVN9qirNlWX4l2h22c3d1v52LEHU/t6
	oh03rIQgxBMYK3zQl0hs3L+LqfLROJ/Uyn9glNFNoJzw5kZldWoxTindp+DuLxgY+LSFZS9IEDi
	aSMfzGV+wNFFWHGdpMnrb9HDLgR8jokSQXgoDrhXDLKcE29VydEbkZHNL2pLk0DziRmq8oAs2BL
	m38YcXX+m4z3kfD9OAPYFpeTrTzmBr6vHSt5AqvKlGB90reipMDXKhYp76L8ARPx9CJPY5NSNtq
	cjn3BadddkFcnlf6QBrE/80TlAPfZYJwVh8to+dnTZ1BM9z131GpepAfK+X5KtyZKdzZfDd1JA8
	0ltzCpn8V6hE=
X-Received: by 2002:a05:6402:90c:b0:6aa:665:830 with SMTP id
 4fb4d7f45d1cf-6aff39863c9mr2984135a12.15.1791396825572; Wed, 07 Oct 2026
 11:13:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929112544.86511-1-scott@gitbutler.net> <xmqq5wzda0h6.fsf@gitster.g>
In-Reply-To: <xmqq5wzda0h6.fsf@gitster.g>
From: Scott Chacon <schacon@gmail.com>
Date: Wed, 7 Oct 2026 20:13:33 +0200
X-Gm-Features: AclHuK-FuaPVXSo3_CQPgrTAS88sZYiDSE3b0uA1S3t9QrEbgdnxe2B1a9kiX5A
Message-ID: <CAP2yMaL51H1OAG25nQ0NuLQLb0wevd4CicCG1_ezsJfrZDqfUA@mail.gmail.com>
Subject: Re: [PATCH 0/4] faster SHA-1 collision detection
To: Junio C Hamano <gitster@pobox.com>
Cc: Scott Chacon <scott@gitbutler.net>, git@vger.kernel.org, Sam Reis <sam@opencanopy.dev>, 
	Sebastian Thiel <sebastian.thiel@icloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey,

On Wed, Oct 7, 2026 at 7:23=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
> > This series ports the approach of Sam Reis's sha1dc Rust crate [1],
> > which gitoxide recently switched to [2], to C.
>
> Which means license-wise the original is compatible with us, I
> presume, as they are "Apache2 or MIT, your choice".
>
> How can you/we be sure, with respect to the current AI policy in
> SubmittingPatches (which by the way was vetted by SFC lawyers), that
> your "AI generated" code did not "borrow" from places that gets
> you/us into trouble?

It's a good question. I actually just submitted a proposed update to
that policy based on SFC's updated guidelines, but either way, I
learned about this from Sam and have talked to him about the port and
he seemed excited about it. I can triple check, but I'm fairly
confident that he's fine with this and I am fine signing off on it
under the terms of the DCO language.

Of course, he in turn used AI tooling to produce _his_ library, but
within the guidelines of the updated SFC guidelines. Johannes's
alternative series is the original Rust code of Sam that my agent
looked at to produce this (in addition to his blog post explaining
it), so I'm not sure how that might be materially different.

> > The end result hashes roughly 2.7x faster on the Xeon and 2.85x faster
> > on the M5 Max. Single-threaded index-pack of git.git goes from 24.3s to
> > 12.7s on the Xeon, and from 16.1s to 8.7s on the M5 Max.
> >
> > Hashing throughput on the Xeon, in MiB/s:
> >
> >                                 16KiB    1MiB   vs OpenSSL
> >   OpenSSL SHA-1 (no detection)   1234    1129      1.00x
> >   sha1dc/ (today)                 435     450      2.67x
> >   shani+avx2 (default here)      1002     901      1.24x
> >   shani+sse2                     1075    1008      1.13x
> >   portable+avx2                   553     654      1.96x
> >   portable+sse2                   603     681      1.84x
> >   portable                        466     565      2.29x
> >
> > In other words, currently collision detection costs about 1.5=E2=80=932=
.5x on
> > top of the hashing itself today, but only about 0.2x with the series.
>
> Thanks for these numbers.

It would have been better had I provided the same relative scale (it
should be 1.5-2.5x vs 1.2x, but whatever, you probably get it. It's
20% overhead here vs 50%-150% overhead previously).

> > [1] https://sam.dev/blog/faster-sha1-collision-detection
> > [2] https://github.com/GitoxideLabs/gitoxide/pull/3008
>
> And the pointers to the original sources.

CC'ing Sam (sha1dc rust guy) and Sebastian (Gitoxide) on this, just in
case they have an opinion but I'm pretty sure they would be more than
happy for this to be integrated.

Scott
