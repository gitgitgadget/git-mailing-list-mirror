Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CDED20966
	for <e@80x24.org>; Wed,  5 Apr 2017 18:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933644AbdDESlZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Apr 2017 14:41:25 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36290 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932913AbdDESlX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2017 14:41:23 -0400
Received: by mail-pg0-f67.google.com with SMTP id 81so3085867pgh.3
        for <git@vger.kernel.org>; Wed, 05 Apr 2017 11:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VElrG2zuZRlFDChEjidNxqKmJl9EfswSlcqkDVcxRjU=;
        b=Ru36K+dw+/lgHHPYvJLS5V4tcIGsoRQjCnF70vZ906GG/vzbE2q+l4R5zXXhZNCIP8
         azKW1w1+WH3CVIq5AIz6lbhVw2HdKNDhnfUMZDzDY4RIr86RpCR6YGDOfqC64lBcYHcP
         0YKDVemRGvXcV75rzCksK2jEVr9h28eSzGEBWM+TTUuNY0Z7os2o2CEyRa+XMmXFCk4n
         tRDa5v/Pb1FDbS0cbbHaF4ieaEuOI2eZFXU8OA3XqtzscACRYYuANuensf5o5jDuxCL/
         6Qnm69zKYIOzRlE20U9eXtX+eq7iyM6tZY9agyy9vZkBoMCMJqmr766+Dye0ytzks8lW
         Pzcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VElrG2zuZRlFDChEjidNxqKmJl9EfswSlcqkDVcxRjU=;
        b=B2p1SlB+DCzcrGMrG4CYr7rzBlEU3HzZoXi4nVmpeJHcEuSvV57ibyKcMA5OxhPKvM
         0HpTpiw0pR+ZxmJa7mN5jtdq/4W3YwfEjMhUkUQZzfIOmOU8FX0SYHTBXgXKe893A5f7
         eLokoCOMyHZdauf7L0+0UXDAj7fnW/JGL8boP+81IzCke8TIo/QmrTGMFQIP1QIiL7Uy
         LZ1sLK0riBWIq0810WgPZe5bj2Zq2aRt24boZl5fMbfNm2kTCUKWnf4h07hMj4+B3t59
         AbpK8O5x29oO3toLtYhQcVPl0WCr3uZAS7n/GyNk0pTWGvWB+eojQJt9q/VlI7E1Ejyk
         oWmQ==
X-Gm-Message-State: AFeK/H0zE/XRoZsLcXkfujo2/JEvSkKcNQw/JYC2kP7Fs2v4MI3J/tuofOVQELuiPaWsAw==
X-Received: by 10.99.55.85 with SMTP id g21mr31833000pgn.62.1491417682486;
        Wed, 05 Apr 2017 11:41:22 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:55a8:b4cb:debd:758b])
        by smtp.gmail.com with ESMTPSA id y65sm32156713pfd.82.2017.04.05.11.41.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 05 Apr 2017 11:41:21 -0700 (PDT)
Date:   Wed, 5 Apr 2017 11:41:19 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@jeffhostetler.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v6] read-cache: force_verify_index_checksum
Message-ID: <20170405184119.GF8741@aiede.mtv.corp.google.com>
References: <20170405180625.12439-1-git@jeffhostetler.com>
 <20170405180625.12439-2-git@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170405180625.12439-2-git@jeffhostetler.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

git@jeffhostetler.com wrote:

> --- a/t/t1450-fsck.sh
> +++ b/t/t1450-fsck.sh
> @@ -689,4 +689,17 @@ test_expect_success 'bogus head does not fallback to all heads' '
>  	! grep $blob out
>  '
>  
> +test_expect_success 'detect corrupt index file in fsck' '
> +	cp .git/index .git/index.backup &&
> +	test_when_finished "mv .git/index.backup .git/index" &&
> +	echo zzzzzzzz >zzzzzzzz &&
> +	test_when_finished "rm zzzzzzzz" &&
> +	git add zzzzzzzz &&
> +	sed -e "s/zzzzzzzz/yyyyyyyy/" .git/index >.git/index.yyy &&
> +	rm .git/index &&
> +	mv .git/index.yyy .git/index &&

Why is the "rm" before "mv" needed?  I would have expected "mv" to
replace the file.

If that doesn't work, I expect there are a large number of other tests
that would need fixing...

> +	test_when_finished "rm .git/index" &&

Likewise --- this seems redundant next to the "mv" enqueued previously.

> +	test_must_fail git fsck --cache

That said,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
