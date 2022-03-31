Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 237B0C433EF
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 17:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbiCaRo6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Mar 2022 13:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiCaRo5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Mar 2022 13:44:57 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DF41AA8D7
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 10:43:09 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 51130112804;
        Thu, 31 Mar 2022 13:43:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Ey93OvqIX8t4
        P2geyWsT5O7in3qk+3ZON8K7+EM2QoU=; b=k1u4qcGAjT+bbB8Mo0/Qieu8yY+V
        /dDvToJajU3KZwvDYTX63T6wlWEWRfMokzyYUWWTza1WcgTAmQ3KjA2JO1fwoWXn
        eC9i1MLnMT6NQUpPpmCAH3rUoy26p8KWG6mcJojln5df+JR5AIY1sLfZ+gcucyEA
        Elh3XibIoFR3g7I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3B5F3112803;
        Thu, 31 Mar 2022 13:43:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4D0D81127FD;
        Thu, 31 Mar 2022 13:43:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 3/4] builtin/stash: provide a way to export stashes
 to a ref
References: <20220310173236.4165310-1-sandals@crustytoothpaste.net>
        <20220329214941.2018609-1-sandals@crustytoothpaste.net>
        <20220329214941.2018609-4-sandals@crustytoothpaste.net>
        <220331.86pmm2swm9.gmgdl@evledraar.gmail.com>
Date:   Thu, 31 Mar 2022 10:43:04 -0700
In-Reply-To: <220331.86pmm2swm9.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 31 Mar 2022 03:56:01 +0200")
Message-ID: <xmqq7d8a3tnb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 05D38A4C-B11A-11EC-9F18-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> @@ -151,6 +152,12 @@ store::
>>  	reflog.  This is intended to be useful for scripts.  It is
>>  	probably not the command you want to use; see "push" above.
>> =20
>> +export ( --print | --to-ref <ref> ) [<stash>...]::
>> +
>
> I think this extra \n here isn't needed.

I wrote the same in my review on one of the previous rounds, but
removed it before sending it out, because this is better with than
without.  The blank line isn't necessary but does not hurt.  And
other existing entries in this file seem to have them consistently.

Thanks for carefully reading the posted patch.
