Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A98C21F954
	for <e@80x24.org>; Mon, 20 Aug 2018 12:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbeHTPg7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Aug 2018 11:36:59 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:36823 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbeHTPg6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Aug 2018 11:36:58 -0400
Received: by mail-io0-f195.google.com with SMTP id m4-v6so12401338iop.3
        for <git@vger.kernel.org>; Mon, 20 Aug 2018 05:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aXia1T3/0NDmbWiL6tRtbvm9VVARJDDma4EMcN4WfNw=;
        b=MZIUEmRoay2zoNE8INSBmrmfllz315Ply8IKy0CS+tlAqTSJziz0/j/8PaLtUmTaE2
         hFdFGoAlsOZtqyPNyis+x/2t6LFy6gidT496oPO6zGx+2HmaZ5Lx8iQUGTFP5reK67xs
         fk60PuhOGKYqT7zF3mIHx1HyBjst2C5Mx6ra7GyxSvEwaOjBQXtjqWQ58fzutvPbDQWI
         TIKHSPWKr/5ZANXT8971iHBoVubV6EeRIhVNLukc/7atauTnNeEOg068IOk1ifZ5EtXA
         VtR9DfNDQWW17+8excuHjV5MjAQm77bfRqtwLE+4y1L+wZ42wSZk57OZTUKJ5wWz6qOb
         Zr5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aXia1T3/0NDmbWiL6tRtbvm9VVARJDDma4EMcN4WfNw=;
        b=hf6BAX5Q8lTYAhE+gT8jiDvaeU8eP/fIQrYxptzXEWLQN+2sf8iGWtz+Cl3RH5PT8+
         KC4s0pfPByg7OJYzWnxmClvy8Ju7RyWfOEcgWe8NK4unmRB41ePuXHVXYduLjZIlwrLv
         JETrGz6EnfgWNeNwRD4O0TpmqukQBeImnJxmDSHTtjFNmGWrbK5ZT2vwYCgUTeDecJjv
         MWXMbkZkhgk3K92+pDaloEKnEAPJ39qRgW8hp4hP7/us9m/aBHKIsySjnShtWb8aPRlF
         qMllOtae6KNP03fxClWMakMzGZupyQOLA5TQvKKkm+/jM8LjD8F1/IB6Bg3LujrdPamg
         Vx1w==
X-Gm-Message-State: APzg51DT6P91UsP5W4lSoImW0r5gF2z1XAse8kqbVigRihFfUvOchM+g
        JW64UOogZgPJdZ1ynztljW2MTiELZocUjhzk+2n5QA==
X-Google-Smtp-Source: ANB0VdaUhNN6YNHJyL8POOB2AOA2bqESG010qCY7cm0KS5MZTQs8P9zKqPArVzXlV7JgTA4iCrBo9j057tvmo7H0dfU=
X-Received: by 2002:a6b:5f12:: with SMTP id t18-v6mr4403857iob.62.1534767692991;
 Mon, 20 Aug 2018 05:21:32 -0700 (PDT)
MIME-Version: 1.0
References: <20180807125108.104293-1-hanwen@google.com> <20180807125108.104293-2-hanwen@google.com>
 <xmqqd0ugc07x.fsf@gitster-ct.c.googlers.com> <xmqq8t54bzo4.fsf_-_@gitster-ct.c.googlers.com>
 <20180818060911.GC241538@aiede.svl.corp.google.com> <xmqqmutjagc7.fsf@gitster-ct.c.googlers.com>
 <xmqqin47acir.fsf@gitster-ct.c.googlers.com> <xmqqa7pjabvn.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqa7pjabvn.fsf@gitster-ct.c.googlers.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 20 Aug 2018 14:21:21 +0200
Message-ID: <CAFQ2z_NEBeiHWeC8BLKeBhTq_zA2iN2cTrENfPTdfykyM5uduQ@mail.gmail.com>
Subject: Re: Re* [PATCH v7 1/1] sideband: highlight keywords in remote
 sideband output
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 18, 2018 at 6:16 PM Junio C Hamano <gitster@pobox.com> wrote:
> > Actually, let's just lose the conditional.  strbuf_add() would catch
> > and issue an error message when it notices that we fed negative
> > count anyway ;-).
>
> So I'll have this applied on top of the original topic to prevent a
> buggy version from escaping the lab.
>
> -- >8 --
> Subject: [PATCH] sideband: do not read beyond the end of input
>
> The caller of maybe_colorize_sideband() gives a counted buffer
> <src, n>, but the callee checked src[] as if it were a NUL terminated
> buffer.  If src[] had all isspace() bytes in it, we would have made
> n negative, and then
>
>  (1) made number of strncasecmp() calls to see if the remaining
>      bytes in src[] matched keywords, reading beyond the end of the
>      array (this actually happens even if n does not go negative),
>      and/or
>
>  (2) called strbuf_add() with negative count, most likely triggering
>      the "you want to use way too much memory" error due to unsigned
>      integer overflow.
>
> Fix both issues by making sure we do not go beyond &src[n].
>
> In the longer term we may want to accept size_t as parameter for
> clarity (even though we know that a sideband message we are painting
> typically would fit on a line on a terminal and int is sufficient).
> Write it down as a NEEDSWORK comment.
>
> Helped-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  sideband.c                          |  8 ++++++--
>  t/t5409-colorize-remote-messages.sh | 14 ++++++++++++++
>  2 files changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/sideband.c b/sideband.c
> index 1c6bb0e25b..368647acf8 100644
> --- a/sideband.c
> +++ b/sideband.c
> @@ -65,6 +65,8 @@ void list_config_color_sideband_slots(struct string_lis=
t *list, const char *pref
>   * Optionally highlight one keyword in remote output if it appears at th=
e start
>   * of the line. This should be called for a single line only, which is
>   * passed as the first N characters of the SRC array.
> + *
> + * NEEDSWORK: use "size_t n" instead for clarity.
>   */
>  static void maybe_colorize_sideband(struct strbuf *dest, const char *src=
, int n)
>  {
> @@ -75,7 +77,7 @@ static void maybe_colorize_sideband(struct strbuf *dest=
, const char *src, int n)
>                 return;
>         }
>
> -       while (isspace(*src)) {
> +       while (0 < n && isspace(*src)) {
>                 strbuf_addch(dest, *src);
>                 src++;
>                 n--;
> @@ -84,6 +86,9 @@ static void maybe_colorize_sideband(struct strbuf *dest=
, const char *src, int n)
>         for (i =3D 0; i < ARRAY_SIZE(keywords); i++) {
>                 struct keyword_entry *p =3D keywords + i;
>                 int len =3D strlen(p->keyword);
> +
> +               if (n <=3D len)
> +                       continue;

I would suggest

 if (n < len) continue;
..
if (!strncasecmp(p->keyword, src, len) && (n =3D=3D len || !isalnum(src[len=
]))) {

so we colorize a single line that looks like "warning" as well


Other than that, LGTM.

--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
