Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5601DEFE7
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 09:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771926479; cv=none; b=rPc2QIMf5BT+HcTvxoJGxt14Zju1NR7nNAunfIQrL1OxMTPD5pQDP9FpZk8B+q1hFt6HmVZxJsBtez0ZuAKy2PrNYkzvKN9rVB4WzDEzbf0lEQLXDCVRwwyrr0IRFCj9D//1fych3pQbpGgtl58XCBFm3gt/a/bcOYZY8p/Q64E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771926479; c=relaxed/simple;
	bh=KMC7hi7fDB6b7+/KonQk2s9cuICI4m6FDy/E2tmvgs0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=HaG2OQ9I56WLoia5uqaDjMpjuPv5wVsMrvclGnTE0WsdlYHKOZKGmAW3t0gJefsJ10Sgk+OM7gMXTiwaeRks47yBzAOOjyV/iShHWsxwRQI3kbS/4ek1qq0hgV8xFfsh9W1sm7PcNvfXt0Rb1daic6KsjC3O08XMXJOT3sfMQ8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ddbeck.com; spf=none smtp.mailfrom=ddbeck.com; dkim=pass (2048-bit key) header.d=ddbeck-com.20230601.gappssmtp.com header.i=@ddbeck-com.20230601.gappssmtp.com header.b=u4TbnDVg; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ddbeck.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ddbeck.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ddbeck-com.20230601.gappssmtp.com header.i=@ddbeck-com.20230601.gappssmtp.com header.b="u4TbnDVg"
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-b8dd0168b90so83521166b.0
        for <git@vger.kernel.org>; Tue, 24 Feb 2026 01:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ddbeck-com.20230601.gappssmtp.com; s=20230601; t=1771926476; x=1772531276; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KMC7hi7fDB6b7+/KonQk2s9cuICI4m6FDy/E2tmvgs0=;
        b=u4TbnDVgfwc6M5VsA2OtTOHbPZocZBrUUNzUWafl0aa4xvhidKUFqy1urGiojrmPED
         1ZMD8JlEYZ9b5UaovVdlWUL5TZEgxxQptJUx+YXBI6TQ9n3xnGA4nFuXTGCw10iNY5CO
         St/Yyi/oCi8uW8E/66sgAXl5OOZFYzY/EFpU96cKVLPWxIBQYpPoDDNnjaAaVyjs3MBY
         lGmYrekm5i0yTQZGF3Jl2EkNOUXPQgQeZDQH7UWvacOPrmMTGLdHV+I8TcRBt3R1p1bs
         zYzsDkrX8Ur54s64tiqOqp/lU0ejazc7E0BCNfz4+2k4fPiJ4dCJoqpSAVBSEcBp+H7f
         uHkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771926476; x=1772531276;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KMC7hi7fDB6b7+/KonQk2s9cuICI4m6FDy/E2tmvgs0=;
        b=LhSIdvh5DHtXTPzo3A8YdOtuCUcxmaEWc0TDNX9UAeB9SPgfs3RjQEMKZ5X7Hufqb0
         iCuHX6ue7MGDH6XXRAMdw9T23g0rAAfmLrYYZgRoxDrF9bIi50vbVkSlo74PsBbjQU3h
         xkbUqhH0zuld6sjXCDhdypmsb6kX77OsSyYPHbEzWsLFqBkymKB6aB3gpO4RXYJXs+CC
         /z5W5+lUIhFyic+2luHjM4zik7Ydm2yhCYK3AUPqOB9U0FAZbdzch4xJ1mq3aGm4KzhD
         VVcFEOsVhd/rUD95T0j/f+5oDvI9lJhpw6MmTaDhrRkdFBPtR8EJj0Sfq/0h/bm4dDmA
         lciQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTJKdahsPkJaUbFCZRAYvCSbW29whQlmGXKsG+g+hTf6AOVkaAh2DzqFIe3GwQAwYHD/8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx1UinTAqphTzM+YhghwyDHBSnRowczJmCaZXaXateiuLa3yqD
	LYWEJuQyqT/S2b6nflYz0EAN7VsrAR8wUlUvx7dZAxPgQr9MiEGjJBBUJBXoI11gPqI=
X-Gm-Gg: AZuq6aLk5yN2brpubVRFX7yrBtPRWi9fLAQkboUarHSsHGSDQxk1ksDxlDDorzfcjFO
	C8ddEl43ItBMr1yAvlmuRRvjJ3Qw5O8Kd8FgqXxZDlks3+85FWaRVaa6aWWBpymtj3AkIz+8D3C
	SRlmjtkKIvnOxmZe4sAu3aEwaVQBrc004RJ4exNCIIDkfNLK+fuQd0e4t6SWDSv2kqOaopNZIAD
	5QCN90urgcgBAwo3S4C5QM++XZK1qO2ZhnC6ThmyRfugOtFo7noEBVX2EJnAnG2Ggdc75av3WSc
	BAZWqtr4DJQfcAM9mKo/xMc86crzh/ffXr/smkxIET+F37wUlsATqmNkiyQRjI78n+jSexQIq0f
	uhPa6QHj6FZKFhqzUGNFFTIbdM/oO6IJh4+4y2Go4PzIEQwKYevcrIwVzuMnbZqN3Ent7fejr2+
	Y3bghJXcfMbjcZP8g+d3LWLy+o1Yyn/Ntna86aEBUBkqUtn/97Sce8KQibOs3xju3SP9Fqc0gMb
	yITcayI/JvDni1jbVEgfz+HdnmgzQ4Nn/i7rGRwwIlACVGyPEDXqxHovQoJPlUCJz+wczjU8wGq
	bjbt3c/J
