Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F4A3C433EF
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 23:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17EC761184
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 23:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbhKIXbD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Nov 2021 18:31:03 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59815 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbhKIXbD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Nov 2021 18:31:03 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B770A152C92;
        Tue,  9 Nov 2021 18:28:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HN/iHgFI6gwnjftosZhMYOUwyOGvg46x0rq+ga
        mOZtI=; b=hrNtg241SekylWHpJwhpXSV5AR52en71lLyWUFIVjBCWPi9jzHTZhu
        O/Ze3KQUIWNi+abwbrTZwCrxSnE8ofH61ciHFe6QSB2JGD3SpBL3QuRSk0O08TIO
        XBe94mhoTVF91K98uu/z/ID5IZI+Dpr1MMywhULlbpXkJ8c5NrhWY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AF9AE152C91;
        Tue,  9 Nov 2021 18:28:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1CD49152C90;
        Tue,  9 Nov 2021 18:28:14 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Anders Kaseorg <andersk@mit.edu>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Andreas Heiduk <andreas.heiduk@mathema.de>
Subject: Re: [PATCH v4 1/4] fetch: Protect branches checked out in all
 worktrees
References: <a25d105a-875b-fa6a-771a-37936779f067@mit.edu>
        <20211109030028.2196416-1-andersk@mit.edu>
        <nycvar.QRO.7.76.6.2111091706290.54@tvgsbejvaqbjf.bet>
        <316e8579-d720-b40e-66fb-3280e8de1922@mit.edu>
        <xmqqa6id0w9y.fsf@gitster.g>
Date:   Tue, 09 Nov 2021 15:28:12 -0800
In-Reply-To: <xmqqa6id0w9y.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        09 Nov 2021 15:00:41 -0800")
Message-ID: <xmqqk0hgzz77.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B5C7F8D2-41B4-11EC-9796-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Another minor thing I noticed and meant to say but kept forgetting.
We do not upcase the first word after the <area>: in the commit
title.  E.g.

Subject: Re: [PATCH v4 1/4] fetch: protect branches checked out in all worktrees

not "fetch: Protect ...".

Thanks.
