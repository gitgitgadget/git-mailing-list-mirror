Return-Path: <SRS0=o5qA=2U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D22CCC2D0C3
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 21:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E22120658
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 21:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MGfRW4dJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbfL3Vix (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Dec 2019 16:38:53 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62099 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727691AbfL3Viw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Dec 2019 16:38:52 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6A8783BF43;
        Mon, 30 Dec 2019 16:38:50 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=erIwWj3oIfNE7x6/KX18J3wqxbU=; b=MGfRW4
        dJKO1gYyGGzystxOlspkOyKftKNZ51ua+84gFKS7hWxM2+/VxSqXTITb/Qjk/BMJ
        kplxPPQ7vAGqiMj8uzcDzBvLs/MH7T5E67tEsw0MnWQu+Z5rPkxPwlrDLcMbnz5v
        y2DaZJzoul8lwvL+jxsKloKtsk0Fp1Q9tAPjk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wX18aidwmmuGXHoX+kQ8XqVgCn/FaoDk
        XKHY/mGuxjaiUcQv+sdYi1afPP8l2MGwDRDLj35ETwPvfLGnGphCdJUFe/ZmmSiA
        ggAPX0Aoarn1NMmfLvvktAabq4llsbWGkQfGr9VU744hGfB3lkIOQ/WfYiVbPH2N
        Lh8roG9wQxk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 605553BF42;
        Mon, 30 Dec 2019 16:38:50 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C99AE3BF41;
        Mon, 30 Dec 2019 16:38:49 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 01/17] Makefile: alphabetically sort += lists
References: <cover.1571246693.git.liu.denton@gmail.com>
        <cover.1577185374.git.liu.denton@gmail.com>
        <31055cdac4a5bfc48cf6f18179f4e9bce9a04c8c.1577185374.git.liu.denton@gmail.com>
Date:   Mon, 30 Dec 2019 13:38:48 -0800
In-Reply-To: <31055cdac4a5bfc48cf6f18179f4e9bce9a04c8c.1577185374.git.liu.denton@gmail.com>
        (Denton Liu's message of "Tue, 24 Dec 2019 06:04:58 -0500")
Message-ID: <xmqqwoadfq8n.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C4423F42-2B4C-11EA-BF35-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Note that if we omit file prefixes, the lists aren't sorted in strictly
> alphabetical order (e.g. archive.o comes after archive-zip.o instead of
> before archive-tar.o). This is intentional ...

That's fine, but then we shouldn't label it as "alphabetically sort".

> because the purpose of
> maintaining the sorted list is to ensure line insertions are
> deterministic.

Truly alphabetic sorting is deterministic, too, so that is *not* the
reason why you are not being strictly alphabetic.  The true reason
is because it is easier to apply mechanical sorting in ascii order
than truly sort alphabetically.  Both are equally deterministic and
reproducible.  Alphabetic might be easier for humans to see and
understand, but you value mechanical ease of sorting and that is why
you chose ascii order over alphabetical sorting.

