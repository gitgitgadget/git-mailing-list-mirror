Return-Path: <SRS0=GnTn=7I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F24EFC433DF
	for <git@archiver.kernel.org>; Tue, 26 May 2020 15:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7CA220776
	for <git@archiver.kernel.org>; Tue, 26 May 2020 15:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cfrU7MvJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbgEZPQL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 May 2020 11:16:11 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55302 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727921AbgEZPQL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 May 2020 11:16:11 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9E1F5C050F;
        Tue, 26 May 2020 11:16:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=/zjwMSkNTcuM
        a/J92uHWlG83YFE=; b=cfrU7MvJFbAh+eKYt5P8ZtshJKq8DwrygX/n3WrlzNKz
        aAJ71+FsloqwyjN7BSE7g9hoOmgpo+pL5K9ChVU1MXP9tL1RJP+VofHXtGgQ2ccw
        F8XJiwwOrVs8hzK5fqciZ9XyeCQysLFbbMRR4v5I8S7deFStr+1PbwQv8oEQLTc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ZUEvFs
        n4tLkJ4eNEQXfqIH/RFVYIsj/mEjG0zHB7hcnCBKZcXwhX8zkERccdyI9TOQ+Yr2
        PmNcxXdweOGZCzVbETNk0jdOyfm3Gq1WJqje8Cmfa/zvtS5KVjmA6CBgp5tgxKUe
        L1N18zw0v6i3tNTxzPjuQFmPdr0rFFODDYLzU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 963E0C050E;
        Tue, 26 May 2020 11:16:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D7A58C050D;
        Tue, 26 May 2020 11:16:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2] rev-list-options.txt: start a list for `show-pulls`
References: <xmqqsgfx0z9k.fsf@gitster.c.googlers.com>
        <20200525170607.8000-1-martin.agren@gmail.com>
Date:   Tue, 26 May 2020 08:16:04 -0700
In-Reply-To: <20200525170607.8000-1-martin.agren@gmail.com> ("Martin
 =?utf-8?Q?=C3=85gren=22's?=
        message of "Mon, 25 May 2020 19:06:07 +0200")
Message-ID: <xmqqv9kiohfv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D26A7798-9F63-11EA-A371-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> Let's start a list for `--show-pulls` where we start actually discussin=
g
> the option, and keep the paragraphs preceding it out of that list. That
> is, drop all those pluses before the new list we're adding here.

The way the "History Simplification" section is organized is
somewhat peculiar in that it begins with a short list of what's
available, followed by mixture of detailed explanation in prose.  I
agree with you two that the result of this patch fits very well to
the surrounding text.

This is not a new issue introduced by this patch, but ...

> +--show-pulls::
> +	In addition to the commits shown in the default history, show
> +	each merge commit that is not TREESAME to its first parent but
> +	is TREESAME to a later parent.
>  +
> +When a merge commit is included by `--show-pulls`, the merge is
>  treated as if it "pulled" the change from another branch. When using
>  `--show-pulls` on this example (and no other options) the resulting
>  graph is:

... "is treated AS IF" somewhat made me go "huh?"; with or without
the option, the merge did pull the change from another branch,
didn't it?  The only effect the option has is to make that fact
stand out in the output.

But rewording it is another topic totally different from "we should
render this section correctly" fix we have here, and should be done
(if it needs to be done in the first place) separately after this
change lands.

Thanks, both.
