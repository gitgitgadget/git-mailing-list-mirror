Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E9EC433EF
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 19:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242341AbiCJTMP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 14:12:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238270AbiCJTMO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 14:12:14 -0500
Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3271965E4
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 11:11:13 -0800 (PST)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 4KDzDv30Rjz5tl9;
        Thu, 10 Mar 2022 20:11:11 +0100 (CET)
Message-ID: <7214a40b-c067-0465-28da-fb303591d876@kdbg.org>
Date:   Thu, 10 Mar 2022 20:11:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v5] userdiff: add builtin diff driver for kotlin language.
Content-Language: en-US
To:     Jaydeep Das <jaydeepjd.8914@gmail.com>
Cc:     git@vger.kernel.org
References: <20220301070226.2477769-1-jaydeepjd.8914@gmail.com>
 <20220306111539.336475-1-jaydeepjd.8914@gmail.com>
 <8799cd42-bb05-a827-187d-33fb03565f21@kdbg.org>
 <cf8a9316-c81e-2477-a565-1c38a168fc67@gmail.com>
 <72aca675-4c65-36bf-1337-34b2d1f40bb4@kdbg.org>
 <64677295-e7fd-ba4b-ce68-fe62132ca504@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <64677295-e7fd-ba4b-ce68-fe62132ca504@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.03.22 um 17:29 schrieb Jaydeep Das:
>>     "|[0-9][.0-9_]*([Ee][-+]?[0-9]+)?[fFlLuU]*"
>>
> 
> The problem with this approach is that it matches `2..5` as a single token.
> However in Kotlin, `..` is used to specify a range so 2..5 should be
> broken into
> 2 .. and 5.

Good catch. Then we have to be more restrictive with the fractional part:

	"|[0-9][0-9_]*([.][0-9_]*)([Ee][-+]?[0-9]+)?[fFlLuU]*"

-- Hannes
