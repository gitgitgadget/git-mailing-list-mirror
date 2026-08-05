Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F323CEB83
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 03:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785899408; cv=pass; b=I20UGUX1UiL4bU6hZ9bcYQ5LOefzDLVR77ibvOHJvSsfOOQZCL6d7ghwUwJ+GbFfydzPZUxsauLCGY7wH4k0CSXO6kUQ9TkReIxGfts1Gq6crWitSVpBoBEP3q5VYW0wdooz8TZg8wRiemBTT4BB/W1cOUgx95/WPivsdNGmDhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785899408; c=relaxed/simple;
	bh=6UtLaoAN+ky27U8YXkjDm+6mW7XwWMUYh5MLFLOCFA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=kBGZvjX11t+cDGTcY9zxBvC9S6//bdAAoWY5oYO3oaBZTQgeavYZoI1icOOtmblpn57D8q1S0RBPj4uJIza1deSQcyhy8Lhn1ZlssopyjHMIqNs+D3W1os10HBRd+XpOe/Nkr3GdtL5ko/JxEMsmX0Pw7uCBfRjayinCR/ZVpWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BXlrAS8O; arc=pass smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXlrAS8O"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-44856d185bcso376332fac.3
        for <git@vger.kernel.org>; Tue, 04 Aug 2026 20:10:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785899405; cv=none;
        d=google.com; s=arc-20260327;
        b=s3LXcBdQcGrvVizXMP7oQrexVKfFhPO3BRpucTmYLf7U4AuZnY671a/uFVCCg5Vqim
         6msNfUQ2USzRM/htFK3UYgjcKzhSOtTKRNmz3UYv8jCAEaCD5191uMEpNT5vmfK0VDfX
         s8eCt38zqAmKL7wKZylNYUKh097Bc5nBBBkKq+bcW+BNPjJKsb2jex5IKegTizuh0qjC
         tSmb0EPWMrWXkVytYPYpMkfKL6Ucq6bfbQIFtvnPPo/P8E/jhknqbynsV9JYgDp7R9L6
         7oIASpXhjfuNNxH2ePRggOBeIaYjo3pokjkJzdDAyqfGN98Md1xOEnDPCa4yVCHYC2V4
         E6Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6tD8ATmY4H0/te+NGZ1VY7inqJRV3y85b2HcyoNGNn8=;
        fh=BcFhNca+Llv59/ReMgMe9/LlAaiuuVCnA5xv5X4lZYs=;
        b=Pu1YOxOYATFPusoUoWys5IW3ki8L5dNREfc9o0tNZ2GtMHCthFQnrC75e//Wvy9svP
         yg+6G/khz+O4XoD/6EIWtLz5toBfbyWwlCbMa9n8swpvh0xnjmI6q1vzijv+oY8gMsgI
         g7Lzgp3TxZEjjZt1kVu648cMGn5gJspEGQ5lfPs8GxoncjPlZnYtzJJ8ITLmnySVkJfr
         FfzzbYPU3LWNpIV7G6YT+1mD2TUsLhJ09MqP6nBRIOCdWWV4+3ukhLKh+3ofuwJhNeNb
         gTAEfM20XX/L3nVMokG8CFis3dWYMD6+QpkrFFq+SE6PPV6llovpwOB3/41Ga1pVmUv5
         eegw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785899405; x=1786504205; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6tD8ATmY4H0/te+NGZ1VY7inqJRV3y85b2HcyoNGNn8=;
        b=BXlrAS8OSn4DBZpcJYmdrbQEvonL0xEMVU1jtolM9SHha6MnMuV9uizgeOf8TndcoT
         wIfHoqzFxLHksgtGALB/JVQSehU2YYAgYL3NZBHyEy4BHwt4+W8BFAspYt9zDS1UnKL/
         tgBhYFg7CyyusGSkQ+IUWe2V+V3ZhddvwzNvHkpVtCE4l6lNpkcwhWt/zRwfcrhMU2jt
         FCebZRsiwah1XgGTeBbCva649q+We6gKX9e6Ka8/b2UEajlC5Keb6CiUCDLC3w44fZ7l
         WKxIogL9lkvrV+9bdKcIkTynEKCXMeuNWdJmTL9YXLAQlPVKNAiw+s3H42+I0xMaC23O
         SynA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785899405; x=1786504205;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6tD8ATmY4H0/te+NGZ1VY7inqJRV3y85b2HcyoNGNn8=;
        b=mLn0a6N2wHdIlpW14k33HGWYynVMCY6aKl0unOyZ+/7SaZ7TjkSroEXO23HoL6Pvgb
         g4biOXwrYeVBx8XGmhLNnvVyc2Lx6JZV4sgu0T3dBukW0Zv574dn8ljkYVfst7x6Mr7q
         a6Knbvzpo/b1xNYGvJhnQWyJ+8CuytXRuhGN6Be5nq502Gr3k//SBwzw/i2qXd4tfkje
         NEYnga3JitBI2hw3vCLWWYyCVzaXLQKugkS0ehnvqqF90GOLFwJCS1izs0cm+VEmzZ+u
         DIhPX7KhMkO/GQG++R654B3y/eZgdKrAtOB6MU6WjBeG8x1nilM7ap93n17HJeF6kVhj
         fEeA==
