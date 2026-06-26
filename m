Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779553DCDA6
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 07:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782460130; cv=pass; b=udQBmRdfOui6NUwECFM7kj1XeA+2aMI82yJUbRhaxT6qxV3dU2LAuO8/J+NjIvgXrCgOC1HO3tR3W+ZfG4TyxwcR0a9snWfZ/9uwxTcx/N74AfT069MkzztnN0ar1z0uueWHWG0kERj3P+FazkQy6KNcmrFtJyv9s0elEujiEmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782460130; c=relaxed/simple;
	bh=ONtD7hFCz+TsUOys2kWj9McGrwMtbzQB0OJGZ/kB+Cc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KMmJE4IRUwsofjFXscCOpd0feJfulvHX8iClkmYBFzCAWMzMK0jN5bohfISrQDnPfoCv/CsgIaQ6NCh8k/W8CBQAmg+wTt7IrJjtHy1BfnmR/CRxBNMgRwaWzbTzc8+1vpPrKQ7hi/4sXF10FCovDVEWhHcB8gh9Kb081vmeA+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X0IjaPd3; arc=pass smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0IjaPd3"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-13809223fd4so837528c88.1
        for <git@vger.kernel.org>; Fri, 26 Jun 2026 00:48:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782460128; cv=none;
        d=google.com; s=arc-20260327;
        b=qhrU6OHNuznYFY7jBNG7tnaOnBZ/PqvhhnB9VbEmGwPr9jSDQhqcBAQpxHoSJbMfTw
         1Y9ygnbqA90qy9rRjTz6GTIB10NLi4SXjFDD+f9hjbtufcK/OtbbQU7H5QNbBL9mIGc3
         Ss8Et2yvLF9HDily0zA6RxE/YkrE5UbgA/Oqg3F2xXnYTnSEDsno0EkDTU1JuPUX1SnC
         Oq3R6ybQ0efZqAEjAGli0hpTgs9NfmcKLLG+L2OYKeesI3MWOnYw9f1/Nnp7SrUz9/zS
         kt4HyHamhwanFti6j4fKXZIGEk86Agtj/XslOjTfkyCOZPAhpqFv/EoLFYCpmYi6xefy
         h2GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2K8JTGoFrcC1BwrjGOirY6+AOi5Uz7gaIHbhXZ6loeA=;
        fh=rxSEfUv3/2d5aDUUp6GNnubJYx6hDrkVpaVpVqglFPk=;
        b=JJFhn4/NUREnnnVJok6vf8QjIqmheXGVOoCtX7JeQEMFJRD+p5E9pOx8Uyp3gk/rXH
         gPMPxbRtYz8d0ibdYZf6fE5j+pwkju2msPJHLa/5eGWNKJGu2B4Oa6lbfNoTr0ECfEUo
         UI6FkhOTlrybIVZ5m87aPPpt1B4rS/o5VhiGaCTD+MJNhRVH54PFfgeSr2OamcwVLecO
         sngSkzfZvlcZsmLfqrSpA8TPSYb6dXsc9ELH4mFX2GbmXOcTx8JXSiCGBV+m36QH0zPq
         w5fnmZt16jCjy2sZlWWlPk58eua6Ooja8wkAMCTF9k3iHSjGL6EB+ep2eFXGiEjbWugk
         fjkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782460128; x=1783064928; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2K8JTGoFrcC1BwrjGOirY6+AOi5Uz7gaIHbhXZ6loeA=;
        b=X0IjaPd3Xt+6DkbarfWZpFAThzXx+bInnDZWr3vMaT9uMYOCRDT1jWJpxJFALMG8a1
         pT8nQHomOr5tVaS8puv9PZG0CfcQFX1dxyIhqdtrudmHaZ3nivWtOFvANHDe5Stghdtk
         xM/ThPBKPXLLKTlU6KizXxUd2cEc8zAeYhTq7pbtr7h9CTnV5YSQCKGg+0/84tEEVGla
         Dt5pRqRTRRe2ceQZOYigXp1CtaEGwVBhIjvwBEtCOAml/2FAyO7l00/zkW3brxKs7zHA
         Q4y95jEqjFCeVtHQB4rpalfC2NoKIuBKZlGLfxh3ixfRo3p97c9nrR5uu7i7E+x5q4KD
         yXeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782460128; x=1783064928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2K8JTGoFrcC1BwrjGOirY6+AOi5Uz7gaIHbhXZ6loeA=;
        b=BvYpVHc/Bugv3HIOOgI83omJgXrA7dYAyUtNbwgOMEnQCbb+8jAScybL1KYYe56Zab
         SfYjGNKbsBPwjLbns6MmN5fv6EPPU7DiiKo/NpNPbtMG/U55b0lmyesLiDVDhIGHeDJI
         E0iPCUQiOXVBnv4iMLdNUJvtBo7hCLIPk/1KLLGG37NTxKBlgEg8vJtFbMS2Om2t1QMs
         LDu4m8YCm/Tk6ipLia5i52v35VTMmCWgCMwWBP8lEjQObemG8Mhz4rySMqM8oG6R6z22
         e8+F34Q2xWRgQ+32/8KKuo2UYEW/pPz7IGUrWygv8iCYXacAHDXZYi9yWf55nnUuE/Wa
         zDfw==
