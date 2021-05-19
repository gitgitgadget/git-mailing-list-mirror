Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C0FEC433B4
	for <git@archiver.kernel.org>; Wed, 19 May 2021 22:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE41A6124C
	for <git@archiver.kernel.org>; Wed, 19 May 2021 22:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbhESWTQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 18:19:16 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56259 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbhESWTP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 18:19:15 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ECCCED1CBB;
        Wed, 19 May 2021 18:17:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QS10AxljKtqtANnylCEYaxsSZT4BbV0PiG8DR1
        J+vDE=; b=tCjKJTCvjdiG9oc2DFb98w9VFLeC6+JIcd6VbR6GCKerPfZdNDRutz
        cIc6qNkkxgkQZ0pl1CiTvHym+vamDG5VsgvMVX8E5m8JW5Pmj0sT+Uf5NZ9+bi/y
        vyHy/RZkZ2daSHZVBcYBrE1Ej0qbO2X1ZSxhMXUP9kj97tEC1/YGs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E1EDFD1CBA;
        Wed, 19 May 2021 18:17:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6B788D1CB9;
        Wed, 19 May 2021 18:17:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] stash show: don't setup default diff output format if
 --{include,only}-untracked given
References: <76dfa90a32ae926f7477d5966109f81441eb2783.1621325684.git.liu.denton@gmail.com>
        <xmqq35uj1pmd.fsf@gitster.g> <YKTZIOOe+IW41MXp@generichostname>
Date:   Thu, 20 May 2021 07:17:53 +0900
In-Reply-To: <YKTZIOOe+IW41MXp@generichostname> (Denton Liu's message of "Wed,
        19 May 2021 02:23:44 -0700")
Message-ID: <xmqqbl96xt9q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0EC76F9C-B8F0-11EB-9032-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> I could be convinced either way and I was erring on the side of caution
> by proposing this patch. I'm okay with the status quo so we can keep the
> behaviour as is, unless someone objects in which case we should revert
> pending more discussion.

I do not know if "--stat" is a good default for "git stash show",
with or without "-u", to begin with, but if the default varies
between "git stash show" and "git stash show -u", it would be like
"git diff" and "git diff HEAD" using different defaults depending on
what is being compared.  And from that point of view, I did find
that the patch takes the behaviour in a less consistent and more
confusing direction.

> I'll send a follow-up patch later this week clarifying the docs.

Thanks.
