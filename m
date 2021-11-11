Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8256C433EF
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 20:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A274461002
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 20:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbhKKUaU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Nov 2021 15:30:20 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63610 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbhKKUaT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Nov 2021 15:30:19 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E3C67164750;
        Thu, 11 Nov 2021 15:27:29 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4FnJYsHO4LHJKLWTCkzHQueNXhg0KAfVtPhRax
        ujeuI=; b=YcKBzIUziAFSRwBccxpXYvBd6ZgxddUJCiqtTh5FHFXaZ70YxNgvO9
        6nFWVl2RaMe6Dtvjy1RKv9oLTWFciRqeggUkiLeZ0Mued2yc8eUNfzx5d60biylQ
        r9XZ4x2qgbZyTIw/iGqN//FZAu/B/XJe6Y6c2odv3lmEqC3QSJGSY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DCFBB16474E;
        Thu, 11 Nov 2021 15:27:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 49D2A164748;
        Thu, 11 Nov 2021 15:27:27 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] RelNotes: fix a couple of typos for the upcoming release
References: <pull.1073.git.1636526490570.gitgitgadget@gmail.com>
        <xmqqo86qmvnr.fsf@gitster.g>
        <CABPp-BETy2=J1jNsS_pPpby7Z1P0Yfp92eekMLRicaA=YCL8tQ@mail.gmail.com>
        <xmqqbl2qlam4.fsf@gitster.g>
        <CABPp-BFEo3T48aXW9aas2FJufPp-jf0O73k3JsoTn1=+6cLcpw@mail.gmail.com>
Date:   Thu, 11 Nov 2021 12:27:26 -0800
In-Reply-To: <CABPp-BFEo3T48aXW9aas2FJufPp-jf0O73k3JsoTn1=+6cLcpw@mail.gmail.com>
        (Elijah Newren's message of "Thu, 11 Nov 2021 12:17:47 -0800")
Message-ID: <xmqq35o2l9ox.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C9668122-432D-11EC-AA4A-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Thu, Nov 11, 2021 at 12:07 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Elijah Newren <newren@gmail.com> writes:
>>
>> >> + * "git pull --ff-only" and "git pull --rebase --ff-only" should make
>> >> +   it a no-op to attempt pulling from a remote that is behind us, but
>> >> +   instead the command errored out by saying it was impossible to
>> >> +   fast-forward, which may technically be true, but not a useful thing
>> >> +   to diagnose as an error.  This has been corrected.
>> >> +   (merge 361cb52383 jc/fix-pull-ff-only-when-already-up-to-date later to maint).
>> >
>> > Is this worth calling out in the release notes?  I thought the
>> > discussion elsewhere on this list pointed out that this bug did not
>> > exist in v2.33 or before after all, but rather that it was a
>> > regression that was new to the v2.34 development cycle.
>>
>> The fix itself (i.e. "git pull --ff-only --rebase" when faced with
>> new development on the other side) has already been described in an
>> earlier entry (the third one in "Fixes since v2.33" section) and is
>> in both 2.33.1 and 2.34.0-rc2.  The above entry is about what "git
>> pull -ff-only -rebase" does when the other side lags behind us,
>> which should be and used to be a no-op "already up-to-date" but the
>> earlier fix broke it.  It should be in 2.34 final, and if we were to
>> issue 2.33.2 later, it should go there, too.
>
> Ah, I missed that it was in 2.33.1.  Thanks, and sorry for the noise.

No, careful reading is very much appreciated.
