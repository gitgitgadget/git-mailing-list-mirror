Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4FE40E8C7
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 13:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781012439; cv=pass; b=s+2WieUxreJVvPJrU/n+ynO/a/T7gD8GUdES5GQeuNzrrC9W/g9FwJO783U2ONumfpkqDTqkAglB2JOplnAckugsohELQ4gbqjqc8D1ir6OfaeHPux8iWgv79HQ2HRQn/9jAx1o4knudVfy4XiVdDIPb/EhZDxQG4H08uA+XGAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781012439; c=relaxed/simple;
	bh=O17XpNvFlLhKuQATNfm+erEw81NBhfxrDw/c002O0O0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RSsZsam2rfi8eu2n1znwl4IjILhFpMEemsecK3SYnExRynYbYWJE3hz02gm74jiUavoqsYic/0T5OWcP9OoHJUhkeHCDYUbmMjZ6JlQaLbSw9VT/QZS1n6f7OIAlNPO/RfQaiJvjVs+wS8Qg1xfeuyL2lq14RJ8sYefCXj1ClxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gUnSXeUt; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUnSXeUt"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c0a5354da1so45207805ad.0
        for <git@vger.kernel.org>; Tue, 09 Jun 2026 06:40:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781012437; cv=none;
        d=google.com; s=arc-20240605;
        b=D5XNbFs0wHi8WoEEYXKOhdF99nUv5RJhavE5NAgi9rLnOApbdGje1EoWHPW6Fnk2o9
         hwB4AxUK+jOHXsTPN+PQDCZzQSndfRSEQuILPr+500T0yaMJPmB0kKGqCckxocD8e+w1
         1PAUWs5NnJDsrFtp9QN1qB+YzSg/xLs74IAIEcAaSVeK3pxI8Rxl2uLmrtlivLMImzvH
         nyYDXN3iHNxr47lab/blkl408SL9vF2NpWR6DAEINqug0ZI4d4++4BsrMUGei1SvvfiV
         4fWV5y1wwgi6WGcZqpknEyZG50xiueGTLol5zqA+FRPeZSXr/ym3ebpwfiI21XzzhkJL
         CfYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xLq6WwQUncSh7BuuXAmslfmdXebJjteY7L29XupZ9ME=;
        fh=vpX6dGd0DGtpCDUvNN26/bWuOlASen2kK7WkZ6OCW74=;
        b=ZVM/hld4sO8TJYUwfbBeI2TXuFEcXOn4RNQozay4eshStJG7wbxqHpZk0auwiwEvj0
         wkEifkJJPIwcwJViIeeHmXGb3DydGBjgmcNtAZlO4Z1AGpVCzFKoT6jqwqVFObRiHr2P
         c/vwaVPhMNVw0Xu2J1KexxkSvoZ5DQEDiJToEwi9JiJ1vswPMr8V3Zxn3rlDa6HPJYPP
         SbTRAqQMhXaQ/rJJTv/iOoT3ANjHZR42MuR0bAQ0r4PSaKpOX5Q3OvgerPIT6WwiU+lj
         68yWpkyuqXQs2hey8kYqOqdcSTFsEBL8UBTN8NMfgG2t7xI5mczr/MeRjs4peA8PpmPN
         T5VA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781012437; x=1781617237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xLq6WwQUncSh7BuuXAmslfmdXebJjteY7L29XupZ9ME=;
        b=gUnSXeUtnw5GaV9f93nxJsXeW1juLwaZ22fOOtbfk6zRRiXdif1MNMBHGr09ZvZV1c
         V4UBBl+rGXHy0IBT6p8hCn4WqcfAqr2LmiFPhG1VikC/jg4sWmNwN3+FRUBjCpREddSL
         CwRA7wl6R2Z95z3irg4usat7AsFeFq4OcKnxOPQdAu5lkq/QCPs2X3zZ2POJxPTnehed
         arHw0BC2JHRIKAhgGj//QTOEijWIbXwNdp6WU0FQI69UWw2Ew0BOhQYzUYXPX2sViMG7
         vXlLrLFMKTGBsUV4of66VFk5abOrrVcm1nna6pl++cvHBMxWN0MWUxAHkXtFKXipcsQE
         9euQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781012437; x=1781617237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xLq6WwQUncSh7BuuXAmslfmdXebJjteY7L29XupZ9ME=;
        b=FSj9RrdTExTWBMYDeI2yqMmWCRG9Fay91XWfHyFhTh8M9LNNvYI0qgHEydZcwJZOBr
         KDZSqMJBS7IrvyMLHiHDd0slbuxGlLmh4S3GKrxkwZwSqDRCILcP7SdcMvoueL0ksjAy
         3gjSyCPb0T792frYG36lfAno2ki67B1IADqP8HXAwltjr+zUg6Ym9p+b1Vc8dT8A5Lpi
         bPcXZvg1jl8Tp7vFkcYSSo175GA/PFQZEGw6tdU/JZGyp1NkxvHYTLpvpXi4iMy5q9Bj
         dWzKef2SXQm3vUVxPG9YWlyI2mRcLtVDGZUkYAAai3PQbDDm4g3s2Ou488lPAZQyytEg
         VUSg==
X-Forwarded-Encrypted: i=1; AFNElJ8viIbb5vl1sHNxbpWEaH0YbslMngQTV0F3DmpGVhBb4iN6QTy1wHL3B3X6J5haYugXkiY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNo0ZPipqAjv472FWx7ngW3yTcF6PHHjhZwd3ZR4/hFp6vdjTY
	Uh69nLwNJfQRvzOIpB5MgD68dNwvhH1ARHHpj6RQk8q4pZrrSUPtTrxhRtTQ1Mcb5csNBUgqpPB
	BrcISdZqZyXv2g4DMtHYKv2R89q0Lodw=
