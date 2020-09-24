Return-Path: <SRS0=EnZj=DB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C11CC4346E
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 06:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 292B8206FB
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 06:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="koOeKfhL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgIXGp6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Sep 2020 02:45:58 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52681 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbgIXGp6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Sep 2020 02:45:58 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 68F928E2F9;
        Thu, 24 Sep 2020 02:45:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JiwMN31KR3u2QX1yuqas8yZUdWc=; b=koOeKf
        hLHgv1ZPXFS5Vm4oy0BO2Rks8JF4HUNgCd+ufHdAjLFa3tKfM6y5k8HE8cZIVSDv
        UExFe0+ivlV1RuvnvIw2L2y83BpAYKkneBuDpcnYTTfHLVGoyGF2IArUDwLmKipm
        RMkgTwvvlF7njfuE+Msk6iVchnSLZCKLsuuNc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ku9rDcf2609aisK4jcxPZokX0pJ4UmW6
        e0Q0gLvRwviOJPRGksTxjFlZ1kz58VOCTSJaARm/nCSHOsUXFw+xqP2E3IcJi6M0
        lem7krUuKnRjqUMwJ8Z2aq3h9C6CacFpcUHfS2WXVaErviqfnUlHNrqNrFVVkKOz
        RykXXJ2JXI4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5070D8E2F7;
        Thu, 24 Sep 2020 02:45:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B7BE68E2F5;
        Thu, 24 Sep 2020 02:45:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ryan Zoeller <rtzoeller@rtzoeller.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC 0/1] Leading whitespace as a function identification
 heuristic?
References: <20200923215859.102981-1-rtzoeller@rtzoeller.com>
Date:   Wed, 23 Sep 2020 23:45:55 -0700
In-Reply-To: <20200923215859.102981-1-rtzoeller@rtzoeller.com> (Ryan Zoeller's
        message of "Wed, 23 Sep 2020 21:59:09 +0000")
Message-ID: <xmqqzh5fhduk.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 98BE7558-FE31-11EA-AFCE-01D9BED8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ryan Zoeller <rtzoeller@rtzoeller.com> writes:

> 1. Is this indentation-aware function identification useful, and
>     generally worth pursuing further?

I cannot shake the feeling off that this is being overly generous
and inviting for misidentification for languages whose usual
convention is not to nest and indent the definitions freely.

IOW, why can't the "we allow leading whitespaces" a per-language
thing?  IOW, why do we even need any new code---shouldn't it be just
the matter of defining xfuncname patterns for such a language with
nested and indented definitions?

So, a mild Meh from me at this point.  I may change my mind in the
morning, though ;-)

Thanks.
