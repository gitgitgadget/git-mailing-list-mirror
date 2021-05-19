Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60218C433B4
	for <git@archiver.kernel.org>; Wed, 19 May 2021 22:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AA7961074
	for <git@archiver.kernel.org>; Wed, 19 May 2021 22:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbhESWtX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 18:49:23 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53747 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhESWtX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 18:49:23 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2D803B81D2;
        Wed, 19 May 2021 18:48:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1bYJ42Vx0CqspgDh/Fj2BatAjKnKsxx0wnMYO5
        t8Kgw=; b=aXfpI0sxP+zqZ0oJIf1gjT9GUotPDS/xMmuJdP6tT8Ai5GdfIQq4kB
        8vlzM15QO9nB5hkScr3IfrC6ruwXoyMM00dZ/tfjHGjqB4jrLizEYvPHKjq7Sc4x
        FJTJAUKWxPwqkFjywuaZJjFVzAB440aRMcrj5zh1bYbHbNMLrDUEo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EAA38B81D1;
        Wed, 19 May 2021 18:48:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0F512B81CD;
        Wed, 19 May 2021 18:48:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] doc: explain the use of color.pager
References: <YKTXlTjwOUi4W+R8@coredump.intra.peff.net>
        <YKVsw3uqb66ifzvd@google.com>
Date:   Thu, 20 May 2021 07:47:59 +0900
In-Reply-To: <YKVsw3uqb66ifzvd@google.com> (Jonathan Nieder's message of "Wed,
        19 May 2021 12:53:39 -0700")
Message-ID: <xmqq7djuxrvk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 43A7FEA8-B8F4-11EB-9D03-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Side note, not about this patch: we treat pager.color as a synonym for
> color.pager.  Is that something we want to document, or is that an
> instance of being extra friendly when the user makes a typo?

IIUC, this is the same historical wart that comes from the same
place as diff.color that existed before color.<cmd> wanted to be the
way forward.  We do not break existing configuration files by
starting to suddenly reject diff.color or pager.color, but we do not
encourage new uses by not advertising them.

