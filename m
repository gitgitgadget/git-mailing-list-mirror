Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EAE0C433F5
	for <git@archiver.kernel.org>; Thu,  5 May 2022 19:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385177AbiEEThT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 May 2022 15:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344161AbiEEThJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 May 2022 15:37:09 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972CF5B3D5
        for <git@vger.kernel.org>; Thu,  5 May 2022 12:33:28 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8C8AF12796A;
        Thu,  5 May 2022 15:33:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+qo4TPhJv6suxlFzNQ/+pT8QRszqAdtF5acF0x
        8J2i4=; b=YBkAJEtUl8fXaUABGAoL+I3dsFoVeD+pNFyJVfcR28Bat3lK3U4pSO
        oPip4DhzXJQydqKmofJcJDYs0gy4JNT/kYIpjzxUaQNF+m6RVEf1rkfWPooBay/u
        /SdyYLLeWGz0LJJfBfGpmQWz2vE4H/rTOJ1tj0NFZ3c9nKrE14PuY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 82990127969;
        Thu,  5 May 2022 15:33:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D9402127968;
        Thu,  5 May 2022 15:33:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Git Mailing List <git@vger.kernel.org>,
        Victoria Dye <vdye@github.com>
Subject: Re: What's cooking in git.git (May 2022, #01; Mon, 2)
References: <xmqqilqnvacd.fsf@gitster.g>
        <0facc01f-ee36-333a-eb25-9c98d616700e@github.com>
        <xmqqy1zhmftk.fsf@gitster.g>
        <CABPp-BHDKRX4sW_Jjqw5j7Voas0X_xkFZgg5Jqk0TkNZOd7k1g@mail.gmail.com>
        <xmqqmtfwezx5.fsf@gitster.g>
        <CABPp-BH8VsH+Y3UxAvZM2kua8XGRE1RyenrESeYwofcq-=kjbQ@mail.gmail.com>
        <CABPp-BF9ftVVp7-ZZuhak456x12-H941Nj4qV7gNf71rrugGhQ@mail.gmail.com>
Date:   Thu, 05 May 2022 12:33:25 -0700
In-Reply-To: <CABPp-BF9ftVVp7-ZZuhak456x12-H941Nj4qV7gNf71rrugGhQ@mail.gmail.com>
        (Elijah Newren's message of "Thu, 5 May 2022 11:53:47 -0700")
Message-ID: <xmqqh763dbay.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3C41FEF0-CCAA-11EC-9A8A-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Thu, May 5, 2022 at 9:15 AM Elijah Newren <newren@gmail.com> wrote:
>>
>> On Thu, May 5, 2022 at 8:56 AM Junio C Hamano <gitster@pobox.com> wrote:
>> >
> [...]
>> > I vaguely recall there were folks who didn't like the change of
>> > default the last time you brought this topic up.  Convincing them is
>> > not my job---it is yours.  Mine has been to help prepare the code
>> > ready for public consumption when that happens.
>>
>> That's a surprise to me; I don't remember anyone bringing that up,
>> ever.  Did I somehow miss it??  I'd be happy to talk to anyone and
>> hear their concerns if they do hold such an opinion.  Over the last
>> year or so both Stolee and Victoria have suggested such a change or
>> said they wondered why I didn't include such a change with other
>> sparse-checkout changes we were making, and I mentioned a few times I
>> thought it'd be a good future plan and finally submitted it.  To the
>> best of my memory, no one ever offered a counter opinion.
>>
>> Are you perhaps mixing this up with the case where people brought up
>> concerns with suggested tab-completion changes?  That's the only other
>> related series recently where folks brought up concerns with suggested
>> changes.
>
> So, I did a few searches through the list history for anyone that may
> have commented on cone mode as default.  The only comments I can find
> are Stolee, Victoria, Lessley, and I being in favor.

OK, so I misremembered.  Let's hope that the list subscriber base is
wide enough and those who will be affected are all in favor, and see
how the reception by those who are not on the list goes.

Hopefully some organizations may have a canary channel for their
users to try out something based on 'next', and we will hear from
them, either positive or negative, about their experience.

