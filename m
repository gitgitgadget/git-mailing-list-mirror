Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35B561F453
	for <e@80x24.org>; Fri, 19 Oct 2018 17:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbeJTBxl (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 21:53:41 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39910 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727736AbeJTBxl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 21:53:41 -0400
Received: by mail-ed1-f68.google.com with SMTP id d15-v6so32180785edq.6
        for <git@vger.kernel.org>; Fri, 19 Oct 2018 10:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fLKnzgEqIOOTApys7zgsRz3gT7PhyRXtD4noLw4RScs=;
        b=jaK2yiJMQuyLbpT0zI84qNkj/grnyxflB4S8IjpCD1lSHH0vhVIU7ehaaLsLEgjtGj
         bvlazNfzCmvAmkpxBpSHTPyKbuQfcZW1wEpM94Js0u3iaKhgJviYkGWvMzTl5hXYB/mX
         d5d8bCyRDzC5+QjZNzuufY5cJuVqNj7ybP81pcaEmcADDbrwkOmSSl2WuuevctktRwAT
         A9JA++tj1u6XwwdUO3l0r4Q/CRN7HxeXXJXg8pWd64QhXOmzsZqUE5KDK41xGK3wyiE8
         Gk1RCAQZXEqXe/p5VJQLk3q5pxaF+E8V58WulGDW2oJnM051rMlzIlLd/ejRwZEEMvrp
         z4RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fLKnzgEqIOOTApys7zgsRz3gT7PhyRXtD4noLw4RScs=;
        b=F8Fjh2NYKbhgcmIxUol/6wYx+KiN+lYJ0OyV3Jzjes9bRTQ6kVjvl1myCLMeCo/pCz
         cjCPHgGT5moPSYN1JwKCohCOsZ6qXvsHoOB2caz1SdNU5egRevMrrHMHLTEG01DClFlW
         eO9ea7QOq5dbDUCYGmvMQeuN19Gmu7iOjHg2Y/z8AfHRp4lutK6IZTWkxw9y7pTk4VW3
         CnvGZKQLH1q7979CFYxTudbEYmKWNowrwDkNWmTBPOPTukAEe02UvnuMoQv6zGDbRQFD
         mBTfR3frM2wGUJrpc+iQGvob2JsuJmxRUdZW1WmkJ2WjXAHZIt7Zbq4Bz0JhvIkTiMRN
         Zw9Q==
X-Gm-Message-State: ABuFfogNRLTvXxZ+/dve8I0+vVn6BCRcg24gfjZjFz+LsPyY+Ql7fmZR
        RGs9LWb0i6O+nCe9RHljV+zHb7MyToUIksICHNyIKQ==
X-Google-Smtp-Source: ACcGV61kZpRLBrfbznDUWwvCVxBYcqzuPc9enKB1XAxlXPpbFMqdQzTJOZeKZyEYhilZI2T8RSyj7DJufKvt8HOO0g0=
X-Received: by 2002:a50:9931:: with SMTP id k46-v6mr6910224edb.85.1539971194119;
 Fri, 19 Oct 2018 10:46:34 -0700 (PDT)
MIME-Version: 1.0
References: <20181019165532.GA31601@sigill.intra.peff.net> <20181019173443.25760-1-pclouds@gmail.com>
In-Reply-To: <20181019173443.25760-1-pclouds@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 19 Oct 2018 10:46:22 -0700
Message-ID: <CAGZ79kbgngppdOdQB=J=65evjxd7Mxm3CGZkGad42L42DPByVw@mail.gmail.com>
Subject: Re: [PATCH] submodule.c: remove some of the_repository references
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 19, 2018 at 10:34 AM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
>
>
>  struct collect_changed_submodules_cb_data {
> +       struct repository *repo;

This slightly overlaps with sb/submodule-recursive-fetch-gets-the-tip,
but we can have this patch on its own as I have to rebuild that
series, will build on top of this.

The patch looks good,
Stefan
