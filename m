Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0FDC433EF
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 21:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347019AbiFOVI5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 17:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345188AbiFOVI4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 17:08:56 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902173615A
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 14:08:55 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0A00B1A838B;
        Wed, 15 Jun 2022 17:08:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=zATE8chi2wQ3
        2a8qFIqIJgiXWsLuRFdyCclYCzmwDh8=; b=kvBRYUetK8Wq/imXChAr3XCYJLBu
        4OHYAJFNO/PCcTgfqnkN4HSpFj+KkmqS/M59HVQk01ixDCMRCZ1Dmhnc6X8h8aNL
        ccqGBnMhs8BHqO/sOLPDFMFmv0+1s87KDHWgWriaGWyCoS4we5289zuK2KXaReYL
        UeSpBQXmUxG+ef0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 02D5B1A838A;
        Wed, 15 Jun 2022 17:08:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A4F4F1A8388;
        Wed, 15 Jun 2022 17:08:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 1/1] tests: add LIBCURL prerequisite to tests needing
 libcurl
References: <cover-0.1-00000000000-20220615T103609Z-avarab@gmail.com>
        <patch-1.1-353c384d2b1-20220615T103609Z-avarab@gmail.com>
        <xmqq35g5232b.fsf@gitster.g>
        <220615.861qvpy8jq.gmgdl@evledraar.gmail.com>
Date:   Wed, 15 Jun 2022 14:08:50 -0700
In-Reply-To: <220615.861qvpy8jq.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 15 Jun 2022 22:28:29 +0200")
Message-ID: <xmqq5yl1zlb1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5B6DD2DA-ECEF-11EC-AB54-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>>> -if test -n "$NO_CURL"
>>> +if ! test_have_prereq LIBCURL
>>>  then
>>>  	skip_all=3D'skipping test, git built without http support'
>>>  	test_done
>>
>> This is not strictly needed in "the most minimal fix possible", is
>> it?  Just checking.
>
> I figured if I was adding a $NO_CURL prereq I might as well change the
> only existing use of $NO_CURL to use it, which also assures the reader
> that our test suite is getting this from somewhere already.
>
> But I'll drop this in a re-roll.

No need.  It already is at the tip of 'master' applied directly.
