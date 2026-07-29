Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF373B71A7
	for <git@vger.kernel.org>; Wed, 29 Jul 2026 09:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785318833; cv=pass; b=LI+S4Lk81wJdrFTNjW+un7km15tS9tkbftrKgp4/UJngcCThwT5E6dS4km+M+LVSAKmPfKdi+1xtjXeohwU0gf8otkmdlBMH/jtDhLFwAuUvdt+evcAek7tLfv1/jN8chAHmZm/LDhWuNFVCsV+KwPJekTpFVMFztpw66VMnfiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785318833; c=relaxed/simple;
	bh=c9Sal97l0sVgvbUyQv2zDupbXIdEyaWz34fyTKJHTGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y6A5cin3ucvohI7pvVepWxd7RmuyqvuBiAgdYT2XYWvbMqbOeh7FMxRF4bk6oQ9GqjoOdPdtK9MtbO2yOzzuC5fRoTUOgyIahThQA0w9UoSINrK4/K1NJWy+I6k9fV4IUvXKhHkCtKt/jIyDhALJWIQlviS++YPANpgJQz2VtVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j4vkqiZG; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j4vkqiZG"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6a02aedabadso996493a12.1
        for <git@vger.kernel.org>; Wed, 29 Jul 2026 02:53:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785318830; cv=none;
        d=google.com; s=arc-20260327;
        b=MmHKpB9l3P3rc5ptDIe9pnPc3OQR2l9K0fNfBjqYCVNaHmIQAZ0J+wnNJmY7gqNGeI
         /iFJPvsao2+HkvBXrZK0+0Bijgfad9o8QMIPfiwCm8CNIiG9zbd46R/F+ZL2b8NzVDtE
         Om7lUH2t5cgTInDPy11EF3iClmUP/5ro+IJfyTaBo1Z6MOM++ZFVudwXVv900A7v8hW3
         w7YITeSvbqxqLcmv3uV+9Oh6qLqDyYoJb/D6HISIF624EAPnHdTsfaId7uidk8H0D4+B
         iPP4eeOysrixr3OG7WxMC4H58ObIvz+xAe+Q2nENlYCZrVkR2QiFDSuJxiR+R8YXpTnr
         AWDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=VmFA6jmantW+2hbPGR0Eny/V2eYJwjCXDsK63OVvnyU=;
        fh=2aAxuZ3FwNf3QcFlH2RvBEmGPgSA32B5xuUzbfpQbOg=;
        b=dk4CdnyglQsMgE1CpCjYDFD4v7ShBxOa39hrtMfvs4Go9hOaiA3f8HHXAqj5OcGzjm
         1o86hg2T/4rnSONcnjsj+7GYYpE3PJ5wQ8snhr4g45xfCiG8RxT+UG/ccik+LeBf9h5+
         OQ6p0UpIf7hQTJCOIWfJLlARyI86sh/YJX6E4AThRiW4moKKe6kG2AUw/zE8WXgNhnox
         okUFukNlBP/HN7urcr8N1aGJhosZK+ivSE85tBCGHHLmJT+SS2L8Cdfv59CVQJMufPUa
         0cjmzDGPSjJRSHYVGRkC16AWvRuN3wHHbOB2jeYiDJhtEClxs9cjGSNZ2yLSEp3yTrt8
         7BTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785318830; x=1785923630; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VmFA6jmantW+2hbPGR0Eny/V2eYJwjCXDsK63OVvnyU=;
        b=j4vkqiZGx1libq3GCJwzP2N3p/H4NVUv1qrfwK+rqwaqRnIB83SeyRW+WgIbcF6sjJ
         +O33cVn7B7TXVN2jNguhxTxBLa3BijnT0UKfxbRsD/qfavONKJQQ10LZCSo/ZFUpUjI9
         2Lzy5K4RptuDiaCOt1GTbDs6wP1o/knE4oBl5+U4Vo5J5bKa4J+Jh8P2d/kwQ18vytCW
         o2wuZi8Kt1gJXD/6mkM4X+T1ZxEtBQsClu8HJdY0/LsLd0ziqLMqW7RuFZh4YHeC7c7A
         bgnBJ+OHMJHQmtB/+9ASp58cYxj56O+Jp4V1d+5N1BGdcaF6/KGzRES6j+rHXwyZm3e4
         w1Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785318830; x=1785923630;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VmFA6jmantW+2hbPGR0Eny/V2eYJwjCXDsK63OVvnyU=;
        b=eJXioiN8z8Mh9oRaIkT3uxnLYv80EW+j+odlDUXNEUzdOPpdpV9acvB92sTJtRpH7r
         7vpKICZu4AiyrwITjRdx9QdVHm8+bfSbr1XtbgJlbsoeCN2DQoFJRkzYEBwQkS3GVfaA
         sKN0ud272ivE3D8crr4+DSdJz6cDRcKltoKjSODZuoP2eqOQupGRin62WxjKm40lP6/r
         gE227klerPD1j+Z9mXIMAwnuiMWgONRrYd9XOCcbGUt5IVitgLP4gJcWc2ZCYx5I7Clh
         facU3MeSdSSP841GJYJPiPVFWHdykL2yMf6fIiSOx1df45/3tzH4nH5gRMzN2L8d5MRZ
         7dUg==
