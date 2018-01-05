Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B9241F428
	for <e@80x24.org>; Fri,  5 Jan 2018 20:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752830AbeAEUpH (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 15:45:07 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51236 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752766AbeAEUpG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 15:45:06 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D2E09CED4A;
        Fri,  5 Jan 2018 15:45:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rPEa4eSkBAC9P/9HraCSRFXj5XY=; b=NZKKIh
        YCjGMI3HzSWRMNCuMn7AgYxKsfFIyBBAhayKLdX1pJISXoHMh5JZb7nRrewmO7/q
        HFAm/W2o8y7kwdZUDBdKtZwtcNDclC7luylZvoSMkx5zMnnZKv8/6ZVEZNM/JDn7
        95CTZ+pXHMXkg6vZlFLm+vp0W5OEy+eK3UT4k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YEc9zlxql+qGu2ecBeBxKoYrICmG0Th5
        spioQYcHxB4VaqapyD8Fz00/fpaJ0xVLX7VJuHeK82NbD9sKv9PgNI8oYkNyVMK4
        zHxDrvselnbFpSbg7snmv51s4w4CvPsRAlwY3JZ8hhwRj2Hg6SXPUvFWztOTxrca
        5ZePYRYcrO0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CA662CED49;
        Fri,  5 Jan 2018 15:45:05 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2CD09CED44;
        Fri,  5 Jan 2018 15:45:05 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Isaac Shabtay <isaac@shabtay.com>, git@vger.kernel.org
Subject: Re: Bug report: git clone with dest
References: <CAK2k7nSsygwRj_Hhrz7-qXZ8UBB=O+deOeC2FFTkrGmWSUpKqA@mail.gmail.com>
        <20180103222821.GA32287@sigill.intra.peff.net>
        <CAK2k7nQcY+QQBfda6CHM8tFo3i4XX2tXxHKv73t6SJ4rRvWo1w@mail.gmail.com>
        <20180104040124.GA11626@sigill.intra.peff.net>
        <xmqqfu7kcca9.fsf@gitster.mtv.corp.google.com>
        <20180105195705.GA5217@sigill.intra.peff.net>
Date:   Fri, 05 Jan 2018 12:45:03 -0800
In-Reply-To: <20180105195705.GA5217@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 5 Jan 2018 14:57:05 -0500")
Message-ID: <xmqqmv1savcg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4F25A5EC-F259-11E7-A9AD-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Out of curiosity, did this change at some point? I thought the process
> used to be to merge to maint, and then pick up topics in master by
> merging maint to master.

If you look at "Sync with maint" merges made to 'master', you'd
notice that most of them are only updating Documentation/RelNotes/*
and otherwise no-effect merges, simply because when such an up-merge
is made, everything in 'maint' is already in 'master' because topics
are merged to the latter first.  Security fixes that go through
embargoes are excempt for obvious reasons ;-)

I do not recall how it was before 2012.

