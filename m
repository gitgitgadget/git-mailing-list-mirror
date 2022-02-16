Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3649DC433EF
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 01:51:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245722AbiBPBv5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 20:51:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235171AbiBPBvw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 20:51:52 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1D02655B
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 17:51:41 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CF1AA18D85E;
        Tue, 15 Feb 2022 20:51:40 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wct1yEa2zwlsWAU21W5T0zaz0QemY6a5ahHgcW
        qgszo=; b=LOEJkbZiEnBrGScRFILW3xgsTavknSFrb5OVWWDy57WpkzSO0XiZzh
        fZPwf3YHB9c3RbJcl1ENYtaMBEfYPl3m6ljTg+9DVR3+jRk+TqfYF2Uej49qCBun
        Y0dx6HI2zfptQgaFuLL2PcakgSY4Tr6LtmsavXICWuPFP79pcB77M=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C5FAB18D85D;
        Tue, 15 Feb 2022 20:51:40 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3171518D85C;
        Tue, 15 Feb 2022 20:51:38 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Sean Allred <allred.sean@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v6 1/6] Documentation: add extensions.worktreeConfig
 details
References: <pull.1101.v5.git.1643641259.gitgitgadget@gmail.com>
        <pull.1101.v6.git.1644269583.gitgitgadget@gmail.com>
        <0260ff6cac0c76c6d66187d77defef1edd4c6fb5.1644269583.git.gitgitgadget@gmail.com>
        <xmqqo83hatm1.fsf@gitster.g>
        <11bf1541-c46a-fcf5-f8d4-0d144b942d59@gmail.com>
        <CAPig+cSY7E_XQC1gHzDJxoDGGmgWDmNz9Ys=CwbhLkCt+DQf-A@mail.gmail.com>
Date:   Tue, 15 Feb 2022 17:51:36 -0800
In-Reply-To: <CAPig+cSY7E_XQC1gHzDJxoDGGmgWDmNz9Ys=CwbhLkCt+DQf-A@mail.gmail.com>
        (Eric Sunshine's message of "Tue, 15 Feb 2022 15:37:59 -0500")
Message-ID: <xmqq4k4zy3x3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FAB26E88-8ECA-11EC-914C-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

>> I generally agree. This was changed in the most-recent re-roll
>> based on a request by Eric [1]. I'm happy to take whichever
>> version the two of you settle on.
>>
>> [1] https://lore.kernel.org/git/CAPig+cS-3CxxyPGcy_vkeN_WYTRo1b-ZhJNdPy8ARZSNKkF1Xg@mail.gmail.com/
>
> "request" is perhaps too strong a word considering that I led in with:
>
>     A few minor comments, which can be addressed later or not
>     at all, and likely are not worth holding up the series...
>
> I mentioned "worktree vs. working tree" only to point out the
> terminology inconsistency being introduced by the new patch; the same
> sort of inconsistency which had bothered Michael Haggerty enough to do
> something about it in bc483285b7 (Documentation/git-worktree:
> consistently use term "linked working tree", 2015-07-20).

Yup, it seems both of us found mixed use of these two terms
disturbing.  Michael's old commit was mostly about "worktree" vs
"working tree", even though 2 changes among 13 changes to the file
were about updating "working directory" to "working tree", and to me
it seems to made the terminology straightened up.  E.g. a hunk from
the change uses "a linked working tree and its administrative files"

    -- `remove` to remove a linked worktree and its administrative files (and
    -  warn if the worktree is dirty)
    -- `mv` to move or rename a worktree and update its administrative files
    -- `list` to list linked worktrees
    +- `remove` to remove a linked working tree and its administrative files (and
    +  warn if the working tree is dirty)
    +- `mv` to move or rename a working tree and update its administrative files
    +- `list` to list linked working trees
     - `lock` to prevent automatic pruning of administrative files (for instance,
    -  for a worktree on a portable device)
    +  for a working tree on a portable device)

which clearly refers to things above .git as "working tree".

> I, personally, prefer the term "worktree" for both convenience and
> because it better encapsulates the overall "thing" which is
> manipulated by the git-worktree command unlike the term "working tree"
> which, as Junio points out, has (perhaps) a more narrow meaning. As
> such, I would not be opposed to a patch series which changes "working
> tree" to "worktree" in documentation where appropriate, but that's
> outside the scope of this series.

I would welcome such changes where appropriate in both directions (I
think I updated a few places in the glossary).  I agree that this
topic is not a place to do so.
