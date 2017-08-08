Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C624C20899
	for <e@80x24.org>; Tue,  8 Aug 2017 22:14:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751975AbdHHWOi (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 18:14:38 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56569 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751965AbdHHWOi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 18:14:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A8CF0A08BD;
        Tue,  8 Aug 2017 18:14:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=8WM0L+VfqoDe
        QgZxaoootjeer8E=; b=GnG2QwyM3xxTCwAoHINAZX1sIyHN88xGk6K9nKDq1e9L
        1pd//deijzEefzAdWlmDc1RmuBwLtO3VPnHzaK3PbKS16XmBvHwabnvCxGAxjQxp
        4aUtRej9MBgPfc7NFgKOuyWFgRIbHyiHBBuNL87hqOH1kr93ubzbEZzweZVkCQU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=icWBWV
        Uhboq/krEwKt7XoAoYEg6irXaatNADsnoSJf7jBHufVZc+hjC1hgJ8e+bgpgIW9N
        UQDzH5dbLuFrLUrtZ/RQlf0UDahzlfTI1PKJXgdNGGGySwVZ8VeZgwN/1OR3HEYg
        XW2nt5waNWEFajpiPrIcCXxNhlsrpj65akHD8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A133EA08BC;
        Tue,  8 Aug 2017 18:14:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0A7DDA08BB;
        Tue,  8 Aug 2017 18:14:29 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] builtin/add: add a missing newline to an stderr message
References: <4b0d092f-5a1b-73c7-38fe-48455099bcff@ramsayjones.plus.com>
        <2821200b-0428-a5dd-9680-f291cee0ec47@web.de>
Date:   Tue, 08 Aug 2017 15:14:28 -0700
In-Reply-To: <2821200b-0428-a5dd-9680-f291cee0ec47@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Tue, 8 Aug 2017 23:45:11 +0200")
Message-ID: <xmqqefslaerf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F2E44B3C-7C86-11E7-8BAA-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

>> diff --git a/builtin/add.c b/builtin/add.c
>> index e888fb8c5..385b53ae7 100644
>> --- a/builtin/add.c
>> +++ b/builtin/add.c
>> @@ -43,7 +43,7 @@ static void chmod_pathspec(struct pathspec *pathspec=
, int force_mode)
>>   			continue;
>>  =20
>>   		if (chmod_cache_entry(ce, force_mode) < 0)
>> -			fprintf(stderr, "cannot chmod '%s'", ce->name);
>> +			fprintf(stderr, "cannot chmod '%s'\n", ce->name);
>>   	}
>>   }
>
> FYI: I brought this up yesterday in the original thread, along with a
> few other observations:
>
>   https://public-inbox.org/git/3c61d9f6-e0fd-22a4-68e0-89fd9ce9b944@web=
.de/
>
> Not sure if the discussion can or should be revived after all this
> time, though; just sending patches like yours might be the way to go.

Thanks, so it should become

	fprintf(stderr, "cannot chmod %c '%s'\n", force_mode, ce->name);

in the final version to be queued?

