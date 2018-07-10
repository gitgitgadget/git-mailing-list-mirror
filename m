Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D70D1F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 13:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933229AbeGJNYZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 09:24:25 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:39505 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933145AbeGJNYY (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 10 Jul 2018 09:24:24 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 9AAC5218B4;
        Tue, 10 Jul 2018 09:24:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 10 Jul 2018 09:24:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=living180.net;
         h=cc:content-transfer-encoding:content-type:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=iL+pNUuWiC8K4AECY
        hh9WFStpA8lWbo8AkxvFG68UVQ=; b=AqxT0/dOudV0IBVa+6IJwSlAB1nSWTcPY
        JKZmON8vUp1SWcs9hVYI3bGfKFgglfYYrj/lF0IW93ZP5jG0HJdSse7d9XXoTH/U
        GxxvHjMn0wh5/EiHTDGxIEDo9ixpZpxLUDkESjDc8Psi01fq/IZBQ+3PvlB+OuGT
        dtOYUMpJ+ugX1rgQc8zuXlhVaLKsKMjU7CHmijNG8Sc5tTNVRNHPBzA8OHmORHc3
        WnvBRZGVUoU8rwX3YtVWtIU0E3DZBhfrv1E/evAQmQ+P1YIIYcDgAS9YG+RBw2Pe
        owQ3Zh7RxwYySpZlyyBX2DlO0sFonOn+mQSegq0B31uciDYPNTh0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=iL+pNU
        uWiC8K4AECYhh9WFStpA8lWbo8AkxvFG68UVQ=; b=WPjfh2t9f70y9ow+q1KC2V
        p1HKJgRTVkS0xaOnE/hTfPgtq2SR35im4aFofrzCbI75XhYt/qd459C9t8LJeFND
        O2NplV2brErLF3Gb9vG0r6xMcGOctda7h9LgVfIDWH5L8fVtt2ET6ZUzwTqXCI5G
        fHUQLgc1kuJuB0fIkf6/6HE3zgK6QkTAgAksvpedUJJfeG4rXPGAT5Y6PcEBQBfW
        y70RnoNjOcbZkkBZeu5IJIzlZhWp65CQwqS2lH/Vy3IEE2BXc7NHtcpi7dQLyu2W
        lVNIx+7JBsh4J9p/2bURGhKKQreFgf5LUorMZFcc+W8e50bDJrsqBUpdPtkBYYOQ
        ==
X-ME-Proxy: <xmx:h7NEW-37BwDqa5IG4TVE5kI3RWPz-2qopVvCwTJJ_ekjfGonOJno9A>
    <xmx:h7NEWxOzyv58ja0hoMZD7XdrBUNvX9oFpNUcG5x2yzlof0rqg53HVg>
    <xmx:h7NEW-1aiJZEQsocCxDzHTAzJgHVFSMMyL0YIjFwSHe5WXR_dc_tlA>
    <xmx:h7NEW4FlalXix4-3Aqp4tQ2jL4EIXHy-Ljm2rnzMEYiWPSqBeKKe1w>
    <xmx:h7NEW74rVdSF-X5L-BZ6A_ID5i1IA2AWLK4bShDPFuIQKdtlKDh-Zw>
    <xmx:h7NEWyEp6NwCom-f4J9FKj-43VdkZUbqvAXMNzkMqrRpeSzIleAjpA>
X-ME-Sender: <xms:h7NEW5zY0rbmdFckySwNPziVlh7ok8hEQ9eWGpXBSMDFxfhohmrXfQ>
Received: from [0.0.0.0] (unknown [173.199.115.247])
        by mail.messagingengine.com (Postfix) with ESMTPA id 79E0BE4516;
        Tue, 10 Jul 2018 09:24:21 -0400 (EDT)
Subject: Re: [PATCH 0/2] Fix --rebase-merges with custom commentChar
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Aaron Schrab <aaron@schrab.com>
Cc:     git@vger.kernel.org
References: <20180708184110.14792-1-dharding@living180.net>
 <nycvar.QRO.7.76.6.1807090936230.75@tvgsbejvaqbjf.bet>
From:   Daniel Harding <dharding@living180.net>
Message-ID: <e8973797-fc5f-2ca5-1881-5ee66fc8279b@living180.net>
Date:   Tue, 10 Jul 2018 16:24:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1807090936230.75@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 09 Jul 2018 at 10:53:14 +0300, Johannes Schindelin wrote>
> On Sun, 8 Jul 2018, Daniel Harding wrote:
> 
>> I have core.commentChar set in my .gitconfig, and when I tried to run
>> git rebase -i -r, I received an error message like the following:
>>
>> error: invalid line 3: # Branch <name>
>>
>> To fix this, I updated sequencer.c to use the configured commentChar
>> for the Branch <name> comments.  I also tweaked the tests in t3430 to
>> verify todo list generation with a custom commentChar.  I'm not sure
>> if I took the right approach with that, or if it would be better to
>> add additional tests for that case, so feel free to
>> tweak/replace/ignore the second commit as appropriate.
> 
> Nothing is as powerful as an idea whose time has come. Or as a patch whose
> time has come, I guess:
> 
> https://public-inbox.org/git/20180628020414.25036-1-aaron@schrab.com/

Oops, I should have done a bit a searching before I tossed off a patch. 
Thanks Johannes for the pointer.

> AFAICT the remaining task was to send a new revision of the patch, with
> the commit message touched up, to reflect the analysis that it handles the
> `auto` setting well.
> 
> Your patch adds a regression test in addition, which is very nice.
> 
> So maybe you can coordinate with Aaron about that first patch? I really
> think that the commit message needs to explain why the `auto` setting is
> not a problem here.

Aaron, how would you like to move forward on this?  I don't want to take 
credit from you since you were the first to post the patch.  If you 
would like to post a new version of your patch with the commit message 
updated based on the feedback, I can then add my tests to go with it. 
Alternatively if you'd like me to run with this I can repost the patch 
with you as the author along with an updated commit message and my name 
in a "Commit-message-by:" line.  Let me know your thoughts.  If I don't 
hear from you in a couple of days, I'll go ahead and repost the patch as 
I described.

Thanks,

Daniel Harding