X-Gm-Gg: Acq92OG7miDKfqex0SWzXnwMUDFf1Ds5S8zfSP2vh2YdAWG1oLPG0/LOiUwTr2ctMSW
	Qhna1gLchaizRr+4YNTTbgfIUki6tW9AMspecj4wo8A39iik3Jj4+bTW8ZGRY0nRXwZ8Syq2QBT
	yz0GL40hZKjEOPK69TnXtKGi//W84qmqBx2Z+ut5MzX9WJsoUKzMKumiXzY8C5gnTOsVIxoiAVr
	qtrhHMpXGhZPIcW8vftVyjrpUzO43OadOVrx647OFXr6LpJNUm9UgqusKyMkwx/OW2bvB6Nl8rO
	DwXlg5aDj1aAGWWpgNTItd18DXRpCEA9I6WjumSrNRlYS2OD8ELchYZFjLvA3XGw5cXeTSvGBbK
	NVBoAXGlDQx79jY1lEFXgQjJKYwRZyWGfInh1Ww==
X-Received: by 2002:a17:902:d2cd:b0:2c0:b74f:a58c with SMTP id
 d9443c01a7336-2c1ec7972e4mr169860485ad.16.1781012437482; Tue, 09 Jun 2026
 06:40:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608-describe-tag-ref-scope-v2-1-256fd36dca32@gmail.com> <20260609110957.GB1509396@coredump.intra.peff.net>
In-Reply-To: <20260609110957.GB1509396@coredump.intra.peff.net>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 9 Jun 2026 09:40:25 -0400
X-Gm-Features: AVVi8CcGA97kFv7nggxFJEId5cBXQ1Dc5GiWxIhvw06bW2Uqs7lXH7r2YaELOo4
Message-ID: <CALnO6CB-9a=P4Os90978YzEH=3iYEHwSbG2oLv9sxVBjBfchMA@mail.gmail.com>
Subject: Re: [PATCH v2] describe: limit default ref iteration to tags
To: Jeff King <peff@peff.net>
Cc: Tamir Duberstein <tamird@gmail.com>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 9, 2026 at 7:10=E2=80=AFAM Jeff King <peff@peff.net> wrote:
>
> On Mon, Jun 08, 2026 at 07:32:14PM -0700, Tamir Duberstein wrote:
>
> > The benchmark checkout had 120,532 refs, of which 330 were tags. With
> > `$repo` naming the checkout, `$commit` an exactly tagged commit, and
> > `$parent` and `$this` the two binaries, I ran:
> >
> >     hyperfine --warmup 3 --runs 15 \
> >         --command-name parent \
> >         '$parent -C $repo describe --exact-match $commit' \
> >         --command-name 'this commit' \
> >         '$this -C $repo describe --exact-match $commit'
> >
> > The results were:
> >
> >     Benchmark 1: parent
> >       Time (mean =C2=B1 =CF=83):     171.7 ms =C2=B1  18.5 ms    [User:=
 23.9 ms, System: 133.6 ms]
> >       Range (min =E2=80=A6 max):   142.3 ms =E2=80=A6 198.3 ms    15 ru=
ns
> >
> >     Benchmark 2: this commit
> >       Time (mean =C2=B1 =CF=83):       9.9 ms =C2=B1   1.1 ms    [User:=
 3.3 ms, System: 4.7 ms]
> >       Range (min =E2=80=A6 max):     8.8 ms =E2=80=A6  13.1 ms    15 ru=
ns
> >
> >     Summary
> >       this commit ran
> >        17.35 =C2=B1 2.63 times faster than parent
> >
> > Both revisions were built with -O3, -mcpu=3Dnative, and ThinLTO using
> > Apple clang 21.0.0 on macOS 26.5. The machine was a MacBook Pro
> > (Mac16,6) with a 16-core Apple M4 Max (12 performance and four
> > efficiency cores) and 128 GB RAM.
>
> This patch looks fine to me, but let me pick a nit for a minute, because
> I think there is a broader conversation to be had.
>
> Given the discussion in earlier rounds and sibling topics, I assume the
> commit message here was AI-generated. And it's OK in the sense that it
> is describing what happened and I assume is entirely accurate. But as a
> human reader, it feels so much more verbose than what I'd expect, as it
> is full of semi-irrelevant details. Why set --warmup and --runs? Why
> bother with --command-name, which just means you have to show the
> commands separately anyway? Is the amount of RAM in the machine
> important for this test? Surely it could be if it was absurdly tiny, but
> in general, no, I would not expect it to be.

[You probably know this] It is common in academic papers to report
benchmarks with details about the hardware and how they were run to
contextualize the results and help with reproducibility.

Of course, Git's commits do not form an academic paper=E2=80=A6 so I have n=
o
real opinion on what to see here. But I've seen a few other mails
where having perf test outputs or similar was suggested (maybe that
was to be reserved for the cover letter? idk).

_If_ we show all the hyperfine details, I think it's reasonable to use
--command-name to make distinguishing the versions easy, unless it's
obvious from the path/to/git in each benchmark (which I think I've
seen from Peff's benchmark reports before?).

Someone with better lore skills can probably dig up a few exemplars of
how to write about performance in a commit message?

--=20
D. Ben Knoble
