Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D91C91F463
	for <e@80x24.org>; Fri, 13 Sep 2019 14:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388333AbfIMOBq (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Sep 2019 10:01:46 -0400
Received: from smtp115.iad3b.emailsrvr.com ([146.20.161.115]:50527 "EHLO
        smtp115.iad3b.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388084AbfIMOBp (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 13 Sep 2019 10:01:45 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Sep 2019 10:01:45 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=g001.emailsrvr.com;
        s=20190322-9u7zjiwi; t=1568382905;
        bh=73R0SABEPM06S4TzsUlDYgRWHpbvGy1Op65UdpKzU1w=;
        h=Subject:To:From:Date:From;
        b=bPeEgjt7uy7/zxDONcc2wpIRddrQIWVCO1f9Q6OwdqYU4vMZGY+cg3G5mmfwhQo9u
         J9GRJOlQph4LcbQj3PhfbQUa0yI0he1PioQpQzCmXG0DA8f+0730gS8xsVPpPxE8R9
         YnBd/CHBV/cTR2jCw4X/Y09V3mnJHey0l8xDWG1Y=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xiplink.com;
        s=20181102-2c3qeqyt; t=1568382905;
        bh=73R0SABEPM06S4TzsUlDYgRWHpbvGy1Op65UdpKzU1w=;
        h=Subject:To:From:Date:From;
        b=XaUEBrkILj07iLDGzO4ht8WJrZQ+POpoc5mr4nv+ZfrzalB/q33ix+Flw/ArdkxMK
         3sea3+yx1Tg6hCh/q9Kd9ehNa4VqqyXdjbs3oQrmyYV9b1oM9cM/LM6iiOvDBtVGwv
         CvAf5wy1Up9jKucvKAtd2gO9nTeaOGt5wmz9vULk=
X-Auth-ID: mbranchaud@xiplink.com
Received: by smtp7.relay.iad3b.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 4CC32601AE;
        Fri, 13 Sep 2019 09:55:05 -0400 (EDT)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
        (using TLSv1.2 with cipher AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Fri, 13 Sep 2019 09:55:05 -0400
Subject: Re: [PATCH 2/2] git-gui: add hotkey to toggle "Amend Last Commit"
 check button/menu
To:     Birger Skogeng Pedersen <birger.sp@gmail.com>,
        Philip Oakley <philipoakley@iee.email>
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        Bert Wesarg <bert.wesarg@googlemail.com>,
        Git List <git@vger.kernel.org>
References: <ab1f68cc8552e405c9d04622be1e728ab81bda17.1567713659.git.bert.wesarg@googlemail.com>
 <b82a00441ff1a6a9cea3fd235c1c33729ec31b71.1567713659.git.bert.wesarg@googlemail.com>
 <20190911205539.vb6asqcc22nzgdqa@yadavpratyush.com>
 <CAGr--=Jz9xN6NMmiXjHeq9wZsYUx4eqfQrWjjVMkj3J1YCG_8g@mail.gmail.com>
 <20190912162924.phb5o2ppovnxa7nn@yadavpratyush.com>
 <db01db41-eff0-fb56-161a-ba26d1b18f55@xiplink.com>
 <56a6fbf8-4486-6bad-f847-793bb6b4e070@iee.email>
 <CAGr--=JDKrYT=Z8iwPVRy58OB9teH7bHXrYSZHqYHhJ=5wrJzQ@mail.gmail.com>
From:   Marc Branchaud <marcnarc@xiplink.com>
Message-ID: <aabc98d9-52c4-45f5-fd8b-0d7ee530f263@xiplink.com>
Date:   Fri, 13 Sep 2019 09:55:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAGr--=JDKrYT=Z8iwPVRy58OB9teH7bHXrYSZHqYHhJ=5wrJzQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019-09-13 3:50 a.m., Birger Skogeng Pedersen wrote:
> Hi Marc and Philip,
> 
> 
> On 12/09/2019 22:34, Marc Branchaud wrote:
>> I disagree!  Who expects anything to work properly when capslock is on?
> 
> Me :-)

Fair enough, though I imagine you have a pretty narrow definition of 
"anything".  :)

> On Fri, Sep 13, 2019 at 12:23 AM Philip Oakley <philipoakley@iee.email> wrote:
>> I'd tend to agree. In other areas the use of shift is often used as the
>> complement of the unshifted action, so it does feel 'odd'. Thus it could
>> be used directly as the bool for amend or direct commit.
>>
>> This all assumes that Caps Lock is equivalent to having the shift on,
>> rather than being a special extra key.
> 
> It seems all the Ctrl+(lowercase character) hotkeys in git-gui have an
> equivalent Ctrl+(uppercase character).
> So for this feature, we should keep the Ctrl+E bind aswell as the
> Ctrl+e bind. If nothing else, to keep it consistent with the rest of
> the hotkey bindings.

Ah, OK.  I agree that keeping git-gui internally consistent trumps the 
other considerations.

		M.


> But honestly, (as Marc pointed out) it is a quite weird that
> Ctrl+Shift+(character) has the excact same function as
> Ctrl+(character). Perhaps we should find another way to bind the
> hotkeys, where the state of Caps Lock doesn't matter? If possible.
> 
> 
> Birger
> 
