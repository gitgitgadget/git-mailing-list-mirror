Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF4CC433ED
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 23:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8848E611CC
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 23:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237496AbhDNX0i (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Apr 2021 19:26:38 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52211 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235170AbhDNX0h (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Apr 2021 19:26:37 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B353DC009F;
        Wed, 14 Apr 2021 19:26:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Yidyx2BdZjuPM20av43m8ziI/Ds=; b=atXqa5
        1KnCzrG/PwPoAJzyzBcq7z9CgKTa+YzL3uqunSfwT1QbfqadurQsISvyfB9Jp2WQ
        coHNqeeugqYV1UK5mMwrT3ZmuDP05JQx+MGAu33K2fA8nIZlbRuWby3zdt7xivtu
        uUweXdzQnn5Iigdyxm9+APLwAK240oyXhoik0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OBGmrU0R7GVC0l5EF/Q+MYP5YDqdsxFU
        VxoOAMN5r3Dn1qiNtq5Uh9VvkkkzW4OTN0zpPmNTvvDXB65ZeIX8QUmBa/ikPwp7
        cmbqG7mrHmvfpqpDn1YphwYvsJTO8GTUy41iqL/YH0GyI6XCssTCvC5a5jc2jSs1
        FZWiwtIFJnM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A8250C009D;
        Wed, 14 Apr 2021 19:26:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A27EAC009C;
        Wed, 14 Apr 2021 19:26:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: What's cooking (draft for #4's issue this month)
References: <xmqqmtu1zn3o.fsf@gitster.g> <xmqqim4owixg.fsf@gitster.g>
Date:   Wed, 14 Apr 2021 16:26:12 -0700
In-Reply-To: <xmqqim4owixg.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        14 Apr 2021 16:22:19 -0700")
Message-ID: <xmqqeefcwiqz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CDA707F8-9D78-11EB-9F32-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>  * The tip of 'seen' passes all the tests locally, except that t5540
>    fails when compiled with CC=clang (http-push exits with signal
>    11).  bc/hash-transition-interop-part-1, which is at the tip of
>    'seen', seems to have this issue standalone.

BTW https://github.com/git/git/runs/2347905320?check_suite_focus=true#step:5:203
shows this.
