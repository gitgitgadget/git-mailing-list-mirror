Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC21C433E0
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 07:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC1D664DD6
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 07:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbhBKHo2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Feb 2021 02:44:28 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55571 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhBKHoZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Feb 2021 02:44:25 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EB5819E2D5;
        Thu, 11 Feb 2021 02:43:41 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=W0s6pnWQNk6BoDg+GEIThbIDIFc=; b=hOj0t4
        CjBRm2xVj5ArXeOdSPITxQfOk8/4prYq3/xXEJ86BgTir4SEywEe5Gk4EaUoXtXI
        t0xE1g8bV1WWWHQKHFCGv6lFwmduMJQU09qEiB35blP//nDP2x6PugHVdLXzXi1E
        7nAzMscmHSvOzLxfjtUh4ZVKHnVhliRehYFMA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TUAq/2J90tsn9DPK0LOSSmduYUhrIP1a
        JOMGz2OP1lFSp6BQpL6dJ3q9hXmHG8lvNm2+rkJfxttvEQMWoaKq0p29d4xdveS0
        kwRG7gxODu6dNfd+lGAgZvkCV7abS9jZSCdGiTMEXQdYzLyiHIXhk1TqAD+ZKDVh
        1qY1S+B57Qo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E3EFD9E2D4;
        Thu, 11 Feb 2021 02:43:41 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6CB569E2D3;
        Thu, 11 Feb 2021 02:43:41 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin von Zweigbergk <martinvonz@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3] docs: clarify that refs/notes/ do not keep the
 attached objects alive
References: <e7fde2369495f32c7aa88c7b6b74ebee1a1bed24.1613000292.git.martinvonz@google.com>
        <6cb0a3d0ab333984c35dd1026b80a2dc800d4520.1613029124.git.martinvonz@google.com>
Date:   Wed, 10 Feb 2021 23:43:40 -0800
In-Reply-To: <6cb0a3d0ab333984c35dd1026b80a2dc800d4520.1613029124.git.martinvonz@google.com>
        (Martin von Zweigbergk's message of "Wed, 10 Feb 2021 23:39:14 -0800")
Message-ID: <xmqqy2fvxd5f.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DC49D69A-6C3C-11EB-8110-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin von Zweigbergk <martinvonz@google.com> writes:

> `git help gc` contains this snippet:
>
>   "[...] it will keep [..] objects referenced by the index,
>   remote-tracking branches, notes saved by git notes under refs/notes/"
>
> I had interpreted that as saying that the objects that notes were
> attached to are kept, but that is not the case. Let's clarify the
> documentation by moving out the part about git notes to a separate
> sentence.
>
> Signed-off-by: Martin von Zweigbergk <martinvonz@google.com>
> ---
>  Documentation/git-gc.txt | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)

Thanks.  Will replace and queue.


> diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
> index 0c114ad1ca..853967dea0 100644
> --- a/Documentation/git-gc.txt
> +++ b/Documentation/git-gc.txt
> @@ -117,12 +117,14 @@ NOTES
>  'git gc' tries very hard not to delete objects that are referenced
>  anywhere in your repository. In particular, it will keep not only
>  objects referenced by your current set of branches and tags, but also
> -objects referenced by the index, remote-tracking branches, notes saved
> -by 'git notes' under refs/notes/, reflogs (which may reference commits
> -in branches that were later amended or rewound), and anything else in
> -the refs/* namespace.  If you are expecting some objects to be deleted
> -and they aren't, check all of those locations and decide whether it
> -makes sense in your case to remove those references.
> +objects referenced by the index, remote-tracking branches, reflogs
> +(which may reference commits in branches that were later amended or
> +rewound), and anything else in the refs/* namespace. Note that a note
> +(of the kind created by 'git notes') attached to an object does not
> +contribute in keeping the object alive. If you are expecting some
> +objects to be deleted and they aren't, check all of those locations
> +and decide whether it makes sense in your case to remove those
> +references.
>  
>  On the other hand, when 'git gc' runs concurrently with another process,
>  there is a risk of it deleting an object that the other process is using
