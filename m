Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83A901F404
	for <e@80x24.org>; Mon, 17 Sep 2018 21:43:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbeIRDMR (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 23:12:17 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:33116 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727329AbeIRDMR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 23:12:17 -0400
Received: by mail-yb1-f193.google.com with SMTP id y9-v6so4441796ybh.0
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 14:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1/bHdO2fyy4y0iRKL0nqM0CtmPxLuduyf52WULhSpjc=;
        b=YacdrFgvGTk0RjOjy5GlUqsZEsnjdiY9Y1IyODD0BxSZ5sKXkAUvJBcjcr9nr47txW
         NyaQ8sX+wIydpg9SVecRXiYZsRyykh5Sslper40Lpb71RNn2uXzrsLc7UI8NiGeny+gM
         9KVucghFk1faTiB8XlJkPBCR2n45EPMPaV8lVWm98dYTczyhtjbQLMCarEz8+2s9LrMM
         u9dMxrUttvz+L7XQreIPnIOBd1Ybnkv0+D02uYRT2qWJI2ZFMvLr8Ud6wzsLFJQkpsBl
         SikD5U5SiH+WHEi0ISdyOI2t4NdGGDP/ytKCTKE8UT6fva96UaourXoYUvoBiBSDHhP7
         j9Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1/bHdO2fyy4y0iRKL0nqM0CtmPxLuduyf52WULhSpjc=;
        b=mSyWhfG6N9HNl7iOAEesv2Y6AkVSgsh7FyrXU8zkJr1V8IPGzBNIo1sJ0cxEm+Ffqs
         ajYfjLX3OKqUWhR93qChH7h43KTQuJLAN+bg2et6cdoyL0DecpzMGWXZPufszer1XOBy
         IbFCijvooau+V58HnDwhOjKlHrGdtU8FUMU6liDX7MfgglwRSwZml16g7elEz83x6emQ
         Fv8GG4n9hJ34dBhw6SbWzzRgGonJWo8qBPbMS052Tn2RzCHzixBsE8foh1hR/x60XVfM
         ays35qUOxxdkb1oS5uE9xs9lMjkKfohZ7sqxQ/UymL9tb+UCpaoxHrgt+XBre88yRkvV
         VAkg==
X-Gm-Message-State: APzg51BNK2a4S8kqfe3th2RWkW03Djt8yhq468OX9lFq2NDk6FDpKdoR
        kYmdBolHGm1S8AZIBwSGnHkA2aTwNB7zvG9gEnm4dw==
X-Google-Smtp-Source: ANB0VdbVcDUjqFsv7CixHjzTFFhYf+mGVPpxyQ3IpUbn7xQxfs3sMNWCmseeUhd87Gv8uBFf7gddB+/xKzQqZL2MWi4=
X-Received: by 2002:a5b:1cd:: with SMTP id f13-v6mr11264637ybp.363.1537220585819;
 Mon, 17 Sep 2018 14:43:05 -0700 (PDT)
MIME-Version: 1.0
References: <20180911234951.14129-1-sbeller@google.com> <20180917213559.126404-1-sbeller@google.com>
 <20180917213559.126404-3-sbeller@google.com>
In-Reply-To: <20180917213559.126404-3-sbeller@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 17 Sep 2018 14:42:54 -0700
Message-ID: <CAGZ79kYtR4BgzFDfHookB-ax1wN0TVH1Qam3vC99ypjwr=PHgQ@mail.gmail.com>
Subject: Re: [PATCH 2/9] sha1-array: provide oid_array_filter
To:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 17, 2018 at 2:36 PM Stefan Beller <sbeller@google.com> wrote:
>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  sha1-array.c | 17 +++++++++++++++++
>  sha1-array.h |  9 +++++++++
>  2 files changed, 26 insertions(+)
>
> diff --git a/sha1-array.c b/sha1-array.c
> index 265941fbf40..67db5eeec9a 100644
> --- a/sha1-array.c
> +++ b/sha1-array.c
> @@ -77,3 +77,20 @@ int oid_array_for_each_unique(struct oid_array *array,
>         }
>         return 0;
>  }
> +
> +void oid_array_filter(struct oid_array *array,
> +                     for_each_oid_fn want,
> +                     void *cb_data)
> +{
> +       unsigned nr = array->nr, src, dst;
> +       struct object_id *oids = array->oids;

Blargh :-(

I made this last minute "pull oids out to be more like
the object_array_filter" and typo'd without compile checking.

Please discard this series.

Stefan
