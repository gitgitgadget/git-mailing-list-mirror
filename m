Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8E940DFBE
	for <git@vger.kernel.org>; Sun, 22 Mar 2026 02:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774145060; cv=pass; b=Oqi39Ydqr0I2h+LpM6eWylhIBCqoOoqw/8KYThb7EgLGx78Ug7B/heKNChTlODYMyNNvPZhQXbrWx+KtMCdX8u6dN3BceDC7CQAmcxJUW6GbN4tsEy27DhBWfLD4xH65Ma7bQBSV59BGckjmQGLldC+7zjO6hEAlVwK5jX1t7jw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774145060; c=relaxed/simple;
	bh=SdSAyqa5VwbuuB4XREL2Jy3KItaCf/SnqEocpuzS+Ic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=txNw99dbWCJBKWyx1L52OcBuU25dhVKjndh76EQzy+hq9PD061R0i8NmByzufE+BEfpnrBDUbw76Pdwlrxbsispoyd5fFg41+aw58ZTU4xhi6pDKqsoF3mdmb9N4ved2zolCxsKIMtv3RwhvREWulUmVZrnhCAI51h31KQfBcWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-124713e4244so144781c88.2
        for <git@vger.kernel.org>; Sat, 21 Mar 2026 19:04:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774145058; cv=none;
        d=google.com; s=arc-20240605;
        b=Y3b1BiuF06i2oyi2A0Nwm370Mk4znAS6IKk5X7j88fxC3HiUezAd3ZD/jKas6j2uP9
         +JdCU+0oCHFcZCnlFt5lgAE63kQYAG9GqZXUObxLOXTWtUtjA8kr7Ab/KrAHc44kZQI/
         7pAC6uZNBpix+Ql4MzziblRjmuQkNLEQecLCugmMhX3ipvBuABb+6xm2pmlZ6zS/gZM4
         FGZoidFcrF15fujUyB95lPxehjCWCzpVmuGAowpfqihjhqq6PCpEa3r/LARjvSE7UaL4
         c+m+DzP/QrGuGweXyX/lgZ03hBDfpejhF1DwQj7+FvJ5sd4qBxkyfBKjv/8gQDtVztDA
         dvZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=GpH+IayVc7COz3Kq5vspN4DDJQZUnb/VO5FVrLAX9lU=;
        fh=6vVo/7/laIe1JqA+xNYlvxMrNtmBkIXrc5uXeLhLzrc=;
        b=gA9OjlHF7UUuhH3SxBoMIi9vHCFiN3tUS6rtFCnwDL5BCUDSsAfghZ7FfpDpCzy9Hb
         4EjXKCz03heEKQsPaSDDz1SNJmPaCF4EEVgvws90skDtX1Jz00EUpdfnL2h0S+WTaYKd
         RL7gqwcPDwzzzeAImRVYBh4dLaBknPvz94J+ObjQ+cEvjqHhlZ6r+5uGz7buPPWh1lhS
         xJ/4CQlrXqGUWsUa10wJCVEEOXyLpwc37Q2eeyRWsH+QpT8cr2umNMrEj5uNY374W2r7
         5h4hLoYp/87yKa4adAqL81Bqq2s2lrzOmtYqPOqBR2Bde3lG5wzb3ZbGOxnWBnE+s3WH
         6Cmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774145058; x=1774749858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GpH+IayVc7COz3Kq5vspN4DDJQZUnb/VO5FVrLAX9lU=;
        b=NzXhCqqiRiq4vgQEFcjxZe9kf6gioK9PXqj+SCPXsnkJ+WJw86Qo/n7lobCRQEVrab
         qvrHPNr46pBtTu80WygG8aGMM7zelye5YTqmX3+iUB5PTXPgiOX9rCYKXknTo5onWklB
         yNf4/WiwVnY7rrxDc0Hz2YONp3ejwbkAnqBcuUAXRCCpBFLg2Wi/6ZIX8XGn5u7zRo8c
         VtkCkel/BsyzOtKBSwiuOaa7r7BlrKCT2JLITNqw8/tBBzTBDMHHBAG12C5uZYBB+2tg
         FXgBtuSkSQBuGPtsbmIKVxur73HJXk9ugaXVvNKuh/Ymubr1ZlilJ7p559eoFnsbRwZR
         gyxg==
X-Gm-Message-State: AOJu0Yzw3dYQwYkhOl7z05AtgwrPqGXDw2cBQMkJfJcWDFKj864cP7so
	hdrIKKm3NoNaqbA2BNTxDmZxsUnpzRcMu6znIoPRuy+mT+cU64U1YclP3Ya/LQrUPttTbbXwtQq
	fCJYHyDc8PxTMCTGVkM1571v7qsCJlUY=
X-Gm-Gg: ATEYQzz8yD0qRypvIivQAcQnURCfJVvVaaIdd07NHy+ft+uw+Q8hagzfMX3py6SAERa
	VyxX6EDXhVVpkkD/LvFncyXJYwEsItjXBhrfd3Wb3Ok/f4HQTi8VymmeRregdtaroxGzRoLWr8f
	5moeKl6QeLrO1iDFKl5wEyZo2+nVFFrthe1rpCUdnZkiPqmH75dEgGAS6YAZKqfLgVcFMO1q5A+
	hLSquxO/nuILFBwOebh7iLulPnGoFCbcKxGwa9oNdT5Qi7FYnQc5Vcu1prq9uz9sxgknghcv3Lw
	LIRHP1U3yeUfbzw2wbcZHuWNQjKod6X+abYvpGXN+w==
