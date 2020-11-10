Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A040C5517A
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 17:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC9BC206D8
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 17:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GbsNL5TZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbgKJRFz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 12:05:55 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53026 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbgKJRFz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 12:05:55 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 56B7B10D386;
        Tue, 10 Nov 2020 12:05:52 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=tInqPHS5DE5s
        kFdvve9cDZLxYbQ=; b=GbsNL5TZ9RFrsfDw8yu32qIjo1Wf4ORdpCdjJ0VU9K0J
        r2A6YVft/aWCS2DKsgW4QuhBPbjfwHoLO1DwbYHaCb9lJBcZD+c7Lbu6CBYcX9xa
        IAIwuZ2+iFpwXdC4yEAYipD1gkg8vC4M8sfJ7aj+UaSF6wfUN2f6taSYF3i42pU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=vIcS2r
        RBnli9HSYti62WXl265XNhdvOkhSTdHt0xJ6j0xU/gVJILYIiMhTFpIBoUoGWINf
        1sd9n2aSDGB5ofX5SJ6rMbUvjaBF1Ugvi0mcEMycpj8/kf4caXbjvcwKRFFH3gC0
        F+ObwNeQR3RQbP1vwd/igAmoBMRnVMB/o4KSs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4EFCF10D385;
        Tue, 10 Nov 2020 12:05:52 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8D28510D384;
        Tue, 10 Nov 2020 12:05:49 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Barret Rhoden <brho@google.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Jean-Yves Avenard <jyavenard@mozilla.com>, git@vger.kernel.org
Subject: Re: Request for change 610e2b9240 reversal
References: <CA+phgpFS_MOKOib5+yAE7U2QPMqMD_t+yXhR29UG9aSO4pgk+A@mail.gmail.com>
        <171b9a99-d48a-babe-168b-a7cd410e4635@web.de>
        <416a4e32-f813-cb7f-406d-30c5d48034b3@google.com>
Date:   Tue, 10 Nov 2020 09:05:47 -0800
In-Reply-To: <416a4e32-f813-cb7f-406d-30c5d48034b3@google.com> (Barret
        Rhoden's message of "Tue, 10 Nov 2020 08:33:53 -0500")
Message-ID: <xmqq361h87mc.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FB67D374-2376-11EB-BC4F-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Barret Rhoden <brho@google.com> writes:

> On 11/10/20 6:38 AM, Ren=C3=A9 Scharfe wrote:
> [snip]
>> Reported-by: Jean-Yves Avenard <jyavenard@mozilla.com>
>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>
> patch looks good to me.
>
> Reviewed-by: Barret Rhoden <brho@google.com>
>
> Thanks,
>
> Barret

Yes, I do recall that we discussed reverting half of that change and
then I forgot to follow through.

Thanks, all.  Will queue.

>
>
>> ---
>>   oidset.c                     | 5 +++--
>>   t/t8013-blame-ignore-revs.sh | 4 ++--
>>   2 files changed, 5 insertions(+), 4 deletions(-)
>> diff --git a/oidset.c b/oidset.c
>> index 2d0ab76fb5..5aac633c1f 100644
>> --- a/oidset.c
>> +++ b/oidset.c
>> @@ -72,9 +72,10 @@ void oidset_parse_file_carefully(struct oidset *set=
, const char *path,
>>   		if (!sb.len)
>>   			continue;
>> -		if (parse_oid_hex(sb.buf, &oid, &p) || *p !=3D '\0' ||
>> -		    (fn && fn(&oid, cbdata)))
>> +		if (parse_oid_hex(sb.buf, &oid, &p) || *p !=3D '\0')
>>   			die("invalid object name: %s", sb.buf);
>> +		if (fn && fn(&oid, cbdata))
>> +			continue;
>>   		oidset_insert(set, &oid);
>>   	}
>>   	if (ferror(fp))
>> diff --git a/t/t8013-blame-ignore-revs.sh b/t/t8013-blame-ignore-revs.=
sh
>> index 24ae5018e8..b18633dee1 100755
>> --- a/t/t8013-blame-ignore-revs.sh
>> +++ b/t/t8013-blame-ignore-revs.sh
>> @@ -39,10 +39,10 @@ test_expect_success 'validate --ignore-rev' '
>>   	test_must_fail git blame --ignore-rev X^{tree} file
>>   '
>> -# Ensure bogus --ignore-revs-file requests are caught
>> +# Ensure bogus --ignore-revs-file requests are silently accepted
>>   test_expect_success 'validate --ignore-revs-file' '
>>   	git rev-parse X^{tree} >ignore_x &&
>> -	test_must_fail git blame --ignore-revs-file ignore_x file
>> +	git blame --ignore-revs-file ignore_x file
>>   '
>>   for I in X XT
>> --
>> 2.29.2
>>=20
