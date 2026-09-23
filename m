Received: from mail-vs2-f43.google.com (mail-vs2-f43.google.com [74.125.227.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631EF46982D
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 12:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790167425; cv=pass; b=sNfIlsweVN4drKipAcJBUBwpGnYM5xdOVUh/EXyzFgWQypmNUvXvxv8JSYuMuzGKDcrdW874pu4bfc6zamT0AU30UPwyQQL2RYeUxddivjamwZBgOSv1fZSSFiBPQ9e4PLaJ+daWDu4zOPtNKwJbFFpD+ox1lO//zhi0YzqPLXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790167425; c=relaxed/simple;
	bh=lxNKouB+XDINj1G2bNRzq/B79n7z9o3pJx8kn0SqUS4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R+ixtxXcFVpFrVQ62hIWk1fLX5Dd1F2nAhlKsFXbajzAVLP76+2H05hqmZ38MQReRbwBR2IYvuuV6LswYFuFPVDZByzcAtKM8KJIBylsj665RL2QJENg1r26BYaGJt/rxUdj6SHadCpXIPN2vh2EOYZ9rRVL/T6jDhMnOn7N85U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Op7HwVRG; arc=pass smtp.client-ip=74.125.227.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Op7HwVRG"
Received: by mail-vs2-f43.google.com with SMTP id ada2fe7eead31-78565a41a19so300653137.1
        for <git@vger.kernel.org>; Wed, 23 Sep 2026 05:43:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790167423; cv=none;
        d=google.com; s=arc-20260327;
        b=e4RTuAm4TLYj+ixnfGzvhnJwJy7rEDa6AzjouG5xbfAu24OehIUzKiVEZWIeZjTPL1
         4ZXk/1sRGpZOJQli7RTnXEhqQGzlpsOzTEHJmmI9lYaHU9xbgwBzshPIpNNmKT7Pm22S
         Nk1d1ZXUbBHpDGPao1t71G3hZMah/zhKS9WAWB98VJRSrSAIDYV647MUXE9Iyu8OePHA
         paPsaXw1/xUCPcluFFT9sVv4nKsJc1ATc3Deg/mqUFbvvNVA3o2FdlERH0nqa+TCMfYG
         CAVcXaGbAJmY5tbrHfsptb0v8ardpxDzihXMoHGj11AgNYujnrgKW1SVkZWYPbe4Iluu
         5boA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=lxNKouB+XDINj1G2bNRzq/B79n7z9o3pJx8kn0SqUS4=;
        fh=A5IkmViW+lbRqHGxdZGGWOG8E5y97aTd5WBKr/o1D1k=;
        b=GodpyMQC4ce2mBIb4IzbiQ2qtw9AHKK4sHJ3R7P9FbCZ+Qxanwx6ImprW16dJjLYmo
         HFhl/7aBwWZQ3wHQJyq81ruxTATYIH+5d9kPWC80lK3SqsG1hWGbnCT7haJqO0VljNIs
         wRAkty1xEB2aH6WPKgQjTVMBrVdvt7t0bRavwql3PLMjN8iX6K/lyO9xYOiFD8ztC8r0
         EJhZpWQNrN93McmVNnRO48gwHYi0aFkhEqLkvV2kZ6R+gvZGxYfdVoRSPgK0yEjnQh4r
         5YagmYTFzyf6wb/dvizB879zj7dF21jEOhQODwV+Ek4PEq+k5Xubdrvh0w2tfmv9HKu+
         4iWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790167423; x=1790772223; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lxNKouB+XDINj1G2bNRzq/B79n7z9o3pJx8kn0SqUS4=;
        b=Op7HwVRGlKpoEPCWxSRuzdpe2y75Lg2puzX0brV4Ea1Kgqn/HSlhxsxlLryflPvkne
         23ulVbaGLSPU+4tFO0LYENJ5FA/+AYHUfOtgaoa6ITN0esb1duKp82S9fkzFlA/H8DwN
         VVzqFG2eFqfS8jegIDK8BonM0hyjed6W9kZ6eim9DihBeQTxSaduksUXv40jZc5Owg0K
         n7UiPD93q2CeVQynjb80egG+EO1UTDXR4pfX21V2x+Lir4Kbuw/udNznMfS/jsIIwGTy
         ffgDPO3n5lvJzCuZsXk3wXCo00XE1icsKVW/wcFTHOSCsGsYj4JnPGRFpPfq2BgE/Sgl
         tdgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790167423; x=1790772223;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lxNKouB+XDINj1G2bNRzq/B79n7z9o3pJx8kn0SqUS4=;
        b=H1WHqxNg5O2W2GR1qvxMqs46+00pEAYfLrVVIxWBvLq8KWXFhaR6GRr+E6vubWG3nZ
         8dC/GYWElCUGsrpDEq194wFh39ZZpSbT0w4M2W/XQAvHdoN8w7q9GHMqlbje2pjZXhJJ
         KAj7irEAJhSUxq8wVndOOrC+jOcevjaAwP+dqmPv0BjjBFF6uZJuL7A1J5DBdvPa57BP
         M/Ujs2Zt/ogDIhtl2XfMEeZ8OkdCFfw7o/hA1Rz5pG2CAC3X4YbheZGAWyylsQ7SLtuB
         wqOhe03xHgc5LY8uriDri/30bPLqkz/DIFS3/ZqoP5XsY0ef/jWx7FeND/SwpBKb63c1
         zJCw==
X-Forwarded-Encrypted: i=1; AKwUvBy42JaH+++f9Dc27PnacL+nLyBJ7n5kzNYFp6owPE/hSKGd/1UAXaWM7q4OZte4Ax3dM+s=@vger.kernel.org
X-Gm-Message-State: AFuF++mvf9Ja1vQiYWpFZev6tczNFHHGFl/i8nwt8ltuR4TbuTlkzZcf
	dB/DsedDt2Zh7BCsFWwMGRcohuoF5Vhhj8EBkKdZa2cZ9qSusm3YP2gezCNzXCs4/+8lFTAXR05
	WCLgYJw8npVvwyvqLgs3rCqO6KN3aRAw=
X-Gm-Gg: AYBFou2+N0oGkQK4/SjBkvVdckZjLzsLLe3iKYfCfCtUUqRkGcgBlnXbNWVdtv4Agi5
	WPlGTr9OQ3FbS5p21S7bz3IBBpWJ/V3squ8pEkrict6/aOlYTKsI4ANseEPOzD8IM9qr5Ws020G
	4IgKAz7/IvwNR8PYLcsP7now2YRk03wNUlLUNsOGy/rAuevIwsJqYGtzD3olvDNNGipOaOlCmV9
	1aO2geThZ7zQJitaf/t7Cc9eAOT4iXXw1HQS3GLMq6ptTjSoBaDDukfWvZ38tbD4sHsuWQpM2wa
	hMeqvETY4bgEV6CYR/g8c103giMCVYyN2UZw55Mc93dKf3z7BL17TWrZLfJ/xv85y/YkTC/RFs8
	fOVPL0FTJ2PEFOGjAgIns0hf19YqjRn8awEqprW+eAYgBwg==
X-Received: by 2002:a05:6102:290b:b0:7a7:198a:c2c5 with SMTP id
 ada2fe7eead31-7ac1ea9459cmr2291665137.35.1790167423196; Wed, 23 Sep 2026
 05:43:43 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 23 Sep 2026 05:43:42 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 23 Sep 2026 05:43:42 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <cd4dc991-0791-c4b7-19d1-c45018ccc119@gmx.de>
References: <pull.2233.git.1789819933.gitgitgadget@gmail.com>
 <CAOLa=ZTgF+Qw_1FMUEF-YyBYo-gKnhPVk+qxd+gt1PMrt9GYqQ@mail.gmail.com>
 <6c2bba91-a1a9-3547-4be3-f4f9ce03e696@gmx.de> <CAOLa=ZQkJui77Xz2HL4sAWsaYLAzU6EPvBk+RzKkKxoiY_8aKw@mail.gmail.com>
 <cd4dc991-0791-c4b7-19d1-c45018ccc119@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 23 Sep 2026 05:43:42 -0700
X-Gm-Features: AclHuK9N_VgclL49a6EE5hdJQ3FlOlMcFgdv7wL4zxNFmBWIdaG7TlqGGAKXkE8
Message-ID: <CAOLa=ZSnKsqm1Mt6t1nYO8-yWpwB6OZiQBK3Outr=EPaxBep-Q@mail.gmail.com>
Subject: Re: [PATCH 0/4] gitlab-ci: fix the cargo invocation in the Windows job
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: multipart/mixed; boundary="000000000000596ec1065c25d5b8"

--000000000000596ec1065c25d5b8
Content-Type: text/plain; charset="UTF-8"

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Karthik,
>
> On Mon, 21 Sep 2026, Karthik Nayak wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>
>> > On Sun, 20 Sep 2026, Karthik Nayak wrote:
>> >
>> >> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> >>
>> >> > In https://lore.kernel.org/git/xmqq8q4zosri.fsf@gitster.g/, Junio mentioned
>> >> > that the GitLab CI seems broken since I enabled Rust in the Windows-based CI
>> >> > jobs. This patch series should fix it (lightly tested, but I don't have a
>> >> > whole lot of build minutes on GitLab).
>> >> >
>> >>
>> >> I've created an MR [1] on our team repo for testing, I'll try to update
>> >> with newer versions (if any). The pipeline for this version is here [2].
>> >>
>> >> [1]: https://gitlab.com/gitlab-org/git/-/merge_requests/671
>> >> [2]: https://gitlab.com/gitlab-org/git/-/pipelines/2863888081
>> >
>> > Thank you!
>> >
>> > It looks as if the `build:mingw64` job succeeded, as planned (although it
>> > should now probably say `build:ucrt64`?).
>> >
>> > The `build:msvc-meson` job seems to have timed out trying to do something
>> > with credentials, though...
>>
>> Re-ran the job and it seems to now run as expected.
>
> Seems that now some `test:msvc-meson` jobs failed. I had a closer look:
> the failures happened during the cleanup phase. Apparently there is a
> problematic change in the Runner image:
>
> All failing jobs used Runner 19.4.0~pre.2085.g4d3dddee. Its cleanup code
> (https://gitlab.com/gitlab-org/gitlab-runner/-/blob/4d3dddee/shells/abstract.go#L2081)
> calls `writeClearGitCredentials()`, which runs `git credential reject`:
> https://gitlab.com/gitlab-org/gitlab-runner/-/blob/4d3dddee/shells/abstract.go#L758
>
> However, this `git credential reject` then calls _Git Credential Manager_,
> which assumes that it is running interactively. And that there is anything
> to reject. And therefore it waits for the user to react to the open
> dialog, but there is no user, so it times out after two hours.
>
> The successfully-retried build
> (https://gitlab.com/gitlab-org/git/-/jobs/16625727899) and the passing
> test slice 3 (https://gitlab.com/gitlab-org/git/-/jobs/16604448474) used
> Runner **18.8.0**, whose cleanup code
> (https://gitlab.com/gitlab-org/gitlab-runner/-/blob/v18.8.0/shells/abstract.go#L1699)
> lacks that credential-clearing call.
>
> Might be worth pointing that out to your colleagues who are in charge of
> that Runner image?
>

I have no idea about this, but have forwarded the message to the
appropriate team. Hopefully we see some resolution. Thanks for the
debugging!

Karthik
> Ciao,
> Johannes

--000000000000596ec1065c25d5b8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 87d1a98788e6b56c_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xenlYd1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1md1ErQy80am1WcHg0Z3A0ZzY0TVVIdnhtaWhER1YwVApBdVJTcVEzM2tQ
NW1FZkZQUXdCdFZBWSs5K3F5TXRCR3FnM21FRjZwSFNoN0JrQy9ZbUFQUzV2UTczdW9HYWI1CkhF
ckdBamtuOWxzYTBEV3hkaEdjK3RiSWpZcFpzTHM1Z2ltbWhDSzdydExrdm5lQ1NGYzVCRUdnb2lS
anBCaGYKNkwxOHh1alYxQldTRkE1ZHB6YjFWR2JtVWM2NUdjRXRNTHpqTkFVbUdpaHg0bXZPc2Zn
bDViUENuVGlwNDR5bgpLc1BTb2xXSTYzSUZ0K0YwSnhzcGUzTDZ1U285aHZWUi9rTEhyV0U4K0dF
V0w3cnhPVlJuRVVJNHpnSDR6U3JECjBRd0QzSWREaWhiQkk3T3pGODBxb1FnT2U4dHYvSW1Db0Uw
NWRFYk51M1F2QTB3a1VVc2JKVE1IQ1FlWDFJbVYKZDJPZ3NhL0pXYTRBS0gzV1o1a1ZSMHFBTDIz
Z2NVeFErWm1KOTFSQ1IyY3VtNUJJTlNXUng0S3FsV3IvYVdaMgpNV1o0alRoRnQyMS9icmNKSWNa
Y3NpUktNME9FNHpBdlJUODFuNm5vQVgxc2RpcFM4ZmRHZ0lwdVFIa3FXOXdMCnlPeDBjemI3Mm5w
SXdpTXB0QTIyV25EUHkwV04wNU1zZFVPc1dFcz0KPUg5RGgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000596ec1065c25d5b8--
