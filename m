Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A7FC4361B
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 05:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DC0623741
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 05:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgLQFUU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Dec 2020 00:20:20 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62330 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgLQFUU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Dec 2020 00:20:20 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8008981A78;
        Thu, 17 Dec 2020 00:19:36 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OuJ+A0F3Gvr/MLMdiuOWkoKqdlI=; b=gNUGY3
        +Ou2rPX7+XahZlzUmDo/IM70s5/61Az/hnBjxBbfFHwbPRxrLVBSSTlpCpcBRd5C
        vcBPSY291vzmIOKfGWNVZJ+HI2XlZxqBT4np/497AOyVkmiBmyyMx7EaKI5+muSj
        nxfwrN4laoTB5o+AFpXZgWAgHxYHnQEcEehR4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oW4mhJGv/8DG3A2j5LowgnU6On7BWRRC
        H1IY2rWCY0BHFhGdWypTgnr18Gqadla0rjYpTMkPpOhUwF6sVMCC2Oju7Kwm0gjJ
        TyQLxcef69bQrA1arjzwVKeQtbLpm7HkMxIXUbG4QqDJ8mh60Bg1OHxsGLqspgqe
        iuczkmjidUo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7646E81A77;
        Thu, 17 Dec 2020 00:19:36 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0837581A76;
        Thu, 17 Dec 2020 00:19:36 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Seth House <seth@eseth.com>
Subject: Re: [RFC/PATCH] mergetool: use resolved conflicts in all the views
References: <20201216174345.28146-1-felipe.contreras@gmail.com>
        <xmqqa6ud2xuw.fsf@gitster.c.googlers.com>
        <5fda9b3f4979c_973f2083@natae.notmuch>
Date:   Wed, 16 Dec 2020 21:19:35 -0800
In-Reply-To: <5fda9b3f4979c_973f2083@natae.notmuch> (Felipe Contreras's
        message of "Wed, 16 Dec 2020 17:41:51 -0600")
Message-ID: <xmqqmtydypp4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7416F706-4027-11EB-AB70-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> The implementation details of the proposed patch are not relevant at
> this point; it was just to show an example of what Seth's diffconflicts
> vim plugin does.

Sorry for commenting on the "irrelevant" part; as the patch was
marked with RFC label, I bothered to read it and tried to give
comments, but it wasn't clear which part was welcoming comments
and which parts were off limits ;-)

