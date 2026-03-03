Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516B3390984
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 07:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772522646; cv=pass; b=XRBIvSOiW3Q62YeIDJx8o5ruMytxZL05PceKYUBtrFPAY00TiglkR/R9OhkGjbrc39NlfaWF/sx6zZOiy9sLyQ1p0dx+wmF4Dbv0vJSZhI5E2h2QC9dS4ydoEgQooGBPkJBjGQiDf+/bAvXeceRQmV8bAoSeOj4xwWvjDypd2GM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772522646; c=relaxed/simple;
	bh=0IYQEx8zp3cpXzeHzJAHTMvvkcBxLVMx+BdEq0ClAmM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qjzZt2qNhJEf9FTGNY6FwvoXfk8jGGzzxQTGnmqw3Lia0ova7wckbguSvF2G0t5cIL1DbCbzDxmvcyF1eMbRjN+RILjCvA5/PadsapXe9Z+VP6kYJHPIKmMpte+EbQpNmAXANhcfH2r1Y9Fg8ymt1yAYxX7Jh+J1T4eLn11BOzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H7XXoCrE; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H7XXoCrE"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-50698970941so66278341cf.0
        for <git@vger.kernel.org>; Mon, 02 Mar 2026 23:24:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772522644; cv=none;
        d=google.com; s=arc-20240605;
        b=ioVTBBvWYe+VzNXj5DLfJi53n72WVbzZM7OS/p52wWdKiyQZsz1LgYryb7UqgTvH1e
         PH6CnKuRA11OXXKGgVcCbJO0QfaNDW1yONleAfKXshb3BPtHjo8miq/p4Slb4Fed+em2
         wAp4ryoxrt3NSqXdSWj0e6uw8GWa9k4ddj85mJ2kplyFwC2PiYKH7SL6Z7+8/apyavQz
         1nZvZX9/GWS9EUq92fJUu6P1+CibycJp1WQgvJba9Z904HvA+TEWd7cMAMHm29sZv1vq
         cC0NfO14TONOp3myvpu7poJog/ODBeHr/+paW9wg24H8FTrBTAWTRUqoWnWTh0p7yVI9
         TxgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=noOhoVsENrhPfz5BWB0OqQ+nrrkBinGCSeZDw29qTKw=;
        fh=XEO1H8+yKtQE7Mauub3AvytV/lMKxhrj0jHek6Exxaw=;
        b=Pxn7ErpYOcuKLKCLmbH9i8SEDqQHLVAwGdj2NNN2lTjKZ27fZklbHs9N+SvV/PSUU8
         qDme7pw8EGpVuiJvkT/Xg8lkd36j56+HR3A/VvYROqtgO8LYlF80PsXeTka/TDLu2bOb
         kaPvYzi9RjlPh1d4AqbBzJm8EbFgo92QV+ZqV5uYv8Au/aPzPKzQd98TQRoYSmeetTVI
         1/o5h0ZtoTmDRYRuK9nK52zWFaVp3VKZjB6vNjlJLJt3WpbQhrvQfVjFATlp5zL8DbSR
         6AucVgH7hQGflJS131mLd0fm3ERwDSydcEOLX0YTo4yKxFtQlJ3wweutfA3m7m8y3rWC
         siPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772522644; x=1773127444; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=noOhoVsENrhPfz5BWB0OqQ+nrrkBinGCSeZDw29qTKw=;
        b=H7XXoCrEUXnE11HIFqJxHZatPeGG+E4XJ3yn6dWINEUYE+21619Wc4dXuQU+MW3k+7
         vdBrEAtyiIK3keHRSVDpWq4GahHc10PE3ZVnIfdGFwubm6V7J32jg0M4fID3+I3lbQ6Y
         LsGAap6CBu2fQSNA/vXKfNqzPfKY0raZPhkMgfN0jEE8+bM3nwDLuIDun1H2UIOrH4hG
         gJiEA4rDIQ778wlbMLtmbAQ9fNUpjOWYtpoNtWfFljoUelskICV2BwQZ0igXkVNH5Wzk
         zNtNtMNPoE8MqTsVN1w8MPkli8Mdhl6WAzUs05TldfzAB/hWUW5MBeTURJsQzabxaxQH
         +uxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772522644; x=1773127444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=noOhoVsENrhPfz5BWB0OqQ+nrrkBinGCSeZDw29qTKw=;
        b=j708YdnJG8RiKbEfKL8TCWTVPxiWQZISUHazg7OFD0PFyoVFhpX6FHuf0wpsldHmDJ
         iPk9zkc19X091/l4WyaCPK5CYxmndvSj86Icy2aEycut0mK9CVY6o1eBmi7GBDHQwkfm
         HdugUZp9zBDUgDWsarmLuDl6bKQdEffD3GrGPOZm/6WrujwlL5wbwtpWLksrqA15Vmbz
         s4VBKa7dN25dLLY3S7n2Op2qEDvo1RMvGs8NYBl4NNKwMmRmq+r1fFDCY883E/a5nF4H
         c7bNEQkKyPmpzOvXsa0ApWmOU0/mEFxGBWgX+kgDNgmvbREI55l5eelKTMIKqnq41PPA
         xE2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXyxrjJNZGCtXdVJCiOVL/xIR2bLHaiFqQdOHsGX78zhxNyS0DtYKHl0a5LvM8ug6vYnkE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWJyFWg3Wjj3V/ocWzjhRWz4bObPK1ttjPmYCYkfU1ffqL854J
	eu7QKtudlnxqokdqSBJj/KUboDzv+skA4RXQyBmurZuyDtOBycaz72NVfw/29zMhjpXCQqkVzl4
	M3Ce3qRV+bCalc1ZPAqW1RNRopDUrd3Y=
