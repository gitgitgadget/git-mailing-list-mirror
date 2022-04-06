Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1DAC433FE
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 18:00:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239972AbiDFSCG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 14:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239884AbiDFSB4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Apr 2022 14:01:56 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC456C1E1
        for <git@vger.kernel.org>; Wed,  6 Apr 2022 09:35:21 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 62E3612BAEA;
        Wed,  6 Apr 2022 12:35:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Ip+yXPQMTNoP6sYVDR2vrCl88pFTgmx9ifLf4D
        0NL+A=; b=E1jteI2mZMYVDPl2nlUnyAYsU9vTRyDFKODUfs4zUpUma+tts2hr5p
        mcJN2NY34aMImsVt1C1DVu+ADay2VhE9Mad9EXrVTakQz/fOyNvRjXJkjiIVJ61Y
        lmq2+fayNvis/OwrttD0O7G/SYRGRbi8BI0KJ127vPDjP7fY+D7Y4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 10FC612BAE8;
        Wed,  6 Apr 2022 12:35:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E106612BAE7;
        Wed,  6 Apr 2022 12:35:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Neeraj Singh <nksingh85@gmail.com>
Cc:     Adam Dinwoodie <adam@dinwoodie.org>, git@vger.kernel.org,
        Neeraj Singh <neerajsi@microsoft.com>
Subject: Re: [PATCH] configure.ac: fix HAVE_SYNC_FILE_RANGE definition
References: <20220405100020.48663-1-adam@dinwoodie.org>
        <20220405153159.GA22458@neerajsi-x1.localdomain>
Date:   Wed, 06 Apr 2022 09:35:17 -0700
In-Reply-To: <20220405153159.GA22458@neerajsi-x1.localdomain> (Neeraj Singh's
        message of "Tue, 5 Apr 2022 08:31:59 -0700")
Message-ID: <xmqqo81eyxtm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8BCA4AB2-B5C7-11EC-8C27-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Neeraj Singh <nksingh85@gmail.com> writes:

> On Tue, Apr 05, 2022 at 11:00:20AM +0100, Adam Dinwoodie wrote:
>> If sync_file_range is not available when building the configure script,
>> there is a cosmetic bug when running that script reporting
>> "HAVE_SYNC_FILE_RANGE: command not found".  Remove that error message by
>> defining HAVE_SYNC_FILE_RANGE to an empty string, rather than generating
>> a script where that appears as a bare command.
>> 
>> Signed-off-by: Adam Dinwoodie <adam@dinwoodie.org>
>> ---
>>  configure.ac | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/configure.ac b/configure.ac
>> index 6bd6bef1c4..316a31d231 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -1087,7 +1087,7 @@ GIT_CONF_SUBST([HAVE_CLOCK_MONOTONIC])
>>  # Define HAVE_SYNC_FILE_RANGE=YesPlease if sync_file_range is available.
>>  GIT_CHECK_FUNC(sync_file_range,
>>  	[HAVE_SYNC_FILE_RANGE=YesPlease],
>> -	[HAVE_SYNC_FILE_RANGE])
>> +	[HAVE_SYNC_FILE_RANGE=])
>>  GIT_CONF_SUBST([HAVE_SYNC_FILE_RANGE])
>>  
>>  #
>> -- 
>> 2.35.1
>> 
>
> Thanks for fixing this.  Looks good to me.

Thanks, both.

Will apply.
