Return-Path: <SRS0=4+BP=3K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC16C2D0CE
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 17:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA56421569
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 17:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="AeOayz8n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbgAURhW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jan 2020 12:37:22 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54316 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729099AbgAURhW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jan 2020 12:37:22 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 54E5F56C88;
        Tue, 21 Jan 2020 12:37:20 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=h0b5L8Y3Z3abG3LQmkZ9KMTiNKQ=; b=AeOayz
        8nT7z48siwI06aUngbQ7PIYftGgRLlbQk8ATBRAmWpKwb6OI9GyvuaixgtVLYW4L
        LSixzuYsCgd1fo1txrzQ0yPIgcG1JfgCXzuk1/B1LVPZREMxpVkWy3250k0yVme3
        luXfZ61x+wfY+iQW7jPVy294cOTqbLhWf9Cn4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=amdhjYcJSSMIjdUGdK3NkDuUnoS/6fc7
        U0eRek+bD214BXhq008rrR1JbjP1djflHtBa6KLvFiEAfc7VS7+5ZeVpvd5LHWmL
        35X0nP1o0VjubT+Oj/aJ1cMjgWB7daBPwTlG/ZtrPhPvGbhztgcgHOl22azRyDxp
        DUApdW1+ljg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4B96F56C87;
        Tue, 21 Jan 2020 12:37:20 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 60E0756C86;
        Tue, 21 Jan 2020 12:37:19 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eyal Soha <shawarmakarma@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 2/3] color.c: Support bright aixterm colors
References: <CANsz78JyawDpp_SewRQp4_AbZVduSYiazhvCqUcqUV810az5MQ@mail.gmail.com>
        <20200118145318.5177-1-shawarmakarma@gmail.com>
        <20200118145318.5177-2-shawarmakarma@gmail.com>
        <xmqqv9p8bo0o.fsf@gitster-ct.c.googlers.com>
        <CANsz78+-Z89d8E=n3cjfnXaGVFXpchdG7EjtdQuFjzo-=2aPeA@mail.gmail.com>
Date:   Tue, 21 Jan 2020 09:37:18 -0800
In-Reply-To: <CANsz78+-Z89d8E=n3cjfnXaGVFXpchdG7EjtdQuFjzo-=2aPeA@mail.gmail.com>
        (Eyal Soha's message of "Tue, 21 Jan 2020 08:52:49 -0800")
Message-ID: <xmqqr1zsbtip.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AC618D54-3C74-11EA-9225-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eyal Soha <shawarmakarma@gmail.com> writes:

>> I have to wonder if spelling "bright<color>", i.e. two words smashed
>> together without anything in between words, is in widespread use (in
>> other words, are we following an established practice, or are we
>> inventing our own), or if we need to prepare for synonyms?  HTML/CSS
>> folks seem to use words-smashed-without-anything-in-betwen so they
>> should be fine with this design; I no longer recall what X did ;-)
>
> /usr/local/lib/X11/rgb.txt often uses smashed together:
> https://github.com/vim/vim/blob/master/runtime/rgb.txt  Wikipedia
> calls them "bright" consistently:
> https://en.wikipedia.org/wiki/ANSI_escape_code#Colors .  So we've got
> a vote for smashing them together and a vote for "bright".  Seems okay
> by me!

OK.  By synonym, I did not mean any word other than "bright"; in the
context of my response, "brightred", "bright red" and "bright-red"
would have been synonyms, but I think it is sufficient to support
only the first one.

Of course, somebody may come up with a bright idea to treat the
"bright" adjective just like "underline" and "bold" and that might
improve the end user experience slightly better, but I dunno ;-)

