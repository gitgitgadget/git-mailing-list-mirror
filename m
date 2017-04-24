Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C0B2207BD
	for <e@80x24.org>; Mon, 24 Apr 2017 00:26:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163764AbdDXA0A (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Apr 2017 20:26:00 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51217 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1163521AbdDXAZ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Apr 2017 20:25:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DC73F7C246;
        Sun, 23 Apr 2017 20:25:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8pAJbeSxMMjBfJa77uR+nPwaWRI=; b=Cm1hyc
        tL/qvEsu4UusXM6f2l5d+HJ/vGWc8TnU0/7vux1fYqtMqOI0UTcR0gtnkAeuJi3H
        aZUUV+YETzi+2Yn5QMOqqoRT5Iiy+zDSAyPnTklBWEFD8tSFEIVoCX12tEAXO/dF
        w/rzglN5N1d7CxEsM+T0mF/cjEMLIyMAAXkc0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Q8uJH67MBf2/mTpdxCPbMimj7dU+apEJ
        PIp76OY/vWOsTQDvwjY0FxFyKYpmxMlWuyH+U0hIBEGD/W22IhhaMxLm9Ah/zdI0
        GQp9VYrtkZGbfp5HHT5sVH46t7yvy0qJFejB7pfPYDtBOdMd2YO5mZni83PIbTjI
        jN2AJPEFmJU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D490E7C245;
        Sun, 23 Apr 2017 20:25:56 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 426277C244;
        Sun, 23 Apr 2017 20:25:56 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org,
        peff@peff.net, bmwill@google.com
Subject: Re: What's cooking in git.git (Apr 2017, #04; Wed, 19)
References: <xmqq4lxjabce.fsf@gitster.mtv.corp.google.com>
        <D61D47BD-9750-4FB6-892E-013504E03738@gmail.com>
        <xmqqbmrq8z4j.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1704211135430.3480@virtualbox>
Date:   Sun, 23 Apr 2017 17:25:54 -0700
In-Reply-To: <alpine.DEB.2.20.1704211135430.3480@virtualbox> (Johannes
        Schindelin's message of "Fri, 21 Apr 2017 11:50:20 +0200 (CEST)")
Message-ID: <xmqqfugy4pnx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 953FC23C-2884-11E7-9E39-E680B56B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Part of the reason is that you push out all of the branches in one go,
> typically at the very end of your work day. The idea of Continuous
> Integration is a little orthogonal to that style, suggesting to build &
> test whenever new changes come into the integration branch.
>
> As a consequence, my original setup was a little overloaded: the VM sat
> idle most of the time, and when you pushed, it was overloaded.

I do not see pushing out all them in one go is making the problem
worse for you, though.

As of this writing, master..pu counts 60+ first-parent merges.
Instead of pushing out the final one at the end of the day, I could
push out after every merge.  Behind the scenes, because some topics
are extended or tweaked while I read the list discussion, the number
of merges I am doing during a day is about twice or more than that
before I reach the final version for the day.  

Many issues can be noticed locally even before the patches hit a
topic, before the topic gets merged to 'pu', or before the tentative
'pu' is pushed out, and breakage at each of these points can be
locally corrected without bothering external test setups.  I've been
assuming that pushing out all in one go at the end will help
reducing the load at external test setups.
