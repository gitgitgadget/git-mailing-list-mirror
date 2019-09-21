Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 889111F463
	for <e@80x24.org>; Sat, 21 Sep 2019 21:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbfIUV6i (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Sep 2019 17:58:38 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42829 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbfIUV6i (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Sep 2019 17:58:38 -0400
Received: by mail-qt1-f194.google.com with SMTP id w14so8395266qto.9
        for <git@vger.kernel.org>; Sat, 21 Sep 2019 14:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CZQ/8RnCz3trM1v4eEN/ZtC5iV7ONW+n3d3yGgw9ZiI=;
        b=mYajXq1fTdtarxUvJL1mqevI3yI1+rnweSdKODoCXweqSLHKq0VLJbq6L6UJjZZ9WT
         mVxHInHPjKPkx8OYSLc5Uem9jgls7iBqqxuOUEvhTm3SkCfEJrAZK3jKjwTE/3kvuIcS
         biWK1FN835bOx3OBae5Oguu6ZJxCb5o5/cw7aR8tXgYIMSdXemaLydX/CGv8wwNnyzT7
         OMGf3cqJ9Q+Zd80YI7UV4VYtu+qqK2MGblIYWIvnyyupg/wkRpqXyM1n/kwS9c9PSzCh
         tZLnX6nRaMzU5Zzc9tDHAZ8rcVTyLrXyYQbNTBpG/v6ofe59LTAIL3OwgzzqgbNEz8bU
         4yOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CZQ/8RnCz3trM1v4eEN/ZtC5iV7ONW+n3d3yGgw9ZiI=;
        b=iqBB4FDyRhr1KHz7272a8xLhRpFLKpy2C2hVnUeAeegLODF33vOoetqY7ieU8LKI74
         Om81hKpX/aKO7viRX7IP0ObXpda0pRgryRLm8KF0IhneVpLRilE6XxPl6rsZ9JxdEUzK
         KfJGpU+xXtnhSZjdhZWciu8Ob8FRzOwK05yI4DKDEizqfJoSCbBE3uh7VQ5NAADu8Bd3
         GZ4w93JPIuWIKQdq/KrKCOAM69U2CvwtJnYDnEV4qQ7y3zgzzzho/N9jV6iULtwOX7Ei
         CUjq/chkj1BcPQOwVnbp+uys95Uaj6V/zf93ueF1k+DZTGU3fueVUe6P+x2uAD0X69Y0
         sfWg==
X-Gm-Message-State: APjAAAXaWqjno1h1t/oi/qSdY0UTmVuDWOB7slWzryh3xevA2wLxL6lz
        0kbW5kL0C8GElM0txAV2WV/oHH9Ma017aZZctRU=
X-Google-Smtp-Source: APXvYqxXe5D2vCkss/ko9TIkm2cykniRpihxJe5mGokfxFPCZaJO7f+NUmXK2FEsDseMEBIyxrPY7bcjJyNTrAjwTG0=
X-Received: by 2002:ac8:43cc:: with SMTP id w12mr10313135qtn.301.1569103117429;
 Sat, 21 Sep 2019 14:58:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1568771073.git.matheus.bernardino@usp.br> <fc5f5fe95c10ac66d1234a025122c8866965021f.1568771073.git.matheus.bernardino@usp.br>
In-Reply-To: <fc5f5fe95c10ac66d1234a025122c8866965021f.1568771073.git.matheus.bernardino@usp.br>
From:   Brandon Williams <bwilliamseng@gmail.com>
Date:   Sat, 21 Sep 2019 14:58:26 -0700
Message-ID: <CALN-EhSnadjdgdpbuZhj5tDQe5a8uQ6CBnDgh4CZ-AG3JuU_LA@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] grep: don't add submodules to the alternates list
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 17, 2019 at 6:56 PM Matheus Tavares
<matheus.bernardino@usp.br> wrote:
>
> When grepping with --recurse-submodules, the object directory of the
> submodule is added to the in-memory alternates list. This makes git need
> to watch out for more packfiles which might bring bad consequences for
> memory and performance.
>
> Now that raw_object_store is a member of the struct repository, it's
> possible to use the submodules' instances directly, without the need to
> add its odbs to the alternates list. So let's instead pass the subrepo
> down to the threads and replace function calls which use
> the_repository by default for their more general counterparts. Also,
> submodule cleanup must be refactored as calling repo_clear() at the end
> of grep_submodules(), might free the subrepo's resources before threads
> have finished working on it. To do that, let's keep track of the
> workers progress and only call repo_clear() when it's safe to do so.

This is incredibly exciting. Glad to see the effort that were started years ago
to finally come to fruition.
