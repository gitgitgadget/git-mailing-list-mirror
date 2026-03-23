Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E372D363C65
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 20:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774297678; cv=pass; b=HspRTPWqHcCqBjZ/9t9n624mBP+awFgxjuq97RQ/zZ6fQ7KOS7BAhtpDYWg6CsT92mY9UJg6GwQqsHzWpc1UOrO3Bsb2OMj8xQMnprckLaAfBMkhOX3u/SVSpCbvFK390f1Va9Iq5acsFf9fQVM143jlnaWQKNJWK2d58ySun3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774297678; c=relaxed/simple;
	bh=pX5uEAU4jPL2UJ71pN+5vfxpHSGkaZ2jKpegdSmp5nc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q2U++ZAfY+pAsmrpWz0D/dGhAnOqW1qSuYQiMB7DlXFraOYhKlLO/Xv9o/9vPmG6U0NEqjumErTqsREUpD4kfr7NLBI8oJpPrrWFbm664NpV0vnJ6udbJoLa/Ccv5djkAy/evqC1IzsOxmLzHz3Xnb+140pKEsSMjVCZVvOAtdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-127148c2112so411644c88.3
        for <git@vger.kernel.org>; Mon, 23 Mar 2026 13:27:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774297676; cv=none;
        d=google.com; s=arc-20240605;
        b=VIAVoHDz+pyOFg76NDWc7agzouRIL3n+4ZNNYRc4q6TP7XXrGYPHSCajrCIDDEm/aC
         YodMDL3dWmVL9h3sB90/vuQz4Sq3ybbzmTMRX3xOApLY/TbGK5ue81SeSsxOfMpRVjT/
         QlA/iirXOdjFofGusaYgvd3Y87Ea6Cwv1YSreJcn5Lw3Iv127os72lD9dWXPL/iPCbtn
         eLic1oSB+AIHlE9ZUt30fHROBgw0eDtPbiLsgsdDG8S/1hh1JI0FquA+BQ/Wh8eeaU0Q
         tTRC+ecRCJu7JMDu5g8cMDfdp/0JgSIOhsEVHv28BCIA+BQ6sQbey7jQ82+0CVlK/3Fo
         +P1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=Qfm2JNcBs0bLgYRxhklQYCrFg/U8FzWGu3SsoN+wK1E=;
        fh=2G/e6Lw/f+E+f8jTR0OeNBw5Z436rjI5/HE2AOyMqWw=;
        b=XkWUI2t/q5dFoCJ2BSqsX1w/48q3PXJPqjOQmu6Bbo9k456hpijAnCzBC+qZwnLrDZ
         7lfXku0e9dklLg3/gOYYak1liVyTiTFwLtr6fvC/5SPdrF0buJQAaGgO/QbqLqxfXsk4
         +Q9LgyR9YjUhT7TP13bsh7o9UsaTsJpLxAu9uQKOPyZvcRBe67hVokypPt/Mof2j/xDE
         jzxpHrtizdvk/Zp3L61cL5NXH3xLC3SvJyPAqlo2Xo1OugKfJY87LByY6p/yAQaipTWN
         F7giihyaauZYgMVb8Qb9gYmfqoh4kvYFzv/pYGZWf/fNax7BKWblZmQxP363z7pSZ8kU
         IoAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774297676; x=1774902476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qfm2JNcBs0bLgYRxhklQYCrFg/U8FzWGu3SsoN+wK1E=;
        b=KjD2n5qsdxVdAnKfsfoC5+CoX30xXx5TQc+F/ThrsbIOvUWHx5dAngLwORluOJxCNL
         BCNAz3blVNrcoh8ZxkEX2pEwK5ooNdxTGr3l1++s1ZX7otqlQD1AM6wH1g2uVdsaefOl
         PBHSNJSqqK3OYDKqeS/dJdIqnRRz9F8/PuIdTMIrTIkx99AAJrMyHw5MY5j0H4MzXSyb
         NOmtEV2roYdF+R+WtGR0RMokp+gJvKaX3gO+bverojCxBWrrMbPYxUuYdVBVJju59Alg
         5jjrROxmfn2dm+h4QHFrue/IRg9RbrWXyWPFfN1mYISZM3pzcgo01ZNAzU2SCBrM+jRE
         HW1g==
X-Gm-Message-State: AOJu0YyNp+cpjHTfXodRUWTBOGnJF/PXeR/O5+sPT6JoygOXtaso/jr0
	lvaUhTOel2/zoFII3FZn+dlC8qAE2DymF+0GBMkThEVLxYvMpxp+eMklZgCnbU6rHycd0fEV81J
	hipqJIUic+1Ei5nFwRYmLdUrwX5SEKcs=
X-Gm-Gg: ATEYQzxBsSCn+WpmXC5ls6fft5QF3k/HrIEs6RkySez/9b3alZ0PZjJhIHS5U7NbwIK
	jyYRhEkgnTMfhf9lzQeWs1UIRw8oWZ/b8QCRTsebE/TQDCQxMsKwM/noU8Y9nay16YPAVPqLNc2
	yhAMB0FRp54FA1BkL2iYIm4rF80TXQzZ0uGINapyFvCAa8j9joOcI9OPsCevQ3CfpI3CuqR7hy7
	p5E2LQgFdwCxvrDh50Kp6lPEjWX38Exe00PeGEQ4DhGlnOSrzo0o//oHTPgGjQ87/WFUTRln+pG
	tzxtPk/e+Mk0v2etaXPTSnFlleOIJlaIiN8aGrU=
