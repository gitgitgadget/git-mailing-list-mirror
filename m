Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E6EC433DB
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 23:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42B8F2255F
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 23:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbhADX6S (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jan 2021 18:58:18 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59194 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727734AbhADX6S (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jan 2021 18:58:18 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EC6CFA4315;
        Mon,  4 Jan 2021 18:57:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=MqeS34eeWzvA+Q3gm49xfiGugoA=; b=WQErNzUr3lxu46VIo6sY
        dauEtVc9x3qe2gH6YNIkhCctazs85RS/iwUPOgDQPRwQCf/GxV+19I9+XBmLNMCz
        KioVQngAn8oKP3jG2cFVh2wfh+AiFQx6+CPWXT1ut6KHLcGRqkoLvyUcRR1lRd2X
        a1RpP1n6YFII5L+YsvJJ2TU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=rNIU32RuS7dZK8MrtiJ1sA37QFnWrhJoOY67sE3orlIDaQ
        FJbb/6P2ukDOhg4yKvZ0iv2bhJzrJsvo/IS6Pm/XZUL6JpaGE+LslkqULzQESHNh
        Xu3wuJhYv55pMQprbzsCkfkYVFY0DA1jpPfJ1gY/Dhw8Kif+FCzmM7KECXwLo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E4597A4314;
        Mon,  4 Jan 2021 18:57:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 72288A4313;
        Mon,  4 Jan 2021 18:57:35 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     scs@eskimo.com (Steve Summit)
Cc:     git@vger.kernel.org
Subject: Re: suggestion for git glossary: upstream, downstream
References: <2020Dec29.0815.scs.0001@quinine2.home>
Date:   Mon, 04 Jan 2021 15:57:34 -0800
Message-ID: <xmqqwnws1ci9.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9DFBEBCE-4EE8-11EB-84D1-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

scs@eskimo.com (Steve Summit) writes:

> The terms "upstream" and "downstream" are heavily used in much
> writing about git, with obvious meanings and implications for
> those who use git regularly, but they're not defined at
> https://git-scm.com/docs/gitglossary .  Perhaps they should be?
> (Sorry, I'm not nearly experienced enough with git yet to write
> good definitions myself, though.)

Yup, 'upstream' has clear definition and we use the phrase a lot.
'downstream', not that much, primarily because your repository may
have its upstream (singular) but typically you may not even know the
set of people who consider your repository their upstream.

Having said that, there isn't much we can actually say about
'upstream' as a unversal truth, no?  I can readily think of this:

    Your upstream is the line(s) of history you base your
    development on.

but beyond that, there aren't much that is common across different
workflows how 'upstream' appears to you.  Sometimes you may ask your
changes to be pulled by it, sometimes you may directly push into it
while others like you who consider it their upstream do the same.

So...
