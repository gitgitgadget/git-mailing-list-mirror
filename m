Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B809C4361B
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 19:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B75C238A1
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 19:36:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgLGTgE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 14:36:04 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62927 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbgLGTgE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 14:36:04 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E08CAFE5FB;
        Mon,  7 Dec 2020 14:35:21 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=C//V85sWwowxN4BECuD2VU7v2js=; b=wQXZUu
        t4HF+BH/+mGw3NTMVkIETf4nw3MTW2OB7WTSwCF8grOnD6uCkFlv3OgwLtxF8hms
        t07q8z6Is9f5Tt86pwdQnrrLuA4P+B/h8JvXyuZlgLJYa35Y0NRjER2yy0jaarOm
        JngJPiMN9l2m/TfGooUmFCqL+ktc7/ImvdgO0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=e9DRKypS8MuTqeTO1RW1/CGf9WLqXl9C
        vM6OtLkl4o+WaB+CdmvXs5XWyObuX4LfkVE4gpJmSdowwwtD+t2XEFjhlLzoFGOq
        DUc+PlNpLs7a7CtRJofwAhmH0WoXu0eypJ8m6alkbmlYkItCYbmWOk1ms5pMmC5Q
        jJL74HkOKuQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D801AFE5FA;
        Mon,  7 Dec 2020 14:35:21 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CEA06FE5F4;
        Mon,  7 Dec 2020 14:35:17 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jan Engelhardt <jengelh@inai.de>, git@vger.kernel.org
Subject: Re: `git grep` is too picky about option parsing
References: <704q5rs6-63q1-sp78-9845-227oq8q42o8q@vanv.qr>
        <X85gMs1gPBNLff7f@coredump.intra.peff.net>
        <xmqqa6upbgil.fsf@gitster.c.googlers.com>
        <X856rSHziQcmr/zX@coredump.intra.peff.net>
Date:   Mon, 07 Dec 2020 11:35:16 -0800
In-Reply-To: <X856rSHziQcmr/zX@coredump.intra.peff.net> (Jeff King's message
        of "Mon, 7 Dec 2020 13:55:41 -0500")
Message-ID: <xmqqtusx9zpn.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5610443A-38C3-11EB-BE3F-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> would be sad to lose it. (I don't use it with grep, but my standard perl
> invocation is "perl -lpe 'some script'"; another common one is "tar xvf
> foo.tar").

Heh, "tar" is a different breed, isn't it?  It can have a clump of
single letter options among which more than one take parameter.

> And it works now (obviously not in the case we're discussing, but in
> other cases that don't run afoul of the typo fix), so I think people
> would see that as a regression.

Sure.
