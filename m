Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.208.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793787953;
	b=J3TN6y3FWp0F9esI8qcf2TeZTuUWD6Tt/RSYcD2d8dJbYyki5hozFXl5eGh0HdSMHnOW
	 86O7U2hVuVXXCnbBLFH9mQEY5DA4T4LW7eTqiWluKowxRB9n00la1O5yhYvcgpGESPQKT
	 cOxOE+W2xwLWwWjJ2Z728yq6KjtHmTNj11o5d3Fm0kN0KEDhoMP5rl/mu8iEPE2iDAsyn
	 IeFAEcArnqdWSJhJt8tgfkJh8Lcl+MGgSisWk75umUwCENgahnauuPAGeAXbhrEZc8C0D
	 L+UB4jmZSS1nyoSzjO/jo0vlCdfU1Ts1E1Od2cmtrnNpnEzb0Zrz7nBVNqUAklyIQnw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793787953;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=hQJyBYcB7GLvWeI1pyzuvuyDKc7HIrS4/nSGsELuh4A=;
	b=jOuqNz/AkfIhcE90bbeNAxsg/JKT7oFjr7md22ZfSoiQGuzFZbax3IBY+tQA8adraXBZ
	 ZHxKN7bfEqy6ptf4LUReww0F08rMfScOF39gs5IX12+5oc3aYNXe2hGPgFFWO7mNGSBc0
	 RNFLD9926i1DgZvUGGSb/f9ec5pPpUt3YzXYD4Vo0VbXfU2Nm9KoqXfLoy/D/QAm1RuP/
	 9i280SFFGdQNDuHxd7wZBeZ8CZjuOFtY84v3A03hLVX6Rdlb5zAQlcly5a83VURizBLqL
	 UzG9mb79GJub07S1+iTmgTmN6cy+l2Vj2JtxGP2EwcOChA+Dk5mBdEWPtS+9E0DDVjg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=spotify.com;
	spf=pass smtp.mailfrom=spotify.com;
	dkim=pass header.d=spotify.com header.i=@spotify.com header.a=rsa-sha256 header.s=google header.b=BHxdsCpf;
	arc=fail smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7234A606A328
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 10:25:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7234A606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=spotify.com header.i=@spotify.com header.a=rsa-sha256 header.s=google header.b=BHxdsCpf
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6ae305e3bd9so883686a12.0
        for <git@vger.kernel.org>; Wed, 04 Nov 2026 02:25:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793787951; cv=none;
        d=google.com; s=arc-20260327;
        b=n6iM0ZVlJKXJvf1VnOxIasUpkhOumpSYoETfgHlDemuanHugc1URnRU/Ks4VEX2MdH
         pnndspvWHADajZvBEkYmqowmnfVVTlxrc5jzOEEwIFF4Z3vSvWItuwTEv5t7kZPh3DeQ
         FVbuMjHOz3DRL0JF1YTr+6EtoogimuFB00JqmNcdcnXwolWGq68XX0ES3OsDO1VB2CV3
         lnV8hEmWnIZ0lAGl30+6TusXvX2NvqLwvpkFxO69OH69rwwYcyb+zksUhHKoQLF3TlFG
         vcVECskySfCorhkf1YhXtnhIITYm3Z3BEQjVlJDIVgKyWKj47VFLIP4vGQ3d2XiLXwCQ
         +OTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=hQJyBYcB7GLvWeI1pyzuvuyDKc7HIrS4/nSGsELuh4A=;
        fh=nlPMMkihcGe7OC8eFJQ6rrqArhFtr8zkO1r4hB2opI0=;
        b=fBXZIigkyAcceIjMYyX6/UWqGr8dXG0KSwuERNhi6o0zUAeUKxE5BZqDY8GtBwOF0T
         Tm0hYIAE/zRBEm7fbyuEQ3YATUqfGHdJJj5WRz9CFckxrqIEKyNB324c45TqvMrjlImv
         VOCMzAaO3Rh33dxrLpCZ1eG4p/48GMCAIwoGu5pKaAPkIAdKS5lgDKRWtwt2s0kibRE5
         UvSYF6R9TGEbXDJdHHft2z62CE8VtdLYMTXKcPmP83HocMiXgG/IVGIOP4wOCsGbYZoi
         B5P7KJ1syhnQ81l8bUKc1WfXkFNAXFPbzRPp7TlGUonsT5yx/MDCmWBciIkabPupMVN1
         19xg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1793787951; x=1794392751; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hQJyBYcB7GLvWeI1pyzuvuyDKc7HIrS4/nSGsELuh4A=;
        b=BHxdsCpfCj2kGZQDNoPlpwr+rApqzD4LVNQE1QJ+JNnmhfw0nV5UXaCMJwCOcjtX9q
         qLevYKX/NIhYo19b6Rty7uLbJyQn+rLesF+NwsElpcgUdpY26NgKlL1GuGxmnrPFkU0j
         1IlH8meqm/HtwT2AkHiQGNfSsdt5t5HBrEiLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793787951; x=1794392751;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hQJyBYcB7GLvWeI1pyzuvuyDKc7HIrS4/nSGsELuh4A=;
        b=V0IoMQBw/hpo4K/1fqVY37RmunDNKRweL0SLEXIhPpaeJp6R/3gOF8qnfktwuO7GlW
         JBuJHW/OBQTMqcHtYQ+TZxv6yDj/aCfVxvLThuAM/AMlulBJu2EALxMSLd6aHYPSrnrc
         K32aOSMhh7tUn+OJcNnjNh35h1hb6JP+txOIEjA0jlsPluGgQUV6IhysYCPbTehp8fae
         y5u/eib2EQ7SCBdnHg1H63EoR0AXlMChyemcxT1HypZYMUTidsd2KWPaC0JRy5zR2ooL
         q0dVkHfIXQ6TCg5tHv0zI+KX7P3oA5iItw8rr1hpqTS6X/ObGSCuAyPUszKkIRUVKA6w
         Tl3g==
