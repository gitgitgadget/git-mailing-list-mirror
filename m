Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA4E11FF72
	for <e@80x24.org>; Tue, 24 Oct 2017 19:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751803AbdJXTCn (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Oct 2017 15:02:43 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:57103 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751354AbdJXTCj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Oct 2017 15:02:39 -0400
Received: by mail-wm0-f50.google.com with SMTP id z3so11317227wme.5
        for <git@vger.kernel.org>; Tue, 24 Oct 2017 12:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hRsqmasE1G+wWNTsj1HHewKpHgOxrneaxu+6yNKfGbM=;
        b=q+lObI+xLGKQskfrXBVrjGyNyYtqav/N3rdprySJDf6dvqCmHrTQVJ3xhYhuRV3yks
         ZFcBTWNWEG7gqfx1RRyVXzrOii6qfCUDb81yJHFvxlqLjS9kbQNPP8oe6RRAD8D8zN5t
         0VKt2aW5Yw4EnIjZciAnYBEmxsfxz9kEOVYkh1uGrpn6MtTT0SUNTsh6eu3cU85gXjyT
         Gq2LAM667cZ+RyzpXSzj+w3Xb/zCX4s7lP4eZuQSDwdOsKl1Mpl2F1tAhZdSc8Byq8Gi
         WFfQUPi4PZViH9kJA1knFTa/cH9+LL5KnvzY4KViWomVWDUJBUCm9j1J1spuTwuOCq7b
         NWkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hRsqmasE1G+wWNTsj1HHewKpHgOxrneaxu+6yNKfGbM=;
        b=hJ9zOvwvdgioo+Ie4gnaKfIMls4QuDn1vlNMMGppxscPXumD5yl8Cb0GERIdcSParH
         YWwB0hvnFA62pu+Vw0mKmlz6TYK5P2OVXKaTwwvTCU+S2lfFH28ZkLH3KicXpHW5A6qZ
         rWSg1IaOJBfpB0XSXyKqc954NKu6b0gXGyORuRzhUS2VqPw1zRqGaPFETMPbLNgECEJ3
         uB2nu3w2anXZO0686uk0yeNfCpr0vtPhycN0uVvhvr76oNFcNa7bVXyJrvHUJ2l7rFl7
         icUuzTrNIfBL0LfgyO8AdweQ3scbpy4KU/mjnq83ox38SIN1mWJDg7uv/LBGcwIAG6Um
         ynCw==
X-Gm-Message-State: AMCzsaWCP0S/UPyKGMQzHm9hyujd/JTp3R/Z7+X4uGAl5TntlnQg2r3K
        jDk4CLvTndbYpejyoLL7yngnYWZF6c8a65reJZpNHijK
X-Google-Smtp-Source: ABhQp+RcOYjKNex5p148M8l0mRHMD+LelM+QqEjzaxVOerNBu7WCk9xWaxx7a5QbJOGIkZ4KSrnaSw1M+3PVYyCvkWM=
X-Received: by 10.28.90.87 with SMTP id o84mr5965wmb.132.1508871757736; Tue,
 24 Oct 2017 12:02:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.195.125 with HTTP; Tue, 24 Oct 2017 12:02:37 -0700 (PDT)
In-Reply-To: <20171024185917.20515-1-sbeller@google.com>
References: <20171024185917.20515-1-sbeller@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 24 Oct 2017 12:02:37 -0700
Message-ID: <CAGZ79kZftQoP-Ht+VRakCZsQxh1tjfu=4DFJn_R6fiKD2MmzMA@mail.gmail.com>
Subject: Re: [PATCH 0/4] (x)diff cleanup: remove duplicate code
To:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 24, 2017 at 11:59 AM, Stefan Beller <sbeller@google.com> wrote:
> Junio wrote:
>
>>  * I was hoping that the next_byte() and string_hash() thing, once
>>    they are cleaned up, will eventually be shared with the xdiff/
>>    code at the lower layer, which needs to do pretty much the same
>>    in order to implement various whitespace ignoring options.  I am
>>    not sure how well the approach taken by the WIP patch meshes with
>>    the needs of the lower layer.
>
> This series does exactly this; although I chose to reuse the code in
> xdiff/xutils.c instead of the new fancy next_byte/string_hash, as that
> code has seen more exercise already (hence I assume it has fewer bugs
> if any as well as its performance implications are well understood).
>
> However to do so, we need to pollute xdiff/xutils.c and include
> hashmap.h there (which also requires cache.h as that header has
> an inline function using BUG()), which I find a bit unfortunate but
> worth the trade off of using better tested code.
>

This, of course, applies on top of jk/diff-color-moved-fix.
