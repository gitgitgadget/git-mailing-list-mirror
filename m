Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38C53E4510
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 09:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787217073; cv=pass; b=sD2+2dpq72IyeXVQM1HirKDYfR5/kapIYrS+HtdcFCanB3AyqZUUek5DEPQJsV8KBGqzTlw9KH0A8kd9t+2dpSzJf9RW1z+32TF+2cusLopZmUsDxDT6Fvia7a7jvFiUMZ0OK0IQFGVY28mP6ebxHtuNAygL2ewjoUAEUkyt7EE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787217073; c=relaxed/simple;
	bh=hQnoMbBUP46LYd6UUasMPna5OhBIEW74WIkpEXMOyqU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=II/XRkIZJWMW3UHONMFGtUERHc/MHu4et9P8cRNAXPk8KT8yh5Bj2c7nAgEAnw+6T/VPr+mAVgBykepkmIKepLiBqxv4QAg74L2QxtBeFxN9Rq6c4b468jKekJjGowlRjRJvwNwFcT6nk/x86Ft+xEQ+gbsE/YT7MG0JuSwMQ74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W0YxXapa; arc=pass smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0YxXapa"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-75609e844faso666540137.0
        for <git@vger.kernel.org>; Thu, 20 Aug 2026 02:11:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787217068; cv=none;
        d=google.com; s=arc-20260327;
        b=cj6rlPfRwHo77NEWNYCd2i1FZZl1RGemhZR4ckG9B1jjtKcUAHxdgwA/P6CbZjQ4gw
         6Uy2f5QQtf6El8BlCA/4iUgW0CO/ps5wmx9Tdiyh7i2+9AqyA+lP+KlwQSnRrKM0qut5
         6HT4F7jfxUPSRg0HwLOkpurnW8W/Yd6rc2oDIUcvM63OptEjnHeBjhDyEirUunMrsoKM
         ehG0uih29qQ0VY3ER5j/RydOdpj0pkcG2CT/ltItBcAy2UcAAi/H1fckoG9LEOl+GcrR
         2RuiCrGWVDfz2z6MuMrPbP1JdkHQ7yLNhIEFkIR1XPcTaoeWoRCB4CDKpg+K2pbEEPat
         nyZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=6S9guMsslDGqShWbgxs7QzHrIL+Z/DhOePnj47raYP0=;
        fh=ilFwKrEHnlMyT6+85EZPoruq38dvY3Cv74bln5f+1CY=;
        b=m5jioLlBWFxcrQ7SZg7QOTZK+QTDuiR67vRToQYGWCFIv7wJMNU+yMOc5yDVUC4Gm2
         aSfD1Wj3xJPduylUwBb/u3WxTpDvM2p9KqjiugdiTGFO+uxBD22E6YSFK20VPv6QcUIR
         FuxjNfvTjVSWi1uscDx6AnDUAZARfdqyXzFJPLLzFZy5FBDDPVkqADbXF5dMWwchElzo
         /P6hyadXmwzqs66UBCzVeKxoB3JL8C+pPFUHwgk0AQLNMU0a0obMZjAFaJV5msrHeCIG
         H4Hjbu0BHl8Al0Bs7hwZ7IdXf5NxASlDFw8itGZBJHe99nQpMXWYfc3bYQrYoeMUv6eu
         Ew+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787217068; x=1787821868; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6S9guMsslDGqShWbgxs7QzHrIL+Z/DhOePnj47raYP0=;
        b=W0YxXapaIqAkpZLARBAdKHBRwPIy8Tv7+BwFYIFDcSYku9t2bPqDaJEXu5S5bKj89F
         1h0lCa6ga+rIlnpbF+pYQOo8bBnkGeh8I8jdSsoXid+S3RzhXulKXlXYEPZ420/9KInX
         14bj5QSQwJMElH8ZVDuOYQ3XPKM6MxFLI4nQDV2C+XX898bcc5M0TD83jM+hfNyodx4+
         Wv3LmNRUE1wyrglUO61IJBMTDraUD5kjNpje3Droz7x02ti+QgipFIWAeUNreIwqBddc
         rBTMBoYo3HYcxC9OtvOzz1VfHOXOhFJyym80ORvly/0TVumzIqn8Zu+J79sQJPd/SEpW
         KEEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787217068; x=1787821868;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6S9guMsslDGqShWbgxs7QzHrIL+Z/DhOePnj47raYP0=;
        b=P+7txVO+AFfH49wavigXAGdxF7b74U3d90gmYbHNd1uz76ZeH1x+iFuIeNN85CCJpl
         qR2CERKnmvdRNVtA67BUufcXW2xNJIBl6redgxGjgilic1tPtfZlmCdQqAZ9uF3JSqiR
         rx+8eGVF7bFtCZoOuc/sIuU67kN9xNOUWWjk53+ewo/4/fLx/cbbC3JgpV0p6pgUn4Rd
         PeNb6oI9RdvJLGyd+5EsjwZSiKSH13m4QeUrCpL/XKqK3T4PWeYOUtE3AbbjPO91If84
         5T7bnub7kaMnSYcQRncpBJ1HjnaTfNbLSEq4iX59ayRm92jTCMLgzcs7ceJcTvp5C3yY
         EOJg==
