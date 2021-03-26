Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F13F0C433DB
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 22:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E206961A2A
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 22:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbhCZWmK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Mar 2021 18:42:10 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54819 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbhCZWl7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Mar 2021 18:41:59 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B667510C266;
        Fri, 26 Mar 2021 18:41:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kxeRx8O7C/tsb8O0sx+EYN0EXhg=; b=Vpy2/L
        sKB26VWzskiV2iR4ieOH7t/82MxdnIZh+oN0BSuNcQyECpZcgHbiCvjOOQNA9gSK
        x9mJI4jg8S1kyQxf30GKLc3vm07a5RCt+G5xZdDGR6jheKYwYWMzOLn9en2OT48R
        3dx92VKRy2/sXuRP53Ut6W9HTWzKsJ16nsryE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=URL70R9rRONkfI4n7WZMVxwMUeOCNdtM
        puK/c0keKGAJ33eAv375PHp305+UhXyK/VNWomi5917Dtk3X54FwHf1jzS6+7bzC
        Qa/gFcIRfWw1YRXzXBTU9/18pWhRzwb8iy6f7yaRWIs29HPqBC/DfgRj8HtGrn7q
        l0p+61NbGEo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AFE4310C265;
        Fri, 26 Mar 2021 18:41:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D52F110C264;
        Fri, 26 Mar 2021 18:41:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] format-patch: give an overview of what a "patch"
 message is
References: <20210325105433.43310-1-bagasdotme@gmail.com>
        <xmqqmturuh8o.fsf@gitster.g>
        <7c0aabe0-9240-950e-912f-0a195db7a144@gmail.com>
        <YF2fIhVUwBim47Wq@coredump.intra.peff.net>
Date:   Fri, 26 Mar 2021 15:41:53 -0700
In-Reply-To: <YF2fIhVUwBim47Wq@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 26 Mar 2021 04:45:22 -0400")
Message-ID: <xmqqa6qpsfke.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 77A1CC1A-8E84-11EB-879F-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> You should start the first line of the message body with:
>
>   From: Original Author <orig@example.com>
>
> git-send-email will do this automatically if the author of the commit you
> are sending does not match your identity (you may also need to use "git
> commit --author" to make sure the author is set correctly in the
> commit).

Thanks.

FYI, the commit in question is 28e29ee3 (format-patch: give an
overview of what a "patch" message is, 2021-03-24) and I think it is
ready for 'next'.
