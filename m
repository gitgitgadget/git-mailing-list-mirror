Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E7DC433EF
	for <git@archiver.kernel.org>; Wed,  1 Jun 2022 21:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbiFAVMt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jun 2022 17:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbiFAVMr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jun 2022 17:12:47 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425445DA10
        for <git@vger.kernel.org>; Wed,  1 Jun 2022 14:12:45 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2FFF711DEB5;
        Wed,  1 Jun 2022 17:12:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gN7gQTOIBPQcpQvD64md8v6ghmJEUrBRMQp1LO
        BXrZc=; b=Oajezg3GYt6dljA1M69lzC+PDIu/aebpv+VlS7tKQoFoItWw+Eq9sJ
        EX1mdQEePj89Vx9uuWKeO50qV+o0zHnapbVfQEXPF1OQGriE8YTSwGA674GsjcIJ
        sPWFcuRPYhotaV/oEenvUOdUWnwlr+gRj7nNHd5hO1EBO6LqVdLeY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 26AB011DEB4;
        Wed,  1 Jun 2022 17:12:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6FA4311DEB3;
        Wed,  1 Jun 2022 17:12:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Mark Esler <mark.esler@canonical.com>
Cc:     git@vger.kernel.org
Subject: Re: CVE-2022-24975
References: <CAJ=HsVKX-NXePKU1G0UKRcFT5He8AjS_TQEirb3hN3chGFz9TA@mail.gmail.com>
Date:   Wed, 01 Jun 2022 14:12:43 -0700
In-Reply-To: <CAJ=HsVKX-NXePKU1G0UKRcFT5He8AjS_TQEirb3hN3chGFz9TA@mail.gmail.com>
        (Mark Esler's message of "Wed, 1 Jun 2022 15:55:09 -0500")
Message-ID: <xmqq4k14qe9g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9465DA34-E1EF-11EC-BAF2-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark Esler <mark.esler@canonical.com> writes:

> Hello,
>
> Could the git developers state their position on CVE-2022-24975? Is it
> disputed or will it be addressed by upstream?
>
> As I read the documentation, --mirror is working as stated and MITRE
> should remove the CVE.
>
> Thank you,
> Mark Esler

It took me a while to Google for "gitbleed" as I got tons of GI
bleed but no Gitbleed, so a quick conclusion is there is no such
credible thing called gitbleed ;-)

Jokes aside (yes, I know about [*]).

As you said, "A repository can have more than what branch heads and
tags can reach, and the --mirror option is a way to copy all the
things that are reachable from other refs.  It is 100% working as
intended."

During the discussion about [*] on git-security@ mailing lsit,
everybody said that it is dubious that CVE is warranted.  I am not
sure there is anything more for us to do.


[Reference]

* https://wwws.nightwatchcybersecurity.com/2022/02/11/gitbleed/

  the author of which asked git-security@ list and after getting
  things explained, accepted that this is a "working as intended"
  functionality and promised to adjust the blog post entry not to
  imply that the entire repository can be copied.  I do not know how
  much correction was actually made since then, though.
