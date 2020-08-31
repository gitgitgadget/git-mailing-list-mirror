Return-Path: <SRS0=A5vO=CJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9273C433E2
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 18:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F3F0206FA
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 18:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IwfgpL6+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbgHaS7a (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:59:30 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57185 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727993AbgHaS73 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Aug 2020 14:59:29 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 18B0FF13A3;
        Mon, 31 Aug 2020 14:59:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=W0P7WAnMLW70NfLny4lsLUcbKK8=; b=IwfgpL
        6+FbSlzkIrlG+YXvBVV8L7GVuqPzVwd6eMGd+0gs24dU5m8HyycYpOw+YjnhJoO5
        fKV2NqZE+t7oBiwqMAIBG92rlUo0DdVspcZV/XaMLwkF5WKEWXqYYijabOZlu1s4
        1odfgiiTWiGSKvJlYoa/TZIPgTJ2Awj4QYk8Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vSU6AeqUn4Gnv4CbR1JHI/0ljdbiCQ6k
        NQCVP8Q2MCsEyTA+pr3rcpOa5F/dF6akpZMYf1J96mTqECiD08mAPuPiZi+1ca8N
        FGg1KFp93NBGbVIUDQHE8Z/c8+w+6N7lJfpLd9WVPvs/OVqmkGcvUr6L7pjkGqLL
        IOo4Th6JBi0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EDFA6F13A2;
        Mon, 31 Aug 2020 14:59:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 42F62F139F;
        Mon, 31 Aug 2020 14:59:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org,
        =?utf-8?Q?Henr=C3=A9?= Botha <henrebotha@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v2 0/5] add "git worktree repair" command
References: <20200827082129.56149-1-sunshine@sunshineco.com>
        <20200831065800.62502-1-sunshine@sunshineco.com>
Date:   Mon, 31 Aug 2020 11:59:24 -0700
In-Reply-To: <20200831065800.62502-1-sunshine@sunshineco.com> (Eric Sunshine's
        message of "Mon, 31 Aug 2020 02:57:55 -0400")
Message-ID: <xmqqbliqfxpv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 17252A82-EBBC-11EA-9DE0-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> This is a re-roll of [1] which adds a "git worktree repair" command
> and which fixes bugs with "git init --separate-git-dir" related to
> worktrees.

These look good to me.  Thanks.
