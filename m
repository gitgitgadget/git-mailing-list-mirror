Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83425C433F5
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 21:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E76460F4A
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 21:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241149AbhIMVok (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 17:44:40 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50948 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238184AbhIMVok (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 17:44:40 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A45C8140387;
        Mon, 13 Sep 2021 17:43:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OuY/fzUzxmEPdTdTq0eyYXxSwUKmNTdPiAEDWb
        eefc4=; b=AYBoEax3vEt8SO6MeaMixxCb2ovw49mKSWvnZC9C9owHNmGxRhBkBB
        LdQlY7Cqh6gMCSPlS5DWq5MhZEpql5t9ck8lGBZR75DcpqKUuW24U6CmYkZ/TOmK
        YYSGWoS7G2MlweS6FGrkpICSvuSuM7GtO6QJ4u6I2BMiViDNlFxv8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8A180140386;
        Mon, 13 Sep 2021 17:43:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E6CD2140385;
        Mon, 13 Sep 2021 17:43:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Alban Gruin <alban.gruin@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH v1] git-clone.txt: add the --recursive option
References: <20210913185941.6247-1-alban.gruin@gmail.com>
        <CAPig+cR=HUDgFctXzcigZ062c=QWYfGWUPuT7scc-xU_w3NT1w@mail.gmail.com>
Date:   Mon, 13 Sep 2021 14:43:19 -0700
In-Reply-To: <CAPig+cR=HUDgFctXzcigZ062c=QWYfGWUPuT7scc-xU_w3NT1w@mail.gmail.com>
        (Eric Sunshine's message of "Mon, 13 Sep 2021 15:26:25 -0400")
Message-ID: <xmqqsfy8cft4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9D363E88-14DB-11EC-8BCC-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Mon, Sep 13, 2021 at 3:14 PM Alban Gruin <alban.gruin@gmail.com> wrote:
>> This adds the --recursive option, an alias of --recurse-submodule, to
>> git-clone's manual page.
>>
>> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
>> ---
>> I found this out when a friend told me he could not remember how to
>> fetch submodules with git-clone, and when another one suggested
>> `--recurse-submodule'.  I checked the man page, and I was surprised to
>> find out that `--recursive' is not mentionned at all.
>>
>> I did not modify the synopsis.  So, this alias, although shorter than
>> the "real" option, would still be somewhat hidden in the man page.
>
> Considering that the `--recursive` option was intentionally removed
> from `git-clone.txt` by bb62e0a99f (clone: teach --recurse-submodules
> to optionally take a pathspec, 2017-03-17), it's not clear that this
> change helps the situation.

A logical continuation of what bb62e0a99f tried to do might be to
hide the --recursive[=<pathspec>] from "git clone -h", I guess.
