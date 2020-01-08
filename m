Return-Path: <SRS0=ZiOn=25=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C8AC282DD
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 16:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F5A620678
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 16:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TSo7G0W0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729524AbgAHQxK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jan 2020 11:53:10 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61261 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727308AbgAHQxK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jan 2020 11:53:10 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 04C4E3BEC2;
        Wed,  8 Jan 2020 11:53:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=a9TZmn3f/q/UlCm4YTQ64AnGkmY=; b=TSo7G0
        W0FAlvkigMossENjNBeyY4vugXtdxWbi3Q53dxHPXWg9KljouVO6pTNHctSo0NHO
        aLR6aHs4c3j4LKpwM9b0r/P+zNGszkEKXt5x76cKuntq4KAZ5FmDFTJIADANdORv
        XUw1toMMss5FMf1qVIs3sOrpVmMsy95Tby6mw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hjr2SbLZKk6X+grT6f+bfHhvP8yoWh4o
        ZftcY5XhsnZdI8RfD39ivaYcbKcy2HHbKSKDq/t0njG9RLcpLusIXjizG5OffPNa
        B+xdUTyhmKk+X173kJ4X4qOQuS0UEKZaqUUEOY0uXSyQrVTJFGoDrBPOauRN+gui
        Ra6Awt/lezc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F01293BEC1;
        Wed,  8 Jan 2020 11:53:07 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5E4563BEC0;
        Wed,  8 Jan 2020 11:53:07 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Mike Rappazzo <rappazzo@gmail.com>,
        Michael Rappazzo via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 0/1] sequencer: comment out the 'squash!' line
References: <pull.511.git.1578326648.gitgitgadget@gmail.com>
        <xmqq7e24a3t0.fsf@gitster-ct.c.googlers.com>
        <CANoM8SV=pT3sFrfnEqWc2xBn_c2rES0qSMsdptF0DgcxgYL94w@mail.gmail.com>
        <20200107013401.GI6570@camp.crustytoothpaste.net>
        <xmqqlfqj6y5n.fsf@gitster-ct.c.googlers.com>
        <20200108025509.GM6570@camp.crustytoothpaste.net>
Date:   Wed, 08 Jan 2020 08:53:06 -0800
In-Reply-To: <20200108025509.GM6570@camp.crustytoothpaste.net> (brian
        m. carlson's message of "Wed, 8 Jan 2020 02:55:09 +0000")
Message-ID: <xmqqv9pl3n65.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 58499D20-3237-11EA-8904-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2020-01-07 at 16:15:16, Junio C Hamano wrote:
>> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>> 
>> > I can see the argument that this makes it a little harder for mechanical
>> > processing across versions, but I suspect most of that looks something
>> > like "sed -i -e '/^squash! /d' COMMIT_EDITMSG" and it probably won't be
>> > affected.
>> 
>> With the left-anchoring, the search pattern will no longer find that
>> line if "squash!" is commented out, but people tend to be sloppy and
>> do not anchor the pattern would not notice the difference.  Perhaps
>> the downside may not be too severe?  I dunno.
>
> Sorry, I was perhaps bad at explaining this.  In my example, it would no
> longer remove that line, but the user wouldn't care, because it would be
> commented out and removed automatically.  So while the code wouldn't
> work, what the user wanted would be done by Git automatically.

I didn't realize that you only care about 'd' there; you're right of
course if you limit the scope of the discussion that way.

I was talking in a more general terms where "^squash!" is used as a
marker that signals the boundary between two original commits and
the processing is done possibly differently on each part.

