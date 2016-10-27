Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31F9B20193
	for <e@80x24.org>; Thu, 27 Oct 2016 18:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751169AbcJ0Skz (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 14:40:55 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57061 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S942199AbcJ0Sky (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 14:40:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4827548563;
        Thu, 27 Oct 2016 14:40:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=A/xlBsojFdV8QxgSQYQoVYMgwgs=; b=OZ1Bxf
        QsQtFdElpT/fnfMGLf8Wh+tv6FjcIfZA617Gt38Npxyu19ur5N9RW9d0fZVfHq7E
        zcVKbCLvILgNBIz0qqQGoedxV/+fCE6J50h8nQsSRGlRAue+cu2bpYsDIz7lJLDm
        +HbRiSvkjm1os1ouc2d0VhCdAv/bsDk5rzu2I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BQ29tox0W9Gp9gM8mpVAtGAEPmpbMlcc
        07u7Dj7RmsW0Fc3aww4G7D32eVPYCaN7P7FtLj7Wy2J6rYo69TmmtzfxwzhYDXHr
        PKju2E1Iw//sSiT6Qp8j8hK+XwT9UHxazfnDm6EE8J6hCWwRGSbpiNmAyj75MoHL
        Lt2Vcex9zxM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3F64F48562;
        Thu, 27 Oct 2016 14:40:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B01CE48561;
        Thu, 27 Oct 2016 14:40:52 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael J Gruber <git@drmicha.warpmail.net>
Cc:     git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] Documentation/git-diff: document git diff with 3+ commits
References: <CA+P7+xq1i8AtQ7i=1m_n9HTSL10kFUFBn8jvNcB_t_6Rh29u4w@mail.gmail.com>
        <07712c2c94670ca4d91ef78cd7d3602a8d36b0c1.1477472970.git.git@drmicha.warpmail.net>
        <xmqqh97zask7.fsf@gitster.mtv.corp.google.com>
        <e74d4d84-d848-00be-8ca5-75204cf47262@drmicha.warpmail.net>
Date:   Thu, 27 Oct 2016 11:40:50 -0700
In-Reply-To: <e74d4d84-d848-00be-8ca5-75204cf47262@drmicha.warpmail.net>
        (Michael J. Gruber's message of "Thu, 27 Oct 2016 11:27:14 +0200")
Message-ID: <xmqqvawd63f1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E3716FEC-9C74-11E6-8ED3-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael J Gruber <git@drmicha.warpmail.net> writes:

> It did not exist, but even at that point in time, "git log A..B" listed
> only commits between the merge base and B, not those which are only in A
> and not in B. Whereas "git diff A B" shows the differences between the
> endpoints A and B.

I think you are speaking with 20/20 hindsight at this point.  

Do you genuinely think you would have thought that way when there
weren't any concept of "merge-base" or "git log A...B" known to you?

>>> @@ -12,6 +12,7 @@ SYNOPSIS
>>>  'git diff' [options] [<commit>] [--] [<path>...]
>>>  'git diff' [options] --cached [<commit>] [--] [<path>...]
>>>  'git diff' [options] <commit> <commit> [--] [<path>...]
>>> +'git diff' [options] <commit> <commit> <commit> [<commit>...]
>> 
>> Made me wonder "is [<A>...] 0-or-more As or 1-or-more As?".
>
> 0-or-more, at least that's the way it is used in all lines here.
>
>> Don't we allow pathspecs in this case?
>
> Yes, the combinded diff mode kicks in only with no blobs (not: no
> pathspec, which I had misread) and N>=3 commits. Maybe I should update
> the code comments in builtin/diff.c to describe this, too.

I don't know about the code comments, but the above SYNOPSIS needs
an update, I would think.  That is why I wondered if [<A>...] were
0-or-more or 1-or-moer.

You can replace

>>>  'git diff' [options] <commit> <commit> [--] [<path>...]

with

>>>  'git diff' [options] <commit> <commit> [<commit>...] [--] [<path>...]

without adding a new line to cover the new(ly discovered) case.

