Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FFD3FB7C0
	for <git@vger.kernel.org>; Wed, 29 Apr 2026 13:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777468505; cv=pass; b=IlzCtTQGF5M04m6nJVNwHPbYpUXXa/HxFYOufhMCh2KlV7QWp6GmynvNeywznxIVhKRmqKqyJHmVDRj3CYmxGNG7LodtmA18tQUjgte7wRVJlp19jQv/UmNKbbU3fESKVLkWLo/QlII8U1QA7kz3aEOcek0EJTj2k7yjUukfaVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777468505; c=relaxed/simple;
	bh=D2riaDeHl6H/g5dkjE+mNhurDByVHosa3fx+K5jOtwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=JqKFg7WtbYqNvuhLu1qsjhMIW9jeLamK+31Q9JGHY0I1kg0x3x0xN7Y2iLhkQR2xtFDW+xynqKwfphc+Fmo46I9VuWyOaQz3K43QJ9caKX2l7RkdPgJSXDFVqeWWijM2/vCn9e/d4IxNXOsqd7G+r1gusl8ATwmx/+DU7BPyTog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=owenstephens.co.uk; spf=none smtp.mailfrom=owenstephens.co.uk; dkim=pass (2048-bit key) header.d=owenstephens-co-uk.20251104.gappssmtp.com header.i=@owenstephens-co-uk.20251104.gappssmtp.com header.b=sfjS/aYE; arc=pass smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=owenstephens.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=owenstephens.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=owenstephens-co-uk.20251104.gappssmtp.com header.i=@owenstephens-co-uk.20251104.gappssmtp.com header.b="sfjS/aYE"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-38e96a071c3so128248721fa.0
        for <git@vger.kernel.org>; Wed, 29 Apr 2026 06:15:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777468502; cv=none;
        d=google.com; s=arc-20240605;
        b=SJfuOdAU2f09on7GfFTHVuxoLcgk4y+PmGL9yNa0rG2pqGn7fv25sJY+VTN3lxi9QL
         /c+wMUPOuEACzF8ndGlRlZ7VVxkuA2JWpZOMS+VYCgxSI9/uY6qd2lM6DDn35xDc1rez
         rgB1Np5Mx+Sz/+j6ruRmNmOOGjMFm1CCK1FH4k9Lknd6tje4fQ0AnMRz0Yev3Rb2QUA6
         qpzXnR3mEoExUUT4PWbzv4ydt6ZzOImUykJRzwDIgfVWrtoPhVLzVl01m7yCjgj35Ild
         GRjYqyF+aUGivyMp8s6ykqd0YMoh22AIFQrO20F31myBfbBn7c3Xgr9uqLlUSdx1kQoV
         7ofg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=D2riaDeHl6H/g5dkjE+mNhurDByVHosa3fx+K5jOtwI=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=V8rOdOzOGu1Ueb21s0j51/Wg6bb7baqOfaVWU9NMJEdFMgErB2amQakr0bM392QUfx
         KJuszBdFS2/+SUTCOgofPmUG1x9pqP1QZQhmz5D1Fai8QoW5g2ARbaCp/UfB81SZxJrY
         GnbdQUl/sL+vcvgtA9ZomkcNOdvfS+xQskWYekyx33hf7EnB4LQbxJB6vm2wRaFejZWQ
         bWWWBy2SNkLypf3tIyWG209v3llueNg0w5twB1qfs2BBZD9t2NIOdBoCdWOz9X7HQAsr
         +J2U/oLhxOQaHEhL4f/cyvgUgDLTLQIcuo3JIrYGELq1LuA7xmgeb+efFAAWAhQPKGsL
         a5oA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owenstephens-co-uk.20251104.gappssmtp.com; s=20251104; t=1777468502; x=1778073302; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D2riaDeHl6H/g5dkjE+mNhurDByVHosa3fx+K5jOtwI=;
        b=sfjS/aYE+KHRzsrB/rDHjjzXK0MHPerX+b1ehZJ0S0xVFe0M+RjpqL2gSf9BwdIpO2
         EohgKvdbd6mIIUGoRNz2UCy2F2Xnq+hC05f4qAjTFbm0ElaPajYpregeiYO+ExLq336M
         X0kpO+XUF7hZXO6sxEFOG1lMLd70mh2neDHi96sdkoNkNp2AWcsjRjFMfDC7t78LEONQ
         sPBmo71QGJM80TP6dEKc3Vt+6hVaoKjCBtnXPreJrMl3VtBdPL6qQWhGRRrv0qgrjDs0
         k2BibMTpZxxqQnXgtzy9z2YHoHnbTuQQqshpcAH8/ly1BhgWl5hb593z4D3vyT7gq48S
         PP8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777468502; x=1778073302;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D2riaDeHl6H/g5dkjE+mNhurDByVHosa3fx+K5jOtwI=;
        b=a0QaD4eMn38RQYUQr8ng2mP1SY+1nncfMoE+DI5jarRsSghD9XOarAsq8ujTBeytaf
         Z60mqzUgM4Kg+UBVeX3FDjRM/6Piv5+Ch22V/fNas86Jpk8/l6vXVacpnxgPVNHcUV4c
         dw5t+c2twwP7HU/Fzpr+CqNelrQ2rBsVG1Y1qiw1xx4GliNpHkXRqhkwy7sYtfQNH03F
         0LX/BfWERA/8dhFh3ars/+0ahDzgaD8fpVLdFD7QEdm1gdhG6Pj1pUyvbzJszVjhaVLm
         qjSRQXJeqblup2ijelh2VjPuKBrNuH9tiKswz4vBQ7s2XtRuJhT5YpJEzndKCe4LjMe/
         On4g==
