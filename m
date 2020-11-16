Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA9FC2D0A3
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 20:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 969E220DD4
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 20:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hWaJdz8P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbgKPUEN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Nov 2020 15:04:13 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65511 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbgKPUEN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Nov 2020 15:04:13 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id ED76BF5E0B;
        Mon, 16 Nov 2020 15:04:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=cpo6nAlcZ1mz
        Dn1Cdr+1Z6c6cno=; b=hWaJdz8PVgx0MnIi4hvlfxTqgF2knTffGv9xJK1P3YG5
        jlfReT3TAWPw9+/P1XphyzWepyQoh2mTEQYmdkhgupLT/p7F6WBDjKzN7AtRUiZ3
        MfV4IfEPcNVxqSrEUUrLAcnf80CldjvIwL4vpSxHznD7l7RkFPNqVety/qUNbGo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=vh+X4T
        OY8r6OKeE8kYxiWZRk/yDlYBk6oHBucU3ZCKFZur2wkhEPZOwgHdmEZq5ieFwAHz
        zNP4kl5HytTN20g77EaJLxEFtIGVAtdheCsdVAhjdR20e3n4zX/C/iGxWuVJWrCp
        RVKly/EBTvEOHV6XYqGZuOw/WHuwDQ2rrlcSQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E63A7F5E0A;
        Mon, 16 Nov 2020 15:04:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 141B5F5E09;
        Mon, 16 Nov 2020 15:04:07 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Don Goodman-Wilson via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Don Goodman-Wilson <don@goodman-wilson.com>
Subject: Re: [PATCH 28/28] Change the default branch name to `main`
References: <pull.762.git.1605221038.gitgitgadget@gmail.com>
        <f853fa946f5840518577584a5b8c51660da06928.1605221040.git.gitgitgadget@gmail.com>
        <87v9e9fujk.fsf@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.2011131500020.18437@tvgsbejvaqbjf.bet>
Date:   Mon, 16 Nov 2020 12:04:05 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2011131500020.18437@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Fri, 13 Nov 2020 15:09:14 +0100
        (CET)")
Message-ID: <xmqqmtzh83wq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E217FB7C-2846-11EB-BFBE-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi =C3=86var,
>
> On Fri, 13 Nov 2020, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>>
>> On Thu, Nov 12 2020, Don Goodman-Wilson via GitGitGadget wrote:
>>
>> > The current default name for the initial branch is a loaded term, an=
d
>> > many Open Source projects renamed their principal branches already. =
A
>> > common choice appears to be `main`.
>> >
>> > Let's follow their lead and change the default of `init.defaultBranc=
h`.
>>
>> I think it makes sense to split this change off from a 28-series test
>> cleanup series.
>
> It is not a test cleanup. It is a series of 27 patches preparing the te=
st
> suite for the change made in the 28th patch.
>
> I don't think that it is a good idea to split off that 28th patch from
> the patches whose entire purpose is to prepare for that 28th patch.

Well, I personally think that the "purpose" of the first 27 patches
must be updated if that is the case. =20

The test should NOT be prepared only to work in the post "switch
from master to main" world.

Instead, what we want to see is that the test would work whether the
fallback default value for init.defaultBranch is 'master' (i.e. old
world) or 'main (i.e. a possible new world).  Perhaps by using the
GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME mechanism for tests that relies
on a particular value to be the fallback default.  So in the sense,
the goal the first 26 patches support is the 27th one, which is the
most important one in the series from _my_ point of view.  We get
ourselves prepared so that 28th one can happen at any time.

That way, as long as the first 27 patches land, we will keep the
same test coverage as we've always had, regardless of the timing
we actually ship the 28th one to the production environment.

> Personally, I would have used something like
>
> 		main=3D$(git symbolic-ref --short HEAD) &&
> 		[...]
> 		git checkout $main
>
> instead of what you suggested. That's a topic for another patch (series=
),
> though.

Yeah, I would have used $primary or some word that is neither these
m* names, but I think that is a good alternative, when workable, to
the GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME mechanism.  When the golden
master compared with actual output hardcodes the expected branch
names, however, the approach becomes awkward, though.

Thanks.
