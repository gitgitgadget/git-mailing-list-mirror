Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A83E1F597
	for <e@80x24.org>; Mon, 30 Jul 2018 17:50:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbeG3T0s (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 15:26:48 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40822 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727019AbeG3T0s (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 15:26:48 -0400
Received: by mail-wm0-f66.google.com with SMTP id y9-v6so279428wma.5
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 10:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=F/oBxgqhGlp6wFP6NnaNZizs36re2qpJEwTL4/r00Vs=;
        b=QxdcAyaL5ea25aF5ApDTXkguPObI88CmqT36dRMg77gm9sW2zzED2JiHIdJ3roRU2D
         Ur7Jh1DT4qFKEB3L5zXpqMEPYdjZ1OG2h/HVTR56BJcMUCgy5EFdsqX2X2f8pop+ODJR
         wxjuege5Zu0ymMgIenP7/P9KufOY1nYjm8q8a7y3d/VhPUPBGVnv51V9ViSnZ7KIJqK+
         GTqjz0LHlVWH6GZl8gpz713IUDrU/OxJfwGYyjuZ+w10d9gZOwrZftD+XkgNQkK9jdKT
         056+2S+CcehMiHSZhZTL6WvkpzR8v0rp/trW1ki4tZoNN4B50D0ZBBWhlZKZy7E4/DlT
         KgMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=F/oBxgqhGlp6wFP6NnaNZizs36re2qpJEwTL4/r00Vs=;
        b=LreN7/8z/+fhSEQaaQqcmCw6zGeP8cSRKyg5lgcZSBrypdF8yfH+qX8HjRT4LarV9L
         hRAP/h3dlYYBVdx/cw0d+UR5qF49fanViXYOiqSRyL4AxToGHtJsrSoheJJ/COKlJ5Uq
         vR5r5e90FS+ci378FO0GtGurCqwI3C+5Cqt9BA3i36PJy0PvR0sxd6dvU1TwbUY/ZcQC
         qdDTZnx5O0gbVAamUlU0eypzTG0OvMNK4Ep+a+S6MbkAF/f1ohRs2XNOHiYYbmYQbIYL
         N4ssAP6RUbBAIYjIiaM1cSX8LjGYdrMlsUzMSdb6E+HIQDMRQJCDT0CpavqlmzdLdtHd
         Sh+w==
X-Gm-Message-State: AOUpUlEt4snAZMfonxyRFT+5dJnTV5jldQfdxno1KkA1p1JA+qCyzDuU
        MXDmdjbOpgFiOJ5lpt6QwjE=
X-Google-Smtp-Source: AAOMgpcQtV0Vg4y2TZ6q4MgBPY8L/ckH8rWgreoh/ECWMW6AOAmC2IleelP5N8lTlPTlSIJV6aBwcg==
X-Received: by 2002:a1c:b756:: with SMTP id h83-v6mr217132wmf.8.1532973041175;
        Mon, 30 Jul 2018 10:50:41 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id t69-v6sm98037wmt.40.2018.07.30.10.50.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 10:50:40 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 05/11] rerere: add documentation for conflict normalization
References: <20180605215219.28783-1-t.gummerer@gmail.com>
        <20180714214443.7184-1-t.gummerer@gmail.com>
        <20180714214443.7184-6-t.gummerer@gmail.com>
Date:   Mon, 30 Jul 2018 10:50:40 -0700
Message-ID: <xmqqin4whatr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> +Different conflict styles and branch names are normalized by stripping
> +the labels from the conflict markers, and removing extraneous
> +information from the `diff3` conflict style. Branches that are merged

s/extraneous information/commmon ancestor version/ perhaps, to be
fact-based without passing value judgment?

We drop the common ancestor version only because we cannot normalize
from `merge` style to `diff3` style by adding one, and not because
it is extraneous.  It does help humans understand the conflict a lot
better to have that section.

> +By extension, this means that rerere should recognize that the above
> +conflicts are the same.  To do this, the labels on the conflict
> +markers are stripped, and the diff3 output is removed.  The above

s/diff3 output/common ancestor version/, as "diff3 output" would
mean the whole thing between <<< and >>> to readers.

> diff --git a/rerere.c b/rerere.c
> index be98c0afcb..da1ab54027 100644
> --- a/rerere.c
> +++ b/rerere.c
> @@ -394,10 +394,6 @@ static int is_cmarker(char *buf, int marker_char, int marker_size)
>   * and NUL concatenated together.
>   *
>   * Return the number of conflict hunks found.
> - *
> - * NEEDSWORK: the logic and theory of operation behind this conflict
> - * normalization may deserve to be documented somewhere, perhaps in
> - * Documentation/technical/rerere.txt.
>   */
>  static int handle_path(unsigned char *sha1, struct rerere_io *io, int marker_size)
>  {

Thanks for finally removing this age-old NEEDSWORK comment.
