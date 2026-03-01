Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7947E20CCDC
	for <git@vger.kernel.org>; Sun,  1 Mar 2026 05:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772343916; cv=pass; b=K5EqtwRnRTPfEPuzPXuHWZAgD6RhzAEMHxzf8aOfqIyGiHRT9anPoHW+atpICefgHk5xlH3/luBzVH2zHG0YusT7zmgcP3Zo0ze7OHo0dfUubMkdlWHh+6yTEdB+D0R+rvwe9IwAbI/ZhyVrQ87GoL01nSh9KHK+Av48f2vTWew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772343916; c=relaxed/simple;
	bh=8cjoUM3+zoqwNvvKMlcOUQ4UxLKmW6SO7MnOLD+wd9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a9vqj5QuAZyBNNMjFUjB2Ae2JUcIo7qXIPZyN3C/O7Q94p60iFwyk5dqnmqcreFsiv+lOyK1r2+rqnN629dJjQ6uFg9QR90jXyZL/IAyUremJBm35EsiWOOIvn/ST+6mPib9B6wAH8/CaC6sPu98YyzB3gmklMPkxvCrJd3rli4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QVhFk5IB; arc=pass smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVhFk5IB"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-389e4330e32so48876201fa.0
        for <git@vger.kernel.org>; Sat, 28 Feb 2026 21:45:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772343913; cv=none;
        d=google.com; s=arc-20240605;
        b=irME8jjYO3ycpdDjeffltAvPFqvMp0N0ia4UEubAuRWDXAsurtOa+QRahdiQ14oLFW
         cNLFe7Jiwv5rE/sRSBjVejXniUwWLDEGrc6/kaO6qlXooLoQqwZidSsI+U3wan2mThwZ
         6aZH/FYkIbEdPzlNebETUK61d2MV6zGRkA+bgXb7QdNd1cuxmRwB01KqHrFdTjlgKjN3
         Pq0Jj/B/yonmBIoXcrpk+1feJrudEm7LuNS12IYp6TbFBvpeP8oZp1mSLWRHD2UCyqgX
         qdLbutSMElG/q+RtqHtNEyqeiEtG6HfbEpFztJmn22xVkwQlGOIHqHMfy61lrCvF/NWr
         Nsmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nfR5/X3OYvrIWLzsm1J9OC1Gw06//nS1mu6sNfFZ1lY=;
        fh=O1v6St9G/Wi/DrzbsDmHBalcIOdtsUQ0YHnG2CJfrrs=;
        b=I46vaXbIrL83rQSzEqrC3qxFSjWuksKepgpiMhrrVjFME/MwrZfEg23cnf8jzRQqXy
         oOKBxa7eRoH1s4GQxDHGmPV32q0aaqa6F4EVhqcVII7SL3Iv1DkBYp+iLjOqaqCxHO72
         WucWS0DFWOeaUoDtxnWTzRgvGaDarDjbFfoXRnS0SkokE1q2BKBqImxgmr4TPVLcneQe
         iD0XKK/Tc19uK1J+ZqmMnqePqLHVAXkacqRbKvbR+vyXu0z6Sdn/Q/V7Y8suLqLsqTKK
         nZTZj2p6MCvHkAduiOK8qqF1YNfG8xoLFPCpcFKGOhcyd/hKmAhPUA1F8cXPsNRKj0cx
         nhHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772343913; x=1772948713; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nfR5/X3OYvrIWLzsm1J9OC1Gw06//nS1mu6sNfFZ1lY=;
        b=QVhFk5IB1w0vgaVrOEl/Ll+7MicyLVson0Vu98GBwqvbv+A33AkTZHgAR/QVrX2JEa
         BrVlV2ZLMB2hSDBgIJXWvmPTF7eYzveHzoHJxIJgiZ5zuuuRnOjOy1KvLKKkyId+PyUd
         iEXyd6ijwaqb4oxVOHZzsClaVdQhQ6yY1I1H7/mcPOnoAX+arL0lg2cIuDQu3jpGO2tk
         ozVTr2hqawsWzVN1wdU6yjOPDcHam5XrTUoONOaEV2N/3z9fTh6a7NlcPbzLfQOUvkUZ
         z732QRI97pNHweqXYSha2P5PJ+eU9fsUDosNHvKfXNKesfgFGfR8kCzoAwklAEz/v5xb
         fW/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772343913; x=1772948713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nfR5/X3OYvrIWLzsm1J9OC1Gw06//nS1mu6sNfFZ1lY=;
        b=BY/or1ziUG6hF9ZBdXjmigF+SJAaca/nP+75WEjD2QhUar39YPFvmj8UfC1GtDSSzM
         O6Eb4X1AvQDXgP9u7IQ/fdcplvELvnrNV/6gUs3MwaOvCrTsZGYp5Q7z4uHQVvi8jOp7
         4fwWhDsmjNIxS0Cfjcvt3FMmtZyZZqRs45BcJePxOGiraSKqj0OJIAQwsEwhTA+2Yss2
         h2OZScFI6q5YUrSjyMX4+GiOV/a0lmHP2iX8rxbyoZKUScyIDqRPaDi8+2VNEGkBSOk8
         uTp1/nI8nX4rJh7dcO1pakVRvd4XC2hhzAxBttBeSmX22k2XQ4rF6ibz7sZrJ/lzgBXJ
         KjrA==
X-Forwarded-Encrypted: i=1; AJvYcCWKXkHW1rbZor7543zZ6IzDEjym1jO7EnscJNcicg+7JYg3JQKVCdhkqK/dlCfVCi6AB5w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0PqLb2nSJOd044AYWAMsNNNqIJ6xqgSTj8DLVCQHtDFYr+8oy
	Bz6AHhR1KymOl/yBueTWS7SFT7b6mn46e7axGMAUVXPLZvaao/yQyuRIynmFDS56Ea5mSykEtN3
	4tgVQazyMVx8o2lYltzR+V+prmvShaEY=
