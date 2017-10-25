Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0143D1FAED
	for <e@80x24.org>; Wed, 25 Oct 2017 01:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751883AbdJYB23 (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Oct 2017 21:28:29 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56955 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751861AbdJYB21 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Oct 2017 21:28:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E73F1AAD93;
        Tue, 24 Oct 2017 21:28:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=P28Ji5kfBa4Kqtcw+luS2enex8Q=; b=ZdYpCv
        /9gTQo+ZZdC4yntItJ1N8lnD/VEhrR4c9hq+oUtUGt+I6abYKMRfh4ScuEE7dEet
        Utz2qcr0jS7tFQN5VmUy7/qTkwHw+/QmHfM0w/gWlK938aVyvQ5hWAaIYJ8gfCMC
        21yMtNZt6KFvp8MocANrlrLOw2mUknecrQiac=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QOZgBvz778cvxBUsWxVrHfpwCwR3hWRM
        UGoN9yqOXXZcdu9oPtWEz8umhS/EgpIGADsTOQ3LJ+ApZf7l1goyF0Smq4nUY5pE
        Qkg1HONxSNYkHEvULNGZqxlPQEVwl3vy5puuuUfOoJKXg5g0gRFpIgMrnDzY3n1l
        lEDIPye10Wc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DE585AAD92;
        Tue, 24 Oct 2017 21:28:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4528FAAD8E;
        Tue, 24 Oct 2017 21:28:26 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] status: do not get confused by submodules in excluded directories
References: <244d71f47336e985ae265573b7d523cd8b3943bd.1508244305.git.johannes.schindelin@gmx.de>
        <xmqqo9oxkts6.fsf@gitster.mtv.corp.google.com>
        <20171024121536.GA88363@book.hvoigt.net>
Date:   Wed, 25 Oct 2017 10:28:25 +0900
In-Reply-To: <20171024121536.GA88363@book.hvoigt.net> (Heiko Voigt's message
        of "Tue, 24 Oct 2017 14:15:36 +0200")
Message-ID: <xmqqh8uoj9s6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CC7034B4-B923-11E7-A93F-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Heiko Voigt <hvoigt@hvoigt.net> writes:

> On Tue, Oct 24, 2017 at 02:18:49PM +0900, Junio C Hamano wrote:
>> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>> 
>> > We meticulously pass the `exclude` flag to the `treat_directory()`
>> > function so that we can indicate that files in it are excluded rather
>> > than untracked when recursing.
>> >
>> > But we did not yet treat submodules the same way.
>> 
>> ... "because of that, we ended up showing <<what incorrect result in
>> what situation>>" would be a nice thing to have here, so that it can
>> be copied to the release notes for the bugfix.  
>
> Yes I agree that would be nice here. It was not immediately obvious that
> this only applies when using both flags: -u and --ignored.

Does any of you care to fill in the <<blanks above>> then? ;-)

> Looks good to me.
>
> Cheers Heiko
