Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0E9D1F403
	for <e@80x24.org>; Thu,  7 Jun 2018 07:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753174AbeFGHoa (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 03:44:30 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:33876 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752631AbeFGHo3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 03:44:29 -0400
Received: by mail-vk0-f67.google.com with SMTP id q135-v6so5456625vkh.1
        for <git@vger.kernel.org>; Thu, 07 Jun 2018 00:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=awwPFstS/1ZwrzXF1sM2xuOWnl89POzclhN14zARJfA=;
        b=DQuacJEbWFnvOOa6e6LaoSQC5Sh9o6MfBcPVnFC4lpkmoZqja3rn4wcSxeA5wyvE+J
         tnAXX+hXjc2pG+E3M6TvF6CHJf7eJjLV/VKtDngW8V7DGWoIfz7mykt6mN8D/y9CLp2Y
         0HE5FvKws7t2BDe35f1TR3XEpZzZ3bpdWmte5lLD+5zPlueR4SmHW4ybNUM1qwP/hQZk
         Ww9EKDPeNJf4/TiC8XVOgb2XJ4cLuUm+LexUnpdXwOCPSOCWT9V1HI8tAZ+T3fJdOdTE
         6ulY9SfZ4kX+WzKRC0Z+Ldi2FL+cv6YPBbnX6igLPObXUsSLuwC+LxvIrbH5wmT7Ia9n
         koIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=awwPFstS/1ZwrzXF1sM2xuOWnl89POzclhN14zARJfA=;
        b=BqyHS4loRHLWcrpDFj7IIA+2tKeChOUtwDUSzo5RMCCjXq/et33Kc0o3be9mYxTTxR
         pqwBHV04IaJTFSV28sEt7Zq5HKjhmS25D0Nto1Qs9qN3lPnpjK9RqRPK28aNSRBWzwzT
         Pslz8N+mkK8g8THvv9YQckpBTmZUJssCZz0dCv9OR4xWTIqqbt/xJi9S5P0OoJhWVdxO
         0PAikE+KlQ+7LHKBj2IbmauAjqvOdsNNwEKaG70Db82uIZk7+wsL/fC2S80ENpHJ09pe
         b3FiSXTFM+iObyXo3WjnN3GQWL27+pEwiWwlu+tGc8CtkSJIq/jbNsoagZyeW0XW2cyC
         sWAA==
X-Gm-Message-State: APt69E0u5TId6nH99OtqaoSvL6V456WhOBcV6qht2bE0Y2lpoQ17CseH
        Elw3+xAn9VIASvKUhYCzeTav2qek7BViwhzIhWE=
X-Google-Smtp-Source: ADUXVKLIBoSNl/4DzRU2ckup5+stNoMKt0kQK5ooXVFDUMarV2f6rOOvXmYmKZ6YgS6oip/Qe95Noz074eLjUMRnLEo=
X-Received: by 2002:a1f:4083:: with SMTP id n125-v6mr450165vka.76.1528357468298;
 Thu, 07 Jun 2018 00:44:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:5f28:0:0:0:0:0 with HTTP; Thu, 7 Jun 2018 00:44:27 -0700 (PDT)
In-Reply-To: <20180606165016.3285-1-pclouds@gmail.com>
References: <20180606073933.14755-1-pclouds@gmail.com> <20180606165016.3285-1-pclouds@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 7 Jun 2018 00:44:27 -0700
Message-ID: <CABPp-BEngspJMEpwoiTq7SCdsQt7fOT_uePS3c6nRxTVqOnNeQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/23] Fix incorrect use of the_index
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 6, 2018 at 9:49 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <=
pclouds@gmail.com> wrote:
> v4 fixes some commit messages and killed a couple more the_index
> references after I tried to merge this with 'pu'

Thanks for tackling this.  The first 8 patches look good to me other
than the typo I pointed out on patch 4.  However, my eyes glazed over
a bit on the attr.c stuff in patch 7 that you specifically mentioned
in the commit message, so my "looks good" doesn't count for as much on
that one.

I'm getting sleepy, but I'll try to circle back and look over the rest
of the patches in the next few days.
