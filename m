Return-Path: <SRS0=XLsf=DH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC667C4363D
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 22:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91E782074A
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 22:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GNksCpM4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731941AbgI3W5q (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 18:57:46 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59791 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731925AbgI3W5q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 18:57:46 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BE0C18938D;
        Wed, 30 Sep 2020 18:57:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NctX3+T+0DN6Hb4dVfMTfiysd10=; b=GNksCp
        M4rx6H2n/XQY+XzV58qATy/2Y82XFEp9O1osD5aOs9CLE5VLfDyhl2IxQ6qV74tu
        9hSYjLzuucI/sU1selX+s70iFWAg0s5vQcTyxNzvpcefbewaW/HPKX93FyKft5kv
        oFCJNG9xVhZsuYhzol22B8xS76sxdrrGBuKTI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=J7h0tXrUo++z64JfKe7PeDrS3DosOhIR
        5MARzxWpIPv2+lDdz4byxH2vfzltQu6iAgRlTJpF3uWTBPrsEOp9Uei3J6aiRMUE
        LGJIqHqy2U9IEGD7JFEEdVx1qTQtC6wxu9nGwwMaHRWanDm9d5uMHM2ezQFR4xzF
        aeGdhYsFizQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A5D728938C;
        Wed, 30 Sep 2020 18:57:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 03E5F8938B;
        Wed, 30 Sep 2020 18:57:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 0/5] Inclusive naming, part II
References: <pull.734.v2.git.1600725687.gitgitgadget@gmail.com>
        <pull.734.v3.git.1601154262.gitgitgadget@gmail.com>
        <xmqqimbugb3l.fsf@gitster.c.googlers.com>
        <20200930223451.GA1908000@coredump.intra.peff.net>
Date:   Wed, 30 Sep 2020 15:57:41 -0700
In-Reply-To: <20200930223451.GA1908000@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 30 Sep 2020 18:34:51 -0400")
Message-ID: <xmqq1riig9ei.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 58770228-0370-11EB-B2EC-01D9BED8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Sep 30, 2020 at 03:21:02PM -0700, Junio C Hamano wrote:
>
>> > Changes since v2:
>> >
>> >  * Extended the idea of using topic instead of main to patch 4/5.
>> >  * Explained in the commit message of patch 5/5 why we cannot use topic 
>> >    instead of main here.
>> 
>> This round hasn't seen any new comments.  I quickly scanned them one
>> more time, and it seems to be in good shape.
>> 
>> Shall we merge it down to 'next'?
>
> I had an "all of v3 looks good to me" comment, but it was perhaps a bit
> buried. So yes, I think this is ready for 'next'.

Ah, thanks and sorry for a confusing comment.  I meant by "new
comments" messages that point out issues yet to be addressed.

