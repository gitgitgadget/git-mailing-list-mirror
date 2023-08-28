Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3240C83F11
	for <git@archiver.kernel.org>; Mon, 28 Aug 2023 15:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjH1PUT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Aug 2023 11:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbjH1PT7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2023 11:19:59 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 685E8128
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 08:19:49 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B212121F8A;
        Mon, 28 Aug 2023 11:19:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=0pqNdXE5Sp8A
        yqfBdAT8GIMUBI/EqbhJpWDK+2ggv40=; b=L5cdhfoLb9+fT7jPixPdYMlKMN4/
        3+iUudAkU/JzLkb1gIWczc7Wx2XjCq9yYY6t60s8AzTM9ChaMOVsZKAKIiWc6ZPp
        fcd3GSKfFGWwrDzn8CSiHIuzjy9N7rjsbzzeaZXLeeu9QQHUWWITUiCCQeaMmzPj
        25prFawZHmUhsWY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AAAB021F89;
        Mon, 28 Aug 2023 11:19:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4952921F86;
        Mon, 28 Aug 2023 11:19:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: PATCH] parse-options: allow omitting option help text
References: <2b08dc43-621d-2170-c4a6-c2aac33a9a19@web.de>
Date:   Mon, 28 Aug 2023 08:19:44 -0700
In-Reply-To: <2b08dc43-621d-2170-c4a6-c2aac33a9a19@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sat, 26 Aug 2023 10:06:00 +0200")
Message-ID: <xmqqr0nnjisv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 51C2E04C-45B6-11EE-8E25-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> 1b68387e02 (builtin/receive-pack.c: use parse_options API, 2016-03-02)
> added the options --stateless-rpc, --advertise-refs and
> --reject-thin-pack-for-testing with a NULL `help` string; 03831ef7b5
> (difftool: implement the functionality in the builtin, 2017-01-19)
> similarly added the "helpless" option --prompt.  Presumably this was
> done because all four options are hidden and self-explanatory.
>
> They cause a NULL pointer dereference when using the option --help-all
> with their respective tool, though.

Good find.  Will apply.  Thanks.