X-Forwarded-Encrypted: i=1; AKwUvBwIoqDtdT7wxwLbESxDn9zmLgP2xtysJ9W5VERRDaXPVNoBU18LN97ceahY3Vt5y4oKlIg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Oio/hv9AZSd56M+Lwt1u5h1rntKWXK4YNwrSIdorbIoTTq3op
	vplm+4PmOB50RocA/SjA9fRTeI9ODgLNUI/3hOaB2+C3h3MJ1c8wcMBGnpd+HBKg3rp7kwXYEq3
	Q3aCH//aQBTx1qHws4OVzXxpmyzH62EESG1a6RMiLwQ==
X-Gm-Gg: AYBFou3Tko3w3Fsr0OYxwLucJtb19vSgIxZ2ijQRlUzjhPbmP6xKK2sy0O3FQXqo70V
	t7ujkMA/PA0c1ezks44bmdj7LT8wE5HSx9c4SoiQTaEIhmlspZCFjVxxXh1bXsrHUi2iEPZiQJn
	469mV1PilZY/SD8aza5XS6WpTSftSvdoWtrleNmBB+gUu1Mo7+Id1um2wmTZmKkrFQnfRI8vCJg
	LoShA8GgG3/GY+Edc62snrMmEKYiHC26SiMNcVCvpeJY03cHD/124ii7NiSg1j79PfSCsJme0AR
	9vskp2tfrkaO7kciL3gfwlry+hboN1JEhZ7IuQJZ0VvjrYSTZOveVsYHTvcNoqDGV6fLzEXzUOJ
	4rfl44EgnY+vcs1wYUlpQ9ZHPZ0ilN1GN1Ks1/Q==
X-Received: by 2002:a17:906:dc8a:b0:c46:7645:861 with SMTP id
 a640c23a62f3a-c4ca7936230mr1330321166b.7.1793787950816; Wed, 04 Nov 2026
 02:25:50 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2285.git.1793200705017.gitgitgadget@gmail.com>
 <pull.2285.v2.git.1793619933300.gitgitgadget@gmail.com> <20261104024806.GA1492379@coredump.intra.peff.net>
In-Reply-To: <20261104024806.GA1492379@coredump.intra.peff.net>
From: Kristofer Karlsson <krka@spotify.com>
Date: Wed, 4 Nov 2026 11:25:38 +0100
X-Gm-Features: AclHuK_VAMgZRhGQofyEGSyE-l8sUP8D7uVs46XoPsOiaEa0D2ItnXKo0Zka50M
Message-ID: <CAL71e4OreARF+dbCU3S8-_umrFEptPLPUiPDH3SYBx6OYjVpfg@mail.gmail.com>
Subject: Re: [PATCH v2] odb: do not list our own refs as alternate refs in the quarantine
To: Jeff King <peff@peff.net>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>, Justin Tobler <jltobler@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Nov 2026 at 03:48, Jeff King <peff@peff.net> wrote:
>
> I.e., I'd expect the code part of the patch to just be:
>
> diff --git a/odb.c b/odb.c
> index 2c93a9490c..f9ab5c8e7f 100644
> --- a/odb.c
> +++ b/odb.c
> @@ -183,6 +183,7 @@ static int refs_from_alternate_cb(struct odb_files_dir *alternate,
>                                   void *payload)
>  {
>         struct strbuf path = STRBUF_INIT;
> +       struct strbuf repo = STRBUF_INIT;
>         size_t base_len;
>         struct alternate_refs_data *cb = payload;
>
> @@ -198,10 +199,16 @@ static int refs_from_alternate_cb(struct odb_files_dir *alternate,
>                 goto out;
>         strbuf_setlen(&path, base_len);
>
> +       /* XXX could realpath once in caller as a mild optimization */
> +       if (strbuf_realpath(&repo, cb->repo->commondir, 0) &&
> +           !strcmp(path.buf, repo.buf))
> +               goto out;
> +
>         read_alternate_refs(cb->repo, path.buf, cb->fn, cb->payload);
>
>  out:
>         strbuf_release(&path);
> +       strbuf_release(&repo);
>         return 0;
>  }
>
>
> and keep it totally local to the path hackery in the alternate-refs
> path.
>
> Or am I missing something that requires more complication?

No, I think you are right.  The quarantine parent only matters when
the object directory is not under the commondir, which is rare.  Your
version is essentially my v1 without the "this is a hack" framing
(and also cleaner).

> > This is safe: alternate refs only serve as negative tips that are
> > assumed to be complete, so dropping some can only make the traversal
> > walk further, never make it accept a missing object.
>
> That's how _we_ use them in the internal callers, but it's a rev-list
> option. So we can't say how they are used elsewhere. That said, I think
> this is a totally reasonable tightening of the definition for general
> use.

Good point.  I will reword that part of the commit message so that it
does not rely on how the connectivity check uses them.  It also seems
in line with what we already do when loading alternates, where
listing the object directory itself is ignored as a common mistake;
inside the quarantine, that check just compares against the
quarantine instead of our own object directory.

Justin suggested fixing it at the transaction layer instead, so I will
wait to see where that discussion lands before sending a v3.

It looks like the remaining options are:
  1. Go with your proposed version.
  2. Do nothing until the long term fix.
  3. Just add a regression test for now.

Thanks,
Kristofer
