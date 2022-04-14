Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E183C433F5
	for <git@archiver.kernel.org>; Thu, 14 Apr 2022 18:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344267AbiDNSfm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Apr 2022 14:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242401AbiDNSfm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Apr 2022 14:35:42 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29AA4EA749
        for <git@vger.kernel.org>; Thu, 14 Apr 2022 11:33:16 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6295710E780;
        Thu, 14 Apr 2022 14:33:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=wzhPZUx0F1VM
        TfNDYN+XEjnRi72Ti7el3OxJSXjcZjc=; b=fMuz8rZmTTaWjMEl4/9/Ub66wzOQ
        4uejybO793fJhptj/KneyTkW5nuZJW9T6Z94f2S9xVFWY5Ly23povt+FFVzdiqHE
        GmOC4YKUPAgrLontnNukObIn/r8GELXlh5rN4VnSb4RBSb/ejti+jhCobtQfIQwQ
        ddHrM/NDdGeKc8I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5867010E77F;
        Thu, 14 Apr 2022 14:33:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B8A9D10E77E;
        Thu, 14 Apr 2022 14:33:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: ab/plug-leak-in-revisions
References: <xmqq8rsab5do.fsf@gitster.g>
        <220413.86bkx4eobr.gmgdl@evledraar.gmail.com>
        <xmqq35ig5zlf.fsf@gitster.g>
        <220414.86y208cen7.gmgdl@evledraar.gmail.com>
Date:   Thu, 14 Apr 2022 11:33:12 -0700
In-Reply-To: <220414.86y208cen7.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 14 Apr 2022 09:22:31 +0200")
Message-ID: <xmqqv8vbzf9z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 57FBD344-BC21-11EC-BD94-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Wed, Apr 13 2022, Junio C Hamano wrote:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>
>>> I think it should be ready with my just-submitted re-roll, which fixe=
s a
>>> trivial nit spotted by Phillip Wood by removing a useless NULL check:
>>> https://lore.kernel.org/git/cover-v6-00.27-00000000000-20220413T19593=
5Z-avarab@gmail.com/
>>
>> Last time I checked, the last three patches haven't made to the lore
>> archive yet.  We have other things to do while waiting for them, so
>> there is no need to rush or resend ;-)
>
> git-send-email died at the end of that send, I picked up where I left
> off and sent the remaining three.

Thanks.  All replaced and the change from the previous round was as
expected.

Looking great.


