Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68843C433E3
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 21:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03C0820768
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 21:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZLYBlPh2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbgGWVdN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jul 2020 17:33:13 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54582 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbgGWVdM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jul 2020 17:33:12 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0F532DD679;
        Thu, 23 Jul 2020 17:33:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MvYowizequFMeu14ALzJBWxI7XM=; b=ZLYBlP
        h2jYsZluYL3iS1//xH1we7CBYLm5iT2QjaxbW6fu5vMiMNmoLN0Ysg8+vxsdcGBB
        zxW6mT7yGAzasmsnNe+FFYAGl3+mXF/opuA7jM2aKlogLOEKfLpzvJh42YeyltrR
        KooZrWqK8AP37K6bU6c50FGPqU3qm42p4WcZI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WMWgVGbx25oJ5uPdsH0LqF1FBT9Ma/um
        6UIoA++swCyw+7FMGefO1ng40voIcqnGvL/bVzyWQtAPAZ9ThiZu81AvH0brW/5C
        62UXpjTLr2YNw8fY8m/Jio7MDz5oV7BUbSLpBW30V7zGxokIhl+C0ZZypZEQpZ+x
        ypHG19oWSmc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 08978DD678;
        Thu, 23 Jul 2020 17:33:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 36361DD674;
        Thu, 23 Jul 2020 17:33:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthew Glassman <matthewglassman78@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Trying to update GIT in Ubuntu 18.04
References: <CAO-dU=fQZ6YVk1rWw_Tc8YT-i_zH7-hw3GATXmf7hwaqqC3j4Q@mail.gmail.com>
Date:   Thu, 23 Jul 2020 14:33:06 -0700
In-Reply-To: <CAO-dU=fQZ6YVk1rWw_Tc8YT-i_zH7-hw3GATXmf7hwaqqC3j4Q@mail.gmail.com>
        (Matthew Glassman's message of "Thu, 23 Jul 2020 16:12:22 -0400")
Message-ID: <xmqqmu3pq5m5.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 19BDF278-CD2C-11EA-B956-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthew Glassman <matthewglassman78@gmail.com> writes:

> My git version is listed as 2.17.1.  If I try to just do sudo apt
> install git..It will tell me I have the latest version and this is
> after running apt update.  I can not get the PPA to work because there
> is no GPG Key to input and thus Ubuntu will automatically keep it from
> use due to insecurity.  Can you please advise me on how to best update
> GIT to the current stable version please.

Unless installing from the source is an option, you are at the mercy
of your distro packagers.  

But it shouldn't be hard if you are on a mainstream platforms (any
recent Linux certainly qualifies) to build and install from the
source.

  https://github.com/git/git/blob/master/INSTALL

Using "make --prefix=$HOME/gitstuff install install-doc" and adding
"$HOME/gitstuff/bin" early in the $PATH would let you use the one
that you built, without uninstalling what came from the distro
(typically in /usr/bin).