X-Gm-Message-State: AOJu0YwaEYeP2tvd4ddy5lu9xZQ1QQGT74wclivg7icPDtpJ10WDh0Ju
	SmjFT6cl8riU5T6e8bdRwCGn65SNgGSQQE0Sj6+B1NY6NuSXs2II7AdGHX5ysyYgu1ePUd6voTP
	N6W/ngoO1eRdVdloWamLDf40hMI/nMP8=
X-Gm-Gg: AR+sD13f1L27vm0JWmEhU0j/xwZyQvu6XeaHzVkjpEwevo0pGn+zEHA7hm9ZKK6G7LN
	HB5JqgQTaWis9uomTKBhGwmh94FDgodkRqRzo5CpouIyjmGtt4kHPcnuMrHKikmtNYSS13jeNtZ
	zVEVD5sEOyZuzARhoCa6YfFcsl02p/cSQnKf9PqxaTXQAzRj3/KfweVGQQYY473HGffYmxO1xj3
	txFT9hQT1lwrVnByICpRZ83r61lHx3Of1hIQcs2u6SOmrpTBc2aHSqi7NR4sTyq0hzZNqnCTQ7P
	4L7/SuHo+sKqUc8hhSwNZ8EgjcQcaY+2wYWz3J7+u+Qs+8QSfeRPHLihz+5kbLTw7TRBQbO3Jct
	1iw9ikl78W9/nL8tm4LklUYRd6+MNcEAoCWxU8Kw6H0NdArID/5HybfHdId0v7KOrJ8wU
X-Received: by 2002:a05:6402:1ec9:b0:69e:2585:7e6 with SMTP id
 4fb4d7f45d1cf-6a034ab356fmr3126198a12.30.1785318830049; Wed, 29 Jul 2026
 02:53:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260725-objecttype-support-v1-0-2d4ca3bbabf1@gmail.com> <20260725-objecttype-support-v1-1-2d4ca3bbabf1@gmail.com>
