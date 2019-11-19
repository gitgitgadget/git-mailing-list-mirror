Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 823AC1F4B5
	for <e@80x24.org>; Tue, 19 Nov 2019 02:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbfKSC4z (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Nov 2019 21:56:55 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53219 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbfKSC4z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Nov 2019 21:56:55 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3E76A9877B;
        Mon, 18 Nov 2019 21:56:53 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6dFkiZ8zsJEr73jKqAJb0dgF/1Q=; b=bTSe1N
        gCGYjUF07HK/pRapPsJ2rLwOd3SAdmLNDsD7qhHtBBdEUegbNE/GxxhAl6O9Y94B
        7sxtrVkFnLKTcQX4L9umtpUL7c544Q9eHQ9+RJYcHxR25htEMf6jS2DFGgNJ4qQy
        IoaL3XELYL+z/TOMuF903S8w3HMiQcGgu5IX4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Xpk6UI8gq3xQAY+M5WcX6S4LfbYhR4yl
        cPyzlPFGMcXnrnIL9nICnMciqCFfPLmV4r0bnXNw1QuUSMjSvM+EeT5Wpfck/ZC0
        LnmKMV5I2/+EES5csb+YVzd68uQO4c4T08fzulmKcffsYPQ4p8xDZLrTu6SYvq7p
        DpHeTcMjvcg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3609F9877A;
        Mon, 18 Nov 2019 21:56:53 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 663FF98778;
        Mon, 18 Nov 2019 21:56:50 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH 0/3] range-diff: don't compare notes
References: <cover.1574125554.git.liu.denton@gmail.com>
Date:   Tue, 19 Nov 2019 11:56:48 +0900
In-Reply-To: <cover.1574125554.git.liu.denton@gmail.com> (Denton Liu's message
        of "Mon, 18 Nov 2019 17:06:52 -0800")
Message-ID: <xmqqftikzi8f.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3BD495D2-0A78-11EA-BE22-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> When I was using range-diff at $DAYJOB earlier, I realised that it
> includes commit notes as part of the commit message comparison. This is
> undesired behaviour so this patchset documents it and stops it from
> happening.

I actually wish it allowed me to compare them _with_ --notes=<ref>
specified by the user.  If you are passing --no-notes through,
perhaps you can also pass through such an option while at it.
