Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 242EAC43334
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 19:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349250AbiFCT14 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 15:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237562AbiFCT1z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 15:27:55 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7870C1FA46
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 12:27:51 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E349C199763;
        Fri,  3 Jun 2022 15:27:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=89DIbm+VEGOI
        PsSmIpMkDnhPJ6OD1ffM+eKLcYNUT1o=; b=v8gQBn5Hb5r3CiXq3VHRK9ZJDQ8A
        YqiyXPkvgmydWGITVzxz+WzuSbOeam7o+Q60eflY4kkTzEl9seqUYh+tiRzOfRLS
        nLjhvFOilTHMI6aACJqH1yfus6CL0K4bmoHpzNaxTJoYHPx5ifeuWxugERmXG+gZ
        0qo1Ka/hyMGXap0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DB3F2199762;
        Fri,  3 Jun 2022 15:27:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 73024199760;
        Fri,  3 Jun 2022 15:27:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Josh Steadmon <steadmon@google.com>,
        congdanhqx@gmail.com, dyroneteng@gmail.com, martin.agren@gmail.com,
        peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: Re: js/ci-github-workflow-markup output regression
References: <xmqqee28spni.fsf@gitster.g>
        <patch-1.1-0fdfec624eb-20220531T171908Z-avarab@gmail.com>
        <nycvar.QRO.7.76.6.2206021703110.349@tvgsbejvaqbjf.bet>
        <220603.86fskmxd43.gmgdl@evledraar.gmail.com>
Date:   Fri, 03 Jun 2022 12:27:45 -0700
In-Reply-To: <220603.86fskmxd43.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 03 Jun 2022 11:54:31 +0200")
Message-ID: <xmqqpmjpeedq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3F54796C-E373-11EC-A2E0-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> Further, since this failure is outside of any `test_expect_success` or
>> `test_expect_failure`, the error message about this is not even includ=
ed
>> in the weblogs (but of course it is included in the full logs that are
>> included in the build artifacts). For the record, here is the error
>> message:
>
> ...this part of it though seems like a pretty bad regression in your
> merged-to-next js/ci-github-workflow-markup topic, which just happens t=
o
> be unearthed by this CI failure.

Indeed it makes it impossible to figure it out things like this
case.  But ...

> But this does look easy to "solve" with a quicker fix, just bringing
> back the "ci/print-test-failures.sh" step so you can at least expand it=
,
> and not have to go to the "summary" and download the *.zip of the log
> itself. As that shows we still have the raw log there, it just didn't
> make it to the new GitHub Markdown formatting mechanism.

... it seems a solution is possible?  Care to send in a patch (or
perhaps Dscho already has a counter-proposal)?

Thanks.
