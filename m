Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD5FDC43219
	for <git@archiver.kernel.org>; Wed, 19 Oct 2022 15:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbiJSPv5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Oct 2022 11:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232523AbiJSPvh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2022 11:51:37 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE031D20D8
        for <git@vger.kernel.org>; Wed, 19 Oct 2022 08:47:32 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 19C6E1AB6E4;
        Wed, 19 Oct 2022 11:31:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yK0ovThDoxD+tAByWHnEExQOE6ZkqZ/QLc8Zix
        dm/44=; b=kAplaslbS86BVIhUDJjmER1QZ1yyuXelmtsmHCEzpVASpO7P8b2xBm
        dZRfF+p8k4gCnChwe87M0GDAoOlDjPYvpdFvVil8HnegWtpEyhAKm9yzTgkgg2Em
        HqeD8NXSI0pKls7JDcVb33JQxNoAwOLr0yFepIKMt/cigIudBGIqc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 125F01AB6E3;
        Wed, 19 Oct 2022 11:31:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4596F1AB6E2;
        Wed, 19 Oct 2022 11:31:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     <rsbecker@nexbridge.com>
Cc:     <git@vger.kernel.org>
Subject: Re: 2.38.1 Build Version Confusion
References: <01cd01d8e3c7$e93bff50$bbb3fdf0$@nexbridge.com>
        <01d101d8e3cb$ab9d7940$02d86bc0$@nexbridge.com>
Date:   Wed, 19 Oct 2022 08:31:12 -0700
In-Reply-To: <01d101d8e3cb$ab9d7940$02d86bc0$@nexbridge.com>
        (rsbecker@nexbridge.com's message of "Wed, 19 Oct 2022 11:01:24
        -0400")
Message-ID: <xmqqk04vu8xr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1088FE7A-4FC3-11ED-AC61-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

<rsbecker@nexbridge.com> writes:

> On October 19, 2022 10:35 AM, I wrote:	
>>When I build 2.38.1, I'm ending up with GIT-VERSION-FILE as follows:
>>
>>$ cat GIT-VERSION-FILE
>>GIT_VERSION = 2.38.GIT
>>
>>$ ./git version
>>git version 2.38.GIT

That is unexpected.

>>This seems a bit different from past patches. Is this intended?
>
> I should point out that I used the 'main' branch for this build.

Yes, you should.  You didn't build 2.38.1.

If you built 'main' (which does not really exist, by the way---I
push out 'master' to 'master' and to 'main' when I publish for
illusion), it has a lot of development towards the next feature
release plus whatever is in 'maint', and 2.38.GIT is expected.

"git checkout --detach v2.38.1" and build from there, and then you
can say "I built 2.38.1".  "git checkout maint" and building it
right now would also build 2.38.1 but that is only true until
'maint' gains more updates on top to prepare for 2.38.2.

HTH.


