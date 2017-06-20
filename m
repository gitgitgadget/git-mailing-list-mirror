Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEC3D1FA7B
	for <e@80x24.org>; Tue, 20 Jun 2017 02:50:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751085AbdFTCuh (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 22:50:37 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:36039 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750992AbdFTCuh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 22:50:37 -0400
Received: by mail-pg0-f49.google.com with SMTP id u62so37295439pgb.3
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 19:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8SGpl29X7iHLy89VprCvaYJL8cCgbwRpS28WecbeMTk=;
        b=kPMCCfz0tEm1ntMJvKtb74Yg3Wj3wNDbYP90GxfWeP0i77mM7ly0NT+hLfqnMh3bxw
         gnexf/SYiCW00IIdh6niHgOJeVU2Jti8e9OJvXrGrk/9Knc5PrZILcRAIGjFJ0NYggI2
         nOhz/xsmcBblM8M8/55AIvm586vcyPEBZVsYj6iJgqWMieeMS9O0dkCtBmFw0Hy6xxuO
         PJW5jlLE/qnls3FSxE4sJoKnilPzyBuuQfC7yMbuFGs6YVzKRwwF0v37ikyjGWeWny2/
         E47x9uIlq0AI9vghIsS+pEhEHeBVM9AXjYSb5AYYOLvwqsUYSw3liHGkZmxGZAHYjd57
         Bb1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8SGpl29X7iHLy89VprCvaYJL8cCgbwRpS28WecbeMTk=;
        b=nh2LeweAnhg7QIilDuSWbOK2dGLCV+e1/jR5l60sVl0L6J4OtPWZNOrLND85i5V3Td
         SBX3kFDhy/7sObZymL0bwqUUrJZfRtjpHcLsM/daLM5eT4pdcuky/KcjBrpY1v/n0DWN
         Ls8+WZShEVe5Qn15VgXTtJ48YhVcTvla0PZW62FJHH4d3FxXCQr7ynLepRg5sKybAZKT
         YHG74gXjtXTVMVq/kLwUj1uXauWj8qa5hKVJtfYK/PGBETUpT35jKcK197tO/CzN73qm
         vYmzRst9HrX9fkT4xQrKdE9V6yXBaiWqCiG5fmzecyb23I/D/qJ3YXmP94r4oBfzivft
         ElnQ==
X-Gm-Message-State: AKS2vOxzfjGSLJJZ2vLORL7Kel7WxJpIFDSoVRMmbNm0TmrG6SSrE3P3
        yzxtjCz88ZqpXgkDSYszWIY70x1kJWMQ
X-Received: by 10.84.137.165 with SMTP id 34mr32682571pln.167.1497927036302;
 Mon, 19 Jun 2017 19:50:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.218.134 with HTTP; Mon, 19 Jun 2017 19:50:35 -0700 (PDT)
In-Reply-To: <20170620024816.20021-27-sbeller@google.com>
References: <CAGZ79kaqjQYmkt77kk5m=fdBfbZAvwd0YhhT7=O5b-FkQmDfHg@mail.gmail.com>
 <20170620024816.20021-1-sbeller@google.com> <20170620024816.20021-27-sbeller@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 19 Jun 2017 19:50:35 -0700
Message-ID: <CAGZ79kYLdpaXzn0T5547fRr=EPR691n2bPfS+mzaZuS-k39ayw@mail.gmail.com>
Subject: Re: [showing-off RFC/PATCH 26/26] diff.c: have a "machine parseable"
 move coloring
To:     Stefan Beller <sbeller@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

+ =C3=86var, who was not part of the email where I copied all recipients
from for this series.

On Mon, Jun 19, 2017 at 7:48 PM, Stefan Beller <sbeller@google.com> wrote:
> =C3=86var asked for it, this is how you would do it.
> (plus documentation, tests, CLI knobs, options)
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  diff.c | 15 +++++++++++----
>  diff.h |  2 ++
>  2 files changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index 7756f7610c..61caa057ff 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -997,6 +997,7 @@ static void emit_diff_symbol_from_struct(struct diff_=
options *o,
>         static const char *nneof =3D " No newline at end of file\n";
>         const char *context, *reset, *set, *meta, *fraginfo;
>         struct strbuf sb =3D STRBUF_INIT;
> +       int sign;
>
>         enum diff_symbol s =3D eds->s;
>         const char *line =3D eds->line;
> @@ -1058,8 +1059,11 @@ static void emit_diff_symbol_from_struct(struct di=
ff_options *o,
>                 default:
>                         set =3D diff_get_color_opt(o, DIFF_FILE_NEW);
>                 }
> +               sign =3D '+';
> +               if (flags & DIFF_SYMBOL_MOVED_LINE && o->machine_readable=
_moves)
> +                       sign =3D '*';
>                 reset =3D diff_get_color_opt(o, DIFF_RESET);
> -               emit_line_ws_markup(o, set, reset, line, len, '+',
> +               emit_line_ws_markup(o, set, reset, line, len, sign,
>                                     flags & DIFF_SYMBOL_CONTENT_WS_MASK,
>                                     flags & DIFF_SYMBOL_CONTENT_BLANK_LIN=
E_EOF);
>                 break;
> @@ -1086,8 +1090,11 @@ static void emit_diff_symbol_from_struct(struct di=
ff_options *o,
>                 default:
>                         set =3D diff_get_color_opt(o, DIFF_FILE_OLD);
>                 }
> +               sign =3D '-';
> +               if (flags & DIFF_SYMBOL_MOVED_LINE && o->machine_readable=
_moves)
> +                       sign =3D '_';
>                 reset =3D diff_get_color_opt(o, DIFF_RESET);
> -               emit_line_ws_markup(o, set, reset, line, len, '-',
> +               emit_line_ws_markup(o, set, reset, line, len, sign,
>                                     flags & DIFF_SYMBOL_CONTENT_WS_MASK, =
0);
>                 break;
>         case DIFF_SYMBOL_WORDS_PORCELAIN:
> @@ -5475,7 +5482,7 @@ static void diff_flush_patch_all_file_pairs(struct =
diff_options *o)
>         static struct emitted_diff_symbols esm =3D EMITTED_DIFF_SYMBOLS_I=
NIT;
>         struct diff_queue_struct *q =3D &diff_queued_diff;
>
> -       if (o->color_moved)
> +       if (o->color_moved || o->machine_readable_moves)
>                 o->emitted_symbols =3D &esm;
>
>         for (i =3D 0; i < q->nr; i++) {
> @@ -5485,7 +5492,7 @@ static void diff_flush_patch_all_file_pairs(struct =
diff_options *o)
>         }
>
>         if (o->emitted_symbols) {
> -               if (o->color_moved) {
> +               if (o->color_moved || o->machine_readable_moves) {
>                         struct hashmap add_lines, del_lines;
>                         unsigned ignore_ws =3D DIFF_XDL_TST(o, IGNORE_WHI=
TESPACE);
>
> diff --git a/diff.h b/diff.h
> index 98abd75521..b6c4d7ab0f 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -194,6 +194,8 @@ struct diff_options {
>                 COLOR_MOVED_ZEBRA =3D 2,
>                 COLOR_MOVED_ZEBRA_DIM =3D 3,
>         } color_moved;
> +
> +       int machine_readable_moves;
>  };
>
>  void diff_emit_submodule_del(struct diff_options *o, const char *line);
> --
> 2.12.2.575.gb14f27f917
>
