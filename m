Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4905BEB64DC
	for <git@archiver.kernel.org>; Fri, 14 Jul 2023 16:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235588AbjGNQpO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jul 2023 12:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236068AbjGNQpN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2023 12:45:13 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313B835A6
        for <git@vger.kernel.org>; Fri, 14 Jul 2023 09:45:12 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5F92424C4F;
        Fri, 14 Jul 2023 12:45:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nZHghOHQDSy/DP/YA7Gjr2V7jgrrCMsax3wSLh
        ihiYI=; b=D6i+1lfK7Uy0To8bFHYUdyY6ppCyWuiMwurBifOXIQ6gGV8UlhtM2q
        JBZmNVSA3nFWNbzIP97/CR2Mj/udImOc4m3T0ibNV40Qb7ZlJBWSjqpTB+wA9Y2s
        c4YUCFQx1ymfLDR8USClrfT40Ga/O+lkO+tjJaud8kcKo2JGylt6k=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 59B5524C4E;
        Fri, 14 Jul 2023 12:45:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A70C924C48;
        Fri, 14 Jul 2023 12:45:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "nick" <nick@nicholasjohnson.ch>
Cc:     <git@vger.kernel.org>
Subject: Re: Git Privacy
References: <CTZ9RD9RQ5UO.3OIJX50PKMIR0@anonymous>
        <xmqqlefjpwif.fsf@gitster.g> <CU1SAE4WGP3X.3R7TTIWFSHGDI@anonymous>
Date:   Fri, 14 Jul 2023 09:45:04 -0700
In-Reply-To: <CU1SAE4WGP3X.3R7TTIWFSHGDI@anonymous> (nick@nicholasjohnson.ch's
        message of "Fri, 14 Jul 2023 09:22:44 +0000")
Message-ID: <xmqqbkgeqw6n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C9C14C7E-2265-11EE-9B8D-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"nick" <nick@nicholasjohnson.ch> writes:

>> "nick" <nick@nicholasjohnson.ch> writes:
>>
>> > hooks. Perhaps a config option to automatically set the date to a time
>> > before Git was invented?
>>
>> [...] I am not yet convinced that it is worth the engineering effort
>> for this project to review, accept and maintain changes to implement
>> it.
>
> Upon further thought, given that it's already pretty easy to accomplish
> timestamp obfuscation, albeit clumsy, I concede that it may not be worth
> the engineering effort to implement my original suggestion. So I'll drop
> it.
>
> However, I think it is worth the effort for the time zones. Is there any
> reason Git doesn't automatically convert local time to UTC in timestamps
> to prevent leaking the developer's time zone?

Actually it is the other way around, if I understand correctly.

Git could have been designed to discard that information like
previous version control systems, but it is another piece of
interesting information and made a conscious design decision to keep
it.  In other words, "is there any reason why we do not discard the
information?" is a wrong question to ask in the context of VCS.

I earlier said I am not yet convinced it is worth our time, and so
far I haven't heard anything new that may help me convince myself
yet.

Thanks.