X-Forwarded-Encrypted: i=1; AHgh+RpFlaUOaxltTTQWRhr86+FAPkILUj8z11co65qanm6eY6AgssLxLBo+n7a16mMjArrevZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDgwXbYEMIk7wD9C07F0zcThPTyvIZWUOr36iAFGWuoGuV6DO1
	7YW/XnjM/A/avOvnbyjskkb4+3aB7RjMyxW6pHoJIx6HwXTJsi27dlG3do+F0JDQGO5dP/HrPN0
	WcwlnuT1HOWSQM+Vy6beVf+juvoI/irjD20IR
X-Gm-Gg: AR+sD13xFvPG4wvfqPLqzuSK8sPLZOE6JpA/fPj9O5wlTGuxcdo1RZ/Mp4TF6A5hC0X
	GoAmDZCDJZsmf3+c9YLGFGxlN8svorvb/e/X2ryrBEUQ+y7VSRKvRDup8LFJPXL/+STszZ4i8Wq
	HkDJ9brO0ae7F/QWJAEi0Prodn+QeBM2HLZeKJI2G9rqUlWckZJXf9hDrMVMMzTHqA7Qg5Jbw8g
	ncwZQzZdae+HLBXI0jx5vhCze+e9oEtmVu6/ZiFURodRz27sTuzJCkZ3YINntHz8ha9i25Fobb4
	h/OyPPmX0+78zNfLyUMLRCccdCDRStTF7oweTqaUibyO9CE6chscd7WBod/ygeH71P8N44zud5y
	C3pmsHtTd7gjKyqR4ZY+TH/dfIzl3y4Kh
X-Received: by 2002:a05:6102:5695:b0:779:78ae:9ade with SMTP id
 ada2fe7eead31-77978aeb7f8mr489342137.0.1787217068309; Thu, 20 Aug 2026
 02:11:08 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 20 Aug 2026 05:11:07 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 20 Aug 2026 05:11:07 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260817-pks-odb-eagerly-prepare-alternates-v3-0-1115a7e02467@pks.im>
References: <20260810-pks-odb-eagerly-prepare-alternates-v1-0-f0fa4a4004e1@pks.im>
 <20260817-pks-odb-eagerly-prepare-alternates-v3-0-1115a7e02467@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 20 Aug 2026 05:11:07 -0400
X-Gm-Features: AcwNN1U9W2qJIoqYEFbfiFGYe1p8ZKl0MVVVjJZXay0T72rOlSufWCabZ4wRQbA
Message-ID: <CAOLa=ZReodSXjEbQkFoxcofMLq6mUOjXANRg7bZ2uEKKQn=DXw@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] odb: eagerly load alternates
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Jeff King <peff@peff.net>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="0000000000007e5648065976e600"

