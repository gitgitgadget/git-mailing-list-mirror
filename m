Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E30FC433F5
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 20:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B21361090
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 20:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346356AbhIGU65 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 16:58:57 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53692 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236693AbhIGU64 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 16:58:56 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E195C144B3D;
        Tue,  7 Sep 2021 16:57:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NNkVmt5MgXF7z/ZnWwx+41YD42DrnnXIq956qv
        bbviA=; b=sydpLGTYImYPlzC8YvO9h/y4U6DtqJcuP2enHREotf9/poE1BxrHza
        Tvtg+K889cEedGt+veuPSL62ttxBidFwYJE9Jq0OyPlr9KQSBvSv1njFE7pjXnmC
        KVCMoXvY87LCrz4kVRyhnNoNPRRBlDgNgG5L4NpaxvIcWqb74HLbQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DACCB144B3C;
        Tue,  7 Sep 2021 16:57:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2E97A144B3B;
        Tue,  7 Sep 2021 16:57:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH] Docs: web server must setenv GIT_PROTOCOL for v2
References: <20210904151721.445117-1-konstantin@linuxfoundation.org>
        <YTOW352xtsbvJcKy@coredump.intra.peff.net>
Date:   Tue, 07 Sep 2021 13:57:45 -0700
In-Reply-To: <YTOW352xtsbvJcKy@coredump.intra.peff.net> (Jeff King's message
        of "Sat, 4 Sep 2021 11:55:11 -0400")
Message-ID: <xmqqeea09k8m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4149C8D6-101E-11EC-AC47-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Sat, Sep 04, 2021 at 11:17:21AM -0400, Konstantin Ryabitsev wrote:
>
>> For the server-side to properly respond to v2 protocol requests, the
>> webserver must set the GIT_PROTOCOL environment variable to the value of
>> the Git-Protocol: request header.
>
> Thanks for assembling these examples.
>
> I don't mind having these in the technical documentation, but I think
> most users won't find them there (nor would they even know they need to
> be looking). Maybe the manpage for git-http-backend would be a better
> spot. We can mention v2 in the "description" section, and then there's
> some example config near the end that could include it.
>
> Unfortunately there isn't any nginx example config there at all yet. If
> you have kernel.org config you could share, that would be great. But
> even starting with just the "here's how you do v2" part would be
> welcome.

True, true.

In the meantime, I'll queue this as-is.

Thanks.
