Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93DA32047F
	for <e@80x24.org>; Tue, 19 Sep 2017 20:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751503AbdISUn6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 16:43:58 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33089 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751370AbdISUn5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2017 16:43:57 -0400
Received: by mail-pg0-f68.google.com with SMTP id i130so426534pgc.0
        for <git@vger.kernel.org>; Tue, 19 Sep 2017 13:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5Z6V0HfnEukSyNM7JX8JykvVfhG/7BNmiablfOKQ4EA=;
        b=udpEqvfkC+Aw/QVqCD9jPZ0Ws2YeORnyQa8BEbOXNTgUw3w7xlLAlPqsiGQ/kU4shE
         WWsY+F29G/4P5ms9w6UUGWZiWvbrLq6BSHNJCdjx+1ei/QBK7MUM86jT1ZeDx+EEDUGy
         5D3XkBolGUbYr6rI/3ErmXkGHWYov3IWzfWuZZpyaiduvw/yrs8IVo9MqUw/tkjlzvL6
         H4qpi5fqaAwGjrTTv+R1BRCVe1jEXcJl/9kNIh82pxcv/hVJH2zsc4ID2gbL608j/7Qp
         S0ORasb3k1AM1cb6gLbzH/DhMz40mhhZM9IRX5rKchaOkcUM4JuJ6+kb1Q4pSolTeMGh
         5isA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5Z6V0HfnEukSyNM7JX8JykvVfhG/7BNmiablfOKQ4EA=;
        b=PWpZccWSlVycpd2reb1xtKlm3uF+qLzlIPmx5u2BeIxivLKEvCtDZT/HXN3X2NqW0D
         BJdJ1W9xf+3OCkXbGWjJT5CRuElXxpBnvoAj9PknbUFdytOzdCQKQALj7wBl9Oh302pX
         jZMKQTr2UCg2g47TR0UmywWryUdaP54hlozft+tRN0iVg5QkvYEHG0ImPl9jqVNQ7b6S
         wShsOYKiPGhx/WRkEPWus6ShNtyTLl2u80lGCjqHPt+v1yXsj4QHYM05txOGjeClPfm4
         PjYAaI7cDLt3BgY8AhS+F2AdFcNY/4HY1xKR/KMOhKJPPy+zRBF0ZVuHP6t0cERITI8w
         sbIA==
X-Gm-Message-State: AHPjjUiirz9JedFKbZ9WOcr3TbG/K0FJeBV0wHfFbKoyC0n0uc6+U8KE
        JC/GDY7A8SVYtx7/g/pFXtQAbGth
X-Google-Smtp-Source: AOwi7QAYj47kuO/pRy/OGrXuYyRz3LKfzU5ZZFPu81WmWsKqx87HeP9G5oOTJW241+A4nI5g3/7NIQ==
X-Received: by 10.99.117.30 with SMTP id q30mr2412175pgc.75.1505853836857;
        Tue, 19 Sep 2017 13:43:56 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:ed67:93b4:3411:bf26])
        by smtp.gmail.com with ESMTPSA id f3sm6635223pfd.82.2017.09.19.13.43.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 19 Sep 2017 13:43:56 -0700 (PDT)
Date:   Tue, 19 Sep 2017 13:43:54 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Ben Peart <benpeart@microsoft.com>
Cc:     David.Turner@twosigma.com, avarab@gmail.com,
        christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        johannes.schindelin@gmx.de, pclouds@gmail.com, peff@peff.net
Subject: Re: [PATCH v6 09/12] split-index: disable the fsmonitor extension
 when running the split index test
Message-ID: <20170919204354.GG75068@aiede.mtv.corp.google.com>
References: <20170610134026.104552-1-benpeart@microsoft.com>
 <20170915192043.4516-1-benpeart@microsoft.com>
 <20170915192043.4516-10-benpeart@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170915192043.4516-10-benpeart@microsoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Ben Peart wrote:

> The split index test t1700-split-index.sh has hard coded SHA values for
> the index.  Currently it supports index V4 and V3 but assumes there are
> no index extensions loaded.
>
> When manually forcing the fsmonitor extension to be turned on when
> running the test suite, the SHA values no longer match which causes the
> test to fail.
>
> The potential matrix of index extensions and index versions can is quite
> large so instead disable the extension before attempting to run the test.

Thanks for finding and diagnosing this problem.

This feels to me like the wrong fix.  Wouldn't it be better for the
test not to depend on the precise object ids?  See the "Tips for
Writing Tests" section in t/README:

	                                                         And
	such drastic changes to the core GIT that even changes these
	otherwise supposedly stable object IDs should be accompanied by
	an update to t0000-basic.sh.

	However, other tests that simply rely on basic parts of the core
	GIT working properly should not have that level of intimate
	knowledge of the core GIT internals.  If all the test scripts
	hardcoded the object IDs like t0000-basic.sh does, that defeats
	the purpose of t0000-basic.sh, which is to isolate that level of
	validation in one place.  Your test also ends up needing
	updating when such a change to the internal happens, so do _not_
	do it and leave the low level of validation to t0000-basic.sh.

Worse, t1700-split-index.sh doesn't explain where the object ids it
uses comes from so it is not even obvious to a casual reader like me
how to fix it.

See t/diff-lib.sh for some examples of one way to avoid depending on
the object id computation.  Another way that is often preferable is to
come up with commands to compute the expected hash values, like
$(git rev-parse HEAD^{tree}), and use those instead of hard-coded
values.

Thanks and hope that helps,
Jonathan
