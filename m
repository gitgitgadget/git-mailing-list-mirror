Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C7D1624D5
	for <git@vger.kernel.org>; Wed, 22 Apr 2026 15:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776870644; cv=pass; b=YM+qD0zlOywWS9EAEEjyqyGfy+iCt8dxeyH1o+uylvjZ0DKeKaOOJJ2XLlbXxoeTnEH+oK1rk9wPV86cXkQBkpfnqPt+6v4ZPlokT98UWdXwry3lF07NmH6U2O1knrIR8l6uXUUN+347A2NrSOLHn2Fw11Ff398BK1hk5vZ/lFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776870644; c=relaxed/simple;
	bh=Hw5ODwt96DyDUp1gl5pwIYisMjVCQzplfNCz/NBLZVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qAh2RmaQBRUIOv1LhKAk1rIU6CJf4n2zt6peCVYkbSNaHPBm6pWpxu/OORGbCjnjg4SUmLxHKwMadb0t8Te20LZ8NWx4AdUcNZXLbcl2yoyFlo7JPVq0mA2AOR0HJO7DvN1QydK3OubFVd1BJOg5/Y2hHmN6AT+XgZ3RHb2jtZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JJmT4R3S; arc=pass smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJmT4R3S"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c79467f11abso3649650a12.2
        for <git@vger.kernel.org>; Wed, 22 Apr 2026 08:10:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776870642; cv=none;
        d=google.com; s=arc-20240605;
        b=BPy4uRBXopdG2IY2K4c1yAugr+bspvMUPlljA2KhRIvrD3jgOW6EUFEGup/wt1B7fP
         OQBtwHlf5/uzqy99bIQ3ltVrKpmLhEIaNd8lGoD9fXffOMZO3kZjw+EZCtMrt3WyHxl4
         uUbnciXvYCuBsLDtarzDirs18CVG+UUfvuC52C1YkxLa7AKrg+pG5vw0c1boJ+dCRMJ9
         XaDkGHQmOxiPp00Y4WTriMG6sHCXc4IJoR28HYiSoMgj7kNz97CdgjXKlD72Y/1YH22f
         Xrf4FEJu7pruLSbrtWpws0X0MQJlqIalRxU75yc83x1/qYQthupIZeNgZzWPzbXX7hwr
         XGFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fN56bXxK2LJnPnyNIgfTFqCo6Rrqje76UZlMlsPchCg=;
        fh=DhOplH8Wm0HJxlPTZpb3tKfCO/1+B0ZPOux/REQhY2Y=;
        b=E+6hNRK8R1t2rIT/qVPJX43WU7JukPvwu6mH8BTYtE8D6pZ1yjQj5hAZAFWoxEeMEw
         mw25yzeL3PLanJkiY6rY32IRLtSdFrL9RzcWhVYRKzg1FHk2x6Pl6iTHW+alLT/7rUMV
         RfWX7ah8w4QAuPKNeauDyvvDWOUbAY8up4iH4wTv7rhIlHDb3W2s2EsAU+3T5aVhGAbt
         nplEiSLQW37huhB11miVIoEihHG48TcnLBxGNP7EZGqwF4hn3L6JmvuF/IkCUdvPZAWD
         iGhYDSiv8fKv1c5d/uLDqFjIr8NJLWCzGwoou4PGSdinXWJpqOeXx4Wm2icTZoR69vww
         ltZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776870642; x=1777475442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fN56bXxK2LJnPnyNIgfTFqCo6Rrqje76UZlMlsPchCg=;
        b=JJmT4R3S5oFME+Dkc/jDuFW5UXt8N7lXKCIgbPRkVrG3QthTRrtTxxhXCmx/ZU6FUw
         k+IQ9AZ71SMVB+9S22Xo45yy1n3BgIoNSMFsckvmi3CMS7M/89mEFz2HwU/WAqu7rqnS
         mEP/CApNccODd/us2IGaVbG9rpqnj5hmtxKNujo7RUiCWSjHbItZPuzvZFb0AatmIQlL
         xB5gC3jY9jH48EW+RW1scsRqR4v8j0REio8wqDdiVkngeZfsTuw4PExxMpF0uK4iRQvU
         0SmPO7w3s9hhApUDeezcxQlvTUkUtNsF3RdBdjYREZm5tk5SWEf7wMjxCIf5NqIKVr8X
         4Z6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776870642; x=1777475442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fN56bXxK2LJnPnyNIgfTFqCo6Rrqje76UZlMlsPchCg=;
        b=bbDCPFyjm0f5Y4iKg3H2CASE663FQDAQFaYHZAI5uuhMeG0R/tlUDN5OK3OBX8IT3t
         oV3mWuK+ypl4nmDHBX9kFxAR79/iDgtGQ9pvQMymRldEQAti9jq5Ss9EJj6VtgxeQsCH
         XJpbJhNpgSDNfJRkcRZUrQaZZLSTSH+fikmOpPv/pQvj8+hy/OOEL47UXLMFTu9vYZZq
         0yE3Mdsg0R1FWoXOPwQ/OWo5zaNWckNUdiG9APHSlBN55O6l8SwnLmAH11+aWDecF4wn
         b4hVBGJLoBPz+W6m6PSvhURtaFlB/ZEbCzAHu/AdOPKRBM4WRG7Nxbe+K8FbEvu/LYTd
         CPvQ==
X-Gm-Message-State: AOJu0YwnT1OrfxcVuSCY8N2Dv7Tr1GFl5nVjPO7puCeBTSLk0UZB8jdg
	rbw+ekfLCiVqS89eVgTgGsC7K0bkvbeVs4mEhQCziuRsXJg9zRdpiM3/zvoX+bu4yH1rX9VpnqG
	/TFUI50gDFkgC6IZzVVFIWOmCk8U1GGOUgw==
