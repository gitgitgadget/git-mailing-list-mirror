Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DC73290A6
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 08:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783414255; cv=pass; b=WS4X/1L66Bm/I+naEnQEQgiXB32t54rKL3amZx/jLb6eGuIROiBDsxOEg2Ox2Yb2rpx4f7USyNt0AB5aN+3NILlMBiGzoJcahIKmB53M4ttM+4r6LJDGOXqdEkkxG36OE4CHX8yEsBwCORak5CekYdvRIxfrc2E21f4EAOFJNdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783414255; c=relaxed/simple;
	bh=V2TPXNa7SsWCWQZxgp4S989e1UWfwNdWw0E78Tr0nkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rdURBo5AeGnkRptj3QyPPZK8jV+U73RfB+BGZMPIucq5vGvAjH6FZd9NA2e/Pg3CkrJoLKJwkLyInC2UhPTxDVwZm+oyFEQnQTLFSOa3U2of0yOWW654e6X/+CTOALn+0sV2fUwesuBXDZ0m2lyCGE7ffKD37F2hCIjGgtpCbGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C85b/Kkt; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C85b/Kkt"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7ff05e5d009so45291687b3.1
        for <git@vger.kernel.org>; Tue, 07 Jul 2026 01:50:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783414253; cv=none;
        d=google.com; s=arc-20260327;
        b=HrchXJ4eQmyECAvxEpZTODaWfCvx3jQ1AhUnuJDTNKEwqgJUeMO88GCXLxyvhB+r6h
         9/8pk94FW+irTIMj4EudAWzUJgQ0E059srjlwKESWRRjJsemQ2ikNIwQr/CjZrAom8KP
         zh7Ync1doT3guspWSVE6X4X8ZiliVkXSoFA1uE6fIqwpQQMiyC/4x+j1xFF/wiOas9Se
         loN6n0UadXz2Wk031tJeCC6rgQ8HP+Q0YLVkV75NM8jj/1L4hGMOmZgJqC26Iu3hi74Q
         eRP2QrtSRxLAZ7fOldWY38FQHr70tfbdNjZH4sRy2gwIMNQtq7MLUwpdrimFxOolRzVK
         uCTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Xwdyy7CNmTtobSNy6Nnz7urEQhPKRWAr/r30enb+wRA=;
        fh=BY0PJxl/9NWRhq6Hk5NfDhGbQiIoMa5/xMUI66hWeLM=;
        b=KBnVMkTjLr99SOjYteWp3sDpbL5Ere0HDqFu799bZAAzXqP2VTUXp1zjiwgGWkrWTH
         bawBECenpSMhH5GhZc7ZQ1myDhFIf2vkJcq8k7pB8yEbUrrwXwK+21QQO2ZUdMp/Gjy6
         3EGriwdVd6RBjtXfvO6nirP/31KYcq15B3qhn6U630NYQUDVS46QdrUvYblwUYsptzzd
         emWba/JM5XcOJ/49q/DSGQ4hDZD2k6KEGVN2U/tiMr6+oRa9L73wKfQTfu9saWprUz/7
         6NeHNsvGvQlzF/xis0/bxBZ7jCRdxqEFfEJsqeHsKV8KdLKjEltgJCG7LmqRNLxa/kWT
         Tv9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783414253; x=1784019053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xwdyy7CNmTtobSNy6Nnz7urEQhPKRWAr/r30enb+wRA=;
        b=C85b/KktjnrMbx1Z7GzQFdXGdoqL5MYXWLPI+RdGvd4bmyCn5rAuhIqXQ5aLgcGqYq
         Ya9Ok2UAx915f2mufYQsxZd0QJtvRUT2aQG2swprWMoXWmoqwpTLg2xGrvthbIYRGO96
         GffABl3G0AISsKbovA28xCEpPrkn2Ho81G9LhnOGd9V6Wl2xeU6tHxOrXCF22XgO4UG1
         luBzt2knbkfN70TY94zN1lmvknnsLPZjUShuzDYleQON1IXy/1ZgS2gMP97eidEXttpJ
         wXXGv3PS9toFzsWLIBCNMc4U/FTRIXcqNQqKwNVozPVnqbjqSLZ+Vcr7TiXI4SIA8MNW
         45Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783414253; x=1784019053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xwdyy7CNmTtobSNy6Nnz7urEQhPKRWAr/r30enb+wRA=;
        b=QC8FYa75jKH9a0+Sbd4usfZZx3TcgFdtm6JLjr0q0ITUdaDwlNYmXtE7ose+LkCXnt
         gJ8abSfbD8fnvZDBqdgtc/1KXZqbxIygZC9v2wHr/835Jz9f1bYgg4n+7mqV/TzllA2v
         h/DvkaAcLmtFP4Ml8xgcclcEDwoiKweshkt3zi57hGQArzWO/mqgtl6JypD5uQhGOTXe
         kdtUQXivNXxBktLIcmNFQciEa6cYmt7y6BDvuFQXKKEldgbr3bLpsACJWcPa8WcYhAVV
         3KPOG/byAyP61VeTAcz46xWtclovsoRWkHdJLTpklhJZc1jYNY72JJeIZkdw3CIq0Q8J
         wusA==
