Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F99D446058
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 17:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786557089; cv=pass; b=Fq6mPgpQmugv7fVjwwUgWq7QNlR30MOBQiGJuKOkyvHJRoPUFebYphLRmyXIFcKVAf4yACmkWOpuJkSN4AVqLxzra9BjucjPMlQwchs0yVtKvlgwAaONc++0vLki2Vat8oP30Oec1Y7GVCZDbf/9ITzohWeWyoKUHONKUWfYWbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786557089; c=relaxed/simple;
	bh=3vc/Q35N7lJrAEuWVDgWIw1evAH0+OQiNXrmNheqdi8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L2AzWuSa4c38tG0FuSLjLBIiIeX//LpmFfG88fsZJVAcbNZGX19SY2IORbv+ZF6lrelX4VkQTx3ufU5PFY0ehsgmVe/hVGfxsvRlUPePsO+7hBLY0ftNz4zzhm77MPGxrb5UVhpl9O0zyBSSgtkXMd4+6r3MEkywUo7ZJ7GwUN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nyd2Bra9; arc=pass smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nyd2Bra9"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-84faf87d19dso1506146b3a.3
        for <git@vger.kernel.org>; Wed, 12 Aug 2026 10:51:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786557088; cv=none;
        d=google.com; s=arc-20260327;
        b=kHAXs3I7rnmbKtJ7pPx59W3T6iZrJEcr1j9WNjyYgAwvvodPgEamGMp0Ewf/w9AGy6
         FQ7SQPeYcVtQ3p8lnyuyO+tP9zbxoUpsXa0pUr8wP/j+qsq+LyWzDc5Q00zHh6yz1yJp
         z6Fk2hZVSXU59aSokpl+eKTZVlOOIwfz+FpwArvlTOblTDH+CUVNdRsgfnIgNFla36Lk
         Z5jq/iDRfnu2+m3ajyDr0ejFpsja74/NCoOU20JY7tg0bCNhhbpOVexc0V+DkRnmSeEF
         XN3gkFxfl4exTgVCwxCieRUYV1h11/RKBXixywgt/+XZ9UldTSj4j/90UmZ26B85fz7i
         +ANg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fOAzPZqfARfvsen5KNZCT0dbuEdiR1rO+/R5RHMT6CM=;
        fh=pN7wu1zwD+xcQsXWuh1aXLiVhMCtwuxgzoUDjuwgVME=;
        b=lX0JRXf00yS8t9+2wi7B2DcLARL7sFRssTowCjsTrjBkrwV2FFmMrlYjBgIdrrKjyX
         H83HOkjjOxQmuEQxa84AfQhtuGbLhe6SGwQb5CmuVLD5m29VBSrPpKJHn+fHUQciR9Gv
         RHbe8D5WvXRrkf8Yuuy8l9lkxll52IO7i/HUMdDzUAvdnAbk6/gnnLVFFZ4aZN284Nk1
         yyGvrvQ+peK4KOatBNMwhF2dtQSOXsltP/ANjhytOjLC3jsBKlXDAZD9oGa2hvwgLijy
         XBvI7pQf9rvrVdr816s0ZPCqXrbjUV9rQrdb2aCi5QU+72BRo1+6kgyfZpM6XoukoXaP
         T5fg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786557088; x=1787161888; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fOAzPZqfARfvsen5KNZCT0dbuEdiR1rO+/R5RHMT6CM=;
        b=nyd2Bra9MTtn/BCfX0f2KpH6tERZ/PCZKBk5lBL6jLw+kUIP7zhJ2gECG2COQmYjyp
         M1YhkyDNKFecYuAu9EWeLxdmh6HGjq6G5tSV7GPFB4XMFEZIvgb7u/V2/7bkPWFIrEwi
         yAkGmZIDSnQNUWugnCXy+hnAMvRN/vr61Wo6DNyg5Q+KSCtc4SN3ulfbr8Ra+plEynY9
         Hk2eAEkRUUW3wfZo+HCSq/qAWC5oNVQd4ioLzIllYbMwQsV53XEjjAKPFKCzHr8YE0Wr
         gO1101TRUVi7ysug67xbi5zBULnOh3vdkgMRWkd2Hn6S1Lc1Y7HAg8qM/1GRTRJ1k/EW
         b3AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786557088; x=1787161888;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fOAzPZqfARfvsen5KNZCT0dbuEdiR1rO+/R5RHMT6CM=;
        b=OhFkNdjK8pPlJ83jIkn4mcskBd47Nh/F4YgrdWjsMKA88qZF4ZirBLZTWo28pr4Ok7
         2NapI/R/GWZakM4DVuBTqsLfxM2vG0GvavSdJd6a/3SJlFcF/PUtmHzV0KHaRVgwtC1e
         o3mBpV8WJOEusP7ICHPoISyjh45OZPG8r8dNvhsl5rKUqCUDHVadSMcheYxi8U0iQN8K
         OcMMx0ojoFCv3tLo+B7BmegTgT5uPG2HKZD1+B00ZQb93XY33cFsPhCaziqeHgiMbKix
         ZO42LgiJEJnxNFDhOZKW5vsIXxdPbcI0vpxYKgNNjtCaXmbZJEPqOPTsAO00EhnWbhgA
         NhLQ==