X-Forwarded-Encrypted: i=1; AHgh+Rr4/UbXWaVNxmnRYmKNnEybsKHKKwfeZGVJ1uGiR/fo8pAkvPIdGvIqa4jq+HuPliJjKLI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRF/70kwAjpjb2v/zF2ZqxAi2Ylyy2Zpe+3upVMIUWDC9szPw2
	4+MNWmiuQBzMEAa5qzud7v78+qATNSyv0eGv0NtBBSnIOU2vXP0H3vNwkFPWmVlPKrCif+IvPuM
	EIfQdfWZ5svuTuPueNHSAlDWFpsUn14Q=
X-Gm-Gg: AR+sD13pktHyqrWiY1kgDYXQPB2MQ70MinYcwoDHAXaRQqLJ2twf+GK+E+SZUvtI9ye
	Aap5XMldOyxI3/wNRwayXEzfSJ9S+E9VymgU7S3OM34vm+UfM0LK+2+XSNRAZyo21agNUKJLZXY
	+sjgOQb5auEH79klcEqCtkl5+aoZ8sa49hlh4jHoCM6fsm+t+AS+v1irZKUpe9BH+PFxf1sLC20
	ZjIKbiH4CTlYCZKANtdd36e2QxZsh0HILoFBUOeGkDUSpiFN3IXYtWIQAR91MpCnK2l4lHzh1jQ
	t4tw1pbZp24436gEg8Ue62q9GmvRsWVAj6rxH12cMT4dsz3q1NqfPHbPLgw4Y+OMr34YAM6+gzv
	tuks7FBIeGbfp4JBUHoJ9lVUV4o86qMRtqvV/VBHxAxixuqobg8k3XwSWOP6oPBGuJxMuyVPYSQ
	==
X-Received: by 2002:a05:6870:b2e1:b0:451:3852:25a9 with SMTP id
 586e51a60fabf-4599f0fbac1mr2169955fac.21.1785899405442; Tue, 04 Aug 2026
 20:10:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729233215.398654-1-sandals@crustytoothpaste.net>
 <20260729233215.398654-7-sandals@crustytoothpaste.net> <xmqqv79vha69.fsf@gitster.g>
 <am_AL9dymrkidizF@fruit.crustytoothpaste.net>
In-Reply-To: <am_AL9dymrkidizF@fruit.crustytoothpaste.net>
From: Michael Montalbo <mmontalbo@gmail.com>
Date: Tue, 4 Aug 2026 20:09:53 -0700
X-Gm-Features: AUfX_mwEaJo4yl4dE8ijE8mD8fBGKKtvo841kcRJqynHZHcz3YYWwK2DK6hh7aA
Message-ID: <CAC2QwmKS+ojHd31oagdHv1G3h=Sa-BttWpQLv49=kC=PC-1BTQ@mail.gmail.com>
Subject: Re: [RFC PATCH 6/6] hex: allow only lowercase object IDs in breaking
 changes mode
