Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88DB4EB64DA
	for <git@archiver.kernel.org>; Wed, 12 Jul 2023 15:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233626AbjGLPTT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jul 2023 11:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233677AbjGLPTF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2023 11:19:05 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49A72701
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 08:18:49 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1BBF332C74;
        Wed, 12 Jul 2023 11:18:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iydZJHX61HjyVJR46sNzZ6ZqlOzEsGP+JKXUeY
        lG2WI=; b=B25D4U86kV4Oodyi31E0FWoFkDl03CGbI3O8ueccXPYNKVk+bZAznV
        R0COTfbKnlimfUqeAlPSywJ2iV2D8ls8A1A2sVwRDGC00Wa/BCQyFTKqbBJMjeJE
        6cSURPoLikGVfZraJx+sQvycF93D0OHvxrvLXXhR4QLk+cHUXlXKQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1367132C73;
        Wed, 12 Jul 2023 11:18:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 89F1532C71;
        Wed, 12 Jul 2023 11:18:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, git@matthieu-moy.fr, christiwald@gmail.com,
        john@keeping.me.uk, philipoakley@iee.email,
        phillip.wood123@gmail.com, phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 1/2] remote: advise about force-pushing as an
 alternative to reconciliation
References: <20230704194756.166111-1-alexhenrie24@gmail.com>
        <20230706040111.81110-1-alexhenrie24@gmail.com>
        <20230706040111.81110-2-alexhenrie24@gmail.com>
        <xmqqttugbxds.fsf@gitster.g> <xmqqo7kobwpj.fsf@gitster.g>
        <CAMMLpeS9_P=XXMoOdTAM3jZbaxfLEJNwYArS6p9pMXisT3TRtw@mail.gmail.com>
        <xmqq8rbra9ti.fsf@gitster.g>
        <CAMMLpeQ2P+qQxo17dEdWhMHcmAfTiBoEifp2wUjWVrP+oGSzxQ@mail.gmail.com>
        <xmqqbkgl6f04.fsf@gitster.g>
        <CAMMLpeSwadTcd+z0-J1t=vUgz0wFiVaE5KaT-Wy1cckT3=fFGQ@mail.gmail.com>
        <xmqqsf9v2roa.fsf@gitster.g>
        <CAMMLpeTNMaVk7M2nLSJJzDMWPDVdyOr27Ae2-Usky5tW-dRqJQ@mail.gmail.com>
Importance: high
Date:   Wed, 12 Jul 2023 08:18:10 -0700
In-Reply-To: <CAMMLpeTNMaVk7M2nLSJJzDMWPDVdyOr27Ae2-Usky5tW-dRqJQ@mail.gmail.com>
        (Alex Henrie's message of "Tue, 11 Jul 2023 22:47:00 -0600")
Message-ID: <xmqqo7khupjh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5112A074-20C7-11EE-955A-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> Just to be sure that we're on the same page, when I said "I thought we
> just agreed that we don't need to mention force-pushing..." and you
> replied "I do not think so", were you only saying that you think that
> changes to `git commit` are essential, or were you also saying that we
> have not come to an agreement about whether to include force-pushing
> advice in this message?

None of the above ;-)

With that "I do not think so", I meant that I do not agree with "I
guess you're saying that we'd still be over-encouraging `git pull`"
that was in your message.  In the message you were responding to, I
was saying that the time the user runs `git commit` is not a good
time for the user to decide how to eventually update the remote
target, and it does not matter which one we encourage more between
"`git pull [--rebase]` then `git push`" and "`git push --force`".

I am fine dropping patch [1/2]; we would not be touching output from
"git status", "git commit", or "git checkout", and "we should not
talk about 'git pull' (or how the eventual remote update should go,
for that matter) when we notice that the base of the user's branch
has become stale" becomes totally out of the scope of this topic.  I
think that we all are in agreement that [2/2] is the more important
part of this topic, as it more directly improves the guidance for
the end-users when their "push" triggers the non-ff check.

Thanks.
