Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C5391F461
	for <e@80x24.org>; Thu, 22 Aug 2019 18:05:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732952AbfHVSFm (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Aug 2019 14:05:42 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55385 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfHVSFm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Aug 2019 14:05:42 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5CC3D6B53F;
        Thu, 22 Aug 2019 14:05:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=k94Qwo4QRoBAFeg5ZiBO+oBVCaA=; b=wr3Vf3
        g38k/94HUjdDoQK9YeeKQmlSqb5tkdFUS2wbHtLR+0beeb2FyDuHsbfQxdCDr7Ha
        M34DgTC43NJKm1lwQiyfTW+H1QymC2W3XMb2u4nhTEJJ3h1Qvn4U/vuiKK6JnulL
        d2hQO6dCM9TdNoUjy9Rf6DCv1of6/sU2B3ZOk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=C/tE1uVCDxrBJh+c5yWPOmJtGaHytJH0
        t7zdjTcqmfZNpgM6wRWUnWzBLDOhfIf05uM5naOiCaj7MwtQFfHLi5N2Ib1sWWXE
        theW53ZmtWK4+dHzQkmf4Bo+l+tKlViQF7pMI3ftBTQIyP07mMDdy37/wFqEwzgz
        yWXdWTFWiA8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 553326B53E;
        Thu, 22 Aug 2019 14:05:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 831996B53D;
        Thu, 22 Aug 2019 14:05:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Mischa POSLAWSKY <git@shiar.nl>
Cc:     git@vger.kernel.org,
        =?utf-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Subject: Re: [PATCH 2/1] t6300: format missing tagger
References: <20190817215107.13733-1-git@shiar.nl>
        <xmqqimqtxcou.fsf@gitster-ct.c.googlers.com>
        <xmqq1rxerxkk.fsf@gitster-ct.c.googlers.com>
        <20190822135528.GB28725@shiar.net>
        <xmqq36htqipw.fsf@gitster-ct.c.googlers.com>
        <20190822162731.gxubrdro4imv55qs@shiar.net>
Date:   Thu, 22 Aug 2019 11:05:35 -0700
In-Reply-To: <20190822162731.gxubrdro4imv55qs@shiar.net> (Mischa POSLAWSKY's
        message of "Thu, 22 Aug 2019 18:27:31 +0200")
Message-ID: <xmqqlfvloz2o.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 71C28ADE-C507-11E9-882F-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mischa POSLAWSKY <git@shiar.nl> writes:

> Junio wrote:
>> 
>> Mischa POSLAWSKY <git@shiar.nl> writes:
>> > Strip an annotated tag of its tagger header and verify it's ignored
>> > correctly in all cases, as fixed in commit e2a81276e8 (ref-filter:
>> > initialize empty name or email fields, 2019-08-19).
>> 
>> I am inclined to squash this test part of the update into the said
>> commit; you'd lose one commit count, but hopefully you do not mind?
>> 
>> My motivation for doing so is that it would allow us to lose the "as
>> fixed in commit X" comment in a log message, which in turn would
>> mean that the code-fix patch can later be rebased safely without
>> having to remember that this one needs to be adjusted ("git rebase"
>> does not do such a rewrite for us, and I personally do not think
>> "git rebase" should do such a rewrite silently, as I cannot quantify
>> the risk of false positives).
>
> Of course.  Might get one commit back if you pick it into maint :)

Actually you won't; I generally do not cherry-pick, even though I
merge down relevant fixes to older maintenance tracks.
