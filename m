Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE8D720288
	for <e@80x24.org>; Fri, 21 Jul 2017 15:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754465AbdGUPPa (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jul 2017 11:15:30 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51269 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754397AbdGUPP1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2017 11:15:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4148C98BFB;
        Fri, 21 Jul 2017 11:15:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=P4rnjdpOKgd15SyarqZ/+Gi0V3U=; b=MZDjem
        d4dgie9ZfaZoOSlgDuD7Pwaxp8ae0pswpnFF6EvaQHmxbFYQJsycqK7KHaoWG9+J
        q6GPw2FxXKseCAMFFJfDxG4w+gkwHQY1aKE5FQ4FK+YNbesWlG4utU2kPD0F2Vdm
        OqW0m8fis5V0HfbQBBAeUsbbKeVI9cBcCYOaI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FTgcHUTyw0DWwNOZHjREboLJ5mp4VMEJ
        wpCB3Qez6U8i55F+ur+wIgfjjRZJ4fdvFMzw0kbHbqd9s/0TMMKT3W8dFOgrqyN6
        Oy99v3hTt+ncoIljm0NpD8YqWlmiD0ea0vWz4os9Q14MDgdimsNedbwTUFlUUroD
        SaaHHn8xuM8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2CF9798BFA;
        Fri, 21 Jul 2017 11:15:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8AAFA98BF9;
        Fri, 21 Jul 2017 11:15:18 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Victor Toni <victor.toni@gmail.com>
Cc:     Charles Bailey <charles@hashpling.org>, git@vger.kernel.org,
        Charles Bailey <cbailey32@bloomberg.net>,
        Jeff King <peff@peff.net>
Subject: Re: Handling of paths
References: <CAG0OSgdEE3g-ugEJU4EZqfbxZ=3h2WPdLC4W4mG7b6UeTaXQ-Q@mail.gmail.com>
        <xmqq7ez2lwsv.fsf@gitster.mtv.corp.google.com>
        <20170720200523.GA13792@hashpling.org>
        <xmqqwp72kg03.fsf@gitster.mtv.corp.google.com>
        <CAG0OSgfWZAbr1_j-SYYZyAzOvW4mrSFa7bBkfhRbJskgdGmsZQ@mail.gmail.com>
Date:   Fri, 21 Jul 2017 08:15:17 -0700
In-Reply-To: <CAG0OSgfWZAbr1_j-SYYZyAzOvW4mrSFa7bBkfhRbJskgdGmsZQ@mail.gmail.com>
        (Victor Toni's message of "Thu, 20 Jul 2017 23:03:48 +0200")
Message-ID: <xmqq1sp9izy2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 68016C38-6E27-11E7-BC0A-EFB41968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Victor Toni <victor.toni@gmail.com> writes:

> 2017-07-20 22:30 GMT+02:00 Junio C Hamano <gitster@pobox.com>:
>>
>> I've read the function again and I think the attached patch covers
>> everything that ought to be a filename.
>>
> Your swift reaction is very much appreciated.
> With the background you gave I just started to to create a patch
> myself just to see that you already finished the patch.

Heh, I guess I could have waited to save time ;-) 

I did the patch myself in order to avoid wasting your effort to find
and report the issue and time and distraction cost from Charles to
remember what happened 2 years ago and reply to me, because I will
certainly forget if I didn't have some patch readily usable in the
list archive.

In general, I (and other experienced reviewers here) prefer to give
chances to people who are new to the Git development community and
are inclined to do so to scratch their own itch, by giving analysis
of the problem and a suggested route to solve it, but without giving
the final solution in a patch form.  After all, many developers
(including me) started from small changes before getting involved
more deeply to the project and starting to play more important
roles.

Some reviewers are much better than myself in judging if a new
person wants satisfaction of solving himself or herself[*1*], and
they end their analysis and suggestion with a phrase like "Want to
try doing a patch yourself?"  I try to follow their example myself,
but I do not always succeed, and this is one of such cases.  I guess
you could have immediately responded "OK, let me try to see if I can
fix it myself" before starting to actually work on it ;-)

Having said all that, I suspect that your original problem
description might point at another thing we may want to look into.

The patch under discussion may have solved the "~[username]/" prefix
issue, but I offhand am not sure if a path-like variable that holds
a relative path behaves sensibly when they appear in configuration
files and in a file that has configuration snippets that is included
with the "[include] path=..." thing, and if there is a need to clarify
and/or update the rules.

In any case, thanks for reporting the bugs on two variables, and
welcome to the Git development community.


[Footnote]

*1* Some people just want to report an issue and move on, which is
    understandable.
