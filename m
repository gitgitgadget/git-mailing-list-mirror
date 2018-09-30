Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 604581F453
	for <e@80x24.org>; Sun, 30 Sep 2018 14:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbeI3VU4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Sep 2018 17:20:56 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:35952 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727425AbeI3VUz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Sep 2018 17:20:55 -0400
Received: by mail-wm1-f47.google.com with SMTP id n23-v6so6208186wmc.1
        for <git@vger.kernel.org>; Sun, 30 Sep 2018 07:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ZOUV/u+mpJl7cbzkyYHcHLC88Om8N+8KNV65wUr9n1c=;
        b=HZZdqTPnXpINs2hZl/+DqAtvlmNFYPS3o5zjTc+r/XcRj4ZhsB+n+WQyLHyBl+vcSl
         punkjuCwU5p82ieSNWOufTbKn61ISAx5ahuylNiB0x3mQYv7MvVsIaZFw87zJfVw3IzY
         gxjZeT/3k6nNMbPrKOghTxHHHac+/4vz0eGldAldVEGbm2fa0DE/yW973tmE1iSC3bNa
         8TQF+Ing6PmM9eEiuYIdK4xb+bLsKSDq2XqmzVg+2fJOtTasGZ+W61T6WCdwoLhbbpBO
         yc/WjVsTPQ/nQLDR/0YLu6pfEKjRLd0TuNld4+rnTXcXQXxNb5qiguCVC8wJmqa2oNBk
         mVEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ZOUV/u+mpJl7cbzkyYHcHLC88Om8N+8KNV65wUr9n1c=;
        b=GaeNz1Rb4GFraEvzpVtyDEMdc3bFlMEE78PrhywhD1ySvtYt9Pz+nPzRUHSx2cFOIw
         ivbf3IgFAmOtN95KL5i4RVU/ANpHTBIlHTNWae0eoBEbl46sDvSTmGhJY9FJkt7fcH3k
         0aK6Os/OdBmAKSqAAbsX4gSPI4rsKtkQ9Nx5voOjr/6Q5PvD2H1c5TU6VEdJBt8Pkj5k
         GefZKsunWuyjMF4Vo8lXTui3D7zfspy3osN952IbECUOyQLKaZp1FIaqrps0FaOyhSUi
         2FBVdrr96pMZWaW7bjeVWujnoven/Jq06Bx92u4ogWAvCZ/RPquwVlOqjdpqSMlYpPQF
         Pt/w==
X-Gm-Message-State: ABuFfoh6nLiBHTEwjq4KWjOMoByNlqM0ELZir8N0afCENMOSA1u6yYV+
        9C+sry9QtaaHjYvX9UN6qYo1Ke/4
X-Google-Smtp-Source: ACcGV61oWdVg+4IvmX6mjRRPSf90KsiC/L4kw3uuC9/Oegv8Iup6/hUiqzLQxlm2YkSuEAqpbNEQIQ==
X-Received: by 2002:a1c:9c56:: with SMTP id f83-v6mr6940365wme.135.1538318855067;
        Sun, 30 Sep 2018 07:47:35 -0700 (PDT)
Received: from localhost (x4dbe4c7d.dyn.telefonica.de. [77.190.76.125])
        by smtp.gmail.com with ESMTPSA id r30-v6sm18156088wrc.90.2018.09.30.07.47.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 07:47:34 -0700 (PDT)
Date:   Sun, 30 Sep 2018 16:47:31 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v3 0/6] Fix the racy split index problem
Message-ID: <20180930144731.GJ23446@localhost>
References: <20180927124434.30835-1-szeder.dev@gmail.com>
 <20180928162459.17138-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180928162459.17138-1-szeder.dev@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio,


On Fri, Sep 28, 2018 at 06:24:53PM +0200, SZEDER Gábor wrote:
> Interdiff:
> diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
> index c8acbc50d0..f053bf83eb 100755
> --- a/t/t1700-split-index.sh
> +++ b/t/t1700-split-index.sh
> @@ -6,6 +6,9 @@ test_description='split index mode tests'
>  
>  # We need total control of index splitting here
>  sane_unset GIT_TEST_SPLIT_INDEX

The conflict resolution around here in 3f725b07d3 (Merge branch
'sg/split-index-racefix' into jch, 2018-09-29) accidentally removed
the above line, which makes the test fail when run with
'GIT_TEST_SPLIT_INDEX=yes', e.g.:

  https://travis-ci.org/git/git/jobs/435077629#L3389

> +# A couple of tests expect the index to have a specific checksum,
> +# but the presence of the optional FSMN extension would interfere
> +# with those checks, so disable it in this test script.
>  sane_unset GIT_FSMONITOR_TEST
>  
>  # Create a file named as $1 with content read from stdin.
