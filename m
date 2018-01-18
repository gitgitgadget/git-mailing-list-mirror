Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B0331FADF
	for <e@80x24.org>; Thu, 18 Jan 2018 18:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932691AbeARS5S (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 13:57:18 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:38751 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932089AbeARS5R (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 13:57:17 -0500
Received: by mail-qt0-f193.google.com with SMTP id z10so4710383qti.5
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 10:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=iQYZjO2lAoe0qI4KyglwxDbOY5Xo3cZcwFfseD5k574=;
        b=mm0UJvFkGwdo8fXnHqPeoILAH2M9peMU0UEry4hf3pTmTPETKskfqCyK+s57E8IHEM
         hVJHid3SqxyvEh1DcKhNQkjao9n46YM9/7IBooUT/DqxtgqsBrN854vtslCbeziDzrge
         +gIVXDdXDSBE4D4itZ4E4sBF0vLz9SQToSx9/J/AKm2DUFDNI9Sg+6o/7uS0dysfUjM8
         qN0AStQ6UnxWxxB+T3zjoRqjQaGxD9Q1LcCOtbXGLNYBjsSWrYrIFTwSUuE/j5GXJ57E
         wXYmeCAv8BtoX4gmAQrnc+ADsIoqRCpglR4kLVtJrx/2ua0RonuwZZluYH/RS2IJ7Su9
         8/kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=iQYZjO2lAoe0qI4KyglwxDbOY5Xo3cZcwFfseD5k574=;
        b=Lj3Ipn3dHmT0umdRhy4zEmVhSKnL+41209DIe0IPw90HSxvWiGh2flDdwOc5evrtym
         fMgS1/91Idl3xKPBvcuFz3oP+Pq21XbpTm0vSp/uWfbKVAoG2OjYiiOPOOfBf4up0zdO
         EcpSAPNUsMGo6LUQ5Npcx0kmzbMPFeKw+S5n/fydlABrBoMWP4TadlR0nDC9UFB293KD
         JfLk5hB9S3FLaFI5C7MT1hTUMDBbkw0w+WpjqU9ps/t6VOzznhUSPMQHGMs8lA8/Lp3b
         TytK78bEreDQN1nsCbELWYZRdh6eBP61npzIn3jxOsn0vNQdg8YUdmn3n3jnLyxQced3
         pF6Q==
X-Gm-Message-State: AKwxyterSfOCDhgR3wUVsCgdKr5ZRSDOy8zcGOsBQ3mrmjRDzJRfK4JQ
        DqmzzUrf+frUKmwyVYdUGnDk7fdrYrElIJoalIAjBQ==
X-Google-Smtp-Source: ACJfBov9uPINY8uZk24aqAoXlVUJ5eHvWqPD+Y29x7eijMQQYx7XjNh6YHonHJLwD+vZCEqSX8vmRZUkS66yRVw7c+U=
X-Received: by 10.55.104.17 with SMTP id d17mr22177420qkc.306.1516301836882;
 Thu, 18 Jan 2018 10:57:16 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.137.143 with HTTP; Thu, 18 Jan 2018 10:57:16 -0800 (PST)
In-Reply-To: <20180118100546.32251-1-pclouds@gmail.com>
References: <20180113132211.13350-1-pclouds@gmail.com> <20180118100546.32251-1-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 18 Jan 2018 13:57:16 -0500
X-Google-Sender-Auth: VRi-0o9Z25V04MFLjLY4V2P09hc
Message-ID: <CAPig+cQLgs59JYxcmK30qY307ArwqJx6pNOo95Z39_jJ9+D6+g@mail.gmail.com>
Subject: Re: [PATCH v2] diff: add --compact-summary option to complement --stat
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 18, 2018 at 5:05 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> [...]
> The new option --compact-summary implements this with a tweak to support
> mode change, which is shown in --summary too.
>
> For mode changes, executable bit is denoted as "M+x" or "M-x" when it's
> added or removed respectively. The same for when a regular file is
> replaced with a symlink "M+l" or the other way "M-l". This also applies
> to new files. New regulare files are "A", while new executable files or

s/regulare/regular/

> symlinks are "A+x" or "A+l".
> [...]
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.=
txt
> @@ -188,6 +188,17 @@ and accumulating child directory counts in the paren=
t directories:
> +--compact-summary::
> +       Output a condensed summary of extended header information in
> +       front of the file name part of diffstat. This option is
> +       ignored if --stat is not specified.

Rather than ignoring this option if --stat is not specified, a
different approach would be for --compact-summary to imply --stat.

Also, per documentation:

    --stat[=3D<width>[,<name-width>[,<count>]]]::

    These parameters can also be set individually with `--stat-width=3D<wid=
th>`,
    `--stat-name-width=3D<name-width>` and `--stat-count=3D<count>`.

One wonders if "compact" could be another modifier recognized by --stat.

(Genuine questions/observations; I haven't formed strong opinions either wa=
y.)

> diff --git a/diff.c b/diff.c
> @@ -2287,6 +2289,18 @@ static void show_stats(struct diffstat_t *data, st=
ruct diff_options *options)
> +       for (i =3D 0; (i < count) && (i < data->nr); i++) {

Noisy extra parentheses...

    for (i =3D 0; i < count && i < data->nr; i++) {

perhaps? (Not at all worth a re-roll.)

> +               const struct diffstat_file *file =3D data->files[i];
> +               int len;
> +
> +               if (!file->status_code)
> +                       continue;
> +               len =3D strlen(file->status_code) + 1;

The +1 is for the space following the status code? (Reading ahead,
that seems to be the case.)

    len =3D strlen(file->status_code) + strlen(" ");

perhaps? (Probably not worth a re-roll.)

> +               if (len > max_status_len)
> +                       max_status_len =3D len;
> +       }
> +
> @@ -2383,6 +2397,8 @@ static void show_stats(struct diffstat_t *data, str=
uct diff_options *options)
>                       options->stat_name_width < max_len) ?
>                 options->stat_name_width : max_len;
>
> +       name_width +=3D max_status_len;

I wonder if it would be clearer to account for the space after the the
status code here rather than above when it was not obvious what +1 was
for.

    name_width +=3D max_status_len + strlen(" ");

(and drop the earlier +1)