X-Gm-Gg: AeBDieu4xeyGikWZBcSt4uU9rWmARhNhhTSH10KI5fuIf+Kj1/pSrHQgFIb2eN3cXfr
	SqEQ1krs0GC7/8W1URZiH6jKbUoKkly8khAdrdVz5OjRuAu1HequYPJM3aqj5/bKCBm+Hd16I5J
	24ikc+/hdHLNZDxpvPXkeeNlg+ehes9Fq9VLHFRX/d7GyY2EQCiDNlzYGRaWXFd0Vv2myYNHyTd
	WFwdcdogfoHEA7WdgqdsoXHk2vC6CCrzDaMvMEe3cn5O3Po0ipHqCgwYfDgWa9+D0r9cC5PjKOv
	OpolJJ3Mqhwk6kNUHc6aeKxURqh3UTVF7ioRNksC9256EvlqsmaFJObO6SmMH2rsenAwY6qKAJq
	d4MmS
X-Received: by 2002:a05:6a20:2195:b0:398:7792:3882 with SMTP id
 adf61e73a8af0-3a08d703f18mr19456776637.16.1776870642290; Wed, 22 Apr 2026
 08:10:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aeakf0xcjSteTMZp@fruit.crustytoothpaste.net> <20260420221425.2763661-1-sandals@crustytoothpaste.net>
 <20260420221425.2763661-2-sandals@crustytoothpaste.net>
In-Reply-To: <20260420221425.2763661-2-sandals@crustytoothpaste.net>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 22 Apr 2026 08:10:29 -0700
X-Gm-Features: AQROBzCjAeaxi3sSo4aVicgk1EvWFJ0NLZG-bCT2x3oBuHtMWOK11WvDyBfDV2w
Message-ID: <CABPp-BEd9saiMWVdcSaZBHqGreshpA=fGZc4AvYkoU=swSSuxA@mail.gmail.com>
Subject: Re: [PATCH 2/2] commit: sign commit after mutating buffer
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Kushal Das <kushal@sunet.se>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2026 at 3:14=E2=80=AFPM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> The ensure_utf8 function can mutate the buffer to change its encoding,
> so we must call it before signing the buffer so that we do not
> invalidate the signature, which is made over raw bytes.  Add a test for
> this case as well using 0xfe and 0xff, which are never valid in UTF-8.
>
> Reported-by: Kushal Das <kushal@sunet.se>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  commit.c                 | 12 ++++++++----
>  t/t7510-signed-commit.sh |  8 ++++++++
>  2 files changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/commit.c b/commit.c
> index 790dd2faed..bc41859be1 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -1747,6 +1747,11 @@ int commit_tree_extended(const char *msg, size_t m=
sg_len,
>                 oidcpy(&parent_buf[i++], &p->item->object.oid);
>
>         write_commit_tree(&buffer, msg, msg_len, tree, parent_buf, nparen=
ts, author, committer, extra);
> +
> +       /* And check the encoding. */
> +       if (encoding_is_utf8 && !ensure_utf8(&buffer))
> +               fprintf(stderr, _(commit_utf8_warn));
> +
>         if (sign_commit && sign_buffer(&buffer, &sig, sign_commit,
>                                        SIGN_BUFFER_USE_DEFAULT_KEY)) {
>                 result =3D -1;
> @@ -1780,6 +1785,9 @@ int commit_tree_extended(const char *msg, size_t ms=
g_len,
>                 free_commit_extra_headers(compat_extra);
>                 free(mapped_parents);
>
> +               if (encoding_is_utf8 && !ensure_utf8(&compat_buffer))
> +                       fprintf(stderr, _(commit_utf8_warn));
> +

So the users might see "commit message did not conform to UTF-8..."
twice? (Isn't compat_buffer likely to have invalid UTF-8 whenever
buffer does?)  Do we want to avoid that double printing?

>                 if (sign_commit && sign_buffer(&compat_buffer, &compat_si=
g,
>                                                sign_commit,
>                                                SIGN_BUFFER_USE_DEFAULT_KE=
Y)) {
> @@ -1818,10 +1826,6 @@ int commit_tree_extended(const char *msg, size_t m=
sg_len,
>                 }
>         }
>
> -       /* And check the encoding. */
> -       if (encoding_is_utf8 && (!ensure_utf8(&buffer) || !ensure_utf8(&c=
ompat_buffer)))
> -               fprintf(stderr, _(commit_utf8_warn));
> -

Did the change in this patch also fix a short-circuiting error?
Previously, when both buffers had invalid UTF-8, we'd only call
ensure_utf8() on the first one and fix it, and then short-circuit and
not handle compat_buffer, right?

>         if (r->compat_hash_algo) {
>                 hash_object_file(r->compat_hash_algo, compat_buffer.buf, =
compat_buffer.len,
>                         OBJ_COMMIT, &compat_oid_buf);
> diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
> index 1201c85ba6..071dbb3d39 100755
> --- a/t/t7510-signed-commit.sh
> +++ b/t/t7510-signed-commit.sh
> @@ -462,4 +462,12 @@ test_expect_success 'custom `gpg.program`' '
>         git commit -S --allow-empty -m signed-commit
>  '
>
> +test_expect_success GPG 'commit verifies with non-UTF-8 commit message' =
'
> +       printf "I hate\\376\\377UTF-8\\n" >message &&
> +       echo unusual-message >file &&
> +       git add file &&
> +       test_tick && git commit -S -F message &&
> +       git verify-commit HEAD
> +'

Nice test.