In-Reply-To: <20260725-objecttype-support-v1-1-2d4ca3bbabf1@gmail.com>
From: Chandra Pratap <chandrapratap3519@gmail.com>
Date: Wed, 29 Jul 2026 15:23:23 +0530
X-Gm-Features: AUfX_mydJKxx6fHsYyxOkRoej-rvA7A20pWIDv4lj4M5x_uya7Uu0YzZmOVsp44
Message-ID: <CA+J6zkQFAqZvi-6UaQi6v_OBiT4ihZtCN45vyGCGTbo9TJLJbg@mail.gmail.com>
Subject: Re: [PATCH GSoC 1/5] protocol-caps: add type support to object-info
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 25 Jul 2026 at 17:25, Pablo Sabater <pabloosabaterr@gmail.com> wrote:
>
> Teach the server-side object-info handler to accept type as a requested
> field. When the client includes type in its object-info request, the
> server returns the requested object type.
>
> While at it, fix requested_info->size bit field style.
>
> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> Mentored-by: Chandra Pratap <chandrapratap3519@gmail.com>
> Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
> ---
>  protocol-caps.c      | 21 ++++++++++++++++++---
>  t/t5701-git-serve.sh | 27 +++++++++++++++++++++++++++
>  2 files changed, 45 insertions(+), 3 deletions(-)
>
> diff --git a/protocol-caps.c b/protocol-caps.c
> index 02261be14d..5531d388f0 100644
> --- a/protocol-caps.c
> +++ b/protocol-caps.c
> @@ -11,7 +11,8 @@
>  #include "strbuf.h"
>
>  struct requested_info {
> -       unsigned size : 1;
> +       unsigned size:1;
> +       unsigned type:1;
>  };
>
>  /*
> @@ -73,15 +74,20 @@ static void send_info(struct repository *r, struct packet_writer *writer,
>         if (info->size)
>                 packet_writer_write(writer, "size");
>
> +       if (info->type)
> +               packet_writer_write(writer, "type");
> +
>         for_each_string_list_item (item, oid_str_list) {
>                 const char *oid_str = item->string;
>                 struct object_id oid;
>                 size_t object_size;
> +               enum object_type object_type;
>
>                 if (get_oid_hex_algop(oid_str, &oid, r->hash_algo) < 0) {
>                         packet_writer_error(
>                                 writer,
> -                               "object-info: protocol error, expected to get oid, not '%s'",
> +                               "object-info: protocol error, expected to get "
> +                               "oid, not '%s'",

I assume this is a style change? The original line doesn't seem
long enough to wrap though.

Also, this would break the grep-ability of this error string.

>                                 oid_str);
>                         continue;
>                 }
> @@ -93,7 +99,8 @@ static void send_info(struct repository *r, struct packet_writer *writer,
>                  * If an object is not recognized by the server append SP to
>                  * the response.
>                  */
> -               if (get_object_info(r->objects, &oid, &object_size) <= OBJ_NONE) {
> +               object_type = get_object_info(r->objects, &oid, &object_size);
> +               if (object_type <= OBJ_NONE) {
>                         strbuf_addstr(&send_buffer, " ");
>                         goto write;
>                 }
> @@ -103,6 +110,9 @@ static void send_info(struct repository *r, struct packet_writer *writer,
>                                     (uintmax_t)object_size);
>                 }
>
> +               if (info->type)
> +                       strbuf_addf(&send_buffer, " %s", type_name(object_type));
> +
>  write:
>                 packet_writer_write(writer, "%s", send_buffer.buf);
>                 strbuf_reset(&send_buffer);
> @@ -124,6 +134,11 @@ int cap_object_info(struct repository *r, struct packet_reader *request)
>                         continue;
>                 }
>
> +               if (!strcmp("type", request->line)) {
> +                       info.type = 1;
> +                       continue;
> +               }
> +
>                 if (parse_oid(request->line, &oid_str_list))
>                         continue;
>
> diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
> index 9a575aa098..d7c93b5b55 100755
> --- a/t/t5701-git-serve.sh
> +++ b/t/t5701-git-serve.sh
> @@ -366,6 +366,33 @@ test_expect_success 'basics of object-info' '
>         test_cmp expect actual
>  '
>
> +test_expect_success 'type' '
> +       test_config transfer.advertiseObjectInfo true &&
> +
> +       test-tool pkt-line pack >in <<-EOF &&
> +       command=object-info
> +       object-format=$(test_oid algo)
> +       0001
> +       size
> +       type
> +       oid $(git rev-parse two:two.t)
> +       oid $(git rev-parse two:two.t)
> +       0000
> +       EOF
> +
> +       cat >expect <<-EOF &&
> +       size
> +       type
> +       $(git rev-parse two:two.t) $(wc -c <two.t | xargs) blob
> +       $(git rev-parse two:two.t) $(wc -c <two.t | xargs) blob

Can we not use the `test_file_size` tool to do this instead?
That should also be much more portable.
