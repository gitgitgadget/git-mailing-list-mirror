Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 693CBC433B4
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 10:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34D296124B
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 10:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbhDOKA5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Apr 2021 06:00:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:53224 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229481AbhDOKA4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Apr 2021 06:00:56 -0400
Received: (qmail 10304 invoked by uid 109); 15 Apr 2021 10:00:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 15 Apr 2021 10:00:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14843 invoked by uid 111); 15 Apr 2021 10:00:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 15 Apr 2021 06:00:34 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 15 Apr 2021 06:00:32 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v2 2/3] api docs: document BUG() in api-error-handling.txt
Message-ID: <YHgOwB1Pp2Z+LIPh@coredump.intra.peff.net>
References: <cover-0.5-00000000000-20210328T022343Z-avarab@gmail.com>
 <cover-0.3-00000000000-20210413T090603Z-avarab@gmail.com>
 <patch-2.3-ce78c79c9ac-20210413T090603Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-2.3-ce78c79c9ac-20210413T090603Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 13, 2021 at 11:08:20AM +0200, Ævar Arnfjörð Bjarmason wrote:

> When the BUG() function was added in d8193743e08 (usage.c: add BUG()
> function, 2017-05-12) these docs added in 1f23cfe0ef5 (doc: document
> error handling functions and conventions, 2014-12-03) were not
> updated. Let's do that.

Wow, I had no idea this file even existed (most of the time I looked at
technical/api-* the contents were along the lines of "somebody should
write this").

IMHO this is more evidence that this stuff should just go into header
files, where people are more likely to see and update it.

> diff --git a/Documentation/technical/api-error-handling.txt b/Documentation/technical/api-error-handling.txt
> index ceeedd485c9..71486abb2f0 100644
> --- a/Documentation/technical/api-error-handling.txt
> +++ b/Documentation/technical/api-error-handling.txt
> @@ -1,8 +1,11 @@
>  Error reporting in git
>  ======================
>  
> -`die`, `usage`, `error`, and `warning` report errors of various
> -kinds.
> +`BUG`, `die`, `usage`, `error`, and `warning` report errors of
> +various kinds.
> +
> +- `BUG` is for failed internal assertions that should never happen,
> +  i.e. a bug in git itself.

Your change looks obviously correct, of course.

-Peff
