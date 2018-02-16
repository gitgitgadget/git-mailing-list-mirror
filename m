Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 115721F404
	for <e@80x24.org>; Fri, 16 Feb 2018 01:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757049AbeBPBO2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 20:14:28 -0500
Received: from mail-ua0-f194.google.com ([209.85.217.194]:45541 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753066AbeBPBO1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 20:14:27 -0500
Received: by mail-ua0-f194.google.com with SMTP id z3so1018874uae.12
        for <git@vger.kernel.org>; Thu, 15 Feb 2018 17:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=E0nhnBjGLhiUf4mK3w8oKCeKKQNPpgY57+RRqqHslfk=;
        b=NlZoX/Jss3v0A9349y0EAIT6Piaf+ptBTNujU0dJ/zjy39wbLkYIrt2pz1JebZU7lL
         qImWev0myS7jJRwrANNM1Y0Sd67yTRF5idN6+THs0b91axwcLgs1mhfuHB7jmPEvlqpb
         RMaW9gezLjPGQJCDY/SkBfDFjEPsE7oQfEuWrm8wYv4dF2oFe/PilSgCsbmlrIoSoScB
         hTADYGn3HG66P3Kk+FHrfQbQKuJk20Sr8fNJAXhvy4uOV51mCutrnldomt4VyU/fbjB6
         EqdyDf45LSnjAfgB7hkY8ukObbUIl9c/1e1+xH9wWXn98EoqHKFsf8V9Ak5jpOo+yhV4
         CfXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=E0nhnBjGLhiUf4mK3w8oKCeKKQNPpgY57+RRqqHslfk=;
        b=aoJ889wIRywqX7PmL3eCiL8YU0F0C9O5ru3AO3pTNhRp672CjIoKow/6mt7Lpg0V1X
         QTagZQkfS1QE3wVYjracP8daZmphVQEG/N7/hotFrnjJcUiFD0UGYHf/RFko53qi8dzE
         gs7bzkJCYCn4ox1R7fchrE5QM2C8mGnusc8N+PDEGw1EvV7Wd1NA25dxxDEPZIcOHIaO
         sMKv1f/2z5uJZCfIDBwocUKlma0Bn/zOnWF9GOPimQUZ5ms4QXnfru5qQ0LVx4SEfCEH
         pdLQ+dL+Z5XhcyD/5UueU6Vp6xBvzRwcei7SX7hKyB1o7AR5KxIvVhXuR7pEaEY8I+CV
         /H+A==
X-Gm-Message-State: APf1xPDMBJtDpxHF7TYAVfogdMYVHIrJjbiUlWYZEr1LnN230Y5zBKnf
        5U3jQU2T7JzuJSeW1DOHeM+bEucKK+fasioAD0Xd6w==
X-Google-Smtp-Source: AH8x2264J7BIvfH94m1gJS/Jao84Yl+uB/uLZftimrBqbG2DCLb1CjzNvfPO9nfmhTGDb9MScR7F66LJFi0NM+p0KEQ=
X-Received: by 10.176.68.35 with SMTP id m32mr3680756uam.39.1518743666989;
 Thu, 15 Feb 2018 17:14:26 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.32.12 with HTTP; Thu, 15 Feb 2018 17:14:26 -0800 (PST)
In-Reply-To: <20180130232533.25846-26-newren@gmail.com>
References: <20180130232533.25846-1-newren@gmail.com> <20180130232533.25846-26-newren@gmail.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Fri, 16 Feb 2018 02:14:26 +0100
Message-ID: <CAM0VKjkqOe_pU78cRqgaqEoiZP6PENUvq6-RnDWEKCKsB1rQXA@mail.gmail.com>
Subject: Re: [PATCH v7 25/31] merge-recursive: apply necessary modifications
 for directory renames
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 31, 2018 at 12:25 AM, Elijah Newren <newren@gmail.com> wrote:
> This commit hooks together all the directory rename logic by making the
> necessary changes to the rename struct, it's dst_entry, and the
> diff_filepair under consideration.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  merge-recursive.c                   | 187 +++++++++++++++++++++++++++++++++++-
>  t/t6043-merge-rename-directories.sh |  50 +++++-----
>  2 files changed, 211 insertions(+), 26 deletions(-)
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index 38dc0eefaf..7c78dc2dc1 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c

> @@ -641,6 +643,27 @@ static int update_stages(struct merge_options *opt, const char *path,
>         return 0;
>  }
>
> +static int update_stages_for_stage_data(struct merge_options *opt,
> +                                       const char *path,
> +                                       const struct stage_data *stage_data)
> +{
> +       struct diff_filespec o, a, b;
> +
> +       o.mode = stage_data->stages[1].mode;
> +       oidcpy(&o.oid, &stage_data->stages[1].oid);
> +
> +       a.mode = stage_data->stages[2].mode;
> +       oidcpy(&a.oid, &stage_data->stages[2].oid);
> +
> +       b.mode = stage_data->stages[3].mode;
> +       oidcpy(&b.oid, &stage_data->stages[3].oid);
> +
> +       return update_stages(opt, path,
> +                            is_null_sha1(o.oid.hash) ? NULL : &o,
> +                            is_null_sha1(a.oid.hash) ? NULL : &a,
> +                            is_null_sha1(b.oid.hash) ? NULL : &b);

Please use is_null_oid(&o.oid) etc. instead of is_null_sha1().