X-Gm-Gg: ATEYQzyGSfuRkokII8/AVK9TWClIzTyBE5f7EQN2WJm5b3GnwvTYN7XYElf44PwGB8m
	vlUfsfVr+cH1V9BMLjmhA5c0JvL75QpLg2vUImRpiCZmoezBuuBUwPrML2veulc0oHopRCe0VGK
	KebdoYmq4mokvh5bvRSsvOKcfkaufKh2NzrJVxHbQPJRDzJibI1z7jotHHQ7fpIWGbb7yeRMfO6
	D3scWccYCtVseFuoZ/Ltvi6RIRa5vGanEJAp+xhQAqtT9qeqaAmqbbZdXYFmEV+Y7+ogvgrlosc
	UviyaJQHh9pMcsAgzSMxrJWDaKsoWbA/bDYCAeNmEkACX9l4r/lAzH2ctRmZegY7omOuVxWy5a6
	A/ioMcXgLR0xzNX2yeceutT5NYvydORxur+Ne
X-Received: by 2002:ac8:574a:0:b0:4f1:83e3:c058 with SMTP id
 d75a77b69052e-50752783584mr194698461cf.30.1772522643997; Mon, 02 Mar 2026
 23:24:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260228224252.72788-1-lucasseikioshiro@gmail.com>
 <aaSusXil9nDHYGMR@fruit.crustytoothpaste.net> <xmqqbjh64262.fsf@gitster.g>
 <3983da40-bf2c-4665-a7d9-dfebaacb8bd3@gmail.com> <CA+rGoLfbzXqP1Tw+94jMmWcSGPoefMv5E_fvwriad-O5CUeKHQ@mail.gmail.com>
 <108ccc9d-5777-4c84-9dad-c2d0f5dc2e42@gmail.com>
