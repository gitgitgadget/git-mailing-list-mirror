Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A674A1F4B5
	for <e@80x24.org>; Sat, 16 Nov 2019 02:50:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbfKPCun (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 21:50:43 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56230 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727276AbfKPCun (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 21:50:43 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9172298BED;
        Fri, 15 Nov 2019 21:50:41 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tlY+e/+YNil+GyLVq1dR/r4b8sQ=; b=Me/A4+
        IT+wBuKDIq7z5HG9MYnkyl2ANr8IqSJbvkJu7s3F1qDZHY8EStAQJORAdZLzfLWr
        N/qqr9NY3Bp3lcUzQOnSqiYO+ROkiURJTQyr61TYkhFauyY4yOQnSAcmByHp3VJN
        WhVviCniWdyL9fCBr86tntvIbW5nmylhmU/TI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=drUCnQ8c8v4X2u6OTJgGuqiH9D6969zD
        BSb26z9vS5aXaT5211WgTD0Z4ULmF3zqUIeldV+4fHEsqkBs4hX4yXu83/DGY0D5
        yw/Jza53tsQfljUMgg5OdQPpTemgqFnfBfYTAjwXi2hK9epq5mypIfVM+ERKRBkT
        rdw4Uemoe28=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 895EB98BEC;
        Fri, 15 Nov 2019 21:50:41 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B8A5098BEB;
        Fri, 15 Nov 2019 21:50:38 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 01/27] lib-bash.sh: move `then` onto its own line
References: <cover.1573779465.git.liu.denton@gmail.com>
        <b4442fb408c80cf6c4d8fd05b474c0094e243126.1573779465.git.liu.denton@gmail.com>
        <CAPig+cQx=kOZrsR9d05qK9KTnR5X8gAXf0jMysK+njPbX-_6SQ@mail.gmail.com>
Date:   Sat, 16 Nov 2019 11:50:36 +0900
In-Reply-To: <CAPig+cQx=kOZrsR9d05qK9KTnR5X8gAXf0jMysK+njPbX-_6SQ@mail.gmail.com>
        (Eric Sunshine's message of "Fri, 15 Nov 2019 13:22:09 -0500")
Message-ID: <xmqq4kz45ybn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DF0FE5E4-081B-11EA-A21F-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Thu, Nov 14, 2019 at 8:00 PM Denton Liu <liu.denton@gmail.com> wrote:
>> The code style for tests is to have statements on their own line if
>> possible. Move the `then` onto its own line so that it conforms with the
>> test style.
>>
>> Signed-off-by: Denton Liu <liu.denton@gmail.com>
>> ---
>> diff --git a/t/lib-bash.sh b/t/lib-bash.sh
>> @@ -2,7 +2,8 @@
>> -if test -n "$BASH" && test -z "$POSIXLY_CORRECT"; then
>> +if test -n "$BASH" && test -z "$POSIXLY_CORRECT"
>> +then
>
> Okay...
>
>>         # we are in full-on bash mode
>>         true
>>  elif type bash >/dev/null 2>&1; then
>
> ... but why not move this 'then' to its own line, as well?

Good eyes ;-)
