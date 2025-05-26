Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AA11E48A
	for <git@vger.kernel.org>; Mon, 26 May 2025 16:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748275438; cv=none; b=jyt+X5k1mTajOQw16FnEJnecSVq5cbjjJgRn+a3uvoH9o8r9LYIGO5Rul+e5pzCJ/S2EZ5AU6sFbsQ3/2vmW6FWVQzOZYO6oZ0GgRAY/JdX64Wj+IMRVK7MWLSOgFsRbSoavqBr3gk7+KqqozLsfd2dp0jQ4wfb1BdfD/can9o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748275438; c=relaxed/simple;
	bh=gfSm6N09fHufruQu42VAozrhBTz3FitJRc2pYaJ1j/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L9FgoYgwu4nrcQpu0jPac5Jt7URnOtoc4pCuu+8iae3Zs9iCbyM9BKre0QfOgF03tLVhv0bbtSjIJillmTtyR6ZCpdtSRZei/Kd+D4qCDef5jNJZwPJLvjuMlnZGhwgW1DsGTxYUNRKGw45g3vCia/GlVhO+WitaA7CHRV+8aXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GIcXm13T; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GIcXm13T"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3dd24c86779so13122205ab.1
        for <git@vger.kernel.org>; Mon, 26 May 2025 09:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748275436; x=1748880236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cnmUIoYkNBfkuo1vBlVxbN2A5mcdExKJQf7OKcCmK0Q=;
        b=GIcXm13TqgBGk0N7NeZJJ1fKaPJtuTj1Azanta7unR5xdDdZewqEkcc9fIRL1dq5ht
         BajYwinzpHVIr8JKUFUbbx1LrZQLuZhpzm6JFKxYvGtWzrvt+Y9k0KIi5AIfiTeZOtgd
         vGhqCf14yAEfd9S9GmhdcJsPlRNzff5SOKl3dmmjem9pykFibRSMWFrCLJ8ovjYc8Z7h
         bMpLqkam4penzbX+YV53xLqR6Dm3XVrNHT1nIRKEnD6ev+KDfCOC1cksi3QRQ1B1OHXL
         +735KQAStvvMi8vghAecSkQH/OxcnJ0cpaZO3Tbb7qrA4Ow/UkPR+mLsJWUvOigqbkcH
         /lxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748275436; x=1748880236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cnmUIoYkNBfkuo1vBlVxbN2A5mcdExKJQf7OKcCmK0Q=;
        b=LloniA9B5xfgOMsiq0U2b9EaXKQUHluIRDpxwXYEd/JPpUeSJVoIvRtfMRyfD7NOQw
         Xhwo1WAKH+sFiHXoJqDrLKCIY5T1yAcsx8UqSRcH13TS75CvRPdKBX7djo04NWW8gPvX
         s28wqITZ6EJY18dcosueKN8cr/gy30u8MbT3eaqFJSuB515vbcaEYSEEPQ138mnSMB8j
         aZFToZOJGluzcY0XlzSztf7di82y6uqwLbZjCOMbyKOl2mdg+t7a1Ru4eZmd/0OHpmq8
         omfTMmdOt+mTNFTF4PUaQpBbfLVFjmoOADLfBDYt8Hc4RiT4cfRmjAtHac8shvtlZEQh
         qBGA==
X-Gm-Message-State: AOJu0YwlN9CtuazFzQHvaWT19/O/mVFGmJ1ip8J5Tx7mRMbhLAdvNmqP
	3YKaSW5yUaeEC0O7BlwHOEgRBcnK7yFTRYb/D5vpDtH/CJ5uSGliKi0vUvUGryZ78yaRhGUFRdK
	hDXtCg4OGYrrjMiUgxtPf5sqlkv97RzQ=
X-Gm-Gg: ASbGncvt1fkGV2eHE7KVgytl+skCf1b/Rt6etPO/QxP/KOnDb1bx5ONrmdjrrOPH1xw
	6hjbYu2TjAZVjGsT4ijfeK4wj+ddSGSbV2NfczQeDySeBDMSDbzI1J8S0AkgKKW92LxHoOJ8do6
	p7po56vrIzHSbugnwXqdAEEjVopIlxXPSGFSm8NoRmHGNKrul+vUAL/U5Wx0rHqXMR
X-Google-Smtp-Source: AGHT+IFqVzh9H9cCMMnRna0rlik9HsJ1eVbnxkNWH3tTuFSGy9YmUs3gA4/onvhbiHVaA7uChig4dWu8VA5oV2sjQk4=
X-Received: by 2002:a05:6e02:1c0c:b0:3db:754c:63b with SMTP id
 e9e14a558f8ab-3dc9b6d3b48mr96870655ab.12.1748275435020; Mon, 26 May 2025
 09:03:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424203904.909777-1-christian.couder@gmail.com> <20250526103314.1542316-1-christian.couder@gmail.com>