X-Gm-Message-State: AOJu0YzMCqnmRyd8IeKhkjZ/kFHluJwIz8O6mhB2YFa28kyKMBpyh8Iw
	L/gHjPUrOiwby1OZKvDRtQpW+9MPytjiHCAq1512OkFEpb/EbDowao/ftxExgRmM0p82eoOoLYa
	Hz1MswiFrC5L6E3exyEs1rgGZabxRWI7JOmvv
X-Gm-Gg: AfdE7cnO61Ye3N0ltAsXRJYMK1g7KFGxUpQUMl0tcH4UkrdgwyWk1FLHUD539SgPD71
	vvIQkg0odH/dOjLyV0Xk3kNx1dcVGUqqhHJBzw/6RkLxWXMC5n2jBVym5r0isoJ49Uotxj6u2ol
	rCXONzOeS253lza4M3ujcTfbQ9kmH3iengv5o0gz5rSHt35G/Nw+9aMQNuI2TlhEEs0bg+GGU4q
	yA0EbLfC04srAc8cMS1i3YNb8OvbwC2v0B35aV2RCiXeSVMojgXTB487M3iWY8XOQtPitLOwhJQ
	8xNAreewexN/W8sCWsKbmOIZtZ6LRkD85o8jLoV36LoWABUsrxLlMdbrZA==
X-Received: by 2002:a05:7301:4e8a:b0:30b:d865:4bd6 with SMTP id
 5a478bee46e88-30c84eba981mr5974655eec.22.1782460128309; Fri, 26 Jun 2026
 00:48:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624-pks-reftable-hardening-v1-0-66e4ce87c6b9@pks.im> <20260624-pks-reftable-hardening-v1-5-66e4ce87c6b9@pks.im>
In-Reply-To: <20260624-pks-reftable-hardening-v1-5-66e4ce87c6b9@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 26 Jun 2026 09:48:36 +0200
X-Gm-Features: AVVi8Cdo8F1zrtIiFjhNCmNfMEYIEoQ5le7GIYI0bCIrf6Ukv5zcViAOs40sbxE
Message-ID: <CAP8UFD0y0GVjdnWYDkOsk6R9-ReGfzr6ZEm8PbyHOHrdAETXzg@mail.gmail.com>
Subject: Re: [PATCH 05/11] reftable/block: fix OOB write with bogus inflated
 log size
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, oxsignal <awo@kakao.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 24, 2026 at 10:24=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wro=
te:

