Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 716721F42D
	for <e@80x24.org>; Thu, 31 May 2018 21:45:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751058AbeEaVpM (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 17:45:12 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:42567 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750732AbeEaVpL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 17:45:11 -0400
Received: by mail-wr0-f195.google.com with SMTP id w10-v6so34378402wrk.9
        for <git@vger.kernel.org>; Thu, 31 May 2018 14:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=A5Him+o6cP3Fae1xt+b61vtpaCnk6w/WWKhe5wXSBV8=;
        b=l3zT2Z3Z0kJqxsec19lev/GffvuO11P1bK1Rm5y8w218mNZbs5U10wcZKSPyCYuX1n
         i51/BIBCQQjUP+3GFDG4W/JEnCpbKTMNyUK9bmO4EmLlxbhI3YDDdWSooc4vWWr8Z/OS
         p1eUv8TmuATQd3bhA1iCuheRVQ/0tEo81S/JxoVT7J8d27MuoGQSiDshaqYIiy6XEIyA
         jXRHOyV0ATnpPjuii+O9JxoLiveVN6lBH33+AfoOWMOjZsTr9sJv9wkX2vwznVMxxIxV
         c4xc952fNpB6RydUIkRaj3JHpSOjUnGfksZI+aJvj261/E80qiwz71wmt5sRsmOtIarE
         JOQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=A5Him+o6cP3Fae1xt+b61vtpaCnk6w/WWKhe5wXSBV8=;
        b=Q+Fs4XbuJFzhOlejMzaOTY9Y2nuWeeOjMpg9BuhpUyo80zRUrcAVbCHYv3w2zY8Z76
         WAtJkCJAMA8iMc7p1kkMkSe91Wa4yDcUkbDpX1KOEf1AIweVrK+pGoA7O7fNwvmYupsW
         +Lzt+uqMq1xfiK0rvNmjkzF6wAqPUqUwmSrfKigRzi1eP3C8IXZL2Ib/D22dpZ5eip/k
         edvGi8i8XZixVIre8QyVcJ158pcDmW+3Ng2snAOlQtJJVdfDnQ7IayNRQ2R1y3ax/MzY
         vVu2DE7ujb5rcaQRbVQJxMs9iUaUQSuPg6FkRK6HwZx4BBDrGD7A6xVstLp7O8dPx/ln
         4sEQ==
X-Gm-Message-State: ALKqPwc/pX1VtHeSjLqJaeFRBX/5k2k7IVATEBNJy3ZbbJMpBv1XnOkO
        mxWVjOovzvUvuxDiwqHjx7Y=
X-Google-Smtp-Source: ADUXVKLqNdkKfi7MKDwu9lEwiqihAFXEcpEyxu7JXAj5hMLBlIPovceFgiWB3NMaXk4kr38G8pHuMA==
X-Received: by 2002:adf:b710:: with SMTP id l16-v6mr6877250wre.115.1527803110487;
        Thu, 31 May 2018 14:45:10 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id 67-v6sm411756wmw.32.2018.05.31.14.45.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 May 2018 14:45:09 -0700 (PDT)
Date:   Thu, 31 May 2018 22:45:46 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 3/9] checkout.[ch]: move struct declaration into *.h
Message-ID: <20180531214546.GC26159@hank.intra.tgummerer.com>
References: <87a7sg9sjz.fsf@evledraar.gmail.com>
 <20180531195252.29173-4-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180531195252.29173-4-avarab@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/31, Ævar Arnfjörð Bjarmason wrote:
> Move the tracking_name_data struct used in checkout.c into its
> corresponding header file. This wasn't done in 7c85a87c54 ("checkout:
> factor out functions to new lib file", 2017-11-26) when checkout.[ch]
> were created, and is more consistent with the rest of the codebase.

We seem to have plenty of structs defined in '.c' files, if they are
only needed there.  Its use also seems to be single purpose for the
callback data, so I'm a bit puzzled how having this in a header file
instead of the .c file would be helpful?

I feel like having only the "public" part in the header file also
helps developers that are just looking for documentation of the
functions they are looking at, by having less things to go through,
that they wouldn't necessarily care about.

> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  checkout.c | 7 -------
>  checkout.h | 7 +++++++
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/checkout.c b/checkout.c
> index bdefc888ba..8d68f75ad1 100644
> --- a/checkout.c
> +++ b/checkout.c
> @@ -3,13 +3,6 @@
>  #include "refspec.h"
>  #include "checkout.h"
>  
> -struct tracking_name_data {
> -	/* const */ char *src_ref;
> -	char *dst_ref;
> -	struct object_id *dst_oid;
> -	int unique;
> -};
> -
>  static int check_tracking_name(struct remote *remote, void *cb_data)
>  {
>  	struct tracking_name_data *cb = cb_data;
> diff --git a/checkout.h b/checkout.h
> index 4cd4cd1c23..04b52f9ffe 100644
> --- a/checkout.h
> +++ b/checkout.h
> @@ -3,6 +3,13 @@
>  
>  #include "cache.h"
>  
> +struct tracking_name_data {
> +	/* const */ char *src_ref;
> +	char *dst_ref;
> +	struct object_id *dst_oid;
> +	int unique;
> +};
> +
>  /*
>   * Check if the branch name uniquely matches a branch name on a remote
>   * tracking branch.  Return the name of the remote if such a branch
> -- 
> 2.17.0.290.gded63e768a
> 
