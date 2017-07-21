Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4245203F3
	for <e@80x24.org>; Fri, 21 Jul 2017 23:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753527AbdGUXe1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jul 2017 19:34:27 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57652 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753502AbdGUXe0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2017 19:34:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2E0F99E379;
        Fri, 21 Jul 2017 19:34:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wgX9PRtNULckVktBI/nww6MhTU8=; b=Qt/Ab8
        lvaRcTQrm20byL7nh5jskZKRGnT1yhQQ5O2XzwQwUccEre89eOjo4ktPGvGLUmCS
        uaBKjcOFubT4QXilaiYMPiTlN31OynBBH+WVBXESpoT75R9ESzV63A8geRFH5has
        k6muf5NdY2JTSIbafmBj3tOfvDUYUsLNZA0XM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jbXE/LhgMS5+wqK8uv/CsydtzcvF8Z/1
        eNZCOJetWbI8zkdeLyisRzDbUjEtXunJGMpjgLJJc5+wyScUnu/V2LzkiOjqs4Fu
        SPMaVDb2IupTksWPLjg01af48x4DL/01YLxn52tVFx7Q8YVZFcm62dmAAYS3P69W
        6qhn1jVaMTQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 24E969E378;
        Fri, 21 Jul 2017 19:34:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 75E3C9E377;
        Fri, 21 Jul 2017 19:34:18 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
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
Date:   Fri, 21 Jul 2017 16:34:17 -0700
In-Reply-To: <CANYiYbF+XDANNbpZJ-jL7y81QhggW_snBuWeONSCUc4CPn2zMw@mail.gmail.com>
        (Jiang Xin's message of "Sat, 22 Jul 2017 07:13:50 +0800")
Message-ID: <xmqqr2x9fjpi.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1D964952-6E6D-11E7-B15B-EFB41968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> A very small hack on gettext.  When extract l10n messages to pot file
> with `xgettext`, will grep "PRItime", and do "sed s/PRItime/PRIuMAX"
> inside `xgettext`.
>
> See this patch:
> https://github.com/jiangxin/gettext/commit/b0a726431c93b5a1ca0fe749de376b0752e75fb0
> ...
>      gettext-tools/src/x-c.c      | 17 ++++++++++++++++-
>      gettext-tools/src/xgettext.c |  2 +-
>      2 files changed, 17 insertions(+), 2 deletions(-)

I do not think the size of the "hack" is much of an issue.  There is
no way you can sell this patch to the upstream, which would mean
that we would have to be relying on our own private edition of the
external tool, and that is what I feel very uncomfortable about.

You are not passing %<PRItime> through the toolchain and instead
turning it into %<PRIuMAX>, which is less risky than the obvious
alternative, but when we switch to a signed timestamp_t type and
need to change it something else (e.g.  PRIdMAX), you'd need to make
sure you update that private edition that matches the source being
compiled.  You might even be asked to do the po/git.pot thing for
both 'maint' and 'master' at the same time, when the former still
uses unsigned timestamp_t while the latter switched to signed one,
which would mean you'd need two hacked versions of gettext handy and
choose the "right" one.

Compared to that, Dscho's "hack" at least ties what PRItime is
replaced with and what the source code says by being in the
Makefile, which is tracked alongside the rest of the source.  So I
somehow feel that the approach has smaller chance of going wrong.

Am I missing some concerns you had that you think the tweaked
gettext would solve better?
