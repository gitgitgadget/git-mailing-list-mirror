Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C1847ACE2
	for <git@vger.kernel.org>; Sat, 17 Oct 2026 09:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792229714; cv=pass; b=JnrSz7rryFj/0wTfjvSRn3rtN0eI+EI0hNkXEu92ULigWbeacNQZiILHacapcl1wdO5QB/hBwaZigoFmPpRmdlFV0Rh3Es2xEIi6gpulUyXf+/Z1aLRtb1mElAWlWLW6Wn4v8zAWDCwi+jVt0h3cFHoj3lJMo+KvO8zqV3oyX70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792229714; c=relaxed/simple;
	bh=sKwBIwvkr/zsyL450jMjqn+mioZm7h3bj4HHg/U18Hw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=S+r3vnxCFpfqQLr0kUlk+yoIFGr16WaYsdv/hV3lLivq8zfcpRbJO9ZgmhowRetMWxtqmK7zmN5KOm6P+psYjtfb6QEm4dBVzGi4AjzOYArFEOYMLXvIwdhIYpQ27QIZCvFBilCjx+W8G6RiBfFYof9gyChbjp9r8qOq+i9qTEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6uzRhqd; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6uzRhqd"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b2237b596cso898538a12.0
        for <git@vger.kernel.org>; Sat, 17 Oct 2026 02:35:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792229712; cv=none;
        d=google.com; s=arc-20260327;
        b=ovTHPqSbHhm0Nw/KOE2F0fFhTMcG5GCmrPhvp6z+dlE1KPYrA/F0ASwYRhstfIajz6
         qzrqz1wvhZ/8b4Huh/G+6ulCLdhOpasbKDZtX2aa3UY+2rQIX+XtykKiDIbtAu9iQNHN
         wt4nLSzjflJMFHBiDV972TuVQzWDaV3bKlOpuMjJXuCEDrAroOAzSZsg08+C4k7Tk/91
         sBlIiYOLPUbIJkD0Gn6yrACfM9pMOtJh4xcAuUFbXZaXjPFIZOfDp+xVtFGqEhC3vzzm
         eNdqkR8CnBvJnZYLmxxOyAhbisJAoO1vj/0GiW5kqq1mJJ6w/KTp8TC2CYd5dY0+UMJX
         3HDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=sKwBIwvkr/zsyL450jMjqn+mioZm7h3bj4HHg/U18Hw=;
        fh=fGSJMDFrkkEDNS6+QfBczVJpie+hBE0ZP2ZqquOXZKM=;
        b=hVrbPsR8GB+ijfNxOUxy5gQ0Lm4ufHBOq1TFJ3HzXj2cTBHG/MVis31BSzDMpFBd4t
         b9Tm2EycY4rUWH1QjL4waE3Jw8j7gJZgrN4jtU8vBdaWBfItT8ZkYVgDCm89RUSeBCs9
         Su9MK3ytKelUp0aqNe19MiHEAn/Ga6EGMkxo8UGYuPR0GF+lAA7Xt+OyYaqk+LiaAukE
         0n0nlY8gtmcU2X2JCP7WMt1OZlgetI967U/osi6UuJQS1WPIi0ozj6EwY6UX1DW4YepS
         /ME70V241L+ZX/xxWTXrfZqbFLOoJfv5hKfvSvPq0F2OY7aDga9jP/W7Y0UhYEUvO1Tz
         LlEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792229712; x=1792834512; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sKwBIwvkr/zsyL450jMjqn+mioZm7h3bj4HHg/U18Hw=;
        b=Y6uzRhqdqCwSs97ZJSuEcwN0sTEZtuG2mTxgg1rSLWRyrtYipNvCFSoB22nq/pkpX4
         zPXMjeAMq8B+7BBAFMJuExPL4MLtXEocwOzj5aaemOcC87aLiGhipAjfL7L57vS2ITw+
         WgXetyocGNSqKAl89yo7sy+jk3OVVdBCZ/Dg5pLa+RhPQBAT/IN0/CmU9RjUNoQscKr1
         BHGU54r+XeJD09TLVWz8TQnQS3SiW6ysFzvrtiAtWD5/Y46Rd8bOnsvGRmR3yJJ1glVr
         wKYbhmXUV/fMkBPKbCwU920hWdBj9lm8sv7MKKUAFA9up3L8oWmwl+2CvH1DLLc1zBp8
         9mTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792229712; x=1792834512;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sKwBIwvkr/zsyL450jMjqn+mioZm7h3bj4HHg/U18Hw=;
        b=d1O0IsbFyrdjZrDJuOnoc98obBUzC3iPoYRctWwMiNM/IDt88FrBOykwDTDzRBVr8n
         eicNWhg3RXl9jc6BknbDnNlRG9Cz7frSRt6eDNxZbImMXFj36Z0wLiwhvw48DRj7oNWV
         40Iy9wWMHzRcBn20wciHvIcLacFhIuu0ECMrf6r/BjcbLnKKFfzeaE0bC27U4u0czbw1
         ZR4JvN8tOVS3F+cjjF8lhZGPC2IpUMbkhj1e3PisaOVMjK3pnSbIj0fC5rXbSsjFtVmb
         /DJ9o0UFzsEsoHJEjxyuNDz9QAgVgCBB1kHZCYOEaYWg7pEv2ZkX2LDLadhuoMNiWfFs
         GkGg==
