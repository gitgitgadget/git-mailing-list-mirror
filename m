Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E08381FBB0
	for <e@80x24.org>; Mon,  5 Dec 2016 22:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752437AbcLEWZF (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Dec 2016 17:25:05 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61957 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751455AbcLEWZA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2016 17:25:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C3E7C56A94;
        Mon,  5 Dec 2016 17:24:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1xdG6YpD2nzHO8+LQfytuFA2PTI=; b=ChtOkz
        mUnne8+FGkFLPQ3Kjzd7/+dQttm3Dz6Svbbj3ufSjMz032P1JPbaf1pdWGiZ1Jag
        CrBZqdOM1HWrXMXnBXtJMnGn1K8n+DTHAmfoDUNVUecLW4ZQBqQLfTHKJgTpNrST
        bVl3SJTmVsH/Z6h9/L4e/wQIYJfhgcylcXqmo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sciPwucuPAwXGl1JoX0MV7OjUJ0DhCmM
        xRGrEUxvTSY+jA6YJ8q9DU8h1pn4AohpCP3LJWCMKAuXHnict5CKTpdQTeoYEgse
        Qvpn81sg5dCJFkV2bP6JDeFmNvnkmI0C7rcBFF3NeR2e1Sfz5SN2IySUyMvCiRzK
        nafemw7FEbI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BBFA756A93;
        Mon,  5 Dec 2016 17:24:58 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2A71556A91;
        Mon,  5 Dec 2016 17:24:58 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Jeff King <peff@peff.net>, GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [RFC PATCH] GIT-VERSION-GEN: set --abbrev=9 to match auto-scaling
References: <22e9dfa0-47fb-d6fd-caf4-c2d87f63f707@ramsayjones.plus.com>
        <20161205053258.jtnqq64gp5n7vtni@sigill.intra.peff.net>
        <ab1e7ce9-1022-0c72-2f72-63e3b9182bc9@ramsayjones.plus.com>
        <xmqq7f7e5jsy.fsf@gitster.mtv.corp.google.com>
        <e74163ee-e7d4-bcbd-e65f-368bc2ee9a2d@ramsayjones.plus.com>
Date:   Mon, 05 Dec 2016 14:24:57 -0800
In-Reply-To: <e74163ee-e7d4-bcbd-e65f-368bc2ee9a2d@ramsayjones.plus.com>
        (Ramsay Jones's message of "Mon, 5 Dec 2016 20:30:17 +0000")
Message-ID: <xmqqr35m2eva.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A7AAD956-BB39-11E6-AA55-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> As I said, the original version of the patch just removed the
> --abbrev=7, but then I started to think about why you might have
> used --abbrev in the first place (first in commit 9b88fcef7 and
> again in commit bf505158d). Making sure to override the configuration
> was the only thing I could come up with. So, I was hoping you could
> remember why! :-P

Nope.  As a maintainer support script, the only thing I cared about
it is that there is no -gXXXX at the end for anything I release ;-)

> (I assumed it was to force a measure of uniformity/reproducibility).

You cannot force uniformity/reproducibility with fixed abbrev,
unless you set abbreviation length to 40, so you are correct to add
"a measure of" there ;-) The first choice (i.e. 4) may have had a
justification to force absolute minimum, and the second one (i.e. 7)
may have had a justifiation to make it clear that we are using the
same setting as the default, so in post-1.7.10 era, I think it is
fine for us to just say "we have been using the same as default, so
let's not specify anything explicitly".


