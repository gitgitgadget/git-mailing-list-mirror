Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD67D1F454
	for <e@80x24.org>; Fri,  1 Nov 2019 01:40:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbfKABkJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Oct 2019 21:40:09 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42822 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbfKABkJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Oct 2019 21:40:09 -0400
Received: by mail-pg1-f196.google.com with SMTP id s23so1999155pgo.9
        for <git@vger.kernel.org>; Thu, 31 Oct 2019 18:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PPhdtYLh44T6PIqoXePrdyFO1PBrPt1BlD113ieeiAE=;
        b=JEDjs7uBhQgXBBBJD/RUheIznZOfFhDJdrlxP7wKyzracdNDsmEWymkZ+NlmlqiB+e
         MfYfQZlA/e3CkeMrPH9DoEAC63GBEYddd+dkWM/pGnqno+WVtPRpEnK2WhpJUmc7yb3/
         oGbztAQdLhfjgZKRWis+Pz2xmwNtwCkDF9/CH8CyIW7inXnddo9v1waiS8lhw2JTyp2q
         tB4hXpFSIh15cleQVRDeawax6CO3RK+UUPXDXRbXJ4V04McF5aTy421Wy2BY6wWeRzvm
         3qido+UBJyrqU2taGOlueZDMVOec6aCmpiELBlosYKABNHivklidTDYa8WVPEcVUgSJL
         dOQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PPhdtYLh44T6PIqoXePrdyFO1PBrPt1BlD113ieeiAE=;
        b=Fk5qqkLqJdW4GcDBrZiAzZkK5ncoPihMiWr70WYpPitzurrdoFFtAnV49/o15IxEL4
         aUudGNgrfKiMq//Xm8ikw+Q49z1OMc7ODQ66yTXCFa1wC/5xpZp6SdCT1rAKGly0x4nA
         5oYWSopXXOORoUCHuf6up5xVmIRM1R9ZDKBmT/454dvibBtzxDRzT+lx/0CumW6yoDTl
         RBxumUbLlgDYL4yNSrSMpBMR3kNhs/sCARlo6BQTWuAJk8egjFkmM0ox/78oHf/J5rh2
         EvVc8U0FbF5GXgWFuCW++CUuO6Eedv4soXxe4oChQak/+qRyIOkZnSg5fg+qBoYRnXqf
         mtdQ==
X-Gm-Message-State: APjAAAUnksmWfA8lZqUnkePiTtTO/r/h1wuunIYhoaHb6PKnk16e47qe
        MqYQ2lzjyHKe1YCZSCXnZ/A=
X-Google-Smtp-Source: APXvYqyuS8q8ET08Gpma54xA2WxmeHyd7+PQ9Ia5k2LOJOlvzqUS1XU11zxTC3TA61ToUeUaAWuyMg==
X-Received: by 2002:a17:90a:db0b:: with SMTP id g11mr11943023pjv.15.1572572408359;
        Thu, 31 Oct 2019 18:40:08 -0700 (PDT)
Received: from localhost ([2402:800:6374:2d45:2809:9830:be60:8e46])
        by smtp.gmail.com with ESMTPSA id 205sm1948723pge.56.2019.10.31.18.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 18:40:07 -0700 (PDT)
Date:   Fri, 1 Nov 2019 08:40:06 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/3] configure.ac: define ICONV_OMITS_BOM if necessary
Message-ID: <20191101014006.GE30350@danh.dev>
References: <20191031092618.29073-1-congdanhqx@gmail.com>
 <20191031092618.29073-3-congdanhqx@gmail.com>
 <20191031181116.GC2133@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031181116.GC2133@sigill.intra.peff.net>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019-10-31 14:11:16 -0400, Jeff King wrote:
> The ICONV_OMITS_BOM flag is about the libc iconv that Git will be linked
> against. But this is checking the iconv tool. For a system that is using
> musl across the board, that would work. But it might not always be the
> case (in particular, I don't know if people statically link some
> binaries against musl; certainly I've seen people do it with dietlibc).
> 
> I think we should be test-compiling a small program, similar to the way
> OLD_ICONV works (though I guess we may even need to run the result to
> see what happens).

Originally, I wrote a C program for AC_RUN_IFELSE, but I found out the
complicated of OLD_ICONV and NEEDS_LIBICONV, then I switch to this
approach.

But, your reasoning makes sense. I think people could build a static-linked
git binary for a clean-room build system.

I'll pursue the C program in the re-roll.

-- 
Danh
