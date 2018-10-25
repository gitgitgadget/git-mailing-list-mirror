Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79F241F453
	for <e@80x24.org>; Thu, 25 Oct 2018 03:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbeJYLdw (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 07:33:52 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:50268 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbeJYLdw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 07:33:52 -0400
Received: by mail-it1-f196.google.com with SMTP id k206-v6so8807448ite.0
        for <git@vger.kernel.org>; Wed, 24 Oct 2018 20:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4+t1C1t3PoC8VzPqPALd+DfIVrt47NhcaFCpLK2jEXA=;
        b=XMMNmtei+qfT1OY1+k/QqAUnsjJeJ4F/yGIhg0ol71BPuDsAgeiVZ57sdwK/Aah7uy
         B3O0xifY++zNXMkjjEy/abAThdiTs7FBehqAzZp9UPu/D8m8+ZxhYRcBbAHxpOpLOHBl
         G3ckDUHEkcwaNEsccU9wBpw5KQ7iNOp4JU/qAIPrCN6H39xmJXnwzp5slnjIYYju2VK+
         2+oTPfXoxInXfwPz1HAmVFp/YiwPSPsAholyD4bbwwdZe2B+GBe4GrADad8J7cjr6acv
         HJJ2CARsWvGuvX/e6JxvzCuOTA1Pjt+I+idypNBP9BOWT6MU2WbOTHALWYdbDGit9lk1
         4cQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4+t1C1t3PoC8VzPqPALd+DfIVrt47NhcaFCpLK2jEXA=;
        b=OR9JeSgB1ZumfvBUbCCJqeWqH3eWN9rPtUg9Z4JOH1MzCeBqWRMGM11saf+s5hjpMS
         AxDPxEDAPmApLdzj/u+LFohHs3zeV8xNZ9fF2DtYMtOf1Xolqx3Bv+kvfcjyaSG4TixO
         8jP+rvZqu5K3TSHPn6yoqU2IKVRI8XNm0vYSz3aItoC6VOl2GFv1fUBGCTFQfmoIlZmU
         FcnX2F8Bs6AVsdfXUNuumuEWDcpk5qqq/Vzt/FynskSOrqzalz4R1WEdFKLuTbO0EaXT
         0TvB5ZY6fLgRzHIWM3Lim373dm2ORMtnw5U4Z4BysMeENj26KNEUzQCz51pNuRrGb+CA
         VWtg==
X-Gm-Message-State: AGRZ1gJ4/tvyYheMmlze+DvcvXxrCMncuaLMfJR2uUEIZ/Oa7J/m1keI
        uyiddZi3adJU2xd+7kGfz8rGrpsXY1UAzBCoFog=
X-Google-Smtp-Source: AJdET5e8RrYKBHls/IqGfG/7TkOj9armS+TloXTgMSQ/20AUXGkO4IyN82+r/5wKg8jCSfaW9fG3ce/ePRAaRP5V38o=
X-Received: by 2002:a24:4687:: with SMTP id j129-v6mr90484itb.6.1540436586425;
 Wed, 24 Oct 2018 20:03:06 -0700 (PDT)
MIME-Version: 1.0
References: <20181025024005.154208-1-sandals@crustytoothpaste.net> <20181025024005.154208-11-sandals@crustytoothpaste.net>
In-Reply-To: <20181025024005.154208-11-sandals@crustytoothpaste.net>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Wed, 24 Oct 2018 20:02:55 -0700
Message-ID: <CAPUEspjCjFiwCO8TCM23f2jqFSpy2z05+Ea_zGATy0jh1L83iQ@mail.gmail.com>
Subject: Re: [PATCH v4 10/12] Add a base implementation of SHA-256 support
To:     sandals@crustytoothpaste.net
Cc:     git@vger.kernel.org, stolee@gmail.com, avarab@gmail.com,
        pclouds@gmail.com, szeder.dev@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 24, 2018 at 7:41 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> diff --git a/sha256/block/sha256.h b/sha256/block/sha256.h
> new file mode 100644
> index 0000000000..38f02f7e6c
> --- /dev/null
> +++ b/sha256/block/sha256.h
> @@ -0,0 +1,26 @@
> +#ifndef SHA256_BLOCK_SHA256_H
> +#define SHA256_BLOCK_SHA256_H
> +
> +#include "git-compat-util.h"

this shouldn't be needed and might be discouraged as per the
instructions in Documentation/CodingGuidelines

Carlo
