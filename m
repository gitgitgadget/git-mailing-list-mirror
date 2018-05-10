Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7D841F406
	for <e@80x24.org>; Thu, 10 May 2018 18:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757456AbeEJScl (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 14:32:41 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:35815 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757305AbeEJScj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 14:32:39 -0400
Received: by mail-yb0-f196.google.com with SMTP id j143-v6so983941ybg.2
        for <git@vger.kernel.org>; Thu, 10 May 2018 11:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vYl1IsjRTK8QYHz+0S0GhN/AxqfXBBSrPGcAOmtW+bI=;
        b=QnTLkcQzrKBee4f9rMtigsE4D6Ogt54N9C+OmPA7eTFCb0MToP0nxa3x+lZ9m8RkHU
         V2rlYhCpb7xKeqWgXYE0ZX1sLUq9Cmud1k6E5S/sNfRgyvmYu9/LT82giqB2fLu/afIW
         0YB/kgtU8jUTnpXdKCNthTOOvP9gbVY2b18lp3RuKazPeKLzGb98MFxu8joq1dGwQ/0M
         LPT1Rtff6KT00GJFuqp7zgHLdGnp7ktuzpVTKUACCXCt85vV9d5uEApt3Q+lLp4bLauW
         VGB8VvadzoFZ2njHRkIyr7YLG1/BhnCudIwq0K/YQrAgGMQvkZwwnEGp+j+PU+UmFWYC
         hj5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vYl1IsjRTK8QYHz+0S0GhN/AxqfXBBSrPGcAOmtW+bI=;
        b=a8jAdpXa2/f9RClaqICCuW0UumQQqiiL4wmMb8tGAEwLgDhHkDzVn645ZFtbFPw5gz
         ZJ+k2lxPVwac0SW2IyB9LfIS44UMgx9lQBUQpbL2AO473WWJQSenSW8Nr1nfERzCkitQ
         y/1t/SmzpONbOEidgMog/X3Ej6exm4L7rfR9Z9sSPlMExtQRf/UejJpjymRWRVv0mKuZ
         nbqGIxqyk5+3khJ2Zpm1X4XJ6Z0VR1iTm9CgQJAs8WYsJPraMhGPzQqUWZcqPQq64hvs
         vJq+2tSpgAXK0QKFzMXp9jiaef20+nNGe/vKvv2sCsGvupPKD72BsTk6AUy4+EQf2VRo
         6Pog==
X-Gm-Message-State: ALKqPwdF8PQEGZg3C0EOrb/TJRK/29//DQ9dz9anq3jjKqOIWN4DVwOX
        jyRI6ughzULcDbEITIVO0P3LNOlJyZ+U5egDCeBzCg==
X-Google-Smtp-Source: AB8JxZpo4dlwfOBlmx1Pu6gHeeFAzA+0YutC73kPTtOOwOSqmbF6tWP/MBzhwc1AEnLliNrSCtzrETn/I9RtuXm9MZQ=
X-Received: by 2002:a25:500e:: with SMTP id e14-v6mr1405486ybb.334.1525977158144;
 Thu, 10 May 2018 11:32:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cfd8:0:0:0:0:0 with HTTP; Thu, 10 May 2018 11:32:37
 -0700 (PDT)
In-Reply-To: <da155b13-b915-edb7-9bf9-6bef900cdde9@gmail.com>
References: <20180509234059.52156-1-sbeller@google.com> <20180509234059.52156-2-sbeller@google.com>
 <xmqqtvrfizce.fsf@gitster-ct.c.googlers.com> <20180510115623.GA20632@sigill.intra.peff.net>
 <da155b13-b915-edb7-9bf9-6bef900cdde9@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 10 May 2018 11:32:37 -0700
Message-ID: <CAGZ79kb_qLm2dBxDmH7-N9C9+oVArxehTC3RuM7ci292AuFmBQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] replace-object.c: remove the_repository from prepare_replace_object
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Using `git grep` I see 230 instances of 'xmalloc' and 261 instances of
> 'xcalloc'. After the Coccinelle transformation, these are down to 194 and
> 190, respectively, because the rest allocate in the same line as the
> definition. It's worth thinking about the macro pattern for those cases.

Thanks for reporting the coccinelle experiment!

As we follow a strict declare before code, and we do not know if further
declarations make use of this already, e.g. given

    struct foo *f = xmalloc(sizeof(*f));
    struct bar b = &f->baz;

we cannot split up the line declaring and assigning f, but the macro
has to recreate the assignment upon declaration, for that we'd
need to have something like

    ALLOCATE_TYPE(type, name);

which over complicates things IMHO.

Maybe it is worth identifying the pattern where 'f' is not used in further
declarations, such that we can make patches as

-    struct foo *f = xmalloc(sizeof(*f));
+   struct foo *f;
    struct baz b = &unrelated;
+
+ ALLOCATE(f);
+

Thanks,
Stefan
