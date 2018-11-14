Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9C731F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 08:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbeKNSSa (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 13:18:30 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54736 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbeKNSS3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 13:18:29 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 26B0611896C;
        Wed, 14 Nov 2018 03:16:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YbT5B+iC2qMzXj0gO7nHYziTQGs=; b=AvBPbk
        4BEQuwu+LRv5CjryRl3DC2Ipha4mwBKqI37RD0dM347mIwFlMFHnBxPjpgstnVit
        LK2a/82s6fU6/LCZTiZNOTPQrtM82I4nkGkC75d553a8oGQx5Mt8Hi6tAc3cWgZb
        GSikXtDVh4FUDDBiCw8EJ8TKl+5xfKawuFJ00=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bHGpZqFBloYs4+bvlRDcnLZ/ZPJ6RnnI
        runo/UwrezhJzJfw6JMspJ9OqdbzZlSXcFT9m+Bh7KhR5+jLSZl8izZV41jtJ8d4
        QE+RtUM3FeBaKxQfYhAklm4ZLlnWCcDUBhZcrfBqUIPy6UOJGtFXYeTlPaScFWdK
        de7PO8YsGz4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1EF4A11896A;
        Wed, 14 Nov 2018 03:16:18 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 86E2C118968;
        Wed, 14 Nov 2018 03:16:17 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthieu Moy <git@matthieu-moy.fr>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] push: change needlessly ambiguous example in error
References: <20181113203909.30740-1-avarab@gmail.com>
        <1615698920.2718456.1542145071499.JavaMail.zimbra@matthieu-moy.fr>
        <87wopg1w2z.fsf@evledraar.gmail.com>
        <xmqqva50p9c6.fsf@gitster-ct.c.googlers.com>
        <850526490.3010891.1542177378884.JavaMail.zimbra@matthieu-moy.fr>
Date:   Wed, 14 Nov 2018 17:16:16 +0900
In-Reply-To: <850526490.3010891.1542177378884.JavaMail.zimbra@matthieu-moy.fr>
        (Matthieu Moy's message of "Wed, 14 Nov 2018 07:36:18 +0100 (CET)")
Message-ID: <xmqqsh04m5v3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8F7CCE86-E7E5-11E8-BB72-BFB3E64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthieu Moy <git@matthieu-moy.fr> writes:

> "Junio C Hamano" <gitster@pobox.com> wrote:
>
>> > Where 'topic' is a tracking branch of 'origin/master' (I use
>> > push.default=upstream). I only recently discovered that I could push to
>> > 'HEAD" to do the same thing. So one ulterior motive is to make that more
>> > prominent.
> [...]
>> Do we consider the current behaviour useful? Is it documented
>
> Yes, since 1750783 (Documentation: more git push examples, 2009-01-26).
>
> It may be an accident that the doc says "to the same name on the
> remote." since it predates the introduction of push.default, but it
> does say so and it's the actual behavior.
>
>> already and widely known?
>
> https://stackoverflow.com/questions/14031970/git-push-current-branch-shortcut
>
> 458 votes for the answer suggesting it.

OK, that probably is good enough reason to keep the current
behaviour and convince ourselves that there is nothing that needs to
be done further on this topic.

Thanks.
