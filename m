Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D3CD207BD
	for <e@80x24.org>; Thu, 20 Apr 2017 22:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S947935AbdDTWWP (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 18:22:15 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:34511 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S947921AbdDTWWN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 18:22:13 -0400
Received: by mail-io0-f170.google.com with SMTP id a103so90602178ioj.1
        for <git@vger.kernel.org>; Thu, 20 Apr 2017 15:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=2MXqr0WkCIFHslp0GfkFkRaPYrJ1b4cuiXIji+y7wGI=;
        b=QeTzoqDVZqqNkIgzXlNmK4lgcWTMWk9OCtFyVThagtaoim3NHnP6MJKNVHYTQd99Vg
         nmfQXddTWqKsfG5ciEeD/EmMOjEmwEh+0oh88hTwD87QXQnMNzGIkfb4fbbcCGtileGc
         /TDdnPj+GO+G/5K2Q1WQSHnwAMY7prdo/72GMK7Dt1DfmTNGyzCPUbwbhjT3XKXCYJdZ
         hMnfWJEWJvX7P4I1FaCYWi9dwKiNRrc4j8gWI+lv40zRreEFBBMIOKetgf8SSYT/2qC1
         Y5g+HLer41mOfV+nZHPe6CkmjwbGzhd/sc5iYCe6CDP2w5/W4FqvggjUKgiGXEdhD9/u
         O/4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=2MXqr0WkCIFHslp0GfkFkRaPYrJ1b4cuiXIji+y7wGI=;
        b=gJBS85fOEVwxlGYYqXvmqu3+oSNJXjvOUt0gXGyzEHGPl007b5AB6fr+IWfdPinsWk
         tzRlTEEmc47RpJ3HaaOq82+9Yb7Orz8uHMBx/XNXvsKaNzX+xhRQO4tI70bKljWjIQou
         hWsWoenIu8ljMYj2UKKh9ZSV3j6AAoVHrNzo8VmbPQXtlJ7Kay98wd4dsGwQCzBWC4yD
         q0JNQcJ8/rWbF8VswevYktR6EBNz8qFCmLbVVNCC3wAuYwEzgwK7zBeeSJ3laZxUUPPJ
         tAjZdZCoa2CjOKd8PzUomsSs8O7x+LrhunBu7adaqOxXMclRUffnn92/r1vsWE9w7F0L
         Hnfg==
X-Gm-Message-State: AN3rC/5PrC4M+ntWLCtkgAX2Rpj7ftGH4aCZiCIKdgfhtjOa3ToD8ezu
        L1SbilkTQNxBGMZbv/MkgA==
X-Received: by 10.98.64.199 with SMTP id f68mr9496256pfd.123.1492726931871;
        Thu, 20 Apr 2017 15:22:11 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:6c7e:3273:2d37:5651])
        by smtp.gmail.com with ESMTPSA id 29sm12227789pfo.9.2017.04.20.15.22.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 20 Apr 2017 15:22:10 -0700 (PDT)
Date:   Thu, 20 Apr 2017 15:22:09 -0700
From:   Brandon Williams <bmwill@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Jeffrey Walton <noloader@gmail.com>,
        =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Fredrik Kuivinen <frekui@gmail.com>,
        =?iso-8859-1?Q?Zolt=E1n?= Herczeg <hzmester@freemail.hu>
Subject: Re: [PATCH v3 01/18] grep: amend submodule recursion test in
 preparation for rx engine testing
Message-ID: <20170420222209.GK142567@google.com>
References: <20170420212345.7408-1-avarab@gmail.com>
 <20170420212345.7408-2-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170420212345.7408-2-avarab@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/20, Ævar Arnfjörð Bjarmason wrote:
> Amend the submodule recursion test added in commit 0281e487fd ("grep:
> optionally recurse into submodules", 2016-12-16) to prepare it for
> subsequent tests of whether it passes along the grep.patternType to
> the submodule greps.
> 
> This is just the result of searching & replacing:
> 
>     foobar -> (1|2)d(3|4)
>     foo    -> (1|2)
>     bar    -> (3|4)
> 
> Currently there's no tests for whether e.g. -P or -E is correctly
> passed along, tests for that will be added in a follow-up change, but
> first add content to the tests which will match differently under
> different regex engines.
> 
> Reuse the pattern established in an earlier commit of mine in this
> series ("log: add exhaustive tests for pattern style options &
> config", 2017-04-07). The pattern "(.|.)[\d]" will match this content
> differently under fixed/basic/extended & perl.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

Looks good.

-- 
Brandon Williams
