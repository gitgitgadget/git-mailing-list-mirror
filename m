Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E2FC1F404
	for <e@80x24.org>; Sat, 17 Mar 2018 14:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753251AbeCQO3g (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 10:29:36 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:45196 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753212AbeCQO3f (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 10:29:35 -0400
Received: by mail-pl0-f67.google.com with SMTP id v9-v6so7539732plp.12
        for <git@vger.kernel.org>; Sat, 17 Mar 2018 07:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=z1nz6Dn/VaTn4l0teM96Dg0HdfOU+VSin6EqiBA3pbg=;
        b=OjmcJcubvhkHmbQFCW0CP4+B6AXSEQQGd6HdfwydaBv18Z98NmzLUgzdPmS6weQuL/
         HCfeMpnAZ4NpILm8M+GKh/PnC/hcTMZXmKTvZ0wsb4RTDb2J8nYd0GyH8egG9zH4tdxR
         Tkhqp6lEhsI8pYY1LIqT0hVp/KuLD8eSa7bQq8BDowL2c+yYzIQFXNVb/6tL9s6EGls+
         liowjgsMyCCDu33tkwFnMy0GezDlqTlQh1U4OhIQSLVWqi/qprgM6W+fZX3Kt4LAgdP4
         nKv3JhfrWAvJWgmpEohgIV7INJAjbk/NNP+QznFN8Lbe3puccjXxA3JKKqECdbfysaMj
         rBrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=z1nz6Dn/VaTn4l0teM96Dg0HdfOU+VSin6EqiBA3pbg=;
        b=i3nr8DNdS7hdQ3TLqMSRIbZq9+XsVA8NJkmyKP8LOSnF8F6pXmgZSglpSfzqi2hHnx
         M1/w13/mRELHqGS9MIA5l4RnmmVs4VLETpr56LxjTcWdnWJ1xqjqPgJYDO0AxTpDqTrp
         ApWu+zGdkkiuy305ydwzevfRsIOI4jbiIbF55WcWMzCG0Wlkm9bv3CjTxhc4Qc8Hclbi
         LR+enocHg3Z95XjwWcglfybVgajvRCBV0nHtFj/2sNrfbpAJDfrEWGRM3tj7k1qta3QO
         PRJ8bR8809i8VsdHePj3p28MFVlz3G7QipCSWAf5WnV2JKtg5EFR2BCj7qXzDA9wKV2s
         Gw5A==
X-Gm-Message-State: AElRT7FuIyjookdd/3S4JF7hUO5ncssTGCm0Vfd4X6tLpqQ0Fu1vWIJO
        7T3EKgiTbAToVvQg/LTZNyfdlzv3
X-Google-Smtp-Source: AG47ELuX1VuGM5TzQ2hqMIkJkNv7bwrcFsOM4ds5z4mnSsWiYHuABTTO7mq7mzWsoIr+qbaJloxL1A==
X-Received: by 2002:a17:902:5389:: with SMTP id c9-v6mr5850559pli.90.1521296974620;
        Sat, 17 Mar 2018 07:29:34 -0700 (PDT)
Received: from par57nmp12.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id p9sm18207789pgs.89.2018.03.17.07.29.32
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 17 Mar 2018 07:29:33 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v2] travis-ci: enable more warnings on travis linux-gcc job
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <CACsJy8A3_itjs0MRar+Aog=0yZDuAK2-x4MU=Rvqh2C6Le-7Aw@mail.gmail.com>
Date:   Sat, 17 Mar 2018 15:29:31 +0100
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <D8137CD9-9E11-4FBC-B89B-907C007FC6E9@gmail.com>
References: <20180303014605.10603-1-pclouds@gmail.com> <20180316193355.20161-1-pclouds@gmail.com> <20180316212208.GC12333@sigill.intra.peff.net> <CACsJy8A3_itjs0MRar+Aog=0yZDuAK2-x4MU=Rvqh2C6Le-7Aw@mail.gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 17 Mar 2018, at 09:01, Duy Nguyen <pclouds@gmail.com> wrote:
> 
> On Fri, Mar 16, 2018 at 10:22 PM, Jeff King <peff@peff.net> wrote:
>>> diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
>>> index 3735ce413f..f6f346c468 100755
>>> --- a/ci/run-build-and-tests.sh
>>> +++ b/ci/run-build-and-tests.sh
>>> @@ -7,6 +7,22 @@
>>> 
>>> ln -s "$cache_dir/.prove" t/.prove
>>> 
>>> +if [ "$jobname" = linux-gcc ]; then
>>> +     gcc-6 --version
>>> +     cat >config.mak <<-EOF
>>> +     CC=gcc-6
>>> +     CFLAGS = -g -O2 -Wall
>>> +     CFLAGS += -Wextra
>>> +     CFLAGS += -Wmissing-prototypes
>>> +     CFLAGS += -Wno-empty-body
>>> +     CFLAGS += -Wno-maybe-uninitialized
>>> +     CFLAGS += -Wno-missing-field-initializers
>>> +     CFLAGS += -Wno-sign-compare
>>> +     CFLAGS += -Wno-unused-function
>>> +     CFLAGS += -Wno-unused-parameter
>>> +     EOF
>>> +fi
>> 
>> Why isn't this just turning on DEVELOPER=1 if we know we have a capable
>> compiler?
> 
> DEVELOPER=1 is always set even before this patch. It's set and
> exported in lib-travisci.sh.

I interpreted Peff's comment like this:

If DEVELOPER=1 is set and we detect a gcc-6 in the makefile, 
then we could set your additional flags in the makefile.

This way every developer with a new compiler would run these
flags locally (if DEVELOPER=1 is set).

- Lars
