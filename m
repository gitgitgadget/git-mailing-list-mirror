Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 326C11FBB0
	for <e@80x24.org>; Thu,  8 Dec 2016 18:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752126AbcLHSVy (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 13:21:54 -0500
Received: from mail-qt0-f178.google.com ([209.85.216.178]:34699 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751674AbcLHSVx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 13:21:53 -0500
Received: by mail-qt0-f178.google.com with SMTP id n6so419846872qtd.1
        for <git@vger.kernel.org>; Thu, 08 Dec 2016 10:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ei6QfiYZyyBGWf+6X1hkjmSEqRrsbRslTct1Hja5wsY=;
        b=O6u6Gp1v5zV7baQEHNOFu1oaDrTWgab21bvL29yLG5r1pHfMFR69EWTVmombjeJDjC
         SLEhNk/yaH+VNn0Jd+ZOVGyWcimP2JFzmd2mHtCbQgj6jrHXVV9+nBIpZg5ivzsoQUDW
         vbWiZf/GYUgQylYDYQSWCThc6BtWGyZT+EQG5nVE0Y8aGQSg+SwPEc/xxIQJz2wdkubF
         mkCRiR+9nejMa+cTzcjcgxivGWZCz82ZlBJ0TjHE5VnWL9PfhJVgitnxzwOZMKp8Rb7I
         Y+1mKhtHV7FyK4gUlF+lPIYuk0lySIIBu9xsWddXcQNe+FmyHVvZeX3/lDa4S1jvVcZq
         v0aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ei6QfiYZyyBGWf+6X1hkjmSEqRrsbRslTct1Hja5wsY=;
        b=P3HN5caDbaWdBpeMQ7Wc035OUTsEe+NngBD65TNRRymZzJ6qtDxMfJnmACJObph4oG
         p/5dea5uIZQ0Y7gUpb6h9d8VlvSNZScRnCppT4gZ/6dX3Ht1TJGk08c93wPR6Wz1a0T2
         GQYANL7O8kAyo6RsfSxemxGCQrrv2bmPnlecqq05Pkmk0+ESSszRzPswJmxtIoec1mzc
         GEhQBsfk7IM+ld9VCzIDS74iiYXlBhN63RKPDuM+DVV0QzQPZHJARIdP8xr5Dqw4zk2a
         SsuyndsFqRqg8BZ2B6jldQcuR/9SC2pM5/L8tQM20Kq9lNcPDazFFufQ8VD58jLYFxqi
         46Cw==
X-Gm-Message-State: AKaTC01uemUDz4MwI4O/1MBBkELD9et6/ljdLlw5gAxAPlcYIohMTiNPevv/a9Oq2Ro2R0RX7pkBFgDVcQUqEm31
X-Received: by 10.200.53.9 with SMTP id y9mr64092786qtb.176.1481221312285;
 Thu, 08 Dec 2016 10:21:52 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.188 with HTTP; Thu, 8 Dec 2016 10:21:51 -0800 (PST)
In-Reply-To: <d445a6c3-5375-22cf-4f03-1717559f1157@gmail.com>
References: <20161208003940.28794-1-vi0oss@gmail.com> <CAGZ79kZU401JRp4EtwTGHzk3Zq+snQhX3GArDfF6SpKxsSwtWg@mail.gmail.com>
 <20161208174633.bsktiflql6jpn5t3@sigill.intra.peff.net> <d445a6c3-5375-22cf-4f03-1717559f1157@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 8 Dec 2016 10:21:51 -0800
Message-ID: <CAGZ79kZs4vy3-1jAxY+95CNRE2_YgTcBTsxR-Mg0xLqCp7UHcA@mail.gmail.com>
Subject: Re: [PATCH] submodule--helper: set alternateLocation for cloned submodules
To:     vi0oss <vi0oss@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Stefan Beller <stefanbeller@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 8, 2016 at 10:04 AM, vi0oss <vi0oss@gmail.com> wrote:
> On 12/08/2016 08:46 PM, Jeff King wrote:
>>
>> On Wed, Dec 07, 2016 at 05:22:30PM -0800, Stefan Beller wrote:
>>
>>> On Wed, Dec 7, 2016 at 4:39 PM,  <vi0oss@gmail.com> wrote:
>>>
>>>>      Previously test contained errorneous
>>>>      test_must_fail, which was masked by
>>>>      missing &&.
>>>
>>> I wonder if we could make either
>>> the test_must_fail intelligent to detect such a broken && call chain
>>> or the test_expect_success macro to see for those broken chains.
>>>
>>>
>>> I wish we could improve that, but I spend a lot of brain cycles on it at
>>> one point and couldn't come up with a workable solution.
>>>
>>> -Peff
>>>
> Why Git test use &&-chains instead of proper "set -e"?
>

"Because set -e kills the shell and we would want to keep going
until the test suite is finished and display a summary what failed"
would be my first reaction, but let's dig into history:
bb79af9d09 might be helpful on that, but it doesn't explain why
we use && chains.
I could not find any commit explaining the use of && chains.

e1970ce43abf might be interesting (the introduction of the test
suite), as that did not contain && chains.

I guess it would be hard(er) to implement e.g. test_must_fail
in an environment where -e is set.
