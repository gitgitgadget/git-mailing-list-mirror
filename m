Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2704C433EF
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 19:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392094AbiDUTyD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 15:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241640AbiDUTyC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 15:54:02 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC6D427F2
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 12:51:12 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 04258195C28;
        Thu, 21 Apr 2022 15:51:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=UW7Uwoy3Hey3
        +MjJwbflEMUyRwLP/6QSiAU0oedzGWE=; b=j2Bg/kok84kvc04ErAjrPi8v2IP9
        3Juu6YfzCvB8itr2sluBYQawFa4RhyyjrFocO+pp74TEZXKng+Ng5dr/ctOxX4zy
        3MFcC+X+lScgmMZU7s+Le4NB0A45cJvWH2RSORos6TIO5Q+1wMBU1qe83yeMJwxi
        uxyetjDEzullNeU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F1739195C27;
        Thu, 21 Apr 2022 15:51:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 83CC7195C25;
        Thu, 21 Apr 2022 15:51:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Carlo Arenas <carenas@gmail.com>,
        Phillip Wood <phillip.wood@talktalk.net>
Subject: Re: [PATCH v2] CI: select CC based on CC_PACKAGE (again)
References: <patch-1.1-d89ad4d5b7c-20220421T130310Z-avarab@gmail.com>
        <patch-v2-1.1-92acf9420a9-20220421T174733Z-avarab@gmail.com>
        <xmqqzgkegspg.fsf@gitster.g>
        <220421.867d7i6ycr.gmgdl@evledraar.gmail.com>
Date:   Thu, 21 Apr 2022 12:51:07 -0700
In-Reply-To: <220421.867d7i6ycr.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 21 Apr 2022 21:13:57 +0200")
Message-ID: <xmqqlevygqqc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6343B722-C1AC-11EC-A7CC-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I'm happy to rephrase it however you'd like, but I'm a bit confused by
> the "saw any mention in the proposed log message". I'm fairly sure
> paragraph 2 onwards covers this, i.e. how linux-gcc's behavior is
> changed (as it also regressed).

Yeah, true, """Likewise for the linux-gcc job CC=3Dgcc-8 was changed
to the implicit CC=3Dgcc, which would select GCC 9.4.0 instead of GCC
8.4.0.""" that you wrote is exactly about it.

I was confused because immediately after that you said it was not a
bug, so I dismissed it as not part or the real issue.  Perhaps
striking that "not a bug" part may make it less confusing?  I dunno.

> What I suppose is left undiscussed is that jobs that don't define
> CC_PACKAGE at all won't be impacted, is that what you wanted to be
> explicitly mentioned?

Yes, I agree that is a good idea, too.  Or you can steal the "before
and after" table I gave you in the message you are responding to, if
you think it helps.

Thanks.
