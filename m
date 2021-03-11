Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6721C433DB
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 06:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7758064FAA
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 06:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbhCKGJO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 01:09:14 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57993 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbhCKGJC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 01:09:02 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6CB73AFE2E;
        Thu, 11 Mar 2021 01:09:01 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YW+mRr0O0KI0NGdT9fKrE5+AX2Q=; b=F8KgZk
        ylilmUHs9r6oKGcJCnx0rcXPy4DwLfzb91aPf8u/sZLTtwExINr0SwtZ6u8DWNY6
        mScrj+BFqPpEyVePRoCeil0Pz1X33/7xrD1yMRMD7BW+nWWCETVn7UpSnu6rXMat
        8GJ3h94yHfZffm2PQaqzOA9WEmz7Y8KwDMsRI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WDulAO/rvLhX4iIEU4JdHm8r0QrA8PJq
        uqFJFpZfUvIo3Gv13U8z6MHYJPbMXbcF1Byn/9xtYHh66X1FfuDg/O6Id4JVkLE4
        LxGeTcPApMKOsyECVd5S9AAa1mNjRWjUOILhJk7kh9exrzk7Zj//NOkLkSv4FECQ
        KC0EzF1ospU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 33174AFE2C;
        Thu, 11 Mar 2021 01:09:01 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EA0F5AFE2A;
        Thu, 11 Mar 2021 01:08:58 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Mar 2021, #03; Wed, 10)
References: <xmqqmtvafl62.fsf@gitster.g>
        <CABPp-BHxj8jS62mVH4qgmoh1v48ciz8CRswz3+twSnuxUo7Rmw@mail.gmail.com>
Date:   Wed, 10 Mar 2021 22:08:58 -0800
In-Reply-To: <CABPp-BHxj8jS62mVH4qgmoh1v48ciz8CRswz3+twSnuxUo7Rmw@mail.gmail.com>
        (Elijah Newren's message of "Wed, 10 Mar 2021 20:49:56 -0800")
Message-ID: <xmqq5z1yfchx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 44D4B46A-8230-11EB-AF3D-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Wed, Mar 10, 2021 at 7:05 PM Junio C Hamano <gitster@pobox.com> wrote:
>> --------------------------------------------------
>> [New Topics]
> ...
>
> Is there any reason the topics at
>
> https://lore.kernel.org/git/pull.845.git.1614484707.gitgitgadget@gmail.com/T/#t
>
> and
>
> https://lore.kernel.org/git/pull.973.git.git.1614905738.gitgitgadget@gmail.com/T/#t
>
> haven't been picked up yet?

While we are in pre-release freeze, I'd refrain from picking up a
brand new code with nontrivial complexity that is under discusion on
the list (because I know I cannot spare enough bandwidth to keep up
with the discussion and picking up an early iteration, and risking
to merge it down without refreshing it with a newer iteration by
mistake, is not a good tradeoff), while I am busy dealing with
prerelease issues.  I do use the spare time to follow discussions on
topics that are already in tree and possibly replace them with their
newer rounds, and also new code that are of less importance and
easier to reason about.

