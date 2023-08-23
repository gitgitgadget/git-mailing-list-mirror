Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87DA9EE49A5
	for <git@archiver.kernel.org>; Wed, 23 Aug 2023 01:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbjHWBzM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Aug 2023 21:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbjHWBzL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2023 21:55:11 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C739BE4D
        for <git@vger.kernel.org>; Tue, 22 Aug 2023 18:55:06 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2BD7C3FB5F;
        Tue, 22 Aug 2023 21:55:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LasfjCAnZ/9d5lalNQ6AeCiAokduSD73lkqXZ2
        dbcV0=; b=EI0UL5z0k+fmnd8SuH0hLrpSfyGzQ2WdXdpyd7YCkpdnu/nO/62pi/
        psWazzB2vqX5lYVxS9eaytT02+5o+xR0qvWy9Lye++GKC1ggPRb+khTmT83zlWTk
        BM8H1mWkIEg08u2o64zJpBNovUhEEOIT8r8oz+bJFwmz+rJeAHC4A=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 245143FB5E;
        Tue, 22 Aug 2023 21:55:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 17CD23FB5A;
        Tue, 22 Aug 2023 21:55:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Santiago <taylorsantiago@google.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 1/1] Fix the order of consuming unpackLimit config
 settings.
References: <20230817215325.2550998-1-taylorsantiago@google.com>
        <20230817215325.2550998-2-taylorsantiago@google.com>
        <20230821203051.GA1800481@coredump.intra.peff.net>
        <xmqqttsrn9l2.fsf@gitster.g>
        <CAKacvadS8X_nb6Z=yub9eJ54hRYWq4B7CYrWaw=uXBY8dPChYA@mail.gmail.com>
Date:   Tue, 22 Aug 2023 18:55:01 -0700
In-Reply-To: <CAKacvadS8X_nb6Z=yub9eJ54hRYWq4B7CYrWaw=uXBY8dPChYA@mail.gmail.com>
        (Taylor Santiago's message of "Tue, 22 Aug 2023 06:00:20 -0700")
Message-ID: <xmqqcyzeh6a2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 13430160-4158-11EE-9C0F-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Santiago <taylorsantiago@google.com> writes:

> Thank you! How would you like me to proceed? Should I submit the above as a
> v2 of the earlier patch?

There is nothing "above" as you seem to be top posting ;-)

When somebody else helps by supplying an "squashable" patch, often
people are expected to review it and then update their patch(es)
using the given material to produce a v2.

But as I said, the "squashable" one was only about the receive-pack
side; even if you combined it with your original, tests for the
fetch side were still missing, so it was not sufficient for a v2.

As I didn't see your reply message (to which I am responding to)
until now, mostly because it was dropped by the mailing list
(perhaps it was an HTML e-mail from GMail or something???), I've
further worked on the tests to cover the fetch side and sent out a
full version (not a squashable, but just a replacement for the whole
thing).  It is archived and viewable at

  https://lore.kernel.org/git/xmqqpm3eh7f6.fsf@gitster.g

Part of it is still your original patch, some material in its
proposed commit log message was given by Peff, and the rest was
written by me, so it carries names of three people.

If the result looks acceptable to you, then saying "Yup, that looks
good" would be the simplest answer to give to move things forward.

Thanks.
