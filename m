Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD596213E90
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 21:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754946865; cv=none; b=tT4VR1YLsgodEEsiokQ4K7EfxKaja22a1M4T0zh8K5T9IGF96FV3WVrzlSJHsFyKKelNIW2Qg/Uw3ErOig2weaxIa1nYc3mBXW10IlaeC+oFt76PcDe+16V98nyMm4JS2B5N5gyVf4T3gf8N9r2TdFaGB/i5BLooeuABcmrTngM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754946865; c=relaxed/simple;
	bh=uRko4td3CvpmXjvqkbEAsNfIelRXUqaWLGZ7k/zaN8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f44Urf/bKg/MmzLm5bXnljLjEAz4qw/2RyxPHtNy5sDIpQozu9CRPKJTrafjFUStEEaw/zvlwiQUDy+dTFnnZuIdqRexn4fkanEsYEYVRmwVceW1VzJ6hYlsXripYGTIaeCTeUPc/5rJRWiuCggiZrIMYOoLHIrKlTt1n/qrms0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LmF/nNSg; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LmF/nNSg"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6157ed5dc51so7309727a12.1
        for <git@vger.kernel.org>; Mon, 11 Aug 2025 14:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754946862; x=1755551662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KYXG7kXO4+cWyb4Ox9MupUyOS6Vj3Rwz3ixB9s3PC1k=;
        b=LmF/nNSglPTXYy9pn7LIa+NOGWhIW98fzxbPxT9tPVtAvZKAX5voUEZp/QQFJ6EVTz
         D9LfedFK/+DIreg190UDj7tUM4sRhvgplcHOlouOLSnn2xHoIr+CfgochUTRAJCowXlA
         aYVVPXZFNZ47LD68LokTiJX1fGv4gK/BYiElZGq6sZ7tpLNAKCdXSg/HMgYvwXmop04M
         8XmP6ySeGMGU1fy8BhpHBVNzNaEQ1bzW/FB8soAKbg+60EynK5IS8hlruSdApbwklYeL
         frrXomeEs+AwxubI7yOi/K/z6A9+FaT7KzMQtGKlLsDdB9hIDSLf/jqTSTsozdw2P7Mn
         Itdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754946862; x=1755551662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KYXG7kXO4+cWyb4Ox9MupUyOS6Vj3Rwz3ixB9s3PC1k=;
        b=FPhBFuI2aDsmAd6nXPXFkwE6rYEzZ1W4BprxchJMODlE4U/VGGyNnuyr0Em7lmk3AY
         PPCyx34JNq6IK5vwFUkKFSsrToapsceDDrngL4zivOQVeJNv/QsUlHD2Nm9AVRo4d0Nd
         an9RP2uE3mpD+Or6apXRWw414qJr2Uxfm2pUyZuKuct/aJZN1M4jamZis51f/BhRi686
         8rJktlLcdtmf6FZKPxMF7tINc09X2swI3VPrhxtwfjvrMV7RpTbdB8c10lGNDOkkugOc
         4Hai2A5iQ5WpZC9x4mLfhUI2Uq2OT1djc7sGb0X1vOHv4MkcmmIX4KYbVscfb/ZzNCBr
         DUJA==
X-Gm-Message-State: AOJu0Yyv84LPF4bNL1YEma1M+t8Tg8aP9UAMs0ktJuiGIMmWYOq2aiMN
	hchgbG9GAcrGQP96P+5FFSvbL4LR6LEYKbjRWKH2kYCTUi4reyy4Oxq5R0kLh29+VILj0bfg9Ln
	kkikj8GV8H8ybsHAnXh6ZZhCmjwDbr0LQI1av
X-Gm-Gg: ASbGnct9iHL5zdkzcyDSIQx29bPJnijcXsBwqW7VQoBzCTy37nozIhf4Kj50GQsfpE0
	sM2XeEqaXaJy+Oe7YjMgd8MNe4GyGWeI0NMzXBm4UbpkvNulp1lDX/hadY7Xg9RxkLqxkT3HyOp
	PflKSeBzP/xAuEk3cDRwrgn6mGWpFNi7/obeTr4S1lKKog0w6f/nNdoVa+ywr0PpA+EszCm+R8H
	PzNOH9Mc5khCBd1jGLeStzH+ILFdQaBlcgBBCDv
