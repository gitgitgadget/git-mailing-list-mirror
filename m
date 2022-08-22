Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B41C32792
	for <git@archiver.kernel.org>; Mon, 22 Aug 2022 19:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238838AbiHVToG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 15:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238779AbiHVToD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 15:44:03 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF1A2CCA3
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 12:44:02 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id f14so8743205qkm.0
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 12:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=NWP1+csbBQEqgCxfKRLeObCZMofcOh4soPifCXjXAfw=;
        b=CP0n0LT6TuVAmikSWIHYLfG3LhH5ohXGdk4HrHxlpWD0SKNAUykd2EYjgAvdaF+09o
         IivVr7NSKZpq8IvlzlpXzpZEYxFK+/3ziAY3EjUyuSy2eSRfB43ht7UYTeZVa8VhP3tT
         062sFS93Uhwlb1X7h0sKNqb7J6wNFAWzgwXBC4Fla8glmy1Ww+5f8U/wJzlCUolMEZAM
         VeJBTNIcWrOtWdiBR7MC8SKC4PFaYD6h4GgWtexJnnGnBOG9NuIWjffdZcXuRzUVmSkm
         z2VyJM5mVIkNYxhFWvTVf8KLfPOt/GnQsToYZU99Sq/kP85Zc1AHRfTeJ9lAfUVsDn65
         f+iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=NWP1+csbBQEqgCxfKRLeObCZMofcOh4soPifCXjXAfw=;
        b=A2hO5SmTr5uVz5Qdq7ACkApyDh190OelihkdxPxmOikHkh+mIAppHbFA1fYBk4Gblv
         eDs5PeS+btrBn4YMtaCQRTAg5/79Zt58N4cbTBw1Mhpti+E7XvuowBzpJ1/osq09aMT+
         tw8ETxmT2QaZbKsvBUF/y5EXh5L3zo4nZRZBQiYOBsL0NleekAAGaQZR5JY/1l1oAh6K
         NvXS+Cy2H9DeSVUqNoWPqBOeCgDXzJ7qSqffNVpqBo043/R7cTkgWCTduMj+TAuLrHii
         m+D9GToj48XytdrMO9uPtogVrd/cFp2QPehh8ryAhIwwDG/LoFjjSJj6hbZ8SD4E+0u8
         l+cA==
X-Gm-Message-State: ACgBeo24qBAUhdZTQIChdWLaMIIQfhfcYZYWaOmxVEZLiZlWo8vSxWoQ
        nnzNhxHej9+SJ/bXrlB7VG4log==
X-Google-Smtp-Source: AA6agR5bOHjT3BMom8eo9D4osp+cK+3NnjKxCm3W9u3ncewns3507DyGO5jF/Sc6kVJqMUi2I/NRwA==
X-Received: by 2002:a05:620a:24d5:b0:6bb:bed6:18d3 with SMTP id m21-20020a05620a24d500b006bbbed618d3mr13098820qkn.271.1661197441668;
        Mon, 22 Aug 2022 12:44:01 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m9-20020a05620a24c900b006af0ce13499sm12211824qkn.115.2022.08.22.12.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 12:44:01 -0700 (PDT)
Date:   Mon, 22 Aug 2022 15:44:00 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de,
        chakrabortyabhradeep79@gmail.com, jonathantanmy@google.com,
        kaartic.sivaraam@gmail.com
Subject: Re: [PATCH 0/6] midx: permit changing the preferred pack when
 reusing the MIDX
Message-ID: <YwPcgIStTEelWJfK@nand.local>
References: <cover.1660944574.git.me@ttaylorr.com>
 <6c146fa9-48da-5f74-c91a-29c54e1da6ce@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6c146fa9-48da-5f74-c91a-29c54e1da6ce@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 22, 2022 at 01:04:29PM -0400, Derrick Stolee wrote:
> Thanks for putting this together. Definitely not an easy bug to find
> and fix.
>
> I mostly have nitpicks, but the overall structure is sound.

Thanks very much for reviewing (both to you and Abhradeep). I have a new
version that I'll send now, which incorporates your suggestions.

It also adds a new patch on top that takes a slight optimization, by
avoiding adding objects from the MIDX that show up in the (new)
preferred pack, since we know we'll discard them anyway.

Thanks,
Taylor
