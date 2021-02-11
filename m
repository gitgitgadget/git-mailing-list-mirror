Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63872C433E0
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 07:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 334EA61490
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 07:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbhBKHbT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Feb 2021 02:31:19 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53574 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhBKHbQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Feb 2021 02:31:16 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B43AE119946;
        Thu, 11 Feb 2021 02:30:32 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zk00zuEu74sgMU73nTVinXM3XpE=; b=wox+kl
        bZD9m8C888++JZjvCAJumVaGebcv6hnx9ynJMRLXKUjrXcqGUm60cJMjFukwryjc
        klrH7wTYwhLRVnzAkVrr8uSn4Kua4aFRro+sKEBK1u711KY9j7/i9EfnXQkD7Nq1
        hKwwEjvxjgv7GlMA/mtEFNEEIDRQHbeB9j2jk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tPAp7lyasA8eZlFb4534lwfoxc+AgNej
        6FfxZ9ZI2yBkH1FZjOzmecTJjQioc1WhNEYTJnBYZx0IpZl9TqjsaNUbo6lWYDmL
        dCmGK2DX4BBliG2dDgyy/4iRQOlm9C0kJvsE8rpenpz57o4CKz4QENB0BYcVuLW5
        L+D+v0E/D4c=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AC64F119945;
        Thu, 11 Feb 2021 02:30:32 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E239F119943;
        Thu, 11 Feb 2021 02:30:29 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin von Zweigbergk <martinvonz@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] docs: clarify that refs/notes/ do not keep the attached
 objects alive
References: <e7fde2369495f32c7aa88c7b6b74ebee1a1bed24.1613000292.git.martinvonz@google.com>
        <xmqqo8grzbjv.fsf@gitster.c.googlers.com>
        <CAESOdVDgpe9yacMxKLO_AjAnadcSjrik_NdwhW-4vDELf+UxPw@mail.gmail.com>
Date:   Wed, 10 Feb 2021 23:30:28 -0800
In-Reply-To: <CAESOdVDgpe9yacMxKLO_AjAnadcSjrik_NdwhW-4vDELf+UxPw@mail.gmail.com>
        (Martin von Zweigbergk's message of "Wed, 10 Feb 2021 21:14:15 -1000")
Message-ID: <xmqqeehnysbv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0481A0AE-6C3B-11EB-8B68-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin von Zweigbergk <martinvonz@google.com> writes:

> Good point. You dropped the bit about the notes (texts) being kept
> alive. I don't know if you did that intentionally are not.

Yes, I did it on purpose, because it is just one of the things that
can be reached from refs/, but we shouldn't write our document for
those like me, who know what notes and other things in Git are.

> I initially
> thought that we should keep that bit, but it's probably not actually
> very useful information. Users probably don't have large amounts of
> information stored in notes, so they probably don't care whether notes
> text is kept, especially since there's no good way of pruning the
> notes.

I am not sure if I agree with any part of the above.  End-user data
is precious no matter the volume, and we keep notes by making them
reachable from refs in the refs/notes/ hierarchy.

I am not sure what qualifies, in your eyes, "good" way, but "git
notes prune" is a good way to remove notes that are attached to
objects that have already been pruned away.