X-Gm-Gg: ATEYQzz1M/Pum7q/RFAfXQKaakk2h3dbUlF5qZffvMxrbhk9Bis8RxjK/OAqP2ESVYZ
	0ZXYK/29r9/PzcUeJyszYMtCWBn5j4wR5t2E7Y+gUOh0DBaNm6YpVGw3ablh7GAusajcuQGky2O
	7zOZOYSWYztBrnBjp7LQWKQCt3cPdFnfHcAvuATmawWtTyh/wcMYpb1r0FqFwy5MDVsKNsAP6Vv
	A/l1bnKzqIFDJ5fVZIvJzZ6SMd6bATxdrPI+qDOZlBerHBsQ6Ckmsm8VycH8pcVkzBom4FGSIT7
	8+i/svsH+Ayi4nmvuzzq
X-Received: by 2002:a2e:be0a:0:b0:37c:c84a:98f5 with SMTP id
 38308e7fff4ca-389ff08bf5amr52885041fa.0.1772343912297; Sat, 28 Feb 2026
 21:45:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260228224252.72788-1-lucasseikioshiro@gmail.com> <CA+rGoLdTc2caDUsQedpegL+T4MqwwiA62uuDSFSawAT5vcPvWQ@mail.gmail.com>
In-Reply-To: <CA+rGoLdTc2caDUsQedpegL+T4MqwwiA62uuDSFSawAT5vcPvWQ@mail.gmail.com>
From: Ayush Jha <kumarayushjha123@gmail.com>
Date: Sun, 1 Mar 2026 11:15:01 +0530
X-Gm-Features: AaiRm53haTzwpsQB5pL6GQrXKDKT1DTt8fOHV8vcPhu3BWtwo6QpG1MVgcd3ojg
Message-ID: <CAFNBzOdCx=R3r9+m5eDyAykMAbmbcfpX3kPeEPjqXPYT-_89+g@mail.gmail.com>
Subject: Re: [PATCH 0/4] repo: add support for path-related fields
To: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, git@vger.kernel.org, 
	sandals@crustytoothpaste.net, a3205153416@gmail.com, valusoutrik@gmail.com, 
	pushkarkumarsingh1970@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lucas,

Thanks for sharing this series =E2=80=94 moving the path formatting logic i=
nto
path.c makes a lot of sense and avoids duplication with rev-parse.

Regarding the limitation you mentioned about not being able to mix
relative and absolute paths within the same invocation, I was
wondering whether it might be worth considering making the path format
part of the key itself, rather than controlled by a global flag.

For example, something along the lines of:
path.toplevel
path.absolute.toplevel
path.relative.toplevel

This could allow users to request different formats in a single call
without introducing global state into the command output.
That said, I=E2=80=99m not sure whether this would complicate the key
namespace too much, or whether maintaining parity with rev-parse
semantics is preferable for consistency.

I=E2=80=99d be interested to hear your thoughts on this trade-off.

Best,
Ayush

On Sun, Mar 1, 2026 at 8:28=E2=80=AFAM JAYATHEERTH K
<jayatheerthkulkarni2005@gmail.com> wrote:
>
> On Sun, Mar 1, 2026 at 4:14=E2=80=AFAM Lucas Seiki Oshiro
> <lucasseikioshiro@gmail.com> wrote:
> >
> > Hi!
> >
>
> Hey Lucas,
>
> > This patch series adds support for path-related fields in repo-info, ba=
sed on
> > what we already have in git-rev-parse:
> >
> > 1. The two first patches moves the path formatting used by git-rev-pars=
e to
> >    path.c. This will allow us to reuse this code in git-repo-info
> > 2. The second patch add a new flag --path-format to git-repo-info, simi=
lar to
> >    the flag of git-rev-parse with the same name
> > 3. Add the new field `path.toplevel` as a proof of concept.
> >
> > This arises from the fact that I didn't know what should be the default=
 behavior
> > of git-repo-info when dealing with paths. Some ideas were:
> >
> > 1. Add --path-format, just like we have in git-rev-parse
> > 2. Use what rev-parse uses by default
> > 3. Add keys for both relative and absolute formats
> >
> > In this case, I'm using 1, but I'm not sure if it's the best option. On=
e
> > downside that I see here is that git-repo-info won't be able to return
> > a relative and an absolute path for different keys in the same call.
> >
>
> Option 1 feels like the cleanest approach.
> Even though it means git-repo-info can't return both a relative and
> absolute path in the exact same call, it keeps the API highly predictable
> for scripting without bloating the key namespace (which Option 3 would do=
).
>
> The behaviour is different when compared to the command itself where we
> have to use --all, but I think in this area this is the right approach.
>
> > Since there are many people interested in contributing to git-repo-info=
, I'll
> > leave the remaining path-related fields to them :-)
> >
>
> Thank you ;)
>
> > I'm CC'ing here:
> >
> > - brian, who was the original author of the `print_path` [1]
> > - Ayush, Tian, Jayatheerth, Soutrik and Pushkar, since they expressed i=
nterested
> >   in contributing to git-repo-info in GSoC. (I hope that I didn't forge=
t anyone)
> >
> > This patch is based on top of master 2cc7191751 (The 8th batch, 2026-02=
-27) with
> > lo/repo-leftover-bits merged.
>
>
> This provides a fantastic foundation.
> I have updated my GSoC proposal based on these patches to build out
> the remaining path.* keys, alongside category-based querying and
> global state removal.
>
> I will be sending that in a completely new thread shortly.
>
> Regards
> - Jayatheerth
