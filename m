Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6F3C433E1
	for <git@archiver.kernel.org>; Wed, 27 May 2020 16:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5035D20873
	for <git@archiver.kernel.org>; Wed, 27 May 2020 16:47:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GGiQO8Sw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391663AbgE0QrH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 12:47:07 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50752 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391654AbgE0QrF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 12:47:05 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CF64D7585F;
        Wed, 27 May 2020 12:47:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=C9lLlkSdNrXGdh5hXfHODVnFNP4=; b=GGiQO8
        SwCgFSVbcgRgnlELY7xHJ8fXDTBb7GW8BJq+DqY8lhK6lPTQN1WsAlt2CSuaj7H2
        siJ2BZapsEc4kz9ToQGY3SSJz2cwj3y56BWN8BR9wZtcs7ksmK9nYTJ2N4WZpQA8
        1Zoi/Kk57sZj/6Md37PI+Km6ab46xGGqMvlf4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DEh7/W9b2etf/AQifYw/WVwhXMm6SDyN
        V00UIE/wiOPzR3iBCVPSuH/SzxKcPI1ItwcKVQw3lNmD1U7WShd0+enolNEF4TMO
        MOxLVylq6KIZJ/KXZNyzBqtTYsix6CbytebQ7q8AdkkM7EElQUqEBi7s9gWP7KhP
        IWa0GhdN7BY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C54A47585E;
        Wed, 27 May 2020 12:47:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 33B767585D;
        Wed, 27 May 2020 12:47:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     git@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.27.0-rc2
References: <xmqqtv02mt2m.fsf@gitster.c.googlers.com>
        <e66ea483-5e7f-4ebd-5ba8-91227efa454a@gmail.com>
Date:   Wed, 27 May 2020 09:47:01 -0700
In-Reply-To: <e66ea483-5e7f-4ebd-5ba8-91227efa454a@gmail.com> (Kaartic
        Sivaraam's message of "Wed, 27 May 2020 00:36:29 +0530")
Message-ID: <xmqqa71tmika.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B075B298-A039-11EA-B15E-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

> Hi Junio,
>
> On 27-05-2020 00:17, Junio C Hamano wrote:
>> Shourya Shukla (4):
>>        submodule--helper.c: Rename 'cb_foreach' to 'foreach_cb'
>>        gitfaq: files in .gitignore are tracked
>>        gitfaq: fetching and pulling a repository
>>        submodule: port subcommand 'set-url' from shell to C
>
> This is the only place where the `set-url` conversion from Shell to C
> is mentioned. I wonder if it's enough or if it needs a little bit more
> attention may be in the "Performance, Internal Implementation,
> Development Support etc." as it is a conversion of a submodule
> sub-command?

I'm not sure if it is worth the bits.  It may matter _only_ if/when
new implementaiton of set-url hurts the end-users by being buggy ;-)
