Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB0CC433EF
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 00:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93B3960F9B
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 00:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbhJ1Ad1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 20:33:27 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64689 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbhJ1Ad1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 20:33:27 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 26D1315BD17;
        Wed, 27 Oct 2021 20:31:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MdED1PcrJKI4v1uINZ3N4zAoWKBgUrJqVD49yD
        gj+Wk=; b=naPrMK4aPyTPUZ1DzHjGgUqk9q5+bUAAw2F4gK6oTmXWvGGsJ8af5n
        vMm2mZx/JOcfENYo5ArW0QqAdAdN369fQOclenpugg3GI4+9NDX+5bJw6rqeyFzM
        8Ywizt/8lzafmJdsi3t0LhfzYYKW0OGTJ3bZfUi1B2XFjhgGBrL5I=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1279A15BD16;
        Wed, 27 Oct 2021 20:31:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6000215BD14;
        Wed, 27 Oct 2021 20:30:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Neeraj Singh <nksingh85@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org, "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH 0/2] tmp-objdir: fix regressions in
 core.fsyncobjectfiles=batch
References: <pull.1067.git.1635287730.gitgitgadget@gmail.com>
        <nycvar.QRO.7.76.6.2110271439120.56@tvgsbejvaqbjf.bet>
        <xmqqo87auqda.fsf@gitster.g>
        <20211027225706.GA3984@neerajsi-x1.localdomain>
Date:   Wed, 27 Oct 2021 17:30:57 -0700
In-Reply-To: <20211027225706.GA3984@neerajsi-x1.localdomain> (Neeraj Singh's
        message of "Wed, 27 Oct 2021 15:57:06 -0700")
Message-ID: <xmqqcznqt2gu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 521812A0-3786-11EC-AF7E-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Neeraj Singh <nksingh85@gmail.com> writes:

> On Wed, Oct 27, 2021 at 02:09:21PM -0700, Junio C Hamano wrote:
>> Yeah, none of the above is attractive this late in the cycle X-<.
>> 
>> It probalby is best to queue the "fixup!" commits as they are on top
>> of ns/tmp-objdir, merge the result to two topics that depend on
>> ns/tmp-objdir, and keep them without merging them down, until the
>> release.  When it is time to rewind 'next' after the release, it
>> would be a good chance to get rid of these "oops, earlier we screwed
>> up" commits by redoing the tmp-objdir (and rebasing the other two
>> topics on top).
>> 
>
> Hi Junio,
> Apologies for the breakage! I just want to be 100% clear here: is there
> any action I should take with the patches, or will you handle the merge/rebase?

If we all agree on the above plan, then nothing for you for now, but
we'd ask you to send a cleaned-up patch after the upcoming release
when the 'next' branch gets rewound and rebuilt, at which time we
can get rid of the "oops, we screwed up" fixup patches.

Thanks for finding and sending in the fix.

