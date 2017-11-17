Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE33B202AF
	for <e@80x24.org>; Fri, 17 Nov 2017 20:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161438AbdKQURb (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Nov 2017 15:17:31 -0500
Received: from mail-qk0-f170.google.com ([209.85.220.170]:36309 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161392AbdKQURY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Nov 2017 15:17:24 -0500
Received: by mail-qk0-f170.google.com with SMTP id o6so833035qkh.3
        for <git@vger.kernel.org>; Fri, 17 Nov 2017 12:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gJ//5K8RD4ezbKOY0e/lth+7ytdaDVJ1OTX/Sjr7Zas=;
        b=G0GyicEQ4beLQegQQo5WR72ekzALQnRmAZ0oeEyR1IFlF9dqqHHDw9AdnDE9QTfpN+
         8eP2U2si3faXUsCPqHjW4LTV/jZwrPpU02+3gE/H2QTCxup39+Z/uEB4ktIHpbkTvI5J
         PJWnoRczpmE83MsQGuMsYui0g+1WEeIXtBYgQvofb8QjoOJFH6oAMhe5z3UiZW/Zcrsx
         m+JKMSz923v5huBKj+RpGhgErJiW5qJwZEMRtnmYdNnjY+2eq5x2AOhG4xIxKPPQKgsU
         23V+DfnN954ihSW9Lc/JwqJeHWfjzodcqTAbQBGt0vRXSfsft+Mnl97QF3ExXZEFw81Z
         GuUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gJ//5K8RD4ezbKOY0e/lth+7ytdaDVJ1OTX/Sjr7Zas=;
        b=OA6w0fvdu7TZ8LlMsyUk0Q+WBTpdZELv+70N1Qu8f2MKL6ShAh2f8YEobNp2W1tdZM
         REbJVIA72OG74QuQBz3VTmo/8fUC6ngn2pJGWmc/mtmUYV53fJn51EiU5YGCvHvEv5nG
         /sYZBi5y1QZypTqrnrLJpmrAroE1ZaOIrAhoj/sJcZsbYz39dh/doIhbrOG8eQPfSa5j
         0B5leKB/edbrX7iJ++xVBxGvYkpMiJ15X1Q3MqlBoocWT4MOMl6yy7dmbDQWeuXUfyq8
         2FP4Vk0ss1cSUMS41gLrhkwOxX1KKBZGKka3Ss6SYmbA4+ClQHUv8MVFGBhX4sLGMg7w
         tWCw==
X-Gm-Message-State: AJaThX5hiFNiXa4wr6M/dUlxOP3Vn7TPuB9LmPN7BbOVglkZAsmKmMTM
        Mmc8oMZ9onGJelPsuPfYOP9Gkx0AjvK7VdVFAxX74w==
X-Google-Smtp-Source: AGs4zMYEvZPQAQyqaYl/dXxxILKi5o7/T3CykHw5yLZbLwpqMGIcbXxB55tcGzxnhqxTphw8Bhg0eZiwoYebCIFsY7o=
X-Received: by 10.55.124.198 with SMTP id x189mr10264526qkc.40.1510949843498;
 Fri, 17 Nov 2017 12:17:23 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.203 with HTTP; Fri, 17 Nov 2017 12:17:22 -0800 (PST)
In-Reply-To: <798096fe-dd01-5351-94d3-949039c84e69@jeffhostetler.com>
References: <20171116181257.61673-1-git@jeffhostetler.com> <20171116181257.61673-8-git@jeffhostetler.com>
 <e7b5e42f-b13c-50c8-501c-0100d8c48d00@ramsayjones.plus.com> <798096fe-dd01-5351-94d3-949039c84e69@jeffhostetler.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 17 Nov 2017 12:17:22 -0800
Message-ID: <CAGZ79kZCdxN8h-mJRY9fQy5W3HtqcvFoL1W5jVcb3=A3vvk_Ww@mail.gmail.com>
Subject: Re: [PATCH v4 07/10] introduce fetch-object: fetch one promisor object
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 17, 2017 at 11:49 AM, Jeff Hostetler <git@jeffhostetler.com> wrote:
>
>
> On 11/16/2017 2:57 PM, Ramsay Jones wrote:
>>
>>
>>
>> On 16/11/17 18:12, Jeff Hostetler wrote:
>>>
>>> From: Jonathan Tan <jonathantanmy@google.com>
>>>
>>> Introduce fetch-object, providing the ability to fetch one object from a
>>> promisor remote.
>
> [snip]
>>>
>>> +#include "transport.h"
>>
>>
>> I note that this still does not #include "fetch_object.h".
>> [If you recall, this suppresses a sparse warning].
>>
>
> Sorry, I missed that.  I know I did a DEVELOPER=1 build and
> I didn't see a warning, but I'll check again.

sparse is an extra tool, which you have to run/install;
it is not included in the developer build.

https://en.wikipedia.org/wiki/Sparse
