Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E4061F453
	for <e@80x24.org>; Sun, 27 Jan 2019 00:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbfA0AZv (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Jan 2019 19:25:51 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:35059 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbfA0AZv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Jan 2019 19:25:51 -0500
Received: by mail-it1-f194.google.com with SMTP id p197so14754960itp.0
        for <git@vger.kernel.org>; Sat, 26 Jan 2019 16:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rZDCypN1wH/BcHLtB8uMwrth9AYQ0TB4iJOQebBsoN0=;
        b=cqdU7mNmP6m6Q1vz2YawY0Zr4QvvW3I78NFE4FYyZYMsaZJmnM9Sd4TR9RcJ+YSgjB
         hE7ifq0PXBQJRb4jn1Xtq9FwnRGYQ4BXf9IPbXOWJmTCbK/EMToEgs/e/OfL1VZ8up5S
         3U+OHOuVgXm+0o0tgg4RFStirdMfrTn6//m6uhj7zl+jMq5GF2dYALQZPBLUdZ/wTYr/
         rJN+I4Il1zfmB44P+ztx6WMcz2eQ8n2DF/vBio0m2455kgAdFiNbj8sRcdb5xKXpsPpn
         HfFxQ4WBtDLHWjQWNwj+tNAke6gmqhZuDfIcUcKRkq0DEcR1T3LNFgyII8zeTszLAf1X
         70rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rZDCypN1wH/BcHLtB8uMwrth9AYQ0TB4iJOQebBsoN0=;
        b=mAn9p7UZYPq+usxTVu2672IuQwq8rOLczIGdYQHPwH1k1T+xzFaj5swQpI8/nKS0d1
         yqiGFGL15JRue2V/X4O8mGUwytUNZxXpAmxslxn/rxfB4o/qJJsFQvEHKyVUVxwPG6vo
         DoICi1mujcwpf+s3yeG6uls5JB5FlX2Y2gFUwoAVNVy212SgIBtYF11dHo1rWToaIPho
         HwvJMMXsqYEX5Oe/Wcd8oBIfJD0Q4oBvWknLiE3890U52424SVmZW+7/JdlhqUrH5mu6
         7Hus+YIssbjnPN7ADkuxAz5IXjqaFRGvNMbCL9FKjrW1XIWCpWbzV9UQXWH1UqI7A8vI
         Merw==
X-Gm-Message-State: AJcUukfYpOZ8OPk/x/Z2Cl7Jr9rh3wI/fK63zpKuzlvUEQvPa9+Alm9J
        F4b2BcfNAeeyuXjCFLX30Kl1Y4/NuHfoTVi39YsDOw==
X-Google-Smtp-Source: ALg8bN5rPpmll5pDg4Bnen4pYiA4QhKE2ZU6+xl+b1BwZMzxEF8wAzBDgTZ7R0rzgsUyK54VNxzkHO09ITGLRgil7OE=
X-Received: by 2002:a05:660c:81a:: with SMTP id j26mr7445546itk.70.1548548750806;
 Sat, 26 Jan 2019 16:25:50 -0800 (PST)
MIME-Version: 1.0
References: <20190126204951.42455-1-koraktor@gmail.com> <20190126204951.42455-3-koraktor@gmail.com>
In-Reply-To: <20190126204951.42455-3-koraktor@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 27 Jan 2019 07:25:23 +0700
Message-ID: <CACsJy8C27hKNTyGE5P+F6nzszN_z85chEq8MvQ+BgiDAi=4jww@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] Add test for describe with a bare repository
To:     Sebastian Staudt <koraktor@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 27, 2019 at 3:51 AM Sebastian Staudt <koraktor@gmail.com> wrote:
>
> This ensures that nothing breaks the basic functionality of describe for
> bare repositories. Please note that --broken and --dirty need a working
> tree.
>
> Signed-off-by: Sebastian Staudt <koraktor@gmail.com>
> ---
>  t/t6120-describe.sh | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
> index 9a6bd1541f..ddd8cc307d 100755
> --- a/t/t6120-describe.sh
> +++ b/t/t6120-describe.sh
> @@ -409,4 +409,11 @@ test_expect_success 'describe complains about missing object' '
>         test_must_fail git describe $ZERO_OID
>  '
>
> +test_expect_success 'describe works from outside repo using --git-dir' "
> +  BARE_CLONE=$(mktemp -d) &&

No, keep everything in $TRASH_DIRECTORY so it will be automatically cleaned.

> +  git clone --bare '$TRASH_DIRECTORY' \$BARE_CLONE >/Users/koraktor/open-source/others/git/t/out &&

Ehh.. I'm pretty sure I don't have /Users/koraktor on my system :)
This looks like just debug code, I think you can drop ">.." part for
all commands.

> +  echo $PWD >/Users/koraktor/open-source/others/git/t/out &&
> +  git --git-dir \$BARE_CLONE describe 2>&1 >/Users/koraktor/open-source/others/git/t/out
> +"
> +
>  test_done
> --
> 2.20.1
>


-- 
Duy
