Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED65EB64DD
	for <git@archiver.kernel.org>; Sun, 13 Aug 2023 10:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjHMKqF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Aug 2023 06:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjHMKqE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Aug 2023 06:46:04 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66AF0170A
        for <git@vger.kernel.org>; Sun, 13 Aug 2023 03:46:02 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id DDF9024054;
        Sun, 13 Aug 2023 06:45:58 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qV8be-FQf-00; Sun, 13 Aug 2023 12:45:58 +0200
Date:   Sun, 13 Aug 2023 12:45:58 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t9001: fix/unify indentation regarding pipes somewhat
Message-ID: <ZNi0ZrjSyE7vpQva@ugly>
References: <20230809171531.2564769-1-oswald.buddenhagen@gmx.de>
 <xmqq350sm21v.fsf@gitster.g>
 <ZNS7PJ0oyOQLeaZ7@ugly>
 <xmqqa5uysoi0.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqa5uysoi0.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 10, 2023 at 12:09:43PM -0700, Junio C Hamano wrote:
>Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:
>
>>>but more like
>>>
>>>	A |
>>>	B |
>>>	C
>>>
>> i'd argue that this should be written as
>>
>> 	A |
>> 		B |
>> 		C
>>
>> like other continued lines (no trailing backslashes are needed here,
>> but it would be ok to add them, and there is in fact a commit that
>> does just that in other places, and one might do the same here in a
>> followup).
>
>You are entitled to your own opinion, and you are welcome to stick
>to it in projects you run.  But please refrain from wasting time of
>this project on something that is subjective preference and has no
>absolute yardstick to tell which is _right_ or _wrong_.
>
i think it's a rather uncontroversial statement that the whitespace 
should visualize the code structure to the greatest degree possible 
(which of course doesn't imply blindly maximizing indentation, as there 
are multiple considerations). so while the details can be bike-shedded 
to death, that doesn't mean that there isn't a trend.

i can totally see why one wouldn't indent the top-level `&&` chains in 
the test cases (they are really kinda a local `set -e`, and with bash 
one could probably actually use that with an ERR trap), but generally 
not indenting continuations (also of compound statements) is confusing 
(and doing it incorrectly even more so, as you agree).

>Difference
>between the above two falls into "once it is written in one way, it
>is not worth the patch noise to turn it into the other way",
>
that i'll happily agree with in this case.

regards
