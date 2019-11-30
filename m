Return-Path: <SRS0=RoqO=ZW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFA5C432C3
	for <git@archiver.kernel.org>; Sat, 30 Nov 2019 20:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00CCD215E5
	for <git@archiver.kernel.org>; Sat, 30 Nov 2019 20:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bSjsHTZ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfK3UX2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Nov 2019 15:23:28 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58441 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbfK3UX2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Nov 2019 15:23:28 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 26EDA9CABB;
        Sat, 30 Nov 2019 15:23:26 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DHDKalR2smsvR3QwqkOySHJ9UOk=; b=bSjsHT
        Z6ss6fFedUwS0EWSTjKD51CblXscxBvQquw7BTzQ4K3JpuEqFNeqHp0gkrAna0vQ
        gTJOOm3OK5/U1bj2+OyYSaMraiYkyuGifGE0AFWccC0TJQBtKz07V8LtdQeiHbf2
        UfWTckAnNDJbTKlZTkaz+qI8CgHX47zBHOz3Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Gd0CVyQnCfvzQpVi61+E6qsCbZ7pC+b5
        Z2NYX9CXoFz2iAIXfMeHg29Nw7F9qvVrwNGgPPICg+Kcj2J50PeuBPFsauTOoFEw
        7pwf+qIfI5oM9EE+uRE+usmLlrEIaERJrerwvI+WCFNx6+F+WSsw1GL8pU9/28LF
        s/8iHDsQ0i8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0C31E9CABA;
        Sat, 30 Nov 2019 15:23:26 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 07D059CAB9;
        Sat, 30 Nov 2019 15:23:22 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 0/2] Brown-bag fix on top of js/mingw-inherit-only-std-handles
References: <pull.480.git.1575063876.gitgitgadget@gmail.com>
        <pull.480.v2.git.1575110200.gitgitgadget@gmail.com>
        <xmqq5zj12qc2.fsf@gitster-ct.c.googlers.com>
        <6beaf25f-1369-3e77-fd54-fdb5a1e63707@kdbg.org>
        <8736e5t98b.fsf@igel.home>
Date:   Sat, 30 Nov 2019 12:23:20 -0800
In-Reply-To: <8736e5t98b.fsf@igel.home> (Andreas Schwab's message of "Sat, 30
        Nov 2019 21:11:48 +0100")
Message-ID: <xmqqwobh15c7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 41AFFAF6-13AF-11EA-8B46-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andreas Schwab <schwab@linux-m68k.org> writes:

> On Nov 30 2019, Johannes Sixt wrote:
>
>> Am 30.11.19 um 19:04 schrieb Junio C Hamano:
>>> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
>>> writes:
>>> 
>>>>  * We now assign errno only when the call to CreateProcessW() failed.
>>> 
>>> Meaning the global variable 'errno' is left as it was (instead of
>>> getting cleared) when a system call succeeds?  That I think is the
>>> correct behaviour people who use the variable expect.
>>
>> I hope you mean people who read the code. You cannot possibly mean
>> developers who expect that the run-command API keeps errno unchanged if
>> the calls were successful. I'm pretty sure they do not provide such a
>> guarantee.
>
> POSIX guarantees that no library function sets errno to zero.

It is true, but the rest of the Git code works on top of an
abstraction a bit higher than C/POSIX library.  The run-command API
J6t cites is an example.

IOW, we cannot take advantage of that POSIX guarantee in the
codepaths that use our internal API.  So...

