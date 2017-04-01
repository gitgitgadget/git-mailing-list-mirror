Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23B1520958
	for <e@80x24.org>; Sat,  1 Apr 2017 19:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751924AbdDATNA (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Apr 2017 15:13:00 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53637 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751804AbdDATM7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2017 15:12:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DF5B46BD72;
        Sat,  1 Apr 2017 15:12:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZuDA7o9wxCzx/gMtwoOxgyLGoHw=; b=c4QwXK
        x2WPVp1sJ0Q82ft3Dxrufp7YZxacVFMVlu55vzpwv1XkvHTEviC1BPsAFobF37GS
        sH9tc9wO0TX9kBgJx0H5bkOLgymVavdeJcIECPf5MJCfcTj5XDpk6mOxDp9o9gNw
        MBA1k1Lo8KzNwJTik/g/AE/THdasOl6fSTU4g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=clLt5TwUVI1uKhISSiu6Ox8oGaeAdqDI
        sLQ+KQYNsVXhOL82pFux+VdHebuUhBogvN9i68kO1PU0RYyRyhQIWokOvNIbgX/3
        keM2299Gj+Sr5s63lQZgF01MVCcJdqYRTNkxCKHysCQzmduCcCIOqRlqHhVqQmJk
        ikwbovO01XA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D76666BD71;
        Sat,  1 Apr 2017 15:12:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 19A046BD6F;
        Sat,  1 Apr 2017 15:12:56 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Robert Stanca <robert.stanca7@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] [GSOC] Convert signed flags to unsigned
References: <20170401153049.21400-1-robert.stanca7@gmail.com>
Date:   Sat, 01 Apr 2017 12:12:55 -0700
In-Reply-To: <20170401153049.21400-1-robert.stanca7@gmail.com> (Robert
        Stanca's message of "Sat, 1 Apr 2017 18:30:48 +0300")
Message-ID: <xmqqy3vkt008.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 36E7837C-170F-11E7-90C4-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robert Stanca <robert.stanca7@gmail.com> writes:

> Subject: Re: [PATCH 1/2] [GSOC] Convert signed flags to unsigned

Try

    git shortlog --no-merges -40

to learn how commits are typically titled.  And then imagine this
patch makes into our codebase and appear in the output.

Can you tell what this commit is about from that single line title?
No.  You wouldn't even know that it is only touching bisect.h and
nothing else.

What do your readers want "shortlog" output to tell them about your
commit?  What are the most important thing (other than giving you an
excuse to say "I have completed a microproject and now I am eligible
to apply to GSoC" ;-)?  Your proposed commit log message, especially
its title, must be written to help future readers of the project
history.

Perhaps

    bisect.h: make flags field in rev_list_info unsigned

would help them better.

>  Unsigned int is a closer representation of bitflags rather than signed int that uses 1 special bit for sign.This shouldn't make much difference because rev_list_info.flags uses only 2 bits(BISECT_SHOW_ALL and REV_LIST_QUIET)

Overlong lines, without space after full-stop before the second
sentence, without full-stop at the end of the sentence.

>
> Signed-off-by: Robert Stanca <robert.stanca7@gmail.com>
> ---
>  bisect.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/bisect.h b/bisect.h
> index acd12ef80..a979a7f11 100644
> --- a/bisect.h
> +++ b/bisect.h
> @@ -16,7 +16,7 @@ extern struct commit_list *filter_skipped(struct commit_list *list,
>  
>  struct rev_list_info {
>  	struct rev_info *revs;
> -	int flags;
> +	unsigned int flags;

Have you checked how this field is used?  For example, there is this
line somewhere in rev-list.c

	int cnt, flags = info->flags;

and the reason why the code copies the value to a local variable
"flags" must be because it is going to use it, just like it and
other codepaths use info->flags, no?  It makes the code inconsistent
by leaving the local variable a signed int, I suspect.