X-Google-Smtp-Source: AGHT+IEt83eOyPG+2BzihC0sNiY4QbGkC0WOz6gGm40sTTQYEC0vjQaTI0hm2Mca+uwPYIjY4B7vIHtHwOG0x1pBCm8=
X-Received: by 2002:a17:907:7fa8:b0:ae9:ca8f:9642 with SMTP id
 a640c23a62f3a-afa1e04122bmr76570366b.15.1754946861676; Mon, 11 Aug 2025
 14:14:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKkAvayK9WRBLtPL7XCsBP=UGbYMnDYE6+EPRpCxJioryNeBBA@mail.gmail.com>
In-Reply-To: <CAKkAvayK9WRBLtPL7XCsBP=UGbYMnDYE6+EPRpCxJioryNeBBA@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Date: Mon, 11 Aug 2025 17:14:10 -0400
X-Gm-Features: Ac12FXzVpR7P9MnumSeYs4YS2NgboQ653-378LUxFurmy2gGLHUbjTd4UJSSRZ8
Message-ID: <CALnO6CAJsXJXDtw_ewXnV4rydmnfh4Fm=eDE9WQ0_t8BpFEi_w@mail.gmail.com>
Subject: Re: [bug] git clone: -c key=value missed when cloning submodules with --recurse-submodules
To: ryenus <ryenus@gmail.com>
Cc: Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 10:52=E2=80=AFAM ryenus <ryenus@gmail.com> wrote:
>
> Given 2 repositories, the 1st is "parent", with the 2nd as a submodule:
>
> * https://remote.host/parent
> * https://remote.host/submodule
>
> When cloning the parent repo with the below command:
>
>     git clone -c key=3Dvalue --recurse-submodules https://remote.host/par=
ent
>
> While "-c key=3Dvalue" is properly applied when cloning the parent, it's
> missed when cloning the submodule.
>
> Here the actual key/value is something like "url.new.insteadOf=3Dold" for
> authentication purpose.
>
> Fortunately the following works:
>
>     git -c key=3Dvalue clone --recurse-submodules https://remote.host/par=
ent
>
> Ideally the first form should also work.

I don't /think/ this is a bug: the manual for git(1) describes the form

    git -c <name>=3D<value> <command> [<args>]

as

       -c <name>=3D<value>
           Pass a configuration parameter to the command. The value given w=
ill
           override values from configuration files. The <name> is expected=
 in
           the same format as listed by git config (subkeys separated by do=
ts).

Meanwhile, the manual for git-clone(1) omits "-c" from the synopsis
(?), but does say

       -c <key>=3D<value>, --config <key>=3D<value>
           Set a configuration variable in the newly-created repository; th=
is
           takes effect immediately after the repository is initialized, bu=
t
           before the remote history is fetched or any files checked out. T=
he
           <key> is in the same format as expected by git-config(1) (e.g.,
           core.eol=3Dtrue). If multiple values are given for the same key,=
 each
           value will be written to the config file. This makes it safe, fo=
r
           example, to add additional fetch refspecs to the origin remote.

    [ some caveats omitted ]

So they are 2 different commands, and the position of "-c" matters.

All that said=E2=80=A6 upon a re-read, I see "this [config] takes effect [=
=E2=80=A6]
before the remote history is fetched." So let's take a look at the
omitted caveats:

           Due to limitations of the current implementation, some configura=
tion
           variables do not take effect until after the initial fetch and
           checkout. Configuration variables known to not take effect are:
           remote.<name>.mirror and remote.<name>.tagOpt. Use the correspon=
ding
           --mirror and --no-tags options instead.

Perhaps url.<name>.insteadOf deserves mention here?
