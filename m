Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB98C2BA2B
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 17:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65DA120801
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 17:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rIqJkiWC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgDJRMY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 13:12:24 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59277 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgDJRMY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 13:12:24 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 041054823A;
        Fri, 10 Apr 2020 13:12:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ufEjpHpwzsg/Msm7unbtDLinlXc=; b=rIqJki
        WCqDOYMAWOqMZYeEGCwkXS0wi/LU7KrGgsK3C6sWux/aFmm3E7kDAIBdmJLpQtfb
        QS7TQ84tLMNnjnS5TLxHfTmCa9HFHXYvoHd0UfCbwpfVtTEBMS0eaqqXLv1I1ksj
        bRvm0Q9GuoBNyk7SBl0SGqdDloFyyw6d+361A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wPBR/y0FxAWH4Nz6PvW8XI1Hw3NpqKML
        xAKeHwXwVW2Os7bCX/3psnHlvmo9Mcp6LEC6URB7xOMkkmaAw6xojCbMiCi49Mur
        ERfjnWVXOwLEoWUnDSxQUpuS5KStB+pTMAInpBV7ZDqLHV7pXkdVnCHSgZYjqlTR
        eNWIVhwROsk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EF7BB48239;
        Fri, 10 Apr 2020 13:12:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6271248237;
        Fri, 10 Apr 2020 13:12:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] merge: use skip_prefix to parse config key
References: <20200410151032.23198-1-martin.agren@gmail.com>
        <20200410155827.GA71011@coredump.intra.peff.net>
        <xmqqo8rzjnnb.fsf@gitster.c.googlers.com>
        <20200410165644.GA79836@coredump.intra.peff.net>
Date:   Fri, 10 Apr 2020 10:12:21 -0700
In-Reply-To: <20200410165644.GA79836@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 10 Apr 2020 12:56:44 -0400")
Message-ID: <xmqqk12njmdm.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 71261020-7B4E-11EA-912F-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Shifting from "iterate over and store config keys" to "look up config
> keys on demand" is a much bigger change, though. I would only do it if
> it made the rest of the code flow easier.

Yeah, absolutely.

Thanks.

