Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA0FC54FCB
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 20:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70536215A4
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 20:45:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bOocplRp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgDXUps (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 16:45:48 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64146 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgDXUps (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 16:45:48 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5DB1C47556;
        Fri, 24 Apr 2020 16:45:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=z5BEyCTwHBwGr26zTVq2Ga58lvk=; b=bOocpl
        RpaCaJ+xGj7DNUCus10bd/29aa4xOjgSTyABMo/vEQd3NvUqsC3xtj3nE5FDya6B
        ZwP0pOvWIeKRbS03Ea1FUR/3j6rzLtfF0DnKFxrAygOjidEG2v5gapEPbdmopM/T
        uBzdQ9cL71yjC25PjKcHkEGyVAp/PQV+ZUkf8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tysprme23vl2D2U6fgDiYZakmnafphii
        4Z2UwA5fTqvKhseNy7rkSWHi5S86nhXk8dJfHsp9brPSWfBXqp0ger9RVkeZbC3k
        2MxG5cmMSB45G6Axu6feeysBGhc+brmKgq7FdY0vg7Ly1OFaDdbJvWk/PHQd3qg+
        hGXwwrL9pDg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5486A47553;
        Fri, 24 Apr 2020 16:45:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9D71B47552;
        Fri, 24 Apr 2020 16:45:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        jonathantanmy@google.com, newren@gmail.com
Subject: Re: [PATCH v2 1/2] t5537: use test_write_lines, indented heredocs for readability
References: <20200423001438.GC19100@syl.local>
        <cover.1587601501.git.me@ttaylorr.com>
        <5c9217ad8fc594fbff46507c4be7961eb5a478e2.1587601501.git.me@ttaylorr.com>
        <20200423011444.GG140314@google.com>
        <20200424171139.GA61470@syl.local>
Date:   Fri, 24 Apr 2020 13:45:44 -0700
In-Reply-To: <20200424171139.GA61470@syl.local> (Taylor Blau's message of
        "Fri, 24 Apr 2020 11:11:39 -0600")
Message-ID: <xmqqpnbwbojr.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9241E968-866C-11EA-8EA8-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Subject: [PATCH] t5537: use test_write_lines, indented heredocs for readability

Assuming that "indented" is not a verb in the past tense, but
adjective on the noun "heredocs", this reads well, but "s/,/ and/"
would make it more clear in that case.  Or "for readability, use X
and indent Y" would work equally well.

But the original is probably OK as-is.

> -	cat <<EOF >expect &&
> -4
> -3
> -EOF
> +	test_write_lines 4 3 >expect &&

Yeah, becomes much nicer with test_write_lines.

Thanks.
