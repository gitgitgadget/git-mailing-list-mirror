Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D49401F404
	for <e@80x24.org>; Wed,  7 Mar 2018 17:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754471AbeCGRyy (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Mar 2018 12:54:54 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:35067 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751284AbeCGRyw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Mar 2018 12:54:52 -0500
Received: by mail-qk0-f193.google.com with SMTP id s188so3699999qkb.2
        for <git@vger.kernel.org>; Wed, 07 Mar 2018 09:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=g3MpK1xMKzeQOoQdu3eKe9cf8rZwB7iFxe/g19gbN2Y=;
        b=n2dP9OhVff3U63NuxbVGwNZXYlAM188Qe3Ov2gsF9z/pcD8JZqSkN5f2XWW43Kprjp
         SaBPE6Oyv6ZAdeXNbBhtI12XiqHH1n7NTV1oQ3gw6Dj6UVfqAoRFWe+/DyMVrl7gIuWs
         2GLKXD2x2faMftPD8SG3sUELtrjX67VzBXexZ3PE0/qOB1h55qERFBSthZDIFFbTSxxk
         xpCQqYSpbW3+oJLBGkq4zPMQ2eoCgFPHotC+5EsVSMn+ImlLxc92WAcp3v5YAC7emubr
         riR5zrKl/+go6gNRO2mi0Q6pY8PLbAfCN3LNV6X6qWXlyeVzcqFrxDfYCyHfgAUxjYpV
         4pTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=g3MpK1xMKzeQOoQdu3eKe9cf8rZwB7iFxe/g19gbN2Y=;
        b=pwFCCSxN4SOe1gR0tYxbjy8MWEd4+h/rFaE8OQ5D5WaqKIxe7m1kzQk0X0z5DFGtpr
         fL9Z3tWFnqbDUkzhf0jcBzzNCI/+FpGZCnqj+CTbPIhydmWphzvNw/qfRoAK8wH43ZN7
         K8j79H8GnPTiMmej4/sqhSxAxI74FRWa7QD3/BAllE174vOZDYfBl4is+Cp1mG8jUgU6
         gYCn7dTNZvtBM/ojjMqroheoPt5f5GgyIxXwOQEwMNklHFQiS5PsNuuOZBgJs+8uQD2P
         onoeVsawM5ivuWU1VlnyHiRLLC4g/VpnRQ1oZFZbU/8GzHJeY8cJTWGZ+O98irvpiMvV
         1lbg==
X-Gm-Message-State: AElRT7GIzFmk90geU90Gg0caA1UlQ1Ll0XzFf4yVuUma+Lxdr3UpTTUL
        vWIbR5y3Z4wKgAg2j1/eYrHPvo4KbhwUGehmjSE=
X-Google-Smtp-Source: AG47ELtAxw7sQ0yU/9uRw7+C7GHpnmVD7r/FjEsmS9nsFlnCdV9H0ZqUsZW1JAXvRKNdMD0t8O8X0Ofsp9DkHVeHfwA=
X-Received: by 10.55.133.131 with SMTP id h125mr35399073qkd.79.1520445291925;
 Wed, 07 Mar 2018 09:54:51 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.142.14 with HTTP; Wed, 7 Mar 2018 09:54:51 -0800 (PST)
In-Reply-To: <20180307173026.30058-7-lars.schneider@autodesk.com>
References: <20180307173026.30058-1-lars.schneider@autodesk.com> <20180307173026.30058-7-lars.schneider@autodesk.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 7 Mar 2018 12:54:51 -0500
X-Google-Sender-Auth: MAhkcCGMGihOKncBbalT2CXgSf0
Message-ID: <CAPig+cSvC1a5EaDfFZdJU74mZz84M=CkeOJLSDxFdXKcJYyzEw@mail.gmail.com>
Subject: Re: [PATCH v10 6/9] convert: add 'working-tree-encoding' attribute
To:     Lars Schneider <lars.schneider@autodesk.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 7, 2018 at 12:30 PM,  <lars.schneider@autodesk.com> wrote:
> [...]
> Add an attribute to tell Git what encoding the user has defined for a
> given file. If the content is added to the index, then Git converts the
> content to a canonical UTF-8 representation. On checkout Git will
> reverse the conversion.
>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>  Documentation/gitattributes.txt  |  80 +++++++++++++++++++++++
> diff --git a/convert.c b/convert.c
> @@ -265,6 +266,78 @@ static int will_convert_lf_to_crlf(size_t len, struct text_stat *stats,
> +static const char *default_encoding = "UTF-8";
> @@ -978,6 +1051,21 @@ static int ident_to_worktree(const char *path, const char *src, size_t len,
> +static const char *git_path_check_encoding(struct attr_check_item *check)
> +{
> +       const char *value = check->value;
> +
> +       if (ATTR_TRUE(value) || ATTR_FALSE(value) || ATTR_UNSET(value) ||
> +           !strlen(value))
> +               return NULL;
> +
> +       /* Don't encode to the default encoding */
> +       if (!strcasecmp(value, default_encoding))
> +               return NULL;

As of v10, the rest of the code accepts encoding names "UTF-xx" and
"UTFxx" (case insensitive), however, this check recognizes only
"UTF-8" (case insensitive). For consistency, one would expect this
also to recognize "UTF8" (case insensitive).

> +
> +       return value;
> +}