X-Gm-Message-State: AOJu0YxP/B050V1V0yvMMUZ2c65wqW+OxtnychMlN3N/cSfFdMyucOLf
	Xqas6rz5jk9txLDQhww4dgZUW+F7TOJraTfMH3YRylwglh42fNMDFPeUTctTXvyib77BKUFOKRP
	XuzmY6+YoIgjL4Co6vapXpE+aDKLk+SnBS77WF+94sLe0sOnjrBbjPn8=
X-Gm-Gg: AeBDievw0ga4q6DAzrat/eGAFXjOO96P1xgzDn3CQR2y2IFWwBc1rUrk2lbipzoS7o7
	PiyjRrU30uOVlgiUTy8tfAN1mKEeZu1EtzXzs0PSwiumgjp9hJIjrHJtaLOUpVPSpLTegbvh5mK
	Z1u9eXh6+GapRW6YdLmU3TKlUIkPsSGLKF1JMsynCY4oyXaqTxe8jJbZtyg2Lv+A3B8Cb7g1qOH
	9imE1FXpGXOCzbnxqnwFVS7BCopKx/qHm61/jkTE1y5KogVNCrEkICgp9n6oTNlO+eqnK4Qoo6s
	1hVE+wTnutjakNOirfehFYs9R3s=
X-Received: by 2002:a05:651c:154c:b0:38e:c9f:a14c with SMTP id
 38308e7fff4ca-39240f93b8emr28117261fa.24.1777468502272; Wed, 29 Apr 2026
 06:15:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANOh7gEEw+6146NN3JV8EYxQarj0KkyA7r3RZ6v-DxeqQZLrCA@mail.gmail.com>
In-Reply-To: <CANOh7gEEw+6146NN3JV8EYxQarj0KkyA7r3RZ6v-DxeqQZLrCA@mail.gmail.com>
From: Owen Stephens <owen@owenstephens.co.uk>
Date: Wed, 29 Apr 2026 14:14:51 +0100
X-Gm-Features: AVHnY4LLPAPJFxl7KQRyhc2wa_-XwGxXQqsQLoDNPvgVQw3rPK03LiGX78lzcqc
Message-ID: <CANOh7gE6rQ1ya+KusfYhbaG9iSNqNkUtYWbTAPFOs=Ff21YSDw@mail.gmail.com>
Subject: Re: [Bug] fetch --deepen truncates history in v2.54.0
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2026 at 12:27=E2=80=AFPM Owen Stephens <owen@owenstephens.c=
o.uk> wrote:
> The key lines in the output are:
> ```
> Shallow repo? true
> 63d1ebe (HEAD -> master, origin/master, origin/HEAD) Change 4
> 864e13c (grafted) Change 3
> remote: Enumerating objects: 10, done.
> remote: Counting objects: 100% (10/10), done.
> remote: Compressing objects: 100% (2/2), done.
> remote: Total 6 (delta 1), reused 0 (delta 0), pack-reused 0 (from 0)
> Unpacking objects: 100% (6/6), 351 bytes | 175.00 KiB/s, done.
>
> Shallow repo? true
> 63d1ebe (HEAD -> master, origin/master, origin/HEAD) Change 4
> 864e13c Change 3
> 3e05d14 Change 2
> 1d9fe14 (grafted) Change 1
> remote: Total 0 (delta 0), reused 0 (delta 0), pack-reused 0 (from 0)
>
> Shallow repo? false
> 63d1ebe (HEAD -> master, origin/master, origin/HEAD) Change 4
> 864e13c Change 3
> 3e05d14 Change 2
> 1d9fe14 Change 1
> remote: Total 0 (delta 0), reused 0 (delta 0), pack-reused 0 (from 0)
>
> Shallow repo? true
> 63d1ebe (HEAD -> master, origin/master, origin/HEAD) Change 4
> 864e13c (grafted) Change 351
> ```

Apologies, I just noticed that I had inadvertently munged the final
line - it should read "864e13c (grafted) Change 3"

Owen.
