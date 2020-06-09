Return-Path: <SRS0=lPKc=7W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C9DAC433E0
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 20:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 089FA206C3
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 20:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="K7UrQcqM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbgFIUpf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Jun 2020 16:45:35 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54596 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbgFIUpd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jun 2020 16:45:33 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 926A65CE87;
        Tue,  9 Jun 2020 16:45:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ul7yjSzXYT4yma8NYyTFzGmA2JU=; b=K7UrQc
        qMC+YDq95qWpAM71KXHki5nrLJVMa05ocXJu2UY5qE10BGBmRl/5vXUUCM7B9Xbk
        6g0cdbR/7FXXrDi5AngnTvanlrTw5ja1YiVRgTQEZl4WO3pSVtGmV8XFyEZIYDfc
        NKTmRYfnn5TrqGc4NGLFwFSvaT67E285oJsgo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hybTMIJuz4ycquPSZa8wu83NUGConET2
        Abzutl3dVrjrElg25ZR8olUqsyaMCW+ChbYFpRDPWR6p6fkobAfopJJjRsX6iuiE
        faKQV2alYKsYZ4qgcNPmdi8IfVL/XsPOGJfNlac3TbJyyq873bFI70ccZq1bpaY3
        4uwbMrcYsqg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8333A5CE86;
        Tue,  9 Jun 2020 16:45:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 00E3E5CE84;
        Tue,  9 Jun 2020 16:45:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     hanwen@google.com
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Fixup! Add t/helper/test-reftable.c
References: <xmqq4krll544.fsf@gitster.c.googlers.com>
        <20200609172244.257392-1-hanwen@google.com>
Date:   Tue, 09 Jun 2020 13:45:30 -0700
In-Reply-To: <20200609172244.257392-1-hanwen@google.com> (hanwen@google.com's
        message of "Tue, 9 Jun 2020 19:22:44 +0200")
Message-ID: <xmqqsgf4ge8l.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2888A206-AA92-11EA-AC6B-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

hanwen@google.com writes:

> Subject: Re: [PATCH] Fixup! Add t/helper/test-reftable.c

I do not see a step with "Add t/helper/test-reftable.c" as its
subject; is this supposed to be squashed into "Hookup unittests for
the reftable library." or somewhere else?

I also notice, with or without this squashed in, 775c540f (Hookup
unittests for the reftable library., 2020-06-05) does not compile
cleanly.  Since you are relatively new to this project (even though
you are very experienced and capable), I probably should let you
know that in this project each patch in a series is expected to
cleanly compile and pass the testsuite, not just the endstate.

Thanks.
