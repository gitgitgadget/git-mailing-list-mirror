Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F0EC64E7B
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 19:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61CDB20639
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 19:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ug5jYv2Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731315AbgLATMv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 14:12:51 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62237 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730070AbgLATMv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 14:12:51 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C16199FEF1;
        Tue,  1 Dec 2020 14:12:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LTfE+9l0hhRR7Oy1dCmVLfsL620=; b=ug5jYv
        2YLX2ereBQiK+1leks+tWgtJRnlRw7eUtOwyH7gzEpwJLz21Cm1l+o9prUXerHiI
        xjY47IGcsx2i6N+TzDxNiEhDJfGqoKw+HTin6mjiBTAjdEDmxBlYqorEsIexEvyb
        0AHkkEsHAd/+ekeD7Ubu+niivKA55NXBaR60Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kwKqKMLeAMCI8RKwQ+FhLXpbhr6MshyW
        VdwjNFlDy7JkwX11TjhSnWaiWFFH0yMJmdx07oDN9hAfVcC4f9Kwam/qQ0dANtNk
        DD6p3bCEYo1DlQ3KOf5XzAhe+kDa6M+k3VZaCjgKaxHJl9zc+XgzjkD5Pw4FqrN9
        bpGwEPFvJHI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 277A09FEF0;
        Tue,  1 Dec 2020 14:12:08 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 341F99FEEF;
        Tue,  1 Dec 2020 14:12:07 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCHv3] imap-send: parse default git config
References: <51989467-7bac-5e90-5b42-6503c8370988@suse.com>
Date:   Tue, 01 Dec 2020 11:12:06 -0800
In-Reply-To: <51989467-7bac-5e90-5b42-6503c8370988@suse.com> (Nicolas
        Morey-Chaisemartin's message of "Tue, 1 Dec 2020 08:38:16 +0100")
Message-ID: <xmqqtut5pchl.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1AB3E6DA-3409-11EB-ADA5-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com> writes:

> git imap-send does not parse the default git config settings and thus ignore
> core.askpass value.
> Rewrite config parsing to support core settings.
>
> Reported-by: Philippe Blain <levraiphilippeblain@gmail.com>
> Signed-off-by: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
> ---
> Since v2:
> - Hopefully fixed format-flowed issue in my mail client
> - Fix style if issues

Thanks.  Will queue.
