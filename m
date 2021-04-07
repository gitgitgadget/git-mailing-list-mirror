Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BBF1C433ED
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 02:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30F0E6124B
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 02:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239083AbhDGCg3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Apr 2021 22:36:29 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63815 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233994AbhDGCg3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Apr 2021 22:36:29 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 471F91204E6;
        Tue,  6 Apr 2021 22:36:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3DVy6+8kQOYGnizAOxHjx7JehHs=; b=eH0YeG
        gLqWmOFhjiscINBuogHdJ37STeBIbLueqJ0p/aavUaXHP6xLzRxE9QbqgoVmMxvR
        4qmVz6gVlUK2gc1CHgF6uDAW6cRVg8P4iM8g/SFL60WvmhdUBnf5vlf0T/OUmm0t
        ra3WrrKUSNQ2214e2MT1hyDkJXeFYNKV3IwOE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bZvD8OTVkrxlHE5FTUmfnZxvFjN0X7vB
        dNcW7Uh1axg4Sa3T1kc1fW3yu0IMPyTvusF2EQ9bT1RapJL+c7+HRuJpcgHZ5kvw
        JcKqsoe62e8wDWB+TPbYmlAT+3pzBmruFdDX/FP5bURNLDdpaw1+6ucTigbb1B+c
        Pc/PX6jKVyk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3F6A81204E5;
        Tue,  6 Apr 2021 22:36:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8BA4A1204A9;
        Tue,  6 Apr 2021 22:36:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v8 37/37] docs: unify githooks and git-hook manpages
References: <20210311021037.3001235-1-emilyshaffer@google.com>
        <20210311021037.3001235-38-emilyshaffer@google.com>
Date:   Tue, 06 Apr 2021 19:36:15 -0700
In-Reply-To: <20210311021037.3001235-38-emilyshaffer@google.com> (Emily
        Shaffer's message of "Wed, 10 Mar 2021 18:10:37 -0800")
Message-ID: <xmqq5z0y2540.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 079A37DA-974A-11EB-849A-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> By showing the list of all hooks in 'git help hook' for users to refer
> to, 'git help hook' becomes a one-stop shop for hook authorship. Since
> some may still have muscle memory for 'git help githooks', though,
> reference the 'git hook' commands and otherwise don't remove content.
>
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
>  Documentation/git-hook.txt     |  11 +
>  Documentation/githooks.txt     | 716 +--------------------------------
>  Documentation/native-hooks.txt | 708 ++++++++++++++++++++++++++++++++
>  3 files changed, 724 insertions(+), 711 deletions(-)
>  create mode 100644 Documentation/native-hooks.txt

While this would be a very good move when this were the only topic
juggling the hook related documentation, in the real world, it
creates rather nasty "ouch, the original hooks document was updated,
and we need to carry these changes over to the new native-hooks
file" conflicts with multiple commits on different topics.

$ git log --oneline --no-merges es/config-hooks..seen Documentation/githooks.txt
2d4e48b8ee fsmonitor--daemon: man page and documentation
23c781f173 githooks.txt: clarify documentation on reference-transaction hook
5f308a89d8 githooks.txt: replace mentions of SHA-1 specific properties
7efc378205 doc: fix some typos

$ git log --oneline --no-merges ^master es/config-hooks..seen Documentation/githooks.txt
2d4e48b8ee fsmonitor--daemon: man page and documentation

As three of the four changes are already in master, it probably is a
good idea to rebase this topic (and redo this step) to update the
native-hooks.txt

I am not sure offhand how ready fsmonitor--daemon stuff is, but if
it takes longer to stabilize than this topic, it might make sense to
hold off the changes to githooks.txt in that topic, until this topic
stabilizes enough to hit at least 'next', preferrably 'master', and
then base that topic (or at least the documentation part of it) on
the final shape of the native-hooks.txt.

Or better ideas?

Thanks.
