Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537ACC433F5
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 20:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BC1860EE7
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 20:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234791AbhJKUKc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Oct 2021 16:10:32 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62911 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbhJKUKc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Oct 2021 16:10:32 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0691BF99E3;
        Mon, 11 Oct 2021 16:08:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=U/94rit3Uwf4hNq7WT0KCvDw4vnD6cx19fpk5D
        kCOSc=; b=uv8bS9jahziGaPdRD8h5g0zTOSazNrLsAS6pLbsGOfwMr3YzhWn95q
        coGxctrHBKy3EeSJlQk3Iht2RMxR30KapjNMmZy/UTWlOpepzFW5G7Zk3qvZG8D2
        lRilqu2oa53kjLC/y2C/YLBX18S7178nOMkm55XEdjSWy4hyB0EzE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F1EBCF99E2;
        Mon, 11 Oct 2021 16:08:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5E6DAF99E1;
        Mon, 11 Oct 2021 16:08:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 0/3] Use default values from settings instead of config
References: <20210917225459.68086-1-chooglen@google.com>
        <20211005001931.13932-1-chooglen@google.com>
        <xmqqfstafyox.fsf@gitster.g>
        <kl6lfst72v1e.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Mon, 11 Oct 2021 13:08:29 -0700
In-Reply-To: <kl6lfst72v1e.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Mon, 11 Oct 2021 12:58:21 -0700")
Message-ID: <xmqqzgrfb9z6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 00F17150-2ACF-11EC-A11E-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> With this merged to 'seen', the CI job with the extra set of
>> GIT_TEST_X settings fail.  When this topic is excluded, with
>> all the other topics in flight in 'seen', everything seems to
>> be OK.
>
> Thanks for the feedback, I did two CI runs on my fork in response:
>
> * [1] uses the same tree as seen. Looks like osx-clang passes but
>   linux-gcc fails.
> * [2] is rebased onto master. Again, osx-clang passes but linux-gcc
>   fails.
>
> This should be enough for me to hunt down the issue, though I would
> appreciate any hints if anyone has any :)

Using the set of GIT_TEST_FOO... settings I cited in the
Reference#1, in the message you are responding to, will let you
reproduce the issue locally on glinux boxes.
