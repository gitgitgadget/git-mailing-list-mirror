Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B9C4C433EF
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 13:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F93060F41
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 13:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234630AbhI0NyS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 09:54:18 -0400
Received: from siwi.pair.com ([209.68.5.199]:20835 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234589AbhI0NyR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 09:54:17 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id BBF313F4098;
        Mon, 27 Sep 2021 09:52:39 -0400 (EDT)
Received: from test.azshci.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id A11D63F4096;
        Mon, 27 Sep 2021 09:52:39 -0400 (EDT)
Subject: Re: New built-in fsmonitor: messages accidentally on stdout?
To:     Tao Klerks <tao@klerks.biz>, git <git@vger.kernel.org>
References: <CAPMMpoj-oiD1yDHx6WS_1uiPOXMLj7FcfBPZm-q4vO30kpE_ow@mail.gmail.com>
 <CAPMMpoic0Dt=5Z7GB7BG7CqwxAs49SPPDkdasUPvasvsPhr-tg@mail.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <c0ff1914-8bf2-fb10-ea74-d35cf86508a1@jeffhostetler.com>
Date:   Mon, 27 Sep 2021 09:52:39 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAPMMpoic0Dt=5Z7GB7BG7CqwxAs49SPPDkdasUPvasvsPhr-tg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/27/21 5:32 AM, Tao Klerks wrote:
> Hi folks,
> 
> I did track down where that message was being issued onto stdout in
> git-for-windows
> (https://github.com/git-for-windows/git/blob/main/builtin/fsmonitor--daemon.c),
> and I see that in the the latest version of the patch series it was
> already switched to stderr
> (https://github.com/jeffhostetler/git/blob/f08a63e197a0efe4d8f0452893238b0d3156e669/builtin/fsmonitor--daemon.c).
> 
> The only remaining thing I can ask for, I guess, is that the next Git
> for Windows release ideally include this change/fix, even though the
> built-in fsmonitor is not in "regular git" at all yet?

Yes, I've fixed that in my branch to print to stderr (and also
put it behind a feature flag).

If my current series does not make it into core Git in time
for the next release, we will update the experimental version
in the next git-for-windows release.

Thanks,
Jeff