X-Received: by 2002:a05:7022:6883:b0:12a:6d14:df9c with SMTP id
 a92af1059eb24-12a7265122amr3076779c88.1.1774297675973; Mon, 23 Mar 2026
 13:27:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1774125871.git.lorenzo.pegorari2002@gmail.com>
 <cover.1774205661.git.lorenzo.pegorari2002@gmail.com> <0bb031e7443bb53abbbb0afaa347285d6d8cf7b8.1774205661.git.lorenzo.pegorari2002@gmail.com>
In-Reply-To: <0bb031e7443bb53abbbb0afaa347285d6d8cf7b8.1774205661.git.lorenzo.pegorari2002@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 23 Mar 2026 16:27:44 -0400
X-Gm-Features: AQROBzDKAaKnuHDTSAAzMFoxrYJ6c6U8W0H21rT7i6-ZOwpfJt6W0_sYC0ctylE
Message-ID: <CAPig+cR7-3rdkHvGbzk8O7P=83pxBTvqXTUgMxYpf+OK9jNCgg@mail.gmail.com>
Subject: Re: [GSoC PATCH v2 2/4] pack-write: add helper to fill promisor file
 after repack
To: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>, 
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 22, 2026 at 3:18=E2=80=AFPM LorenzoPegorari
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
> multiple (redundant) packfiles. There might be another better/cleaner way
> to achieve this.
>
> Signed-off-by: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
> ---

Thanks, I think this version addresses all my review comments[*] and
looks much better overall. Use of `strset` makes a big difference over
the previous attempt. A couple minor comments below...

[*]: https://lore.kernel.org/git/CAPig+cQSsMfvHJnwuXGQ1Je8ekz=3DRqbaibn-3sh=
bya5y-5xTKg@mail.gmail.com/

> diff --git a/pack-write.c b/pack-write.c
> @@ -621,3 +622,63 @@ void write_promisor_file(const char *promisor_name, =
struct ref **sought, int nr_
> +void copy_all_promisor_files(struct repository *repo, const char *promis=
or_name)
> +{
> +       struct strset dest_content =3D STRSET_INIT;
> +       struct strbuf read_line =3D STRBUF_INIT;
> +       struct strbuf promisor_source_name =3D STRBUF_INIT;
> +       struct strbuf write_dest =3D STRBUF_INIT;
> +       FILE *dest, *source;
> +       struct packed_git *p;
> +       int err;

Nit: I probably would have declared `FILE *dest` within the scope of
the repo_for_each_pack() loop as suggested in the review, but it's not
worth a reroll.

> +       dest =3D xfopen(promisor_name, "r+");
> +       while (strbuf_getline(&read_line, dest) !=3D EOF)
> +               strset_add(&dest_content, read_line.buf);
> +
> +       repo_for_each_pack(repo, p) {
> +               if (!p->pack_promisor)
> +                       continue;
> +
> +               strbuf_reset(&promisor_source_name);
> +               strbuf_addstr(&promisor_source_name, p->pack_name);
> +               strbuf_strip_suffix(&promisor_source_name, ".pack");
> +               strbuf_addstr(&promisor_source_name, ".promisor");
> +               source =3D xfopen(promisor_source_name.buf, "r");
> +
> +               /*
> +                * For each line of the promisor source file, check if it=
 already
> +                * is in the promisor dest file. If not, add it to write_=
dest, so
> +                * that it will be written in the dest file.
> +                */
> +               while (strbuf_getline(&read_line, source) !=3D EOF) {
> +                       if (strset_add(&dest_content, read_line.buf)) {
> +                               strbuf_addbuf(&write_dest, &read_line);
> +                               strbuf_addstr(&write_dest, "\n");

Not worth a reroll, but this could also be:

    strbuf_addch(&write_dest, '\n');

> +                       }
> +               }
> +
> +               err =3D ferror(source);
> +               err |=3D fclose(source);
> +               if (err)
> +                       die(_("could not read '%s' promisor file"), promi=
sor_source_name.buf);
> +       }
> +
> +       if (write_dest.len) {
> +               strbuf_strip_suffix(&write_dest, "\n");
> +               if (fseek(dest, 0L, SEEK_END))
> +                       die_errno(_("fseek failed"));
> +               fprintf(dest, "%s\n", write_dest.buf);
> +       }

Can you explain why you strip "\n" and then re-add it via fprintf()?
The reason is not immediately obvious.

> +       err =3D ferror(dest);
> +       err |=3D fclose(dest);
> +       if (err)
> +               die(_("could not write '%s' promisor file"), promisor_nam=
e);
> +
> +       strbuf_release(&read_line);
> +       strbuf_release(&promisor_source_name);
> +       strbuf_release(&write_dest);
> +       strset_clear(&dest_content);
> +}

Everything appears to be released. Good.
