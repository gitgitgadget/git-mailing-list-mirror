Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7736E1F463
	for <e@80x24.org>; Mon,  9 Sep 2019 19:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731563AbfIIToc (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Sep 2019 15:44:32 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57825 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730465AbfIIToc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Sep 2019 15:44:32 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 635F593690;
        Mon,  9 Sep 2019 15:44:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TKJ48Ao339S0fyokJhs1feLbyjg=; b=kBBmwH
        xr9iKmIzz6+zvA1pfI7wWbkwgW3GcqMuS50XaeqSZzcp9gUs5L/q8yyGsAj8Vz6x
        i+VEUyXbpLPTUSlcD9vwGgRGoSHotG4FfvbKM/O1VeGhh1pZUxfvZyvX9v65pB4D
        tK873/swWeOIWfVO67fzxuD+fpBvnR6gbXaUQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Ce1eN+wdI8xi/2tTQBt7Qs6ULJKDLRnr
        pxRa5z79ILe/d/pYyu8dEVimhXL58pRyl8XlHdga4eg8Y61Lch8PR/agTdcuzI+r
        4q6eVv1B8/oxlyxrHoTK/fzYo2iNP99ZfwkIVgI0OWSoKLFs6CxyivIQmPio+MG0
        3ChqpuysoXk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5BE5B9368F;
        Mon,  9 Sep 2019 15:44:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 833FC9368D;
        Mon,  9 Sep 2019 15:44:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "Stephen P. Smith" <ischis2@cox.net>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] test_date.c: Remove reference to GIT_TEST_DATE_NOW
References: <20190909014711.3894-1-ischis2@cox.net>
        <20190909014711.3894-3-ischis2@cox.net>
        <20190909172954.GC30470@sigill.intra.peff.net>
Date:   Mon, 09 Sep 2019 12:44:25 -0700
In-Reply-To: <20190909172954.GC30470@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 9 Sep 2019 13:29:54 -0400")
Message-ID: <xmqqwoehi7ae.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3BC0196A-D33A-11E9-A70B-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Sun, Sep 08, 2019 at 06:47:11PM -0700, Stephen P. Smith wrote:
>
>> Remove the reference to the GIT_TEST_DATE_NOW which is done in date.c.
>> The intialization of variable x with the value from GIT_TEST_DATE_NOW
>> is unneeded since x is initalized by skip_prefix().
>
> It took me a minute to understand what this second sentence meant. I'd
> have actually expected "x" to go away, looking at the diff context.
>
> Maybe a more clear explanation would be: We can't get rid of the "x"
> variable, since it serves as a generic scratch variable for parsing
> later in the function.
>
> (I'd also probably have just rolled this into patch 1, but I'm OK with
> it either way).

Thanks for saying everything ;-)  I have nothing to add.
