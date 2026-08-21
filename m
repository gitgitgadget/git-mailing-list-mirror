Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B3947CA8D
	for <git@vger.kernel.org>; Fri, 21 Aug 2026 12:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787315898; cv=pass; b=P6xVCOuDmOVQx8O3pT9bBNU+kZN7/8avoCKyQtUUryBHTiIUdr1Q8d22LZW+M9WIlnN40DIBaBS3R5ikCcTM9sEHOYBmY0rSSC3UKwyZgCGdGY+zwd0PRmcMmfQ2MrpED0upE1PNXFQtZ9Vp7TVhJ+kKhFHz5Mwt/j8quRXF5HI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787315898; c=relaxed/simple;
	bh=mBPicloZtal8xOLbztYqH4NZpxAdDJi9OxVXItoEOKc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sH4lkJFxwsu3bMAXWmpN6Ugq6CKrXMSslL26bjiiOCq6U7IfvgdtKg9nHapINwwGyduH+eYzg7HF2MbPnaeL5BMoXkdebzObZUTREj95jOjMAJMGCqhXzUsxBKXTk78Wr8+eClctLvbvR9tgNH8YodxXuszChL1W6c20QcVYC4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mfsR/r/K; arc=pass smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mfsR/r/K"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-74ac3ea9c60so296973137.1
        for <git@vger.kernel.org>; Fri, 21 Aug 2026 05:38:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787315893; cv=none;
        d=google.com; s=arc-20260327;
        b=gQa6XL68ozkddoT3htslb89y2KhlGiBuXFjngWwSjlgfRenScdcZMmtASyyAFDpbp+
         JbsvvSVCQoiz4EuAofPmv+R5xQfL8E7f9OUI/7ve7pqHO7Q3ixYQBwkeHwL8QYzpHyjj
         fidkw3dAJhiyvDkKHJgWLgGXNkeSoldxoyeQ8iJ62viNlTdphd1d/+gEP4AonwsfP42o
         IPMQk6zJ8geJwEQCpg1lO21/MlXxiye9tWi6/bmfOlNnh57KoSCd8wPCKyMooGhPitp4
         jtm4o9uAe+K/zw2UniIXkhhpmmAVoc/Xe82QLSFZWlS6ttXhUtsCDBpq8GTW2lRPxYov
         XgmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=2jwYVRPZLErVH4WvmY7mcWgZZl6vVovggUwBtAIyj6Q=;
        fh=QD5PF7gH8/6Y86iPLgnwxn0PCC1G8XNpSnHML+KOX/E=;
        b=bZObTIk6FCjcEam+LKNt3MRCmgiT6ND4c6pPPdkek8DETihUFyiOvto5MCIKo+/j9g
         iE7lRZmbuIs8WMLKjGUEQ1GWnIFKAfj6yfVrWTOK/POeysY5tZnERWec7JqvWIb3q+2m
         84vslyi+uPCRoyyt/mz1FLuSF/LPEQ9jML+J755rvFN4+o8SyFuOS97wcSEFhyB5qPxB
         UqSO4xLLwKa6pn6IxWgKKeuV7DuV1FpgtkA3GTHuigpsdbSzCKxM+7P4YBCuNsMUq22b
         f+meGlBI9ZCWPrJshCGKOJAqgW3pbSzhCIcA4l9acZkYZCIBygtiy2a7YDEI734v3pTp
         GFPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787315893; x=1787920693; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2jwYVRPZLErVH4WvmY7mcWgZZl6vVovggUwBtAIyj6Q=;
        b=mfsR/r/K2B7kopx+NZgF6RlqXCnraYqPx2LRfPTZcakFgLQeJWz2Zad6rqCUM2gcrh
         ZCU+qHv6AFLKZskoe0KPWRLag+cedLCU3mIi+N+B81kBRPW1eZ18BkqAaoNpbRuRZfyu
         hrSrsK1PL2IOfv+dW8HV+Dx3uNeTKf3ak+2hi3qb2eCl4AHx4cLAC3VCXDO131ocw23X
         1FErCNruKWNCuMj0SjaAHw0R7dc46HH/0SVui0NJBKi64iAX1Z4bsETvRbTxp67oMA/+
         agIthAo/vrGKBoWukRXQ9hfj4PBHFmgULOIUIG8+JOOg6kWsWoJNGxEtDKJtZAXVtlrI
         AHtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787315893; x=1787920693;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2jwYVRPZLErVH4WvmY7mcWgZZl6vVovggUwBtAIyj6Q=;
        b=TNknY4A1g/SKZr+ydCCdVvVWUrqU+AQAMfXmppbEpDiP3b5yOGInsJNuG8t1tPSJ0x
         S6yrS3fb8rU/L4gQJxcnTdYrUF5Yf7oPPzABS6dPg+sYjbcm5EMVQd5WlU3tarveAx0c
         b3qStC6WH7f5t0AQHqH8eCt/vd78CdUUs3gRhp5oUWU7zUCMinM+J1zj0eKnnyvP9xoS
         sNSgvf/MSeDFMmnzJF5ArzUT4G6t8XxHYwap0YixBFou04FDd9UfZRbzUyIsl1/vwJYM
         nE7cN9LCelrfNFf1cl+AYUL/00OkVUiTWFv5nFJoQbhENZXOQpe3ixG5+QodS1WkFs6m
         2/tA==
