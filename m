Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 308A4207EC
	for <e@80x24.org>; Thu,  6 Oct 2016 18:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755453AbcJFSY5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 14:24:57 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50987 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754305AbcJFSYu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 14:24:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 882E642FD6;
        Thu,  6 Oct 2016 14:24:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=BGiDhfW98UD1
        N6Zt4GAjjw2nfSo=; b=NENuDmIAz26WrkEGxGe2LAecz74xDsA98MqmGHBqC6+V
        K48TZOAKpLm8ip0VmBbB0/CaVwxq6Gprt48gtZIZSeF12mPtXf7Vpz5CjksbHw7r
        wzQEjc+8z2jYgg34iLWiNQPVQXodgzRAIDY3E8gcozAnWZrH15mqQlalnHR8DsI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=h6EzWE
        Ibas+W5D6xJxC3KS5x+0TebF0/quQQlh6bJrCCpqRY9RhjdQeGgSApE+4PTwJtZh
        BfBP1zZntDXOrOoogCVBvjI4y4lSXDqESnPuT84cQy+gi3vKy23h5evJNcOYrsGd
        wCz5kIl6AukjvGUYtkDX7h8phiGqHxtJgkTJ8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7F4C042FD5;
        Thu,  6 Oct 2016 14:24:49 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F0DD842FD4;
        Thu,  6 Oct 2016 14:24:48 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git <git@vger.kernel.org>, Johan Herland <johan@herland.net>,
        Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] push: Re-include "push.default=tracking" in the documentation
References: <20161006084905.14944-1-avarab@gmail.com>
        <vpq1sztsmji.fsf@anie.imag.fr>
        <CACBZZX5ycZbFrrVgr4PVy5pKQDbnvmvDxuephx7-uHzzcm3u=g@mail.gmail.com>
        <vpqlgy1h28g.fsf@anie.imag.fr>
Date:   Thu, 06 Oct 2016 11:24:46 -0700
In-Reply-To: <vpqlgy1h28g.fsf@anie.imag.fr> (Matthieu Moy's message of "Thu,
        06 Oct 2016 18:27:27 +0200")
Message-ID: <xmqqint5l4i9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2A563020-8BF2-11E6-B4B0-F99D12518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> Junio, looks like from the 2013 discussion that you preferred just
>> having that mention in parenthesis instead of its own item, how about
>> just re-applying your fa23348 (with conflicts resolved)?
>
> (fa23348 did this:
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1749,7 +1749,8 @@ push.default::
>    +
>    This is currently the default, but Git 2.0 will change the default
>    to `simple`.
> -* `upstream` - push the current branch to its upstream branch.
> +* `upstream` - push the current branch to its upstream branch
> +  (`tracking` is a deprecated synonym for this).
> )
>
> I agree that doing the same thing is the best option.

Sorry, I wasn't paying attention to this thread. =20

It seems that 87a70e4ce8 ("config doc: rewrite push.default
section", 2013-06-19) removed that mention by accident?  The log
message of the commit does not say it actively wanted to remove
mention of `tracking` and/or why it wanted to do so, so I agree that
resurrecting that parenthetical mention is the easiest course of
action at this point.

However.

With today's description of push.default choices, each of which is a
full fledged paragraph, I no longer have the objection I had in

    https://public-inbox.org/git/7vip6dgmx2.fsf@alter.siamese.dyndns.org/

against having `tracking` as a separate bullet item.  If we add

    * `tracking` - a deprecated synonym for `upstream`; do not use this.

to today's list, it would stand out as something different from
others and it will not cause the confusion I feared in the
discussion we had in early 2013.  As Jonathan Nieder argued in the
thread back then, having it as one of the bullet point would help
people locate it without using "search" \C-s or / feature.



