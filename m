Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1272B1F4C0
	for <e@80x24.org>; Thu, 24 Oct 2019 23:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732420AbfJXXtf (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 19:49:35 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:37097 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730783AbfJXXtf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 19:49:35 -0400
Received: by mail-pg1-f202.google.com with SMTP id u20so323281pga.4
        for <git@vger.kernel.org>; Thu, 24 Oct 2019 16:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=N1nMa6PwEAt7NFs4iPjCHvRyKTyjq99dEj2oTJSVZhI=;
        b=efpXwi25LSiiJPuYNAVQBIbq4PB7eGpBhN1c2vx8Ao1vhxbno99BO5v/KJcACZhNkc
         4vioRoHBYgdBJDmFY6ndLOx/Uu7sKJs09FJiAKFzvf2eLi0owYuIqNVrgQ3ubipLs/mZ
         F/F7eOx2LU4KMtJLARI4Aceerqr7P/RuYuSoeBAgjhjWfatLemmS8uH3BZ6r8JfOekIh
         IwaEuiuHew6GueE/AtGgYKO411pr2yVOA6KyOx2jtolOYLLmdJRsGlFv75hRePLI2rdX
         bt6Us7Iz0KPJDlWtJu4zdiJSI3TT9WsfGY5sbcqeXeCM+V/V6WaVx6oIxlrxRWvCzwi7
         OA1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=N1nMa6PwEAt7NFs4iPjCHvRyKTyjq99dEj2oTJSVZhI=;
        b=QemS3/INquvyIFqY3KJVWCnjpntvw/bzYZgduv8UGSW6WuK3v+AQrFckJ2HAgZwylb
         sUu8W7hXhUEtO3V6zTvdSVzOp292yhLT4gIX75S+zsTQbcbF/zWpFy8vZNAPQFw42jSy
         peQ1FdQNLZWq4mJ2GSsBVtbKWnQDCCLbVYDObTcBrSZvdjtNOKQDghre7OchhAwZzUP+
         9iX2G3AhLi1FJ75EizpvHUJUZ3g/i2RBJrUHLMr0Wx4Uof56p6G6O5trKu80MTt1RQKw
         Vks+GCu85R1Vp+uL+wKzszoEFC9ukIGMBEcRMiktB2WODGD/ynJdgY7pef3w5R7elmH9
         jGfA==
X-Gm-Message-State: APjAAAVJ/32sjjgwrY2s0F9JW83/jSrltKHmOP2m+J9LvgMpGovgP8xP
        LqAIaYJUQohiBCxE2fQjlsfQS/MkqhsZ8gSSiw7Y
X-Google-Smtp-Source: APXvYqwPxe9J1nnLwFosLrwcJP/4GxCXTPfjhWBB49efJrK3JRIInVg2Nv3OhkEwQDQZpcsmj4x0zea0gudCylN7k9gQ
X-Received: by 2002:a63:cf46:: with SMTP id b6mr778011pgj.90.1571960974444;
 Thu, 24 Oct 2019 16:49:34 -0700 (PDT)
Date:   Thu, 24 Oct 2019 16:49:31 -0700
In-Reply-To: <20191018044103.GA17625@sigill.intra.peff.net>
Message-Id: <20191024234931.44192-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20191018044103.GA17625@sigill.intra.peff.net>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: Re: [PATCH 0/23] parsing and fsck cleanups
From:   Jonathan Tan <jonathantanmy@google.com>
To:     peff@peff.net
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've looked at the rest of the patch set and I think that this set is
worth taking.

>     This a string of refactors that ends up with all of the
>     type-specific fsck functions not getting an object struct at all.
>     My goal there was two-fold:
> 
>        - it makes it harder to introduce weirdness like we saw in
> 	 patches 5-8.
> 
>        - it _could_ make things less awkward for callers like index-pack
> 	 which don't necessarily have object structs. And at the end, we
> 	 basically have an fsck_object() that doesn't need an object
> 	 struct. But index-pack still calls fsck_walk(), which does (and
> 	 which relies on the parsed values to traverse). It's not
> 	 entirely clear to me whether index-pack needs to be doing
> 	 fsck_walk() in the first place, or if it should be relying on
> 	 the usual connectivity check.
> 
> 	 So I'm undecided whether this is worth taking on its own, or if
> 	 trying to avoid object structs in the fsck code is just a
> 	 fool's errand. I do think the result isn't too bad to look at,
> 	 though and there are some minor improvements along the way
> 	 (e.g., patch 17 is able to drop some awkwardness).

If we can partially avoid object structs in the fsck code, I think
that's an improvement too.
