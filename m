Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C925116DEA9
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 08:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736498844; cv=none; b=kDaBD2lS7xS2K2YwoR7iTg+ym73cWnka7oTcIJk29E6YFWN6IW/VnH3l0r15NwRo2oyDQpu3ZgVZYIppMWjd+U4vehtsB6TdCoCmEgoyDY0LDOrihEmce0uFwP1Zrafty4/CmFF9JnMhPobQQ+HYByTVRsYHkK1UHxTMB/Q87Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736498844; c=relaxed/simple;
	bh=WM6e7EMw6au24pt0Jy5gXylw9a+iT3+VSZvBECZSkgc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BsnBSa019j0jJj0+qmkbYdIVU6SVv/l1BHf4o8axVaC4Xvj33PcvsFIudFfgbH1/UhW0fW2byQNUZG2HJhq/sdWEvfgmFCt0PWCrlfzDngzzQsXkBZJ8Mt3SbPU2kLi9rU+Hz8h17jKB0VWphQJAZ2+gyLdAROouXTWiASHXOEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hDZ8qVq+; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDZ8qVq+"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9e44654ae3so279435066b.1
        for <git@vger.kernel.org>; Fri, 10 Jan 2025 00:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736498841; x=1737103641; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VWfhf4ZU/LLMozF/HEEOg+208zmx/8WBcSp0EhWFN9A=;
        b=hDZ8qVq+PY1eOCFV/wjrFZRc4g4J1cqs6KU5JQvYTt6iH4qeUXGjRNUue4yFwIP8U+
         0WFIs+QZdaWb0VHTdqSzt55L/0hFH/mTbxZXqHnaEyvrHfWk3YLBx7AVCKTtaRtQknM7
         07KPZOAQOfhQ6bEqZxkk7RZlWIXFSZ1FDj1qb9u5G2IPzip8pCKcvlZWB48HGdTX7myI
         WmmJDf9sfeJbNDLWzo85z1PyfAcNJHn/gcKsCca9PSD9bShWJjDBroKHKFgWRC1eNplk
         VnsGNGHgo3ItuVwg01CscagBGWdGCymc24wVSMu82CGZ7ogbS5lfltXKXpCYIYMyx1JM
         tl3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736498841; x=1737103641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VWfhf4ZU/LLMozF/HEEOg+208zmx/8WBcSp0EhWFN9A=;
        b=Qn+x6D6TxPprPdNeJdTiPYNMa5BzbGlPyWnAkh2MdDHtUmON5uA0FLb/4uMxm1aZXZ
         daLueeXhUnLxpTnvEhpRyL8fClbkOY4ObOxHBrS2W8IlXs2pGWcdOcyvlyAVCx0U6diV
         OIyOgKoQdlv872xIt9MstKT33mzUGeSMqkXz/td7Q1nz2X9SlTTtnCiGejlNjJekIPpk
         +bi2PJe6whWwmtQMVCRlaDwZu4NlHHFa0kjM+oUKVnsbJuzAy8lE55hXVnO/A4KR5e4e
         J4s57mtLwatMyZ9ztjVGCCTEkKbCg1FHfvl3BgOSFbqvx9UrplA2dEqIwPDefk4BNlBU
         DDnA==
X-Gm-Message-State: AOJu0Yz04fEzQMWi6vHPftqbSOP+4iXPEns3CuUHr9DXGOxQVPLbbAfC
	75LdLggPbIyeJ4YPbaUzETYfA5P+cotKGUq6CHdO8zR77M9rtxkMJgNxiZS2vEKDIkPj00DMKV2
	UNme92TCkm2D+hZHNTSHSU82I6a+SELzq
X-Gm-Gg: ASbGncv7TjhXTdvZk/LJh48lsVu38g1UBPyPtSykUPds5ADSIqgNvo4+9ZbTdnBw6DH
	ootOCjGfENEH9nkqNGxmZV+umcxuSTwEiFDznp47G
