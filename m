Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F840C432BE
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 16:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F12C60C40
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 16:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbhHKQNw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 12:13:52 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63080 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbhHKQNv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 12:13:51 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A7D65130248;
        Wed, 11 Aug 2021 12:13:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=jqfZMOFbejKI
        dsNset3qzjarhOgIvxqTSdkuFvMF4H8=; b=iLwBsdpNcchTVb8P53SkRDNYmR0g
        zSoZ5PqLzm7wBP4OYTsP/ShgkqqWHOeXqKqIBf2k7EBjBheNYdhFMOwmQnyr7pZm
        Syu4YsNURm6wL8/TaQ9/sqhLyFUoO0rrIV75g5bMUVyhVQmm0CU0wH+rDSFIMgTC
        PVpmscrOQNh88jQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A0A54130247;
        Wed, 11 Aug 2021 12:13:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E93DC130246;
        Wed, 11 Aug 2021 12:13:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2021, #04; Tue, 10)
References: <xmqqh7fwbx86.fsf@gitster.g> <YROElmCJQGaR8Lsx@carlos-mbp.lan>
Date:   Wed, 11 Aug 2021 09:13:23 -0700
In-Reply-To: <YROElmCJQGaR8Lsx@carlos-mbp.lan> ("Carlo Marcelo Arenas
 =?utf-8?Q?Bel=C3=B3n=22's?=
        message of "Wed, 11 Aug 2021 01:04:38 -0700")
Message-ID: <xmqqr1f09cyk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0E3FFB64-FABF-11EB-8915-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com> writes:

> On Tue, Aug 10, 2021 at 06:12:41PM -0700, Junio C Hamano wrote:
>>=20
>> * cb/ci-build-pedantic (2021-08-09) 1 commit
>>  - ci: run a pedantic build as part of the GitHub workflow
>>  (this branch uses cb/many-alternate-optim-fixup.)
>>=20
>>  CI update.
>>=20
>>  Will merge to 'next'.
>
> this version has the bug you reported[1] and provided a fix for
> because the base image doesn't include git, and while the bug is
> harmless it is still silly enough that should be worth fixing
> before going to next IMHO..

Will mark it as "expecting a reroll".  I do not think we are in a
hurry for this step, even though, as I said, we would probably want
to have the two other changes in the upcoming release.

> I was preparing a version 2 reroll that included the tests, as
> you suggested, which I was also planning to make a little more
> useful by including other test dependencies missing from other jobs.
>
> on that line, I also forgot to build with PCRE, which was the reason
> why it was included as a dependency, and that has been corrected as
> well; alternatively it could be removed and make the job slightly faste=
r.

Sounds good.  We are not in a hurry for anything that may go into
'next' at this stage.  A version that you think will help us start
the cycle after this one well would be desirable.

Thanks.
