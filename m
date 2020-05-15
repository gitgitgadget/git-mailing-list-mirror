Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B35AC433DF
	for <git@archiver.kernel.org>; Fri, 15 May 2020 16:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7927F207BB
	for <git@archiver.kernel.org>; Fri, 15 May 2020 16:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="R2SAVy83"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgEOQun (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 12:50:43 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56571 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbgEOQul (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 May 2020 12:50:41 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6070F4D89D;
        Fri, 15 May 2020 12:50:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=iASU3m5+niv2
        pLEqzvT8G+P6NFk=; b=R2SAVy83WVwnvrQ+joc/+dFIG7tCMHTERrvWEOd5dRrh
        fzEgfDUnXnHLtVv5PoSfnZVkxptmd/TPXD3/whYQFyfreoI5owQFOF0QkJ4jbqnm
        f97SlaKrYrG2KmUT7Plcg/rdu5ays2DvUxvDZy9pbK0l3UJ/waOMgBMH1W60BSg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=nOAdsN
        t5d4Ma9Kp3CJ2NY5EWCWxzOcMBTLw3wuRglmcik/CHKOMA71UTBjtQyNFSqYOMBC
        7TJ8eI7AhBzuvgdrSrBD6ul/2gDU7pTapIY+cwLllVwUB2KUUQx3bntoS8RygloP
        J3xT9MDTAe2p3AzBwGh3zyFMGWZXnqvEWvy8U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 583464D89C;
        Fri, 15 May 2020 12:50:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D6D3A4D89B;
        Fri, 15 May 2020 12:50:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org,
        congdanhqx@gmail.com, johannes.schindelin@gmx.de
Subject: Re: [RFC PATCH] t: move metadata into TAP test description
References: <5b373748-d986-1aec-670f-7ac1502e7052@gmail.com>
        <20200515150041.22873-1-carenas@gmail.com>
        <880ded78-21c6-9310-6c5e-422f6a63ad47@gmail.com>
        <20200515154539.GB61200@Carlos-MBP>
Date:   Fri, 15 May 2020 09:50:38 -0700
In-Reply-To: <20200515154539.GB61200@Carlos-MBP> ("Carlo Marcelo Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Fri, 15 May 2020 08:45:39 -0700")
Message-ID: <xmqqlfltm9b5.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 34A588C6-96CC-11EA-9F1D-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com> writes:

> On Fri, May 15, 2020 at 05:38:21PM +0200, Alban Gruin wrote:
>>=20
>> Thinking about it, I think it would make sense to put this kind of
>> information in a diagnostic line, as we already do for the code of a
>> failed test.
>>=20
>> Instead of this:
>>=20
>> > not ok 1 - plain(error:t/./t0001-init.sh:33)
>> > #
>> > #               false &&
>> > #               git init plain &&
>> > #               check_config plain/.git false unset
>> > #
>>=20
>> Something like this:
>>=20
>> > not ok 1 - plain
>> > # (error:t/./t0001-init.sh:33)
>> > #
>> > #               false &&
>> > #               git init plain &&
>> > #               check_config plain/.git false unset
>> > #
>
> indeed, and that is why I mentioned this as a workaround only.
>
> to move to a format like the one you suggest, it might be better to
> do it by also moving to TAP13[1] (which allows all that metadata)
>
> but of course that would also require us to do more changes to the
> integration with GitHub's problem matchers and probably a lot more
> changes I am not even aware of.

At this late stage in the cycle, would it be a safer change to
revert the whole thing, I wonder, rather than piling fixes on top of
fixes to the initial breakage?

303775a2 (t/test_lib: avoid naked bash arrays in file_lineno, 2020-05-07)
662f9cf1 (tests: when run in Bash, annotate test failures with file name/=
line number, 2020-04-11)

I'll prepare a topic to revert these two directly on top of -rc0 and
see how well it goes.



