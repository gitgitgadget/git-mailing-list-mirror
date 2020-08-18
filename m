Return-Path: <SRS0=LSsm=B4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A24C433E1
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 20:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AC52206B5
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 20:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="k0zUS7ev"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgHRUc3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Aug 2020 16:32:29 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53422 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgHRUc2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Aug 2020 16:32:28 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BBDFDEA4C3;
        Tue, 18 Aug 2020 16:32:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OUp+O1IoDXynDtyHiVJZT5bWiR8=; b=k0zUS7
        evBa43Zw2cvSMmxTeODNJ6I00OO39+048amxe2nNmjy2wwxWZ9+pBusctitIzPj9
        MeDPrrm3YUvfoP4MCEZRX+qmT0E3QiiLunhbb5b/gbdx412jdJbTpzJyqCP3TLLo
        WTMXN8+uxdbsQaPj808KG9Jw7R75+9NU/E2BU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AM3pHshR/r6lHTxeIA2lIJfC12KLM3fL
        JbRPvML5Ox73TdCEvKOQ7jHHTw9F0WCbsomIc4WcFLkj9GJvJP0bVSrmEpRaKNe0
        k1UotMx0JB5d7Ye5u9j8MhjSkqkKC8uTDEzAYBUjHiws/i5BcZZptvv/S8TV1PRK
        NmDwn/Qmqf0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B45E1EA4C2;
        Tue, 18 Aug 2020 16:32:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 43F54EA4C0;
        Tue, 18 Aug 2020 16:32:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jimit Bhalavat <jimit@rams.colostate.edu>
Cc:     David Huseby <dhuseby@linuxfoundation.org>, git@vger.kernel.org
Subject: Re: GPG Commit Signing Project
References: <43C81FDC-611D-45A1-9525-24640FEB2E1A@rams.colostate.edu>
Date:   Tue, 18 Aug 2020 13:32:18 -0700
In-Reply-To: <43C81FDC-611D-45A1-9525-24640FEB2E1A@rams.colostate.edu> (Jimit
        Bhalavat's message of "Tue, 18 Aug 2020 12:43:45 -0600")
Message-ID: <xmqq5z9fy9t9.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EA23976E-E191-11EA-8F1F-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jimit Bhalavat <jimit@rams.colostate.edu> writes:

> Hello Junio,

Sorry, I read the message twice but I am not sure what you expect
out of me.  We usually do not evaluate a proposal only from its
"design document" in the sense that we won't say neither "such a
proposal is great" or "we won't accept such a proposal" until we
actually see patches.  It is a good idea to have a written design as
it may help reviewers when they review patch submission.

> 	5. All of these changes will make sure that we maintain
> 	backwards compatibility. We are aiming to deprecate things a
> 	little but old options will not stop working. We will
> 	preserve existing behavior.

That is always a requirement by our project so it goes without
saying ;-) but it is good to see the promise written down.

