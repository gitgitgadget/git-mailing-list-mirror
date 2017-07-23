Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D35611F600
	for <e@80x24.org>; Sun, 23 Jul 2017 21:55:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751769AbdGWVzE (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Jul 2017 17:55:04 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51238 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751463AbdGWVzD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Jul 2017 17:55:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9E89D79DE0;
        Sun, 23 Jul 2017 17:54:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=NKpF8TDJdZk5
        F7HJjfv/Yp0sA9Q=; b=bGxcBjAQwRcg2JDXCaeQgPhxs4Q6o+NdnI8iEw1rLCa0
        E02Q6PwEiOd8XGmbOxJkbocRxiqxGPKgNJ3uoluSMpBPdfcDPQ6SgNE7Kf7m2Ngm
        i+ASyjcHdd4jZ5D/Q49Aa+/+yaQ2DaSZwBnr5RvsY1Z9oHAbNNz9UyahqFfqyS4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=omN5qW
        nZSyL1J3n6J9y/xpqN1Vel5mDaxg1UzxNLxWjQvu0FvOVzwUaeKV+9dMPetYGqHa
        bRo5fLzQXlJJAQSH+qJWy4gVXuKFnpYmdZqhgg0qPsJ9J0j7clV4C3da69vMrhrr
        7N3OW3KuLKUztiaS/kQZ6Ff71czegzEkeQJxo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 96DEA79DDF;
        Sun, 23 Jul 2017 17:54:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0A01479DDE;
        Sun, 23 Jul 2017 17:54:52 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jean-noel.avila@scantech.fr>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] PRItime: wrap PRItime for better l10n compatibility
References: <249ac6f8-af3c-4b20-5bf0-87a82866cc7a@free.fr>
        <3ccfa2fb49d471f807d77d9a280e4b7cfe56faea.1500304209.git.worldhello.net@gmail.com>
        <xmqq7ez7htvj.fsf@gitster.mtv.corp.google.com>
        <CANYiYbEcMrriaor9OT4c2qtfh9Ja5NJ9KBSxa3XhPAuoN0t42A@mail.gmail.com>
        <xmqq60epfy27.fsf@gitster.mtv.corp.google.com>
        <CANYiYbFROuyXso2ZKuJWDp4cSwpBu=bNAbC-yZtEyDwkbUcAhQ@mail.gmail.com>
        <alpine.DEB.2.21.1.1707191456010.4193@virtualbox>
        <xmqq8tjkm3ly.fsf@gitster.mtv.corp.google.com>
        <xmqqo9sfkm32.fsf@gitster.mtv.corp.google.com>
        <CANYiYbGSaaFOq7iw=ON1Oo87bSA96o=zyzym5RDT32kMae7bsw@mail.gmail.com>
        <xmqqvamlfm6s.fsf@gitster.mtv.corp.google.com>
        <CANYiYbF+XDANNbpZJ-jL7y81QhggW_snBuWeONSCUc4CPn2zMw@mail.gmail.com>
        <xmqqr2x9fjpi.fsf@gitster.mtv.corp.google.com>
        <CANYiYbGkuGNNYn4OF5w=1+Pqn9hEHWcD+DYVB6AXRs0vFEsY2Q@mail.gmail.com>
        <2421d5f3-12ee-833b-72d8-de627fbfe26c@scantech.fr>
Date:   Sun, 23 Jul 2017 14:54:51 -0700
In-Reply-To: <2421d5f3-12ee-833b-72d8-de627fbfe26c@scantech.fr>
 (=?utf-8?Q?=22Jean-No=C3=ABl?=
        AVILA"'s message of "Sun, 23 Jul 2017 04:33:18 +0200")
Message-ID: <xmqqwp6yes44.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8EBBABEC-6FF1-11E7-82F9-61520C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jean-No=C3=ABl AVILA <jean-noel.avila@scantech.fr> writes:

> Le 22/07/2017 =C3=A0 02:43, Jiang Xin a =C3=A9crit :
>>
>> Benefit of using the tweak version of gettext:
>>
>> 1. `make pot` can be run in a tar extract directory (without git contr=
olled).
>
> This issue is real for packet maintainers who can patch the original
> source and run their own set of utilities outside of a git repo. This
> can be possible with Junio's proposition by writing the files to a
> temporary directory before running the xgettext, then removing the
> temporary directory.
>
> Please note that with respect to this issue, the patched xgettext
> approach is completely disruptive.

OK, so what you are saying is that my assumption that Jiang (at
least for now, and his successor l10n coordinator in sometime in the
future) would be the only one who needs to have access to the
machinery to update po/git.pot and that it does not matter that much
what that exact machinery is as long as the resulting po/git.pot
lists messages with %<PRIuMAX> and other known ones because plain
vanilla tools will grok such po/git.pot file just fine, were both
too optimistic.

I think binary packagers, who update the software with their own
changes, produce their own modified po/git.pot and have that
translated into multiple languages, are capable of coping with any
method we use ourselves, but being capable of doing something and
being happy to do that thing are two different things, and we need
to aim for the latter---we should not make things unnecessarily
cumbersome for them.

So I'll leave the s/PRItime/PRIuMAX/ patch in the 'master' without
Jiang's change for 2.14-rc1.  The approach to require private
edition of xgettext, while it may technically be a fun exercise,
would not fly very well in the real world.

For those who want to work with a tarball extract without being in a
Git repository, it would be sufficient fot them to run "git init &&
git commit --allow-empty -m import" immediately after extracting the
tarball, even if we require that "make pot" must be run in a clean
repository.  And I'd prefer to go that route than copying into a
temporary directory, primarily because I do not want to having to
worry about what to copy---when we know we pass $foo.c through
xgettext, we know we want to put the modified copy of $foo.c in the
temporary, but I do not want to even think if we need to also copy
the header files $foo.c "#include"s, for example.

Thanks.
