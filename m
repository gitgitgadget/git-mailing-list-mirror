Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 439AAC761AF
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 13:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbjC1NYL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 09:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232475AbjC1NYH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 09:24:07 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A76A24D
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 06:23:59 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 87E3A20081
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 09:23:58 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
        id 1ph9Is-RBN-00
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 15:23:58 +0200
Date:   Tue, 28 Mar 2023 15:23:58 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Subject: Re: [PATCH] sequencer: beautify subject of reverts of reverts
Message-ID: <ZCLqbmWsN/7Ihjg+@ugly>
Mail-Followup-To: git@vger.kernel.org
References: <20230323162234.995465-1-oswald.buddenhagen@gmx.de>
 <210376fb-f830-4883-b576-2936dabc09cc@app.fastmail.com>
 <xmqqa5zxn85r.fsf@gitster.g>
 <4f570b05-036d-45a1-8caa-cebfce3026c9@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4f570b05-036d-45a1-8caa-cebfce3026c9@app.fastmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 28, 2023 at 08:04:43AM +0200, Kristoffer Haugsbakk wrote:
>On Tue, Mar 28, 2023, at 00:25, Junio C Hamano wrote:
>> ""Revert^4 "A change" the other thread proposed start to look less horrible.
>> So, I dunno.
>
>That looks good. And the transformations are just:
>
>    Revert " → Reapply "
>    Reapply " → Revert^3 "
>    Revert^<n> " → Revert^<n+1> "
>
i thought about that already, and concluded that it's getting a bit "too 
nerdy" and over-engineered.
the main motivation for me is to break the dogmatism with which some 
people are approaching the matter - "$tool did it, so it is _the_ way".  
set an example where the tool does something "humane", and you may 
change some minds.
when it gets to round 3 of reverting, i expect people to get creative:

  Revert "foo" again
  Reapply "foo", take 2
  etc.

but i don't mind, as long as `Revert "Revert "Revert "foo"""` cannot be 
argued to be canon any more.
