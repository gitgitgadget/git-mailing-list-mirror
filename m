Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793961627;
	b=jdF/nrJCagrkhhZCwmU2lLDV3lUYFbYrehXsxn1J70v6C/c5bNWU5zBcDW7//06yLPeo
	 PfK8k6H5mH2M0snHtMUsyE34RD7AIfh9G+hXZ/91u0X31Y+yX9yGV3peBSm5TAqHR2xvz
	 6hBuFTWScbx8jlgFxSRZ8Gtr9gWiPDkwCzFp7ctxPsfj06a2B2Qs9PlnFEJsZY0aeuUBW
	 vSoMYv5rj9Soy6d1+kwQAqD7HH7RXubiOmwUlDFT4+aa/BeIKqMS8SX5C04wTJnH8BAA3
	 gBTnW/ADauMowAZDOzZQ9pXxMbXFQCK2hGhaMGrgXUxUyhXJHPSPLgfdOYzh9VJMiGw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793961627;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Content-Type;
	bh=qCTA6XXpcsTc7qn2roFlCWyNmRORID+PsuQAHOYvqag=;
	b=imiMMbyfFSnFkBYL2aEqJ6yTMYTlqanhAKbxGsA4yglzvQsCCw5+woFRvg6GX2JcvpM4
	 Mgapegly3RFJehk8sJYKeQ+iMVpM8XAgIhavfxWwMP4LQvhfMsMtyChk99rW/BAGVOAvf
	 4OOSO85hb0nzaG0uHs4xez9yx4bUsFiJgKNVjqd89TtHO7Cx4NQ5qI2R3B1q6fmtK7VY/
	 4ovdXPtgNFClNa0DDT6O5kuQglfozrlsU2iQLNWJEX4OGsbK8RWew5DJxYYN4nfd2S+d9
	 ZykJuaG/E1zIvty5mR0K3/3JUyKQAS/fak4bunLp8t40TvkV7aQeE8JX/Hzv6Ksed7A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=solq8Egz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.42
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43610606A32C
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 10:40:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43610606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=solq8Egz
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-7c3b75caad1so368042137.0
        for <git@vger.kernel.org>; Fri, 06 Nov 2026 02:40:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793961626; cv=none;
        d=google.com; s=arc-20260327;
        b=ecIwRd/D3Kt7PiuVifGRs51MiST4steRRYF/iWboukWQavp+4JZwJ5VxLlNlkfLCCl
         tPY4usS0epSdYsEd7Egr6mrCIe7/94b+NH9KKPcO83e8v58H6xyTQ3eHdhxmlaB1dRwv
         1/3RhT6PSZ/RWtTENhXOf9IRkLiwTmg5EpD2hISJochsa51pVVn2gF5qhKAKHLb/L575
         /5uenaK1KL734i5WtZiMV20nF2vyBAELIHXEpDaY9vBCl7oIUB0WgnaTVxF+F+R6bcJX
         Gqd4yZnRUqs8qaCu5DAepp42t0A9ehiH5cwuqJV9ph3atXI6NfrLSPsk9Uy+ht7INsh+
         /Zhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=qCTA6XXpcsTc7qn2roFlCWyNmRORID+PsuQAHOYvqag=;
        fh=/WgNsP9nunlYUVactyj7gYaaC54D7k9QfGjUSUVp2HE=;
        b=JlB3AwyDKAOrhbnKMpWlWgI+ogsmNIi7YU8xirIlRZee6NKobusliHrefPSa0pubvR
         DTz75Zg53eQJ5o1gEmtYO/ItXTNQ/Ogj2R1G5wOA689jdrEsEztkrjNn//GBSDtmuJgZ
         phNfGqNuVgZGnKuzuEk2Dv8kVdE0Ps3g6ipfN1/AyuDHE1q+JOAUM3B+pudWRP3w3tro
         uaK0AGxIrP+HSbuzMDMXzcY2NUUYTMYEP0KGw1BHqSB2oeTuIYzboV9iYCwEdyLwr4nA
         i6Jr6RLPp3CXa+2sWW0YMdUlIzr1wTJrAY2b5erZjqhZkex6K14slfPF3Z14cgVWe+Jv
         KcBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793961626; x=1794566426; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qCTA6XXpcsTc7qn2roFlCWyNmRORID+PsuQAHOYvqag=;
        b=solq8EgzWQzUkvhxw8nOIKJdCuVk9dceid5w3PoWTvlVylQfoAPVKT+IKfZuDhZhCV
         wO1aOTQuPgxs44EOWexw2ZCwmxakXIWN0Lez3u3oly55X0P0Fa+56B39ZC0MoQ2tDVXJ
         TwaaqYTBxsYqK4O9qv3GopAQJOUdr899Wch2sPnex7ddFp5I1Ut8a+3b334P3vIkjZDh
         5/Fmne7pPOksxYQ4P/9sW7DAh54oTRRn0UWXwEfvOKCsh08AaZ37xHt104KnTgqWlxgZ
         LNNPUIfuoidZVLpTR98Vg1Nk3rEbGZXZ4mcpKkp0MzV7f50kvQ2QABCOx0rDkRCNQlCT
         pvrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793961626; x=1794566426;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qCTA6XXpcsTc7qn2roFlCWyNmRORID+PsuQAHOYvqag=;
        b=fPuIpw6SNgON9gs0ZUKSbub+Y2GHb3/4Xu/dkcPPnWjGO/ZzfWjFD5ySl+niedInxc
         EC4hL0/XzqzTGS5YuQzjM+MhB2TiL4VltiRci6UvqfpkPOHvynHu0fzD7q1HWt4VQxhp
         gD38lOS0HIBV9pQF6ghvhfjiQbJv8T433cZMQAvyag/bxSJIUDAfdKV/d1HRxkr93iMh
         DVKLZTY1ipYJGdx/t+0hBnlbaS5Hk+rG68TO2JPP2oJt5Spxw1r6gvjO50s7ccQC4HtP
         Ff3Sk8o0mWZEkBQqMecsBLMzoioOS6/wtd9h1o30WlNPv2e/LbahDM5KWjLjabWDV6jI
         0JhA==
