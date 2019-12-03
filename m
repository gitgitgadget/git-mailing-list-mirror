Return-Path: <SRS0=UYkv=ZZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E938C432C0
	for <git@archiver.kernel.org>; Tue,  3 Dec 2019 16:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FC67206EC
	for <git@archiver.kernel.org>; Tue,  3 Dec 2019 16:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="j1974Tsx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbfLCQzk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Dec 2019 11:55:40 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53007 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfLCQzj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Dec 2019 11:55:39 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 243992F5CA;
        Tue,  3 Dec 2019 11:55:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Za12wO5TsY2q86Qk1wLELXvBs8U=; b=j1974T
        sxcucuPP9OKJC8Ahub1BgDrVIs/zDOc5DamQnlfOQBwDJaugamEFdbGOYRB4jMYF
        6M4mzvcMk7aM6DdxYEZR2LZPlHO4xGMYIWq4MSzVqogzRAdJZ54oqcSL5hLQwTjH
        r/zLMApXnAzVJcbKFgIRMoexItx0qSCvcbXjQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=H/PjfsVe0BGXPI6Y3XBZKiIEbr5Cr1Wb
        M8fXZ7DKC4qXRQeUy/utxBfrY6YJuT65OJnK9zFNwVsbTYPOXqYxPK1ImUOxWQfq
        IhE5SUM4oHiSFDnHbku8vbFEl/MsGeoodMSBd71t/Q/YSKWSFRr/BMIriNEY2Vhu
        TYRhzKz2v4U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 196102F5C9;
        Tue,  3 Dec 2019 11:55:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 65A782F5C7;
        Tue,  3 Dec 2019 11:55:38 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Subject: Re: [PATCH v4 00/13] Add --pathspec-from-file option
References: <pull.445.v3.git.1574182135.gitgitgadget@gmail.com>
        <pull.445.v4.git.1575381738.gitgitgadget@gmail.com>
Date:   Tue, 03 Dec 2019 08:55:37 -0800
In-Reply-To: <pull.445.v4.git.1575381738.gitgitgadget@gmail.com> (Alexandr
        Miloslavskiy via GitGitGadget's message of "Tue, 03 Dec 2019 14:02:05
        +0000")
Message-ID: <xmqqpnh55oxi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BB704A22-15ED-11EA-B4A9-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Changes from V3:

Yikes, perhaps our mails crossed or something?  I think the previous
round is already in 'next'.

Let's wait and see they cook enough to graduate to 'master', and
build a separate series on top to teach other commands the option
using the facility introduced by the current series (which is the
first 6 patches you sent here).

Thanks.
