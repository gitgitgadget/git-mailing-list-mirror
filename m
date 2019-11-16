Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CF361F4B5
	for <e@80x24.org>; Sat, 16 Nov 2019 02:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbfKPCkY (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 21:40:24 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55059 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727275AbfKPCkY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 21:40:24 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 89D742170D;
        Fri, 15 Nov 2019 21:40:23 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uOkAA54OEuCwZBa480stjUq9lsc=; b=YZ3xwo
        9HVI/CsvRg6TzfUI9b+5+2uauVtOXoSA7PDDxu/xf8bIVEV3AbZ1htecx9z++S7q
        PNh1UJ9RvwZzJlv0mzwsA9RSD+yiBTqVbw/tohckpZnq//S5YV7jL96AsTSDZ0MO
        LxB3Dr1DBfvCaIUtslKraf0JP5sb2Ay6bFZ1Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KoGVQUkBk26/cvJ6q90uQnPnQTWDbWW/
        IXBidyjIaO1L0nu0X4eUz6iwQgwVVV/oTDmmRyCq+aOuVnxU2Kr2EP3FB2P1Z9Qq
        NYTwUW3PJvolBjNUP6wv0CpfzKjpp1Ms89/Tqvl2P2Fyxh6wcs3njG0WyGqtulDH
        /2pZpBNDLAQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 824D92170C;
        Fri, 15 Nov 2019 21:40:23 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E62E52170B;
        Fri, 15 Nov 2019 21:40:22 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Ben Keene <seraphire@gmail.com>
Subject: Re: [PATCH v2 0/3] Feature: New Variable git-p4.p4program
References: <pull.465.git.1573679665.gitgitgadget@gmail.com>
        <pull.465.v2.git.1573828978.gitgitgadget@gmail.com>
Date:   Sat, 16 Nov 2019 11:40:21 +0900
In-Reply-To: <pull.465.v2.git.1573828978.gitgitgadget@gmail.com> (Ben Keene
        via GitGitGadget's message of "Fri, 15 Nov 2019 14:42:55 +0000")
Message-ID: <xmqqd0ds5ysq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 70020728-081A-11EA-9F1F-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Ben Keene via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Ben Keene (3):
>   Cast byte strings to unicode strings in python3
>   Added general variable git-p4.binary and added a default for windows
>     of 'P4.EXE'
>   Changed the name of the parameter from git-p4.binary to
>     git-p4.p4program

That's rather poor organization.  In the larger picture, nobody
wants to even know jthat you used to call git-p4.p4program with a
different name or what that different name was.  They do not even
need to know why the new name is an improvement (but you do not even
discuss to justify the name change in the proposed log message of
3/3, which is even worse X-<).

When presenting your work to the public, Git lets you pretend to be
a perfect human who never made mistake while preparing it and built
the series as a logical progression with perfect foresight.  That is
how "git rebase -i" is useful.  Learn to take advantage of that ;-)

As to individual patches, our local (read: project specific)
convention around here is to state the are the patch touches (in the
case of these patches, "git-p4" is the appropriate area name), colon,
and then a one-line summary of what the step is about (the last one
is done without initial capitalization).  The summary is written with
the focus more on why and what than how.

Thanks.



