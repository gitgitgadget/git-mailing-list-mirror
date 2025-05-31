Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF2A10E4
	for <git@vger.kernel.org>; Sat, 31 May 2025 21:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748726930; cv=none; b=AYt7Q82nEOmGXRmI9bmGF1xprExLerxotpnaVMXAUXrsF0GtOJzLmd/tKdSVC0oNrCwDd0n9tZR8fm6TB1IITeatPykKcdmQGT4LhK4JGFrKdAHIajRd70uNs3ir0yBKgdyy6Hp/f0Hhv3KcnrgysKDJECTPu2zN+q+er4rsdyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748726930; c=relaxed/simple;
	bh=k1qbNF0NwGsADQDN3U+EoAgdreXjRRT7Uh18MJ8HaVs=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m3a6c/wgS7zWnhWZJPjBcTzp2QCUMXBMcZNs7kgaJzraKwhYE+CPogiEWh1HXlbmT9vH8tdUGkFZ8yPHjQWhBqmEd/v39PubhbcegovlyrBrIWq3tGrpjEHfpLWuhEzm1YqUvsbI2j4+tNFhRsqr+lRtUuaAMrThAes04i+aqEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kyi1d2yB; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kyi1d2yB"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-51eb1a714bfso2114806e0c.3
        for <git@vger.kernel.org>; Sat, 31 May 2025 14:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748726928; x=1749331728; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=FcsQlYs+sCe8BJDdHqRD0dfHl6ExmGqbc9A1kdjNNKU=;
        b=kyi1d2yBQS4weswBYgOCtJ7P4hAB7A1TUI5uyDADEZsdXczMV36SVYMmOtG8PUNC0Z
         aa2/XwL7IhSYoE4f/TGNkpVJZxEw3NZdtFzt82DFCJMvB8E3pKo0fu/jLXvRLCCO2e42
         xlrYzU2W2KMmVtSbf2kb2ZMU4YosVRI57dH1XblMnZNLrIPDCKrGJ1fgSv09ZsizdvtT
         x/IjXn4HB5boc32IPN40nwVqra4iESW20CBM4Sj9AxxSp/UK08MSk/ekAiNf+qP+7Sy+
         RDOG7vpWmumpGkSTvI7EYUWFChFxDcY+6GFBkBrL/4DMmxW4Gf9lYLFKVe3fXE2+B5K2
         l7wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748726928; x=1749331728;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FcsQlYs+sCe8BJDdHqRD0dfHl6ExmGqbc9A1kdjNNKU=;
        b=A1aEhLKc8xzlElPD2lFdpwKF48DBv1sqd/5OHO76xnxgsO3+vhZcfu5w/XhN3Yd1ai
         3Kelc54BMU6IBRuTnykrAdycDedBDFF1RQMFR+quF4NkCqXdBmZS286RNDYlav9V3RJn
         0o0ukKtzNIsgLoz3iv9WOdS6ZkH2nAz7MnbdlJDBVvanBoeiZjSOCnv8ROV+caF6hrI9
         Dwgiypqfzi6jZICFMBtHwETQdR7pxpfGlr9oa69PNywaqpolmFDvTfgN0uUwkGINxJVS
         Oj3BLqv3brXgaAl7SbVHdqEp9sEX/8fHp/3WfrEh20RnS4AsKjkAUDiagsPP78LtOSbT
         oH/w==
X-Forwarded-Encrypted: i=1; AJvYcCUFO11owohRf4dOmeVM1ETz/xrZ6wwp02tBV//fX6/uLDDsip6sucRsc0fJELIYv8wRM38=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuEXX2VBOt3+NT5EM9msMTWhhGttRL7caOG6FUT2ulvb4T9unO
	M81MZwmprh7zl2w+BIprAlOWSlMgq9enEow7fsCjAQBLbUqc3cGMlR2LCdY3raKPEBmCTvOHzva
	rbsinzOa70DB4BNLQXXEr6OlIebi4NHs=
X-Gm-Gg: ASbGncuTWnLN2Gl0ZOLTasYqVrlzZ8tak3faTVqxlpookmtbGnt6vLa1tHcHp4ZS10r
	PN0RP6p3hjS4AasdFMVVWe+bQUhh5mc8bGMcJNd05NWZ36ZH0g57hdCa4D7QDXSaygbdT7kbPe+
	ekic0uoKtZ7L58jP45LkRZaxLyxrZ9V0PH4Lk7JIUiRr6p4NQzVFQGxk2vuwd7hFe/w8qM5doVL
	bQ6Jg==
