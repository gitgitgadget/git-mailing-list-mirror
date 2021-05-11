Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB63C433ED
	for <git@archiver.kernel.org>; Tue, 11 May 2021 23:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8FE36187E
	for <git@archiver.kernel.org>; Tue, 11 May 2021 23:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbhEKXuD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 19:50:03 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55063 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhEKXuD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 19:50:03 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 053E213DF6A;
        Tue, 11 May 2021 19:48:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mdXwLOFt7FCz2vFgWKYZRrl2HuT0tovrdVrDqy
        9yXg4=; b=TR28gdR38cOZwJgRlbF/d8WdmJw4BXUOUWzzvJpBmKyacL2ouasD2y
        sxxoZUNseeZ4NkWLQQnaMwA/IMA9yS3YXyqTIOivuB+SrwrmMxivxFlYQL8yr/D6
        qR4zETmYr8PW374gd+JDNdkTCSxmjBcl8ayNBp+GRt46MlO+D+UEE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F37DA13DF69;
        Tue, 11 May 2021 19:48:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 392CE13DF68;
        Tue, 11 May 2021 19:48:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Eric Wong <e@80x24.org>, git@vger.kernel.org
Subject: Re: [PATCH] remote-curl: fix clone on sha256 repos
References: <20210511103730.GA15003@dcvr>
        <YJsM3sUXRYjJiwZG@camp.crustytoothpaste.net>
Date:   Wed, 12 May 2021 08:48:51 +0900
In-Reply-To: <YJsM3sUXRYjJiwZG@camp.crustytoothpaste.net> (brian m. carlson's
        message of "Tue, 11 May 2021 23:01:50 +0000")
Message-ID: <xmqq8s4kj0gs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 712B79FA-B2B3-11EB-A91B-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> This seems fine as a solution for now.  I tried to keep the transport
> code mostly independent of the local repository settings, but in this
> case because the HTTP walker mucks around with the internals of the
> local pack files, I don't think we can avoid this without some major
> restructuring, which I'm not interested in sitting down and writing this
> evening.
>
> I'll clean this up in a nicer way once I get interop working.  Thanks
> for sending a patch for this.

Thanks, both.

As an "experimental" stuff, I do not think SHA256 "fix" is as urgent
as (or of higher priority than) other stuff, like reducing
inter-developer stepping-on-others-toes, so I'll refrain from
picking Eric's patch up myself and let you include/handle it later.

