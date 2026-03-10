Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221C630E0FC
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 04:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773118293; cv=none; b=LpY4AUFyZT7Ra9CAY7A/fmrmRvyjPyMxuGDfC4PhB0wthrN7H11TjqzEeF3hE2ENf7YM2uUAUzxKr0vO/qHl41XWFimcqLOxwvkvZeeSS6C8MRc2UvRVJkzc1yycV79jxzPdVFonfceJkm7B6/hEV9uiET9ieXcvSlczrAjhN7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773118293; c=relaxed/simple;
	bh=II3is0ehZgEkdFA3kJW5POnFvfvwjK+MkeM4eVMu2RM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mW33Z4gS/YEZBSVjm6S78JjWiKOz5uMHG0Y/LNH5xPw7reEpnhriOLX5SEE1GLqq9jrUdCPsaXSsuX3g0rgtYEdaSv0Wgbqy4t3FWihHUEGicGvbFEZRlqVRvCQVEnC89pwy67kBwhge5Imp0KuhEwGmfuhcIdjO+Sab97i2Rqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=fwHn/8Ag; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=s9cobJT2; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="fwHn/8Ag";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="s9cobJT2"
DKIM-Signature: a=rsa-sha256; b=fwHn/8Agny5qHxZhUMOKR76gAlB8lStS7B5zmLl+e7MzMHu8vJCJEM3KnpnCsvcik9dMJgnQIH+emCwaMUM73DlI3AVK/FosLFwlDVvDXGylHaKS6Tj7XcJf5nw7CuoHkUwE+0wcmMq3pzJUFj4BKP89ey+fgbQJuEvdSJzMvatFEAVORZcix6y73EjBB8dINKRuu2PZe+eKrcN9nFBNPny3zKiejO8OXo1ABAV2Lr5ta/6FUQJEgZh9PPFGNsI5C4Q9A1sbyBZtZ4y/tYPr3OCzFHjsRRGT41gDcWNwJA16nbkShm56gVSei72mOjlVEUjSnDOKrkH1oYb7JMgLbA==; s=purelymail1; d=malon.dev; v=1; bh=II3is0ehZgEkdFA3kJW5POnFvfvwjK+MkeM4eVMu2RM=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=s9cobJT2/CEWo5BuQpcn/AJ2rwQ4hWMwHo2t6t3DXH3TGBNrUCMxRds5epc+mauSzaUizT80RALD6GBTPjDY+IEeFor+cbh0KitYpib4jQGfdOajW+E6HaHD5mOFTXmjCgt1Ug6tgNTnQ7sUY4LNjf9niTEHWHePaByb9RZ6FaJuERTU1hUuvIC+4xhxM+6gRojV1ul7fuyq1CVRIG3DhRkdFxkvtYUgjBU9044E4iJ4RirDJrmg14qmFyPuX2EH/eDoZuLU/2K1Df18qomm4lSP9lPwAd1S3+CikndXnlh68S+aOF4O3X39YCNIIJOi2cSQpteOXNu+tWDQ9Bw3Hw==; s=purelymail1; d=purelymail.com; v=1; bh=II3is0ehZgEkdFA3kJW5POnFvfvwjK+MkeM4eVMu2RM=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -688842347;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Tue, 10 Mar 2026 04:51:28 +0000 (UTC)
Message-ID: <71287f25-eb60-4a45-b4ac-9368053c9183@malon.dev>
Date: Tue, 10 Mar 2026 12:51:23 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] diff: document -U without <n> as using default context
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <xmqqh5qswo45.fsf@gitster.g>
 <20260309172719.125419-1-cat@malon.dev> <xmqqwlzk1wd8.fsf@gitster.g>
From: Tian Yuchen <cat@malon.dev>
In-Reply-To: <xmqqwlzk1wd8.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail

Hi Junio,

> I am moderately nagative.
>=20
> It is not like we are _encouraging_ users to omit <n> from -U<n>,
> but it is not errored out only due to a bug.  Who would the new text
> help?  Users would wonder why <n> is not optional in --unified=3D<n>,
> the other way to spell the same thing.

Indeed.

What I was actually thinking earlier was: for bugs like this, which most=20
likely come from misoperations, typos, or inconsistencies from *ancient*=20
standards, should we acknowledge them as

=E2=80=9Cyes it is a bug/historical issue=E2=80=9D

or

=E2=80=9C*special behavior* we defined=E2=80=9D?

I'm not as familiar with the Git codebase as you are, so I couldn't make=20
a definitive call. I chose the second approach, but I now agree the=20
first makes more sense. In other words, users shouldn't be *encouraged*=20
to engage in such behavior, right?

> If we want to be explicit, we should probably do this instead:
>=20
>      `-U<n>`::
>      `--unified=3D<n>`::
>              Generate diffs with _<n>_ lines of context. Defaults to `dif=
f.context`
>              or 3 if the config option is unset (`-U` without '<n>' is ac=
cepted
>              as a silent synonym for `-p` due to a historical accident).
>=20
> which would tell readers what happens when '<n>' is omitted and why
> we allow such an inconsistency.

That makes sense. I'll make the changes accordingly.

Regards,

Yuchen