X-Google-Smtp-Source: AGHT+IF0IkJmsaEJexJ9902Ilv7FtSbyBTyWjxruYfwNl6d5O2j0E/zrO05Q0AewoVDwRDidYgboWIu02iRtsvd8nPw=
X-Received: by 2002:a17:907:7b89:b0:aae:ec9d:5fdb with SMTP id
 a640c23a62f3a-ab2ab748b8emr813772166b.28.1736498840677; Fri, 10 Jan 2025
 00:47:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250108034012.211043-1-jltobler@gmail.com> <20250110053417.2602109-3-jltobler@gmail.com>
In-Reply-To: <20250110053417.2602109-3-jltobler@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 10 Jan 2025 09:47:08 +0100
X-Gm-Features: AbW1kvaLWMIFFAOx_GdCa3f8uqZ1v-WaFZQd_VW7L4CTIxrb82bqsLPkhhrjjRo
Message-ID: <CAP8UFD2Cfriv4puPe8agaTZOpLHr-=4CkK-yrzw8fH-k5mPkAA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] rev-list: add --missing-info to print missing
 object path
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2025 at 6:38=E2=80=AFAM Justin Tobler <jltobler@gmail.com> =
wrote:

> +--missing-info::
> +       Only useful with `--missing=3Dprint`; prints any additional infor=
mation
> +       about the missing object inferred from its containing object. The
> +       information is all printed on the same line with the missing obje=
ct ID
> +       in the form: `?<oid> [<token>=3D<value>]...`. Additional attribut=
es are
> +       each separated by a SP.

Nit: I'd rather say "The `<token>=3D<value>` pairs containing additional
information are separated from each other by a SP." to avoid
introducing "attributes" which might not be very clear.

> Any value containing a SP or special character
> +       is enclosed in double-quotes in the C style as needed. Each
> +       `<token>=3D<value>` may be one of the following:

It might be a bit better to decide for each token-value pair how the
value is encoded, instead of deciding in advance for all of them.

> ++
> +The `path=3D<path>` shows the path of the missing object inferred from a
> +containing object.

For example for the path, I think it might be easier to always enclose
it in double-quotes in the C style rather than checking first if it
contains spaces or other special characters, see below.

> +static void print_missing_object(struct missing_objects_map_entry *entry=
,
> +                                int print_missing_info)
> +{
> +       struct strbuf sb;
> +
> +       if (!print_missing_info) {
> +               printf("?%s\n", oid_to_hex(&entry->entry.oid));
> +               return;
> +       }
> +
> +       strbuf_init(&sb, 0);

I am not sure it's worth initializing the sb separately from its
declaration above. Using "struct strbuf sb =3D STRBUF_INIT;" is more
standard in the code base and I think most compilers these days are
likely to be able to optimize away the initialization in the
"!print_missing_info" case.

> +       if (entry->path && *entry->path) {
> +               strbuf_addstr(&sb, " path=3D");
> +
> +               if (quote_c_style(entry->path, NULL, NULL, 0))
> +                       quote_c_style(entry->path, &sb, NULL, 0);
> +               else if (strchr(entry->path, ' '))
> +                       strbuf_addf(&sb, "\"%s\"", entry->path);
> +               else
> +                       strbuf_addstr(&sb, entry->path);

I think the above code paragraph could be simplified to just:

            quote_c_style(entry->path, &sb, NULL, 0);

if we decided to always quote the path. The decoding part would likely
be simplified too.

> +       }
> +
> +       printf("?%s%s\n", oid_to_hex(&entry->entry.oid), sb.buf);
> +       strbuf_release(&sb);
> +}

> @@ -656,6 +703,15 @@ int cmd_rev_list(int argc,
>                 if (skip_prefix(arg, "--missing=3D", &arg))
>                         continue; /* already handled above */
>
> +               if (!strcmp(arg, "--missing-info")) {
> +                       if (arg_missing_action !=3D MA_PRINT)
> +                               die(_("the option '%s' requires '%s'"),
> +                                   "--missing-info", "--missing=3Dprint"=
);

It seems to me that this check should be performed outside the arg
parsing loop so that this check passes if the user passes
"--missing-info" before "--missing=3Dprint" on the command line.

> +                       print_missing_info =3D 1;
> +                       continue;
> +               }
> +
