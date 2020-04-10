Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A61C2BA2B
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 16:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69A7E20857
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 16:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="InqzaUXf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgDJQ0r (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 12:26:47 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59297 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbgDJQ0r (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 12:26:47 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DE47247BF9;
        Fri, 10 Apr 2020 12:26:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BeLFnC1RY+qi2/YzBD2MX4ddmac=; b=InqzaU
        Xf9z6xDrnMgYaTgWbXSRTL+1b8InSrIDz5K/km358+3zbb9myfPpmJO0L2RSZLSi
        6dH13+Kraxonwj36kynoiI0wju7a6HK6p/ziYdHrNVwSwdbDX7NRKrIReRICqk56
        aNDWCHX5wraddURyLtNX+5agPouXN2OlEaFIw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Uit2LKm5SpkTIt8Pu9kNs0wpoZtYfXXE
        eWdeLfmJ3ZJdHNnKkKyJPL5HEvks2L4vfCBtNQHYepEj+5iRTY8dYunY3YSS7ulE
        eL9KE/kyabncXWszp4epKG106ELfgOECKhpSbMsKWXj0syzWxBvmmV9MVjGaQk7a
        q/Bh24nwdlY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D669F47BF5;
        Fri, 10 Apr 2020 12:26:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5F8D047BF4;
        Fri, 10 Apr 2020 12:26:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v5 00/22] merge: learn --autostash
References: <cover.1585962672.git.liu.denton@gmail.com>
        <cover.1586269542.git.liu.denton@gmail.com>
        <eaf864e6-8441-c5a6-3c15-b71c522ec43d@gmail.com>
Date:   Fri, 10 Apr 2020 09:26:44 -0700
In-Reply-To: <eaf864e6-8441-c5a6-3c15-b71c522ec43d@gmail.com> (Phillip Wood's
        message of "Fri, 10 Apr 2020 16:34:46 +0100")
Message-ID: <xmqqsghbjohn.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 11C2E5C8-7B48-11EA-A7FA-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> Looking at the range-diff this series looks fine to me now apart from
> the typo Junio pointed out.

It is quicker for me to do s/NON_EXISTENCE/MISSING/ locally if there
is nothing else.  Thanks for giving the series another round of
look-over.


