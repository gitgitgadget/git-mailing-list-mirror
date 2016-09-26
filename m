Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD,URI_HEX shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48AC8207EC
	for <e@80x24.org>; Mon, 26 Sep 2016 19:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934845AbcIZTjn (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 15:39:43 -0400
Received: from mail-it0-f52.google.com ([209.85.214.52]:37078 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751962AbcIZTjm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 15:39:42 -0400
Received: by mail-it0-f52.google.com with SMTP id j69so54909573itb.0
        for <git@vger.kernel.org>; Mon, 26 Sep 2016 12:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ghkT54B9BzrftULPGCFJY2lUdG9J6rDIOdSGUXLhleU=;
        b=pWY6HztlzH9+9EKUrjXyYHF4ukIX4YQmLPiNP8tS+mJKVgGETBitUrTa0b3WgJJXdn
         7VkljQkoPtHgrrrCfHkzyHliYsKqE4yUx9y1BnDlsNq3Tlt7jPdLRa7UPL2RM7Apy6jM
         B9alqBND6sLtglcjaMHTxt9zxTtZ2vmllaYlX1AHzykmDhF8CZMag5qP7wg7TxGJaQwa
         VUpD2kNzNhQnLwiznZuulRgGPDE4aZMfE/79UsZjX7q5CehrTQlOHMG8Ra8e8xvwG0Q2
         FXSdiatS0Y7EF0X5J2KjYVk08+w3Oq1VfAklnWZI1R74wdb4r90S4XCad/9vbGkGIyHx
         W9oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ghkT54B9BzrftULPGCFJY2lUdG9J6rDIOdSGUXLhleU=;
        b=Rn8RE/UeWMS85SNdr77kTF+n7fQ3DK8Xfxtr5jonH0SwcV8dBn95+t67DAxZY8pPgu
         Zt77nakgZUFxMFekSsWzMkvHVobMshvLOKxveot4/X3fCkh/fA5zXHHRjWcjdbuN14qd
         2bVeDTeZCcoGJgzqnJNDGugGbkZ23v6AQRJeP6Gk5U+tu7THYF8RX3mHFpdUaUn/3faC
         +CMJfUiNTDClF86iVKLXC9GHUrMa9ehAbmhJDsMM3QZ7nMxAxXqmyiADGc/tHvD4a96I
         yQErJpDRVJLVN09bLZIZZBo2KQXa+tyN6WH1fhH6O35g4vSN9nSnKaCOsw2o6FhJhiJb
         xeAw==
X-Gm-Message-State: AA6/9Rmk5G8t+uKY7Qd7/keKGLdatsEygK2rLAsws1yDY/uohp1BVLyxjVeqvQKnDdSjDrIraGfXTJOr4FV/r1Ph
X-Received: by 10.36.73.215 with SMTP id e84mr18724756itd.33.1474918780934;
 Mon, 26 Sep 2016 12:39:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.173.98 with HTTP; Mon, 26 Sep 2016 12:39:40 -0700 (PDT)
In-Reply-To: <1474918365-10937-1-git-send-email-novalis@novalis.org>
References: <1474918365-10937-1-git-send-email-novalis@novalis.org>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 26 Sep 2016 12:39:40 -0700
Message-ID: <CAGZ79kY6W5jDP9YJz4Vr7OK9yFhbBM2h9wpgFLx_Ug+bTocn+g@mail.gmail.com>
Subject: Re: [PATCH 0/2] tree-walk improvements
To:     David Turner <novalis@novalis.org>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 26, 2016 at 12:32 PM, David Turner <novalis@novalis.org> wrote:
> The first patch is a re-roll of Peff's patch from 2014 -- here's
> the archive message:
>
> http://git.661346.n2.nabble.com/PATCH-tree-walk-be-more-specific-about-corrupt-tree-errors-td7603558.html
>
> Not sure why this wasn't applied then, but I thought it looked pretty
> good, so I added a few tests.
>
> Hopefully the encoding works correctly on these patches. If not, you
> can fetch from
> https://github.com/novalis/git/
> on branch dturner/bad-trees
>
> Email address note 1: my employer wants me to use my company address,
> but not my company computer, for patches I write on work time.  This
> means that I'm going to continue corresponding from
> novalis@novalis.org, but will send patches with the @twosigma.com
> address in the author line.

Mind sending a patch for .mailmap to reflect that different email
addresses are still the same person? ;)