X-Received: by 2002:a05:7022:6723:b0:119:e56b:c3f5 with SMTP id
 a92af1059eb24-12a726d1d74mr1712256c88.5.1774145057496; Sat, 21 Mar 2026
 19:04:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1774125871.git.lorenzo.pegorari2002@gmail.com> <3c0702f81b3e4a57cd38284ab90f8277da3fcd40.1774125871.git.lorenzo.pegorari2002@gmail.com>
In-Reply-To: <3c0702f81b3e4a57cd38284ab90f8277da3fcd40.1774125871.git.lorenzo.pegorari2002@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sat, 21 Mar 2026 22:04:01 -0400
X-Gm-Features: AaiRm52qhUkTiLJNoode_YNyqBZpB98NHT4g8wJ18ScIPMV_gY0q273MWRgPLcg
Message-ID: <CAPig+cQSsMfvHJnwuXGQ1Je8ekz=Rqbaibn-3shbya5y-5xTKg@mail.gmail.com>
Subject: Re: [GSoC PATCH 2/3] pack-write: add helper to fill promisor file
 after repack
To: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>, 
	Karthik Nayak <karthik.188@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 21, 2026 at 5:29=E2=80=AFPM LorenzoPegorari
<lorenzo.pegorari2002@gmail.com> wrote:
> Create a `copy_all_promisor_files()` helper function used to copy the
> contents of all ".promisor" files in a `repository` inside another
> ".promisor" file.
>
> This function can be used to preserve the contents of all ".promisor"
> files inside a new ".promisor" file, for example when a repack happens.
>
> This function is written in such a way so that it will read all the
> ".promisor" files inside the given `repository` line by line, and copy
> only the lines that are not already present in the destination file. This
> is done to avoid copying the same lines multiple times that may come from
> multiple (redundant) packfiles. A better way to achieve this might be (is
> definitely) possible.
>
> Signed-off-by: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
> ---
> diff --git a/pack-write.c b/pack-write.c
> @@ -621,3 +621,65 @@ void write_promisor_file(const char *promisor_name, =
struct ref **sought, int nr_
> +void copy_all_promisor_files(struct repository *repo, const char *promis=
or_name)
> +{
> +       struct strbuf promisor_source_name =3D STRBUF_INIT;
> +       struct strbuf read_source =3D STRBUF_INIT, read_dest =3D STRBUF_I=
NIT;
> +       struct strbuf write_dest =3D STRBUF_INIT;

These strbufs don't seem to be released, thus are leaked.

> +       int err;
> +
> +       FILE *dest =3D xfopen(promisor_name, "r+");
> +
> +       struct packed_git *p;

Style nit: Place all the variable declarations together (without blank
lines), followed by a blank line.

> +       repo_for_each_pack(repo, p) {
> +               if (!p->pack_promisor)
> +                       continue;
> +
> +               strbuf_reset(&promisor_source_name);
> +               strbuf_addstr(&promisor_source_name, p->pack_name);
> +               strbuf_strip_suffix(&promisor_source_name, ".pack");
> +               strbuf_addstr(&promisor_source_name, ".promisor");
> +               FILE *source =3D xfopen(promisor_source_name.buf, "r");

This project still frowns upon variable declaration after code. You
will want to declare `FILE *source;` at the top of this loop body and
then assign `source =3D xfopen(...)` here.

> +               /*
> +                * For each line of the promisor source file, check if it=
 already
> +                * is in the promisor dest file. If not, add it to write_=
dest, so
> +                * that it will be written in the dest file.
> +                */
> +               while (strbuf_getline(&read_source, source) !=3D EOF) {
> +                       if (fseek(dest, 0L, SEEK_SET))
> +                               die_errno(_("fseek failed"));
> +                       int is_source_in_dest =3D 0;

Ditto regarding variable declaration following code.

> +                       while (strbuf_getline(&read_dest, dest) !=3D EOF)=
 {
> +                               if (!strbuf_cmp(&read_source, &read_dest)=
) {
> +                                       is_source_in_dest =3D 1;
> +                                       break;
> +                               }
> +                       }
> +                       if (!is_source_in_dest) {
> +                               strbuf_addbuf(&write_dest, &read_source);
> +                               strbuf_addstr(&write_dest, "\n");
> +                       }

The commit message talks about this, and it is indeed very ugly that
this re-reads `dest` from the beginning for *every* `source` line. Is
there a reason you can't simply read `dest` into a `strset` (see Git's
`strmap.h`) in its entirety before entering the repo_for_each_pack()
loop and then merely check the strset for existence using
strset_add()?

> +               }
> +
> +               if (write_dest.len) {
> +                       strbuf_strip_suffix(&write_dest, "\n");
> +                       if (fseek(dest, 0L, SEEK_END))
> +                               die_errno(_("fseek failed"));
> +                       fprintf(dest, "%s\n", write_dest.buf);
> +                       fflush(dest);
> +                       strbuf_reset(&write_dest);
> +               }
> +
> +               err =3D ferror(source);
> +               err |=3D fclose(source);
> +               if (err)
> +                       die(_("could not read '%s' promisor file"), promi=
sor_source_name.buf);
> +       }
> +
> +       err =3D ferror(dest);
> +       err |=3D fclose(dest);
> +       if (err)
> +               die(_("could not write '%s' promisor file"), promisor_nam=
e);
> +}