X-Forwarded-Encrypted: i=1; AHgh+RqmYjgiqur4KW5k2aU/VWSI+tGp9REWdm37Q9XS4ot6PcdZYJURxGsdFBXnCi8WVH6XLfg=@vger.kernel.org
X-Gm-Message-State: AFuF++nGISh7sLMXEFvdywJXYQfRchOZuVlM1tmkBxwm2Bske3lWFqqu
	p+eHIqXCB+MadtljubKhpK3CgCTD+iG3zrdPTEuSPAU7RSejaeBcc7tggdJeNq6HlZkS1UwdFTF
	FFVrSJrDYvNLR0yD4VQhMBDGgz9rzuG8=
X-Gm-Gg: AR+sD10HiNh2ol5aI7Bl8Oct/7cv1dlS2QQ0/Ho2ThC6nn5jqX3+SYB0oY0RmtHr52o
	bGZiKqhtT5eqzY6AW8QyH84df//8X00SJF6OdV8gVNAM8UsT18YWJJQX60Jg2aXrpr5cbJQhhKg
	/3/i5tgbjoQ9KGRbn2YtclqAzDtK06DtsuumzYkklM54pFpFTWdTnrMj3RBX98BQK0PTfqbI/xi
	trbNndlgwDn5wEa+hDnElJLXP26injgAxc9csqxUuR7UhNp+mKr0+Hv1oZ+9BaE9NEHRZcAxy1Y
	73JxHHEQfznIMOFitxGzCgnQiddcgZZ4sdPQUlbg1+CHyLBGRYXS8k5RhlDxVKe23NH9aPTjU6+
	pyA==
X-Received: by 2002:a05:6102:1814:b0:77a:d089:3dd8 with SMTP id
 ada2fe7eead31-77ad0894d2cmr684192137.12.1787315892653; Fri, 21 Aug 2026
 05:38:12 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 21 Aug 2026 05:38:11 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 21 Aug 2026 05:38:11 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260821-b4-pks-odb-generate-pack-v4-0-074e8bd641f8@pks.im>
