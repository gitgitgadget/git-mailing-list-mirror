Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D9A9C433E0
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 21:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10D2320756
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 21:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mB4Q6O/1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgHKVgK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 17:36:10 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55922 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbgHKVgK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 17:36:10 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5A13BF35A8;
        Tue, 11 Aug 2020 17:36:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0nX8Z1j5IH+WR5E4tBdn5dtR1N4=; b=mB4Q6O
        /1INRUGJqU82XaT03k12AetabzPqI01baHoUGWvj7D6aeB8vmNyrj+qxl6MO5Pzc
        9UZqm6Mkg8dnbFWJAjvF39Rn8HgAUKABJ89ERS28pUpch3ueCWwY+NcEGteG31Wf
        +058Lo38o6QOJBfMqTF9En7NAn2x2edLk0ca8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gisLohrBC5e0hc5dsVxQ13PZdbMkRl/i
        DddvQkuVcYRVtyi5lSUZDbgA935Gs6AEu1soYxdpApxXhUn8Teqq3JVsoyEa9vR5
        2pOHpCy5koYsiPVnWc2e570ysrVNTivM9e8cvXRLSS+dl4/21jTpHIUZ3N4YENP3
        6EXNPdwXGPY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 533C8F35A7;
        Tue, 11 Aug 2020 17:36:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9B119F35A6;
        Tue, 11 Aug 2020 17:36:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2020, #02; Mon, 10)
References: <xmqqsgcub811.fsf@gitster.c.googlers.com>
        <874kp9biho.fsf@osv.gnss.ru> <xmqq7du59eb4.fsf@gitster.c.googlers.com>
        <87364t563r.fsf@osv.gnss.ru> <87tux93pku.fsf@osv.gnss.ru>
Date:   Tue, 11 Aug 2020 14:36:03 -0700
In-Reply-To: <87tux93pku.fsf@osv.gnss.ru> (Sergey Organov's message of "Tue,
        11 Aug 2020 23:17:05 +0300")
Message-ID: <xmqqh7t89870.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A95651B2-DC1A-11EA-88E4-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> Here is the patch you've asked for, separately, as I honestly believe it
> does not belong to the series in question themselves. This is on top of
> the series.

Well, the tip commit's title being "add test for --diff-merges=off",
testing it standalone as well as in different ways to combine with
another option that potentially interacts with it would make the
commit complete, I would think.

The sample output shows that the explicit --diff-merges=off told
"git log" not to show any patch for merge commits, which is what we
want to see, so it looks good.

Thanks.

