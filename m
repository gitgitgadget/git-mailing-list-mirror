Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B01AAC4332D
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 01:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A4CA65172
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 01:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234074AbhCDBT7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:19:59 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57544 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244513AbhCDBTb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 20:19:31 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 27BE110F936;
        Wed,  3 Mar 2021 20:18:50 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IFfvDaNEE7bl9hVzvPNLKfUWw9o=; b=UBFUBQ
        Ri0AxSe9jOZryIGu3IaalX/xznI/oUfz7DdT6nEeAQObrekz3WERGeeEURBCKWxh
        CAy1sDtzzeq1t+gznhvQCa5Cc0OJ0aB84tQWWK60fmhKlqbIi1fZfho6iClMB2m2
        3UVQKO+LunZtuGMLAu0gA78/qnQ2/wsgh0dvo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vcYXEEFbB+g3QbSPdRQQOm7oozncoaWu
        GMShXH8OF2GNjkAlUYtnbLrp3TcxDPgE8C8eArMsHzYVk1LTdheDAxo7u04bK6PQ
        nlfdZb4woWIf9ms0M06EqQHLhko/x+DVwFO9tDMfSTC3X5Gqaj1Yt16WO9pLI9E/
        od2JbhkQ0hM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 20A8010F934;
        Wed,  3 Mar 2021 20:18:50 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 67E0F10F933;
        Wed,  3 Mar 2021 20:18:47 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git pull unclear manual
References: <874khsqq0o.fsf@osv.gnss.ru>
Date:   Wed, 03 Mar 2021 17:18:45 -0800
In-Reply-To: <874khsqq0o.fsf@osv.gnss.ru> (Sergey Organov's message of "Wed,
        03 Mar 2021 17:18:47 +0300")
Message-ID: <xmqqv9a7emx6.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 91DA4378-7C87-11EB-BDF3-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> Here is how "git help pull" begins:
>
> <q>
> NAME
>        git-pull - Fetch from and integrate with another repository or a local
>        branch
>
> SYNOPSIS
>        git pull [<options>] [<repository> [<refspec>...]]
> </q>
>
> From this, how do one figures how to "integrate with ... local branch"?
>
> Is "git pull" useful to integrate with a local branch at all?

Yes, you can refer to your local repository as ".", so

	git pull . another-branch

will integrate the history of your local "another-branch" into
the history of the branch you have currently checked out.


