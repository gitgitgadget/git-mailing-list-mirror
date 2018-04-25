Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C25F61F424
	for <e@80x24.org>; Wed, 25 Apr 2018 18:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756218AbeDYSQK (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 14:16:10 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:36059 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756119AbeDYSQF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 14:16:05 -0400
Received: by mail-qt0-f193.google.com with SMTP id q13-v6so28025169qtl.3
        for <git@vger.kernel.org>; Wed, 25 Apr 2018 11:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=X4hDYi+n8+TD38gVWdDKZTzTekHrOLgJ5+Bmwg1t3nI=;
        b=a/FiRuucelB42lx6PO2vgwyGss1p3/cwvkbYd+kzBNvRBl6gYeOAK7nsIikPBVX2xP
         +lYyjXqfACBd/Q4p/5HLn+hN02zBYHNielp1zQWqRa8j5XQYjK1yi13WBLVlnE1TrPVQ
         aa2YDc11Pn7RZsGhnB6vjsLKKyWBlfI+LCLe0ZjxZ5N0SYaSDGt1Etl/tsGrFnTf8G5P
         Tw/9tPahw3502U4MbdkzmLOtzqBrlRr2nWxRWJZAjoIesLRk7O8bOJJdsWxO+G+D87/P
         pQ6Hdl36v1iaF9JrEDFgowYNfBCFq6AcTeB1bFxzq3usaViyYk2c6lnKaacUU6k6P4sR
         HmKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=X4hDYi+n8+TD38gVWdDKZTzTekHrOLgJ5+Bmwg1t3nI=;
        b=rUwzwQGA4/SA8twCWFB7xfdCl8yE4zcV4OWELmk77Za7uD68TJkln9+zB1peTq0YG6
         1Q72s5ERxwBOiGDgYt2xpna2t3UPy8Rx/w1YwXZndcgXuELmlZngZg8oZ91RpB5wjn6R
         XtPgLkMHaUMdx5lXD/tYL9+he35RNB+ctc2A2plxeG32Ks0dq39dtcIzIvr1OE0id887
         OAA36kHju2wO+45Y7zVaky7jGlJJdow1aWWJMR34dtqiwfMvxCz85JpP8H7617JSmb/4
         6Z58hHN52oVOvQEXhkygqsnELY8D299voQ3YxbR/wfW3/GzaUgg6DltmwJxuT5AwmAak
         QSMg==
X-Gm-Message-State: ALQs6tA6n3Htb5LKE/PJqGGiJM+IgQ/MTwCO7JCEtrjeJa4ZC3ZmTJB+
        ZQ0aJHxqb/l3ZSwzuV0TE3PL/2NfT0MZLtceMX8=
X-Google-Smtp-Source: AB8JxZo2ckCzBfjGV02p5Og1FWN/cVtmyQCDYOGb+SCAWwyfi9vXVwj8Lblew6iZg1dEeJXVV2QevkIpXCB56Mrh/FQ=
X-Received: by 2002:ac8:3267:: with SMTP id y36-v6mr33061824qta.25.1524680164795;
 Wed, 25 Apr 2018 11:16:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.170.75 with HTTP; Wed, 25 Apr 2018 11:16:04 -0700 (PDT)
In-Reply-To: <20180425163107.10399-9-pclouds@gmail.com>
References: <20180421165414.30051-1-pclouds@gmail.com> <20180425163107.10399-1-pclouds@gmail.com>
 <20180425163107.10399-9-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 25 Apr 2018 14:16:04 -0400
X-Google-Sender-Auth: PCtoxuV56dCOibytm0xBSX18mJY
Message-ID: <CAPig+cT2FJodBeVO8RO9CqSAFvmcMQbEwyTEsxPBYovA6ivXGQ@mail.gmail.com>
Subject: Re: [PATCH v4/wip 08/12] git: support --list-cmds=<category>
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 25, 2018 at 12:31 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy
<pclouds@gmail.com> wrote:
> This allows us to select any group of commands by a category defined
> in command-list.txt. This is an internal/hidden option so we don't
> have to be picky about the category name or worried about exposing too
> much.
>
> This will be used later by git-completion.bash to retrieve certain
> command groups.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
> diff --git a/help.c b/help.c
> @@ -305,6 +305,25 @@ void list_all_cmds(void)
> +void list_cmds_by_category(const char *cat)
> +{
> +       int i;
> +       int cat_id =3D 0;

Should 'cat_id' be unsigned...

> +
> +       for (i =3D 0; category_names[i]; i++) {
> +               if (!strcmp(cat, category_names[i])) {
> +                       cat_id =3D 1 << i;

...since you're shifting it here?

> +                       break;
> +               }
> +       }
> +       if (!cat_id)
> +               die("unsupported command listing type '%s'", cat);
> +
> +       for (i =3D 0; command_list[i].name; i++)
> +               if (command_list[i].category & cat_id)
> +                       puts(command_list[i].name);
> +}