X-Google-Smtp-Source: AGHT+IGPkuKcXWRtaDyqf2fPGDjnyRCIZ4MIQq4UvtSPZx3pVZpOVVgnLrq+BXTp0fXIQu3Sr2nX1jtKmVTPfB2swtI=
X-Received: by 2002:a05:6122:2002:b0:52f:4624:35ef with SMTP id
 71dfb90a1353d-530810d9105mr7583367e0c.6.1748726927837; Sat, 31 May 2025
 14:28:47 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 May 2025 14:28:47 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 May 2025 14:28:47 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250530-pks-meson-tap-v3-7-676f5e41f2e4@pks.im>
References: <20250530-pks-meson-tap-v3-0-676f5e41f2e4@pks.im> <20250530-pks-meson-tap-v3-7-676f5e41f2e4@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 31 May 2025 14:28:47 -0700
X-Gm-Features: AX0GCFt2yY67CaEd8TEYP7pn2V-3cJ2lNhDStYFaBjDuKSB78eq7qQwxncNs5Wo
Message-ID: <CAOLa=ZRp=-x3eDXvb1WMCwT4FXU+YbiJYTfo3=kiGfO5GHSR5Q@mail.gmail.com>
Subject: Re: [PATCH v3 07/10] t7815: fix unexpectedly passing test on macOS
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
	Ramsay Jones <ramsay@ramsayjones.plus.com>, Eli Schwartz <eschwartz@gentoo.org>, 
	Todd Zullinger <tmz@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>
Content-Type: multipart/mixed; boundary="00000000000057e9a60636753760"

--00000000000057e9a60636753760
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> In t7815, we have the following test:
>
>     test_expect_failure !CYGWIN 'git grep .fi a' '
>         git grep .fi a
>     '
>
> The test passes if '.' matches a NUL byte, which we expect to only
> happen on Cygwin. The upcoming changes to support parsing TAP output in
> Meson surface that this test is also unexpectedly passing on macOS
> though.
>
> It is unclear how long the test has been passing on macOS already.
> 064eed36c7f (config.mak.uname: only set NO_REGEX on cygwin for v1.7,
> 2025-04-17) mentions that the test started to pass for Cygwin once it
> has imported a newer implementation of regcomp(3p) et all, which was
> inherited from FreeBSD. Given the BSD lineage of macOS it is feasible
> that it also inherited similar code eventually that made the test pass
> now.
>
> It is somewhat dubious what the test actually brings to the table given
> that it is quite platform specific. Ideally, we would fix this mess by
> having a configure-time check whether regcomp(3p) works as expected,
> including NUL bytes, and use our bundled version of the regex library in
> case it doesn't. Like this, we could ensure that all platforms work the
> same in this edge case and mark the new behaviour as expected.
>
> This change is outside of the scope of this patch series, which only
> introduce support for TAP. So instead of fixing the bigger issue, ignore

Nit: s/introduce/introduces

> the test on Darwin like we already do for Cygwin.
>

The change makes sense to me.

[snip]

--00000000000057e9a60636753760
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: c661407c3670a2_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1nN2RJMFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meDR4Qy93SWhKSmtFaTdBSllKOG4raC9xV3U0aUUydgpNTEN4U3FjMTY3
dFRBNmVwU2dWSHY4SGd3MkVRUGorZW9jL0ZEQ3ZHUEIvVE0zQkcxSWNIcTRTZUJiNjFKaTBICnJB
MzdRbmo0WE5kSEE3RDhnczZlNWh4TGFLUFdZZVpKQit1dXV4aTRreUxIOXJqL1FCZEJVVEhqbmpQ
OHF0OGcKSmNCYndXUFN4TE5TZGZSM1dxWjlXQTYrVWE4cFprcDVNZm42WHdodlRGOXdvelZMTGp0
MzZzM2loSjVvdlc4NwpPa2hicnEwNjl3MDN1czVMV0V3N1dkM3RJRjhST3JLSE1RanVvN3cyMHg4
VzBHT2gwNmxjbzRicWdoeUNaVVdtCmRVYVNCQXhjMks2QUhTSGMrOVpPMS9UV1g4bElkTEJMQWR6
a2Q1cmZMTHdTRGxMVE9XaVBNcjRsNTBlS0hZTUkKNkJyZ3VQdjhVdEsrM1NZbW5iNXhiZ0tHOWxI
SjVEOXQvMCs5dk0wYm5XNWdwTFZrLzdVNVdqRzI3K28xdGFMMApkd2lyNWdlQ1RlMW5lYjZCQjRI
ZmNtbHJXYnA4Zm9WQys1WTRHZkppYWhubEJHMzVtYW9ESE52TUxLRnhhUkNFCnNlN3dLUThCczZS
bE5FUXZDOEhwRjRVU1pnL0diUnpiQ3FYS2JwWT0KPUhYYU8KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000057e9a60636753760--