X-Gm-Message-State: AOJu0Yy8lCWsO/TMrAwnFylFsZ03HKaodrDrUGNpX8jhpdv3L55TnjE9
	JtEKb5yPDX/q0NdcpNAqJMDDcaGanDFwX6rNzkBKce+/AwLJ5+dus+m64tFKDEViKNH8QL+Ogp5
	Z/ZhIcbab2ZowtwgMfzE4G2G4EvKE7/V+nIcZoHI=
X-Gm-Gg: AfdE7cnfWW7Flh8MZPjv2VcpHBIQAma4Evnpl8ce0FryUAaMCp03XaD4ohMK6TiMpJU
	2pD3FX5P/HQBDAv38RiVRkhFHnuLZR5CgcxjIviA/0RN6p1w3sYXyxoRubvruKxKjhAR9nzOQHa
	IUKU9+I02BNPiMKDzBFCPNJ5GenHqHoNtQwU0a/3b00FG10+3GwzTZiy/uDzhUNYCeWhYhRHDW2
	8qVPZNS3g6+Pz1c0PP7F9iEn1mTb3AgC1o2hqvbuca5BMOepcJeFykdfMhx9IRlYvt3Zgw7NSN2
	EdgwYSmkl9njv3dItnWqLV2N9bgzxs1t1LATxKm9duSliJ+JdvZF6vW4wJLs59tndtYCYUSwILR
	dBpU6wgjM74+MbZZd0BvHRaWFMOG/Hds3/4oOCLp8XqvwSeauvOPM69FpXK5uLNiy5wOdtkA=
X-Received: by 2002:a05:690c:6b10:b0:812:d768:72c4 with SMTP id
 00721157ae682-81be2f913bdmr32907277b3.58.1783414252808; Tue, 07 Jul 2026
 01:50:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260625-ps-eric-work-rebase-v14-0-09f7ffe21a53@gmail.com>
 <20260701-ps-eric-work-rebase-v15-0-c88a43b63917@gmail.com>
 <20260701-ps-eric-work-rebase-v15-2-c88a43b63917@gmail.com> <xmqqse62obwh.fsf@gitster.g>
In-Reply-To: <xmqqse62obwh.fsf@gitster.g>
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Tue, 7 Jul 2026 10:50:41 +0200
X-Gm-Features: AVVi8Cd-jxNRmmJsGvYZjSDPf9NvSSLHgtYrA5rW_CmkckZfNCw7kNrY_SnsqkY
Message-ID: <CAN5EUNTYeDrQMor29eYMhJD0jcdRQq36ZA6BgupV8gG9xs9rFQ@mail.gmail.com>
Subject: Re: [PATCH GSoC v15 02/13] git-compat-util: add `strtoumax_szt()`
 with error handling
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, chandrapratap3519@gmail.com, chriscool@tuxfamily.org, 
	eric.peijian@gmail.com, jltobler@gmail.com, karthik.188@gmail.com, 
	peff@peff.net, toon@iotcl.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El mi=C3=A9, 1 jul 2026 a las 19:30, Junio C Hamano (<gitster@pobox.com>) e=
