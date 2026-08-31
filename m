Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2473DA7ED
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 09:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788168422; cv=pass; b=MPl6jnTkBnAS0DqYvD0wgx+Cr0AHEcs0WeDDxRx2p9J9E0eNc+yfnoD1yV+myQSUe6YX1+SOksCT1+Axh8bBmpDjsaZgdNog+PbyJRFTLbkXgYMlKOOlnb2MOIzXOuuU0rcaNK1u1aqNHDgWV4Ll7UuV84AMDyu3S0sN4t2F4PE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788168422; c=relaxed/simple;
	bh=H4J3l3aYtH8xCtQ7Mt6NdeAbSskw2xav0rA+g/HAvCo=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=h/BYREO3rSy6E7K9kQDa+XxSFi+0wBZ0KHe3uZ3mIq52Sgzq17bD8iBmtyDhhsc3ZeaHGOo5p73f3MtLsx6ixhZrsFeRjjj2DTIaZLexY2hjjB5gEpeI9/qwDQZRHA3N1VeYKFqFB0zYaiJpVvf853YynZyeWV/qhtCnjd+GcJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MrQfljXa; arc=pass smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MrQfljXa"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-7841b831381so569756137.2
        for <git@vger.kernel.org>; Mon, 31 Aug 2026 02:27:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788168420; cv=none;
        d=google.com; s=arc-20260327;
        b=OxW2DTB13dFDHKXqRh9Ngd6BGVxJa3OrETzKesUOCeVlBCRpUjgp+xENJslDDPt3Dh
         pPWbFRvcLUsJmGJG2SVY7Qyqyqvl5EH9lc26RwXwoKHSdnMKKPJIpMkw2mXNMCcSTd12
         vk2h9L4aFWzUi/h5luVb8zAiLRY3kwoPNMy471LGPlS/z3ikQiyISBg51eI+DhpKA/9y
         x2byMXBJXa39QSAge55X1TFsxwrOVmWA1dFqEVAB40Oixr1BecBcvsaS3Gcw9aRqeQ9b
         6UPlg/jbrAB1Qya/9ULHX2861u0xxb/GzuvHs4IFtSmxM7QBm3El3mvJ7ozkmIfnnnH+
         GqJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=ESQuHX+UHFhuuv2vinVyRZkjpMVp8tNaasHvCNkJoFg=;
        fh=1oqchylwQmpaYYYokh0Na2gm/hAXZhiRjup9Dhri3Lc=;
        b=DqFLxE9iMsOsLfbQuv8H0fsczm/ty1kCBTletuoL3mlqiQVYUy4NkGybhzwUBv1vRw
         0vS+Te7wXIiWZemlmJtn0W5gTCTjlqrxK92TfUJJjadQvkk/gsDujHZpQgmn6rsu7qzH
         IS10g87tIfsEkzVVkGAbWSGzLpLKDAt42CCq2wGNepttECPmlPytVmOnprpNbhwRF7ji
         cfTzlTVF1hpyX7nect5AykxVTV4EXhILRbYj6UWk+XqRA98B6RKZwi8RMNJw2BHCONCZ
         YKnXKFCpdHQHOF9cdH/hRyZDPqAzzw4GnnQpIcLC0sGJkLzwYTpuj4NIpzAgzjo7ji7/
         zGrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788168420; x=1788773220; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ESQuHX+UHFhuuv2vinVyRZkjpMVp8tNaasHvCNkJoFg=;
        b=MrQfljXaOw8ESKLCDiCxv7tIaidfmkajSgDOyTNLGqVEmedqZb7oVTcSc5U2WEgVJ9
         iPNp2PirhnN3BzIoePGW+0RPefe+jXRVwg3lfJKidHzZF4tfCsqLPR4d8xiDZzrc20jE
         aIHCtZBpzQNVRg8qTcgWWuitRgtYE7UxXGK/m9D3pkJu+RdLOGW6EmIwzoXZQvhbn7C6
         9IQ791wt/8PecFeGWd9WulhGjvAhna3MIr+SFrliAf16WE9Cl8ciVHSCNeq5siS6VLPe
         JF79oQ0yD3Kqyl9jE/pIPI0tGh9DYIHkxOcuntoEyBifo/2Z4L8TuPQp+426Iw4Z8IDu
         oXNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788168420; x=1788773220;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ESQuHX+UHFhuuv2vinVyRZkjpMVp8tNaasHvCNkJoFg=;
        b=cmjfZlqFnLgA7A9MJT6dFQlgcegOHiRUx8FZwUfa93nJTvJDvv273vuuqATdrE6Gm1
         yxbf6aMOG9p89uiFV5d/Z1yIiVOFWpubvTQjghzHqhBbrLf3SLVIxGUEMO/tuPFaL/f9
         I8uqEdsWhsiUtLe7MjNjz5mjmyGDCQZqj4PXH76vbZpa7VErBNf2FqEeDgcar8H5uE3a
         F5ksqvTQe0zhm4pgkSIIapEJ1WYEJPgeR30V5ZXCKVyeuOXxXrCpC+0u0/GznncPw0Eg
         cSaoRGsrehNFFwoM9vNRZLY+xvlpmTBcUhSVOT5rG3iw6oea7AM67qbkziqFkjGvryQ3
         Riog==
