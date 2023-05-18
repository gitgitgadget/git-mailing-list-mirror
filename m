Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 491DCC77B7D
	for <git@archiver.kernel.org>; Thu, 18 May 2023 19:50:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjERTuv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 May 2023 15:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjERTus (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2023 15:50:48 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A86BE7F
        for <git@vger.kernel.org>; Thu, 18 May 2023 12:50:45 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EF66A209B54;
        Thu, 18 May 2023 15:50:42 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=G3gUOENbBcCpYnz5/+ipd1LTtii+QGX00/JIMsa
        Kix4=; b=w7Tf3cDzrk4vMv/6tLdiaAuslHIDKG6y/Qg5F12vun2Vd7HbUsyW00G
        goQZfpW+/DCuxoeiWcHKEJ8IuGvwXxsAUdSeIJfZ5HdVH8uTbpD2jDk8625N3pgd
        mNaSHU6UUn/y87HwD16y6MsiTnFwDvtFBbfY1I6hXAQ3mx+VMv6s=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E7B5A209B53;
        Thu, 18 May 2023 15:50:42 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [108.15.224.39])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E6D99209B50;
        Thu, 18 May 2023 15:50:38 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Date:   Thu, 18 May 2023 15:50:36 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Matthew John Cheetham <mjcheetham@outlook.com>
Subject: Re: [BUG 2.41.0] t/lib-httpd/apache.conf incompatible with
 RHEL/CentOS 7
Message-ID: <ZGaBjLsJUiNEaLu2@pobox.com>
References: <ZGUlqu7sP7yxbaTI@pobox.com>
 <20230518184532.GC557383@coredump.intra.peff.net>
 <20230518192102.GA1514485@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518192102.GA1514485@coredump.intra.peff.net>
X-Pobox-Relay-ID: 43BA8154-F5B5-11ED-9EE7-C2DA088D43B2-09356542!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Thu, May 18, 2023 at 02:45:32PM -0400, Jeff King wrote:
> 
>>   2. We do some kind of version check in enable_cgipassauth(),
>>      and skip tests manually if it doesn't pass.
>> [...]
>> Obviously (1) and (3) are the least work for us upstream, but I don't
>> think (2) would be too hard to do.
> 
> It indeed was pretty easy. So here's a patch. I'm adding Junio to the cc
> before any review, as this is a change in the v2.41 cycle. So I think
> we'd want to address this before the release.

Nice.

> I tested this manually by mutilating the config directive to "FooBar",
> which would fail even on recent versions. And then tweaking the "13"
> in the version check up to "60" to make sure it properly skips even with
> recent Apache. But testing on real CentOS 7 would be very much
> appreciated.

I have a build running now.  It takes around ~20 minutes in
the Fedora/EPEL build system.  I wanted to make sure it was
started quickly since you turned out a patch in the time it
took me to write my last reply. ;)

(It would have been quicker if I hadn't forgot to apply the
imap-send patch as well.  D'oh!)

-- 
Todd