X-Received: by 2002:a17:907:96a7:b0:b8d:fc50:c2f0 with SMTP id a640c23a62f3a-b908196a1ebmr342098366b.2.1771926476037;
        Tue, 24 Feb 2026 01:47:56 -0800 (PST)
Received: from smtpclient.apple (2001-1c08-0703-7900-6d21-7239-5959-38fe.cable.dynamic.v6.ziggo.nl. [2001:1c08:703:7900:6d21:7239:5959:38fe])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9084e8b790sm411810766b.49.2026.02.24.01.47.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Feb 2026 01:47:55 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH] doc: fetch: document `--jobs=0` behavior
From: Daniel Beck <daniel@ddbeck.com>
In-Reply-To: <aZggm7R-4VohiCYm@pks.im>
Date: Tue, 24 Feb 2026 10:47:44 +0100
Cc: Junio C Hamano <gitster@pobox.com>,
 "Daniel D. Beck via GitGitGadget" <gitgitgadget@gmail.com>,
 git@vger.kernel.org,
 =?utf-8?Q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>,
 Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FDB97002-401E-4F36-95AA-7FB772F9301F@ddbeck.com>
References: <pull.2047.git.1771443159369.gitgitgadget@gmail.com>
 <aZb2acEvAtNmt-4j@pks.im> <xmqq4inc5zlt.fsf@gitster.g>
 <aZggm7R-4VohiCYm@pks.im>
To: Patrick Steinhardt <ps@pks.im>
X-Mailer: Apple Mail (2.3826.700.81)


> On 20 Feb 2026, at 09:51, Patrick Steinhardt <ps@pks.im> wrote:
>=20
> On Thu, Feb 19, 2026 at 10:59:10AM -0800, Junio C Hamano wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>>=20
>>> On Wed, Feb 18, 2026 at 07:32:39PM +0000, Daniel D. Beck via =
GitGitGadget wrote:
>>>> diff --git a/Documentation/fetch-options.adoc =
b/Documentation/fetch-options.adoc
>>>> index fcba46ee9e..e15cbc51f2 100644
>>>> --- a/Documentation/fetch-options.adoc
>>>> +++ b/Documentation/fetch-options.adoc
>>>> @@ -234,6 +234,8 @@ endif::git-pull[]
>>>> `--jobs=3D<n>`::
>>>> Parallelize all forms of fetching up to _<n>_ jobs at a time.
>>>> +
>>>> +A value of 0 will use some reasonable default.
>>>=20
>>> Can't we do better though than saying "some reasonable default"? As =
a
>>> user I would wonder what this is even supposed to mean. True, we =
don't
>>> do so either in the documentation of "fetch.parallel". But arguably, =
we
>>> should update both sites to reflect the status quo.
>>>=20
>>> Going into the code we seem to fall back to `online_cpus()`. So =
should
>>> we document this accordingly?
>>=20
>> I do not have time to dig this out myself from ancient discussion
>> threads, but we probably had the same discussion when "git config
>> --help" described the fetch.parallel with exactly the same phrasing
>> and decided to leave the exact implementation detail out of the
>> end-user facing documentation.
>=20
> Doesn't look like it. The thread in question is [1], and neither the
> commit message nor the discussion around the patch mentioned why we
> don't document what the reasonable default is.

(This is my first reply to this mailing list. Apologies in advance for =
any
formatting mistakes.)

To set aside the history for a moment, I submitted this patch because, =
as a
Git user, I was looking for someone to just tell me a reasonable number =
of
jobs to use. I was pleased to find that Git already had a "don't make me
think" value built in.

If there's a possibility to giving this behavior a name like =
`--jobs=3Dauto`
[1], then I'd recommend against specifically promising a strategy in the
docs. It would preserve that "don't make me think" quality. Plus it =
would
leave the door open to changing that strategy, if a better method came
along.

That said, if the strategy is meant to be meaningful to users, then I'd
suggest naming it something like `--jobs=3Dcpus` at the same time as
describing the workings of `online_cpus()`.

In any case, thanks for the thoughtful consideration of my patch.

Daniel

[1]: <xmqq342w7hx2.fsf@gitster.g>

>=20
> Dscho, do you remember by chance why you decided to not be more =
specific
> here?
>=20
> Thanks!
>=20
> Patrick
>=20
> [1]: <pull.369.git.gitgitgadget@gmail.com>
>=20

