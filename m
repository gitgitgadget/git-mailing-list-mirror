Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE8D4C433ED
	for <git@archiver.kernel.org>; Tue, 18 May 2021 00:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88DC96139A
	for <git@archiver.kernel.org>; Tue, 18 May 2021 00:44:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345102AbhERAp5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 20:45:57 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50264 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232332AbhERAp4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 20:45:56 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B86AF135596;
        Mon, 17 May 2021 20:44:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+mO3tqtxHRJ5tGrXy9cXJusaxynJpYNN7DIw0m
        SV4rM=; b=fR5/U6+1e9hq/oXRoA0khdT/e+HeWc1+aU7YI5Wa4gS5GQVmuNp+OX
        as+qgcypYDnCDO6BD9/W/oMyINixFcFxxjy1AnAmWAG6Sjz23OIi5GT3im0FLQzM
        E9IhPU2WIF6HCMtJ9kncxHb0tDtB0jXoDbMrB0mFgz51tNYsU7Cp8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B110A135595;
        Mon, 17 May 2021 20:44:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 06F4D135594;
        Mon, 17 May 2021 20:44:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     jonathantanmy@google.com
Cc:     git@vger.kernel.org, Teng Long <dyroneteng@gmail.com>
Subject: Re: packfile-uri.txt: fix blobPackfileUri description
References: <20210506073354.27833-1-dyroneteng@gmail.com>
        <20210513071547.64367-1-dyroneteng@gmail.com>
        <xmqq8s4i9v42.fsf@gitster.g>
Date:   Tue, 18 May 2021 09:44:35 +0900
In-Reply-To: <xmqq8s4i9v42.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        14 May 2021 06:33:49 +0900")
Message-ID: <xmqq8s4c6fbg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 38B49250-B772-11EB-B5D0-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Teng Long <dyroneteng@gmail.com> writes:
>
>> Fix the 'uploadpack.blobPackfileUri' description in packfile-uri.txt
>> and the correct format also can be seen in t5702.
>>
>> Signed-off-by: Teng Long <dyroneteng@gmail.com>
>> ---
>>  Documentation/technical/packfile-uri.txt | 15 ++++++++-------
>>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> Will queue; thanks.
>
> Jonathan, how does this look?

Ping?

>> diff --git a/Documentation/technical/packfile-uri.txt b/Documentation/technical/packfile-uri.txt
>> index f7eabc6c76..1eb525fe76 100644
>> --- a/Documentation/technical/packfile-uri.txt
>> +++ b/Documentation/technical/packfile-uri.txt
>> @@ -35,13 +35,14 @@ include some sort of non-trivial implementation in the Minimum Viable Product,
>>  at least so that we can test the client.
>>  
>>  This is the implementation: a feature, marked experimental, that allows the
>> -server to be configured by one or more `uploadpack.blobPackfileUri=<sha1>
>> -<uri>` entries. Whenever the list of objects to be sent is assembled, all such
>> -blobs are excluded, replaced with URIs. As noted in "Future work" below, the
>> -server can evolve in the future to support excluding other objects (or other
>> -implementations of servers could be made that support excluding other objects)
>> -without needing a protocol change, so clients should not expect that packfiles
>> -downloaded in this way only contain single blobs.
>> +server to be configured by one or more `uploadpack.blobPackfileUri=
>> +<object-hash> <pack-hash> <uri>` entries. Whenever the list of objects to be
>> +sent is assembled, all such blobs are excluded, replaced with URIs. As noted
>> +in "Future work" below, the server can evolve in the future to support
>> +excluding other objects (or other implementations of servers could be made
>> +that support excluding other objects) without needing a protocol change, so
>> +clients should not expect that packfiles downloaded in this way only contain
>> +single blobs.
>>  
>>  Client design
>>  -------------
