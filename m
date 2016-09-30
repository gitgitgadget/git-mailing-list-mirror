Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F058F207EC
	for <e@80x24.org>; Fri, 30 Sep 2016 19:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933703AbcI3TAq (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Sep 2016 15:00:46 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52574 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933461AbcI3TAp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2016 15:00:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 814DD41F62;
        Fri, 30 Sep 2016 15:00:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uzLo3sUxaBidDyyOSp9UcZjiFFI=; b=KHInh2
        pJguSz9qKyfxsisnIA9x03Q3Sm+EvdAX0l16c7OXB34gg3O7XjbG1MLhr6/V1erZ
        9yPCil1clllGwxlJwvYx3TAqSEVjwgkdBcNHRduxsB4gQ7qqwpRPEK3rCph8qv3c
        8HuvdhLtCSk64M0WIBEK4aLyuliHRvHY1rsak=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Cvk89eYH10+pmWEPln0fHNbk+QpoHBVW
        0XlJB1Sp9wpGsqZh8j0j9qwp+Cpm8vamNEytCJa+Yfw3neFfzPDxEKm4W3j5D59v
        MLl58JOLM7clV5nR3JdIPd/n9E07C3oqzBrk2KEfODSJok0HD3Ao+o6CoK+3J+ms
        fBklXWX3OLE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 66C8941F5D;
        Fri, 30 Sep 2016 15:00:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E26EF41F5C;
        Fri, 30 Sep 2016 15:00:40 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 4/4] core.abbrev: raise the default abbreviation to 12 hexdigits
References: <CA+55aFy0_pwtFOYS1Tmnxipw9ZkRNCQHmoYyegO00pjMiZQfbg@mail.gmail.com>
        <20160928233047.14313-1-gitster@pobox.com>
        <20160928233047.14313-5-gitster@pobox.com>
        <ae9dbf3b-4190-8145-a59f-0d578067032a@kdbg.org>
        <xmqqmviqfuoh.fsf@gitster.mtv.corp.google.com>
        <CA+55aFyYWWpz+9+KKf=9y3vBrEDyy-5h6J3boiitGE7Zb=uL-Q@mail.gmail.com>
        <CA+55aFwbCNiF0nDppZ5SuRcZwc9kNvKYzgyd_bR8Ut8XRW_p4Q@mail.gmail.com>
        <20160929191609.maxggcli76472t4g@sigill.intra.peff.net>
        <CA+55aFxNVbvyERNc_xEhrtfTVMGz3hkeAx1nv9vW+dhJwCpp6g@mail.gmail.com>
        <xmqqwphuebhd.fsf@gitster.mtv.corp.google.com>
        <CA+55aFyVEQ+8TBBUm5KG9APtd9wy8cp_mRO=3nj12DXZNLAC9A@mail.gmail.com>
        <xmqqbmz6cna5.fsf@gitster.mtv.corp.google.com>
        <CA+55aFysvNc4p_nFcV=edctCizJBJtDjFOHJa-YYgVZQgBZfiA@mail.gmail.com>
        <CA+55aFyXxQSygO-gqevLZDjuggOaHs7HsRO=P6GhpC3GStqwvQ@mail.gmail.com>
        <CA+55aFxsfxvDQqi2M3TUVvAHUx3Qm1hHQ4DMyzXzN6V2v7o-3A@mail.gmail.com>
        <CA+55aFyHn0Q-qPq4dPEJ7X_4jf5UbsVw2vE-4LoWYbPn6gS10g@mail.gmail.com>
        <xmqqtwcyavou.fsf@gitster.mtv.corp.google.com>
        <xmqqoa36auyx.fsf@gitster.mtv.corp.google.com>
        <xmqqeg42au5w.fsf@gitster.mtv.corp.google.com>
        <xmqqmvip9qo7.fsf@gitster.mtv.corp.google.com>
        <CA+55aFyDqYCBCvw0MjZ8fNhaVbRSjsSXNDH--unYkoeJNwVcVg@mail.gmail.com>
Date:   Fri, 30 Sep 2016 12:00:39 -0700
In-Reply-To: <CA+55aFyDqYCBCvw0MjZ8fNhaVbRSjsSXNDH--unYkoeJNwVcVg@mail.gmail.com>
        (Linus Torvalds's message of "Fri, 30 Sep 2016 11:51:15 -0700")
Message-ID: <xmqqintd9prc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2E8D2D94-8740-11E6-ACBB-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Considering that TRANSPORT_SUMMARY and TRANSPORT_SUMMARY_WIDTH are
> both used in exactly one place each, I'd suggest getting rid of that
> crazy macro, and just expanding it in those places to avoid these
> kinds of crazy "hiding variables inside complex defines thning".
>
> And maybe just deciding to hardcode TRANSPORT_SUMMARY_WIDTH to 17
> (which was it's original default value and presumably is what the test
> is effectively hardcoded for too), and avoiding that complexity
> entirely.

For all fairness, when the WIDTH thing was introduced, there were
two places that needed reference it at f1863d0d16 ("refactor
duplicated code in builtin-send-pack.c and transport.c",
2010-02-16).  But that is no longer the case, and it makes sense to
hardcode it as 17 (or something derived from a symbolic constant
that gives the new "default to default").

What TRANSPORT_SUMMARY() does is even more crazy and it really
shouldn't be exposed as a public interface.  Let's move it to its
single calling place.
