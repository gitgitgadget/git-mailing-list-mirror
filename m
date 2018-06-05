Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4EF61F403
	for <e@80x24.org>; Tue,  5 Jun 2018 19:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752082AbeFET6T (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 15:58:19 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:39606 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751950AbeFET6S (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 15:58:18 -0400
Received: by mail-pl0-f66.google.com with SMTP id f1-v6so2188998plt.6
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 12:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=fIBVXgmR5oDdVVZOIiXCWkwCJkdGPsKzGkfynDEnAQs=;
        b=IRuCk78YEnVCq41YyQQ+Qm/TqYYjB+RNMtZks3KM5bnYgBuIVOBB35W5WIF3CX4GHH
         0lo/kPS3kvRswHV1USAq9eFaZCBee5rQUS9kli6Pud6uKl3T/hu/cgSltUsksjr15mDM
         O/tJkQqsORbZ+GvszhnOUHo95RwqufjU26gRmLWdZiAtFkGkf/EWeJ48wumUTQjrL4LT
         MAnbHR9+vM7jZsetpOQktpxK8TceFEftutraWc6zPa3Nk8qcQyIcseh0FxKp32sjCFyE
         P9Itij3s5IoXh0eObYWKVv5OmFz502iJSkhczVahJhuO3LvB/593tJ0MfTWWkT06Yhy2
         0JKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=fIBVXgmR5oDdVVZOIiXCWkwCJkdGPsKzGkfynDEnAQs=;
        b=btZuzYSkBcXISr0zeUOn4yA8f8MzgzPskwWwZEB7JvGAQa2CHGPlGT2vYjUMtpT10+
         dVutVxtucWNVu6wURYbQk6QlpB8bhZLidtHgd7FQnPWeC/diKXINRxfCRtye2uPVztud
         mAPeuFC5sUcxh9EVx/Zd+LDQnFZEiT1LQSzVTJLT8vPQQmMJ+L1yrHyrLZhNE985Ct3+
         V7Bi8yX47nfd3Cw/4AYufAw8l8B1R/4ByBZFU+UyO5ZbGsOTEIVepYtJtwEwKq3cMiYC
         EC7aknTJHDwTaF9jJN+ySPPFlJjPi1yTomxKjZj0BBfAStDORZHhM9uBX59QUHgKhmw+
         5CRw==
X-Gm-Message-State: APt69E2fQRq4wsAcxSUjK2cWD1YCJYzFXN2/JjJ5eBpzGj6etNUxnFYC
        ti/M9R/tDhy1JvLn2qNGoR0KPKZ6w0A=
X-Google-Smtp-Source: ADUXVKJwp6ZVb/cdFcZ5XxAhiC5jFchE62y2Hd5dxsjWIMU1BXBqcNqd+7Podp8q0h3/+xKzlSUTMg==
X-Received: by 2002:a17:902:d886:: with SMTP id b6-v6mr16809plz.361.1528228698213;
        Tue, 05 Jun 2018 12:58:18 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id w1-v6sm66341303pgp.3.2018.06.05.12.58.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Jun 2018 12:58:17 -0700 (PDT)
Date:   Tue, 5 Jun 2018 12:58:16 -0700
From:   Brandon Williams <bmwill@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 0/3] refspec: refactor & fix free() behavior
Message-ID: <20180605195816.GC158365@google.com>
References: <20180605162939.GA158365@google.com>
 <20180605195440.8505-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180605195440.8505-1-avarab@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/05, Ævar Arnfjörð Bjarmason wrote:
> Since Martin & Brandon both liked this direction I've fixed it
> up.
> 
> Martin: I didn't want to be the author of the actual fix for the bug
> you found, so I rewrote your commit in 3/3. The diff is different, and
> I slightly modified the 3rd paragraph of the commit message & added my
> sign-off, but otherwise it's the same.

Thanks for writing up a proper patch series for this fix.  I liked
breaking up your diff into two different patches to make it clear that
all callers of refpsec_item_init relying on dieing.

> 
> Martin Ågren (1):
>   refspec: initalize `refspec_item` in `valid_fetch_refspec()`
> 
> Ævar Arnfjörð Bjarmason (2):
>   refspec: s/refspec_item_init/&_or_die/g
>   refspec: add back a refspec_item_init() function
> 
>  builtin/clone.c |  2 +-
>  builtin/pull.c  |  2 +-
>  refspec.c       | 13 +++++++++----
>  refspec.h       |  5 ++++-
>  4 files changed, 15 insertions(+), 7 deletions(-)
> 
> -- 
> 2.17.0.290.gded63e768a
> 

-- 
Brandon Williams
