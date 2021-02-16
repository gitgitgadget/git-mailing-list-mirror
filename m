Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48F5C433DB
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 19:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DBBC64E7D
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 19:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbhBPTqO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 14:46:14 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59089 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbhBPTqN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 14:46:13 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 26DCD117784;
        Tue, 16 Feb 2021 14:45:32 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XIuSqTeXmG1el/swyrEBPdeTmo8=; b=PMuFou
        qKsPg49jtCHMQTOLEUQ6w7eDjHBy8A5prp46ogJoz/MliqDqe5txe72NUAD19EjQ
        htPRUGV8c2uxCTiC774LRoHtV1Ds41NAynZN9UBTnzpbmZp3br81gKJJJzBCYqyv
        8Oa+NzkotzdYLvNCQ5iydr3et9fzHkMK3ZbT0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cOkzxAK+XOy0mSOa0atiZWJ5sHvt2+qz
        EuK/Q/Rr4qvhOum1yLPcRylazQuwULBKNUJN12R+ljB2DoFvx60kFkRMTZ7DrFJA
        at57XUtLxhoajnPGOifq8K04WSl5etfBdLSIt6p4SPz4DXdmyolLuf0s7v1us5i/
        dQRb9wY5aS4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1F475117783;
        Tue, 16 Feb 2021 14:45:32 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6720D11777F;
        Tue, 16 Feb 2021 14:45:29 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Rafael Silva <rafaeloliveira.cs@gmail.com>, git@vger.kernel.org,
        Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH 0/1] blame: remove unnecessary use of get_commit_info()
References: <20210216163151.76307-1-rafaeloliveira.cs@gmail.com>
        <ce29b876-a5dd-76e9-bf79-5b917249b508@gmail.com>
Date:   Tue, 16 Feb 2021 11:45:27 -0800
In-Reply-To: <ce29b876-a5dd-76e9-bf79-5b917249b508@gmail.com> (Derrick
        Stolee's message of "Tue, 16 Feb 2021 13:35:16 -0500")
Message-ID: <xmqqim6rpzjc.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 85EB7AC2-708F-11EB-9859-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> ...
> This is a good way to demonstrate the change. Definitely worthwhile for
> demonstrating the value of the patch. I'll second Taylor's request that
> this performance data goes in the commit message so we can see the details
> in the future.

Thanks, all.  I do agree with you and Taylor that these numbers
deserve to be in the log message, not cover letter.
