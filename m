Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5095043CE72
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 12:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787230613; cv=pass; b=RYSDbD7hLLlMUP/L/gIbeQk+lVlASvHwfZ5+XO/M4OHIwD9Z3Aaww8kKy05T8iuQJLROYDb3C9rXBIBTHcCsZK2mbDUdN7zpKpaPCD5lVNQQgu3Vqa1viyMOkaumw/iIEIKEixS9vsPcGL6xPjZSEfNZ5Bu+87u7QpLil+14l3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787230613; c=relaxed/simple;
	bh=sSEh/4zT1N6JanukwuScZz/MnxKvkNxjx/QAaCuca40=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i3dAOS/SDteIV2e68PW8mPat2KY1wIB8FF+v8FrNSMtmdVgxEQQVpNDUqqWjV4S2JvLkj9KyIlsIQqkOA9ePmDUqxOCRCJ/PvfcYA4xa1ihgrMy6/U2oyenCTYuiEysPQK7GU9tej4eeaOu9nYLAxD4pxTMXVQ6EStFCee3FEkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jLZ/mLdg; arc=pass smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLZ/mLdg"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-74d55dac06eso1377578137.3
        for <git@vger.kernel.org>; Thu, 20 Aug 2026 05:56:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787230611; cv=none;
        d=google.com; s=arc-20260327;
        b=aUEYGsLpnysas/ULlFKNpHQJUiVJ60fFDvWzwwwSh2kGOzeJj+E3R1r/PgF4bjSjRm
         VJn7WUX38I2ocOp/CMO4jG/3IE0AaRJAdr5zID1VQJ8FiSI/PPi/KgzFIoWxwuchPL7e
         yztvnZ7i5QSqpyjiu/eelMBivC3cduLxmelTa+VXeMMr50l4+cNEJLvms9cYv6epTDr1
         oyVdCKCyXYnW4w+3ITXf/PvIPe+1sY112ciWiioXWtM6esFiRLcuYRncpMwrsqZz2wLs
         U827f7wxSzlzVZh/pepwGdTMnu5fdGNKI3uUEOvVQsQrn6bIxWaKgL3oM+q9TkcDyxDi
         xTpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=ntoUcZka+bCAEYMqg4siwRUX2/X6mLnimmNsHZj5U1M=;
        fh=7//E3kZqQx5zMkFbNHj2PKp48+L6yzv8UQlOOJcjf/E=;
        b=nrsGg0ITm9XDSHMSpufr9CM9hQhyVW3h9hrkSIrhfP1s0tOaSB8EviaZf3aBDSr1Fy
         0+bIDbcjo31JiXstH4pMrA8divmVIpODS6Q5LNwzNBwUMGDiGInImdliZzUW0wXNacI2
         SJPveJMMqiPYhn4G9m68wao6IJzuPuf6TAZb4fhHr77jYmDUHR3bdXsjjXy5j/vLpbXg
         dAGCCP1ChhL35Eiz4S2HkTdQfitfV07rCxon0Ha++wHbE9yFtDUYxVa7dT8aqzEDfmtV
         +QW5Y/UGkNI2RDDob3SFBMblHb+AetD/2kebRAUCweVYNL8rAGcI8Dl9QiseywoIaduy
         Ad7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787230611; x=1787835411; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ntoUcZka+bCAEYMqg4siwRUX2/X6mLnimmNsHZj5U1M=;
        b=jLZ/mLdg1OpZs/MkQjdx67x7nQSxtVZudSWBBdODdHPCsaneEaQDagtfH2fhnvf+fY
         sUgZT6+W69HUHstoBZcx5iHx4K6CTj4r+ykSPMmYqLnpOjm3zAYXd3Qh2cj3RRWFVYDG
         cL7JqrP5hJrhlK9fkTF80isrYkYcQf7nlzWet41aa26qKqIsiGDOKE4O+NNLq1E+CPAp
         MQO7mN/BH1NPFhSOuOkkkU04xQEmaZUoRP7WBxwZ3ZcgvXuVWtmXFTeNQBQv+pIjU11e
         a/darXnQO06PtX8ghWLJ9DFYzZUVsIGRHpz5l4wNoGBiz/woiRSl+Egqjsx8XoZIq6rM
         +HBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787230611; x=1787835411;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ntoUcZka+bCAEYMqg4siwRUX2/X6mLnimmNsHZj5U1M=;
        b=dhpo4kJObrrSg87PvDD7xiiPkYTkhlc2nP9kTAi0nmjJlJNaT9sDyFnADk/+QzTpcm
         s9gVyK2pFm6GetlT1PSSIAfxRLzIuPVzrKddRssh5JEPJDfCSE3T8e8au7Qi7TpxnxZp
         flbcHN7NAvlhDtU98LGDqBKPLjCZNiyuxgNI+ZgU3PvQ8ey/PePUjXYMiKAsXC8pobGG
         19d6V3hgrHFcc4nzwZoGUQo4mKiQj1mV384BQKiS4SAURP53g4LRAs+lDB+hUCRSGVmV
         FCQsRNvMdte16BXh6oFmLgmqWjXe/0VnaH8xF4E0U7NmujIR/nxivrvdu5y8hgIMzZVC
         YINQ==
