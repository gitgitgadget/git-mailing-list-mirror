Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B6CE1FF7F
	for <e@80x24.org>; Wed,  7 Dec 2016 22:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933345AbcLGWER (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 17:04:17 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61918 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932777AbcLGWEO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 17:04:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 734D557AD2;
        Wed,  7 Dec 2016 17:04:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cnzAAQ+8FJUcmDcoZUMJGFNRYqE=; b=vlWR3x
        106jKel6n7ax0KKRXz3oAqJLITjynft/6YB4F4gDJR8bdYDohKsBbzQFEeKCBxTw
        urgS/m68MNMD28aNsr6VGXRK7XiPKi8xSlfUHgnqm5kmL2zoeJ2+qoZYsrR8vyDl
        iIVtaGo4xPBuc7PM1zkxiGR+x5hWAzh2sa410=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jNSadibZkJxqvS8yiHhikDrVf4cpAwRJ
        C3xHKUiJYcAEFfaSHzKhwKS6CCR2HPfDEao8PEzqapGvIXuImRTrNI+Lws5SUbee
        ChX40RlvlgPK3GSrEeZb36sFN1S8w05M5y8hsaS4qs99PPomzsNbyt9fCSWh9If7
        ixSrCMF67YM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6340757AD1;
        Wed,  7 Dec 2016 17:04:13 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E387E57AD0;
        Wed,  7 Dec 2016 17:04:12 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 16/17] pathspec: small readability changes
References: <1481061106-117775-1-git-send-email-bmwill@google.com>
        <1481061106-117775-17-git-send-email-bmwill@google.com>
        <CACsJy8B6Mj-L1t-CETY5DWRyABHZsYZszwXD3dgUqChfXRB6FA@mail.gmail.com>
Date:   Wed, 07 Dec 2016 14:04:11 -0800
In-Reply-To: <CACsJy8B6Mj-L1t-CETY5DWRyABHZsYZszwXD3dgUqChfXRB6FA@mail.gmail.com>
        (Duy Nguyen's message of "Wed, 7 Dec 2016 20:04:52 +0700")
Message-ID: <xmqqinqvwg4k.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 16455A2C-BCC9-11E6-9E56-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Wed, Dec 7, 2016 at 4:51 AM, Brandon Williams <bmwill@google.com> wrote:
>> A few small changes to improve readability.  This is done by grouping related
>> assignments, adding blank lines, ensuring lines are <80 characters, etc.
>>
>> Signed-off-by: Brandon Williams <bmwill@google.com>
>> ---
>>  pathspec.c | 15 ++++++++++-----
>>  1 file changed, 10 insertions(+), 5 deletions(-)
>>
>> diff --git a/pathspec.c b/pathspec.c
>> index 41aa213..8a07b02 100644
>> --- a/pathspec.c
>> +++ b/pathspec.c
>> @@ -334,6 +334,7 @@ static unsigned prefix_pathspec(struct pathspec_item *item,
>
> btw, since this function has stopped being "just prefix pathspec" for
> a long time, perhaps rename it to parse_pathspec_item, or something.

Not specifically responding to this comment, but thanks for all the
constructive feedback messages.
