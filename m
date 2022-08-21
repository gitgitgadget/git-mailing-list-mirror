Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9283EC25B08
	for <git@archiver.kernel.org>; Sun, 21 Aug 2022 00:36:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233998AbiHUAgI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Aug 2022 20:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiHUAgH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Aug 2022 20:36:07 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9899828702
        for <git@vger.kernel.org>; Sat, 20 Aug 2022 17:36:06 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0FB0A131B95;
        Sat, 20 Aug 2022 20:36:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3c07oWxJ4SUjFeroQjypjk2JLBkX485116HXEV
        UDx60=; b=kSvt+jCB03uUO8uTAQuyC4pYj8RYVcnqnTRI1/kb5T3JmHKhgprJNa
        UcqGKCuycVN0uZz+Ve1eE1aPCKu0/eJGeM6SHzI5M5RD1SxDwUxop6vFp9JTTB9W
        a30x8HA0PQAmM5fxwRtGLezW/0SrS2LJcM7YKbvnrebpm7Lh44qBY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F1921131B93;
        Sat, 20 Aug 2022 20:36:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 17EE9131B90;
        Sat, 20 Aug 2022 20:36:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Tim Hockin <thockin@google.com>
Cc:     git@vger.kernel.org
Subject: Re: rev-parse: -- is sometimes a flag and sometimes an arg?
References: <CAO_RewbD+BJd1hPKCmCNM8wYBSUmZ2TuOoy6t1up1CT-rbn4DA@mail.gmail.com>
        <xmqq8rniikrg.fsf@gitster.g>
        <CAO_RewZPXP1EUP90kU6uEQ3_CqqC7yWedjfNd7RaVASFSfrg0Q@mail.gmail.com>
Date:   Sat, 20 Aug 2022 17:36:01 -0700
In-Reply-To: <CAO_RewZPXP1EUP90kU6uEQ3_CqqC7yWedjfNd7RaVASFSfrg0Q@mail.gmail.com>
        (Tim Hockin's message of "Sat, 20 Aug 2022 17:31:23 -0700")
Message-ID: <xmqq4jy6igb2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3C666DF6-20E9-11ED-861B-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tim Hockin <thockin@google.com> writes:

> Thanks.  Is there a more friendly way to do what I'm trying to
> express?  Should I just use `rev-list -n1` instead?

That's hard to answer, as you didn't exactly say what you are trying
to express.  All you asked was: why is "--" treated as an arg.