X-Forwarded-Encrypted: i=1; AHgh+Rpk19ZV27+O12boc8yKMWgrIFVQAfs47CObp2cG5K+Vf5TNt+ZAAJINpmgEkqepyuoqLEg=@vger.kernel.org
X-Gm-Message-State: AFuF++ken3oaJmrqsDq88Ynzr2zjvqVsOKkTLpF8OYtnUUb7Nzke5A3A
	JuyMUxWiNz0CP2sj1BSUW0ivNF1BbUsqEicMXQ79H9aSJ2Bs9g2YZkAWPY/no6xVFBcaIRLk5MI
	uUrYbFgTj2VQHpIEKixPsubO67tk+r5L9JvxO
X-Gm-Gg: AR+sD10QwALSuNaxoNbwDQirRIsBW6Bpxv05keXbtkS0zSfCfM590zfhCHJwuXPLKGz
	f/9fwWFh+dp2Jaqo9sYaYMd3ggf+4RXulSiZQi6U/AupLWXqFQXRBNvOzzbaPtTFHBruSDgdE89
	IxyiRQQiffHAnntgVJEJzq24YhJMt5EazO4dMhMtaOoSGI4WwzJ7BW2HYd1Bn1pT3BeLrNDkQCI
	KGIWaMgsAhGrYk1ufRX3z6r2JPp4emVwfArwc0fo56tTaonvwiehl3aqqvHm184IoiGQH/d2OyS
	9aWFsJxsaUTkVQfskCCD+We2mXwY4BnN0a0Y2i/FjOIVn9UOustAjrTPug61/Lwapn4twYXm0/q
	K6hvZ+IYmz8l4yZ9BtNqUbHrtmFoHyJhdGFQ=
X-Received: by 2002:a05:6102:e07:b0:780:d949:663f with SMTP id
 ada2fe7eead31-789ef7c90d5mr801406137.4.1788168419859; Mon, 31 Aug 2026
 02:26:59 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 31 Aug 2026 02:26:57 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 31 Aug 2026 02:26:57 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260831-pks-odb-source-fsck-v2-0-f9b16ef4957b@pks.im>
References: <20260825-pks-odb-source-fsck-v1-0-b756de0bf24f@pks.im> <20260831-pks-odb-source-fsck-v2-0-f9b16ef4957b@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 31 Aug 2026 02:26:57 -0700
X-Gm-Features: AcwNN1V3KD7i18VFvMrLN0TPdN1ErDrW2S0yAAgNfT3NpThf9MUSJfpMzSGsEdI
Message-ID: <CAOLa=ZSi1TiTZ=i=SQp+pmjTOm2_wY-NiCotx66+M6VDKx=ZXg@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] odb: make consistency checks pluggable
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000770c06065a546798"

