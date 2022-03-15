Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203B7C433FE
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 07:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345555AbiCOHlo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Mar 2022 03:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245061AbiCOHll (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Mar 2022 03:41:41 -0400
Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41494B856
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 00:40:27 -0700 (PDT)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 4KHlgX3znKz5tl9;
        Tue, 15 Mar 2022 08:40:24 +0100 (CET)
Message-ID: <d8783660-1487-1899-19bf-10654801ea0a@kdbg.org>
Date:   Tue, 15 Mar 2022 08:40:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [GSoC][PATCH v2] Add a diff driver for JavaScript languages.
Content-Language: en-US
To:     Glen Choo <chooglen@google.com>
References: <20220304130854.857746-1-a97410985new@gmail.com>
 <20220312164803.57909-1-a97410985new@gmail.com>
 <kl6lwngwqwm2.fsf@chooglen-macbookpro.roam.corp.google.com>
Cc:     xing zhi jiang <a97410985new@gmail.com>, git@vger.kernel.org
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <kl6lwngwqwm2.fsf@chooglen-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 14.03.22 um 18:20 schrieb Glen Choo:
> xing zhi jiang <a97410985new@gmail.com> writes:
>> diff --git a/t/t4018/javascript-exports-function b/t/t4018/javascript-exports-function
>> new file mode 100644
>> index 0000000000..63b79f5991
>> --- /dev/null
>> +++ b/t/t4018/javascript-exports-function
>> @@ -0,0 +1,4 @@
>> +exports.RIGHT = function(document) {
>> +    
>> +    return ChangeMe;
>> +}
> 
> I don't think we should include 'exports.foo = bar'. To my knowledge,
> this is _not_ a standard ES feature, but rather the CommonJS module
> system popularized by Node.js [1] and other frameworks. To confirm this,
> I searched the ES spec and did not find any reference to exports.* [2].
> 
> Even if we wanted to support nonstandard 'language features' (and this
> label is tenuous at best, CommonJS is not trying to replace the ES
> modules standard AFAIK), Node.js is also starting to support ES modules,
> so I don't think this is a good long term direction for Git.

It is not a priority to model hunk header regular expressions after some
standard and to ignore stuff that is outside the standard. The goal is
to make them useful in a majority of cases. If there exists a noticable
chunk of code that uses non-standard constructs, then that is worth
being supported.

> 
> [1] https://nodejs.org/api/modules.html
> [2] https://262.ecma-international.org/12.0/#sec-exports

-- Hannes
