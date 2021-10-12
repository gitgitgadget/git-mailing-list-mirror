Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2603C433F5
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 16:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D8D6604DC
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 16:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbhJLQ4a (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 12:56:30 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:65167 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhJLQ43 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 12:56:29 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8560A14A1AA;
        Tue, 12 Oct 2021 12:54:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GarzhM7K5mLHW/hYeWnhdqsL3MMeUEYK4Ua1L2
        hcwwo=; b=t5cK22ZLuaDsQP7afCEG+gnVyVdZWqJrXY4eCGvfFD9+hM8yyF3HDd
        hdw+rM17kuOjMprDPQsyyJV0OvBEaxrl+YTvmjWiobidqW7+gvt3tvsYEqAEbZgX
        7AZAnJsUc7qoon5hKG3NlhZfirDTscJtjdKkuHLdC3g5a05Jh22I0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7E04414A1A9;
        Tue, 12 Oct 2021 12:54:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1C0C014A1A7;
        Tue, 12 Oct 2021 12:54:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Rob Browning <rlb@defaultvalue.org>, git@vger.kernel.org
Subject: Re: [PATCH 1/1] signature-format.txt: add space to fix gpgsig
 continuation line
References: <20211009163338.2175170-1-rlb@defaultvalue.org>
        <YWRpPw4eTwTmgVvC@coredump.intra.peff.net>
        <xmqq4k9ncopr.fsf@gitster.g>
        <YWTuAOjqK6fy9ZRT@coredump.intra.peff.net>
Date:   Tue, 12 Oct 2021 09:54:24 -0700
In-Reply-To: <YWTuAOjqK6fy9ZRT@coredump.intra.peff.net> (Jeff King's message
        of "Mon, 11 Oct 2021 22:08:00 -0400")
Message-ID: <xmqqzgre5glb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0E3B4E18-2B7D-11EC-83AD-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>>     In the following example, the end of line that ends with a
>>     whitespace letter is highlighted with a "$" sign; if you are
>>     trying to recreate these example by hand, do not cut and paste
>>     them---they are there primarily to highlight extra whitespace at
>>     the end of some lines.
>> 
>> before a displayed material like this:
>> 
>>   committer C O Mitter <committer@example.com> 1465981137 +0000
>>   gpgsig -----BEGIN PGP SIGNATURE-----
>>    Version: GnuPG v1
>>    $
>>    iQEcBAABAgAGBQJXYRjRAAoJEGEJLoW3InGJ3IwIAIY4SA6GxY3BjL60YyvsJPh/
>>    HRCJwH+w7wt3Yc/9/bW2F+gF72kdHOOs2jfv+OZhq0q4OAN6fvVSczISY/82LpS7
>>    DVdMQj2/YcHDT4xrDNBnXnviDO9G7am/9OE77kEbXrp7QPxvhjkicHNwy2rEflAA
>> 
>> perhaps?
>
> ...coupled with the explanation you gave is not too bad. I had thought
> to maybe do something like:
>
>    gpgsig -----BEGIN PGP SIGNATURE-----
>    _Version: GnuPG v1
>    _
>    _iQEcBAABAgAGBQJXYRjRAAoJEGEJLoW3InGJ3IwIAIY4SA6GxY3BjL60YyvsJPh/
>    _HRCJwH+w7wt3Yc/9/bW2F+gF72kdHOOs2jfv+OZhq0q4OAN6fvVSczISY/82LpS7
>    _DVdMQj2/YcHDT4xrDNBnXnviDO9G7am/9OE77kEbXrp7QPxvhjkicHNwy2rEflAA
>
> but that is pretty ugly. I like yours much better.

Yes, I did consider a replacement for SP and rejected for the same
reason as you did.  We could use the same "we only show the 'here is
a SP' sign when the presence of the SP cannot be seen" convention to
make it less distracting, but I think '$' taken from "cat -e"
probably is easier to see and understand for those who are the
target audience of anything in Documentation/technical/ hierarchy.

Thanks.



