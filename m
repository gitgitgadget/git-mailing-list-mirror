Return-Path: <SRS0=9bkr=2Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9757EC00523
	for <git@archiver.kernel.org>; Sat,  4 Jan 2020 03:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 636B221734
	for <git@archiver.kernel.org>; Sat,  4 Jan 2020 03:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uGMUWDpX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbgADDeF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jan 2020 22:34:05 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56720 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727274AbgADDeF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jan 2020 22:34:05 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 83884B7A3D;
        Fri,  3 Jan 2020 22:34:00 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SROG53Bwf/yR9dhEJm+0xUcFUQY=; b=uGMUWD
        pXeDdXQ5dOfT3Wpe+ghzsQM7Pv5G4n0xL3iEoQcDlrIjU8hLRstJtvFcUbqPZN9W
        pcnheeX3yjLwnBw12vrw9RNeJss0+1LG+13rKzpjBtUW6gE4i+VwUYIoPfZdyYcW
        gVvwL1YGq1D56vkTUxoWof7uxntxGIPSyF6Es=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NtszG7khKOjRuVFHD6PrAGLV8OJtw5vU
        o2fQjLY9Xy65S1S75l0BzSP8CHqtQp5gZgyoeVZ/Bo2ea9oA/MCpFqhgvKIQjssH
        FdbYbNSN90ggM6uYob0qw66MIOSKGOvrdgNEuE2SC0eMmNmEzOEg8P4kKeeF96sc
        DVm1t/d7090=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7C243B7A3C;
        Fri,  3 Jan 2020 22:34:00 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A4C41B7A3B;
        Fri,  3 Jan 2020 22:33:57 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Documentation: Mention `Date: ` in git-am
References: <6ffcb6c0-d09e-45c4-d264-8a9024b67f3c@molgen.mpg.de>
Date:   Fri, 03 Jan 2020 19:33:55 -0800
In-Reply-To: <6ffcb6c0-d09e-45c4-d264-8a9024b67f3c@molgen.mpg.de> (Paul
        Menzel's message of "Fri, 3 Jan 2020 16:05:46 +0100")
Message-ID: <xmqqblrjdhek.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0A608D7C-2EA3-11EA-B1F9-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Paul Menzel <pmenzel@molgen.mpg.de> writes:

> Subject: Re: [PATCH] Documentation: Mention `Date: ` in git-am

The technical term to refer to these From/Subject/Date override is
"in-body header", and using it would make it easier to tell what the
commit is about when this appears in "git shortlog" output.  Perhaps

	am: document that Date: can appear as an in-body header

> Date: Fri, 3 Jan 2020 12:48:46 +0100

When the general public sees the patch for the first time is when
the patch is authored as far as the participants of this list are
concerned.

Please don't lie about the author date on this list.

> Tested, that a line `Date: ` in the message body will be preferred by
> `git am` over the one in the message header. So, update the
> documentation.
>
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
>  Documentation/git-am.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
> index fc5750b3b8..11ca61b00b 100644
> --- a/Documentation/git-am.txt
> +++ b/Documentation/git-am.txt
> @@ -190,8 +190,8 @@ the commit, after stripping common prefix "[PATCH <anything>]".
>  The "Subject: " line is supposed to concisely describe what the
>  commit is about in one line of text.
>  
> -"From: " and "Subject: " lines starting the body override the respective
> -commit author name and title values taken from the headers.
> +"From: ", "Date: ", and "Subject: " lines starting the body override the
> +respective commit author name and title values taken from the headers.

Correct.  It would be a good idea to fix "will be preferred" in the
proposed log message to match this by reusing the verb "override".
Perhaps like

	Similar to "From:" and "Subject:" already mentioned in the
	documentation, "Date:" can also appear as an in-body header
	to override the value in the e-mail headers.  Document it.

>  The commit message is formed by the title taken from the
>  "Subject: ", a blank line and the body of the message up to
