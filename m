Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53E2C4332F
	for <git@archiver.kernel.org>; Tue, 15 Nov 2022 18:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbiKOSsg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Nov 2022 13:48:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbiKOSsb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2022 13:48:31 -0500
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87363633C
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 10:48:28 -0800 (PST)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id B5190CA1254;
        Tue, 15 Nov 2022 13:48:27 -0500 (EST)
Received: from [10.0.0.2] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 78481CC8336;
        Tue, 15 Nov 2022 13:48:27 -0500 (EST)
Message-ID: <89762517-bde0-4512-797c-f0c75a8f7e76@jeffhostetler.com>
Date:   Tue, 15 Nov 2022 13:48:26 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: compat/fsmonitor/fsm-listen-darwin warning on macOS Ventura
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Git List <git@vger.kernel.org>
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Kevin Willford <Kevin.Willford@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <5dbd5dd1-3a50-c0ce-d06a-227ec0a89bc6@web.de>
Content-Language: en-US
From:   Jeff Hostetler <git@jeffhostetler.com>
In-Reply-To: <5dbd5dd1-3a50-c0ce-d06a-227ec0a89bc6@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.10 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/5/22 1:26 PM, René Scharfe wrote:
> Hi all,
> 
> on macOS 13.0 Ventura I get the following warning-turned-error when
> compiling the fsmonitor code:
> 
> 
> compat/fsmonitor/fsm-listen-darwin.c:495:2: error: 'FSEventStreamScheduleWithRunLoop' is deprecated: first deprecated in macOS 13.0 - Use FSEventStreamSetDispatchQueue instead. [-Werror,-Wdeprecated-declarations]
>          FSEventStreamScheduleWithRunLoop(data->stream, data->rl, kCFRunLoopDefaultMode);
>          ^
> /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/System/Library/Frameworks/CoreServices.framework/Frameworks/FSEvents.framework/Headers/FSEvents.h:1138:1: note: 'FSEventStreamScheduleWithRunLoop' has been explicitly marked deprecated here
> FSEventStreamScheduleWithRunLoop(
> ^
> 1 error generated.
> make: *** [compat/fsmonitor/fsm-listen-darwin.o] Error 1
> 
> 
> No idea how to use FSEventStreamSetDispatchQueue.  I could run tests
> if that helps.
> 
> René
> 

Thanks for the note.  I'll take a look and see if/how much this
changes things.

Jeff
