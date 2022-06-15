Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F90C433EF
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 01:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345575AbiFOBzO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jun 2022 21:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344884AbiFOBzM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jun 2022 21:55:12 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7ED4BBB6
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 18:55:10 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id x75so7752148qkb.12
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 18:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2k+GTeLwrD5hAvMXTYO43ox+t9xqom+QNILcGHIQPzM=;
        b=tBNFuawLw6kPQL5XR+xIjdJlAv+JHmsomWSvB8i+/+jpifh9zafpDLXynPIg37Hdh2
         raumdzWebT4TjU0foVd2vkrGvUydxxYSImh7NHlPSWKjwTDmrRe0NeXaIIhohGjRztIZ
         8N4T9hLF/ky/nxg50OY6TGddlOIV/WN2zQ6RU8BdGh6P7Aa+zCqUlfRwHmTwgXpLKZHD
         WGk49JgX/e6o2HvfvDwUEMPtYLz9iN7vFpuO4sQ1qlUyvxItKXTC9SpI3IBjRbkF/IZS
         KxX8K9+UdcoKcarHQbYET9HzK23MqafUxiZ21w0NwzCIpBYC4z79ykwfuOavsodA0nHV
         xTfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2k+GTeLwrD5hAvMXTYO43ox+t9xqom+QNILcGHIQPzM=;
        b=fD7qHimGsGFkmKqAQhig3YjJT2iwNS+w1qGWUANRy02o9bgiX/o15TB+1YjPGL9eRr
         rH+tLlKen23ARl6KuY4L38ai9bIW+zAMzRIhhl6EXgb43XUQv65CpqYH5N7kj7jQ+RIF
         HwGoP0/snmLhvlAxl2iqHnK4w9OKgQXSHOucODy7XigG2tK2UFIovhKzdT6Y79MSH5a8
         Y/aJgi+ipYKF2FjAIUK5Nu7eQPlyoWF8Zps9KmrCretnPSIJdVr85Le1TUVOMGzq/p+/
         jdXK293Tv1+bGcYyQgAhablMBZYuX0Et9Src8ckZ6AQ+GKEzDwvej1cyCPzYvaYWyufQ
         qe2g==
X-Gm-Message-State: AOAM530EVTHuNMVrNRo9S1ax99Epjd6REo+BcqVVz0x1tafK+76GgPEU
        55VQX2D5qR1Oek8bQ2NxoxufEPO7oHkI8rRS
X-Google-Smtp-Source: ABdhPJzRistPcOOfhhdIz22w8tX3IKvJUDD3jtqZY9bx+z26z1jtUWuN4Uw9z13FwFn/Qmvf6rBinw==
X-Received: by 2002:a05:620a:12e6:b0:6a6:a5b9:1c57 with SMTP id f6-20020a05620a12e600b006a6a5b91c57mr6379106qkl.393.1655258109885;
        Tue, 14 Jun 2022 18:55:09 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c7-20020a05620a268700b006a6f57fe2e1sm11075974qkp.98.2022.06.14.18.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 18:55:09 -0700 (PDT)
Date:   Tue, 14 Jun 2022 21:55:08 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Michael J Gruber <git@grubix.eu>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] t3701: two subtests are fixed
Message-ID: <Yqk7/HXsrqYK/2QR@nand.local>
References: <cf6aee9acadfb666de6b24b9ed63e1a65bfc009e.1655220242.git.git@grubix.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cf6aee9acadfb666de6b24b9ed63e1a65bfc009e.1655220242.git.git@grubix.eu>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 14, 2022 at 05:26:33PM +0200, Michael J Gruber wrote:
> 0527ccb1b5 ("add -i: default to the built-in implementation", 2021-11-30)
> switched to the implementation which fixed to subtest. Mark them as
> expect_success now.

Since v2.37.0-rc0 is the first tag to contain 0527ccb1b5, I bisected
between v2.36 (when these two tests indeed failed) and the tip of
master (8168d5e9c2 (Git 2.37-rc0, 2022-06-13) at the time of writing).

And I also got 0527ccb1b5, so the bisection looks good to me, and this
was likely an oversight when 0527ccb1b5 was written. Thanks for putting
the author on the CC list just in case there is any additional context.

Otherwise, this patch looks good to me.

Thanks,
Taylor