X-Forwarded-Encrypted: i=1; AHgh+RoeV5+09+AjW9HLmZlpTqqli6Ino4OeeeJOuLYTCWfE+muQEHohWfAMJ/iOSQKc4kmnHFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJp+6dTyX5svGe0BV5Q5nyYwaZFrf5+3h+MorP1P3Z9feyTsU0
	6uP9U29chZC/kNYgChDcLeEGF9GNRFyKEndbrkpRzRPSXJTxpXAwmkM9WxMNRSIzn0sZP5yWctX
	PJFrSMnH2iRsaVhIkBw/YT2/qbzGXC/h/IuFg
X-Gm-Gg: AR+sD13Usyw6Fh/Zp3AFKg1xqoN5Nd50B9ezP04pjuoxpEWLpAs0yz1IkNL8h+hUU1F
	zpzDP3pF7FZ8V12cXYkh3lcbWWcimDCWwdaeQIlwVyKhaU3ZQ/EFqp2Kjc4+8a3PhoNtDqILtNP
	fYb3FzBpqTFisGX13zrGdR9Ij1FJMe9djQhMWc2Ug5h3Q6u3t/fPLFSnFz0GFK+l2etbkIFbLRJ
	7MZbVNJgS8agTEztgLi+oswVlAfdr//hgKZJRX6iiC2F+UzJQt9iR+wNs5UOjYk2hXn2vGCoRpS
	fCa8n/Kji49BCqD+gAbyH/fsZ4gt60mJgHZop48p1G4u7XchcYm5Yp6BvRQ1+6yhLu5wig92KqX
	Byb0xvM5uQVjKRW1H9NBdg/oWiuSBqW7J8lHPasOD2UPEylMktA+5ec0aiA==
X-Received: by 2002:a05:6102:54a3:b0:744:dd70:a364 with SMTP id
 ada2fe7eead31-777fab9d4c7mr4609745137.9.1787230611014; Thu, 20 Aug 2026
 05:56:51 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 20 Aug 2026 08:56:50 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 20 Aug 2026 08:56:50 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260819-pks-odb-generic-corrupt-objects-v2-3-a984e3a0ad6f@pks.im>
References: <20260819-pks-odb-generic-corrupt-objects-v2-0-a984e3a0ad6f@pks.im>
 <20260819-pks-odb-generic-corrupt-objects-v2-3-a984e3a0ad6f@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 20 Aug 2026 08:56:50 -0400
X-Gm-Features: AcwNN1Us0MIDW9NYEatPL0ULsRjaP5P6IHuZhxtmh-DTQTCbjLElBnORl2GjR10
Message-ID: <CAOLa=ZSSzR+qKh4Do-F7xZQMO-pE+t4N8qM5hsbfM4Uh7i3d1A@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] odb/source: let callers discern missing and
 corrupt objects
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="000000000000b3cbc306597a0d30"