--0000000000007e5648065976e600
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> when initializing the object database we only eagerly initialize the
> primary object database source. If the primary source has alternates,
> those alternates are only initialized the first time we really access
> the object database.
>
> When introduced in ace1534d6f (Introduce SHA1_FILE_DIRECTORIES to
> support multiple object databases., 2005-05-07), alternates were
> originally only loaded when a given object wasn't found in the primary
> object database. This was also reinforced by later optimization, for
> example in 693d2bc625 (Attempt to delay prepare_alt_odb during get_sha1,
> 2007-05-26), where we tried to avoid loading alternates in even more
> cases. But as Git has evolved, we eventually started to eagerly parse
> alternates all over the codebase, including on every single object
> lookup, and consequently deferring this operation does not really buy us
> much anymore.
>
> The result of this is that we have calls to `odb_prepare_alternates()`
> cluttered all over the code base. This is somewhat awkward, and as
> almost every Git command ends up reading objects at it doesn't even buy
> us anything.
>
> This patch series thus gets rid of the lazy-loading. Besides simplifying
> the codebase a bit, it also prepares us for moving alternates into the
> "files" backend as discussed in [1].
>
> The series is built on top of 010afd3166 (The 12th batch, 2026-08-07)
> with ps/odb-make-creation-pluggable at e927cfeb21 (odb: make creation of
> on-disk structures pluggable, 2026-08-07) merged into it.
>
> Changes in v3:
>   - Create object database after we have written the complete repository
>     configuration in `init_db()`.
>   - Document that we might want to drop case-insensitive deduplication
>     of alternates going forward.
>   - Better explain why we have to migrate to `struct hashmap`.
>   - Link to v2: https://patch.msgid.link/20260812-pks-odb-eagerly-prepare-alternates-v2-0-522b9a5bc1ea@pks.im
>
> Changes in v2:
>   - Add a missing word to a commit message.
>   - Explain why we don't have to handle GIT_ALTERNATE_OBJECT_DIRECTORIES
>     when re-preparing the object database.
>   - Link to v1: https://patch.msgid.link/20260810-pks-odb-eagerly-prepare-alternates-v1-0-f0fa4a4004e1@pks.im
>
> Thanks!
>
> Patrick
>
> [1]: <amLgMqkqxR8mKIbT@pks.im>
>
> ---
> Patrick Steinhardt (5):
>       setup: create ref and object databases after config is written
>       odb: decouple source path comparisons from `the_repository`
>       odb: eagerly initialize alternates
>       odb: drop `loaded_alternates` field
>       odb: drop `alternates_db` field
>
>  builtin/fsck.c         |   3 --
>  builtin/pack-objects.c |   3 --
>  commit-graph.c         |   4 --
>  loose.c                |   1 -
>  object-name.c          |   1 -
>  odb.c                  | 124 +++++++++++++++++++++++++++----------------------
>  odb.h                  |  22 ++++-----
>  odb/source.h           |   7 +++
>  odb/streaming.c        |   1 -
>  pack-bitmap.c          |   2 -
>  packfile.c             |   1 -
>  packfile.h             |   2 -
>  setup.c                |  12 ++---
>  13 files changed, 91 insertions(+), 92 deletions(-)
>
> Range-diff versus v2:
>
> -:  ---------- > 1:  2adb64d17c setup: create ref and object databases after config is written
> 1:  6255ac7964 ! 2:  736b8d8eb4 odb: decouple source path comparisons from `the_repository`
>     @@ Commit message
>          database. Instead of using `fspathhash()` and `fspatheq()` we resolve
>          "core.ignoreCase" manually and then use the correct comparison function
>          based on the result. This requires us to migrate to a `struct hashmap`,
>     -    as the khash interface does not give us the ability to change these
>     -    functions.
>     +    as the khash interface does not give us the ability to pass an arbitrary
>     +    payload to these functions, and hence we'd have to use global state to
>     +    decide which of those to use.
>
>          Note that we can unconditionally use `strihash()` to compute entry
>          hashes regardless of case sensitivity: a hash function only needs to
>     @@ Commit message
>          case-insensitive equality.
>
>          Overall it's quite debatable whether all of this complexity really is
>     -    worth it, or whether we should just linearly search through all sources
>     -    to find duplicates. But the mentioned commit cares about cases with
>     -    thousands of alternates, and a linear search would of course regress
>     -    performance quite a bit. This doesn't really feel like a reasonable case
>     -    to care about though, but I don't feel comfortable regressing it anyway.
>     +    worth it, out of two reasons:
>     +
>     +      - We could linearly search through all sources to find duplicates. But
>     +        the mentioned commit cares about cases with thousands of alternates,
>     +        and a linear search would of course regress performance quite a bit.
>     +        This doesn't really feel like a reasonable case to care about, but I
>     +        don't feel comfortable regressing it anyway.
>     +
>     +      - It's dubious whether we should handle "core.ignoreCase" in the first
>     +        place. The downside would be that we might add the same alternate
>     +        multiple times with different casing. But this is an edge case, and
>     +        it's not even fully fixed because we don't resolve symlinks or
>     +        mountpoints, either.
>     +
>     +    So for now, keep this infrastructure in-place while removing the global
>     +    dependency on `the_repository`. We may want to revisit this in the
>     +    future though.
>
>          Signed-off-by: Patrick Steinhardt <ps@pks.im>
>
>     @@ odb.c
>
>      -KHASH_INIT(odb_path_map, const char * /* key: odb_path */,
>      -	struct odb_source *, 1, fspathhash, fspatheq)
>     ++/*
>     ++ * NEEDSWORK: we're using "core.ignoreCase" to deduplicate alternates that
>     ++ * _may_ be the same. This requires quite a bit of boilerplate for dubious
>     ++ * benefit:
>     ++ *
>     ++ *   - Duplicating alternates should really only lead to regressed performance.
>     ++ *
>     ++ *   - We don't properly resolve symlinks or mointpoints, so we may still end
>     ++ *     up duplicating alternates.
>     ++ *
>     ++ *   - The value may be lying, in which case we might deduplicate alternates
>     ++ *     that are in fact not mapping to the same directory.
>     ++ *
>     ++ * We should investigate whether we can remove this whole mechanism outright.
>     ++ */
>      +static int odb_source_paths_cmp(struct object_database *o,
>      +				const char *a, const char *b)
>      +{
> 2:  4743659d76 = 3:  a9db918b49 odb: eagerly initialize alternates
> 3:  4a62dde9d0 = 4:  369a566a6a odb: drop `loaded_alternates` field
> 4:  e978a5a47d = 5:  a0a22a0bd2 odb: drop `alternates_db` field
>

The new patch and the range-diff looks good. Thanks!

--0000000000007e5648065976e600
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: d6cee469c8221df2_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xR3hLZ1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mM3E4Qy85dDlHOFJ4TlpaWUtLSEN4S1lTR1oyd3NJNApSWnord2hUbTlq
b0Jrb1VPQys5ZTVsbUxqQ2gya1VnYUoxMk1KL3BqYXRZSkpuVVlFdllpMktaMmJxd3RhRFluCjVZ
WVJxRjF1NlVaUzJEekhTVURsZGNVcklJbUtMSWNUbUFrR09ORE05K0NUQ2s0ZE0wN1BkWDF5a2dL
UUVuUkcKeFdQazBFeVJJYU02enR2TGE5RUdHbUJRVXpmQlM5MDAzN1B4TGxTTGk3TTJnamVLa2tw
aFA4QVdZK0hkM0pJbwp0cVFCc256Z2NONXFBSFRUalVnMUJPUk1sWHByaG5ib3dmaDFlTS9iZ3Z0
bGRuRUYyd1JrbXZSeVN0YXBHa2lkCkF6N244UzVKSmRjMi9tRlcraEVuajZVZDBJR3dYUXJpL3Jx
Z0EzdHcwSkxuOFcrbkU5dUowbkJPK1FOUnZHMHcKei9LeUxrNzRuRFpOY0xsNjIwdllwbjZyMnRa
TmRXTURnSk1CakdoMXF3aUVkMjVIVGg2KzlMRWtsTTU0ZXFGVApOZkJzYlovOThwUW4wb2l1Nys1
QW1YOFBvZm1rbFM4TVc4RVRORnVSS1VZdGJxSmVhTVc5eEZjZXFSZUdFL1NBCjk2aGNVM1FXZEZh
bmZVZDM2OG1JUFk5RjBlTlZacWk2dVlYN2REWT0KPTgrZHQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000007e5648065976e600--
