Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1032AC4338F
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 16:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBB0961019
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 16:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233595AbhHIQtb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Aug 2021 12:49:31 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61472 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233175AbhHIQta (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Aug 2021 12:49:30 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9780A15E661;
        Mon,  9 Aug 2021 12:49:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=zDzcu09MZxXO
        G26YhFsdNfRw5LpUvxwMg4tbrHRf9lk=; b=qvT5w1GiPuM4DF+A8UrgdUkeSuqw
        AKufu2YonO6ykpMJCxTEEiV7D70G0e5AMqvc/GjN9VBTCiLK1eNGRqKShfUNjTTm
        ZjjpNOek3seJvIFCjOWvAFKQHWOLjvrE0aJosVoh/5PWcVM56+0qj0/JUwehpDOH
        hvDLMnHMx6oiOjk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8F94415E660;
        Mon,  9 Aug 2021 12:49:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DA99515E65F;
        Mon,  9 Aug 2021 12:49:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        git@vger.kernel.org, jeffhost@microsoft.com
Subject: Re: [PATCH 0/2] fsmonitor: fixup to avoid warnings from pedantic
References: <20210809063004.73736-1-carenas@gmail.com>
        <42dce285-9599-4c7c-d351-44c1e338337e@jeffhostetler.com>
Date:   Mon, 09 Aug 2021 09:49:05 -0700
In-Reply-To: <42dce285-9599-4c7c-d351-44c1e338337e@jeffhostetler.com> (Jeff
        Hostetler's message of "Mon, 9 Aug 2021 10:34:38 -0400")
Message-ID: <xmqqpmumftry.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B61EDC54-F931-11EB-BD77-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> On 8/9/21 2:30 AM, Carlo Marcelo Arenas Bel=C3=B3n wrote:
>> seen with both clang 12 and gcc 11 in seen (including jh/builtin-fsmon=
itor)
>> as of a5a42b9f76 (from Jul 1)
>> it should be squashed into the corresponding patch from the series
>> as shown
>> in the subject and reroll IMHO; notice Junio also has some bandaid spa=
rse
>> fixes for t/helper/test-touch.c that should be included.
>> a similar additional fix for C89 compatibility to be send as a reply
>> later
>> Carlo Marcelo Arenas Bel=C3=B3n (2):
>>    fixup! fsmonitor-ipc: create client routines for git-fsmonitor--dae=
mon
>>    fixup! fsmonitor--daemon: implement handle_client callback
>>   builtin/fsmonitor--daemon.c | 2 +-
>>   fsmonitor-ipc.h             | 2 ++
>>   2 files changed, 3 insertions(+), 1 deletion(-)
>>=20
>
> Thanks!

Thanks, both. =20

Jeff, I understand that this is planned to be rerolled post release,
so I'll not touch these fixups and let yuou worry about them ;-)

