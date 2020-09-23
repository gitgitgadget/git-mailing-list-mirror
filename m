Return-Path: <SRS0=8LOk=DA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A0FC2D0A8
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 20:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D5572376F
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 20:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rqfxSMQu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgIWUiS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Sep 2020 16:38:18 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50670 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgIWUiS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Sep 2020 16:38:18 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4E2C38A6BD;
        Wed, 23 Sep 2020 16:38:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HzBMM1v0r5jT6207vSTeBfcvhN0=; b=rqfxSM
        Qu3SmUTwC/Gk+5XjUCQUA3VMtpWfAr3aGsIOZcO09e/SJh1vSbdJhKMAYPboezbA
        ybDD3NTOqyuTftkJYwI+DSS15vvPgqDpIcJ4zz2H0fsBwL4NUTR7bt7rQjwBc2bH
        jsng5GnEBKeBeSFDeRmKdLuLJUbtKanTxgg+Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Hg79Kw+fjtbhGl2HCXwV8Q7GcakLgK36
        G7bNIQPP+3mmhpWuezZCMwXuynTktoou5CPGQ8wIzBnw075v4sMpQSLkSlcsHwyI
        n0sR7+sUElmEKqEwTI72kl7t9fgBPFuh9eYksT+8zEDKg8V+uVpqzD11OaJeiEBA
        n1XuBeJpDFk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 457758A6BC;
        Wed, 23 Sep 2020 16:38:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BCBC18A6BB;
        Wed, 23 Sep 2020 16:38:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] cmake: ignore generated files
References: <pull.735.git.1600375065498.gitgitgadget@gmail.com>
        <xmqqtuvwoyz5.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2009181510240.5061@tvgsbejvaqbjf.bet>
        <xmqqft7fnlxr.fsf@gitster.c.googlers.com>
        <20200918155015.GA1837@danh.dev>
        <xmqq7dsrnjhi.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2009201916040.5061@tvgsbejvaqbjf.bet>
        <xmqqr1qsjxgb.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2009232224410.5061@tvgsbejvaqbjf.bet>
Date:   Wed, 23 Sep 2020 13:38:14 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2009232224410.5061@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Wed, 23 Sep 2020 22:27:17 +0200
        (CEST)")
Message-ID: <xmqqft78i5zd.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B4E7312A-FDDC-11EA-A6C4-01D9BED8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> All I want is for the CMake support to be easier to use, yet we go in the
> opposite direction: instead of allowing to use CMake under more
> circumstances (which actually *works*, we just don't have the appropriate

Not, "more", but what you are doing is to ensure it is used at only
one single place, which is the top-level (and nowhere else, judging
from the .gitignore additions).

And that is fine---if you were to add .gitignore entries, you cannot
leave it up to the end-users where the build happens.
  
So, let's not pretend that you are allowing "more circumstances".
Forcing a single choice to make things predictable is fine, but
let's explain it as such, so that people won't be confused into
thinking that they can follow their experiences gained from using
CMake in other projects that lets them build in a separate
directory.  The other things in our project, including the
patterns added to .gitignore with the patch in question, are not set
up to allow that.

