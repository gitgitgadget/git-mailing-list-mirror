Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24D8E2079A
	for <e@80x24.org>; Sat, 12 Nov 2016 00:31:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936234AbcKLAbB (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Nov 2016 19:31:01 -0500
Received: from mail-qk0-f170.google.com ([209.85.220.170]:33292 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934500AbcKLAbA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2016 19:31:00 -0500
Received: by mail-qk0-f170.google.com with SMTP id x190so38854868qkb.0
        for <git@vger.kernel.org>; Fri, 11 Nov 2016 16:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vQkHhUMmvj5X9HIr9TNaHHRChorPbCGQRj6gTEp+gic=;
        b=Sd8hcwtWVcHGm+5qTyIlNiBJwhZJAJc1XGrCIkRiIrjZO9HAW7JVJistr+KSBQ9XRw
         F0mFuYDPR47ufFhyYL364gXU2JI7PKXStKGuwVh+/jfCCRpjqrb4Ql8PGbBnilKh7LOL
         2w2rwBkLDFNLR9xfNuMw4eqWV1vTaIeqtAPN/e6hC0mw0s7006D8WzIc55M2Q0/POeM1
         tVxuUcMJfWhRyg5JS7uE/huia229p+fz5DT+pQJ3rFgF6USgRv0KlFFHORXlEI/xXMFz
         7N77XdpncEbiu6ThwsKOwec/PjgiC1N4NWD1fVQ3FXTgAk19YxPd6j5l/W/LqpK1D8pk
         8tCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vQkHhUMmvj5X9HIr9TNaHHRChorPbCGQRj6gTEp+gic=;
        b=Bf66c0jAZ2FC8TtxF5mJlIAQn0A07sbIZvYrOt19BAuW6Bu23rE6mhNDcS4G+tJTdF
         BbnlWJOa9engopQAM9fBvaXY2AsuSb0+1e01ziTC3j0+/kO/R1cqVfgpgErlxGb9fRiG
         FJUPw4ZcdSdHc4fX+MSWMxM6DB1f3VDzoQjHdCnJ+ttgJOUIuYSH/y6tdcMz1nLHDwdh
         UkbxVIcu/xL55hQzOBm8h1HG4ADm1ZMFcJEzqpEuZ8PkBLwOmJr9aIX5ONytc3W1Qiof
         CXwxMk3H96bHMVY3LLOOauJwlPB/tdcYVd1fiQ6umja0NboMDUQ0c/1euNGLoDyaFO1g
         ypQg==
X-Gm-Message-State: ABUngvenkWK8am3U5WH21uZYXEZZHyEswXD4sifUDgfJdUpIhDvdZoh5uY0nuJfzi19zs9NoXS4ALr4ct49cOgH1
X-Received: by 10.55.16.147 with SMTP id 19mr5978439qkq.255.1478910659246;
 Fri, 11 Nov 2016 16:30:59 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.134.65 with HTTP; Fri, 11 Nov 2016 16:30:58 -0800 (PST)
In-Reply-To: <1478908273-190166-7-git-send-email-bmwill@google.com>
References: <1477953496-103596-1-git-send-email-bmwill@google.com>
 <1478908273-190166-1-git-send-email-bmwill@google.com> <1478908273-190166-7-git-send-email-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 11 Nov 2016 16:30:58 -0800
Message-ID: <CAGZ79kbf2i5s8Y84i2Wehbffsw1dUDUY6LYPEMME3vC6zo8-aw@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] grep: search history of moved submodules
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 11, 2016 at 3:51 PM, Brandon Williams <bmwill@google.com> wrote:

> +
> +       rm -rf parent sub

This line sounds like a perfect candidate for "test_when_finished"
at the beginning of the test
