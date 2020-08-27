Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B336C433DF
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 19:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C2E4207DF
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 19:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Cu1KqixD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbgH0TWD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 15:22:03 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51639 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbgH0TWC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 15:22:02 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8E298740F7;
        Thu, 27 Aug 2020 15:22:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ldFmJbgnDB35vYEKCdj+rMOb8IE=; b=Cu1Kqi
        xD+lnIPA/P3apSi3ettxYeK1tCAwCU+nIMuF2M5dpD4IXaA+86ft/23lY2UBtHyr
        8y3SO4ntQ+iMheL66d5XPLnSW0ntcZLdJPhQC0T04Nd6f7Vs2kY8g5ykD6dkcKR7
        NzyUKr6BfPKrArSKpwMABr1UKYN/tD0i2tvOk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=k02kELMY3NLF6a2FQ+NO3wftajm3NB/S
        85DdT7yOSyl1kYcPbJbEqgDJc5qhdD42YC/kfrd6bZ+XFfn0v4QDyJ/yzEicWn3B
        PmdDpy4qnMA37tnRg9KvK+jbvel/JRxb9+fcYZT2x5xbz2BzxiB+hnOYPFn/EzJ2
        0B2gc0rHCOE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 38536740F6;
        Thu, 27 Aug 2020 15:22:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 000F0740F4;
        Thu, 27 Aug 2020 15:21:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Drew DeVault" <sir@cmpwn.com>
Cc:     <git@vger.kernel.org>
Subject: Re: [PATCH] send-email: do not prompt for In-Reply-To
References: <C580P9BS4VYA.15I6SHXQQ35HF@homura>
Date:   Thu, 27 Aug 2020 12:21:59 -0700
In-Reply-To: <C580P9BS4VYA.15I6SHXQQ35HF@homura> (Drew DeVault's message of
        "Thu, 27 Aug 2020 15:14:57 -0400")
Message-ID: <xmqqy2lzq4h4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9460E20E-E89A-11EA-8AFA-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Drew DeVault" <sir@cmpwn.com> writes:

> Do you have sendemail.to set in your local git config?

Yes, and I'd assume most mailing list have a single to: address, and
people use a repository to interact with just a single project, so I
think it would be natural to have it in the per-repository
configuration file.  Is it true that you do not set it and that the
lack of the configuration is why you are getting prompted?

I suspect that it may not make much sense for the presense of
sendemail.to to affect prompting for other header fields (iow, my
not getting prompted might be a bug).

Thanks.