--000000000000b3cbc306597a0d30
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> As explained in the preceding commits, reading objects can either fail
> because the object truly does not exist or because it exists, but its
> data is corrupt. Some callers do care about this distinction, but there
> is no way to tell these two cases apart right now.
>
> Introduce a new `ODB_READ_NOT_FOUND` value that ought to be returned by
> the backends in case the object truly does not exist and adapt backends
> to use it.
>
> Note that we don't yet return this error from `odb_read_object_info()`
> itself. This will be fixed in a subsequent commit.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  odb.h                         |  2 ++
>  odb/source-files.c            | 20 +++++++++++++++++---
>  odb/source-inmemory.c         |  2 +-
>  odb/source-loose.c            | 31 +++++++++++++++++++------------
>  odb/source-packed.c           |  2 +-
>  t/unit-tests/u-odb-inmemory.c |  3 ++-
>  6 files changed, 42 insertions(+), 18 deletions(-)
>
> diff --git a/odb.h b/odb.h
> index 43cbcc3aba..1264d4ce7d 100644
> --- a/odb.h
> +++ b/odb.h
> @@ -440,6 +440,8 @@ enum odb_read_status {
>  	ODB_READ_OK = 0,
>  	/* The read resulted in a generic error. */
>  	ODB_READ_ERROR = -1,
> +	/* The object could not be found. */
> +	ODB_READ_NOT_FOUND = -2,
>  };
>
>  /*
> diff --git a/odb/source-files.c b/odb/source-files.c
> index a28aa5042d..e88fd1d399 100644
> --- a/odb/source-files.c
> +++ b/odb/source-files.c
> @@ -65,12 +65,26 @@ static enum odb_read_status odb_source_files_read_object_info(struct odb_source
>  							      enum object_info_flags flags)
>  {
>  	struct odb_source_files *files = odb_source_files_downcast(source);
> +	enum odb_read_status ret_packed, ret_loose;
>
> -	if (!odb_source_read_object_info(&files->packed->base, oid, oi, flags) ||
> -	    !odb_source_read_object_info(&files->loose->base, oid, oi, flags))
> +	ret_packed = odb_source_read_object_info(&files->packed->base, oid, oi, flags);
> +	if (!ret_packed)
>  		return 0;
>

Nit: Similar to my previous comment, wouldn't it be nicer to do

     if (ret_packed == ODB_READ_OK)
        return 0;


> -	return -1;
> +	ret_loose = odb_source_read_object_info(&files->loose->base, oid, oi, flags);
> +	if (!ret_loose)
> +		return 0;
> +
> +	/*
> +	 * Reading the packed object may have failed even though the object
> +	 * exists, for example because it is corrupt. Report this failure to
> +	 * the caller in case neither of the sources was able to read the
> +	 * object, and prefer the error of the packed source in case both
> +	 * reads have failed.
> +	 */
> +	if (ret_packed != ODB_READ_NOT_FOUND)
> +		return ret_packed;
> +	return ret_loose;
>  }
>

So if we already found the source we return early and only come here for
errors. What I don't understand is why we filter out ODB_READ_NOT_FOUND
for packed. Wouldn't that leave us with

    ret_packed => ODB_READ_ERROR
    ret_loose  => ODB_READ_ERROR or ODB_READ_NOT_FOUND

Doesn't this come down to preferring to propagate ODB_READ_NOT_FOUND over
ODB_READ_ERROR and now packed error over loose?

[snip]

The rest look in order.

--000000000000b3cbc306597a0d30
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 3fe4c407d720b143_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xRytaQVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mdythQy85aTQxM3ZoSFg4NjlqSUZsVlM1Z21TbW5icQpMM3pXZnpmUEtT
UlJUOUNFeGVuRkN2SEtxRW5VcFhOcG1SUzNlUHFEdjVKK1BmamdvaVBrT2hRS3dFSVBpTDlUClpQ
ald1NWNmdjFTMFpvTHlLbndYaUJ6SkRhUzgvOExjZTV1MnN0ZVFPV2R2SE55eDJlT0RiS1huUEsw
RHpWV2sKcDR1N0ZodGVkQklpQ0lheG5LZHlMOFVIOFc1c25PNGhiNGswVW4yOVNSVkFHckYxdVlz
WVNFZ1NUekVUa0Rhcgpvd1dBdHBXSmV6RHdVVDEzR2dRbEZ0YjY2ZHd2bzhwdDZHa1VpM0YwNDhy
RS9Cc0hmbXRBYUJSeXVKdEE4Vzc2CmpBMFNXSThoRFFlSVhvM3R4Tk93dHhqYmhYcys5VVBSbmNE
VzhIQU1yM2F1SkJyYW1BcDdKQ1pNaCttVUpoMUoKWC81U2F2c3N0NE5MYXNZTUIySE42OUJMdWtT
a3oza3cyeU94RU1Bb0dSRk1razkrcTQvMjlsRFlRbDZxSXF3OApQWHh3dE9GVDlZRnNuQVUxcDAv
enRWT0dsT1M3aEhVMzRUTkRKc3BFZVM2SE5MWVpjc1c4SjQ1cmJWZDc0QUVoCndUcDFxVU5VWjht
cEpmdnpFRytxRmpVQ1lpa1VzQzFyazFQUm5maz0KPURzK2UKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000b3cbc306597a0d30--
