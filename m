Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CF6CE7A88
	for <git@archiver.kernel.org>; Sat, 23 Sep 2023 06:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjIWGYX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Sep 2023 02:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjIWGYW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Sep 2023 02:24:22 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2E6199
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 23:24:16 -0700 (PDT)
Received: (qmail 9407 invoked by uid 109); 23 Sep 2023 06:24:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 23 Sep 2023 06:24:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24735 invoked by uid 111); 23 Sep 2023 06:24:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 23 Sep 2023 02:24:17 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 23 Sep 2023 02:24:15 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] test-lib: fix GIT_TEST_SANITIZE_LEAK_LOG
Message-ID: <20230923062415.GA1469941@coredump.intra.peff.net>
References: <68522960-edda-26d3-ddca-cee63f2d859e@gmail.com>
 <54253e98-10d5-55ef-a3ac-1f1a8cfcdec9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <54253e98-10d5-55ef-a3ac-1f1a8cfcdec9@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 22, 2023 at 10:38:06PM +0200, Rubén Justo wrote:

> [...]
> Let's add the missing conditions in the if-elses chain to make it work
> as expected.

Thanks, I think this explains the situation better than the original.

> +	elif test "$test_failure" = 0
> +	then
>  		say "With GIT_TEST_SANITIZE_LEAK_LOG=true our logs revealed a memory leak, exit non-zero!" &&
>  		invert_exit_code=t
> +	else
> +		say "With GIT_TEST_SANITIZE_LEAK_LOG=true our logs revealed a memory leak..."
>  	fi

OK, so you did add in the "else" here. :) I am obviously fine with that,
and the patch overall looks good to me.

-Peff
