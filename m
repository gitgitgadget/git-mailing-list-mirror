Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE1BD1F89D
	for <e@80x24.org>; Sat, 22 Jul 2017 15:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752126AbdGVPs7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Jul 2017 11:48:59 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50383 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752089AbdGVPs7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Jul 2017 11:48:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 26212A19C2;
        Sat, 22 Jul 2017 11:48:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HvPT4TWq5RsJ0+aSU4iBbd4qbmg=; b=wqlhR7
        8glsKsC6DnDrPRDTjmFU7lF4GTiIuWDegm6MJ1bPkJBGkIeABNuVHK2kerPmSNkI
        yzFEgYBf/xtmHfTY4ZZC1IHl9CRYZItJs5TnM9t0HSk1V8deRKzzXP0UkQiACwvD
        r8THSBgdhv0OQ/2tETYy8AQUUX7BcxMX6EgyU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fJwyJsMd0LhibG8mI6HWEAdV2eSxq5fG
        0bxA5Le6tUiFhmLrlibRt5hd1K3RXRcT4Ad8O6as8LreRfEv/P/EzAzg6GCVfH3t
        2BU3eU3bW+xhuFhH+8emfWBDPJO429TIxQquXcRH/zNL8gbHwYFccs4TjSOQtQQ+
        CtPerq/uzXA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1DC3EA19C1;
        Sat, 22 Jul 2017 11:48:58 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 78915A19C0;
        Sat, 22 Jul 2017 11:48:57 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
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
        <xmqqr2x9fjpi.fsf@gitster.mtv.corp.google.com>
        <CANYiYbGkuGNNYn4OF5w=1+Pqn9hEHWcD+DYVB6AXRs0vFEsY2Q@mail.gmail.com>
        <alpine.DEB.2.21.1.1707221323420.4271@virtualbox>
Date:   Sat, 22 Jul 2017 08:48:56 -0700
In-Reply-To: <alpine.DEB.2.21.1.1707221323420.4271@virtualbox> (Johannes
        Schindelin's message of "Sat, 22 Jul 2017 13:28:52 +0200 (CEST)")
Message-ID: <xmqqeft8fp5j.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 45CB025E-6EF5-11E7-BEC6-61520C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> >> A very small hack on gettext.
>
> I am 100% opposed to this hack. It is already cumbersome enough to find
> out what is involved in i18n (it took *me* five minutes to find out that
> much of the information is in po/README, with a lot of information stored
> *on an external site*, and I still managed to miss the `make pot` target).
>
> If at all, we need to make things easier instead of harder.
>
> Requiring potential volunteers to waste their time to compile an
> unnecessary fork of gettext? Not so great an idea.
>
> Plus, each and every Git build would now have to compile their own
> gettext, too, as the vanilla one would not handle the .po files containing
> %<PRItime>!!!
>
> And that requirement would impact instantaneously people like me, and even
> worse: some other packagers might be unaware of the new requirement which
> would not be caught during the build, and neither by the test suite.
> Double bad idea.

If I understand correctly, the patch hacks the input processing of
xgettext (which reads our source code and generates po/git.pot) so
that when it sees PRItime, pretend that it saw PRIuMAX, causing it
to output %<PRIuMAX> in its output.

In our workflow, 

    * The po/git.pot file is updated only by the l10n coordinator,
      and then the result is committed to our tree.

    * Translators build on that commit by (1) running msgmerge which
      takes po/git.pot and wiggles its entries into their existing
      po/$lang.po file so that po/$lang.po file has new entries from
      po/git.pot and (2) editing po/$lang.po file.  The result is
      committed to our tree.

    * The build procedure builders use runs the resulting
      po/$lang.po files through msgfmt to produce po/$lang.mo files,
      which will be installed.

As long as the first step results in %<PRIuMAX> (not %<PRItime> or
anything that plain vanilla msgmerge and msgfmt do not understand),
the second step and third step do not require any hacked version of
gettext tools.

Even though I tend to agree with your conclusion that pre-processing
our source before passing it to xgettext is probably a better
solution in the longer term, I think the most of the objections in
your message come from your misunderstanding of what Jiang's patch
does and are not based on facts.  My understanding is that
translators do not need to compile a custom msgmerge and builders do
not need a custom msgfmt.

