Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDC3C433EF
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 17:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EEC2604DB
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 17:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241068AbhKIRfB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Nov 2021 12:35:01 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58845 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238382AbhKIRfB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Nov 2021 12:35:01 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0B57B15026E;
        Tue,  9 Nov 2021 12:32:15 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=u4DRZIf2HPcovrenJ+9rRHvLFZ53r0yQt4Th/8
        LY5C4=; b=YwnFAYqG7kFeUcXD/2RsLzvEN9z5iVZ9a8svr3JJJ/OMXyMtgTc+z9
        6IWutJ4wlGsouB1GIVOE070ibOTqt3jMlLtXHxwn8prES4yJJzk5S7u/iWp+9LKT
        891ucoXeGvwLgdA9kGBwASKyvIIJx3fsl6sqzPGY4FJPS27CIKAIY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 03E3315026D;
        Tue,  9 Nov 2021 12:32:15 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DDB9E15026C;
        Tue,  9 Nov 2021 12:32:10 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Altmanninger <aclopte@gmail.com>
Cc:     =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        git@vger.kernel.org
Subject: Re: [PATCH v3 10/10] init doc: --shared=0xxx does not give umask
 but perm bits
References: <pull.1066.git.1635261072531.gitgitgadget@gmail.com>
        <20211106184858.11500-1-jn.avila@free.fr>
        <20211106184858.11500-11-jn.avila@free.fr>
        <20211107132259.jntrqxu5jn5v3vcw@gmail.com>
Date:   Tue, 09 Nov 2021 09:32:09 -0800
In-Reply-To: <20211107132259.jntrqxu5jn5v3vcw@gmail.com> (Johannes
        Altmanninger's message of "Sun, 7 Nov 2021 14:22:59 +0100")
Message-ID: <xmqqwnlh2q1y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F85087DC-4182-11EC-A9A2-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Altmanninger <aclopte@gmail.com> writes:

>> -inaccessible to others.
>> +inaccessible to others (directories and executable files get their
>> +`x` bit from the `r` bit for corresponding classes of uses).
>
> This confused me until I realized that "classes of uses" should be "classes of users".
>
> Other than that the whole series looks great.

You spotted two typos, if I count correctly?  I didn't see anything
questionable in the rest, so let me queue the patches with your
typofixes.

Thanks, both.

