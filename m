Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45AACC433DB
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 01:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E93C964FAB
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 01:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbhCPBkc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 21:40:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63248 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbhCPBkT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 21:40:19 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A725DC8E50;
        Mon, 15 Mar 2021 21:40:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=znvdYl3I3leU8x3zkf21rK6AZyQ=; b=ghpyOd
        cJF/zOcMOycUcFn8T8NOPaY9slCyHmAH1G0fagV03TFPS14nuDnVz+S8X+gQehOi
        sYVo+9Q3Cohxc146cK4QngL8PeFuBUXMVrEpcKKzi1pJjDMFzjtnp0biAKGRjr7p
        tUX04kfOVVWE1hYMX7ubfNtNgvu0sR4/xuKHc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lnlVmHf+WfYXs9UsJCxsFEq4hWZ5Wl2z
        e2wHd+6qGRwS2paI9Nv+3FXzzvf6VplSOXZdE2L2eNbxENRMIbtzWSymiHXhfPex
        OhnXwQJsqcbhIiXuobyXv80hSerqeBuLD0Ij6dzl7TFqncvhcqbQXqJVoVjFZWvQ
        mCQTrqWsVtY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A0189C8E4F;
        Mon, 15 Mar 2021 21:40:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 28003C8E4E;
        Mon, 15 Mar 2021 21:40:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (Mar 2021, #04; Sun, 14)
References: <xmqq35wx2ccy.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2103150436260.50@tvgsbejvaqbjf.bet>
Date:   Mon, 15 Mar 2021 18:40:16 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2103150436260.50@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Mon, 15 Mar 2021 04:43:09 +0100 (CET)")
Message-ID: <xmqqblbjzxj3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 902795E2-85F8-11EB-89A8-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I do not see this in `master`:
> https://github.com/gitster/git/commit/53204061acbf7a03a6ba050f381e0bf9b01e3a78
> claims that it is in `jch`, `jn/mergetool-hideresolved-is-optional`,
> `next` and `seen`, but not in `master`.
>
>> * tb/pack-revindex-on-disk (2021-02-26) 1 commit
>>   (merged to 'next' on 2021-03-12 at 7aa348d3b3)
>>  + pack-revindex.c: don't close unopened file descriptors
>>
>>  Fix for a topic in 'master'.
>
> The same here, I cannot seem to find it in the `master` branch.

Thanks.  I must have fell asleep before pushing them out, after
running a dry-run push and sending out the What's cooking report.

Git 2.31 has been tagged.  We will hopefully either (1) not see
brown-paper-bag breakages at all, or (2) will see some but can
immediately deal with them, in coming couple of days.  After that,
the 2.32 cycle will gain steam, starting next week.  Let's see.

At work HR has been nagging me to take accumulated vacation time, so
I'll officially be off tomorrow but I'll be available to handle such
brown-paper-bag breakages---after all, there aren't many places to
go spend vacation time in right now X-<
