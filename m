Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E44C433EF
	for <git@archiver.kernel.org>; Fri, 31 Dec 2021 08:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237073AbhLaIQp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Dec 2021 03:16:45 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53023 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbhLaIQp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Dec 2021 03:16:45 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 552E510FD82;
        Fri, 31 Dec 2021 03:16:44 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=k5ha0T7gsHZHIKVReNUno4v4h
        FwHMeco6RUKigE6jPI=; b=PZ1liqFSlglZdKrSNtQBEGx3lYErqtesFubW7jHNX
        Nx5C2GQ3uW+oU0GufvgCAavgpyZRZXVlwHIja2yPiwObm3ESqVM+iydX84QGJIER
        o/BDiFi9HYYJxzwX6ZV1Ruy6UObo6+D/5OX+2TMJLrtz2Eb2cSZMOKWk25ymEqnJ
        IU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 383C310FD80;
        Fri, 31 Dec 2021 03:16:44 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 90D8210FD7F;
        Fri, 31 Dec 2021 03:16:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     John Cai <johncai86@gmail.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] name-rev: deprecate --stdin in favor of --annotate-text
References: <pull.1171.git.git.1640492910432.gitgitgadget@gmail.com>
        <xmqqpmphx1yh.fsf@gitster.g>
        <028044FB-5CFC-49DF-BCFC-51AF1806619A@gmail.com>
Date:   Fri, 31 Dec 2021 00:16:42 -0800
Message-ID: <xmqq8rw1mbo5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FD2B7912-6A11-11EC-ACEA-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

John Cai <johncai86@gmail.com> writes:

>> Not a suggestion to change anything in this patch, but just an
>> observation.
>>=20
>> - If the mode is useful enough for many users, certainly somebody
>>   would have rewritten this loop to lift the line-length limit, but
>>   nobody noticed and complained about this 2k limit for the past 17
>>   years.  I am not sure if that is an indication that nobody uses
>>   the option in its current form.
>
> Would this also mean that deprecating --stdin wouldn=E2=80=99t be **too=
**
> disruptive to existing users and scripts?

That probably is a lot of wishful thinking.  Most likely, it is an
indication that most text input files that go into the command have
no overly long lines ;-)  Loss of or change in behaviour of the
command would be disruptive for the users who are content with the
limitation that they cannot feed lines wider than 2k.