X-Forwarded-Encrypted: i=1; AKwUvBxX2CJrymAGTGwaER48XaJjosiEURpwbprdbnogKIlT5ksmU6s81cJ972nn94Fi18VPqFw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8BYn4vvomTKkCk5gJjwGV4jbiVWHMQMNGWygMnIbbVo+DA+tZr
	WNEclDKplRAfswPmhK1iuvHCuMHq83S6tIgiRXi9n1daE+Nmp3EpHE516ugMB0NVkvWN5SKLiMz
	QHJl7PuTjx4RPp8bY4DVDCpKBv3imrkm1BA==
X-Gm-Gg: AYBFou0CIghEK3+Lk1qEVe5rTBB+IBNI5VnK2HxuPQAxFe1q/5GI5RgkgNQqPYRdn0t
	YznufzpfE4pWvhJGolMPgbvYUN5bT4Gp2+Ea1hxONZPsMSWgwJJ0QsYgGUh4FctXbaXrjN4jK2Z
	K5mFE8aditCIFh6TG24RaAy2B4B1ODZlaPVu8YJrDv1gVCmuGnWAwNhXPQor1XFAbvrqZbcSwDt
	9if4R/zwVqijiIB3mLYoe1raIcdB+qf2jq7ucEpwmozS9MeussIGndEUxaRP3HXyiTHYKjOWkbf
	Fp9KKIWDpr2aJo1xwE2wHl7l4Ylhdxncj6QgLD5ycC5PJQW1MMm1SZsJYz/ANVimiPgOT45Lz8Z
	5MBYq3Bs0rrf7MUYBAyB+bDDRBnkLFDXj6m4bBjzFzuSzUDz1ykB0b7M1IKKEMkfSk9DsD7BG36
	HR5G6Uo0fGNOD1t498nNchhO+TqVD8nG3uU3m+PQXh1yiCuuTK
X-Received: by 2002:a67:e70c:0:b0:7cc:828b:421b with SMTP id
 ada2fe7eead31-7d2a15097e6mr1569927137.6.1793961626134; Fri, 06 Nov 2026
 02:40:26 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 6 Nov 2026 10:40:23 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20261105-pks-storage-format-improvements-v1-4-870bb4212518@pks.im>
References: <20261105-pks-storage-format-improvements-v1-0-870bb4212518@pks.im>
 <20261105-pks-storage-format-improvements-v1-4-870bb4212518@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Fri, 6 Nov 2026 10:40:23 +0000
X-Gm-Features: AclHuK8-rCjV5DOqJ9JbKMebPf4_OGCAkvKmONIUxZWfI1Sa1SMHyRqWA01jeyk
Message-ID: <CAOLa=ZQfSA7FzpNPry9tRgF5RAqBPaof7=Q-XR+8nA2koh5gsQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] builtin/rev-parse: print payload for the ref storage format
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000778c6e065f993d87"

--000000000000778c6e065f993d87
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> While we print both the object storage format and its payload for the
> "--show-object-storage-format" switch, we only print the ref storage
> format with "--show-ref-storage-format". Adapt the latter to also show
> the payload.
>

Nice, this makes sense and was clearly a miss. Thanks for fixing.

[snip]

--000000000000778c6e065f993d87
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: c176fda77c47b123_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ydHJwWVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mekxoREFDY1BqaXVDOTh4cSs3a1oyUHYwVDdCMjhMRwo5amtLb2srbGpx
d0oyd2hMK3RVRU55TThINWtMRi8rQVJINnZmc3dOM256ODZrQlRNWjFDeVRmWjRzb0lPaDViClEy
dWh5YllGbnRYYlR1RUpSR2ltdFErRTQrWmhucUtyc2RWQ2FuREI3QWY3b1ZtUEhEOXRvRXQvS3BZ
a3FubSsKQmQ5OCtJOWROck04dVhWcWUyZW1WNElwek9BRkN2NWxkeU4zSXlOZFZVMjBwSThxeEVJ
N1YwYTFhZXBCa01iWQpMcHdud21QZWR1aXRpdlViUndtNjNYRkViRHJkMkdLN3dDNGlYUXNVQ0s0
SUVISjdhSlVzUmU2T1J6ZzVxcU03CjF1UXE0eHR6ZndLOWpjSlpKSWlmd0p0ZG5wVUxFR0ZrQ0Jn
MXRzVElhMWZ0Mmt4djBvdWNPRGZtL3BMT25KZE8KKzRMTlZpcGsyMEN0Zk5DbW9DQmpUclcxc2ZY
ejlHWU56aURXWm16dEo5dkxYcng4eW0vRmp0eXRiM2tIelVvYgo3Y3djSVJ3WUpZODk1L3hDU0p5
dTE5MUdTbWhoNGlrdmRXNDJ5dHNLQi9EdkF5NHVST1A2NC9iUTByUzkyTXpWClYrRmhjVWVMOGZZ
dDRTRGFOZFhTNzJjaGkxSXFoZjhGVXk1SXJLdz0KPVA0NGQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000778c6e065f993d87--