In-Reply-To: <108ccc9d-5777-4c84-9dad-c2d0f5dc2e42@gmail.com>
From: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Date: Tue, 3 Mar 2026 12:53:52 +0530
X-Gm-Features: AaiRm50-2iB1eOyjOOxa0sUATibAskwctMlW77mX3ZrziEl8C4xGnC-M8GdeBpE
Message-ID: <CA+rGoLc+ULYUZaDCdAHxuL8T-qyjJKTRJfSe6Muhb7c6d12e_w@mail.gmail.com>
Subject: Re: [PATCH 0/4] repo: add support for path-related fields
To: Tian Yuchen <a3205153416@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, git@vger.kernel.org, 
	kumarayushjha123@gmail.com, valusoutrik@gmail.com, 
	pushkarkumarsingh1970@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 3, 2026 at 10:02=E2=80=AFAM Tian Yuchen <a3205153416@gmail.com>=
 wrote:
>
> Hi JAYATHEERTH,

Hi Tian,

>
> > I see your point here.
> > but wouldn't this effectively be the same as Ayush's suggestion, just
> > with a different syntax?
>
> In my view, this issue is actually to choose the most suitable tool for
> the job. After all, we don't want to use something like rev-parse, which
> is riddled with *ancient* technical debt, nor do we want to write an
> even more verbose parsing function from scratch for what you call
> verbose user input, right?
>

I agree that it provides a clean and scalable mechanism,
especially in terms of extensibility and per-field formatting without
relying on global flags.

To clarify my earlier comment: I wasn't arguing against ref-filter.
In fact, I=E2=80=99m more inclined toward using the best tool for the job.
My earlier point was mainly about behavioral similarity and how both
belong to the same camp even though they might seem different.

> If I'm not mistaken, using different parsing functions to parse input is
> absolutely not just a matter of syntax differences. Instead, this will
> directly result in differences in data structures.
>
> The reason I recommend this approach is because its implementation is
> incredibly clear and concise. To achieve the functionality we desire,
> all we need to do is add the following to the registry:
>
> [ATOM_PATH] =3D { "path", SOURCE_NONE, FIELD_STR, path_atom_parser }
>
> And the corresponding path_atom_parser().
>
> This approach also offers strong scalability: If one day I decide to add
> a new feature like %(path:commondir,relative) output, all it would take
> is adding a switch statement in the parser() function (along with a few
> other minor tweaks).
>
> *I'm not saying this approach is better than the solution you've
> discussed. I'm simply presenting a possible implementation for
> reference. (=C2=B4=EF=BD=9E`)


That is a detailed mail, thanks for taking time

When I said similar
I meant

something like this:

static const struct repo_info_field repo_info_field[] =3D {
    { "layout.bare", get_layout_bare },
    { "layout.shallow", get_layout_shallow },
    { "object.format", get_object_format },
    { "path.toplevel", get_path_toplevel },
};

This array contains all the keys
You do not need to hardcode path.absolute.toplevel,
path.relative.toplevel, etc., in the array...

Instead,

If the user asks for path.absolute.toplevel:
You detect the absolute. middle part. strip it out to find the base
key path.toplevel.
You find path.toplevel in the aray, the array works with default
values when entered --all

/*
 * Helper to parse the key variant.
 * Takes "path.absolute.git-dir" -> returns "path.git-dir" and sets
opts->format.
 */
static char *normalize_key(const char *raw_key, struct repo_info_opts *opts=
)
{
    const char *suffix;

    /* Check for "path.absolute." prefix */
    if (skip_prefix(raw_key, "path.absolute.", &suffix)) {
        opts->path_format =3D PATH_FORMAT_ABSOLUTE;
        return xstrfmt("path.%s", suffix);
    }

    /* Check for "path.relative." prefix */
    if (skip_prefix(raw_key, "path.relative.", &suffix)) {
        opts->path_format =3D PATH_FORMAT_RELATIVE;
        return xstrfmt("path.%s", suffix);
    }

    /* No variant found, return raw key as-is */
    return xstrdup(raw_key);
}

Structurally, this mimics the ref-filter parsing phase almost exactly.
Just as ref-filter splits a compound atom like %(refname:short) into an ide=
ntity
(refname) and a modifier (short) to populate the handler's state,
normalize_key splits path.absolute.git-dir into the identity
(path.git-dir) and the modifier (absolute).

I just meant both the ideas are in the same camp just unrealized.

What do you think?

Regards
- Jayatheerth
