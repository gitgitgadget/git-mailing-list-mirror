Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B3031F453
	for <e@80x24.org>; Tue, 16 Oct 2018 03:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbeJPLrk (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 07:47:40 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36560 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbeJPLrk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 07:47:40 -0400
Received: by mail-wr1-f65.google.com with SMTP id y16so23682479wrw.3
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 20:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=hMbGlXtmM8AAOudnjaS4vN0veL1w11FJfWYiA7j0B/8=;
        b=YD4zekGW1LeDv75154p7ZSdpiVANCz8uG6LoeUagI4Ur1PlzELQEqYSpHtVyqkkHiJ
         IYjl0EEK0+heCt4Ot87JE+28WRyArmUTFBRs3NMoCeb1CsS4Vfnk5McLLueTF3uwp38N
         9owc/m2VO+kY6HvGcBvcXbKWua3dL2T19+RqXq+tQX0mS5a+D1lkxRebtgg8/eThi/8l
         2ZZwzZaPNMWFQF/X1FP8evRGL19/4Y7/MZO6xw97dOBBdX7fOTbFzEhnttsuYIs0eA2+
         d281SZR7TsfS9XSOoEQW5+EDaPLbAL+xfuV8uDvr5/wjhXA76CsphwyezwyX2RL5VgHE
         v70w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=hMbGlXtmM8AAOudnjaS4vN0veL1w11FJfWYiA7j0B/8=;
        b=WOHBs2bD4a83YKqJp981Lz8hSKA02Dx/SL6vsjqKgKKb5d/W9ltFSwtc8kghtcBvGO
         wnYm8bBlWgiTIZOvmQnKM1pKBLBt7pW4GXP4bNT6Q5gg/Cf7EUiCPBhdkv+ScKB6qZGk
         4zb/73mf+Imn0wj0qmtnjG4wrF1JNPuwaSihTXgFWEOVG/ZQzSy9IECyRr9YUC/gwqyD
         0gt6nWkX9JbCj2vp8Rac0GSoIz1clw80HwQYUGO18mIqV36nQPC6ez2w1f2sTMKpNgZ8
         nGdyskq/CWDMXDEVK7n7l6/3vuAcfdSqTwjmACFJ6tbShJXX5qmyzLoKBOU4gKgRD2Pu
         p2gg==
X-Gm-Message-State: ABuFfoivvz/p17EM5LT9fFc+Ic+LjukUJL2JfIFGuzsOCGNCN6M2UdgJ
        HsWj4yUo9/TVlijaKWh3wlQ=
X-Google-Smtp-Source: ACcGV63yiNC+bbiTtg5lCUdAyayjHWW5qXJZeIMvpOIT9+wfqgSLd6CKj7d8l+UmdjxyBYbpIdUW7A==
X-Received: by 2002:a5d:6ac5:: with SMTP id u5-v6mr16499133wrw.288.1539662359622;
        Mon, 15 Oct 2018 20:59:19 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id p9-v6sm8190704wrt.10.2018.10.15.20.59.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 20:59:17 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 3/3] mingw: use domain information for default email
References: <pull.45.git.gitgitgadget@gmail.com>
        <271a5f57cef00d24ee33e99839cf3890e561efe7.1539596822.git.gitgitgadget@gmail.com>
Date:   Tue, 16 Oct 2018 12:59:16 +0900
In-Reply-To: <271a5f57cef00d24ee33e99839cf3890e561efe7.1539596822.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Mon, 15 Oct 2018
        02:47:08 -0700 (PDT)")
Message-ID: <xmqqbm7u35kb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> +char *mingw_query_user_email(void)
> +{
> +	return get_extended_user_info(NameUserPrincipal);
> +}
> +
> ...
>  
> +#ifndef query_user_email
> +#define query_user_email() NULL
> +#endif

The three patches look sensible to me; will queue.

You may already have audited our use of "struct passwd",
"getpwnam()" and "getpwuid()"--I haven't.  I think we use these only
to learn user's email (to be used as the default ident) and home
directory (to expand "git config --type=path").  If that is really
the case, it may be a worthwhile clean-up to introduce our own API
that offers these two exact functions, have the per-platform
implementation of the API in compat/, and get rid of "struct passwd"
and calls to getpw*() functions out of the core Git proper, to wean
ourselves away from depending on POSIX too much.

But of course that is a separate topic.