References: <20260807-b4-pks-odb-generate-pack-v1-0-7dec431ae7cd@pks.im> <20260821-b4-pks-odb-generate-pack-v4-0-074e8bd641f8@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 21 Aug 2026 05:38:11 -0700
X-Gm-Features: AcwNN1Wu6ooPbFpByGp4-LTXuAs6wquSUjxxM-WT3Yr2RIq9iAtQHm6Jn1k5R6g
Message-ID: <CAOLa=ZQMjb1SzYTVVuMF0ajmre_5_q=L6bmSQwYY233f-RiVXA@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] odb: make packfile generation pluggable
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Elijah Newren <newren@gmail.com>, 
	Justin Tobler <jltobler@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000e22ba706598de8c4"

--000000000000e22ba706598de8c4
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this patch series makes packfile generation pluggable.
>
> Note that this series only makes those parts pluggable that are required
> for the transport layer. The other parts that relate to packfile
> generation as required by our repository maintenance is kept as-is, as
> there is a bunch of options there that are way too specific to the
> "files" backend to be portable. This should ultimately not be much of a
> problem though, as maintenance itself is already pluggable in the first
> place.
>
> It's a bit of a shame though for git-pack-objects(1), which still isn't
> usable with alternate backends. I tried several times to find good
> solutions for making it fully pluggable, but due to the backend-specific
> options it's an utter mess. I want to eventually address this though:
> same as with git-refs(1), I want to introduce git-objects(1) to care
> about all things ODB. And as part of that command we can also introduce
> a command that generates packfiles in a generic fashion, without all the
> cruft that git-pack-objects(1) has. This is part of a future patch
> series though.
>
> Changes in v4:
>   - Improve an error message.
>   - Sneak in a small stylistic fix while at it.
>   - Link to v3: https://patch.msgid.link/20260820-b4-pks-odb-generate-pack-v3-0-bc42252f6169@pks.im
>
> Changes in v3:
>   - Fix a use-after-scope bug on abnormal exit when child processes are
>     cleaned up via `mark_child_for_cleanup()`, as noticed by Elijah.
>   - Link to v2: https://patch.msgid.link/20260817-b4-pks-odb-generate-pack-v2-0-4c8a96ccfdb3@pks.im
>
> Changes in v2:
>   - Mostly remove the dependencies on `the_repository` in "bundle.c".
>   - Link to v1: https://patch.msgid.link/20260807-b4-pks-odb-generate-pack-v1-0-7dec431ae7cd@pks.im
>
> The series is built on top of 2c78326f81 (The 11th batch, 2026-08-05).
>
> Thanks!
>
> Patrick
>
> ---
> Patrick Steinhardt (6):
>       odb: introduce interface to generate packfiles
>       upload-pack: generate packfiles via the object database
>       send-pack: generate packfiles via the object database
>       builtin/bundle: refactor option handling for progress meter
>       bundle: get (mostly) rid of `the_repository`
>       bundle: generate packfiles via the object database
>
>  builtin/bundle.c      |  34 +++++------
>  bundle.c              |  97 ++++++++++++++++++--------------
>  bundle.h              |   3 +-
>  odb.c                 |  21 +++++++
>  odb.h                 | 152 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  odb/source-files.c    | 149 +++++++++++++++++++++++++++++++++++++++++++++++++
>  odb/source.h          |  33 +++++++++++
>  send-pack.c           | 101 +++++++++++----------------------
>  t/t5516-fetch-push.sh |  12 ++--
>  upload-pack.c         | 125 +++++++++++++++--------------------------
>  10 files changed, 508 insertions(+), 219 deletions(-)
>
> Range-diff versus v3:
>
> 1:  4a56334af1 = 1:  33039a0ab8 odb: introduce interface to generate packfiles
> 2:  1ff0eaf6b7 ! 2:  7093fcee83 upload-pack: generate packfiles via the object database
>     @@ upload-pack.c: static void create_pack_file(struct upload_pack_data *pack_data,
>      -	 */
>      +		oid_array_append(&opts.haves,
>      +				 &pack_data->extra_edge_obj.objects[i].item->oid);
>     -+
>     +
>      +	opts.thin = pack_data->use_thin_pack;
>      +	if (!pack_data->no_progress)
>      +		opts.progress = ODB_GENERATE_PACK_PROGRESS_STANDARD;
>     @@ upload-pack.c: static void create_pack_file(struct upload_pack_data *pack_data,
>      +	opts.progress_fd = -1;
>      +
>      +	if (odb_generate_pack(the_repository->objects, &generator, &opts))
>     -+		die("git upload-pack: unable to fork git-pack-objects");
>     ++		die("git upload-pack: unable to generate pack");
>      +	odb_generate_pack_options_release(&opts);
>     -
>     ++
>      +	/*
>      +	 * We read from generator->err to capture stderr output for the
>      +	 * progress bar, and generator->out to capture the pack data.
> 3:  22a19a9a70 = 3:  0a2ca04c01 send-pack: generate packfiles via the object database
> 4:  5d2275c90b = 4:  2d339ee7b7 builtin/bundle: refactor option handling for progress meter
> 5:  0f00e6d234 = 5:  3cf0210247 bundle: get (mostly) rid of `the_repository`
> 6:  ae6af210ff ! 6:  d3345e4407 bundle: generate packfiles via the object database
>     @@ Commit message
>
>       ## builtin/bundle.c ##
>      @@ builtin/bundle.c: static int parse_options_cmd_bundle(int argc,
>     + }
>
>       static int cmd_bundle_create(int argc, const char **argv, const char *prefix,
>     - 			     struct repository *repo UNUSED) {
>     +-			     struct repository *repo UNUSED) {
>      -	struct strvec pack_opts = STRVEC_INIT;
>     ++			     struct repository *repo UNUSED)
>     ++{
>       	int progress = isatty(STDERR_FILENO);
>       	int version = -1;
>       	struct option options[] = {
>
> ---
> base-commit: 2c78326f810173a4f3aefd8021f1e07575412481
> change-id: 20260807-b4-pks-odb-generate-pack-f30fbcdef3fc

Everything looks good now. Thanks!

--000000000000e22ba706598de8c4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 117aaf1f9f787c79_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xSVJxOFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNVZiQy80OVlOcmdHVGNvaXV3ZFY1Ni91OUFuVm8wdApvV2ZhN0EzTlAr
R0lNbmlIZnYwWVN1enBySHpYNzZ2QVJoMkNoK2N0NW83K2J4T3AvY2VmK2c5YktFa3F1azNBCnU3
WUMyakoyRXFGNkV3VlB0ZlNXUVE2S2R1TXRPNUMzMTgzTmJMeTZiQlBIbGNTeU1NUkR5NVVlRFJ2
SlVueUgKN3pTVWYwYVZHZHgrMTJhMWtwTnBzdVJEU3ZFTlZrb3h2YUx5bnl1QkZTZ1p1WHBQbnBu
R3RrM2FDblM3VGZqeQorZFpmR3hiczdXTTlLREVzWnpIWTNZamlIS2dqeTNRa0hiUi9oeGJiK2d3
M2VUaWpmWlZVRHhkcFhXS0xaajhnCmhsNkRuZllkZUJtbW5sK2JQZXNMNFR3SzlQRVBCcEx5YUZa
SjBHV0pNM0djdGpROWxjekJXWUtmK1gyZC9vQmoKaGRoblpjQ0F4TUJsN3ExNFd0Q0E1d1AzUjJU
M1FGU1VndFFIZnZzazJROGRpVkRQRHptNVQrUXBwNGl5SGd3Mwo0VEJCNVFPeDRwVzdsWUFxZmFu
b2RXZkFHTWRSY0dBWHVTSHUvZjJmVGt0eU1UL0dsYkhydzZmK3hLRlA3cVFwCm5HbzNjVVBETi9j
ZXMzVXpOV0FkNlVpTEN1dll2NkkvR1NlZWdPaz0KPVJjYnYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000e22ba706598de8c4--