--000000000000770c06065a546798
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this patch series makes object database consistency checks pluggable.
>
> This series is built on top of 2c3adbb2c4 (The 18th batch, 2026-08-24)
> with the following two dependencsie merged into it:
>
>   - ps/odb-eagerly-load-alternates at 0076dc9f81 (odb: drop
>     `alternates_db` field, 2026-08-17)
>
>   - ps/odb-pluggable-pack-generation at 5176dd3d05 (bundle: generate
>     packfiles via the object database, 2026-08-21)
>
> Changes in v2:
>   - Some commit message improvements.
>   - Link to v1: https://patch.msgid.link/20260825-pks-odb-source-fsck-v1-0-b756de0bf24f@pks.im
>
> Thanks!
>
> Patrick
>
> ---
> Patrick Steinhardt (10):
>       builtin/fsck: use `fsck_obj_buffer()` when checking loose objects
>       builtin/fsck: merge `fsck_obj_buffer()` and `fsck_obj()`
>       builtin/fsck: de-globalize option handling
>       builtin/fsck: don't check alternates with "--no-full"
>       odb: provide infrastructure for pluggable fsck checks
>       builtin/fsck: move packfile verification into the packed source
>       builtin/fsck: move reverse index verification into the packed source
>       builtin/fsck: move bitmap verification into the packed source
>       builtin/fsck: move multi-pack index verification into the packed source
>       builtin/fsck: move loose object verification into the loose source
>
>  builtin/fsck.c                | 296 ++++++++----------------------------------
>  odb.c                         |   9 ++
>  odb.h                         |  33 +++++
>  odb/source-files.c            |  13 ++
>  odb/source-inmemory.c         |   8 ++
>  odb/source-loose.c            |  92 +++++++++++++
>  odb/source-packed.c           | 117 +++++++++++++++++
>  odb/source.h                  |  21 +++
>  pack-bitmap.c                 |  26 ++--
>  pack-bitmap.h                 |   2 +-
>  t/t1450-fsck.sh               |   5 +
>  t/t5319-multi-pack-index.sh   |  13 ++
>  t/t5325-reverse-index.sh      |   8 ++
>  t/t5326-multi-pack-bitmaps.sh |  10 +-
>  14 files changed, 394 insertions(+), 259 deletions(-)
>
> Range-diff versus v1:
>
>  1:  cf49376600 !  1:  1aec903546 builtin/fsck: use `fsck_obj_buffer()` when checking loose objects
>     @@ Commit message
>
>          When checking loose objects we manually parse the object buffer we have
>          read from the on-disk file, mark the object and then call `fsck_obj()`.
>     -    Almost the exact same steps are also performed by `fsck_obj_buffer()`.
>     +    The exact same steps are also performed by `fsck_obj_buffer()`.
>
>          Stop open-coding this logic and call `fsck_obj_buffer()` instead.
>
>  2:  da2ca27041 !  2:  3804f0339e builtin/fsck: merge `fsck_obj_buffer()` and `fsck_obj()`
>     @@ Commit message
>          Furthermore, `fsck_obj()` has no callers other than `fsck_obj_buffer()`.
>
>          Refactor the code by merging those two functions. This makes it obvious
>     -    which function does what, and it allows us to get rid of the early in
>     -    `fsck_obj()` in case `SEEN` is set as the only caller unconditionally
>     -    clears that bit before calling it anyway.
>     +    which function does what, and it allows us to get rid of the early
>     +    return in `fsck_obj()` in case `SEEN` is set as the only caller
>     +    unconditionally clears that bit before calling it anyway.
>
>          Signed-off-by: Patrick Steinhardt <ps@pks.im>
>
>  3:  a24506f55e =  3:  b2cb9032cf builtin/fsck: de-globalize option handling
>  4:  f6a407efd0 =  4:  10ee3b8baf builtin/fsck: don't check alternates with "--no-full"
>  5:  31841a1f05 =  5:  1e65eec60e odb: provide infrastructure for pluggable fsck checks
>  6:  2cd6d71983 =  6:  0b8cf751aa builtin/fsck: move packfile verification into the packed source
>  7:  c0559f1820 =  7:  3a38a75549 builtin/fsck: move reverse index verification into the packed source
>  8:  96ae1ce3c6 !  8:  dd3a4c6cea builtin/fsck: move bitmap verification into the packed source
>     @@ Commit message
>          instead use the generic `ERROR_OBJECT` bit.
>
>          Note that this change also adapts `verify_bitmap_files()` to be
>     -    focussed on a single "packed" source instead of verifying bitmaps from
>     +    focused on a single "packed" source instead of verifying bitmaps from
>          all sources. This change is required as we already know to loop around
>          the sources in `odb_fsck()` itself.
>
>  9:  4721f4b4ba =  9:  90ada56b7f builtin/fsck: move multi-pack index verification into the packed source
> 10:  0b36829fd9 = 10:  b0f6fccae8 builtin/fsck: move loose object verification into the loose source
>
> ---
> base-commit: 6b08999fb1b3ad0bad04d492dc206ad42839e274
> change-id: 20260810-pks-odb-source-fsck-e64772c7ee5f

The changes here look good to me, thanks!

--000000000000770c06065a546798
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 69a67ffeda033881_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xVlNOc1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mME0rQy80ajZmMExCbFNMc1dxVWhMRk8ySWs0TTk0UgpXelBybVZ0RytZ
cEowdU1BTjlkcWhpNmpnc2lzREEvZWlVTTRuSmlaSTdHZE40Q0Nla1ZYT3k0aXdmRGVFQ1B2CmRB
SHd6WVJKNXcwVmlaZ1EwTi9sV3ZSQ3ZDbzQrUUhrR2FYd0ZxQWRQcVQ3b1ZQTmhDRlJsRFE5M09F
anlPLzEKYUVrWHl2Yjd0QldwZlpZYVBNUGp4SllRU1VVelQ5SllIMEhITW9PUmpFTFdsbFRuUE1I
c0hqVXNDT0pmOFEraApTRElkL3l6WTRiQUMzRkFtVXlTZUNWWFNNNCtuRm5vRm5KYWx3OUhxQ3B6
RFBzdTlNT1FPMlRZRVFrM2FRWWhRCllLWEREcW1seSsyV0hzTjN6dmIweVAvcGNmUW9qdDBvTjY5
SElFc0dDUkZpVzAwM01QVGxXYWJXWW9OYzdvb0kKNzBNSXFkRGpGTEZpUktnVGhtd05yYUc2NGVh
YWtqOFV4UWUxSCt1YVp2ekZBcjB4UG1adG0rd21VY0xGdlh4VApxVkxsUEE4OXlGbWpkSFhXUHZ4
b2FmZWEvRDZzZWx3Z0ZIVVRWTENXVGRZR01xclhYd1ZwWGhYZEFGLzZkeS9QCklaNlI5WCt4czRn
TkNxbzdNN0ZRN0dGZ25mZXEvU1RTd1B4QzFDaz0KPWRQTHMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000770c06065a546798--
