Return-Path: <SRS0=WCE0=5E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E79C4332B
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 21:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FB4F20773
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 21:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ijiCB7hH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbgCSVzR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Mar 2020 17:55:17 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64052 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbgCSVzR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Mar 2020 17:55:17 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 726ABA99C6;
        Thu, 19 Mar 2020 17:55:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+4hwqsW1jchUOegQa4PcgY56yYo=; b=ijiCB7
        hHZ/hXQxyqAIISpmxvn9PllZ9XHdVdakU1F+Dij9FiqkI5dL+VPf8Ucc4mpVAu42
        vx9drB8e/AE4Y9An61I8HQ/4uzzIgJobBVIs8jYUbP378s/HrAdHGImNRKlx4MJa
        OI6s3t88R30t1J4W7RLo0eVeIdHCu9tElp8xg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rzTitQo3tLwsnOE2qvkq8DtqzKHNu5em
        KTpihlGzkmWeXF4j/oqfxUE+C/SPmk7OPgibmNm4Pvtnofx3x8Rq/1eyLyXxabEj
        +H4ZzIa5/2TjU80yKzvS8+AT0aVMlfPs10yQkfmwRgYWNohRXMzzL0ns8CCUxO6a
        EfLILLEGDOk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 69E31A99C5;
        Thu, 19 Mar 2020 17:55:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A37FAA99C2;
        Thu, 19 Mar 2020 17:55:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Harshit Jain <harshitjain1371999@gmail.com>
Cc:     Shourya Shukla <shouryashukla.oo@gmail.com>, git@vger.kernel.org
Subject: Re: [GSoC][PATCH 1/2] t4131: modernize style
References: <20200319132957.17813-2-harshitjain1371999@gmail.com>
        <20200319163817.4239-1-shouryashukla.oo@gmail.com>
        <CACuU+s9WbKyg3P+ai8pnQqvRJDv+OoyqU-730K=1R7uasc=09g@mail.gmail.com>
Date:   Thu, 19 Mar 2020 14:55:08 -0700
In-Reply-To: <CACuU+s9WbKyg3P+ai8pnQqvRJDv+OoyqU-730K=1R7uasc=09g@mail.gmail.com>
        (Harshit Jain's message of "Thu, 19 Mar 2020 23:15:32 +0530")
Message-ID: <xmqq5zf0dn7n.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4D56C582-6A2C-11EA-B5CC-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Harshit Jain <harshitjain1371999@gmail.com> writes:

>> > The tests in 't4131-apply-fake-ancestor.sh' were written a long
>> > time ago, and have a few style violations. Update it to adhere
>> > to the CodingGuidelines.
>> ...
> I used 'git commit' only and not 'git commit -m "message". But

I'd suggest developers, especially the new ones, to stay away from
using '-m "message"' form, too.

In your editor, you would probably have written something like

	-- -- -- -- -- the contents of editor window -- -- -- -- --
	t4131: modernize style

	The tests in 't4131-apply-fake-ancestor.sh' were written ...
	...

	-- -- -- -- -- the contents of editor window -- -- -- -- --

As you observed, the first paragraph of the log message text is
taken as the title of the commit, and "git format-patch" places the
title on the "Subject:" line (if you had more than one line in the
first paragraph, since the payload on the "Subject: " line has to be
a logically single line, you'd end up getting a single long line
that has the contents on all lines in the first paragraph).

The second and subsequent paragraphs become the body of the message.

Your title looks reasonable; there is nothing that needs to be
"fixed" or "improved" there.

Your second paragraph is not so good---it should wrap the lines at a
reasonable length (say 65-70 columns).

Your last paragraph, which consists of a single "Signed-off-by:"
line in this case, is good.  It matches the identity recorded on the
"From:" line of the message.

>> Also, commit messages are generally around 72 characters per line. What are the
>> style violations you are talking about BTW?
>
> The git coding guidelines says that we shouldn't have a space after
> the redirection operators, hence I corrected this in the test file.

That is a good thing to write in the commit log message.  

"written a long time ago" does not have much value by itself (it
does serve as a backstory to explain a half of why it does not use
the more modern style, though).  "have a few style violations." is
almost meaningless (otherwise, you would not be doing a "modernize
style" patch in the first place ;-).

	t4131: modernize style.

	The tests in t4131 leaves a SP between a redirection
	operator and the file that is the redirection target,
	which does not conform to the modern coding style.

	Fix them.

	Signed-off-by: ...

perhaps.
