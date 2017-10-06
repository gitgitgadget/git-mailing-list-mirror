Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 949D520372
	for <e@80x24.org>; Fri,  6 Oct 2017 20:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752458AbdJFUVM (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 16:21:12 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:37177 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751618AbdJFUVL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 16:21:11 -0400
Received: by mail-pf0-f194.google.com with SMTP id e69so17578376pfg.4
        for <git@vger.kernel.org>; Fri, 06 Oct 2017 13:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RS33Mx6fccpU9DjR2UCDR44fIe3l/xwOEDlSo5DodeU=;
        b=tOGWQIu/qhVbhlhTlfPUBNJVFQNXiM7jXnANVwZkjx34+FzyfUqL/5PEVqUoTP0K8p
         y5q0NxAH+xqoGxr61/EGicLarXfncwUDNCzu5uMpx3pgO2vSqGmnZbLz1jwYz+kMrJ0u
         mO1d3O5VgIzODOQxrOiac7JxgGzufkxHSC/ncJ1iNfewrtcrDVZ+T2kRCksmWDnhVkmf
         qmeax/1xguTmJXOoIN3+uBprn8QgFWCB7bUOGlyui4bFiV9ew9uIOy77gzylCPYMuw34
         XzfxiKeDjMpvRI8KQ8/1yZRIB7HcwrUdughqsj20TxBGr/FdjnqxUIzYfUe6Cm/SvuR3
         06pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RS33Mx6fccpU9DjR2UCDR44fIe3l/xwOEDlSo5DodeU=;
        b=sN9zm7Tw1tHB89rZfg2yzDD2evclysOWbn6ZE43b+FO9FdF7UyhfhffqWPRgGgQBeN
         8tCi2FDfh+dpWv1qX2+bMcL3x6BnuAoBREoCgIamGrH1+9VeiHlReBE6s9+W3tDVeReM
         3WkOnyTrwJX11ZdZ2VJFZzN+IH9qwzIFQmIqyKrER/3Ty3nHWxPAJH1lUZaI1gKShrnb
         Ory8r9IvImsfWgmfsR/C5w9Fx/nTjmQQavSVtFD5DzTFCHpz7oMQBXuN6wPOpxm6wk7N
         1yuSMLO3t30GAPyiuOaQyI2u6A14Mt0Yu8KcKde0uTYNrojeHyLqqptSKdL5Lemt8+2r
         D+4w==
X-Gm-Message-State: AMCzsaXWq5/SqJ9UQPmvAqMe5GfuybweWDguebBpnV572VCRSP5/Q891
        iUaXBGafTEFy20k7QHzB4Y9ouuQl
X-Google-Smtp-Source: AOwi7QA39x8wwBi9lT41Oqp5ab6mGLvSe+9tuNR92Vww8KY1vmfNvMD3xMSTwnfqWV2jfF90iDqz1g==
X-Received: by 10.99.104.6 with SMTP id d6mr2950440pgc.168.1507321270825;
        Fri, 06 Oct 2017 13:21:10 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:78c3:3d0d:a9b5:4320])
        by smtp.gmail.com with ESMTPSA id j6sm4148159pgn.68.2017.10.06.13.21.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 06 Oct 2017 13:21:10 -0700 (PDT)
Date:   Fri, 6 Oct 2017 13:21:08 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] tests: use shell negation instead of test_must_fail
 for test_cmp
Message-ID: <20171006202108.GX19555@aiede.mtv.corp.google.com>
References: <20171006190006.19623-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171006190006.19623-1-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller wrote:

> The `test_must_fail` should only be used to indicate a git command is
> failing. `test_cmp` is not a git command, such that it doesn't need the
> special treatment of `test_must_fail` (which e.g. includes checking for
> segfault).
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  t/t3504-cherry-pick-rerere.sh         | 2 +-
>  t/t5512-ls-remote.sh                  | 2 +-
>  t/t5612-clone-refspec.sh              | 2 +-
>  t/t7508-status.sh                     | 2 +-
>  t/t9164-git-svn-dcommit-concurrent.sh | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)

Thanks.  I agree that this is more readable, and it matches the advice
in t/README:

   On the other hand, don't use test_must_fail for running regular
   platform commands; just use '! cmd'.  We are not in the business
   of verifying that the world given to us sanely works.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

I wonder if it would be useful to have a nod to that advice in the
docstring in t/test-lib-functions.sh, too.