In-Reply-To: <20250526103314.1542316-1-christian.couder@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 26 May 2025 09:03:43 -0700
X-Gm-Features: AX0GCFv25YyY-BG4uP2f0vuGJUkKF3NNDKgJii-BtZCRidmj2zFKiu75AUjei40
Message-ID: <CABPp-BFbF=rp6FZjyL+Fm5TqNZZdhfjS1sK-CBQ_=wtvFmfdLw@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] extract algo information from signatures
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	Jeff King <peff@peff.net>, "brian m . carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 26, 2025 at 3:33=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:
>
> Around one month ago, I sent a patch that tried to improve on how `git
> fast-export` handled SSH and X.509 commit signatures:
>
> https://lore.kernel.org/git/20250424203904.909777-1-christian.couder@gmai=
l.com/
>
> This patch was showing a single string for the hash algorithm with the
> following possible values:
>
> * "openpgp" for SHA-1 OpenPGP signatures,
>
> * "sha256" for SHA-256 OpenPGP signatures,
>
> * "x509" for X.509 (GPGSM) signatures,
>
> * "ssh", for SSH signatures,
>
> * "unknown" for signatures that can't be identified (a warning is
>   emitted).
>
> brian m. carlson however replied that it would be better to show two
> pieces of information instead of one: one for the hash algorithm and
> one for the protocol.
>
> I have tried to do that but there were a number of issues. First it
> seems to be easier to extract information from signatures when
> checking them. And if you check them, then it might be interesting to
> show the result of the check.
>
> Also for SSH signatures, it's difficult and not so informative to get
> the hash algorithm. That's because the hash algorithm is often
> specified by the key type (like "RSA", "ECDSA", "Ed25519", ...). For
> example "Ed25519" has SHA-512 integrated into its design, and "ECDSA"
> and "RSA" are typically used with SHA-256. So for SSH signatures it
> seems better to just show the key type and not the hash algorithm.
>
> In general I am not sure what users might want regarding commit
> signatures when using fast-export. Some might not need much signature
> information at all, and for them checking signatures might just slow
> the export process for no benefit, while others might want more
> signature information even at the expense of a slower export.

I'd like to propose that the following are the possible uses that
users might have regarding commit signatures with
fast-export/fast-import (if anyone has additional usecases, let me
know):

(A) Make fast-export include signatures, and make fast-import include
them unconditionally (even if invalid)
(B) Similar to (A), but make *fast-import* check them and either error
out or drop them if they become invalid
(C) Simliar to (B), but make *fast-import* re-sign the commit if they
become invalid
(D) Similar to (A), but make *fast-import* re-sign the commit even if
the signature would have been valid

Note that in the above, there might be additional processing between
when fast-export runs and when fast-import does (e.g. by filter-repo
or a similar tool, or even the user editing by hand).

> To address this, I decided to focus first on extracting the hash
> algorithm from OpenPGP/X.509 signatures and the key type from SSH
> signature when checking signatures.
>
> To test that, I thought that it could be interesting to add a
> `--summary` option to `verify-commit` that shows a concise, one-line
> summary of the signature verification to standard output in the
> `STATUS FORMAT ALGORITHM` format, where:
>
> * STATUS is the result character (e.g., G, B, E, U, N, ...), similar
>   as what the "%G?" pretty format specifier shows,
>
> * FORMAT is the signature format (`openpgp`, `x509`, or `ssh`),
>
> * ALGORITHM is the hash algorithm used for GPG/GPGSM signatures
>   (e.g. `sha1`, `sha256`, ...), or the key type for SSH signatures
>   (`RSA`, `ECDSA`, `ED25519`, ...).

This sounds like it might be a nice feature extension to the
verify-commit builtin.  I don't see how it helps implement signature
handling in fast-export/fast-import, though.

> If we can agree on a concise format output for signature checks, then
> maybe this format will be a good format to be used in the `git
> fast-export` output for users who are fine with signatures being
> checked.
>
> What do you think?

Maybe I'm missing something, but it seems to me that checking
signatures *in fast-export* would be a complete waste of time.  For
usecases (A) & (D), checking signatures at all is a waste of time.
For usecases (B) & (C), checking signatures in fast-export is
throwaway work because whether or not the signatures are valid at the
time fast-export runs, and even in the rare usecase where there is no
additional processing between fast-export and fast-import (such as by
filter-repo), the signatures would still need to be re-checked by
fast-import anyway.  (Note that a simple `git fast-export ... | git
fast-import` is *not* guaranteed to get the same commit hashes even
when there are no commit signatures; that only happens when the
history is sufficiently canonical).