scribi=C3=B3:
>
> Pablo Sabater <pabloosabaterr@gmail.com> writes:
>
> > From: Eric Ju <eric.peijian@gmail.com>
> >
> > We already have `strtoul_ui()` and similar functions that provide prope=
r
> > error handling using `strtoul` from the standard library. However,
> > there isn't currently a variant that returns a `size_t`.
> >
> > Using `strtoul` is unreliable because `size_`t is platform-dependent,
> > `unsigned long` could be too big to fit into a `size_t` or too small to
> > hold a `size_t`.
>
> It is somehow annoying to see that the commit log desciption, which
> is *clearly* meant to be plaintext, is so heavily riddled with
> backquoted references to code/program symbols.  Yes, `literal` is a
> correct way to format them in both AsciiDoc and Markdown, so we very
> much welcome them in our documentation, but not in proposed log
> messages.
>
> In any case, you dropped 't' in 'size_t' outside the pair of
> backquotes.

Ok, I'll drop the backquotes for the commit messages of this series.

>
> > Use `strtoumax` which returns a `uintmax_t` guaranteed to be at least a=
s
>
> `strtoumax()`, as the convention you used above for strtoul_ui() is
> to suffix function names with ().

ACK.

>
> > large as `size_t`, add a range check against `SIZE_MAX` to prevent
> > `size_t` overflow.
>
> OK.
>
> > This variant is needed in a subsequent commit to enable returning a
> > `size_t` with proper error handling.
> >
> > Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> > Mentored-by: Chandra Pratap <chandrapratap3519@gmail.com>
> > Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
> > ---
> >  git-compat-util.h | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >
> > diff --git a/git-compat-util.h b/git-compat-util.h
> > index 8809776407..5ecce5bbd2 100644
> > --- a/git-compat-util.h
> > +++ b/git-compat-util.h
> > @@ -975,6 +975,26 @@ static inline int strtoul_ui(char const *s, int ba=
se, unsigned int *result)
> >       return 0;
> >  }
> >
> > +/*
> > + * Convert a string to a size_t using the standard library's strtoumax=
, with
> > + * additional error handling to ensure robustness.
> > + */
> > +static inline int strtoumax_szt(char const *s, int base, size_t *resul=
t)
> > +{
> > +     uintmax_t uim;
> > +     char *p;
> > +
> > +     errno =3D 0;
> > +     /* negative values would be accepted by strtoul */
> > +     if (strchr(s, '-'))
> > +             return -1;
>
> Hmph, wouldn't
>
>         if (*s =3D=3D '-' || !*s)
>                 return -1
>
> cut it?  Since your call to strtoumax() checks that the string was
> parsed to the end by insisting *p is NUL?
>
> If you are trying to more explicitly insist that s[] has only
> digits, which may not be a bad idea, as that is what we generally
> expect, then
>
>         if (!s[0] || s[strspn(s, "0123456789")])
>                 return -1;
>
> perhaps.

I like the idea of only digits but, even though in this series I only
use this function in base 10, I want the function to work in other
bases, that's why I left the base in the function signature instead of
hardcoding it. strspn(s, "0123456789") rejects bases >10  ("ff" for
base 16) while strtoumax does support higher ones.
I think that it would be better to explicitly reject what we don't
want similarly to "-":

if (!*s || isspace((unsigned char)*s) || *s =3D=3D '-' || *s =3D=3D '+')
        return -1;

About that, strtoumax works fine with "+" and ignores starting
whitespaces, but for consistency (we reject "-" and whitespaces
between or at the end) rejecting whitespaces and +/- will be better
and make the caller format it correctly.

I'll do that for the next version.

>
> > +     uim =3D strtoumax(s, &p, base);
> > +     if ((errno || *p || p =3D=3D s) || uim > SIZE_MAX)
> > +             return -1;
>
> And with !s[0] upfront, we can discard (p=3D=3Ds) case from here.  Other
> strto*() wrappers we have may need the "cannot be empty" check,
> because they do not need any upfront validation of s[] like we do
> here (we do so to reject negative numbers), but since we do need to
> check s[] before calling the system strto*() function anyway, it is
> OK to be different here from the others.

Agreed

>
> If uintmax_t and size_t are of the same width, then (SIZE_MAX < uim)
> becomes mathmatically impossible, but hopefully no compiler or
> static checker is stupid enough to warn against it.
>
> > +     *result =3D uim;
> > +     return 0;
> > +}
> > +
> >  static inline int strtol_i(char const *s, int base, int *result)
> >  {
> >       long ul;

Thanks for the feedback,
Pablo
