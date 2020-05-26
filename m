Return-Path: <SRS0=GnTn=7I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A337FC433E0
	for <git@archiver.kernel.org>; Tue, 26 May 2020 16:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59BB5207D8
	for <git@archiver.kernel.org>; Tue, 26 May 2020 16:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="N+F92AuK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbgEZQB1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 May 2020 12:01:27 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57677 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727911AbgEZQB0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 May 2020 12:01:26 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CB074B8A8F;
        Tue, 26 May 2020 12:01:24 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=cVIfdhLJZmug3fKtbZ9bo50Hwqg=; b=N+F92Au
        Ki6fgLycnvSBQrSe3xZ+Xk8biNUCa59YslQVk2nFDcmXkV4uFuB6bYNt66OdmPYg
        JJ0mv/zwFcLoXhlQPzm8jrI1naDc2KpS9ONERZRODSyZ7i4QB82d+0AXMdP+q5Nw
        buYVdNCky0F7m/iO5wiTCKNjQqznP2CEyAM4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to; q=dns; s=sasl; b=WDy36WIAN3V3MgSXxIbD1Tx+ty09TQm8u
        DxuTCscLuh33oA2ZTxtrsnLg/T0VnPGfZSY5DBSRacHHDniK6mUf2A52l88s5hzP
        s/Z//hRcAy8kxiSDX2NDLeifv3fzK4ebBzufgXM4qWk19cO9tVS9h3sEB0KbZxGc
        MHAIB5uo+M=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C4AA6B8A8D;
        Tue, 26 May 2020 12:01:24 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [71.254.198.10])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CF8B4B8A8A;
        Tue, 26 May 2020 12:01:20 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Date:   Tue, 26 May 2020 12:01:18 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2020, #08; Sun, 24)
Message-ID: <20200526160118.GY6611@pobox.com>
References: <xmqqh7w4pulj.fsf@gitster.c.googlers.com>
 <20200525172708.GT6611@pobox.com>
 <20200525175309.GD1915090@camp.crustytoothpaste.net>
 <xmqq8shfq3w6.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8shfq3w6.fsf@gitster.c.googlers.com>
X-Pobox-Relay-ID: 24592F4E-9F6A-11EA-963B-B0405B776F7B-09356542!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> 
>> I think since this is an anchor link it's just fine to change for
>> compatibility.
> 
> Given that no other document in tree seems to point at the anchor, I
> think the patch is probably OK.

Excellent.  Thank you both for taking a look.

-- 
Todd
