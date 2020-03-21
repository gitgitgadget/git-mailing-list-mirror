Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30C4C4332D
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 22:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D10A20754
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 22:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ctOcR5+r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbgCUWhK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 18:37:10 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50678 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbgCUWhK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 18:37:10 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1628C62AA2;
        Sat, 21 Mar 2020 18:37:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HxMS4HNoDd6wxWtBFickoWlMeh8=; b=ctOcR5
        +r5lozJlAX3WrYpuH4lrraMWLS8jv3MiSEnUP7zwbZvcdl5N5Yqh2UcbuizUovsK
        apqNnzu56nbMAkpKfUBax4baczNAd0Zq+h+4KKvSQ2naBFOWs3KhlbV2n0/snl8H
        m3MJwOXPLO4ci0wAUqvQ+kYKK6RPG+1cxetCQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RaxZZDNd/4b77VBJmLaAt9UO9hUd7JTn
        6cM1eMYAfuNYaBWTEKhAgAuYLxvSZ1Y7GzhM23y/nT3NSBFqtusPrkhWS7txrX+m
        JlxUbkDz4xUwYnGPGM387Tm/EAaNy7Y2+sD5n3TP/7CdJpIdXxWOQqlNc6k4g48/
        88XNDNhb1/M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0B4D162AA1;
        Sat, 21 Mar 2020 18:37:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5648462A9F;
        Sat, 21 Mar 2020 18:37:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Parth Gala <parthpgala@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, chriscool@tuxfamily.org
Subject: Re: [GSoC Project RFC] "git log --oneline" improvements
References: <28aee28c-8e8d-763a-66c7-d365025e56a2@gmail.com>
        <xmqqwo7ea99z.fsf@gitster.c.googlers.com>
        <a67e0d2e-5bcd-8ac7-648e-51c1dc0f72ef@gmail.com>
Date:   Sat, 21 Mar 2020 15:37:03 -0700
In-Reply-To: <a67e0d2e-5bcd-8ac7-648e-51c1dc0f72ef@gmail.com> (Parth Gala's
        message of "Sun, 22 Mar 2020 03:35:14 +0530")
Message-ID: <xmqqh7yh8hdc.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7D09A378-6BC4-11EA-AAD1-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Parth Gala <parthpgala@gmail.com> writes:

>>>    |   === 2015-09-04 ===
>>>    | * 27ea6f85 10:46 jch (tag: v2.5.2) Git 2.5.2
>>>    * 74b67638 10:36 jch (tag: v2.4.9) Git 2.4.9
>>>                         ..........
>>>    * ecad27cf 10:32 jch (tag: v2.3.9) Git 2.3.9
>>>
>>> So these are the two main formats to be enhanced along with as many options
>>> of log as possible. What are your views on this ?
>>>
>> Making the "--oneline" format to consume more than one line for a
>> commit is probably not what we want anyway.
>
> For this format can we build a new option say `--time` or `--log-time`(duh!)

Making such an option orthogonal to the base formats (i.e.
"--decorate" is usable with "--pretty=short", "--pretty=fuller",
"--oneline", etc.---note that this is not meant to be exhaustive)
would be a good idea.  I do not think of any reason why your
"--group-by-same-date" cannot be combined with some of these formats.

It is reasonable to combine it with "--format="%h %s", for that
matter, because the "--group-by-same-date" is not about showing any
particular commit but inserting something that does *not* belong to
any particular commit in between.  Just like "--graph" can be
combined with many formats, showing group separators in between the
stream of commits would mix well with any format, I would say.

By using the idea Peff shown, before starting to emit one commit (in
any format), you would show a single line of "== YYYY-MM-DD ==" if
the commit is from a date different from the one that was shown
last.  It would naturally extend to "--group-by-same-month", etc.,
so you'd want to be prepared for such future.  Your patch does *not*
have to implement such variations like grouping by month, season or
year.  But a developer with a good taste would prepare the code in
such a way that is easy to modify to extend the support for such
variations by future developers.

Also remember there are two timestamps, and depending on the use
case, people want to see author dates or committer dates.

Thanks.
