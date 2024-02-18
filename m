Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30942B9A7
	for <git@vger.kernel.org>; Sun, 18 Feb 2024 19:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708283394; cv=none; b=LNLPp+BChH2fFmmnxa/enO93evMLV3Zr9DvUY0CKHpFjYAE6XOJNhDV83g5jxZKTWhIn96dk874AWwL2PLqizHmW74ReiXQj6/pNUQIqP2r/9IsCNfUzRl93cqilX46aIJi1uZPwIKrnLvY+gowHb4/8q1jmkfR9hrQRPVwBi+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708283394; c=relaxed/simple;
	bh=10rAqGbbnEunT1rjBr77LbVIzxKxJ4d1i67BRGPaESY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ltTC/dGJOp0KjUV1MRViLz/XTW2Zd8VNORYW26MON6t8bCejnVj+wycFEmK2tiEz5fjVj8/l42l8NsQ8qqq/OvJTAkTdDQeRx+L3UdT080CXdbvlAUr2AetOb9gQ1UprZ3uz8SxO6CxeD/LeU4PkpBrleQNEJ6ITU7d7JKo34aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3bd4e6a7cb0so2698859b6e.3
        for <git@vger.kernel.org>; Sun, 18 Feb 2024 11:09:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708283392; x=1708888192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FPO1qbOkmnbScv/Dn3pxsZoW04oOthM2lR7yIKUSeY0=;
        b=del6KZVJ153VNzHdFyWhZdG5BPVt6nwxCeHzuM054xmju5FTYZ/rDJenjxjqd6IRX9
         mvDhLEsCgZLacblrQt6n2/sGeenUiPxcKBU98icuNN3w5CpMpHqdWxaA5Lw5HUW5x7uF
         0/pf0KOi9GK1eX39fw8WOAGwvAaesSxdGoWWeDdZscntKJnVcVbiAnJ6kYkqsLt7zt8b
         GiGGAVCBppQ6NNc0hoThtaJ4FS/y/0xw6cHHiEYy3gqKEOeOU81h/nDjpZsa2PVKqrGn
         b9O6aZUTZjT3eIZ3GpswOPCjzlICUpZnv2CsJOt3CcI/RxrKqEqz7cftssgvGOme455o
         wxTA==
X-Gm-Message-State: AOJu0YwgH+3aA7Rme3L8J0hIVvC/7p2KyZpuERYOpB7PD0TYncYEvxHW
	oIE9PFmlq+TjXRAh2CVPZjOtqJe83NskrIS5//iSSgV1Pi8R+MR/jTWmV6QyXwvkFm80Prb2mgK
	JB0KftjjtomkNqiv+9+YQSYG1oAY=
X-Google-Smtp-Source: AGHT+IF92Fn4yJ6ECj0VNL4zu1w8nHhOqerLDYJY6in/FrmT5aAK6cwLDX3veQOcuzUI61JHi9gU/+RXxqAO1Eiza58=
X-Received: by 2002:a05:6808:1388:b0:3c1:5391:9b17 with SMTP id
 c8-20020a056808138800b003c153919b17mr3884707oiw.41.1708283391798; Sun, 18 Feb
 2024 11:09:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFJh0PTiN18LcKP6LW0d1u2gkodBD2cOJRBzU_subBaFpzM=CA@mail.gmail.com>
In-Reply-To: <CAFJh0PTiN18LcKP6LW0d1u2gkodBD2cOJRBzU_subBaFpzM=CA@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 18 Feb 2024 14:09:40 -0500
Message-ID: <CAPig+cR5K=pQjK+7ZUyGn1M50RZ0pRD6kOPQgmp7qez_LNXcAg@mail.gmail.com>
Subject: Re: [GSoC] Use unsigned integral type for collection of bits
To: eugenio gigante <giganteeugenio2@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 18, 2024 at 6:37=E2=80=AFAM eugenio gigante
<giganteeugenio2@gmail.com> wrote:
> I was looking around the codebase for some field of a structure that
> stores collections of bits with signed int type.
>
> > ./diffcore.h:63:     signed int is_binary : 2;
>
> The struct in question is "diff_filespec" and Junio commented the
> declaration of the field as following:
>
> /* data should be considered "binary"; -1 means "don't know yet" */
>
> I read somewhere that one should always prefer unsigned integral type ove=
r
> signed integral type for a couple of reasons [1].
> These involve operations like Modulus, Shifting and Overflow.

In the context of Git, we want to be using `unsigned` for variables
which are "bags of bits", where each bit indicates some "on" or "off"
property. Very frequently, such variables have "flags" in their names.
So, a possible scenario might be something like this:

    #define OP_FOO 0x01
    #define OP_BAR 0x02
    #define OP_ZAZ 0x04
    ...
    unsigned int flags =3D OP_FOO | OP_ZAZ;
    ...
    if ((flags & OP_ZAZ))
        do_some_zaz();

> I didn't dig too much into how the field is used and if there are cases i=
n which
> the mentioned operations are involved (I would like the community
> opinion about this topic before).
>
> Moreover, I don=E2=80=99t know if such a change breaks too much code and =
if
> it=E2=80=99s worth it.
>
> but maybe I'm missing something. For sure, various If conditions used
> by the function
>
> 'diff_filespec_is_binary' inside 'diff.c' would have to be changed.

The code in question is not being used as a "bag of bits". Rather,
it's a tristate binary with values "not-set", "true", and "false".
Whereas a typical binary could be represented by a single bit, this
one needs the extra bit to handle the "not-set" case. Moreover, it is
idiomatic in the Git codebase for -1 to represent "not-set", so I
think this code is fine as-is since its meaning is clear to those
familiar with the codebase, thus does not need any changes made to it.

> Besides, it's possible that my grep command is not enough and maybe
> more "signed int" can be spotted.

There are cases in the codebase in which a signed type is being used
as a "bag of bits" instead of the more desirable unsigned type. If you
are interested in making such a fix, you might find some candidates
using a search such as this:

    git grep -P '(?<!unsigned )int\s+flags'

For example, it finds this instance in `builtin/add.c`:

    static int refresh(int verbose, const struct pathspec *pathspec)
    {
        int flags =3D REFRESH_IGNORE_SKIP_WORKTREE |
            (verbose ? REFRESH_IN_PORCELAIN : REFRESH_QUIET);
        ...
        refresh_index(&the_index, flags, pathspec, seen, ...);
    }

Taking a look at `read-cache-ll.h`, we see:

    int refresh_index(struct index_state *, unsigned int flags, ...);

So, refresh_index() is correctly expecting an unsigned value for
`flags` but refresh() in `builtin/add.c` has undesirably declared
`flags` as signed.

> P.S. I was insecure about how to send this email since it does not
> include a commit.
> I decide not to use git-send-email. Hoping I didn't mess up the format.

Using your preferred email client for general discussion is fine. Most
people only use git-send-email for sending patches.
