Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA44420958
	for <e@80x24.org>; Mon, 20 Mar 2017 22:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755584AbdCTWF3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 18:05:29 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56219 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753724AbdCTWF2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 18:05:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 616D67E0BB;
        Mon, 20 Mar 2017 18:05:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LZhI3jUrDo12XuKaErgU855v05M=; b=cRwd5I
        oUumjP2KUSXqeTPOpChKReEqCOna730aWzTzlkBWwwQCe+amK3K4CFD1HG1GQgMR
        rsPuqORaTLpNEhtS5wZCHeEoqn07zyYICIYBs8/5e/KK8/8QAsgGCVTgH6W11GlI
        eiH8OwIyrm4YdyiGlNsgyO3iBX9iy4Oda9/uA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iEwBuUdFjWgv2AIsqmsZNqw8iPSBznvv
        Il9bEYmn6Bn9Ttk87sDsfU9Uwdms2iuGJesBm6GazYwijFCjUa55PrRpXpqKRLDj
        Let8rlZc+FVAdUc0ajB7ocnr2GZw7IcZCvf7IbgauwHwfowtd3p98EBmiC6saJ9J
        0qaSopdqgxA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 576FF7E0BA;
        Mon, 20 Mar 2017 18:05:27 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B56DA7E0B8;
        Mon, 20 Mar 2017 18:05:26 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jean-Noel Avila <jn.avila@free.fr>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 2/2] l10n: Add git-add.txt to localized man pages
References: <20170312200248.3610-1-jn.avila@free.fr>
        <20170320210225.13046-1-jn.avila@free.fr>
        <20170320210225.13046-3-jn.avila@free.fr>
Date:   Mon, 20 Mar 2017 15:05:24 -0700
In-Reply-To: <20170320210225.13046-3-jn.avila@free.fr> (Jean-Noel Avila's
        message of "Mon, 20 Mar 2017 22:02:25 +0100")
Message-ID: <xmqqpohbtxi3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 52CFB3DE-0DB9-11E7-9D48-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jean-Noel Avila <jn.avila@free.fr> writes:

> Signed-off-by: Jean-Noel Avila <jn.avila@free.fr>
> ---
>  Documentation/po/documentation.fr.po | 1095 ++++++++++++++++++++++++++++++++++
>  Documentation/po/documentation.pot   |  787 ++++++++++++++++++++++++
>  2 files changed, 1882 insertions(+)
>  create mode 100644 Documentation/po/documentation.fr.po
>  create mode 100644 Documentation/po/documentation.pot

This sounds more like

Subject: l10n: add fr localization for git-add manual pages

to me.  The actual part of this patch that adds "git-add" is the
addition of Documentation/po/documentation.pot, and from that point
of view, this patch may want to be further split into two.

But more importantly, aren't we essentially adding an equivalent of

	cd Documentation && cat git-*.txt

to our codebase?

Surely we cannot avoid having a copy of all messages that are to be
translated using msgid/msgstr based approach, and we already do so
for end-user-facing in-program strings, but it just feels a bit too
much having to carry a duplicate (and slightly a stale) copy of the
entire documentation set around.  For N languages, we'll have an
equivalent for N copies of the English text, in addition to the
translated documentation.

I am wondering if Documentation/po part should be a separate
repository, with a dedicated i18n/l10n coordinator.  Would it make
it easier for (1) those who write code and doc without knowing other
languages, (2) those who update .pot and coordinate the l10n effort
for the documentation and (3) those who translate them if we keep
them in a single repository?

