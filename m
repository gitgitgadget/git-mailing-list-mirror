Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CBD7C63793
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 19:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46BC760C40
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 19:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357501AbhGSSXS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 14:23:18 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51485 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383535AbhGSR4U (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jul 2021 13:56:20 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A9621133756;
        Mon, 19 Jul 2021 14:36:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oAgdJu9YglEjYWZqe3Y1iUyHUbFKxcvyo5/90H
        Mdwiw=; b=VyWFdBh8iqOvxrZBCxPA6KgG7C3o/28vKJZxWkMmGI4Ii/2wliMUDp
        SHOvDm6wRr0t5AqaOd3OCD+pIewzWnkOa3SG7MTSiqoibNm9Y/+W10VND7mHviw3
        TWQDDPl63t9Oo74BiJ9H428h0liwpcE8+nIlTFKt2hxlLn3sw0qrc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A2AC3133755;
        Mon, 19 Jul 2021 14:36:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CAF13133754;
        Mon, 19 Jul 2021 14:36:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Andrew Berry" <andrew@furrypaws.ca>
Cc:     git@vger.kernel.org, bagasdotme@gmail.com
Subject: Re: [PATCH] docs: .gitignore parsing is to the top of the repo
References: <20210706205439.75015-1-andrew@furrypaws.ca>
        <20210706205712.75270-1-andrew@furrypaws.ca>
        <xmqqk0m3gl6a.fsf@gitster.g>
        <52880F2B-FAD4-4E36-8662-A798B91B5C94@furrypaws.ca>
Date:   Mon, 19 Jul 2021 11:36:40 -0700
In-Reply-To: <52880F2B-FAD4-4E36-8662-A798B91B5C94@furrypaws.ca> (Andrew
        Berry's message of "Sun, 18 Jul 2021 10:12:28 -0400")
Message-ID: <xmqqy2a2kv5z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 42E318F8-E8C0-11EB-88B9-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Andrew Berry" <andrew@furrypaws.ca> writes:

> On 6 Jul 2021, at 17:57, Junio C Hamano wrote:
>
>> If you do "toplevel" -> "top-level" while at it, perhaps we would
>> want to correct "work tree" -> "working tree".
>
> Rather than think of this as a one-off fix, I thought to look to see
> how many instances of each are currently used.
>
> toplevel: 246
> top-level: 119
> work tree: 538
> working tree: 2610
>
> Since many of these instances are in translated strings, and that the
> text is understandable with any of the variants, I don't think it's 
> worth changing. "Our standard is no standard" etc.

So using "working tree" and "toplevel" might be adjusting to
majority, but I agree that there are so numerous that tweaking only
one "toplevel" (or another "work tree") should not distract the main
point of this patch.

Thanks for stepping back and thinking it carefully.  I wish
everybody did more of that ;-)

> That leaves bringing the note about the work tree earlier in the
> sentence. Here's a hopefully easier to read word-diff. Look good?

Sure, but the thing is that the version of the patch (with the
change from toplevel to top-level) has already been in 'next' for
more than a week.

Thanks.

> diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
> index 53e7d5c914..b4c8b9c0de 100644
> --- a/Documentation/gitignore.txt
> +++ b/Documentation/gitignore.txt
> @@ -27,12 +27,11 @@ precedence, the last matching pattern decides the
> outcome):
>    them.
>
>  * Patterns read from a `.gitignore` file in the same directory
>    as the path, or in any parent [-directory, with patterns in the-]
> [-   higher level files-]{+directory+} (up to the toplevel of the work
>    [-tree)-]{+tree), with patterns in the higher level files+} being
>    overridden by those in
>    lower level files down to the directory containing the file. These
>    patterns
>    match relative to the location of the `.gitignore` file.  A project
>    normally
>    includes such `.gitignore` files in its repository, containing
>    patterns for
>    files generated as part of the project build.
>
>  * Patterns read from `$GIT_DIR/info/exclude`.
