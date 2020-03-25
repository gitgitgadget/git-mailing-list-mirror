Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB52CC1975A
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 06:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6712206F8
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 06:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SZiNEAI2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbgCYGK0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 02:10:26 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58413 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgCYGK0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 02:10:26 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 60C9DB7595;
        Wed, 25 Mar 2020 02:10:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zk5JbDeeuCOlgsj7qrlqOP0Ve+E=; b=SZiNEA
        I22jREi+xV5oRhCBDoNk0R5C5r0pVriuQ7gNwWVBrZpvuCBA1EdI+lkrx9mlchx0
        wQe4ZVQL3XW60SX0ryaVhUG/NZRXvavZ1PsPFJ0lqxbT0vp6K5lQlW4M3CK7WrqD
        Ge1M+qfYAf70huJJNmL5Q7iQX8Rvn8KgZxDi8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UVsNSXYn4zUlkOMmrrOzlSV6BiBqwGWB
        kIlu3w4r/XMrg2M5FbZlGlQZMocH/M0RTYpHmRrM444+pWeRdJlFQ+FXpSea9PUF
        MDu+12bn1z6FzhlGWJ3xGMa6e9cRfc8fAl5/LLj7wBS81HAMxk+814AjoGupfG2e
        2pZs1exP2Ow=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4B570B7592;
        Wed, 25 Mar 2020 02:10:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7F7BDB7555;
        Wed, 25 Mar 2020 02:10:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>, Emily Shaffer <emilyshaffer@google.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: Re: [PATCH v2 0/1] FAQ for common user questions
References: <20200325013434.219775-1-sandals@crustytoothpaste.net>
Date:   Tue, 24 Mar 2020 23:10:19 -0700
In-Reply-To: <20200325013434.219775-1-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Wed, 25 Mar 2020 01:34:33 +0000")
Message-ID: <xmqqzhc5x8vo.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4F0C6CF6-6E5F-11EA-A0AB-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I know there are some plans to add additional entries to this.  I
> propose we tack them on as additional patches, and if I need to reroll
> this again, I can pick them up as part of the series, unless someone
> has strong opinions about doing things differently.

I do not have a strong opinion, but have a mild preference for the
way you are proposing.  Let's take this almost as-is (modulo
fixes to possible typos if people spot any soon enough) and leave
the enhancement to follow-up patches.