> diff --git a/t/unit-tests/u-reftable-block.c b/t/unit-tests/u-reftable-bl=
ock.c
> index f4bded7d26..40274af5c0 100644
> --- a/t/unit-tests/u-reftable-block.c
> +++ b/t/unit-tests/u-reftable-block.c
> @@ -456,3 +456,47 @@ void test_reftable_block__iterator(void)
>         block_writer_release(&writer);
>         reftable_buf_release(&data);
>  }
> +
> +void test_reftable_block__corrupt_log_block_size(void)
> +{
> +       struct reftable_block_source source =3D { 0 };
> +       struct block_writer writer =3D {
> +               .last_key =3D REFTABLE_BUF_INIT,
> +       };
> +       struct reftable_record rec =3D {
> +               .type =3D REFTABLE_BLOCK_TYPE_LOG,
> +               .u.log =3D {
> +                       .refname =3D (char *) "refs/heads/main",
> +                       .update_index =3D 1,
> +                       .value_type =3D REFTABLE_LOG_UPDATE,
> +               },
> +       };
> +       struct reftable_block block =3D { 0 };
> +       struct reftable_buf data;
> +
> +       data.len =3D 1024;
> +       REFTABLE_CALLOC_ARRAY(data.buf, data.len);
> +       cl_assert(data.buf !=3D NULL);
> +
> +       cl_must_pass(block_writer_init(&writer, REFTABLE_BLOCK_TYPE_LOG,
> +                                      (uint8_t *) data.buf, data.len,
> +                                      0, hash_size(REFTABLE_HASH_SHA1)))=
;
> +       cl_must_pass(block_writer_add(&writer, &rec));
> +       cl_assert(block_writer_finish(&writer) > 0);

It looks like some of the block writing code above could be simplified
using an helper function like:

int cl_reftable_write_block(struct reftable_buf *buf, uint8_t block_type,
                           size_t block_size, uint32_t header_off,
                           struct reftable_record *recs, size_t nrecs)
{
       struct block_writer writer =3D {
               .last_key =3D REFTABLE_BUF_INIT,
       };
       int block_end;

       REFTABLE_CALLOC_ARRAY(buf->buf, block_size);
       cl_assert(buf->buf !=3D NULL);
       buf->len =3D block_size;

       cl_must_pass(block_writer_init(&writer, block_type, (uint8_t *) buf-=
>buf,
                                      block_size, header_off,
                                      hash_size(REFTABLE_HASH_SHA1)));
       for (size_t i =3D 0; i < nrecs; i++)
               cl_must_pass(block_writer_add(&writer, &recs[i]));

       block_end =3D block_writer_finish(&writer);
       cl_assert(block_end > 0);

       block_writer_release(&writer);

       return block_end;
}

This function could be introduced by a preparatory commit in
t/unit-tests/lib-reftable.{c,h}. It would be kind of similar to the
existing cl_reftable_write_to_buf() helper in those files.

It looks like it could already simplify existing tests like:

- test_reftable_block__log_read_write
- test_reftable_block__obj_read_write
- test_reftable_block__ref_read_write
- test_reftable_block__iterator

and it could simplify the new tests introduced by other patches in this ser=
ies:

- 06/11 reftable/block: fix OOB read with bogus block size
- 07/11 reftable/block: fix OOB read with bogus restart count
- 09/11 reftable/block: fix OOB read with bogus restart offset

> +       /*
> +        * Log blocks store their inflated size as a big-endian 24-bit in=
teger
> +        * right after the one-byte block type. Rewrite it to claim a siz=
e that
> +        * is smaller than the block header.
> +        */
> +       reftable_put_be24((uint8_t *) data.buf + 1, 1);
> +
> +       block_source_from_buf(&source, &data);
> +       cl_assert_equal_i(reftable_block_init(&block, &source, 0, 0, data=
.len,
> +                                             REFTABLE_HASH_SIZE_SHA1, RE=
FTABLE_BLOCK_TYPE_LOG),
> +                         REFTABLE_FORMAT_ERROR);
> +
> +       reftable_block_release(&block);
> +       block_writer_release(&writer);
> +       reftable_buf_release(&data);
> +}

Otherwise the series looks great to me.

Thanks.
