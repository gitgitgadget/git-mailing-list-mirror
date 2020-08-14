Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D6D6C433E3
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 17:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 522AF20774
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 17:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jKD2QP8g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbgHNRGo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 13:06:44 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61946 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbgHNRGo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 13:06:44 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 868457EE65;
        Fri, 14 Aug 2020 13:06:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jrTColj0z+zBNOJYStzvpvUC/C8=; b=jKD2QP
        8gu98JKKE4m6B2Auwms6V+iqMJ2CjM94cfXsocIZjtX/UPyr/yJYzY3ij/xoA84K
        hB/Y0lP6cVegAhU8Akpz371W98O5rf6fVSXr1IT+LKKi1tsIa+JnhKJ1DeQLEA0N
        JrmUknLMPn1tG7NSTUvG7up0S8qf6rzDRFv08=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SKQToJjPOG5/ikQnZYf4noU0No9rK72Z
        3WMmSBKXE/rUqHV8w76ovFZZrMM0e0AuljI++SsFSvu5WHQdrMkX3XFCxrMqmXZx
        T8ODS8RBxnpvinb8pnmagOBttXUWJJSb8LYdtmQylh8G4Fa0k6vpG77pB80CU2NL
        afbMgDScGxw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7DE9B7EE64;
        Fri, 14 Aug 2020 13:06:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B14D17EE63;
        Fri, 14 Aug 2020 13:06:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     kaartic.sivaraam@gmail.com, christian.couder@gmail.com,
        git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        liu.denton@gmail.com, me@ttaylorr.com
Subject: Re: [PATCH v2 1/4] t7401: modernize style
References: <20200805174921.16000-1-shouryashukla.oo@gmail.com>
        <20200812192737.13971-1-shouryashukla.oo@gmail.com>
        <20200812192737.13971-2-shouryashukla.oo@gmail.com>
        <c70f7bb5d1289f5318da7b99e41cf5828a451174.camel@gmail.com>
        <xmqqd03u4hpl.fsf@gitster.c.googlers.com>
        <20200814144126.GA137865@konoha>
Date:   Fri, 14 Aug 2020 10:06:40 -0700
In-Reply-To: <20200814144126.GA137865@konoha> (Shourya Shukla's message of
        "Fri, 14 Aug 2020 20:11:26 +0530")
Message-ID: <xmqqsgcpxilb.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 858AF8A4-DE50-11EA-8760-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shourya Shukla <shouryashukla.oo@gmail.com> writes:

> Understood. I will revert the change. Though, what Kaartic suggested, to
> do a '--short=7', that will be okay to keep right?

Sure, that is a strict improvement to lose an unneeded process, as
long as we know HEAD is guaranteed to be unique with 7 hexdigits
(otherwise "cut" to strictly 7 and "rev-parse --short=7 HEAD" would
produce different results.

Thanks.
