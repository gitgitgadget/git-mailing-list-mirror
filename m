Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 867E9C433E0
	for <git@archiver.kernel.org>; Sun, 27 Dec 2020 23:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 480A420866
	for <git@archiver.kernel.org>; Sun, 27 Dec 2020 23:01:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbgL0XAe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Dec 2020 18:00:34 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59332 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbgL0XAe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Dec 2020 18:00:34 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EB7F010B652;
        Sun, 27 Dec 2020 17:59:51 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WhZv0cnVcDG+zTQe9Bo5/xKyjZk=; b=LGU/Ca
        kCfwgwCjiUrGvv5/Nya2/cXu2oQK4ygiixs15gdgt0ZO0sBPfuZhw6UZrNwN8dUn
        cfZn+tnEepjoJAi9IeDWxfjj7lYA4HfKyQ7/0w2O3bhYbat1goeJt208wAPQKPDI
        bAHmNwHAkVMQQkNhsteXIZplx13YQbLwLgOGs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QxrBjzuBnVpX0ypoQOFTIqHKYrKeisWe
        Pac+xFzeYMOJs29KgZZWYuthGj8zNzKXPkxg7HfWgmyAg3UhjD0MB4ZmvflMmvDd
        svvwCxxIFromUjkxs7rHwxrdmV9+93Q55ZzORjwZucE2Wim20YS/dTQ+fPTNScpB
        XUv5G1+gWi4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E280A10B64F;
        Sun, 27 Dec 2020 17:59:51 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2D01010B64D;
        Sun, 27 Dec 2020 17:59:49 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Seth House <seth@eseth.com>
Cc:     git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v6 1/2] mergetool: add automerge configuration
References: <20201223045358.100754-1-felipe.contreras@gmail.com>
        <20201227205835.502556-1-seth@eseth.com>
        <20201227205835.502556-2-seth@eseth.com>
        <xmqq1rfarji5.fsf@gitster.c.googlers.com>
        <20201227222922.GA509599@ellen>
Date:   Sun, 27 Dec 2020 14:59:47 -0800
In-Reply-To: <20201227222922.GA509599@ellen> (Seth House's message of "Sun, 27
        Dec 2020 15:29:22 -0700")
Message-ID: <xmqqzh1yn9cs.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 389CF05E-4897-11EB-8D90-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Seth House <seth@eseth.com> writes:

> On Sun, Dec 27, 2020 at 02:06:58PM -0800, Junio C Hamano wrote:
>> Missing Sign-off as a relayer.
>
> I haven't come across that in the docs on contributing to Git and my
> Google searches aren't helping. Do you mind pointing me to what to add?

Documentation/SubmittingPatches#sign-off

    === Certify your work by adding your `Signed-off-by` trailer

    To improve tracking of who did what, we ask you to certify that you
    wrote the patch or have the right to pass it on under the same license
    as ours, by "signing off" your patch.  Without sign-off, we cannot
    accept your patches.

    If you can certify the below D-C-O:

    [[dco]]
    .Developer's Certificate of Origin 1.1
    ____
    By making a contribution to this project, I certify that:

    a. The contribution was created in whole or in part by me and I
       have the right to submit it under the open source license
       indicated in the file; or

    b. The contribution is based upon previous work that, to the best
       of my knowledge, is covered under an appropriate open source
       license and I have the right under that license to submit that
       work with modifications, whether created in whole or in part
       by me, under the same open source license (unless I am
       permitted to submit under a different license), as indicated
       in the file; or

    c. The contribution was provided directly to me by some other
       person who certified (a), (b) or (c) and I have not modified
       it.

    d. I understand and agree that this project and the contribution
       are public and that a record of the contribution (including all
       personal information I submit with it, including my sign-off) is
       maintained indefinitely and may be redistributed consistent with
       this project or the open source license(s) involved.
    ____

    you add a "Signed-off-by" trailer to your commit, that looks like
    this:

    ....
            Signed-off-by: Random J Developer <random@developer.example.org>
    ....


So, you'd add your own signed-off-by trailer at the end of the
trailer list.

https://lore.kernel.org/git/pull.805.git.1607091741254.gitgitgadget@gmail.com/

for an example where Johannes Schindelin picked up a patch written
by Dennis Ameling and relayed it to the list.

Thanks.