X-Gm-Message-State: AOJu0YyTBseeVMh1s6RSFPUY7aXJOKCuaKGNahoZgWPayRI9MQSwxxjQ
	+7pStaoV+BDfMuMnzTjxWZPsG0dB1y993oeeDXGKcl9GQEedsLkIgNGtoVWqMrhRGUUonVXhjJW
	tqNFtAE3oCg9JxXpABz+RfDu29k6Eh+A=
X-Gm-Gg: AR+sD13piipcPk4/WV292IRFNgSjN+M6q5GqRL6bSW5EeCpdp5/Ebkluvwfm/3Ut6g3
	/H1DToSyef2Grz1U263Xaa/jfuL8syukrLKwAiFRSPia0HH0hXE2eBFIchIXiEMzXgGyFerD0MK
	64cIQU23z/lgNHhstrEIJNffpN//c4OLzvvh1A+00S4jwAT8yNUrVW8XertWaT++IF+vta1JVXt
	BTbf239M1+NHgxPPNErcbKFqGxK3b2Ko5IVHQB0VuyfLayBCZ7+TtahrGSu6JtfdJh6GNAk1fkH
	ndLxwBsvjfFCcqSatWkbAW/JWJyfHSC5zcxzK4PN6gHvgcObTq+wXtJpsBKj0YJEOwSl9/HWDDa
	fC6Jmx2ry/0jbn1syorrLZRIR+A4ZONI6/H8txThmx+PX9G8w9UwHd9sr8n1IZg==
X-Received: by 2002:a05:6a21:6e93:b0:3c3:8255:8c4a with SMTP id
 adf61e73a8af0-3cc5524466dmr208960637.17.1786557087674; Wed, 12 Aug 2026
 10:51:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806112202.75067-1-r.siddharth.shrimali@gmail.com>
 <20260810174047.6524-1-r.siddharth.shrimali@gmail.com> <20260810174047.6524-8-r.siddharth.shrimali@gmail.com>
In-Reply-To: <20260810174047.6524-8-r.siddharth.shrimali@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 12 Aug 2026 19:51:14 +0200
X-Gm-Features: AUfX_mwyW9UT06TZmW5Ysz4YukqSIyQmF0LQ9koqSGjko2KmFs6CJ8hWr68S6GA
Message-ID: <CAP8UFD3Zvm1rCy6iaviK4jjAXuL4Rkkr7yCTEv-pCdaJYgL_Nw@mail.gmail.com>
Subject: Re: [GSoC PATCH v4 7/7] Documentation/git-repack: document
 --drop-filtered and --dry-run
To: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, siddharthasthana31@gmail.com, 
	ttaylorr@openai.com, ps@pks.im, johannes.schindelin@gmx.de, l.s.r@web.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 7:41=E2=80=AFPM Siddharth Shrimali
<r.siddharth.shrimali@gmail.com> wrote:

>  Documentation/git-repack.adoc | 37 +++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>
> diff --git a/Documentation/git-repack.adoc b/Documentation/git-repack.ado=
c
> index 72c42015e2..63943b078c 100644
> --- a/Documentation/git-repack.adoc
> +++ b/Documentation/git-repack.adoc
> @@ -12,6 +12,7 @@ SYNOPSIS
>  'git repack' [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [-b] [-m]
>         [--window=3D<n>] [--depth=3D<n>] [--threads=3D<n>] [--keep-pack=
=3D<pack-name>]
>         [--write-midx[=3D<mode>]] [--name-hash-version=3D<n>] [--path-wal=
k]
> +       [--filter=3D<filter-spec>] [--drop-filtered [--dry-run]]
>
>  DESCRIPTION
>  -----------
> @@ -182,6 +183,42 @@ depth is 4095.
>         `objects` and `objects/info/alternates` sections of
>         linkgit:gitrepository-layout[5].
>
> +--drop-filtered::
> +       Delete the local objects that match the `--filter` specification
> +       instead of keeping them in a separate packfile, reclaiming the
> +       disk space they occupy. This is intended for partial clones,
> +       where the filtered objects are promisor objects that remain
> +       recoverable from the promisor remote and are lazily re-fetched
> +       on demand when they are next needed.
> ++
> +Only large blobs are supported for now, so `--filter=3Dblob:limit=3D<n>`
> +is currently the only accepted filter. Because dropped objects must be
> +recoverable, this option requires a promisor remote to be configured
> +and refuses to run otherwise.
> ++
> +This option requires `-a`, and implies `-d`: the objects are dropped by
> +rebuilding the promisor pack without them and then removing the now
> +redundant old packs, so the redundant packs must be deleted for the
> +space to actually be reclaimed. It is incompatible with `--filter-to`
> +and with bitmap writing (`-b`/`--write-bitmap-index`), since filtering
> +breaks the single-pack closure that bitmaps require. A bitmap setting
> +coming from configuration is silently disabled for the duration of the
> +command.
> ++
> +As a convenience since dropped objects remain recoverable by lazy fetch,
> +`--drop-filtered` refuses to run while another operation
> +(merge, rebase, am, cherry-pick, revert, or bisect) is in progress, to
> +avoid a surprising network fetch mid-operation, and refuses to drop any
> +blob that the current index references, since such a blob would only be
> +lazily re-fetched by the next command that inspects the working tree.
> +These checks are skipped in bare repositories, which have neither a
> +working tree nor an index.

I think this patch could be squashed into patch 5/7 ("builtin/repack:
actually drop filtered promisor blobs") except the above paragraph
which could be added by patch 6/7 ("builtin/repack: add guards for
--drop-filtered").

Thanks.
