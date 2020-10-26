Return-Path: <SRS0=PD7l=EB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 724A7C56202
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 21:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26DA621D41
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 21:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BtnPG24/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729063AbgJZVAt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 17:00:49 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63792 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729036AbgJZVAs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 17:00:48 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 73D11A5C04;
        Mon, 26 Oct 2020 17:00:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BAuk3RE1LHpUBHqRyk7kmcnS5PQ=; b=BtnPG2
        4/NtS1xvH45qkmjT2hfGyrPHBFxo73TsAJovd2clTdkX009JEQxSmy/ATbWt3y2n
        IYrk8mBLdgrNzWRzLm4IBy946KDVJzH7IAQip1Af8ueL38UsZIRXVzI0qLlrSpC4
        RF9s2hVfan1oLtEWXs+dR0+Ms9x4Fud7Hx4Ho=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BuHSe0mCzHlyqZ5AWiVjPrEO+cirPDE2
        gakSt9sY8c7IKWstNDr2A6CgXnECNJ4KqNnrN37OFRtsjIkf2LlrhLCe6Nh3tcHH
        BfbYjEFgOyz6m8aZeX9Ktam3ADxyGDJ7BK8A+EVOEpGyh+MCGhX9r7itz0uU4vAG
        hpmu1ng4qLQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6B8E7A5C03;
        Mon, 26 Oct 2020 17:00:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D5198A5C02;
        Mon, 26 Oct 2020 17:00:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] remote: add meaningful exit code on missing/existing
References: <20201026144825.26537-1-avarab@gmail.com>
        <20201026194519.GB16150@coredump.intra.peff.net>
Date:   Mon, 26 Oct 2020 14:00:45 -0700
In-Reply-To: <20201026194519.GB16150@coredump.intra.peff.net> (Jeff King's
        message of "Mon, 26 Oct 2020 15:45:19 -0400")
Message-ID: <xmqq5z6wem82.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 514217BE-17CE-11EB-8DC8-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> This is a run-on sentence; the comma after `2` should be a period.
>
> I'd also put an Oxford comma after `rename`, but that's a stylistic
> choice. :)

Will queue with this squashed in.

 Documentation/git-remote.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git c/Documentation/git-remote.txt w/Documentation/git-remote.txt
index 7c84631343..31c29c9b31 100644
--- c/Documentation/git-remote.txt
+++ w/Documentation/git-remote.txt
@@ -208,9 +208,9 @@ EXIT STATUS
 
 On success, the exit status is `0`.
 
-When subcommands such as 'add', 'rename' and 'remove' can't find the
-remote in question the exit status is `2`, when the remote already
-exists the exit status is `3`.
+When subcommands such as 'add', 'rename', and 'remove' can't find the
+remote in question, the exit status is `2`. When the remote already
+exists, the exit status is `3`.
 
 On any other error, the exit status may be any other non-zero value.
 