To: "brian m. carlson" <sandals@crustytoothpaste.net>, Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 2, 2026 at 3:10=E2=80=AFPM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> Modern development effectively requires being clear and definitive about
> what data is accepted and what is not, as well as what meaning is given
> to the data that is accepted.
>

I agree with this idea, and the topic inspired me to explore how mixing
upper and lowercase hex oids might be "abused" today. Interestingly, I
found out it is possible to mix upper and lowercase formats within one
oid. Depending on output path, Git either normalizes the casing or
preserves the raw form stored. I didn't come up with a specific way to
take advantage of this behavior yet, but one could imagine a scenario
where downstream consumers of Git output each have their own way
of parsing such an ambiguously formatted oid and behave in different
ways that at best may cause confusion and at worst could be used
maliciously.

To reproduce a mixed case oid scenario:

    #!/bin/sh
    set -eu

    ( repo=3D$(mktemp -d); cd "$repo"
      export GIT_PAGER=3Dcat
      git init -q
      git config user.name Tester && git config user.email tester@example.c=
om

      echo one >f && git add f && git commit -qm base
      echo two >f && git commit -qam child

      # Re-spell the child's parent OID with a mixed-case tail, re-store th=
e
      # object.  Nothing else about the commit changes.
      parent=3D$(git rev-parse HEAD^)
      upper=3D$(printf %s "$parent" | tr '[:lower:]' '[:upper:]')
      mixed=3D$(printf %s "$parent" | cut -c1-10)$(printf %s "$parent" |
cut -c11- | tr '[:lower:]' '[:upper:]')
      git cat-file commit HEAD | sed "s/^parent .*/parent $mixed/" >crafted=
-obj
      crafted=3D$(git hash-object -w -t commit --stdin <crafted-obj)
      git update-ref refs/heads/mixed "$crafted"

      echo "=3D=3D the two commit objects differ by one field, case only =
=3D=3D"
      git cat-file commit HEAD >canon-obj
      diff canon-obj crafted-obj || true

      echo
      echo "=3D=3D they are distinct commits =3D=3D"
      printf 'canonical: %s\nmixed    : %s\n' "$(git rev-parse HEAD)" "$cra=
fted"

      echo
      echo "=3D=3D both parent spellings resolve to the same object =3D=3D"
      git rev-parse "$parent" "$upper"

      echo
      echo "=3D=3D the one parent is spelled two ways, by output path =3D=
=3D"
      printf 'raw (as stored) : '; git log -1 --pretty=3Draw mixed | sed
-n 's/^parent //p'
      printf '%%P  (normalized): '; git log -1 --format=3D'%P' mixed
    )

produces:

    =3D=3D the two commit objects differ by one field, case only =3D=3D
    2c2
    < parent f3b4ff525d82ddcec0cc8597842c73b72e4c5aba
    ---
    > parent f3b4ff525d82DDCEC0CC8597842C73B72E4C5ABA

    =3D=3D they are distinct commits =3D=3D
    canonical: 52d41f6a261b49a18d38933b59a65f2dc919f9ac
    mixed    : ed20e85251a37eb01009faaaa8fbc23baf8bdc72

    =3D=3D both parent spellings resolve to the same object =3D=3D
    f3b4ff525d82ddcec0cc8597842c73b72e4c5aba
    f3b4ff525d82ddcec0cc8597842c73b72e4c5aba

    =3D=3D the one parent is spelled two ways, by output path =3D=3D
    raw (as stored) : f3b4ff525d82DDCEC0CC8597842C73B72E4C5ABA
    %P  (normalized): f3b4ff525d82ddcec0cc8597842c73b72e4c5aba