X-Gm-Message-State: AFq9FYL67/asSKUK+d7nALinWx/Kmr0qrKm4RQcXCQI0upMb47acOjG1
	n28tPj+MJAVG55kLCE0IIuJ+BiOnNSxhEPG/ByC9ALFsdJEabqHCMYrQaK+AjgyFiTvApSPNh4A
	6V9Ob7G6JcPuf5R8McFb3DSwSbWNdlIET4qRILOpCkg==
X-Gm-Gg: AYBFou1k7l+fGoi+ehzGuLLNRbqswZFBNl2/Iqy3MfdAZDDdBs7uRVb/yfwHyGM7PQQ
	BqJixUHrArZ5BGfHdaRG23ZpqrAZZ+8Ae+86ErCzUjTOlst6crl/kD4anIB73dhBerLEz2qqaBU
	zvfq1DcxPyg+rRhSE3XYTnNuLByPvc1AJTn/C88vzN96eWD0PcTaa09DB9I8ZHvE+L6SXHpybTM
	PIL+35FYoHWNevorZAxiuGmxDgQuzI+3t7zO4zmm7f0bl1uJRyLiIcyWSIWINFciT6N/5DQqkmn
	7WIddAuLIenGMBYZ4m9y1xz42PQie7AINz7Y/xdIY7CDYX++V5ds77Ug2xNfKjqwUs5CxvnBgdl
	5/G1fGkgvss0=
X-Received: by 2002:a05:6402:2b90:b0:6af:80c4:8981 with SMTP id
 4fb4d7f45d1cf-6b3a81d3128mr1327771a12.26.1792229711564; Sat, 17 Oct 2026
 02:35:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Muritala Mudi <ibnmuhyideen95@gmail.com>
Date: Sat, 17 Oct 2026 10:34:59 +0100
X-Gm-Features: AclHuK976cCtSpMg45soarmzrsHPgcx43ooAMg-CP1pMHLjt6DgMdNVGa4HIWmo
Message-ID: <CAO=0-S4jSCbYvLPVdL9U=6PPn2w-apMaGpQaOF_AuDN7n1v3JQ@mail.gmail.com>
Subject: [Outreachy] Introduction: Muritala Mudi
To: git@vger.kernel.org
Cc: christian.couder@gmail.com, 
	Siddharth Asthana <siddharthasthana31@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi everyone,

I am Muritala Mudi, you can call me Mudi and my pronouns are he/him.

I am an Outreachy applicant for the December 2026 round, I meet the
Outreachy eligibility rules and received an email approving my
application on October 14. After looking at the projects available I
got interested in the =E2=80=9CImprove how command arguments and options ar=
e
scanned and parsed=E2=80=9D under Git.

I first learned C when I started learning to code with ALX Africa and
that made me want to go back and learn how low-level languages like C
work.

I built Git from the source, I ran the parse-options tests (t0040) and
worked through MyFirstContribution up to the parse-options section.
I=E2=80=99m now looking for a microproject related to option parsing and I
will share my plan moving forward. I=E2=80=99m happy to be part of this Git
community.

Regards,
Mudi
