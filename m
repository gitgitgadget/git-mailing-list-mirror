Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B09E207EC
	for <e@80x24.org>; Fri, 30 Sep 2016 03:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755927AbcI3DzF (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 23:55:05 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59860 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755913AbcI3DzE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 23:55:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6216F425C0;
        Thu, 29 Sep 2016 23:55:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=f/4aEFVOuZ84C2ycu39jpysSY3Y=; b=WBXDux
        36PHGGMMMgw/cxQI2O/98r2m0ZDrx+bnzRQ0d0DqdNU05U+iM8HIthw7JY8XX/Vp
        VHb3ElmEzHrXSJTMixbNcAU9R4qceLisdVXANE98szeNBckLD7pxGSISCsszoM57
        1h+kTfaHKwGzyJS6gQZkUrF5bpagda2szdiss=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FHirnfEcEfUeNxZ9188XDv+fKI1VFX7f
        SAXQH2G3hisj9tvogl9Y/WZmk2sSqVjHlUjswlROWslqkFa4OydRysqtzpgTNeUC
        ogL0zyP4ZOOhKqomkgSJ35St4FaOsOlKuzEYZPtM/LIT/J1dJoq7TwkgrS6+ZpnE
        r14CWh5Bmtg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DCA7F425BE;
        Thu, 29 Sep 2016 23:55:00 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0C989425BD;
        Thu, 29 Sep 2016 23:54:59 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>
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
Date:   Thu, 29 Sep 2016 20:54:57 -0700
In-Reply-To: <CA+55aFyHn0Q-qPq4dPEJ7X_4jf5UbsVw2vE-4LoWYbPn6gS10g@mail.gmail.com>
        (Linus Torvalds's message of "Thu, 29 Sep 2016 18:18:03 -0700")
Message-ID: <xmqqtwcyavou.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A8D46D8A-86C1-11E6-927F-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> So this patch may actually be "production ready" apart from the fact
> that some tests still fail (at least t2027-worktree-list.sh) because
> of different short SHA1 cases.

t2027 has at least two problems.

 * "git worktree" does not read the core.abbrev configuration,
   without a recent fix in jc/worktree-config, i.e. d49028e6
   ("worktree: honor configuration variables", 2016-09-26).

 * The script uses "git rev-parse --short HEAD"; I suspect that it
   says "ah, default_abbrev is -1 and minimum_abbrev is 4, so let's
   try abbreviating to 4 hexdigits".

The first failure in t3203 seems to come from the same issue in
"rev-parse --short".
