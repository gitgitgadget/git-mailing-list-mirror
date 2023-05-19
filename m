Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 344C6C7EE26
	for <git@archiver.kernel.org>; Fri, 19 May 2023 17:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjESRtN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 May 2023 13:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjESRtM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 May 2023 13:49:12 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11F293
        for <git@vger.kernel.org>; Fri, 19 May 2023 10:49:10 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 28111CA1262;
        Fri, 19 May 2023 13:49:10 -0400 (EDT)
Received: from [IPV6:2600:1700:840:e768:537:3c3a:85ed:e4ec] (unknown [IPv6:2600:1700:840:e768:537:3c3a:85ed:e4ec])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id E92A0CC83AF;
        Fri, 19 May 2023 13:49:09 -0400 (EDT)
Message-ID: <7778a454-fefd-5b8a-212b-ab46681ccfd4@jeffhostetler.com>
Date:   Fri, 19 May 2023 13:49:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: Which macOS versions does Git support?
Content-Language: en-US
To:     Jeff King <peff@peff.net>, M Hickford <mirth.hickford@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Git Mailing List <git@vger.kernel.org>
References: <CAGJzqsnS3SnoW__aPQ+13s+-b3a+makCjWxR=z6mjgBBnuKjLg@mail.gmail.com>
 <20230519090917.GB3515410@coredump.intra.peff.net>
From:   Jeff Hostetler <git@jeffhostetler.com>
In-Reply-To: <20230519090917.GB3515410@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/19/23 5:09 AM, Jeff King wrote:
> On Fri, May 19, 2023 at 08:00:00AM +0100, M Hickford wrote:
> 
>> Hi. Does anyone know which macOS versions are supported by Git?
> 
> I don't think we have any formal decision here (or for any other
> platform; it is usually a cost/benefit for individual features we may
> want to depend on).
> 
>> Motivation: I spotted that git-credential-osxkeychain.c uses a
>> deprecated API. SecKeychainAddInternetPassword was deprecated in
>> 2014's macOS 10.10 [1].  Replacement SecItemAdd was introduced in
>> 2009's macOS 10.6 [2].
> 
> +cc Taylor, who I know was looking into this recently.
> 
> I'd guess that anything older than 2009 is probably not worth worrying
> about.
> 
>> Further motivation: If I understand the documentation correctly, the
>> new SecItemAdd API has better support for storing attributes alongside
>> secrets, which might be handy for storing Git credential's new
>> password_expiry_utc attribute (d208bfd, credential: new attribute
>> password_expiry_utc, 2023-02-18).
> 
> Yeah, that would be a nice bonus (in addition to avoiding a deprecated
> interface).
> 
> -Peff

I had similar issues last year with older versions of the compiler
tools and/or an API that I was using in FSMonitor.

https://lore.kernel.org/git/xmqqsfhtphpl.fsf@gitster.g/T/
https://lore.kernel.org/git/pull.1375.git.1665085395.gitgitgadget@gmail.com/

IIRC my API usage needs 10.6 or newer.

Jeff
