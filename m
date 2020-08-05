Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15554C433E0
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 22:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D608D22CA1
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 22:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="J3sXVQO6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbgHEWOq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 18:14:46 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56269 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbgHEWOp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 18:14:45 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9D77CE6E11;
        Wed,  5 Aug 2020 18:14:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=R1Z55rCDN+qtriE4mAZA/2ekxXA=; b=J3sXVQ
        O6vlLjL7ig/PVYkfdwNnU76UsjBD8sneATEWT9roCORNtTdzp1gJ1EUZpJQ1IoNz
        AC3NxF7bCl2bFHOBmoo1yPRrVVxlXhKm7WsMy/ArTzI5O/GFx0liX39foYMfCX8K
        5f/xBlaxq8g4aBsJsR8FUoHfpSSM/2wDVuJto=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=u++mjVYsTHriOChP/STO/lUxsKdtRRVa
        M3uHi/rT9KUKY60CobnYmW04pPpf9c7mupieHwzfGkpHiORWoM4K9Np9xpltvAyx
        R4GYSTG+3eKHYovKkqQG4LpWLqe7uAF+iGJ/L3C0xCch10UbItWdnpRLkWs+9gT7
        Gpdn+i42SII=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 963E3E6E10;
        Wed,  5 Aug 2020 18:14:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1A66DE6E0F;
        Wed,  5 Aug 2020 18:14:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?Q?Marco_Trevisan_=28Trevi=C3=B1o=29_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, Git List <git@vger.kernel.org>,
        =?utf-8?Q?Mar?= =?utf-8?Q?co_Trevisan_=28Trevi=C3=B1o=29?= 
        <mail@3v1n0.net>
Subject: Re: [PATCH 1/3] mergetool-lib: use $XDG_CURRENT_DESKTOP to check GNOME
References: <pull.693.git.1596634463.gitgitgadget@gmail.com>
        <66a026ae678341fe7e93a89e22f76e24282cebaa.1596634463.git.gitgitgadget@gmail.com>
        <CAPig+cR_04fL85nH1tJnbWYbwk3Bn5fRqzr2JReB2xXu9iUGAQ@mail.gmail.com>
Date:   Wed, 05 Aug 2020 15:14:39 -0700
In-Reply-To: <CAPig+cR_04fL85nH1tJnbWYbwk3Bn5fRqzr2JReB2xXu9iUGAQ@mail.gmail.com>
        (Eric Sunshine's message of "Wed, 5 Aug 2020 16:58:04 -0400")
Message-ID: <xmqqlfisn3jk.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0EFCD6BE-D769-11EA-9608-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> Rather than looping and mucking with IFS, even easier would be:
>
> is_desktop () {
>     case ":$XDG_CURRENT_DESKTOP:" in
>     *:$1:*) return 0 ;;
>     *) return 1 ;;
>     esac
> }
>
> But perhaps that's too magical for people?

Nah, that is exactly how 'case' in shell is supposed to be used.

Thanks.
