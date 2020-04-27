Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF249C54EEB
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 21:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D6E72075E
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 21:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WIzI9HHj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgD0VRl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 17:17:41 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58626 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbgD0VRh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Apr 2020 17:17:37 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BD0B35CDF6;
        Mon, 27 Apr 2020 17:17:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hnFyXHupDHhV/pwVmJjpTARZW80=; b=WIzI9H
        Hjgc1iD0pdFvrY5Iw+n3OZmG+YdK9bkzoIXCWE1YGx7SHFO6fuQsS0wPdN17VnNz
        IiiAOk0zFf7aIJGQFgGaqrGARPMGc0OOQOxJUvlN97DDufUwqtXTDPqZYdjVN8U/
        xGTQs8cyEdre15Ss3jX4kPUBoGc8RVPoQPMkU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XW2aio1SvywQHQS+wO+7P4ivzTTLrUB6
        PEabJkWuYCvA9Jc2q7iJ9dhy1toCxISzQxweKy+Mnch3MC33XOjz6W1zz02defg6
        Qw+mtHqBEMzfsrbx3yZhylqzguVJOOx49hXJw78J0Y6Nr80m09yehWilztv9/diE
        hJeSsqbpWn0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B56F65CDF5;
        Mon, 27 Apr 2020 17:17:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 440A55CDF4;
        Mon, 27 Apr 2020 17:17:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/8] CMake build system for git
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>
        <xmqqv9lod85m.fsf@gitster.c.googlers.com>
        <CAKiG+9V_nZUXf2a689vZ54rG+xTCFMGcJe_7Av-khaxxuijERg@mail.gmail.com>
        <xmqq8sikblv2.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2004251354390.18039@tvgsbejvaqbjf.bet>
        <20200427200852.GC1728884@coredump.intra.peff.net>
Date:   Mon, 27 Apr 2020 14:17:32 -0700
In-Reply-To: <20200427200852.GC1728884@coredump.intra.peff.net> (Jeff King's
        message of "Mon, 27 Apr 2020 16:08:52 -0400")
Message-ID: <xmqqlfmg7hn7.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8288E4F6-88CC-11EA-A9DD-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I think what I'm suggesting is not all that different from this, except
> that I'd suspect "next" would not get enough exposure. So in my mind
> merging to master is not so much "hooray, we now have visual studio
> support" but rather the first step in getting data. But we'd have to be
> very clear about how the project regards the cmake support: it's there
> for now, you're encouraged to play with it, but don't be upset if it
> needs some coaxing to behave like the normal Makefile or if it goes away
> in the future.

I think you said almost everything I would have said.  

If we were to adopt it as an experiment, hoping to gain exposure,
nothing above 'master' (or tagged releases) won't work.  And once a
thing is in 'master', users will ignore the "this is merely an
experiment" warning and expect it to be fully functional and usable.

Given the observation in the thread that it would take a fairly
recent version to benefit platform-agnostic usability features, I
did not get an impression that it is ready to be anywhere near that,
not even ready for 'next'.  It is *not* like "Sibi's patches were
bad but they can become ready with further polishing".  The
impression I got was that the large part of why it is not ready is
because it needs time for larger set of distros to adopt more recent
versions of cmake.

And I somehow think that rewriting Sibi's patches to lose the parts
that takes advantage of more recent cmake (abstracting "mklink" vs
"ln" out was mentioned as an example---there may be a lot more) is
going in a wrong direction.  The world will eventually catch up, and
Git does not need cmake immediately.  Using the more recent features
while waiting for the right time would be a more sensible approach
than aiming for an outdated version.

So, perhaps we'll try again in 3 years, perhaps, to consider if it
makes sense to add the cmake support to _my_ tree.

But in the meantime, those who are interested in building Git with
cmake do not have to wait, doing nothing, I would imagine.  I wonder
if they can work on a separate project (let's call it git-on-cmake)
whose sole purpose is to develop and polish CMakeLists.txt, waiting
for an advanced enough version of cmake becomes commonplace.  Then,
anybody who are interested and has recent cmake can subtree-merge
git-on-cmake project into their own clone of our project somewhere,
and help developing git-on-cmake further.

Then we'll meet again in 3 years and see if the world got new enough
;-)
