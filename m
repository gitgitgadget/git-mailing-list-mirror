Return-Path: <SRS0=yIgW=23=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F4FC33C8C
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 20:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0D9720731
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 20:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cgr/NuLE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgAFUlx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jan 2020 15:41:53 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63170 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbgAFUlw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jan 2020 15:41:52 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B6911A6EB7;
        Mon,  6 Jan 2020 15:41:50 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+8YybHCtEbu3ZoD46jz1Uh4TniY=; b=cgr/Nu
        LE1rZ4sQWvp8lmxNC6zm3ZSF33R/lklJO+4V99RX/DgE20EItdPix1+f44QblY6O
        3Qy3TagMsUC9YoAmVxdhZVWH4w0CqatjdyKNr2RtY+b5RiPRg85y9o48OZZC2af5
        OsuDd/Y8AEE8vB/5WDq+pYYE7U8GzxgLUI0Ig=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WHUQ4Ec6/dhMpox9JsA21aMQ72FY7daM
        iv/6KT5LCSI+TcBnK2e1LqSvNVp8VdXVbKSCuyrkkie0BCGZZJqXzws/o/WaQgVl
        WfD96T4YrT9EKSszWMmKq6MABS5K4bC8/iht/aN+/HBPW8P4QQpelz6T1C7NkT+k
        GuFsCuUy86w=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AD991A6EB6;
        Mon,  6 Jan 2020 15:41:50 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8A67CA6EB5;
        Mon,  6 Jan 2020 15:41:47 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Mike Rappazzo <rappazzo@gmail.com>
Cc:     Michael Rappazzo via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 0/1] sequencer: comment out the 'squash!' line
References: <pull.511.git.1578326648.gitgitgadget@gmail.com>
        <xmqq7e24a3t0.fsf@gitster-ct.c.googlers.com>
        <CANoM8SV=pT3sFrfnEqWc2xBn_c2rES0qSMsdptF0DgcxgYL94w@mail.gmail.com>
Date:   Mon, 06 Jan 2020 12:41:45 -0800
In-Reply-To: <CANoM8SV=pT3sFrfnEqWc2xBn_c2rES0qSMsdptF0DgcxgYL94w@mail.gmail.com>
        (Mike Rappazzo's message of "Mon, 6 Jan 2020 14:20:09 -0500")
Message-ID: <xmqqimlo8ghi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F5533A3C-30C4-11EA-A430-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mike Rappazzo <rappazzo@gmail.com> writes:

> This change isn't removing the subject line from the commit message
> during the edit phase, it is only commenting it out.  With the subject being
> commented out, it can minimize the effort to edit during the squash.

Which means existing automation will be broken if they are not
taught to be aware that these subject lines can now be commented out
if their Git is recent enough, which does not sound like a good thing.

> Furthermore, it can help to eliminate accidental inclusion in the final
> message.  Ultimately, the accidental inclusion is my motivation for
> submitting this.

Yes, but that is why the concatenated messages are given to the
editor to be "edited" by you, to be better than just a
concatenation, right?  When I deal with a "squash" (not "fixup"),
the end result would have a log message for a single commit that
describes the single thing it does, which would not resemble to the
original of any of the squashed message---and removing extra title
lines would be the smallest part of such an edit.  So...
